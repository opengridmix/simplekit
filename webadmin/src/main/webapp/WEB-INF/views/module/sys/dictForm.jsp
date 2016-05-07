<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			validator("#inputForm","#value");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/dict/">字典列表</a></li>
		<li class="active"><a href="${ctx}/sys/dict/form?id=${dict.id}">字典<shiro:hasPermission name="sys:dict:edit">${not empty dict.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:dict:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="control-label col-sm-1">键值:</label>
			<div class="col-md-4">
				<form:input path="value" htmlEscape="false" maxlength="50" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">标签:</label>
			<div class="col-md-4">
				<form:input path="label" htmlEscape="false" maxlength="50" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">类型:</label>
			<div class="col-md-4">
				<form:input path="type" htmlEscape="false" maxlength="50" class="required abc"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">描述:</label>
			<div class="col-md-4">
				<form:input path="description" htmlEscape="false" maxlength="50" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">排序:</label>
			<div class="col-md-4">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="required digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">备注:</label>
			<div class="col-md-4">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:dict:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>