<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			validator("#inputForm");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/admin/user/info">个人信息</a></li>
		<li><a href="${ctx}/admin/user/modifyPwd">修改密码</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/admin/user/info" method="post" class="form-horizontal" role="form"><%--
		<form:hidden path="email" htmlEscape="false" maxlength="255" class=""/>
		<sys:ckfinder input="email" type="files" uploadPath="/mytask" selectMultiple="false"/> --%>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">头像:</label>
			<div class="col-md-4">
				<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class=""/>
				<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">归属公司:</label>
			<div class="col-md-4">
				<label class="lbl">${user.company.name}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">归属部门:</label>
			<div class="col-md-4">
				<label class="lbl">${user.office.name}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">姓名:</label>
			<div class="col-md-4">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required form-control" readonly="true"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">邮箱:</label>
			<div class="col-md-4">
				<form:input path="email" htmlEscape="false" maxlength="50" class="email form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">电话:</label>
			<div class="col-md-4">
				<form:input path="phone" htmlEscape="false" maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">手机:</label>
			<div class="col-md-4">
				<form:input path="mobile" htmlEscape="false" maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">备注:</label>
			<div class="col-md-4">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">用户类型:</label>
			<div class="col-md-4">
				<label class="lbl">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">用户角色:</label>
			<div class="col-md-4">
				<label class="lbl">${user.roleNames}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1 col-sm-1">上次登录:</label>
			<div class="col-md-4">
				<label class="lbl">IP: ${user.oldLoginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full"/></label>
			</div>
		</div>
		<div class="form-actions col-sm-10">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
		</div>
	</form:form>
</body>
</html>