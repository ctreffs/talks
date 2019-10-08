revealjs := node_modules/.bin/reveal-md

help:
	@echo "make setup -- sets up revealjs + revel-md"
	@echo "make serve TALK=<RELATIVE/PATH/TO/TALK.md> -- serves and watches TALK"
	@echo "make print TALK=<RELATIVE/PATH/TO/TALK.md> -- prints TALK"
	@echo "make update -- updates revel-md"

serve:
	$(revealjs) "$(TALK)"

print:
	$(revealjs) "$(TALK)" --print "$(TALK).pdf"

setup:
	brew install node

	# init reveal.js submodule
	git submodule init
	git submodule update --remote

	cd reveal.js 

	npm install
	npm install reveal-md

update:
	npm i reveal-md