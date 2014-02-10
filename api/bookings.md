---
layout: api
title: Bookings
---

## Create a new booking

## Retrieve a booking

## Update a booking

## Cancel a booking

## List all bookings

Returns a list of the user's bookings. A _private key_ is required.

### Definition

```
GET {{ site.parku.api }}/bookings
```

### Arguments

* __count__ _optional_ - default is 10<br/>
  A limit on the number of objects to be returned. Count can range between 1 and 100 items.
* __offset__ _optional_ - default is 0<br/>
  An offset into the list of returned items. The API will return the requested number of items starting at that offset.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings?count=3 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

```json
[
  {
    "id": "0072c629-e622-11e2-8bf1-8a83f3373875",
    "car": {
      // ToDo
    },
    "location": {
      "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
      "code": "ZHRTHW",
      "latitude": 47.365398,
      "longitude": 8.51987,
      "street": "Hopfenstrasse",
      "street_number": "20",
      "postcode": "8045",
      "city": "Zürich",
      "country": "Switzerland",
      "sesam_use": false,
      "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
      "image_urls": [
        "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image",
        "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image"
      ],
      "options": [],
      "notifications": [],
      "currency": "CHF",
      "support": {
        "phone_number": "+41 43 928 72 52"
      }
    },
    "phone_number": {
      // ToDo
    },
    "reference": "HRS5J",
    "date_start": "2013-07-06 16:00:00+02:00",
    "date_end": "2013-07-07 00:00:00+02:00",
    "price": 13.75,
    "currency": "CHF"
  },
  {...},
  {...}
]
```