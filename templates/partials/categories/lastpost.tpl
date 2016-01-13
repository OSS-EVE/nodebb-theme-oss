<div class="card" style="border-color: {../bgColor}">
	<!-- BEGIN posts -->
	<!-- IF @first -->
	<div component="category/posts">
		<p>
			<a class="permalink" href="{config.relative_path}/topic/{../topic.slug}<!-- IF ../index -->/{../index}<!-- ENDIF ../index -->"><strong>{../topic.title}</strong></a><br>
			<span class="timeago" title="{../relativeTime}"></span> by <a href="{config.relative_path}/user/{../user.username}">{../user.username}</a>
		</p>
		<div class="post-content">
			
		</div>
	</div>
	<!-- ENDIF @first -->
	<!-- END posts -->
	<!-- IF !../posts.length -->
	<div component="category/posts">
		<div class="post-content">
			[[category:no_new_posts]]
		</div>
	</div>
	<!-- ENDIF !../posts.length -->
</div>
