---
layout: api
title: Facebook
---

There is currently only one endpoint available for Facebook.

## <a name="login"></a>Login

A _public key_ is required.

### Definition

````nginx
POST {{ site.parku.api }}/facebook/login
````

### Arguments

* __access\_token__ _required_<br/>
  The access token which is used to obtain information from Facebook. The token must have the permissions to get the users email.
* __country__ _required_<br/>
  The country of the user. Valid options are _DE_ and _CH_.

### Example Request

```sh
$ curl {{ site.parku.api }}/facekook/login \
    -u 6f1ed002ab5595859014ebf0951522d9:parku \
    -d country=DE \
    -d access_token=1234...
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "gender": "male",
  "email": "test@example.com",
  "firstname": "Firstname",
  "lastname": "Lastname",
  "credit": 0,
  "currency": "EUR",
  "country": "DE",
  "facebook_id": "100006987966349",
  "token": "ce35e3504183c2f52f58263ce11004e0"
}
```

All further requests using the token as [HTTP Basic Auth][HTTP Basic Auth] username are made on behalf of the user.

  [HTTP Basic Auth]: http://en.wikipedia.org/wiki/Basic_access_authentication
