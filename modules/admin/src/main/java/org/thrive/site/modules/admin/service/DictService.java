/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.site.modules.admin.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thrive.site.core.persistence.dao.sys.DictDao;
import org.thrive.site.core.persistence.entity.sys.Dict;
import org.thrive.site.core.service.CrudService;
import org.thrive.site.core.util.CacheUtil;
import org.thrive.site.core.util.sys.DictUtil;

import java.util.List;

/**
 * 字典Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictService extends CrudService<DictDao, Dict> {
	
	/**
	 * 查询字段类型列表
	 * @return
	 */
	public List<String> findTypeList(){
		return dao.findTypeList(new Dict());
	}

	@Transactional(readOnly = false)
	public void save(Dict dict) {
		super.save(dict);
		CacheUtil.remove(DictUtil.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtil.remove(DictUtil.CACHE_DICT_MAP);
	}

}
