<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			validator("#inputForm");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oa/oaNotify/">通知列表</a></li>
		<li class="active"><a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">通知<shiro:hasPermission name="oa:oaNotify:edit">${oaNotify.status eq '1' ? '查看' : not empty oaNotify.id ? '修改' : '添加'}</shiro:hasPermission><shiro:lacksPermission name="oa:oaNotify:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="form-group">
			<label class="control-label col-sm-1">类型：</label>
			<div class="col-md-4">
				<form:select path="type" class="required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>	
		<div class="form-group">
			<label class="control-label col-sm-1">标题：</label>
			
			<div class="col-md-4">
				<div class="input-inline">
				<form:input path="title" htmlEscape="false" maxlength="200" class="form-control required"/>
				</div>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">内容：</label>
			<div class="col-md-4">
				<div class="input-inline">
				<form:textarea path="content" htmlEscape="false" rows="6" maxlength="2000" class="form-control required"/>
				</div>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<c:if test="${oaNotify.status ne '1'}">
			<div class="form-group">
				<label class="control-label col-sm-1">附件：</label>
				<div class="col-md-4">
					<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
					<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-1">状态：</label>
				<div class="col-md-4">
					<form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required radio-inline"/>
					<span class="help-inline"><font color="red">*</font> 发布后不能进行操作。</span>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-1">接受人：</label>
				<div class="col-md-4">
					<div class="input-inline">
	                <sys:treeselect id="oaNotifyRecord" name="oaNotifyRecordIds" value="${oaNotify.oaNotifyRecordIds}" labelName="oaNotifyRecordNames" labelValue="${oaNotify.oaNotifyRecordNames}"
						title="用户" url="/admin/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true" checked="true"/>
					</div>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</c:if>
		<c:if test="${oaNotify.status eq '1'}">
			<div class="form-group">
				<label class="control-label col-sm-1">附件：</label>
				<div class="col-md-4">
					<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
					<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true" readonly="true" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-1">接受人：</label>
				<div class="col-md-4">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>接受人</th>
								<th>接受部门</th>
								<th>阅读状态</th>
								<th>阅读时间</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
							<tr>
								<td>
									${oaNotifyRecord.user.name}
								</td>
								<td>
									${oaNotifyRecord.user.office.name}
								</td>
								<td>
									${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
								</td>
								<td>
									<fmt:formatDate value="${oaNotifyRecord.readDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum} &nbsp; 总共：${oaNotify.readNum + oaNotify.unReadNum}
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<c:if test="${oaNotify.status ne '1'}">
				<shiro:hasPermission name="oa:oaNotify:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>