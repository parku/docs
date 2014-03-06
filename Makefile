all: watch

watch: clean
	bundle exec jekyll serve --drafts --watch --port 9393

clean:
	rm -fr .sass-cache/ _site/

linklint:
	@cp robots_allow.txt _site/robots.txt
	linklint -http -host localhost:9393 -limit 1000 -doc linklint /@
	@cp robots.txt _site/robots.txt

install: uninstall
	bundle install --binstubs vendor/bundle/bin --path vendor/bundle -j4 --without production
	rm -rf vendor/bundle/ruby/*/gems/jekyll-*/test/source

uninstall: clean
	rm -rf Gemfile.lock vendor/ .bundle/

deploy:
	git push origin gh-pages
