<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><!DOCTYPE >
<html>
<head>
    <meta charset="utf-8">
    <title>${fns:getConfig('productName')}</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
</head>
<body>
<div id="aside_container">
</div>
<div id="section_container">
    <section id="login_section" class="active">
        <header>
            <h1 class="title">${fns:getConfig('productName')}</h1>
            <!-- <nav class="right">
                <a data-target="section" data-icon="info" href="#about_section"></a>
            </nav> -->
        </header>
        <article data-scroll="true" id="login_article">
	        <div class="indented">
	            <form id="loginForm" action="${ctx}/login" method="post">
	            	<div>&nbsp;</div>
	            	<div class="input-group">
		                <div class="input-row">
		                    <label for="username">账号</label>
		                    <input type="text" name="username" id="username" placeholder="请填写登录账号">
		                </div>
		                <div class="input-row">
		                    <label for="password">密码</label>
		                    <input type="password" name="password" id="password" placeholder="请填写登录密码">
		                </div>
		            </div>
	            	<div class="input-group" id="validateCodeDiv" style="display:none;">
		                <div class="input-row">
		                    <label class="input-label mid" for="validateCode">验证码</label>
		                    <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"
		                    	imageCssStyle="padding-top:7px;"/>
		                </div>
		            </div>
	            	<div>&nbsp;</div>
	            	<input type="hidden" name="mobileLogin" value="true">
	                <button id="btn" class="submit block" data-icon="key">登录</button>
	            </form>
	        </div>
	    </article>
    </section>
</div>
</body>
</html>