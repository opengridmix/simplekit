package org.thrive.site.core.persistence.dao;

import java.util.List;

/**
 * Created by Administrator on 2016/4/24 0024.
 */
public interface TreeDao<T> extends CrudDao<T> {
    /**
     * 找到所有子节点
     * @param entity
     * @return
     */
    public List<T> findByParentIdsLike(T entity);

    /**
     * 更新所有父节点字段
     * @param entity
     * @return
     */
    public int updateParentIds(T entity);
}
