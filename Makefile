all: watch

generate-v4: clean
	mkdir -p build
	cp images build/images -r
	ln -nfs `readlink -m ./images` `pwd`/v4/images
	NOCACHE=1 aglio -i v4/parku.apib -o build/v4.html --theme 1984 --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

generate-v5: generate-v4
	mkdir -p build
	cp images build/images -r
	ln -nfs `readlink -m ./images` `pwd`/v5/images
	NOCACHE=1 aglio -i v5/parku.apib -o build/v5.html --theme 1984 --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

generate: generate-v4 generate-v5

clean:
	rm -rf build

linklint:
	@cp robots_allow.txt _site/robots.txt
	linklint -http -host localhost:9393 -limit 1000 -doc linklint /@
	@cp robots.txt _site/robots.txt

install: uninstall
	gem install bundler --user-install
	bundle install --binstubs vendor/bundle/bin --path vendor/bundle --without production
	rm -rf vendor/bundle/ruby/*/gems/jekyll-*/test
	rm -fr vendor/bundle/ruby/*/gems/jekyll-*/lib/site_template
	rm -fr vendor/bundle/ruby/*/gems/jekyll-*/site

uninstall: clean
	rm -rf Gemfile.lock vendor/ .bundle/

deploy:
	git push origin gh-pages
