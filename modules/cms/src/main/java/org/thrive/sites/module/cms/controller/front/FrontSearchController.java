/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.cms.controller.front;


import org.thrive.sites.core.persistence.Page;
import org.thrive.sites.core.util.StringUtil;
import org.thrive.sites.core.controller.BaseController;
import org.thrive.sites.core.util.sys.UserUtil;
import org.thrive.sites.module.cms.entity.Article;
import org.thrive.sites.module.cms.entity.Guestbook;
import org.thrive.sites.module.cms.entity.Site;
import org.thrive.sites.module.cms.service.ArticleService;
import org.thrive.sites.module.cms.service.GuestbookService;
import org.thrive.sites.module.cms.util.CmsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 网站搜索Controller
 * @author ThinkGem
 * @version 2013-5-29
 */
@Controller
@RequestMapping(value = "${frontPath}/search")
public class FrontSearchController extends BaseController{
	
	@Autowired
	private ArticleService articleService;
	@Autowired
	private GuestbookService guestbookService;
	
	/**
	 * 全站搜索
	 */
	@RequestMapping(value = "")
	public String search(String t, @RequestParam(required=false) String q, @RequestParam(required=false) String qand, @RequestParam(required=false) String qnot,
						 @RequestParam(required=false) String a, @RequestParam(required=false) String cid, @RequestParam(required=false) String bd,
						 @RequestParam(required=false) String ed, HttpServletRequest request, HttpServletResponse response, Model model) {
		long start = System.currentTimeMillis();
		Site site = CmsUtil.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		
		// 重建索引（需要超级管理员权限）
		if ("cmd:reindex".equals(q)){
			if (UserUtil.getUser().isAdmin()){
				// 文章模型
				if (StringUtil.isBlank(t) || "article".equals(t)){
					articleService.createIndex();
				}
				// 留言模型
				else if ("guestbook".equals(t)){
					guestbookService.createIndex();
				}
				model.addAttribute("message", "重建索引成功，共耗时 " + (System.currentTimeMillis() - start) + "毫秒。");
			}else{
				model.addAttribute("message", "你没有执行权限。");
			}
		}
		// 执行检索
		else{
			String qStr = StringUtil.replace(StringUtil.replace(q, "，", " "), ", ", " ");
			// 如果是高级搜索
			if ("1".equals(a)){
				if (StringUtil.isNotBlank(qand)){
					qStr += " +" + StringUtil.replace(StringUtil.replace(StringUtil.replace(qand, "，", " "), ", ", " "), " ", " +");
				}
				if (StringUtil.isNotBlank(qnot)){
					qStr += " -" + StringUtil.replace(StringUtil.replace(StringUtil.replace(qnot, "，", " "), ", ", " "), " ", " -");
				}
			}
			// 文章检索
			if (StringUtil.isBlank(t) || "article".equals(t)){
				Page<Article> page = articleService.search(new Page<Article>(request, response), qStr, cid, bd, ed);
				page.setMessage("匹配结果，共耗时 " + (System.currentTimeMillis() - start) + "毫秒。");
				model.addAttribute("page", page);
			}
			// 留言检索
			else if ("guestbook".equals(t)){
				Page<Guestbook> page = guestbookService.search(new Page<Guestbook>(request, response), qStr, bd, ed);
				page.setMessage("匹配结果，共耗时 " + (System.currentTimeMillis() - start) + "毫秒。");
				model.addAttribute("page", page);
			}
			
		}
		model.addAttribute("t", t);// 搜索类型
		model.addAttribute("q", q);// 搜索关键字
		model.addAttribute("qand", qand);// 包含以下全部的关键词
		model.addAttribute("qnot", qnot);// 不包含以下关键词
		model.addAttribute("cid", cid);// 搜索类型
		return "module/cms/front/themes/"+site.getTheme()+"/frontSearch";
	}
	
}
