<!-- IF topics.length --><div class="panel panel-default">
	<div class="panel-heading">OP Timers:</div>
	<div class="panel-body">
		<ul class="ops">
		<!-- BEGIN topics -->
			<li class="row <!-- IF topics.important -->important<!-- ENDIF topics.important -->" >
				<a href="{relative_path}/topic/{topics.slug}">
					<p class="col-md-4 col-sm-4 col-xs-9">{topics.title}</p>
					<p class="col-md-4 col-sm-4 hidden-xs" title data-original-title="Local: {topics.dateTZ}">{topics.dateUTC}</p>
					<p class="col-md-4 col-sm-4 col-xs-3" id="eta-{topics.tid}"></p>
				</a>
				<script type="text/javascript">
					var Date{topics.tid} = {topics.date};
					setInterval(function(){
						if(Date{topics.tid} > 0 && document.getElementById("eta-{topics.tid}")){
							document.getElementById("eta-{topics.tid}").innerHTML = msToTime(Date{topics.tid} - Date.now())+" left."
						}
					}, 1000);
				</script>
			</li>
		<!-- END topics -->
		</ul>
	</div>
</div>
<!-- ENDIF topics.length -->
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