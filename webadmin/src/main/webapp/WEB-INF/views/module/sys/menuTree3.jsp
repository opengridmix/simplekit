<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<div class="sidebar app-aside" id="sidebar">
    <div class="sidebar-container perfect-scrollbar" id="sidemenu-${param.parentId}">
        <nav>
            <c:set var="menuList" value="${fns:getMenuChildren(param.parentId)}"/>
            <c:set var="firstMenu" value="true"/>
            <!-- start: MAIN NAVIGATION MENU -->
            <ul class="main-navigation-menu">
                <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
                    <li>
                        <a href="javascript:void(0)">
                            <div class="item-content">
                                <div class="item-media">
                                    <i class="ti-settings"></i>
                                </div>
                                <div class="item-inner">
                                    <span class="title"> ${menu.name} </span><i class="icon-arrow"></i>
                                </div>
                            </div>
                        </a>
                        <ul class="sub-menu">
                            <c:forEach items="${menu.children}" var="menu2">
                                <c:if test="${menu2.isShow eq '1'}">
                                    <c:choose>
                                        <c:when test="${fn:length(menu2.children) > 0 && empty menu2.href}">
                                            <li>
                                                <a href="javascript:;">
                                                    <span>${menu2.name}</span> <i class="icon-arrow"></i>
                                                </a>
                                                <ul class="sub-menu">
                                                    <c:forEach items="${menu2.children}" var="menu3">
                                                        <c:if test="${menue3.isShow eq '1'}">
                                                            <li class="menu-item">
                                                                <a href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}"
                                                                   target="${not empty menu3.target ? menu3.target : 'mainFrame'}">
                                                                    <span class="title"> ${menu3.name} </span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="menu-item">
                                                <a data-href=".menu3-${menu2.id}"
                                                   href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}"
                                                   target="${not empty menu2.target ? menu2.target : 'mainFrame'}">
                                                    <span class="title"> ${menu2.name} </span>
                                                </a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>

