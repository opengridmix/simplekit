/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.core.persistence.dao.sys;


import org.thrive.sites.core.persistence.annotation.MyBatisDao;
import org.thrive.sites.core.persistence.dao.TreeDao;
import org.thrive.sites.core.persistence.entity.sys.Area;

/**
 * 区域DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
