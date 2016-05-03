/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.core.persistence.dao.sys;


import org.thrive.sites.core.persistence.annotation.MyBatisDao;
import org.thrive.sites.core.persistence.dao.CrudDao;
import org.thrive.sites.core.persistence.entity.sys.Dict;

import java.util.List;

/**
 * 字典DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);
	
}
