BUILD_DIR=.
COMMON_DEPS=$(BUILD_DIR)/images/* Makefile theme/*
PAGE_V4=index
PAGE_V5=v5

all: generate

generate-v4: $(BUILD_DIR)/$(PAGE_V4).html

generate-v5: $(BUILD_DIR)/$(PAGE_V5).html

$(BUILD_DIR)/$(PAGE_V4).html: $(COMMON_DEPS) v4/*
	mkdir -p tmp/
	cp v4 tmp/ -r
	sed -i -e 's/{{apiversion}}/v4/g' tmp/**/*
	NOCACHE=1 aglio -i tmp/v4/parku.apib -o $(BUILD_DIR)/$(PAGE_V4).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose

$(BUILD_DIR)/$(PAGE_V5).html: $(COMMON_DEPS) v4/* v5/*
	mkdir -p tmp/
	cp v4 tmp/ -r
	cp v5 tmp/ -r
	sed -i -e 's/{{apiversion}}/v5/g' tmp/**/*
	NOCACHE=1 aglio -i tmp/v5/parku.apib -o $(BUILD_DIR)/$(PAGE_V5).html --theme w00tw00t --theme-variables theme/variables-parku.less --theme-style theme/layout-parku.less --theme-full-width --theme-template triple --verbose
	rm -r tmp/

generate: $(BUILD_DIR)/$(PAGE_V4).html $(BUILD_DIR)/$(PAGE_V5).html

clean:
	rm -rf index.html v5.html
