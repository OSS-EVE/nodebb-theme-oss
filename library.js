(function(module) {
	"use strict";

	var Widget = {
		templates: {}
	};
	
	Widget.defineWidgets = function(widgets, callback) {
		widgets = widgets.concat([
			{
				widget: "ossops",
				name: "Oss Ops",
				description: "Oss Ops widget",
				content: Widget.templates['admin/ossops.tpl']
			}
		]);

		callback(null, widgets);
	};


	module.exports = Widget;
}(module));