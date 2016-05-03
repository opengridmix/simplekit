/*!
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * 通用公共方法
 * @author ThinkGem
 * @version 2014-4-29
 */
'use strict';

var Main = function() {
    var $html = $('html'), $win = $(window), wrap = $('.app-aside'), MEDIAQUERY = {}, app = $('#app');

    MEDIAQUERY = {
        desktopXL: 1200,
        desktop: 992,
        tablet: 768,
        mobile: 480
    };
    $(".current-year").text((new Date).getFullYear());

    // navbar collapse
    var navbarHandler = function() {
        var navbar = $('.navbar-collapse > .nav');
        var pageHeight = $win.innerHeight() - $('header').outerHeight();
        var collapseButton = $('#menu-toggler');
        if(isSmallDevice()) {
            navbar.css({
                height: pageHeight
            });
        } else {
            navbar.css({
                height: 'auto'
            });
        };
        $(document).on("mousedown touchstart", toggleNavbar);
        function toggleNavbar(e) {
            if(navbar.has(e.target).length === 0//checks if descendants of $box was clicked
                && !navbar.is(e.target)//checks if the $box itself was clicked
                && navbar.parent().hasClass("collapse in"))  {
                collapseButton.trigger("click");
                //$(document).off("mousedown touchstart", toggleNavbar);
            }
        };
    };
    //toggle class
    var toggleClassOnElement = function() {
        var toggleAttribute = $('*[data-toggle-class]');
        toggleAttribute.each(function() {
            var _this = $(this);
            var toggleClass = _this.attr('data-toggle-class');
            var outsideElement;
            var toggleElement;
            typeof _this.attr('data-toggle-target') !== 'undefined' ? toggleElement = $(_this.attr('data-toggle-target')) : toggleElement = _this;
            _this.on("click", function(e) {
                if(_this.attr('data-toggle-type') !== 'undefined' && _this.attr('data-toggle-type') == "on") {
                    toggleElement.addClass(toggleClass);
                } else if(_this.attr('data-toggle-type') !== 'undefined' && _this.attr('data-toggle-type') == "off") {
                    toggleElement.removeClass(toggleClass);
                } else {
                    toggleElement.toggleClass(toggleClass);
                }
                e.preventDefault();
                if(_this.attr('data-toggle-click-outside')) {

                    outsideElement = $(_this.attr('data-toggle-click-outside'));
                    $(document).on("mousedown touchstart", toggleOutside);

                };

            });

            var toggleOutside = function(e) {
                if(outsideElement.has(e.target).length === 0//checks if descendants of $box was clicked
                    && !outsideElement.is(e.target)//checks if the $box itself was clicked
                    && !toggleAttribute.is(e.target) && toggleElement.hasClass(toggleClass)) {

                    toggleElement.removeClass(toggleClass);
                    $(document).off("mousedown touchstart", toggleOutside);
                }
            };

        });
    };

    // settings
    var settingsHandler = function() {
        var clipSetting = new Object, appSetting = new Object;
        clipSetting = {
            fixedHeader: true,
            fixedSidebar: true,
            closedSidebar: false,
            fixedFooter: false,
            theme: 'theme-1'
        };
        if($.cookie) {
            if($.cookie("clip-setting")) {
                appSetting = jQuery.parseJSON($.cookie("clip-setting"));
            } else {
                appSetting = clipSetting;
            }
        };

        appSetting.fixedHeader ? app.addClass('app-navbar-fixed') : app.removeClass('app-navbar-fixed');
        appSetting.fixedSidebar ? app.addClass('app-sidebar-fixed') : app.removeClass('app-sidebar-fixed');
        appSetting.closedSidebar ? app.addClass('app-sidebar-closed') : app.removeClass('app-sidebar-closed');
        appSetting.fixedFooter ? app.addClass('app-footer-fixed') : app.removeClass('app-footer-fixed');
        app.hasClass("app-navbar-fixed") ? $('#fixed-header').prop('checked', true) : $('#fixed-header').prop('checked', false);
        app.hasClass("app-sidebar-fixed") ? $('#fixed-sidebar').prop('checked', true) : $('#fixed-sidebar').prop('checked', false);
        app.hasClass("app-sidebar-closed") ? $('#closed-sidebar').prop('checked', true) : $('#closed-sidebar').prop('checked', false);
        app.hasClass("app-footer-fixed") ? $('#fixed-footer').prop('checked', true) : $('#fixed-footer').prop('checked', false);
        $('#skin_color').attr("href", "assets/css/themes/" + appSetting.theme + ".css");
        $('input[name="setting-theme"]').each(function() {
            $(this).val() == appSetting.theme ? $(this).prop('checked', true) : $(this).prop('checked', false);
        });
        switchLogo(appSetting.theme);

        $('input[name="setting-theme"]').change(function() {
            var selectedTheme = $(this).val();
            $('#skin_color').attr("href", "assets/css/themes/" + selectedTheme + ".css");
            switchLogo(selectedTheme);
            appSetting.theme = selectedTheme;
            $.cookie("clip-setting", JSON.stringify(appSetting));

        });

        $('#fixed-header').change(function() {
            $(this).is(":checked") ? app.addClass("app-navbar-fixed") : app.removeClass("app-navbar-fixed");
            appSetting.fixedHeader = $(this).is(":checked");
            $.cookie("clip-setting", JSON.stringify(appSetting));
        });
        $('#fixed-sidebar').change(function() {
            $(this).is(":checked") ? app.addClass("app-sidebar-fixed") : app.removeClass("app-sidebar-fixed");
            appSetting.fixedSidebar = $(this).is(":checked");
            $.cookie("clip-setting", JSON.stringify(appSetting));
        });
        $('#closed-sidebar').change(function() {
            $(this).is(":checked") ? app.addClass("app-sidebar-closed") : app.removeClass("app-sidebar-closed");
            appSetting.closedSidebar = $(this).is(":checked");
            $.cookie("clip-setting", JSON.stringify(appSetting));
        });
        $('#fixed-footer').change(function() {
            $(this).is(":checked") ? app.addClass("app-footer-fixed") : app.removeClass("app-footer-fixed");
            appSetting.fixedFooter = $(this).is(":checked");
            $.cookie("clip-setting", JSON.stringify(appSetting));
        });
        function switchLogo(theme) {
            switch (theme) {
                case "theme-2":
                case "theme-3":
                case "theme-5":
                case "theme-6":
                    $(".navbar-brand img").attr("src", "assets/images/logo2.png");
                    break;

                default:
                    $(".navbar-brand img").attr("src", "assets/images/logo.png");
                    break;
            };
        };
        function defaultSetting() {
            $('#fixed-header').prop('checked', true);
            $('#fixed-sidebar').prop('checked', true);
            $('#closed-sidebar').prop('checked', false);
            $('#fixed-footer').prop('checked', false);
            $('#skin_color').attr("href", "assets/css/themes/theme-1.css");
            $(".navbar-brand img").attr("src", "assets/images/logo.png");

        };
    };

    //sidebar
    var sidebarHandler = function(menuId) {
        var eventObject = isTouch() ? 'click' : 'mouseenter', elem = $('#sidebar ' + menuId), wrap = $('.app-aside'), ul = "", menuTitle, _this;
        console.log("sidebar length:" + elem.length);
        elem.on('click', 'a', function(e) {

            _this = $(this);
            if(isSidebarClosed() && !isSmallDevice() && !_this.closest("ul").hasClass("sub-menu"))
                return;

            _this.closest("ul").find(".open").not(".active").children("ul").not(_this.next()).slideUp(200).parent('.open').removeClass("open");
            if(_this.next().is('ul') && _this.parent().toggleClass('open')) {

                _this.next().slideToggle(200, function() {
                    $win.trigger("resize");

                });
                e.stopPropagation();
                e.preventDefault();
            } else {
                //_this.parent().addClass("active");

            }
        });
        elem.on(eventObject, 'a', function(e) {
            if(!isSidebarClosed() || isSmallDevice())
                return;
            _this = $(this);

            if(!_this.parent().hasClass('hover') && !_this.closest("ul").hasClass("sub-menu")) {
                wrapLeave();
                _this.parent().addClass('hover');
                menuTitle = _this.find(".item-inner").clone();
                if(_this.parent().hasClass('active')) {
                    menuTitle.addClass("active");
                }
                var offset = $("#sidebar").position().top;
                var itemTop = isSidebarFixed() ? _this.parent().position().top + offset : (_this.parent().position().top);
                menuTitle.css({
                    position: isSidebarFixed() ? 'fixed' : 'absolute',
                    height: _this.outerHeight(),
                    top: itemTop
                }).appendTo(wrap);
                if(_this.next().is('ul')) {
                    ul = _this.next().clone(true);

                    ul.appendTo(wrap).css({
                        top: menuTitle.position().top + _this.outerHeight(),
                        position: isSidebarFixed() ? 'fixed' : 'absolute',
                    });
                    if(_this.parent().position().top + _this.outerHeight() + offset + ul.height() > $win.height() && isSidebarFixed()) {
                        ul.css('bottom', 0);
                    } else {
                        ul.css('bottom', 'auto');
                    }

                    wrap.children().first().scroll(function() {
                        if(isSidebarFixed())
                            wrapLeave();
                    });

                    setTimeout(function() {

                        if(!wrap.is(':empty')) {
                            $(document).on('click tap', wrapLeave);
                        }
                    }, 300);

                } else {
                    ul = "";
                    return;
                }

            }
        });
        wrap.on('mouseleave', function(e) {
            $(document).off('click tap', wrapLeave);
            $('.hover', wrap).removeClass('hover');
            $('> .item-inner', wrap).remove();
            $('> ul', wrap).remove();

        });
    };

    // Window Resize Function
    var resizeHandler = function(func, threshold, execAsap) {
        $(window).resize(function() {
            navbarHandler();
        });
    };

    function wrapLeave() {
        wrap.trigger('mouseleave');
    }


    function isSmallDevice() {
        return $win.width() < MEDIAQUERY.desktop;
    }

    function isSidebarClosed() {
        return $('.app-sidebar-closed').length;
    }

    function isSidebarFixed() {
        return $('.app-sidebar-fixed').length;
    }

    function isMobile() {
        if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
            return true;
        } else {
            return false;
        };
    }
    function isTouch() {
        return $html.hasClass('touch');
    }
    return {
        init: function() {
            toggleClassOnElement();
            navbarHandler();
            resizeHandler();
        },
        sidebarInit: function(menuId){
            sidebarHandler(menuId);
        }
    };
}();


$(document).ready(function() {
    try{
        // 链接去掉虚框
        $("a").bind("focus",function() {
            if(this.blur) {this.blur()};
        });
        //所有下拉框使用select2
        $("select").select2();
        Main.init();
    }catch(e){
        // blank
    }
});

// 引入js和css文件
function include(id, path, file){
    if (document.getElementById(id)==null){
        var files = typeof file == "string" ? [file] : file;
        for (var i = 0; i < files.length; i++){
            var name = files[i].replace(/^\s|\s$/g, "");
            var att = name.split('.');
            var ext = att[att.length - 1].toLowerCase();
            var isCSS = ext == "css";
            var tag = isCSS ? "link" : "script";
            var attr = isCSS ? " type='text/css' rel='stylesheet' " : " type='text/javascript' ";
            var link = (isCSS ? "href" : "src") + "='" + path + name + "'";
            document.write("<" + tag + (i==0?" id="+id:"") + attr + link + "></" + tag + ">");
        }
    }
}

// 获取URL地址参数
function getQueryString(name, url) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    if (!url || url == ""){
        url = window.location.search;
    }else{
        url = url.substring(url.indexOf("?"));
    }
    r = url.substr(1).match(reg)
    if (r != null) return unescape(r[2]); return null;
}

//获取字典标签
function getDictLabel(data, value, defaultValue){
    for (var i=0; i<data.length; i++){
        var row = data[i];
        if (row.value == value){
            return row.label;
        }
    }
    return defaultValue;
}

// 打开一个窗体
function windowOpen(url, name, width, height){
    var top=parseInt((window.screen.height-height)/2,10),left=parseInt((window.screen.width-width)/2,10),
        options="location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,"+
            "resizable=yes,scrollbars=yes,"+"width="+width+",height="+height+",top="+top+",left="+left;
    window.open(url ,name , options);
}

// 恢复提示框显示
function resetTip(){
    top.$.jBox.tip.mess = null;
}

// 关闭提示框
function closeTip(){
    top.$.jBox.closeTip();
}

//显示提示框
function showTip(mess, type, timeout, lazytime){
    resetTip();
    setTimeout(function(){
        top.$.jBox.tip(mess, (type == undefined || type == '' ? 'info' : type), {opacity:0,
            timeout:  timeout == undefined ? 2000 : timeout});
    }, lazytime == undefined ? 500 : lazytime);
}

// 显示加载框
function loading(mess){
    if (mess == undefined || mess == ""){
        mess = "正在提交，请稍等...";
    }
    resetTip();
    top.$.jBox.tip(mess,'loading',{opacity:0});
}

// 关闭提示框
function closeLoading(){
    // 恢复提示框显示
    resetTip();
    // 关闭提示框
    closeTip();
}

// 警告对话框
function alertx(mess, closed){
    top.$.jBox.info(mess, '提示', {closed:function(){
        if (typeof closed == 'function') {
            closed();
        }
    }});
    top.$('.jbox-body .jbox-icon').css('top','55px');
}

// 确认对话框
function confirmx(mess, href, closed){
    top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
        if(v=='ok'){
            if (typeof href == 'function') {
                href();
            }else{
                resetTip(); //loading();
                location = href;
            }
        }
    },{buttonsFocus:1, closed:function(){
        if (typeof closed == 'function') {
            closed();
        }
    }});
    top.$('.jbox-body .jbox-icon').css('top','55px');
    return false;
}

// 提示输入对话框
function promptx(title, lable, href, closed){
    top.$.jBox("<div class='form-search' style='padding:20px;text-align:center;'>" + lable + "：<input type='text' id='txt' name='txt'/></div>", {
        title: title, submit: function (v, h, f){
            if (f.txt == '') {
                top.$.jBox.tip("请输入" + lable + "。", 'error');
                return false;
            }
            if (typeof href == 'function') {
                href();
            }else{
                resetTip(); //loading();
                location = href + encodeURIComponent(f.txt);
            }
        },closed:function(){
            if (typeof closed == 'function') {
                closed();
            }
        }});
    return false;
}

// 添加TAB页面
function addTabPage(title, url, closeable, $this, refresh){
    top.$.fn.jerichoTab.addTab({
        tabFirer: $this,
        title: title,
        closeable: closeable == undefined,
        data: {
            dataType: 'iframe',
            dataLink: url
        }
    }).loadData(refresh != undefined);
}

// cookie操作
function cookie(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        var path = options.path ? '; path=' + options.path : '';
        var domain = options.domain ? '; domain=' + options.domain : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
}

// 数值前补零
function pad(num, n) {
    var len = num.toString().length;
    while(len < n) {
        num = "0" + num;
        len++;
    }
    return num;
}

// 转换为日期
function strToDate(date){
    return new Date(date.replace(/-/g,"/"));
}

// 日期加减
function addDate(date, dadd){
    date = date.valueOf();
    date = date + dadd * 24 * 60 * 60 * 1000;
    return new Date(date);
}

//截取字符串，区别汉字和英文
function abbr(name, maxLength){
    if(!maxLength){
        maxLength = 20;
    }
    if(name==null||name.length<1){
        return "";
    }
    var w = 0;//字符串长度，一个汉字长度为2
    var s = 0;//汉字个数
    var p = false;//判断字符串当前循环的前一个字符是否为汉字
    var b = false;//判断字符串当前循环的字符是否为汉字
    var nameSub;
    for (var i=0; i<name.length; i++) {
        if(i>1 && b==false){
            p = false;
        }
        if(i>1 && b==true){
            p = true;
        }
        var c = name.charCodeAt(i);
        //单字节加1
        if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {
            w++;
            b = false;
        }else {
            w+=2;
            s++;
            b = true;
        }
        if(w>maxLength && i<=name.length-1){
            if(b==true && p==true){
                nameSub = name.substring(0,i-2)+"...";
            }
            if(b==false && p==false){
                nameSub = name.substring(0,i-3)+"...";
            }
            if(b==true && p==false){
                nameSub = name.substring(0,i-2)+"...";
            }
            if(p==true){
                nameSub = name.substring(0,i-2)+"...";
            }
            break;
        }
    }
    if(w<=maxLength){
        return name;
    }
    return nameSub;
}


