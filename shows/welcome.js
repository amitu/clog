function(doc, req) {
	var plate = require('vendor/jinja-to-js-runtime');
	var template = require("templates/index");

	return template.render({ username: 'James' });
}
