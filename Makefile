# shell modification for wild cards
SHELL=/bin/bash -O extglob -c

# output build files into current directory as github expects them in
# the root directory
BUILD_DIR=.
COMMON_DEPS=$(BUILD_DIR)/images/* Makefile theme/* ./tmp

 # current stable version gets index assigned
PAGE_V4=index
PAGE_V5=v5

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

all: generate generated/v4.apib generated/v4.swagger.json generated/v5.apib generated/v5.swagger.json

clean:
	rm -rf index.html v5.html generated tmp

# Build version v4 from v4 sources
$(BUILD_DIR)/$(PAGE_V4).html: $(COMMON_DEPS) v4/*
	mkdir tmp/v4 -p
	cp $(V4_SRC) tmp/v4/ -r
	sed -i -e 's/{{apiversion}}/v4/g' tmp/v4/*
	NOCACHE=1 aglio -i tmp/v4/parku.apib -o $(BUILD_DIR)/$(PAGE_V4).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

# Build version v5 from v5 sources
$(BUILD_DIR)/$(PAGE_V5).html: $(COMMON_DEPS) v4/* v5/*
	mkdir tmp/v5 -p
	cp $(V5_SRC) tmp/v5/ -r
	sed -i -e 's/{{apiversion}}/v5/g' tmp/v5/*
	NOCACHE=1 aglio -i tmp/v5/parku.apib -o $(BUILD_DIR)/$(PAGE_V5).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

# Build v4 and v5
generate: $(BUILD_DIR)/$(PAGE_V4).html $(BUILD_DIR)/$(PAGE_V5).html

# directory targets
./generated:
	mkdir generated -p

./tmp:
	mkdir tmp -p

generated/%.apib: ./tmp ./generated v4/*
	cat tmp/$*/!(parku*).apib > $@

generated/%.swagger.json: generated/%.apib
	apib2swagger -i generated/$*.apib -o $@

# Docker targets
dev-docs-docker-image:
		docker build -t parku-dev-docs .

all-in-docker: dev-docs-docker-image
	docker run -v `pwd`:/docs -it parku-dev-docs /bin/bash -c 'cd /docs && make all'

clean-in-docker: dev-docs-docker-image
	docker run -v `pwd`:/docs -it parku-dev-docs /bin/bash -c 'cd /docs && make clean'
