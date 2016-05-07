<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>请假管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			validator("#inputForm","#name");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oa/leave/">待办任务</a></li>
		<li><a href="${ctx}/oa/leave/list">所有任务</a></li>
		<shiro:hasPermission name="oa:leave:edit"><li class="active"><a href="${ctx}/oa/leave/form">请假申请</a></li></shiro:hasPermission>
	</ul>
	<form:form id="inputForm" modelAttribute="leave" action="${ctx}/oa/leave/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="control-label col-sm-1">请假类型：</label>
			<div class="col-md-4">
				<form:select path="leaveType" >
					<form:options items="${fns:getDictList('oa_leave_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">开始时间：</label>
			<div class="col-md-4">
				<input id="startTime" name="startTime" type="text" readonly="readonly" maxlength="20" class="Wdate required form-control"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">结束时间：</label>
			<div class="col-md-4">
				<input id="endTime" name="endTime" type="text" readonly="readonly" maxlength="20" class="Wdate required form-control"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">请假原因：</label>
			<div class="col-md-4">
				<form:textarea path="reason" class="required" rows="5" maxlength="20"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="oa:leave:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
