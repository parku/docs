all: watch

watch: clean
	bundle exec jekyll serve --drafts --watch --port 9393

clean:
	rm -fr .sass-cache/ _site/

linklint:
	linklint -http -host localhost:9393 -limit 1000 /@

install: uninstall
	bundle install --binstubs vendor/bundle/bin --path vendor/bundle --without production
	rm -rf vendor/bundle/ruby/*/gems/jekyll-*/test/source

uninstall: clean
	rm -rf Gemfile.lock vendor/ .bundle/

deploy:
	git push origin gh-pages