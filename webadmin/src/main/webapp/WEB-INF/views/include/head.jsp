<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="author" content="http://jeesite.com/"/>
<meta name="renderer" content="webkit"><meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10" />
<meta http-equiv="Expires" content="0"><meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store">

<!-- core - css -->
<link href="${ctxStatic}/component/BJUI/themes/css/style.css" rel="stylesheet">
<link href="${ctxStatic}/component/BJUI/themes/green/core.css" id="bjui-link-theme" rel="stylesheet">
<link href="${ctxStatic}/component/BJUI/themes/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctxStatic}/component/BJUI/themes/css/FA/css/font-awesome.min.css" rel="stylesheet">
<!-- plug - css -->
<%--<link href="${ctxStatic}Plugins/kindeditor/themes/default/default.css" rel="stylesheet">--%>
<link href="${ctxStatic}/component/BJUI/plugins/colorpicker/css/bootstrap-colorpicker.min.css" rel="stylesheet">
<link href="${ctxStatic}/component/BJUI/plugins/niceValidator/jquery.validator.css" rel="stylesheet">
<link href="${ctxStatic}/component/BJUI/plugins/bootstrapSelect/bootstrap-select.css" rel="stylesheet">
<style type="text/css">
    tr{height: 32px; line-height: 32px} /* 优化表格行高 */
    .resize-head{height:0;} /* 修正表格行距增加后表头显示问题 */
    .panel-body td{line-height:1.5;font-size: 14px;} /* kindEditor文字行距 */
    .panel-body p{line-height:1.5;font-size: 14px;} /* kindEditor文字行距 */
</style>
<!--[if lte IE 7]>
<link href="${ctxStatic}/component/BJUI/themes/css/ie7.css" rel="stylesheet">
<![endif]-->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lte IE 9]>
<script src="${ctxStatic}/component/BJUI/other/html5shiv.min.js"></script>
<script src="${ctxStatic}/component/BJUI/other/respond.min.js"></script>
<![endif]-->
<!-- jquery -->
<script src="${ctxStatic}/component/BJUI/js/jquery-1.12.3.js"></script>
<script src="${ctxStatic}/component/BJUI/js/jquery.cookie.js"></script>
<!--[if lte IE 9]>
<script src="${ctxStatic}/component/BJUI/other/jquery.iframe-transport.js"></script>
<![endif]-->
<!-- BJUI.all 分模块压缩版 -->
<%--<script src="${ctxStatic}/component/BJUI/js/bjui-all.js"></script>--%>

<!-- 以下是B-JUI的分模块未压缩版，建议开发调试阶段使用下面的版本 -->
<script src="${ctxStatic}/component/BJUI/js/src/bjui-core.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-regional.zh-CN.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-frag.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-extends.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-basedrag.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-slidebar.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-contextmenu.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-navtab.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-dialog.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-taskbar.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-ajax.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-alertmsg.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-pagination.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-util.date.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-datepicker.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-ajaxtab.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-tablefixed.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-tabledit.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-spinner.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-lookup.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-tags.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-upload.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-theme.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-initui.js"></script>
<script src="${ctxStatic}/component/BJUI/js/src/bjui-plugins.js"></script>

<!-- plugins -->
<!-- swfupload for uploadify && kindeditor -->
<script src="${ctxStatic}/component/BJUI/plugins/swfupload/swfupload.js"></script>
<!-- kindeditor -->
<%--<script src="${ctxStatic}Plugins/kindeditor/kindeditor-all.js"></script>--%>
<%--<script src="${ctxStatic}Plugins/kindeditor/lang/zh_CN.js"></script>--%>
<!-- colorpicker -->
<script src="${ctxStatic}/component/BJUI/plugins/colorpicker/js/bootstrap-colorpicker.min.js"></script>
<!-- ztree -->
<script src="${ctxStatic}/component/BJUI/plugins/ztree/jquery.ztree.all-3.5.js"></script>
<!-- nice validate -->
<script src="${ctxStatic}/component/BJUI/plugins/niceValidator/jquery.validator.js"></script>
<script src="${ctxStatic}/component/BJUI/plugins/niceValidator/jquery.validator.themes.js"></script>
<!-- bootstrap plugins -->
<script src="${ctxStatic}/component/BJUI/plugins/bootstrap.min.js"></script>
<script src="${ctxStatic}/component/BJUI/plugins/bootstrapSelect/bootstrap-select.min.js"></script>
<!-- icheck -->
<script src="${ctxStatic}/component/BJUI/plugins/icheck/icheck.min.js"></script>
<!-- dragsort -->
<script src="${ctxStatic}/component/BJUI/plugins/dragsort/jquery.dragsort-0.5.1.min.js"></script>
<!-- highcharts -->
<%--<script src="${ctxStatic}/component/BJUI/plugins/highcharts/highcharts.js"></script>--%>
<%--<script src="${ctxStatic}/component/BJUI/plugins/highcharts/highcharts-3d.js"></script>--%>
<!-- ECharts -->
<script src="${ctxStatic}/component/BJUI/plugins/echarts/echarts.js"></script>
<!-- other plugins -->
<script src="${ctxStatic}/component/BJUI/plugins/other/jquery.autosize.js"></script>
<link href="${ctxStatic}/component/BJUI/plugins/uploadify/css/uploadify.css" rel="stylesheet">
<script src="${ctxStatic}/component/BJUI/plugins/uploadify/scripts/jquery.uploadify.min.js"></script>
<%--<script src="<%=request.getContextPath()%>/Public/Js/functions.js"></script>--%>
<script type="text/javascript">
    var ctx = '${ctx}', ctxStatic='${ctxStatic}';
</script>
