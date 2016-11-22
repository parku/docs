# shell modification for wild cards
SHELL=/bin/bash -O extglob -c

# output build files into current directory as github expects them in
# the root directory
BUILD_DIR=./build
GENERATED_DIR=./build/generated
COMMON_DEPS=$(BUILD_DIR)/images/* Makefile theme/* | ./tmp

 # current stable version gets index assigned
PAGE_V4=index
PAGE_V5=v5

PUBLISH_TO_BRANCH=gh-pages

# files to use for building v4
V4_SRC:=$(addprefix v4/, \
	parku.apib \
	attributes.apib \
	bookings.apib \
	cars.apib \
	changelog.md \
	coupon.apib \
	devices.apib \
	facebook.apib \
	invitations.apib \
	locations.apib \
	login.apib \
	password.apib \
	payment.apib \
	phone_numbers.apib \
	sesam.apib \
	settings.apib \
	static_pages.apib \
	user.apib \
	violations.apib \
	voucher.apib)

# files to use for building v5
V5_SRC:=v5/parku.apib \
	v5/locations.apib \
	$(addprefix v4/, \
	attributes.apib \
	bookings.apib \
	cars.apib \
	changelog.md \
	coupon.apib \
	devices.apib \
	facebook.apib \
	invitations.apib \
	login.apib \
	password.apib \
	payment.apib \
	phone_numbers.apib \
	sesam.apib \
	settings.apib \
	static_pages.apib \
	user.apib \
	violations.apib \
	voucher.apib)

all: generate $(GENERATED_DIR)/v4.apib $(GENERATED_DIR)/v4.swagger.json $(GENERATED_DIR)/v5.apib $(GENERATED_DIR)/v5.swagger.json meta-files

clean:
	rm -rf $(GENERATED_DIR) $(BUILD_DIR) $(PUBLISH_TO_BRANCH) tmp

meta-files: CNAME robots_allow.txt robots.txt | $(BUILD_DIR)
	cp CNAME robots.txt robots_allow.txt build

# Build version v4 from v4 sources
$(BUILD_DIR)/$(PAGE_V4).html: v4/*  $(COMMON_DEPS)
	mkdir tmp/v4 -p
	cp $(V4_SRC) tmp/v4/ -r
	sed -i -e 's/{{apiversion}}/v4/g' tmp/v4/*
	NOCACHE=1 aglio -i tmp/v4/parku.apib -o $(BUILD_DIR)/$(PAGE_V4).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

# Build version v5 from v5 sources
$(BUILD_DIR)/$(PAGE_V5).html: v4/* v5/* $(COMMON_DEPS)
	mkdir tmp/v5 -p
	cp $(V5_SRC) tmp/v5/ -r
	sed -i -e 's/{{apiversion}}/v5/g' tmp/v5/*
	NOCACHE=1 aglio -i tmp/v5/parku.apib -o $(BUILD_DIR)/$(PAGE_V5).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

# Build v4 and v5
generate: $(BUILD_DIR)/$(PAGE_V4).html $(BUILD_DIR)/$(PAGE_V5).html

# directory targets
$(GENERATED_DIR):
	mkdir $(GENERATED_DIR) -p

./tmp:
	mkdir tmp -p

$(BUILD_DIR):
	mkdir $(BUILD_DIR) -p

$(BUILD_DIR)/images/*: |images/* $(BUILD_DIR)
	cp images $(BUILD_DIR)/images -r

$(GENERATED_DIR)/%.apib: ./tmp ./$(GENERATED_DIR) v4/*
	cat tmp/$*/!(parku*).apib > $@

$(GENERATED_DIR)/%.swagger.json: $(GENERATED_DIR)/%.apib
	apib2swagger -i $(GENERATED_DIR)/$*.apib -o $@

# Docker targets
dev-docs-docker-image:
		docker build -t parku-dev-docs .

all-in-docker: dev-docs-docker-image
	docker run -v `pwd`:/docs -it parku-dev-docs /bin/bash -c 'cd /docs && make all'

clean-in-docker: dev-docs-docker-image
	docker run -v `pwd`:/docs -it parku-dev-docs /bin/bash -c 'cd /docs && make clean'

publish: all
	$(eval GIT_COMMIT:=`git rev-parse HEAD`)
	rm -rf $(PUBLISH_TO_BRANCH)
	git clone -b $(PUBLISH_TO_BRANCH) git@github.com:parku/docs.git $(PUBLISH_TO_BRANCH)
	rm -rf $(PUBLISH_TO_BRANCH)/*
	cp $(BUILD_DIR)/* -r $(PUBLISH_TO_BRANCH)/
	cd gh-pages && git add . && git commit -m "Updated documentation from commit $(GIT_COMMIT)"
