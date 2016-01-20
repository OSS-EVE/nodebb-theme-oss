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
					app.render('widgets/opswidget', {
						topics: data.topics,
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