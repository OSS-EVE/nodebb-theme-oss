(function(module) {
	"use strict";

	var async = module.parent.require('async'),
		nconf = module.parent.require('nconf'),
		fs = require('fs'),
		path = require('path'),
		categories = module.parent.require('./categories'),
		privileges = module.parent.require('./privileges'),
		templates = module.parent.require('templates.js'),
		translator = module.parent.require('../public/src/modules/translator'),
		app;

	var Widget = {
		templates: {}
	};
	
	Widget.init = function(params, callback) {
		app = params.app;

		var templatesToLoad = [
			"widgets/opswidget.tpl",
			"admin/opswidget.tpl"
		];

		function loadTemplate(template, next) {
			fs.readFile(path.resolve(__dirname, './templates/' + template), function (err, data) {
				if (err) {
					console.log(err.message);
					return next(err);
				}
				Widget.templates[template] = data.toString();
				next(null);
			});
		}

		async.each(templatesToLoad, loadTemplate);

		callback();
	};

	Widget.renderOssOpsWidget = function(widget, callback) {
		function extractDate(slug){
			var tmp = slug.split("/")[1].split("-")
			return new Date(
				tmp[0],
				tmp[1]-1,
				tmp[2],
				tmp[3],
				tmp[4]
			);
		}
		privileges.categories.get(widget.data.cid, widget.uid, function(err, data) {
			if(data.read){
				categories.getCategoryTopics({
					cid: widget.data.cid,
					uid: widget.uid,
					set: 'cid:' + widget.data.cid + ':tids',
					reverse: false,
					start: 0,
					stop: widget.data.numTopics ? widget.data.numTopics : 5
				}, function(err, data) {
					if (err) {
						return callback(err);
					}

					data.topics.sort(function(a,b) { 
						try {
							return extractDate(a.slug) - extractDate(b.slug);
						}
						catch(err) {
							return a.slug.split("/")[1] - b.slug.split("/")[1];
						}
					});
					//console.log(Date.getTimezoneOffset());

					var modifiedTopics = []
					data.topics.forEach(function(entry) {
						if(entry.title.split(" ").reverse()[0] == "!"){
							entry.important = true;
							entry.title = entry.title.slice(0, -1);
						}
						else
							entry.important = false;
						try{
							entry.date = (entry.slug && !isNaN(extractDate(entry.slug))) ? extractDate(entry.slug).getTime() : 0;
						}
						catch(err) {
							entry.date = 0;
						}
						if(modifiedTopics.length < (widget.data.numTopics ? widget.data.numTopics : 5)&&
							  entry.date > Date.now())
							modifiedTopics.push(entry);
					});
					app.render('widgets/opswidget', {
						topics: modifiedTopics,
						relative_path: nconf.get('relative_path')
					}, callback);
				});
			}
		});
	};

	Widget.defineWidgets = function(widgets, callback) {
		widgets = widgets.concat([
			{
				widget: "ossops",
				name: "Oss Ops",
				description: "Oss Ops widget",
				content: Widget.templates['admin/opswidget.tpl'],
				categories: ["cat1","cat2"]
			}
		]);

		callback(null, widgets);
	};


	module.exports = Widget;
}(module));