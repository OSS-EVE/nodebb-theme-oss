<ul class="ops">
<!-- BEGIN topics -->
	<li class="row <!-- IF topics.important -->important<!-- ENDIF topics.important -->" >
		<a href="{relative_path}/topic/{topics.slug}">
			<p class="col-md-9 col-sm-9 col-xs-12">{topics.title}</p>
			<p class="col-md-3 col-sm-3 hidden-xs" id="eta-{topics.tid}"></p>
		</a>
		<script type="text/javascript">
			var Date{topics.tid} = {topics.date};
			setInterval(function(){
				if(Date{topics.tid} > 0){
					document.getElementById("eta-{topics.tid}").innerHTML = "In " + msToTime(Date{topics.tid} - Date.now())
				}
			}, 1000);
		</script>
	</li>
<!-- END topics -->
</ul>
<script type="text/javascript">
	function msToTime(duration) {
		var milliseconds = parseInt((duration%1000)/100)
			, seconds = parseInt((duration/1000)%60)
			, minutes = parseInt((duration/(1000*60))%60)
			, hours = parseInt((duration/(1000*60*60))%24)
			, days = parseInt((duration/(1000*60*60*24)));

		var ret = "";
		if(days > 0)
			ret += days + " days ";
		if(hours > 0){
			hours = (hours < 10) ? "0" + hours : hours;
			ret += hours + ":";
		}
		minutes = (minutes < 10) ? "0" + minutes : minutes;
		seconds = (seconds < 10) ? "0" + seconds : seconds;

		return ret + minutes + ":" + seconds;
	}
</script>