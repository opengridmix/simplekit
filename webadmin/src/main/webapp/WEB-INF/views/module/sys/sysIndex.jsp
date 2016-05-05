<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>${fns:getConfig('productName')}</title>
    <meta name="decorator" content="blank"/>
    <c:set var="tabmode" value="${empty cookie.tabmode.value ? '1' : cookie.tabmode.value}"/>
    <!-- init -->
    <script type="text/javascript">
        $(function() {
            BJUI.init({
                JSPATH       : '${ctxStatic}/component/BJUI/',
                PLUGINPATH   : '${ctxStatic}/component/BJUI/plugins/',
                loginInfo    : {url:'login_timeout.html', title:'登录', width:400, height:200}, // 会话超时后弹出登录对话框
                statusCode   : {ok:200, error:300, timeout:301}, //[可选]
                ajaxTimeout  : 50000, //[可选]全局Ajax请求超时时间(毫秒)
                alertTimeout : 1000,  //[可选]信息提示[info/correct]自动关闭延时(毫秒)
                pageInfo     : {pageCurrent:'pageCurrent', pageSize:'pageSize', orderField:'orderField', orderDirection:'orderDirection'}, //[可选]分页参数
                keys         : {statusCode:'statusCode', message:'message'}, //[可选]
                ui           : {showSlidebar:true, clientPaging:true}, //[可选]clientPaging:在客户端响应分页及排序参数
                debug        : true,    // [可选]调试模式 [true|false，默认false]
                theme        : 'blue' // 若有Cookie['bjui_theme'],优先选择Cookie['bjui_theme']。皮肤[五种皮肤:default, orange, purple, blue, red, green]
            });
        });

        // main - menu
        $('#bjui-accordionmenu')
                .collapse()
                .on('hidden.bs.collapse', function(e) {
                    $(this).find('> .panel > .panel-heading').each(function() {
                        var $heading = $(this), $a = $heading.find('> h4 > a')

                        if ($a.hasClass('collapsed')) $heading.removeClass('active')
                    })
                })
                .on('shown.bs.collapse', function (e) {
                    $(this).find('> .panel > .panel-heading').each(function() {
                        var $heading = $(this), $a = $heading.find('> h4 > a')

                        if (!$a.hasClass('collapsed')) $heading.addClass('active')
                    })
                })

        $(document).on('click', 'ul.menu-items li > a', function(e) {
            var $a = $(this), $li = $a.parent(), options = $a.data('options').toObj(), $children = $li.find('> .menu-items-children')
            var onClose = function() {
                $li.removeClass('active')
            }
            var onSwitch = function() {
                $('#bjui-accordionmenu').find('ul.menu-items li').removeClass('switch')
                $li.addClass('switch')
            }

            $li.addClass('active')
            if (options) {
                options.url      = $a.attr('href')
                options.onClose  = onClose
                options.onSwitch = onSwitch
                options.isIFrame = true;
                if (!options.title) options.title = $a.text()

                if (!options.target)
                    $a.navtab(options)
                else
                    $a.dialog(options)
            }
            if ($children.length) {
                $li.toggleClass('open')
            }

            e.preventDefault()
        });

        $(document).on('click', '#bjui-hnav-navbar li.menu-title > a', function(e) {
            //var menuId = "#sidemenu-" + $(this).attr("data-id");
            var menuId = "#navmenu-"+$(this).data("id");
            var that = $(this);
            if($(menuId + " div").length == 0) {
                // 获取二级菜单数据
                $.get($(this).attr("data-href"), function(data){
                    if (data.indexOf("id=\"loginForm\"") != -1){
                        alert('未登录或登录超时。请重新登录，谢谢！');
                        top.location = "${ctx}";
                        return false;
                    }
                    $(menuId).append(data);
                    $.fn.slidebar.call(that, 'initHnav');
                    $(menuId + " div").remove();
                });
            }
        });

        $(document).ready(function() {
            $("#bjui-hnav-navbar li:first a").click();
            //时钟
            var today = new Date(), time = today.getTime()
            $('#bjui-date').html(today.formatDate('yyyy/MM/dd'))
            setInterval(function() {
                today = new Date(today.setSeconds(today.getSeconds() + 1))
                $('#bjui-clock').html(today.formatDate('HH:mm:ss'))
            }, 1000);
        });



        ;


        //console.log('IE:'+ (!$.support.leadingWhitespace))
        //菜单-事件
        function MainMenuClick(event, treeId, treeNode) {
            if (treeNode.isParent) {
                var zTree = $.fn.zTree.getZTreeObj(treeId)

                zTree.expandNode(treeNode)
                return
            }

            if (treeNode.target && treeNode.target == 'dialog')
                $(event.target).dialog({id:treeNode.tabid, url:treeNode.url, title:treeNode.name})
            else
                $(event.target).navtab({id:treeNode.tabid, url:treeNode.url, title:treeNode.name, fresh:treeNode.fresh, external:treeNode.external})
            event.preventDefault()
        }
    </script>
</head>

<body>
<div id="bjui-window">
    <!-- start: TOP NAVBAR -->
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <!-- end: TOP NAVBAR -->
    <div id="bjui-container" class="clearfix">
        <div id="bjui-leftside">
            <div id="bjui-sidebar-s">
                <div class="collapse"></div>
            </div>
            <div id="bjui-sidebar">
                <div class="toggleCollapse"><h2><i class="fa fa-bars"></i> 导航栏 <i class="fa fa-bars"></i></h2><a href="javascript:;" class="lock"><i class="fa fa-lock"></i></a></div>
                <div class="panel-group panel-main" data-toggle="accordion" id="bjui-accordionmenu">
                </div>
            </div>
        </div>


        <div id="bjui-navtab" class="tabsPage">
            <div class="tabsPageHeader">
                <div class="tabsPageHeaderContent">
                    <ul class="navtab-tab nav nav-tabs">
                        <li data-url="${ctx}/sys/user/info" data-faicon="home"><a href="javascript:;"><span><i class="fa fa-home"></i> #maintab#</span></a></li>
                    </ul>
                </div>
                <div class="tabsLeft"><i class="fa fa-angle-double-left"></i></div>
                <div class="tabsRight"><i class="fa fa-angle-double-right"></i></div>
                <div class="tabsMore"><i class="fa fa-angle-double-down"></i></div>
            </div>
            <ul class="tabsMoreList">
                <li><a href="javascript:;">#maintab#</a></li>
            </ul>
            <div class="navtab-panel tabsPageContent">
                <div class="navtabPage unitBox">
                    <div class="bjui-pageContent" style="background:#FFF;">
                        Loading...
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>