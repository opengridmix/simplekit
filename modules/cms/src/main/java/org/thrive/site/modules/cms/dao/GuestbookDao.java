/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package org.thrive.site.modules.cms.dao;

import org.thrive.site.modules.cms.entity.Guestbook;
import org.thrive.site.core.persistence.annotation.MyBatisDao;
import org.thrive.site.core.persistence.dao.CrudDao;

/**
 * 留言DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@MyBatisDao
public interface GuestbookDao extends CrudDao<Guestbook> {

}
