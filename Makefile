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
	authentication.apib \
	bookings.apib \
	cars.apib \
	changelog.md \
	coupon.apib \
	devices.apib \
	errors.apib \
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
	voucher.apib \
	types.apib)

# files to use for building v5
V5_SRC:= \
	v5/parku.apib \
	v5/types.apib \
	v5/attributes.apib \
	v4/authentication.apib \
	v5/bookings.apib \
	v4/cars.apib \
	v4/changelog.md \
	v4/coupon.apib \
	v4/devices.apib \
	v4/errors.apib \
	v4/facebook.apib \
	v4/invitations.apib \
	v5/locations.apib \
	v4/login.apib \
	v5/onstreet.apib \
	v5/orders.apib \
	v4/password.apib \
	v5/payment.apib \
	v4/phone_numbers.apib \
	v4/sesam.apib \
	v4/settings.apib \
	v4/static_pages.apib \
	v5/user.apib \
	v4/violations.apib

all: generate $(GENERATED_DIR)/v4.swagger.json $(GENERATED_DIR)/v5.swagger.json meta-files

clean:
	rm -rf $(GENERATED_DIR) $(BUILD_DIR) $(PUBLISH_TO_BRANCH) tmp

meta-files: CNAME robots_allow.txt robots.txt | $(BUILD_DIR)
	cp CNAME robots.txt robots_allow.txt build

# Build version v4 from v4 sources
$(BUILD_DIR)/$(PAGE_V4).html: $(GENERATED_DIR)/v4.apib  $(COMMON_DEPS)
	NOCACHE=1 aglio -i $(GENERATED_DIR)/v4.apib -o $(BUILD_DIR)/$(PAGE_V4).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

# Build version v5 from v5 sources
$(BUILD_DIR)/$(PAGE_V5).html: $(GENERATED_DIR)/v5.apib $(COMMON_DEPS)
	NOCACHE=1 aglio -i $(GENERATED_DIR)/v5.apib -o $(BUILD_DIR)/$(PAGE_V5).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

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

$(GENERATED_DIR)/v4.apib: ./tmp ./$(GENERATED_DIR) v4/*
	mkdir tmp/v4 -p
	cp $(V4_SRC) tmp/v4/ -r
	sed -i -e 's/{{apiversion}}/v4/g' tmp/v4/*
	cat $(addprefix tmp/, $(V4_SRC)) > $@

$(GENERATED_DIR)/v5.apib: ./tmp ./$(GENERATED_DIR) v5/*
	mkdir tmp/v5 -p
	cp $(V5_SRC) tmp/v5/ -r
	sed -i -e 's/{{apiversion}}/v5/g' tmp/v5/*
	cat $(addprefix tmp/, $(V5_SRC)) > $@

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
