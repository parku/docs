---
layout: api
title: Password
---

* [Update password](#update)
* [Reset password](#reset)

## <a name="update"></a>Update password

The request for updating the users password needs a _private key_.

### Definition

````nginx
PUT {{ site.parku.api }}/password
````

### Arguments

* __old\_password__ _required_<br/>
  The current active password.
* __new\_password__ _required_<br/>
  The new password.

### Example Request

```sh
$ curl {{ site.parku.api }}/password \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -d old_password=pwd123 \
    -d new_password=pwd321
```

### Example Response

```nginx
Status: 204 No Content
```

```

```


## <a name="reset"></a>Reset password

Resetting the users password needs a _public key_. If the given email address is not found in the database the `Status: 404 Not Found` gets returned.

This sends an email with the newly set password to the users email address.

### Definition

````nginx
GET {{ site.parku.api }}/password?for=test@example.com
````

### Arguments

* __for__ _required_<br/>
  A valid email address of the user.

### Example Request

```sh
$ curl {{ site.parku.api }}/password?for=test@example.com \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

```nginx
Status: 204 No Content
```

```

```
