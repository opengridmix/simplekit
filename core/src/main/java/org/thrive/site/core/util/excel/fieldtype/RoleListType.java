/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.site.core.util.excel.fieldtype;

/**
 * 字段类型转换
 * @author ThinkGem
 * @version 2013-5-29
 */
public class RoleListType {

	//private static SystemService systemService = SpringContextHolder.getBean(SystemService.class);
	
//	/**
//	 * 获取对象值（导入）
//	 */
//	public static Object getValue(String val) {
//		List<Role> roleList = Lists.newArrayList();
//		List<Role> allRoleList = systemService.findAllRole();
//		for (String s : StringUtil.split(val, ",")){
//			for (Role e : allRoleList){
//				if (StringUtil.trimToEmpty(s).equals(e.getName())){
//					roleList.add(e);
//				}
//			}
//		}
//		return roleList.size()>0?roleList:null;
//	}
//
//	/**
//	 * 设置对象值（导出）
//	 */
//	public static String setValue(Object val) {
//		if (val != null){
//			@SuppressWarnings("unchecked")
//			List<Role> roleList = (List<Role>)val;
//			return Collections3.extractToString(roleList, "name", ", ");
//		}
//		return "";
//	}
	
}
