import sys
import commands

template = sys.argv[1].split("/")[-1].split(".")[0]

stat, output = commands.getstatusoutput(
	"jinja_to_js src/templates/ %s.html -o templates/%s.js" % (template, template)
)

assert stat == 0, output

file("templates/%s.js" % template, "a+").write(
	"\n\nexports.render = template%s;\n" % template.title()
)
