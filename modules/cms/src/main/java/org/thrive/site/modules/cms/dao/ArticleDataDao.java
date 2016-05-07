/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.site.modules.cms.dao;

import org.thrive.site.modules.cms.entity.ArticleData;
import org.thrive.site.core.persistence.annotation.MyBatisDao;
import org.thrive.site.core.persistence.dao.CrudDao;

/**
 * 文章DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@MyBatisDao
public interface ArticleDataDao extends CrudDao<ArticleData> {
	
}
