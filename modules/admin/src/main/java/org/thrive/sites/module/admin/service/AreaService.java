/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.admin.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thrive.sites.core.persistence.dao.sys.AreaDao;
import org.thrive.sites.core.persistence.entity.sys.Area;
import org.thrive.sites.core.service.TreeService;
import org.thrive.sites.core.util.sys.UserUtil;

import java.util.List;

/**
 * 区域Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class AreaService extends TreeService<AreaDao, Area> {

	public List<Area> findAll(){
		return UserUtil.getAreaList();
	}

	@Transactional(readOnly = false)
	public void save(Area area) {
		super.save(area);
		UserUtil.removeCache(UserUtil.CACHE_AREA_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Area area) {
		super.delete(area);
		UserUtil.removeCache(UserUtil.CACHE_AREA_LIST);
	}
	
}
