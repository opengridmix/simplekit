<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>${fns:getConfig('productName')}</title>
    <meta name="decorator" content="blank"/><c:set var="tabmode" value="${empty cookie.tabmode.value ? '1' : cookie.tabmode.value}"/>
    <c:if test="${tabmode eq '1'}"><link rel="Stylesheet" href="${ctxStatic}/component/jquery/plugins/jerichotab/css/jquery.jerichotab.css" />
        <script type="text/javascript" src="${ctxStatic}/component/jquery/plugins/jerichotab/js/jquery.jerichotab.js"></script></c:if>
    <style type="text/css">
        #footer {margin:8px 0 0 0;padding:3px 0 0 0;font-size:11px;text-align:center;border-top:2px solid #0663A2;}
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            var tabTitleHeight = 33;
            $.fn.initJerichoTab({
                renderTo: '#right', uniqueId: 'jerichotab',
                contentCss: { 'height': $('#right').height() - tabTitleHeight },
                tabs: [], loadOnce: true, tabWidth: 110, titleHeight: tabTitleHeight
            });
            // 获取通知数目
            function getNotifyNum(){
                $.get("${ctx}/oa/oaNotify/self/count?updateSession=0&t="+new Date().getTime(),function(data){
                    var num = parseFloat(data);
                    if (num > 0){
                        $("#notifyNum,#notifyNum2").show().html("("+num+")");
                    }else{
                        $("#notifyNum,#notifyNum2").hide()
                    }
                });
            };
            // 加一个页签
            function addTab($this, refresh){
                $(".jericho_tab").show();
                $("#mainFrame").hide();
                $.fn.jerichoTab.addTab({
                    tabFirer: $this,
                    title: $this.children('span').text(),
                    closeable: true,
                    data: {
                        dataType: 'iframe',
                        dataLink: $this.attr('href')
                    }
                }).loadData(refresh);
                //$("#mainFrame").show();
                var pageHeight = $(window).innerHeight() - $('header').outerHeight();
                $(".jericho_tab iframe").height(pageHeight - tabTitleHeight);
                return false;
            };
            // 绑定菜单单击事件
            $("#navmenu a").click(function() {
                // 一级菜单焦点
                $("#navmenu li.menu").removeClass("active");
                $(this).parent().addClass("active");
                // 左侧区域隐藏
                if ($(this).attr("target") == "mainFrame"){
                    $("#mainFrame").show();
                    return true;
                }

                // 显示二级菜单
                $("#left .sidebar").hide();

                var menuId = "#sidemenu-" + $(this).attr("data-id");
                if ($(menuId).length > 0){

                    $(menuId).parent().show();
                    // 初始化点击第一个二级菜单
                    if (!$(menuId + " .menu-item:first").hasClass('in')){
                        $(menuId + " .menu-item:first a").click();
                    }
                    if (!$(menuId + " .menu-item li:first ul:first").is(":visible")){
                        $(menuId + " .menu-item a:first i").click();
                    }
                    // 初始化点击第一个三级菜单
                    $(menuId + " .menu-item:first span").click();
                }else{
                    // 获取二级菜单数据
                    $.get($(this).attr("data-href"), function(data){
                        if (data.indexOf("id=\"loginForm\"") != -1){
                            alert('未登录或登录超时。请重新登录，谢谢！');
                            top.location = "${ctx}";
                            return false;
                        }
                        $("#left").append(data);
                        // 展现三级
                        $(menuId + " .menu-item a").click(function(){
                            addTab($(this));
                        });
                        // 默认选中第一个菜单
                        $(menuId + " .menu-item:first span").click();
                        console.log("getdata:"+menuId);
                        Main.sidebarInit(menuId);
                    });
                }

            });
            // 初始化点击第一个一级菜单
            $("#navmenu a:first span").click();


            //getNotifyNum();
            //setInterval(getNotifyNum, ${oaNotifyRemindInterval});
        });

    </script>
</head>
<body>
<div id="app">
    <!-- start: TOP NAVBAR -->
    <header class="header">
        <!-- start: NAVBAR HEADER -->
        <nav class="navbar navbar-static-top" role="navigation">
            <div class="navbar-header">
                <!--toogle for mobile device-->
                <a href="#" class="sidebar-mobile-toggler pull-left hidden-md hidden-lg" class="btn btn-navbar sidebar-toggle" data-toggle-class="app-slide-off" data-toggle-target="#app" data-toggle-click-outside="#sidebar">
                    <i class="fa fa-align-justify"></i>
                </a>
                <a class="navbar-brand" href="#">
                    <span id="productName">${fns:getConfig('productName')}</span>
                </a>
                <!--toogle for pc device-->
                <a href="#" class="sidebar-toggler pull-right visible-md visible-lg" data-toggle-class="app-sidebar-closed" data-toggle-target="#app">
                    <i class="fa fa-align-justify"></i>
                </a>
                <a class="pull-right menu-toggler visible-xs-block" id="menu-toggler" data-toggle="collapse" href=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <i class="fa fa-cc"></i>
                </a>
            </div>

            <div class="nav-collapse">
                <ul id="navmenu" class="nav navbar-nav">
                    <c:set var="firstMenu" value="true"/>
                    <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
                        <c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
                            <li class="${not empty firstMenu && firstMenu ? ' active' : ''}">
                                <c:if test="${empty menu.href}">
                                    <a href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
                                </c:if>
                                <c:if test="${not empty menu.href}">
                                    <a href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
                                </c:if>
                            </li>
                            <c:if test="${firstMenu}">
                                <c:set var="firstMenuId" value="${menu.id}"/>
                            </c:if>
                            <c:set var="firstMenu" value="false"/>
                        </c:if>
                    </c:forEach>
                </ul>
            </div><!--/.nav-collapse -->
            <div class="navbar-right">
                <ul class="nav navbar-nav">
                    <li id="themeSwitch" class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="主题切换"><i class="fa fa-th-large"></i></a>
                        <ul class="dropdown-menu">
                            <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
                            <li><a href="javascript:cookie('tabmode','${tabmode eq '1' ? '0' : '1'}');location=location.href">${tabmode eq '1' ? '关闭' : '开启'}页签模式</a></li>
                        </ul>
                        <!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
                    </li>
                    <li id="userInfo" class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息">您好, ${fns:getUser().name}&nbsp;<span id="notifyNum" class="label label-info hide"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="fa fa-user"></i>&nbsp; 个人信息</a></li>
                            <li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="fa fa-lock"></i>&nbsp;  修改密码</a></li>
                            <li><a href="${ctx}/oa/oaNotify/self" target="mainFrame"><i class="fa fa-bell"></i>&nbsp;  我的通知 <span id="notifyNum2" class="label label-info hide"></span></a></li>
                        </ul>
                    </li>
                    <li><a href="${ctx}/logout" title="退出登录">退出</a></li>
                    <li>&nbsp;</li>
                </ul>
            </div>
        </nav>
        <!-- end: NAVBAR HEADER -->
    </header>
    <!-- end: TOP NAVBAR -->
    <div id="left">
    </div>
    <div class="app-content">
        <div class="main-content" >
            <div class="wrap-content container" id="container">
                <div id="right" style="min-height:460px">
                    <iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="650px"></iframe>
                </div>
            </div>
        </div>
    </div>
    <div id="footer">
        Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="http://jeesite.com" target="_blank">JeeSite</a> ${fns:getConfig('version')}
    </div>
</div>
</body>
</html>