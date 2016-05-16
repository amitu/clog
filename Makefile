.PHONEY: deploy help templates dev clean

rapydscript=../../node_modules/rapydscript-ng/bin/rapydscript
babel=../../node_modules/.bin/babel --plugins transform-react-jsx --presets es2015

TEMPDIR := $(shell mktemp -d)
DEPS = .deps templates/index.js _attachments/style.css _attachments/script.js
DEPS_TO_CLEAN = templates/index.js _attachments/style.css _attachments/script.js

dev: $(DEPS)
	couchapp push

_attachments/style.css: src/scss/*.scss
	sassc src/scss/main.scss _attachments/style.css

_attachments/script.js: src/pyjs/vyom/*.pyj src/pyjs/*.pyj src/pyjs/components.jsx
	cd src/pyjs && ${rapydscript} compile --import-path . --bare main.pyj --output ${TEMPDIR}/t.js
	cd src/pyjs && ${babel} components.jsx > ${TEMPDIR}/c.js
	cat vendor/jquery-2.2.2.min.js vendor/react.min.js vendor/react.dom.js \
		${TEMPDIR}/c.js ${TEMPDIR}/t.js > _attachments/script.js
	rm -rf ${TEMPDIR}

f:
	(sleep 1 && open http://localhost:8001) &
	./node_modules/fauxton/bin/fauxton --port 8001

u:
	open http://localhost:5984/_utils/index.html

p:
	open http://clog:5984

templates/%.js: src/templates/%.html
	python bin/compile.py $<

deploy: $(DEPS)
	couchapp push cloudant

.deps: requirements.txt package.json
	pip install -r requirements.txt
	npm install
	touch .deps

clean:
	-rm $(DEPS_TO_CLEAN)

help: ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
