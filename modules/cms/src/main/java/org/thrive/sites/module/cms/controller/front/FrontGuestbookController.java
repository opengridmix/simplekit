/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.sites.module.cms.controller.front;

import org.thrive.sites.core.config.Global;
import org.thrive.sites.core.persistence.Page;
import org.thrive.sites.core.controller.BaseController;
import org.thrive.sites.module.cms.entity.Guestbook;
import org.thrive.sites.module.cms.entity.Site;
import org.thrive.sites.module.cms.service.GuestbookService;
import org.thrive.sites.module.cms.util.CmsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * 留言板Controller
 * @author ThinkGem
 * @version 2013-3-15
 */
@Controller
@RequestMapping(value = "${frontPath}/guestbook")
public class FrontGuestbookController extends BaseController{
	
	@Autowired
	private GuestbookService guestbookService;

	/**
	 * 留言板
	 */
	@RequestMapping(value = "", method= RequestMethod.GET)
	public String guestbook(@RequestParam(required=false, defaultValue="1") Integer pageNo,
							@RequestParam(required=false, defaultValue="30") Integer pageSize, Model model) {
		Site site = CmsUtil.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		
		Page<Guestbook> page = new Page<Guestbook>(pageNo, pageSize);
		Guestbook guestbook = new Guestbook();
		guestbook.setDelFlag(Guestbook.DEL_FLAG_NORMAL);
		page = guestbookService.findPage(page, guestbook);
		model.addAttribute("page", page);
		return "module/cms/front/themes/"+site.getTheme()+"/frontGuestbook";
	}
	
	/**
	 * 留言板-保存留言信息
	 */
	@RequestMapping(value = "", method= RequestMethod.POST)
	public String guestbookSave(Guestbook guestbook, String validateCode, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
//		if (StringUtil.isNotBlank(validateCode)){
//			if (ValidateCodeServlet.validate(request, validateCode)){
				guestbook.setIp(request.getRemoteAddr());
				guestbook.setCreateDate(new Date());
				guestbook.setDelFlag(Guestbook.DEL_FLAG_AUDIT);
				guestbookService.save(guestbook);
				addMessage(redirectAttributes, "提交成功，谢谢！");
//			}else{
//				addMessage(redirectAttributes, "验证码不正确。");
//			}
//		}else{
//			addMessage(redirectAttributes, "验证码不能为空。");
//		}
		return "redirect:"+Global.getFrontPath()+"/guestbook";
	}
	
}
