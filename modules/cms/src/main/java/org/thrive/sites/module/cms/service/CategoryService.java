/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.cms.service;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import org.apache.commons.lang3.StringEscapeUtils;
import org.thrive.sites.core.config.Global;
import org.thrive.sites.core.persistence.Page;
import org.thrive.sites.core.persistence.entity.sys.Office;
import org.thrive.sites.core.persistence.entity.sys.User;
import org.thrive.sites.core.service.TreeService;
import org.thrive.sites.core.util.StringUtil;
import org.thrive.sites.core.util.sys.UserUtil;
import org.thrive.sites.module.cms.dao.CategoryDao;
import org.thrive.sites.module.cms.entity.Category;
import org.thrive.sites.module.cms.entity.Site;
import org.thrive.sites.module.cms.util.CmsUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

/**
 * 栏目Service
 * @author ThinkGem
 * @version 2013-5-31
 */
@Service
@Transactional(readOnly = true)
public class CategoryService extends TreeService<CategoryDao, Category> {

	public static final String CACHE_CATEGORY_LIST = "categoryList";
	
	private Category entity = new Category();
	
	@SuppressWarnings("unchecked")
	public List<Category> findByUser(boolean isCurrentSite, String module){
		
		List<Category> list = (List<Category>)UserUtil.getCache(CACHE_CATEGORY_LIST);
		if (list == null){
			User user = UserUtil.getUser();
			Category category = new Category();
			category.setOffice(new Office());
			category.getSqlMap().put("dsf", dataScopeFilter(user, "o", "u"));
			category.setSite(new Site());
			category.setParent(new Category());
			list = dao.findList(category);
			// 将没有父节点的节点，找到父节点
			Set<String> parentIdSet = Sets.newHashSet();
			for (Category e : list){
				if (e.getParent()!=null && StringUtil.isNotBlank(e.getParent().getId())){
					boolean isExistParent = false;
					for (Category e2 : list){
						if (e.getParent().getId().equals(e2.getId())){
							isExistParent = true;
							break;
						}
					}
					if (!isExistParent){
						parentIdSet.add(e.getParent().getId());
					}
				}
			}
			if (parentIdSet.size() > 0){
				//FIXME 暂且注释，用于测试
//				dc = dao.createDetachedCriteria();
//				dc.add(Restrictions.in("id", parentIdSet));
//				dc.add(Restrictions.eq("delFlag", Category.DEL_FLAG_NORMAL));
//				dc.addOrder(Order.asc("site.id")).addOrder(Order.asc("sort"));
//				list.addAll(0, dao.find(dc));
			}
			UserUtil.putCache(CACHE_CATEGORY_LIST, list);
		}
		
		if (isCurrentSite){
			List<Category> categoryList = Lists.newArrayList();
			for (Category e : list){
				if (Category.isRoot(e.getId()) || (e.getSite()!=null && e.getSite().getId() !=null 
						&& e.getSite().getId().equals(Site.getCurrentSiteId()))){
					if (StringUtil.isNotEmpty(module)){
						if (module.equals(e.getModule()) || "".equals(e.getModule())){
							categoryList.add(e);
						}
					}else{
						categoryList.add(e);
					}
				}
			}
			return categoryList;
		}
		return list;
	}

	public List<Category> findByParentId(String parentId, String siteId){
		Category parent = new Category();
		parent.setId(parentId);
		entity.setParent(parent);
		Site site = new Site();
		site.setId(siteId);
		entity.setSite(site);
		return dao.findByParentIdAndSiteId(entity);
	}
	
	public Page<Category> find(Page<Category> page, Category category) {
//		DetachedCriteria dc = dao.createDetachedCriteria();
//		if (category.getSite()!=null && StringUtil.isNotBlank(category.getSite().getId())){
//			dc.createAlias("site", "site");
//			dc.add(Restrictions.eq("site.id", category.getSite().getId()));
//		}
//		if (category.getParent()!=null && StringUtil.isNotBlank(category.getParent().getId())){
//			dc.createAlias("parent", "parent");
//			dc.add(Restrictions.eq("parent.id", category.getParent().getId()));
//		}
//		if (StringUtil.isNotBlank(category.getInMenu()) && Category.SHOW.equals(category.getInMenu())){
//			dc.add(Restrictions.eq("inMenu", category.getInMenu()));
//		}
//		dc.add(Restrictions.eq(Category.FIELD_DEL_FLAG, Category.DEL_FLAG_NORMAL));
//		dc.addOrder(Order.asc("site.id")).addOrder(Order.asc("sort"));
//		return dao.find(page, dc);
//		page.setSpringPage(dao.findByParentId(category.getParent().getId(), page.getSpringPage()));
//		return page;
		category.setPage(page);
		category.setInMenu(Global.SHOW);
		page.setList(dao.findModule(category));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(Category category) {
		category.setSite(new Site(Site.getCurrentSiteId()));
		if (StringUtil.isNotBlank(category.getViewConfig())){
            category.setViewConfig(StringEscapeUtils.unescapeHtml4(category.getViewConfig()));
        }
		super.save(category);
		UserUtil.removeCache(CACHE_CATEGORY_LIST);
		CmsUtil.removeCache("mainNavList_"+category.getSite().getId());
	}
	
	@Transactional(readOnly = false)
	public void delete(Category category) {
		super.delete(category);
		UserUtil.removeCache(CACHE_CATEGORY_LIST);
		CmsUtil.removeCache("mainNavList_"+category.getSite().getId());
	}
	
	/**
	 * 通过编号获取栏目列表
	 */
	public List<Category> findByIds(String ids) {
		List<Category> list = Lists.newArrayList();
		String[] idss = StringUtil.split(ids,",");
		if (idss.length>0){
//			List<Category> l = dao.findByIdIn(idss);
//			for (String id : idss){
//				for (Category e : l){
//					if (e.getId().equals(id)){
//						list.add(e);
//						break;
//					}
//				}
//			}
			for(String id : idss){
				Category e = dao.get(id);
				if(null != e){
					//System.out.println("e.id:"+e.getId()+",e.name:"+e.getName());
					list.add(e);
				}
				//list.add(dao.get(id));
				
			}
		}
		return list;
	}
	
}
