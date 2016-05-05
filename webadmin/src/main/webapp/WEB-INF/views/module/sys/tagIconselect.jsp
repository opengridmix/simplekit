<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>图标选择</title>
	<meta name="decorator" content="blank"/>
    <style type="text/css">
    	.page-header {clear:both;margin:0 20px;padding-top:20px;}
		.the-icons {padding:25px 10px 15px;list-style:none;}
		.the-icons li {float:left;width:22%;line-height:25px;margin:2px 5px;cursor:pointer;}
		.the-icons i {margin:1px 5px;font-size:16px;} .the-icons li:hover {background-color:#efefef;}
        .the-icons li.active {background-color:#0088CC;color:#ffffff;}
        .the-icons li:hover i{font-size:20px;}
    </style>
    <script type="text/javascript">
	    $(document).ready(function(){
	    	$("#fas li").click(function(){
	    		$("#fas li").removeClass("active");
	    		$("#fas li i").removeClass("fa fa-white");
	    		$(this).addClass("active");
	    		$(this).children("i").addClass("fa fa-white");
	    		$("#fa").val($(this).text());
	    	});
	    	$("#fas li").each(function(){
	    		if ($(this).text()=="${value}"){
	    			$(this).click();
	    		}
	    	});
	    	$("#fas li").dblclick(function(){
	    		top.$.jBox.getBox().find("button[value='ok']").trigger("click");
	    	});
	    });
    </script>
</head>
<body>
<input type="hidden" id="fa fa" value="${value}" />
<div id="fa fas">
		
	    <h2 class="page-header"> Web 应用的图标</h2>
	    
	    <ul class="the-fas">
	      <li><i class="fa fa-adjust"></i> fa-adjust</li>
	      <li><i class="fa fa-asterisk"></i> fa-asterisk</li>
	      <li><i class="fa fa-ban-circle"></i> fa-ban-circle</li>
	      <li><i class="fa fa-bar-chart"></i> fa-bar-chart</li>
	      <li><i class="fa fa-barcode"></i> fa-barcode</li>
	      <li><i class="fa fa-beaker"></i> fa-beaker</li>
	      <li><i class="fa fa-beer"></i> fa-beer</li>
	      <li><i class="fa fa-bell"></i> fa-bell</li>
	      <li><i class="fa fa-bell-alt"></i> fa-bell-alt</li>
	      <li><i class="fa fa-bolt"></i> fa-bolt</li>
	      <li><i class="fa fa-book"></i> fa-book</li>
	      <li><i class="fa fa-bookmark"></i> fa-bookmark</li>
	      <li><i class="fa fa-bookmark-empty"></i> fa-bookmark-empty</li>
	      <li><i class="fa fa-briefcase"></i> fa-briefcase</li>
	      <li><i class="fa fa-bullhorn"></i> fa-bullhorn</li>
	      <li><i class="fa fa-calendar"></i> fa-calendar</li>
	      <li><i class="fa fa-camera"></i> fa-camera</li>
	      <li><i class="fa fa-camera-retro"></i> fa-camera-retro</li>
	      <li><i class="fa fa-certificate"></i> fa-certificate</li>
	      <li><i class="fa fa-check"></i> fa-check</li>
	      <li><i class="fa fa-check-empty"></i> fa-check-empty</li>
	      <li><i class="fa fa-circle"></i> fa-circle</li>
	      <li><i class="fa fa-circle-blank"></i> fa-circle-blank</li>
	      <li><i class="fa fa-cloud"></i> fa-cloud</li>
	      <li><i class="fa fa-cloud-download"></i> fa-cloud-download</li>
	      <li><i class="fa fa-cloud-upload"></i> fa-cloud-upload</li>
	      <li><i class="fa fa-coffee"></i> fa-coffee</li>
	      <li><i class="fa fa-cog"></i> fa-cog</li>
	      <li><i class="fa fa-cogs"></i> fa-cogs</li>
	      <li><i class="fa fa-comment"></i> fa-comment</li>
	      <li><i class="fa fa-comment-alt"></i> fa-comment-alt</li>
	      <li><i class="fa fa-comments"></i> fa-comments</li>
	      <li><i class="fa fa-comments-alt"></i> fa-comments-alt</li>
	      <li><i class="fa fa-credit-card"></i> fa-credit-card</li>
	      <li><i class="fa fa-dashboard"></i> fa-dashboard</li>
	      <li><i class="fa fa-desktop"></i> fa-desktop</li>
	      <li><i class="fa fa-download"></i> fa-download</li>
	      <li><i class="fa fa-download-alt"></i> fa-download-alt</li>
	    

	      <li><i class="fa fa-edit"></i> fa-edit</li>
	      <li><i class="fa fa-envelope"></i> fa-envelope</li>
	      <li><i class="fa fa-envelope-alt"></i> fa-envelope-alt</li>
	      <li><i class="fa fa-exchange"></i> fa-exchange</li>
	      <li><i class="fa fa-exclamation-sign"></i> fa-exclamation-sign</li>
	      <li><i class="fa fa-external-link"></i> fa-external-link</li>
	      <li><i class="fa fa-eye-close"></i> fa-eye-close</li>
	      <li><i class="fa fa-eye-open"></i> fa-eye-open</li>
	      <li><i class="fa fa-facetime-video"></i> fa-facetime-video</li>
	      <li><i class="fa fa-fighter-jet"></i> fa-fighter-jet</li>
	      <li><i class="fa fa-film"></i> fa-film</li>
	      <li><i class="fa fa-filter"></i> fa-filter</li>
	      <li><i class="fa fa-fire"></i> fa-fire</li>
	      <li><i class="fa fa-flag"></i> fa-flag</li>
	      <li><i class="fa fa-folder-close"></i> fa-folder-close</li>
	      <li><i class="fa fa-folder-open"></i> fa-folder-open</li>
	      <li><i class="fa fa-folder-close-alt"></i> fa-folder-close-alt</li>
	      <li><i class="fa fa-folder-open-alt"></i> fa-folder-open-alt</li>
	      <li><i class="fa fa-food"></i> fa-food</li>
	      <li><i class="fa fa-gift"></i> fa-gift</li>
	      <li><i class="fa fa-glass"></i> fa-glass</li>
	      <li><i class="fa fa-globe"></i> fa-globe</li>
	      <li><i class="fa fa-group"></i> fa-group</li>
	      <li><i class="fa fa-hdd"></i> fa-hdd</li>
	      <li><i class="fa fa-headphones"></i> fa-headphones</li>
	      <li><i class="fa fa-heart"></i> fa-heart</li>
	      <li><i class="fa fa-heart-empty"></i> fa-heart-empty</li>
	      <li><i class="fa fa-home"></i> fa-home</li>
	      <li><i class="fa fa-inbox"></i> fa-inbox</li>
	      <li><i class="fa fa-info-sign"></i> fa-info-sign</li>
	      <li><i class="fa fa-key"></i> fa-key</li>
	      <li><i class="fa fa-leaf"></i> fa-leaf</li>
	      <li><i class="fa fa-laptop"></i> fa-laptop</li>
	      <li><i class="fa fa-legal"></i> fa-legal</li>
	      <li><i class="fa fa-lemon"></i> fa-lemon</li>
	      <li><i class="fa fa-lightbulb"></i> fa-lightbulb</li>
	      <li><i class="fa fa-lock"></i> fa-lock</li>
	      <li><i class="fa fa-unlock"></i> fa-unlock</li>
	    

	      <li><i class="fa fa-magic"></i> fa-magic</li>
	      <li><i class="fa fa-magnet"></i> fa-magnet</li>
	      <li><i class="fa fa-map-marker"></i> fa-map-marker</li>
	      <li><i class="fa fa-minus"></i> fa-minus</li>
	      <li><i class="fa fa-minus-sign"></i> fa-minus-sign</li>
	      <li><i class="fa fa-mobile-phone"></i> fa-mobile-phone</li>
	      <li><i class="fa fa-money"></i> fa-money</li>
	      <li><i class="fa fa-move"></i> fa-move</li>
	      <li><i class="fa fa-music"></i> fa-music</li>
	      <li><i class="fa fa-off"></i> fa-off</li>
	      <li><i class="fa fa-ok"></i> fa-ok</li>
	      <li><i class="fa fa-ok-circle"></i> fa-ok-circle</li>
	      <li><i class="fa fa-ok-sign"></i> fa-ok-sign</li>
	      <li><i class="fa fa-pencil"></i> fa-pencil</li>
	      <li><i class="fa fa-picture"></i> fa-picture</li>
	      <li><i class="fa fa-plane"></i> fa-plane</li>
	      <li><i class="fa fa-plus"></i> fa-plus</li>
	      <li><i class="fa fa-plus-sign"></i> fa-plus-sign</li>
	      <li><i class="fa fa-print"></i> fa-print</li>
	      <li><i class="fa fa-pushpin"></i> fa-pushpin</li>
	      <li><i class="fa fa-qrcode"></i> fa-qrcode</li>
	      <li><i class="fa fa-question-sign"></i> fa-question-sign</li>
	      <li><i class="fa fa-quote-left"></i> fa-quote-left</li>
	      <li><i class="fa fa-quote-right"></i> fa-quote-right</li>
	      <li><i class="fa fa-random"></i> fa-random</li>
	      <li><i class="fa fa-refresh"></i> fa-refresh</li>
	      <li><i class="fa fa-remove"></i> fa-remove</li>
	      <li><i class="fa fa-remove-circle"></i> fa-remove-circle</li>
	      <li><i class="fa fa-remove-sign"></i> fa-remove-sign</li>
	      <li><i class="fa fa-reorder"></i> fa-reorder</li>
	      <li><i class="fa fa-reply"></i> fa-reply</li>
	      <li><i class="fa fa-resize-horizontal"></i> fa-resize-horizontal</li>
	      <li><i class="fa fa-resize-vertical"></i> fa-resize-vertical</li>
	      <li><i class="fa fa-retweet"></i> fa-retweet</li>
	      <li><i class="fa fa-road"></i> fa-road</li>
	      <li><i class="fa fa-rss"></i> fa-rss</li>
	      <li><i class="fa fa-screenshot"></i> fa-screenshot</li>
	      <li><i class="fa fa-search"></i> fa-search</li>
	    

	      <li><i class="fa fa-share"></i> fa-share</li>
	      <li><i class="fa fa-share-alt"></i> fa-share-alt</li>
	      <li><i class="fa fa-shopping-cart"></i> fa-shopping-cart</li>
	      <li><i class="fa fa-signal"></i> fa-signal</li>
	      <li><i class="fa fa-signin"></i> fa-signin</li>
	      <li><i class="fa fa-signout"></i> fa-signout</li>
	      <li><i class="fa fa-sitemap"></i> fa-sitemap</li>
	      <li><i class="fa fa-sort"></i> fa-sort</li>
	      <li><i class="fa fa-sort-down"></i> fa-sort-down</li>
	      <li><i class="fa fa-sort-up"></i> fa-sort-up</li>
	      <li><i class="fa fa-spinner"></i> fa-spinner</li>
	      <li><i class="fa fa-star"></i> fa-star</li>
	      <li><i class="fa fa-star-empty"></i> fa-star-empty</li>
	      <li><i class="fa fa-star-half"></i> fa-star-half</li>
	      <li><i class="fa fa-tablet"></i> fa-tablet</li>
	      <li><i class="fa fa-tag"></i> fa-tag</li>
	      <li><i class="fa fa-tags"></i> fa-tags</li>
	      <li><i class="fa fa-tasks"></i> fa-tasks</li>
	      <li><i class="fa fa-thumbs-down"></i> fa-thumbs-down</li>
	      <li><i class="fa fa-thumbs-up"></i> fa-thumbs-up</li>
	      <li><i class="fa fa-time"></i> fa-time</li>
	      <li><i class="fa fa-tint"></i> fa-tint</li>
	      <li><i class="fa fa-trash"></i> fa-trash</li>
	      <li><i class="fa fa-trophy"></i> fa-trophy</li>
	      <li><i class="fa fa-truck"></i> fa-truck</li>
	      <li><i class="fa fa-umbrella"></i> fa-umbrella</li>
	      <li><i class="fa fa-upload"></i> fa-upload</li>
	      <li><i class="fa fa-upload-alt"></i> fa-upload-alt</li>
	      <li><i class="fa fa-user"></i> fa-user</li>
	      <li><i class="fa fa-user-md"></i> fa-user-md</li>
	      <li><i class="fa fa-volume-off"></i> fa-volume-off</li>
	      <li><i class="fa fa-volume-down"></i> fa-volume-down</li>
	      <li><i class="fa fa-volume-up"></i> fa-volume-up</li>
	      <li><i class="fa fa-warning-sign"></i> fa-warning-sign</li>
	      <li><i class="fa fa-wrench"></i> fa-wrench</li>
	      <li><i class="fa fa-zoom-in"></i> fa-zoom-in</li>
	      <li><i class="fa fa-zoom-out"></i> fa-zoom-out</li>
	    </ul>
	
	  
	    <h2 class="page-header">文本编辑器图标</h2>
	  
	    <ul class="the-fas">
	      <li><i class="fa fa-file"></i> fa-file</li>
	      <li><i class="fa fa-file-alt"></i> fa-file-alt</li>
	      <li><i class="fa fa-cut"></i> fa-cut</li>
	      <li><i class="fa fa-copy"></i> fa-copy</li>
	      <li><i class="fa fa-paste"></i> fa-paste</li>
	      <li><i class="fa fa-save"></i> fa-save</li>
	      <li><i class="fa fa-undo"></i> fa-undo</li>
	      <li><i class="fa fa-repeat"></i> fa-repeat</li>
	    

	      <li><i class="fa fa-text-height"></i> fa-text-height</li>
	      <li><i class="fa fa-text-width"></i> fa-text-width</li>
	      <li><i class="fa fa-align-left"></i> fa-align-left</li>
	      <li><i class="fa fa-align-center"></i> fa-align-center</li>
	      <li><i class="fa fa-align-right"></i> fa-align-right</li>
	      <li><i class="fa fa-align-justify"></i> fa-align-justify</li>
	      <li><i class="fa fa-indent-left"></i> fa-indent-left</li>
	      <li><i class="fa fa-indent-right"></i> fa-indent-right</li>
	    

	      <li><i class="fa fa-font"></i> fa-font</li>
	      <li><i class="fa fa-bold"></i> fa-bold</li>
	      <li><i class="fa fa-italic"></i> fa-italic</li>
	      <li><i class="fa fa-strikethrough"></i> fa-strikethrough</li>
	      <li><i class="fa fa-underline"></i> fa-underline</li>
	      <li><i class="fa fa-link"></i> fa-link</li>
	      <li><i class="fa fa-paper-clip"></i> fa-paper-clip</li>
	      <li><i class="fa fa-columns"></i> fa-columns</li>
	    

	      <li><i class="fa fa-table"></i> fa-table</li>
	      <li><i class="fa fa-th-large"></i> fa-th-large</li>
	      <li><i class="fa fa-th"></i> fa-th</li>
	      <li><i class="fa fa-th-list"></i> fa-th-list</li>
	      <li><i class="fa fa-list"></i> fa-list</li>
	      <li><i class="fa fa-list-ol"></i> fa-list-ol</li>
	      <li><i class="fa fa-list-ul"></i> fa-list-ul</li>
	      <li><i class="fa fa-list-alt"></i> fa-list-alt</li>
	    </ul>
	
	    <h2 class="page-header">指示方向的图标</h2>
	  
	    <ul class="the-icons">
	      <li><i class="fa fa-angle-left"></i> fa-angle-left</li>
	      <li><i class="fa fa-angle-right"></i> fa-angle-right</li>
	      <li><i class="fa fa-angle-up"></i> fa-angle-up</li>
	      <li><i class="fa fa-angle-down"></i> fa-angle-down</li>
	      <li><i class="fa fa-arrow-down"></i> fa-arrow-down</li>
	      <li><i class="fa fa-arrow-left"></i> fa-arrow-left</li>
	      <li><i class="fa fa-arrow-right"></i> fa-arrow-right</li>
	      <li><i class="fa fa-arrow-up"></i> fa-arrow-up</li>
	    

	      <li><i class="fa fa-caret-down"></i> fa-caret-down</li>
	      <li><i class="fa fa-caret-left"></i> fa-caret-left</li>
	      <li><i class="fa fa-caret-right"></i> fa-caret-right</li>
	      <li><i class="fa fa-caret-up"></i> fa-caret-up</li>
	      <li><i class="fa fa-chevron-down"></i> fa-chevron-down</li>
	      <li><i class="fa fa-chevron-left"></i> fa-chevron-left</li>
	      <li><i class="fa fa-chevron-right"></i> fa-chevron-right</li>
	      <li><i class="fa fa-chevron-up"></i> fa-chevron-up</li>
	    

	      <li><i class="fa fa-circle-arrow-down"></i> fa-circle-arrow-down</li>
	      <li><i class="fa fa-circle-arrow-left"></i> fa-circle-arrow-left</li>
	      <li><i class="fa fa-circle-arrow-right"></i> fa-circle-arrow-right</li>
	      <li><i class="fa fa-circle-arrow-up"></i> fa-circle-arrow-up</li>
	      <li><i class="fa fa-double-angle-left"></i> fa-double-angle-left</li>
	      <li><i class="fa fa-double-angle-right"></i> fa-double-angle-right</li>
	      <li><i class="fa fa-double-angle-up"></i> fa-double-angle-up</li>
	      <li><i class="fa fa-double-angle-down"></i> fa-double-angle-down</li>
	    

	      <li><i class="fa fa-hand-down"></i> fa-hand-down</li>
	      <li><i class="fa fa-hand-left"></i> fa-hand-left</li>
	      <li><i class="fa fa-hand-right"></i> fa-hand-right</li>
	      <li><i class="fa fa-hand-up"></i> fa-hand-up</li>
	      <li><i class="fa fa-circle"></i> fa-circle</li>
	      <li><i class="fa fa-circle-blank"></i> fa-circle-blank</li>
	    </ul>
	  
	
	    <h2 class="page-header">视频播放器图标</h2>
	  
	    <ul class="the-fas">
	      <li><i class="fa fa-play-circle"></i> fa-play-circle</li>
	      <li><i class="fa fa-play"></i> fa-play</li>
	      <li><i class="fa fa-pause"></i> fa-pause</li>
	      <li><i class="fa fa-stop"></i> fa-stop</li>
	    

	      <li><i class="fa fa-step-backward"></i> fa-step-backward</li>
	      <li><i class="fa fa-fast-backward"></i> fa-fast-backward</li>
	      <li><i class="fa fa-backward"></i> fa-backward</li>
	      <li><i class="fa fa-forward"></i> fa-forward</li>
	    

	      <li><i class="fa fa-fast-forward"></i> fa-fast-forward</li>
	      <li><i class="fa fa-step-forward"></i> fa-step-forward</li>
	      <li><i class="fa fa-eject"></i> fa-eject</li>
	    

	      <li><i class="fa fa-fullscreen"></i> fa-fullscreen</li>
	      <li><i class="fa fa-resize-full"></i> fa-resize-full</li>
	      <li><i class="fa fa-resize-small"></i> fa-resize-small</li>
	    </ul>
	
	
	    <h2 class="page-header">SNS图标</h2>
	  
	    <ul class="the-fas">
	      <li><i class="fa fa-phone"></i> fa-phone</li>
	      <li><i class="fa fa-phone-sign"></i> fa-phone-sign</li>
	      <li><i class="fa fa-facebook"></i> fa-facebook</li>
	      <li><i class="fa fa-facebook-sign"></i> fa-facebook-sign</li>
	    

	      <li><i class="fa fa-twitter"></i> fa-twitter</li>
	      <li><i class="fa fa-twitter-sign"></i> fa-twitter-sign</li>
	      <li><i class="fa fa-github"></i> fa-github</li>
	      <li><i class="fa fa-github-alt"></i> fa-github-alt</li>
	    

	      <li><i class="fa fa-github-sign"></i> fa-github-sign</li>
	      <li><i class="fa fa-linkedin"></i> fa-linkedin</li>
	      <li><i class="fa fa-linkedin-sign"></i> fa-linkedin-sign</li>
	      <li><i class="fa fa-pinterest"></i> fa-pinterest</li>
	    

	      <li><i class="fa fa-pinterest-sign"></i> fa-pinterest-sign</li>
	      <li><i class="fa fa-google-plus"></i> fa-google-plus</li>
	      <li><i class="fa fa-google-plus-sign"></i> fa-google-plus-sign</li>
	      <li><i class="fa fa-sign-blank"></i> fa-sign-blank</li>
	    </ul>
	  
	  
	    <h2 class="page-header">医疗图标</h2>
	  
	    <ul class="the-icons">
	      <li><i class="fa fa-ambulance"></i> fa-ambulance</li>
	      <li><i class="fa fa-beaker"></i> fa-beaker</li>


	      <li><i class="fa fa-h-sign"></i> fa-h-sign</li>
	      <li><i class="fa fa-hospital"></i> fa-hospital</li>
	    

	      <li><i class="fa fa-medkit"></i> fa-medkit</li>
	      <li><i class="fa fa-plus-sign-alt"></i> fa-plus-sign-alt</li>
	    

	      <li><i class="fa fa-stethoscope"></i> fa-stethoscope</li>
	      <li><i class="fa fa-user-md"></i> fa-user-md</li>
	    </ul>
	<br/><br/>
</div>
</body>