---
layout: api
title: User
---

## Creating a User

Creates a new user object. A _public key_ is required.

### Definition

```
POST {{ site.parku.api }}/user
```

### Arguments

* __email__ _required_
* __password__ _required_
* __country__ _required_
  _DE_ or _CH_
* __firstname__ _required_
* __lastname__ _required_
* __gender__ _optional_
  _male_ or _female_

### Example Request

```sh
$ curl {{ site.parku.api }}/user \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
    -d email=test@example.com
    -d password=test
    -d country=DE
    -d firstname=Test
    -d lastname=Name
    -d gender=female
```

### Example Response

```json
{
  "gender": "female",
  "email": "test@example.com",
  "firstname": "Test",
  "lastname": "Name",
  "credit": 0,
  "currency": "EUR",
  "country": "DE",
  "facebook_id": null,
  "token": "098f6bcd4621d373cade4e832627b4f6"
}
```


## Retrieving a User

Returns the user object including the user token. A _private key_ is required.

### Definition

```
GET {{ site.parku.api }}/user
```

### Example Request

```sh
$ curl {{ site.parku.api }}/user \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
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
