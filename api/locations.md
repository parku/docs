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
    "type": "off-street",
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
    "pricing": {
    	"rate_hourly": 2,
    	"rate_daily": 10,
    	"rate_weekly": null,
    	"rate_monthly": null
  	},
    "price_period": "day",
    "address_slug": "hopfenstrasse-20",
    "user_owned": false,
    "provider": "providerkey",
    "settings": {
        "bookable_range_start": -15,
        "bookable_range_end": 43200,
        "booking_duration_min": 30,
        "booking_duration_max": 43200
    },
    "required_fields": [
        "additional_services",
        "car_colour",
        "number_of_passengers"
    ]
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

Available parking space types are:

* `off-street` Off-Street parking space. _Default_
* `park-and-ride` Park & Ride (P+R)
* `professional-garage` Professional garage
* `airport-parking` Airport-Parking
* `harbor-parking` Harbor-Parking

Available options for a parking space are:

* `excess length` The parking space can be used by cars with a small trailer.
* `indoor` The parking space has a roof or can be an underground garage.
* `disabled` Parking space is accessible for disabled people.
* `patio` The parking space is located at an inner courtyard.
* `barrier` Parking space has a barrier and user needs a smartphone to open it.
* `charging station` Parking space with an electric vehicle charging station.
* `key_necessary` Parking space can only be accessed with a key.
* `long_term_booking` Parking space is bookable for longer time period.
* `surveillance` Parking space has surveillance.
* `valet_service` Parking space contains valet service.

`user_owned` is `true` if the user who requested the location is also the owner of the parking space. This allows the web and the apps to determine if the user could block the parking space from bookings. The blocking feature itself is not yet supported in APIv4.

`price` and `price_period`: The `price` is the actual price shown to the user. The `price_period` contains the period for how long the price is valid:

* `day`
* `week`
* `month`
* `timeframe`

`pricing` contains information about the pricing and price prediction. It contains the keys:

* `rate_hourly`
* `rate_daily`
* `rate_weekly`
* `rate_monthly`

If the pricing does not rely on these values, but on a custom price pattern, all these values will be `null`.

The `settings` node provides the booking requirements for a location:

* `bookable_range_start`: start of the range wherein a booking is allowed in minutes from now.
* `bookable_range_end`: end of the range wherein a booking is allowed in minutes from now.
* `booking_duration_min`: minimum duration of a booking in minutes.
* `booking_duration_max`: maximum duration of a booking in minutes.

The settings of a location are used in favor of the global settings that can be found in the settings endpoint.

`required_fields` lists all additionally required fields when creating a booking for this location.
The field names correspond to the `booking.fields.*` entries in the settings endpoint.

`provider` node informs about parking space provider. Additional information for the provider can be using the same key in [settings](/api/settings/)

## Get availability times for location

```sh
$ curl {{ site.parku.api }}/locations/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/availability \
        ?date_start=2016-04-12 \
        &date_end=2016-04-14 \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```json
{
    "begin": "2016-04-09T00:00:00+02:00",
    "end": "2016-04-18T00:00:00+02:00",
    "weekday_1": [{
      "start": "08:00",
      "end": "17:00"
    }],
    "weekday_2": [{
      "start": "08:00",
      "end": "17:00"
    }],
    "weekday_3": [{
      "start": "08:00",
      "end": "16:00"
    }],
    "weekday_4": [{
      "start": "08:00",
      "end": "16:00"
    }],
    "weekday_5": [{
      "start": "08:00",
      "end": "18:00"
    }],
    "weekday_6": [{
      "start": "08:00",
      "end": "17:00"
    }],
    "weekday_7": [{
      "start": "08:00",
      "end": "17:00"
    }]
}
```

### HTTP Request

`GET {{ site.parku.api }}/locations/:location_id/availability`

### Parameters

Parameter | Description
--- | ---
`location_id` | Identifier of the location. __Required__
`date_start` | Start of time frame to include periods. If date_start is provided, date_end is required and vice versa. _Optional_
`date_end` | End of time frame, so that periods are included. _Optional_

### Return values

Displays the availability times. For every affected availability period there will be one entry in the json. This sub json contains 9 keys, one for every weekday including the day's times and also the period start and end.

__Caution:__ This does not include bookings

A period is affected, if one of the following holds:

* `date_start` is between period start and period end
* `date_end` is between period start and end
* `date_start and date_end overlay the period

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
        "pricing": {
    		"rate_hourly": 2,
    		"rate_daily": 10,
    		"rate_weekly": null,
    		"rate_monthly": null
  		},
        "price_period": "week",
        "address_slug": "hopfenstrasse-20",
        "user_owned": false,
        "provider": "parku",
        "settings": {
            "bookable_range_start": -15,
            "bookable_range_end": 43200,
            "booking_duration_min": 30,
            "booking_duration_max": 43200
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
