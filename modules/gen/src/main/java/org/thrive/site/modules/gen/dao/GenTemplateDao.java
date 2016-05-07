/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.site.modules.gen.dao;

import org.thrive.site.modules.gen.entity.GenTemplate;
import org.thrive.site.core.persistence.annotation.MyBatisDao;
import org.thrive.site.core.persistence.dao.CrudDao;

/**
 * 代码模板DAO接口
 * @author ThinkGem
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenTemplateDao extends CrudDao<GenTemplate> {
	
}
