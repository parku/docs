---
layout: api
title: Login
---

Checks the given credentials _email_ and _password_ for validity. Returns the user object with a user token needed for private endpoints. A _public key_ is needed.

### Definition

```
POST {{ site.parku.api }}/login
```

### Arguments

* __email__ _required_
  The users email address.
* __password__ _required_
  The users password.

### Example Request

```sh
$ curl {{ site.parku.api }}/login \
  -u 6f1ed002ab5595859014ebf0951522d9: \
  -d email=test@example.com \
  -d password=1234pwd
```

### Example Response

```json
{
  "gender": "male",
  "email": "test@example.com",
  "firstname": "Firstname",
  "lastname": "Lastname",
  "credit": 106.50,
  "currency": "CHF",
  "country": "CH",
  "facebook_id": "100006987966349",
  "token": "ce35e3504183c2f52f58263ce11004e0"
}
```

All further requests using the token as [HTTP Basic Auth][HTTP Basic Auth] username are made on behalf of the user.

  [HTTP Basic Auth]: http://en.wikipedia.org/wiki/Basic_access_authentication
