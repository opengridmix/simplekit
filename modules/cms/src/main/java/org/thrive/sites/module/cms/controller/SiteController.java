/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.cms.controller;

import org.thrive.sites.core.config.Global;
import org.thrive.sites.core.persistence.Page;
import org.thrive.sites.core.util.CookieUtil;
import org.thrive.sites.core.util.StringUtil;
import org.thrive.sites.core.controller.BaseController;
import org.thrive.sites.core.util.sys.UserUtil;
import org.thrive.sites.module.cms.entity.Site;
import org.thrive.sites.module.cms.service.SiteService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 站点Controller
 * @author ThinkGem
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/site")
public class SiteController extends BaseController {

	@Autowired
	private SiteService siteService;
	
	@ModelAttribute
	public Site get(@RequestParam(required=false) String id) {
		if (StringUtil.isNotBlank(id)){
			return siteService.get(id);
		}else{
			return new Site();
		}
	}
	
	@RequiresPermissions("cms:site:view")
	@RequestMapping(value = {"list", ""})
	public String list(Site site, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Site> page = siteService.findPage(new Page<Site>(request, response), site); 
        model.addAttribute("page", page);
		return "module/cms/siteList";
	}

	@RequiresPermissions("cms:site:view")
	@RequestMapping(value = "form")
	public String form(Site site, Model model) {
		model.addAttribute("site", site);
		return "module/cms/siteForm";
	}

	@RequiresPermissions("cms:site:edit")
	@RequestMapping(value = "save")
	public String save(Site site, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/cms/site/?repage";
		}
		if (!beanValidator(model, site)){
			return form(site, model);
		}
		siteService.save(site);
		addMessage(redirectAttributes, "保存站点'" + site.getName() + "'成功");
		return "redirect:" + adminPath + "/cms/site/?repage";
	}
	
	@RequiresPermissions("cms:site:edit")
	@RequestMapping(value = "delete")
	public String delete(Site site, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/cms/site/?repage";
		}
		if (Site.isDefault(site.getId())){
			addMessage(redirectAttributes, "删除站点失败, 不允许删除默认站点");
		}else{
			siteService.delete(site, isRe);
			addMessage(redirectAttributes, (isRe!=null&&isRe?"恢复":"")+"删除站点成功");
		}
		return "redirect:" + adminPath + "/cms/site/?repage";
	}
	
	/**
	 * 选择站点
	 * @param id
	 * @return
	 */
	@RequiresPermissions("cms:site:select")
	@RequestMapping(value = "select")
	public String select(String id, boolean flag, HttpServletResponse response){
		if (id!=null){
			UserUtil.putCache("siteId", id);
			// 保存到Cookie中，下次登录后自动切换到该站点
			CookieUtil.setCookie(response, "siteId", id);
		}
		if (flag){
			return "redirect:" + adminPath;
		}
		return "module/cms/siteSelect";
	}
}
