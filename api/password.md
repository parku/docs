---
layout: page
categories: ["API"]
title: Password
---

# Password

All API requests to `https://api.parku.ch/v4/password` need a __private key__.

## Update password

The request for updating the users password needs a _private key_.

```sh
$ curl {{ site.parku.api }}/password \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -d old_password=pwd123 \
    -d new_password=pwd321
```

> Response

```nginx
Status: 204 No Content
```
```

```

### HTTP Request

`PUT {{ site.parku.api }}/password`

### Parameters

Parameter      | Description
---            | ---
`old_password` | The current active password. __Required.__
`new_password` | The new password. __Required.__


## Reset password

Resetting the users password needs a _public key_. If the given email address is not found in the database the `Status: 404 Not Found` gets returned.

This sends an email with the newly set password to the users email address.

```sh
$ curl {{ site.parku.api }}/password?for=test@example.com \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 204 No Content
```
```

```


### HTTP Request

`GET {{ site.parku.api }}/password?for=test@example.com`

### Parameters

Parameter  | Description
---        | ---
`for`      | A valid email address of the user. __Required.__
