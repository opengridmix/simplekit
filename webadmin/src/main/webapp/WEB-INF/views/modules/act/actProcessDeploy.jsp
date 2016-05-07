<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>部署流程 - 流程管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			validator("#inputForm");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/act/process/">流程管理</a></li>
		<li class="active"><a href="${ctx}/act/process/deploy/">部署流程</a></li>
		<li><a href="${ctx}/act/process/running/">运行中的流程</a></li>
	</ul><br/>
	<sys:message content="${message}"/>
	<form id="inputForm" action="${ctx}/act/process/deploy" method="post" enctype="multipart/form-data" class="form-horizontal">
		<div class="form-group">
			<label class="control-label col-sm-1">流程分类：</label>
			<div class="col-md-4">
				<select id="category" name="category" class="required">
					<c:forEach items="${fns:getDictList('act_category')}" var="dict">
						<option value="${dict.value}">${dict.label}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">流程文件：</label>
			<div class="col-md-4">
				<input type="file" id="file" name="file" class="required form-control"/>
				<span class="help-inline">支持文件格式：zip、bar、bpmn、bpmn20.xml</span>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form>
</body>
</html>
