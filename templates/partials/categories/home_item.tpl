<li component="categories/category" data-cid="{../cid}" data-numRecentReplies="1" class="row clearfix">
	<meta itemprop="name" content="{../name}">

	<div class="col-md-7 col-sm-9 col-xs-11 content">
		<div class="icon pull-left" style="{function.generateCategoryBackground}">
			<i class="fa fa-fw {../icon}"></i>
		</div>

		<h2 class="title">
			<!-- IMPORT partials/categories/link.tpl -->
			<span class="description pull-right">
			{../description}
			</span>
		</h2>
		<span class="visible-xs pull-right">
			<a class="permalink" href="{../teaser.url}">
				<small class="timeago" title="{../teaser.timestampISO}"></small>
			</a>
		</span>
	</div>

	<!-- IF !../link -->
	<div class="col-md-2 hidden-sm hidden-xs stats">
		{../totalTopicCount} <small>[[global:topics]]</small> / {../totalPostCount} <small>[[global:posts]]</small>
	</div>
	<!-- ENDIF !../link -->
	<!-- IF !children.length -->
		<div class="col-md-3 col-sm-3 col-xs-1 teaser hidden-xs">
			<!-- IMPORT partials/categories/lastpost.tpl -->
		</div>
	<!-- ENDIF !children.length -->
</li>