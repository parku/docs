---
layout: api
title: Static Pages
---

The terms and conditions, imprint and privacy policy are static pages for which you have to do a server request.

* [Terms and Conditions](#terms)
* [Imprint](#imprint)
* [Privacy Policy](#privacy_policy)

All requests to these pages need at least a _public key_.

## <a name="terms"></a>Terms and Conditions

### Definition

```nginx
POST {{ site.parku.api }}/terms
```

### Example Request

```sh
$ curl {{ site.parku.api }}/terms \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

### Example Response

```nginx
Status: 200 OK
```

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"...

```

## <a name="imprint"></a>Imprint

### Definition

```nginx
POST {{ site.parku.api }}/imprint
```

### Example Request

```sh
$ curl {{ site.parku.api }}/imprint \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

### Example Response

```nginx
Status: 200 OK
```

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"...

```

## <a name="privacy_policy"></a>Privacy Policy

### Definition

```nginx
POST {{ site.parku.api }}/privacy_policy
```

### Example Request

```sh
$ curl {{ site.parku.api }}/privacy_policy \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

### Example Response

```nginx
Status: 200 OK
```

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"...

```
