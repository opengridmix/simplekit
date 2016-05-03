/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.gen.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thrive.sites.core.persistence.Page;
import org.thrive.sites.core.service.BaseService;
import org.thrive.sites.core.util.StringUtil;
import org.thrive.sites.module.gen.dao.GenSchemeDao;
import org.thrive.sites.module.gen.dao.GenTableColumnDao;
import org.thrive.sites.module.gen.dao.GenTableDao;
import org.thrive.sites.module.gen.entity.*;
import org.thrive.sites.module.gen.util.GenUtil;

import java.util.List;
import java.util.Map;

/**
 * 生成方案Service
 * @author ThinkGem
 * @version 2013-10-15
 */
@Service
@Transactional(readOnly = true)
public class GenSchemeService extends BaseService {

	@Autowired
	private GenSchemeDao genSchemeDao;
//	@Autowired
//	private GenTemplateDao genTemplateDao;
	@Autowired
	private GenTableDao genTableDao;
	@Autowired
	private GenTableColumnDao genTableColumnDao;
	
	public GenScheme get(String id) {
		return genSchemeDao.get(id);
	}
	
	public Page<GenScheme> find(Page<GenScheme> page, GenScheme genScheme) {
		GenUtil.getTemplatePath();
		genScheme.setPage(page);
		page.setList(genSchemeDao.findList(genScheme));
		return page;
	}
	
	@Transactional(readOnly = false)
	public String save(GenScheme genScheme) {
		if (StringUtil.isBlank(genScheme.getId())){
			genScheme.preInsert();
			genSchemeDao.insert(genScheme);
		}else{
			genScheme.preUpdate();
			genSchemeDao.update(genScheme);
		}
		// 生成代码
		if ("1".equals(genScheme.getFlag())){
			return generateCode(genScheme);
		}
		return "";
	}
	
	@Transactional(readOnly = false)
	public void delete(GenScheme genScheme) {
		genSchemeDao.delete(genScheme);
	}
	
	private String generateCode(GenScheme genScheme){

		StringBuilder result = new StringBuilder();
		
		// 查询主表及字段列
		GenTable genTable = genTableDao.get(genScheme.getGenTable().getId());
		genTable.setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(genTable.getId()))));
		
		// 获取所有代码模板
		GenConfig config = GenUtil.getConfig();
		
		// 获取模板列表
		List<GenTemplate> templateList = GenUtil.getTemplateList(config, genScheme.getCategory(), false);
		List<GenTemplate> childTableTemplateList = GenUtil.getTemplateList(config, genScheme.getCategory(), true);
		
		// 如果有子表模板，则需要获取子表列表
		if (childTableTemplateList.size() > 0){
			GenTable parentTable = new GenTable();
			parentTable.setParentTable(genTable.getName());
			genTable.setChildList(genTableDao.findList(parentTable));
		}
		
		// 生成子表模板代码
		for (GenTable childTable : genTable.getChildList()){
			childTable.setParent(genTable);
			childTable.setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(childTable.getId()))));
			genScheme.setGenTable(childTable);
			Map<String, Object> childTableModel = GenUtil.getDataModel(genScheme);
			for (GenTemplate tpl : childTableTemplateList){
				result.append(GenUtil.generateToFile(tpl, childTableModel, genScheme.getReplaceFile()));
			}
		}
		
		// 生成主表模板代码
		genScheme.setGenTable(genTable);
		Map<String, Object> model = GenUtil.getDataModel(genScheme);
		for (GenTemplate tpl : templateList){
			result.append(GenUtil.generateToFile(tpl, model, genScheme.getReplaceFile()));
		}
		return result.toString();
	}
}
