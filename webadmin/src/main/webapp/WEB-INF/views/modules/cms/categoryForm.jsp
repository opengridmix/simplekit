<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>栏目管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			validator("#inputForm","#name");
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/category/">栏目列表</a></li>
		<li class="active"><a href="${ctx}/cms/category/form?id=${category.id}&parent.id=${category.parent.id}">栏目<shiro:hasPermission name="cms:category:edit">${not empty category.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:category:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="category" action="${ctx}/cms/category/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="control-label col-sm-1">归属机构:</label>
			<div class="col-md-4">
                <sys:treeselect id="office" name="office.id" value="${category.office.id}" labelName="office.name" labelValue="${category.office.name}"
					title="机构" url="/sys/office/treeData" cssClass="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">上级栏目:</label>
			<div class="col-md-4">
                <sys:treeselect id="category" name="parent.id" value="${category.parent.id}" labelName="parent.name" labelValue="${category.parent.name}"
					title="栏目" url="/cms/category/treeData" extId="${category.id}" cssClass="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">栏目模型:</label>
			<div class="col-md-4">
				<form:select path="module">
					<form:option value="" label="公共模型"/>
					<form:options items="${fns:getDictList('cms_module')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">栏目名称:</label>
			<div class="col-md-4">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">缩略图:</label>
			<div class="col-md-4">
				<form:hidden path="image" htmlEscape="false" maxlength="255" class="form-control"/>
				<sys:ckfinder input="image" type="thumb" uploadPath="/cms/category"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">链接:</label>
			<div class="col-md-4">
				<form:input path="href" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">栏目超链接地址，优先级“高”</span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">目标:</label>
			<div class="col-md-4">
				<form:input path="target" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">栏目超链接打开的目标窗口，新窗口打开，请填写：“_blank”</span>
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
			<label class="control-label col-sm-1">排序:</label>
			<div class="col-md-4">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="form-control required digits"/>
				<span class="help-inline">栏目的排列次序</span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">在导航中显示:</label>
			<div class="col-md-4">
				<form:radiobuttons path="inMenu" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control required"/>
				<span class="help-inline">是否在导航中显示该栏目</span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">在分类页中显示列表:</label>
			<div class="col-md-4">
				<form:radiobuttons path="inList" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control required"/>
				<span class="help-inline">是否在分类页中显示该栏目的文章列表</span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1" title="默认展现方式：有子栏目显示栏目列表，无子栏目显示内容列表。">展现方式:</label>
			<div class="col-md-4">
				<form:radiobuttons path="showModes" items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required form-control"/><%--
				<form:select path="showModes" class="">
					<form:option value="" label="默认"/>
					<form:options items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select><span class="help-inline"></span> --%>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">是否允许评论:</label>
			<div class="col-md-4">
				<form:radiobuttons path="allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">是否需要审核:</label>
			<div class="col-md-4">
				<form:radiobuttons path="isAudit" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">自定义列表视图:</label>
			<div class="col-md-4">
                <form:select path="customListView">
                    <form:option value="" label="默认视图"/>
                    <form:options items="${listViewList}" htmlEscape="false"/>
                </form:select>
                <span class="help-inline">自定义列表视图名称必须以"${category_DEFAULT_TEMPLATE}"开始</span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">自定义内容视图:</label>
			<div class="col-md-4">
                <form:select path="customContentView">
                    <form:option value="" label="默认视图"/>
                    <form:options items="${contentViewList}" htmlEscape="false"/>
                </form:select>
                <span class="help-inline">自定义内容视图名称必须以"${article_DEFAULT_TEMPLATE}"开始</span>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-1">自定义视图参数:</label>
			<div class="col-md-4">
                <form:input path="viewConfig" htmlEscape="true"/>
                <span class="help-inline">视图参数例如: {count:2, title_show:"yes"}</span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:category:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>