---
layout: api
title: Locations
---

Get locations of parking spaces. A _public key_ is needed.

### Definition

```nginx
GET {{ site.parku.api }}/locations
```

### Arguments

* __sw__ _optional_<br/>
	Comma separated latitude and longitude of the southwest position.
* __ne__ _optional_<br/>
	Comma separated latitude and longitude of the northeast position.
* __date\_start__ _optional_<br/>
	Filter parking spaces for the start date.
* __date\_start__ _optional_<br/>
	Filter parking spaces for the end date.

If only one parameter of the pairs _ne_ - _sw_ or _date\_start_ - _date\_end_ is provided, the other parameter gets skipped.

If no parameter is given, all parking spaces are returned. Keep in mind, that some of them might not be available at the current time.

### Example Request

```sh
$ curl {{ site.parku.api }}/locations \
      ?sw=45.74001,5.67868 \
      &ne=47.74236,10.24900 \
      &date_start={{ site.time | date: '%Y-%m-%d' }} 10:00:00{{ site.time | date: '%z' }} \
      &date_end={{ site.time | date: '%Y-%m-%d' }} 16:30:00{{ site.time | date: '%z' }} \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

### Example Response

```nginx
Status: 200 OK
```

```json
[
  {
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
    },
    "price": 3.5
  },
  {...},
  {...}
]
```