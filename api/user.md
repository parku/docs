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
    -u 6f1ed002ab5595859014ebf0951522d9:parku \
    -d email=test@example.com \
    -d password=test \
    -d country=DE \
    -d firstname=Test \
    -d lastname=Name \
    -d gender=female
```

### Example Response

The newly created user object with private key gets returned.

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

Returns the user object for the private key. A _private key_ is required.

### Definition

```
GET {{ site.parku.api }}/user
```

### Example Request

```sh
$ curl {{ site.parku.api }}/user \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
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


## Updating a Customer

Updates the user by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

This request accepts mostly the same arguments as the user creation call.

### Definition

````
PUT {{ site.parku.api }}/user
````

### Arguments

* __email__ _optional_
* __password__ _optional_
* __country__ _optional_
  _DE_ or _CH_
* __firstname__ _optional_
* __lastname__ _optional_
* __gender__ _optional_
  _male_ or _female_

### Example Request

```sh
$ curl {{ site.parku.api }}/user \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
    -X PUT
    -d country=CH
```

### Example Response

```json
{
  "gender": "female",
  "email": "test@example.com",
  "firstname": "Test",
  "lastname": "Name",
  "credit": 0,
  "currency": "CHF",
  "country": "CH",
  "facebook_id": null,
  "token": "098f6bcd4621d373cade4e832627b4f6"
}
```
