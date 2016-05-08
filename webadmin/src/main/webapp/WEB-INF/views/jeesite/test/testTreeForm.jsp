<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>树结构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			validator("#inputForm","#name");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/test/testTree/">树结构列表</a></li>
		<li class="active"><a href="${ctx}/test/testTree/form?id=${testTree.id}&parent.id=${testTreeparent.id}">树结构<shiro:hasPermission name="test:testTree:edit">${not empty testTree.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="test:testTree:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="testTree" action="${ctx}/test/testTree/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="control-label col-sm-1">上级父级编号:</label>
			<div class="col-md-4">
				<sys:treeselect id="parent" name="parent.id" value="${testTree.parent.id}" labelName="parent.name" labelValue="${testTree.parent.name}"
					title="父级编号" url="/test/testTree/treeData" extId="${testTree.id}" cssClass="form-control" allowClear="true"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">名称：</label>
			<div class="col-md-4">
				<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">排序：</label>
			<div class="col-md-4">
				<form:input path="sort" htmlEscape="false" maxlength="10" class="form-control required digits"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">备注信息：</label>
			<div class="col-md-4">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="test:testTree:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>