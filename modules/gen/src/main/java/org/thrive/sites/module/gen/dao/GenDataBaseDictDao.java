/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.gen.dao;

import org.thrive.sites.core.persistence.annotation.MyBatisDao;
import org.thrive.sites.core.persistence.dao.CrudDao;
import org.thrive.sites.module.gen.entity.GenTable;
import org.thrive.sites.module.gen.entity.GenTableColumn;

import java.util.List;

/**
 * 业务表字段DAO接口
 * @author ThinkGem
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenDataBaseDictDao extends CrudDao<GenTableColumn> {

	/**
	 * 查询表列表
	 * @param genTable
	 * @return
	 */
	List<GenTable> findTableList(GenTable genTable);

	/**
	 * 获取数据表字段
	 * @param genTable
	 * @return
	 */
	List<GenTableColumn> findTableColumnList(GenTable genTable);
	
	/**
	 * 获取数据表主键
	 * @param genTable
	 * @return
	 */
	List<String> findTablePK(GenTable genTable);
	
}
