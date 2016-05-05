/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.cms.service;

import org.thrive.sites.core.persistence.entity.sys.Office;
import org.thrive.sites.core.service.BaseService;
import org.thrive.sites.core.util.DateUtil;
import org.thrive.sites.module.cms.dao.ArticleDao;
import org.thrive.sites.module.cms.entity.Category;
import org.thrive.sites.module.cms.entity.Site;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 统计Service
 * @author ThinkGem
 * @version 2013-05-21
 */
@Service
@Transactional(readOnly = true)
public class StatsService extends BaseService {

	@Autowired
	private ArticleDao articleDao;
	
	public List<Category> article(Map<String, Object> paramMap) {
		Category category = new Category();
		
		Site site = new Site();
		site.setId(Site.getCurrentSiteId());
		category.setSite(site);
		
		Date beginDate = DateUtil.parseDate(paramMap.get("beginDate"));
		if (beginDate == null){
			beginDate = DateUtil.setDays(new Date(), 1);
			paramMap.put("beginDate", DateUtil.formatDate(beginDate, "yyyy-MM-dd"));
		}
		category.setBeginDate(beginDate);
		Date endDate = DateUtil.parseDate(paramMap.get("endDate"));
		if (endDate == null){
			endDate = DateUtil.addDays(DateUtil.addMonths(beginDate, 1), -1);
			paramMap.put("endDate", DateUtil.formatDate(endDate, "yyyy-MM-dd"));
		}
		category.setEndDate(endDate);
		
		String categoryId = (String)paramMap.get("categoryId");
		if (categoryId != null && !("".equals(categoryId))){
			category.setId(categoryId);
			category.setParentIds(categoryId);
		}
		
		String officeId = (String)(paramMap.get("officeId"));
		Office office = new Office();
		if (officeId != null && !("".equals(officeId))){
			office.setId(officeId);
			category.setOffice(office);
		}else{
			category.setOffice(office);
		}
		
		List<Category> list = articleDao.findStats(category);
		return list;
	}

}
