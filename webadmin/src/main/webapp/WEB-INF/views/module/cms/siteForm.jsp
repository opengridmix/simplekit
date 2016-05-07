<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>站点管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			validator("#inputForm","#name");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/site/">站点列表</a></li>
		<li class="active"><a href="${ctx}/cms/site/form?id=${site.id}">站点<shiro:hasPermission name="cms:site:edit">${not empty site.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:site:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="site" action="${ctx}/cms/site/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="control-label col-sm-1">站点名称:</label>
			<div class="col-md-4">
				<form:input path="name" htmlEscape="false" maxlength="200" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">站点标题:</label>
			<div class="col-md-4">
				<form:input path="title" htmlEscape="false" maxlength="200" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">站点Logo:</label>
			<div class="col-md-4">
				<form:hidden path="logo" htmlEscape="false" maxlength="255" class="form-control"/>
				<sys:ckfinder input="logo" type="images" uploadPath="/cms/site"/>
				<span class="help-inline">建议Logo大小：1000 × 145（像素）</span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">描述:</label>
			<div class="col-md-4">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">关键字:</label>
			<div class="col-md-4">
				<form:input path="keywords" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">填写描述及关键字，有助于搜索引擎优化</span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">默认主题:</label>
			<div class="col-md-4">
				<form:select path="theme" class="">
					<form:options items="${fns:getDictList('cms_theme')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">版权信息:</label>
			<div class="col-md-4">
				<form:textarea id="copyright" htmlEscape="true" path="copyright" rows="4" maxlength="200" class="form-control"/>
				<sys:ckeditor replace="copyright" uploadPath="/cms/site" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">自定义首页视图:</label>
			<div class="col-md-4">
				<form:input path="customIndexView" htmlEscape="false" maxlength="200"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:site:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>