/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.site.modules.admin.service;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thrive.site.core.persistence.dao.sys.OfficeDao;
import org.thrive.site.core.persistence.entity.sys.Office;
import org.thrive.site.core.service.TreeService;
import org.thrive.site.core.util.sys.UserUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * 机构Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office> {

	public List<Office> findAll(){
		return UserUtil.getOfficeList();
	}

	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return UserUtil.getOfficeAllList();
		}else{
			return UserUtil.getOfficeList();
		}
	}
	
	@Transactional(readOnly = true)
	public List<Office> findList(Office office){
		if(office != null){
			office.setParentIds(office.getParentIds()+"%");
			return dao.findByParentIdsLike(office);
		}
		return  new ArrayList<Office>();
	}
	
	@Transactional(readOnly = false)
	public void save(Office office) {
		super.save(office);
		UserUtil.removeCache(UserUtil.CACHE_OFFICE_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtil.removeCache(UserUtil.CACHE_OFFICE_LIST);
	}
	
}
