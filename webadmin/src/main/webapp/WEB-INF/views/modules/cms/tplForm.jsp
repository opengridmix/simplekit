<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>模板管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			validator("#inputForm","#value");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>模板管理</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="template" action="${ctx}/cms/template/save" method="post" class="form-horizontal">
        <form:hidden path="name" />
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="control-label col-sm-1">文件名:</label>
			<div class="col-md-4">
				<form:input path="filename" htmlEscape="false" maxlength="50" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
            <form:textarea id="source" path="source" htmlEscape="true" cssStyle="width:100%;height:460px;"/>
            <%--<sys:ckeditor replace="source" uploadPath="/cms/template" />--%>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:template:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>