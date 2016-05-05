<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<div class="items hide" data-noinit="true">
    <c:set var="menuList" value="${fns:getMenuChildren(param.parentId)}"/>
    <c:set var="firstMenu" value="true"/>
    <c:forEach items="${menuList}" var="menu">
        <c:if test="${menu.isShow eq '1'}">
            <ul class="menu-items" data-faicon="${menu.icon}"  data-tit="${menu.name}">
                <c:forEach items="${menu.children}" var="menu2">
                    <c:if test="${menu2.isShow eq '1'}">
                        <li class="menu-level2">
                            <a data-href=".menu2-${menu.id}"
                               href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}"
                               target="${not empty menu2.target ? menu2.target : 'mainFrame'}"
                               data-options="{id:'${menu2.id}', faicon:'${menu2.icon}'}">
                                <span class="title"> ${menu2.name} </span>
                            </a>
                            <c:if test="${fn:length(menu2.children) > 0 && empty menu2.href}">
                                <b><i class="fa fa-angle-down"></i></b>
                                <ul class="menu-items-children">
                                    <c:forEach items="${menu2.children}" var="menu3">
                                        <c:if test="${menue3.isShow eq '1'}">
                                            <li class="menu-level3">
                                                <a
                                                        data-href=".menu3-${menu2.id}"
                                                        href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}"
                                                        target="${not empty menu3.target ? menu3.target : 'mainFrame'}"
                                                        data-options="{id:'${menu3.id}', faicon:'${menu3.icon}'}">
                                                    <span class="title"> ${menu3.name} </span>
                                                </a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </c:if>
    </c:forEach>
</div>