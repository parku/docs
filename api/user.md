---
layout: page
categories: ["API"]
title: User
---

# User

## Create a new user

Creates a new user object. A _public key_ is required.

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

> Response

```nginx
Status: 201 Created
Location: {{ site.parku.api }}/user
```
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

### HTTP Request

`POST {{ site.parku.api }}/user`

### Parameters

Parameter    | Description
---          | ---
`email`      | __Required.__
`password`   | __Required.__
`country`    | _DE_ or _CH_ __Required.__
`firstname`  | __Required.__
`lastname`   | __Required.__
`gender`     | _male_ or _female_. _Optional._


## Retrieve a user

Returns the user object for the private key. A _private key_ is required.

```sh
$ curl {{ site.parku.api }}/user \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
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
### HTTP Request

`GET {{ site.parku.api }}/user`


## Update a user

Updates the user by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

This request accepts mostly the same arguments as the user creation call. Changing the password is done through a [separate endpoint][password].

```sh
$ curl {{ site.parku.api }}/user \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -d country=CH
```

> Response

```nginx
Status: 200 OK
```
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

### HTTP Request

`PUT {{ site.parku.api }}/user`

### Parameters

Parameter    | Description
---          | ---
`email`      | _Optional._
`password`   | _Optional._
`country`    | _DE_ or _CH_ _Optional._
`firstname`  | _Optional._
`lastname`   | __Optional._
`gender`     | _male_ or _female_. _Optional._


  [password]: /api/password/
