/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.admin.dao;


import org.thrive.sites.core.persistence.annotation.MyBatisDao;
import org.thrive.sites.core.persistence.dao.CrudDao;
import org.thrive.sites.module.admin.entity.Log;

/**
 * 日志DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface LogDao extends CrudDao<Log> {

}
