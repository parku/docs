---
layout: page
categories: ["API"]
title: Locations
---

# Locations

All API requests to `{{ site.parku.api }}/locations` require at least a _public key_.

## Retrieve a Location

```sh
$ curl {{ site.parku.api }}/locations/00cd7cfd-e42d-11e2-8bf1-8a83f3373875 \
        ?date_start={{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }} \
        &date_end={{ site.time | date: '%Y-%m-%d' }}T16:30:00{{ site.time | date: '%z' }} \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```json
{
    "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
    "code": "ZHRTHW",
    "latitude": 47.365398,
    "longitude": 8.51987,
    "street": "Hopfenstrasse",
    "street_number": "20",
    "postcode": "8045",
    "city": "Zürich",
    "country": "CH",
    "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
    "image_urls": [
        "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image",
        "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image"
    ],
    "options": [
        "excess length", "indoor", "disabled", "patio", "barrier"
    ],
    "notifications": [],
    "currency": "CHF",
    "support": {
        "phone_number": "+41 43 928 72 52"
    },
    "price": 3.5,
    "price_period": "day",
    "address_slug": "hopfenstrasse-20",
    "user_owned": false,
    "settings": {
        "booking": {
            "start": {
                "min_minutes": -15,
                "max_minutes": 43170
            },
            "duration": {
                "min_minutes": 30,
                "max_minutes": 43170
            }
        }
    }
}
```

### HTTP Request

`GET {{ site.parku.api }}/locations/:location_id`

### Parameters

Parameter | Description
--- | ---
`location_id` | Identifier of the location. __Required__
`date_start` | Used to calculate the price for a location. Requires the field `date_end` to be defined. If no `date_start` or `date_end` is specified, the returned price field will be `null`. _Optional_
`date_end` | See `date_start`. _Optional_

### Return values

Available options for a parking space are:

* `excess length` The parking space can be used by cars with a small trailer.
* `indoor` The parking space has a roof or can be an underground garage.
* `disabled` Parking space is accessible for disabled people.
* `patio` The parking space is located at an inner courtyard.
* `barrier` Parking space has a barrier and user needs a smartphone to open it.
* `charging station` Parking space with an electric vehicle charging station.

`user_owned` is `true` if the user who requested the location is also the owner of the parking space. This allows the web and the apps to determine if the user could block the parking space from bookings. The blocking feature itself is not yet supported in APIv4.

`price` and `price_period`: The `price` is the actual price shown to the user. The `price_period` contains the period for how long the price is valid:

* `day`
* `week`
* `month`
* `timeframe`

`settings`: `booking` contains the minimum and maximum start-time and the minimum and maximum duration of a booking for this location.
All values are in minutes and the minimum and maximum start-time need to be calculated in minutes from now. The settings of a parking space are used in favor of the global settings that can be found in the settings endpoint.

## List Locations

```sh
$ curl {{ site.parku.api }}/locations \
        ?sw=45.74001,5.67868 \
        &ne=47.74236,10.24900 \
        &date_start={{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }} \
        &date_end={{ site.time | date: '%Y-%m-%d' }}T16:30:00{{ site.time | date: '%z' }} \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

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
        "country": "CH",
        "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
        "image_urls": [
            "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image",
            "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image"
        ],
        "options": [
            "excess length", "indoor", "disabled", "patio", "barrier"
        ],
        "notifications": [],
        "currency": "CHF",
        "support": {
            "phone_number": "+41 43 928 72 52"
        },
        "price": 3.5,
        "price_period": "week",
        "address_slug": "hopfenstrasse-20",
        "user_owned": false,
        "settings": {
            "booking": {
                "start": {
                    "min_minutes": -15,
                    "max_minutes": 43170
                },
                "duration": {
                    "min_minutes": 30,
                    "max_minutes": 43170
                }
            }
        }
    },
    {...},
    {...}
]
```

### HTTP Request

`GET {{ site.parku.api }}/locations`

### Parameters

Parameter | Description
--- | ---
`sw` | Comma separated latitude and longitude of the southwest position. _Required. Will become optional._
`ne` | Comma separated latitude and longitude of the northeast position. _Required. Will become optional._
`date_start` | Filter parking spaces for the start date. _Optional._
`date_end` | Filter parking spaces for the end date. _Optional._

When no `date_start` or `date_end` was provided, all locations are returned. That does not mean, that they are available.

## Terms and Conditions

Each location can have different terms and conditions. With this endpoint you can retrieve location based terms and conditions.

```sh
$ curl {{ site.parku.api }}/locations/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/terms \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"...

```

### HTTP Request

`GET {{ site.parku.api }}/locations/:location_id/terms`

### Parameters

Parameter		| Description
---					| ---
`location_id`| The location you like to retrieve the T&C for. __Required.__
