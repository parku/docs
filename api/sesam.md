---
layout: page
categories: ["API"]
title: Sesam
---

# Sesam

All API requests to `https://api.parku.ch/v4/sesam` need a __private key__.

This endpoint is used to open gates and barriers. A _private key_ is needed. The user scans a QR code which is attached somewhere near the gate or barrier. The QR code contains an URL: _http://parku.ch/s/1234abcd_ or _http://parku.de/s/1234abcd_.

The part after the last / (slash) represents the sesam ID. You have to parse the URL and create an API call with the sesam ID.

![QR-code Example ch](http://chart.googleapis.com/chart?cht=qr&chs=247x247&chl=http://parku.ch/s/IHAFGJNL)

![QR-code Example de](http://chart.googleapis.com/chart?cht=qr&chs=247x247&chl=http://parku.de/s/E14EE6T7)

<style>img[alt="QR-code Example ch"] {float: right}</style>

_Both QR codes are valid and activate a sesam device in the parku office._


## Open Sesam

```sh
$ curl {{ site.parku.api }}/sesam/1234abcd \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 204 No Content
```
```

```

### HTTP Request

`PUT {{ site.parku.api }}/sesam/:sesam_id`

### Parameters

Parameter  | Description
---        | ---
`sesam_id` | The sesam ID which is hidden in the QR code. __Required.__


### Response

There are three possible responses:

1. `Status: 404 Not Found`<br>
   The QR code is not valid. Either it is not a parku QR code or the QR code is outdated.
2. `Status: 401 Unauthorized`<br>
   The code is valid, but the user does not have the permissions to use this sesam device. Either no booking is made or the time for opening the sesam has expired.
3. `Status: 204 No Content`<br>
   Everything went fine. The gate/barrier connected to the sesam device should open in the next few seconds.


## Sesam Available

Endpoint gives you the information whether the user can open a sesam device now or in the near future.

If a booking with a sesam device is available, the result will be `204 No Content` otherwise `404 Not Found`.

```sh
$ curl {{ site.parku.api }}/sesam \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 204 No Content
```

### HTTP Request

`GET {{ site.parku.api }}/sesam`
