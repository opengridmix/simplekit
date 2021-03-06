/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.site.modules.admin.service;

import org.apache.shiro.session.Session;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thrive.site.modules.admin.util.LogUtil;
import org.thrive.site.core.config.Global;
import org.thrive.site.core.persistence.Page;
import org.thrive.site.core.persistence.dao.sys.MenuDao;
import org.thrive.site.core.persistence.dao.sys.RoleDao;
import org.thrive.site.core.persistence.dao.sys.UserDao;
import org.thrive.site.core.persistence.entity.sys.Menu;
import org.thrive.site.core.persistence.entity.sys.Office;
import org.thrive.site.core.persistence.entity.sys.Role;
import org.thrive.site.core.persistence.entity.sys.User;
import org.thrive.site.core.security.Digests;
import org.thrive.site.core.security.shiro.session.SessionDAO;
import org.thrive.site.core.service.BaseService;
import org.thrive.site.core.service.ServiceException;
import org.thrive.site.core.servlet.Servlets;
import org.thrive.site.core.util.CacheUtil;
import org.thrive.site.core.util.Encodes;
import org.thrive.site.core.util.StringUtil;
import org.thrive.site.core.util.sys.UserUtil;
import org.thrive.site.modules.admin.security.SystemAuthorizingRealm;

import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * @author ThinkGem
 * @version 2013-12-05
 */
@Service
@Transactional(readOnly = true)
public class SystemService extends BaseService implements InitializingBean {
	
	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private SessionDAO sessionDao;
	@Autowired
	private SystemAuthorizingRealm systemRealm;
	
	public SessionDAO getSessionDao() {
		return sessionDao;
	}

	//@Autowired
	//private IdentityService identityService;

	//-- User Service --//
	
	/**
	 * 获取用户
	 * @param id
	 * @return
	 */
	public User getUser(String id) {
		return UserUtil.get(id);
	}

	/**
	 * 根据登录名获取用户
	 * @param loginName
	 * @return
	 */
	public User getUserByLoginName(String loginName) {
		return UserUtil.getByLoginName(loginName);
	}
	
	public Page<User> findUser(Page<User> page, User user) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		user.getSqlMap().put("dsf", UserService.dataScopeFilter(user,"o", "a"));
		// 设置分页参数
		user.setPage(page);
		// 执行分页查询
		page.setList(userDao.findList(user));
		return page;
	}
	
	/**
	 * 无分页查询人员列表
	 * @param user
	 * @return
	 */
	public List<User> findUser(User user){
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		user.getSqlMap().put("dsf", UserService.dataScopeFilter(user, "o", "a"));
		List<User> list = userDao.findList(user);
		return list;
	}

	/**
	 * 通过部门ID获取用户列表，仅返回用户id和name（树查询用户时用）
	 * @param user
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> findUserByOfficeId(String officeId) {
		List<User> list = (List<User>)CacheUtil.get(UserUtil.USER_CACHE, UserUtil.USER_CACHE_LIST_BY_OFFICE_ID_ + officeId);
		if (list == null){
			User user = new User();
			user.setOffice(new Office(officeId));
			list = userDao.findUserByOfficeId(user);
			CacheUtil.put(UserUtil.USER_CACHE, UserUtil.USER_CACHE_LIST_BY_OFFICE_ID_ + officeId, list);
		}
		return list;
	}
	
	@Transactional(readOnly = false)
	public void saveUser(User user) {
		if (StringUtil.isBlank(user.getId())){
			user.preInsert();
			userDao.insert(user);
		}else{
			// 清除原用户机构用户缓存
			User oldUser = userDao.get(user.getId());
			if (oldUser.getOffice() != null && oldUser.getOffice().getId() != null){
				CacheUtil.remove(UserUtil.USER_CACHE, UserUtil.USER_CACHE_LIST_BY_OFFICE_ID_ + oldUser.getOffice().getId());
			}
			// 更新用户数据
			user.preUpdate();
			userDao.update(user);
		}
		if (StringUtil.isNotBlank(user.getId())){
			// 更新用户与角色关联
			userDao.deleteUserRole(user);
			if (user.getRoleList() != null && user.getRoleList().size() > 0){
				userDao.insertUserRole(user);
			}else{
				throw new ServiceException(user.getLoginName() + "没有设置角色！");
			}
			// 将当前用户同步到Activiti
			saveActivitiUser(user);
			// 清除用户缓存
			UserUtil.clearCache(user);
//			// 清除权限缓存
//			systemRealm.clearAllCachedAuthorizationInfo();
		}
	}
	
	@Transactional(readOnly = false)
	public void updateUserInfo(User user) {
		user.preUpdate();
		userDao.updateUserInfo(user);
		// 清除用户缓存
		UserUtil.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	@Transactional(readOnly = false)
	public void deleteUser(User user) {
		userDao.delete(user);
		// 同步到Activiti
		deleteActivitiUser(user);
		// 清除用户缓存
		UserUtil.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	@Transactional(readOnly = false)
	public void updatePasswordById(String id, String loginName, String newPassword) {
		User user = new User(id);
		user.setPassword(entryptPassword(newPassword));
		userDao.updatePasswordById(user);
		// 清除用户缓存
		user.setLoginName(loginName);
		UserUtil.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	@Transactional(readOnly = false)
	public void updateUserLoginInfo(User user) {
		// 保存上次登录信息
		user.setOldLoginIp(user.getLoginIp());
		user.setOldLoginDate(user.getLoginDate());
		// 更新本次登录信息
		user.setLoginIp(StringUtil.getRemoteAddr(Servlets.getRequest()));
		user.setLoginDate(new Date());
		userDao.updateLoginInfo(user);
	}
	
	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		String plain = Encodes.unescapeHtml(plainPassword);
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plain.getBytes(), salt, HASH_INTERATIONS);
		return Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword);
	}
	
	/**
	 * 验证密码
	 * @param plainPassword 明文密码
	 * @param password 密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		String plain = Encodes.unescapeHtml(plainPassword);
		byte[] salt = Encodes.decodeHex(password.substring(0,16));
		byte[] hashPassword = Digests.sha1(plain.getBytes(), salt, HASH_INTERATIONS);
		return password.equals(Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword));
	}
	
	/**
	 * 获得活动会话
	 * @return
	 */
	public Collection<Session> getActiveSessions(){
		return sessionDao.getActiveSessions(false);
	}
	
	//-- Role Service --//
	
	public Role getRole(String id) {
		return roleDao.get(id);
	}

	public Role getRoleByName(String name) {
		Role r = new Role();
		r.setName(name);
		return roleDao.getByName(r);
	}
	
	public Role getRoleByEnname(String enname) {
		Role r = new Role();
		r.setEnname(enname);
		return roleDao.getByEnname(r);
	}
	
	public List<Role> findRole(Role role){
		return roleDao.findList(role);
	}
	
	public List<Role> findAllRole(){
		return UserUtil.getRoleList();
	}
	
	@Transactional(readOnly = false)
	public void saveRole(Role role) {
		if (StringUtil.isBlank(role.getId())){
			role.preInsert();
			roleDao.insert(role);
			// 同步到Activiti
			saveActivitiGroup(role);
		}else{
			role.preUpdate();
			roleDao.update(role);
		}
		// 更新角色与菜单关联
		roleDao.deleteRoleMenu(role);
		if (role.getMenuList().size() > 0){
			roleDao.insertRoleMenu(role);
		}
		// 更新角色与部门关联
		roleDao.deleteRoleOffice(role);
		if (role.getOfficeList().size() > 0){
			roleDao.insertRoleOffice(role);
		}
		// 同步到Activiti
		saveActivitiGroup(role);
		// 清除用户角色缓存
		UserUtil.removeCache(UserUtil.CACHE_ROLE_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}

	@Transactional(readOnly = false)
	public void deleteRole(Role role) {
		roleDao.delete(role);
		// 同步到Activiti
		deleteActivitiGroup(role);
		// 清除用户角色缓存
		UserUtil.removeCache(UserUtil.CACHE_ROLE_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	@Transactional(readOnly = false)
	public Boolean outUserInRole(Role role, User user) {
		List<Role> roles = user.getRoleList();
		for (Role e : roles){
			if (e.getId().equals(role.getId())){
				roles.remove(e);
				saveUser(user);
				return true;
			}
		}
		return false;
	}
	
	@Transactional(readOnly = false)
	public User assignUserToRole(Role role, User user) {
		if (user == null){
			return null;
		}
		List<String> roleIds = user.getRoleIdList();
		if (roleIds.contains(role.getId())) {
			return null;
		}
		user.getRoleList().add(role);
		saveUser(user);
		return user;
	}

	//-- Menu Service --//
	
	public Menu getMenu(String id) {
		return menuDao.get(id);
	}

	public List<Menu> findAllMenu(){
		return UserUtil.getMenuList();
	}
	
	@Transactional(readOnly = false)
	public void saveMenu(Menu menu) {
		
		// 获取父节点实体
		menu.setParent(this.getMenu(menu.getParent().getId()));
		
		// 获取修改前的parentIds，用于更新子节点的parentIds
		String oldParentIds = menu.getParentIds(); 
		
		// 设置新的父节点串
		menu.setParentIds(menu.getParent().getParentIds()+menu.getParent().getId()+",");

		// 保存或更新实体
		if (StringUtil.isBlank(menu.getId())){
			menu.preInsert();
			menuDao.insert(menu);
		}else{
			menu.preUpdate();
			menuDao.update(menu);
		}
		
		// 更新子节点 parentIds
		Menu m = new Menu();
		m.setParentIds("%,"+menu.getId()+",%");
		List<Menu> list = menuDao.findByParentIdsLike(m);
		for (Menu e : list){
			e.setParentIds(e.getParentIds().replace(oldParentIds, menu.getParentIds()));
			menuDao.updateParentIds(e);
		}
		// 清除用户菜单缓存
		UserUtil.removeCache(UserUtil.CACHE_MENU_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
		// 清除日志相关缓存
		CacheUtil.remove(LogUtil.CACHE_MENU_NAME_PATH_MAP);
	}

	@Transactional(readOnly = false)
	public void updateMenuSort(Menu menu) {
		menuDao.updateSort(menu);
		// 清除用户菜单缓存
		UserUtil.removeCache(UserUtil.CACHE_MENU_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
		// 清除日志相关缓存
		CacheUtil.remove(LogUtil.CACHE_MENU_NAME_PATH_MAP);
	}

	@Transactional(readOnly = false)
	public void deleteMenu(Menu menu) {
		menuDao.delete(menu);
		// 清除用户菜单缓存
		UserUtil.removeCache(UserUtil.CACHE_MENU_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
		// 清除日志相关缓存
		CacheUtil.remove(LogUtil.CACHE_MENU_NAME_PATH_MAP);
	}
	
	/**
	 * 获取Key加载信息
	 */
	public static boolean printKeyLoadMessage(){
		StringBuilder sb = new StringBuilder();
		sb.append("\r\n======================================================================\r\n");
		sb.append("\r\n    欢迎使用 "+Global.getConfig("productName")+"  - Powered By http://jeesite.com\r\n");
		sb.append("\r\n======================================================================\r\n");
		System.out.println(sb.toString());
		return true;
	}
	
	///////////////// Synchronized to the Activiti //////////////////
	
	// 已废弃，同步见：ActGroupEntityServiceFactory.java、ActUserEntityServiceFactory.java

	/**
	 * 是需要同步Activiti数据，如果从未同步过，则同步数据。
	 */
	private static boolean isSynActivitiIndetity = true;
	public void afterPropertiesSet() throws Exception {
//		if (!Global.isSynActivitiIndetity()){
//			return;
//		}
//		if (isSynActivitiIndetity){
//			isSynActivitiIndetity = false;
//	        // 同步角色数据
//			List<Group> groupList = identityService.createGroupQuery().list();
//			if (groupList.size() == 0){
//			 	Iterator<Role> roles = roleDao.findAllList(new Role()).iterator();
//			 	while(roles.hasNext()) {
//			 		Role role = roles.next();
//			 		saveActivitiGroup(role);
//			 	}
//			}
//		 	// 同步用户数据
//			List<org.activiti.engine.identity.User> userList = identityService.createUserQuery().list();
//			if (userList.size() == 0){
//			 	Iterator<User> users = userDao.findAllList(new User()).iterator();
//			 	while(users.hasNext()) {
//			 		saveActivitiUser(users.next());
//			 	}
//			}
//		}
	}
	
	private void saveActivitiGroup(Role role) {
//		if (!Global.isSynActivitiIndetity()){
//			return;
//		}
//		String groupId = role.getEnname();
//
//		// 如果修改了英文名，则删除原Activiti角色
//		if (StringUtil.isNotBlank(role.getOldEnname()) && !role.getOldEnname().equals(role.getEnname())){
//			identityService.deleteGroup(role.getOldEnname());
//		}
//
//		Group group = identityService.createGroupQuery().groupId(groupId).singleResult();
//		if (group == null) {
//			group = identityService.newGroup(groupId);
//		}
//		group.setName(role.getName());
//		group.setType(role.getRoleType());
//		identityService.saveGroup(group);
//
//		// 删除用户与用户组关系
//		List<org.activiti.engine.identity.User> activitiUserList = identityService.createUserQuery().memberOfGroup(groupId).list();
//		for (org.activiti.engine.identity.User activitiUser : activitiUserList){
//			identityService.deleteMembership(activitiUser.getId(), groupId);
//		}
//
//		// 创建用户与用户组关系
//		List<User> userList = findUser(new User(new Role(role.getId())));
//		for (User e : userList){
//			String userId = e.getLoginName();//ObjectUtil.toString(user.getId());
//			// 如果该用户不存在，则创建一个
//			org.activiti.engine.identity.User activitiUser = identityService.createUserQuery().userId(userId).singleResult();
//			if (activitiUser == null){
//				activitiUser = identityService.newUser(userId);
//				activitiUser.setFirstName(e.getName());
//				activitiUser.setLastName(StringUtil.EMPTY);
//				activitiUser.setEmail(e.getEmail());
//				activitiUser.setPassword(StringUtil.EMPTY);
//				identityService.saveUser(activitiUser);
//			}
//			identityService.createMembership(userId, groupId);
//		}
	}

	public void deleteActivitiGroup(Role role) {
//		if (!Global.isSynActivitiIndetity()){
//			return;
//		}
//		if(role!=null) {
//			String groupId = role.getEnname();
//			identityService.deleteGroup(groupId);
//		}
	}

	private void saveActivitiUser(User user) {
//		if (!Global.isSynActivitiIndetity()){
//			return;
//		}
//		String userId = user.getLoginName();//ObjectUtil.toString(user.getId());
//		org.activiti.engine.identity.User activitiUser = identityService.createUserQuery().userId(userId).singleResult();
//		if (activitiUser == null) {
//			activitiUser = identityService.newUser(userId);
//		}
//		activitiUser.setFirstName(user.getName());
//		activitiUser.setLastName(StringUtil.EMPTY);
//		activitiUser.setEmail(user.getEmail());
//		activitiUser.setPassword(StringUtil.EMPTY);
//		identityService.saveUser(activitiUser);
//
//		// 删除用户与用户组关系
//		List<Group> activitiGroups = identityService.createGroupQuery().groupMember(userId).list();
//		for (Group group : activitiGroups) {
//			identityService.deleteMembership(userId, group.getId());
//		}
//		// 创建用户与用户组关系
//		for (Role role : user.getRoleList()) {
//	 		String groupId = role.getEnname();
//	 		// 如果该用户组不存在，则创建一个
//		 	Group group = identityService.createGroupQuery().groupId(groupId).singleResult();
//            if(group == null) {
//	            group = identityService.newGroup(groupId);
//	            group.setName(role.getName());
//	            group.setType(role.getRoleType());
//	            identityService.saveGroup(group);
//            }
//			identityService.createMembership(userId, role.getEnname());
//		}
	}

	private void deleteActivitiUser(User user) {
//		if (!Global.isSynActivitiIndetity()){
//			return;
//		}
//		if(user!=null) {
//			String userId = user.getLoginName();//ObjectUtil.toString(user.getId());
//			identityService.deleteUser(userId);
//		}
	}
	
	///////////////// Synchronized to the Activiti end //////////////////
	
}
