---
layout: page
categories: ["API"]
title: Static Pages
---

# Static Pages

The terms and conditions, imprint and privacy policy are static pages for which you have to do a server request.

All requests to these pages need at least a _public key_.

## Terms and Conditions

```sh
$ curl {{ site.parku.api }}/terms \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"...

```

### HTTP Request

`GET {{ site.parku.api }}/terms`


## Imprint

```sh
$ curl {{ site.parku.api }}/imprint \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"...

```

### HTTP Request

`GET {{ site.parku.api }}/imprint`


## Privacy Policy

```sh
$ curl {{ site.parku.api }}/privacy_policy \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"...

```

### HTTP Request

`GET {{ site.parku.api }}/privacy_policy`
