/**
 * Copyright &copy; 2012-2013 <a href="httparamMap://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.admin.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thrive.sites.core.persistence.Page;
import org.thrive.sites.core.service.CrudService;
import org.thrive.sites.core.util.DateUtil;
import org.thrive.sites.module.admin.dao.LogDao;
import org.thrive.sites.module.admin.entity.Log;

/**
 * 日志Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class LogService extends CrudService<LogDao, Log> {

	public Page<Log> findPage(Page<Log> page, Log log) {
		
		// 设置默认时间范围，默认当前月
		if (log.getBeginDate() == null){
			log.setBeginDate(DateUtil.setDays(DateUtil.parseDate(DateUtil.getDate()), 1));
		}
		if (log.getEndDate() == null){
			log.setEndDate(DateUtil.addMonths(log.getBeginDate(), 1));
		}
		
		return super.findPage(page, log);
		
	}
	
}
