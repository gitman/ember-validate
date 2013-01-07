JADE = $(shell find test -name "*.jade")
HTML = $(JADE:.jade=.html)

COFFEE = $(shell find test lib -name "*.coffee") index.coffee
JS 		 = $(COFFEE:.coffee=.js)

test: build
	@mocha-phantomjs -R dot test/support/index.html

build: $(HTML) $(JS)
	@component build --dev

%.html: %.jade
	jade < $< --path $< > $@

%.js: %.coffee
	coffee -bc $<

clean:
	rm -rf $(HTML) $(JS)

.PHONY: clean test