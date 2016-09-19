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
    "street": "Hopfenstrasse",
    "street_number": "20",
    "postcode": "8045",
    "city": "Zürich",
    "country": "CH",
    "bookable": true,
    "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
    "type": "off-street",
    "code": "ZHRTHW",
    "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
    "latitude": 52.505681,
    "longitude": 13.303608,
    "image_urls": [
        "https://parku.de/images/parkingspace/020a81f5-c8b9-11e4-bfd2-d43d7eece658/640x286.jpg"
    ],
    "options": [
        "excess length", "indoor", "disabled", "patio", "barrier"
    ],
    "support": {
        "phone_number": "+41 43 928 72 52"
    },
    "notifications": [],
    "currency": "EUR",
    "price": 3.5,
    "price_period": "timeframe",
    "pricing": {
        "rate_hourly": 2,
        "rate_daily": 10,
        "rate_weekly": null,
        "rate_monthly": null
    },
    "address_slug": "hopfenstrasse-20",
    "user_owned": false,
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
    ],
    "provider": "parku",
    "availability": {
        "current": 13,
        "maximum": 15,
        "next_start": "2016-09-12T03:45:00+02:00",
        "next_end": "2016-10-13T04:00:00+02:00"
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

#### HTTP Codes
Code | Description
---- | -----
200  | location found, body contains description
404  | location was not found, check the location id and that your user has the correct access rights to see the location
422  | request validation failed because the request data was malformed

#### Body
Field             | Element                | Type         | (Element and) Description
----------------- | ---------------------- | ------------ | -----
`address_slug`    |                        | `string`     | street name and number of the location in url address format
`availability`    |                        | `dictionary` | describes the availability of the location in relation to the request
                  | `current`              | `number`     | the number of parking spaces available at the location for the requested time period defined by `start` and `end`
                  | `maximum`              | `number`     | the overall number of parking spaces at this location
                  | `next_start`           | `time`       | the start of the next from now slot in which a parking space in this location is free and bookable, can be in the past
                  | `next_end`             | `time`       | the end of the next slot from now in which a parking space in this location is free and bookable, can be in the past
`bookable`        |                        | `boolean`    | `true` if that locations can be booked via the parku API, `false` if the location is purely providing information
`city`            |                        | `string`     | city of the location
`code`            |                        | `string`     | short identification code of the location, not necessarily unique
`country`         |                        | `string`     | country of the location in 2 character encoding
`currency`        |                        | `string`     | the currency that the price for the location is in, `EUR` for Euro or `CHF` for swiss franc.
`description`     |                        | `string`     | the description of the location. The description is returned in the users language or in the language specified by the HTTP header `Accept-Language` if it was given.
`id`              |                        | `rfc4122`    | unique identifier of the location used for referencing.
`image_urls`      |                        | `list`       | urls of location images, can be **empty**
`latitude`        |                        | `decimal`    | latitude part of the location geo coordinate
`longitude`       |                        | `decimal`    | longitude part of the location geo
`notification`    |                        | `list`       | *deprecated* usually empty, ignore
`options`         |                        | `list`       | describes which options are available at the location and can contains each of the following elements. The list can be **empty**.
                  | `excess length`        |              | the parking space can be used by cars with a small trailer
                  | `indoor`               |              | the parking space has a roof or can be an underground garage
                  | `disabled`             |              | parking space is accessible for disabled people
                  | `patio`                |              | the parking space is located at an inner courtyard
                  | `barrier`              |              | parking space has a barrier and user needs a smartphone to open it
                  | `charging station`     |              | parking space with an electric vehicle charging station
                  | `key_necessary`        |              | parking space can only be accessed with a key
                  | `long_term_booking`    |              | parking space is bookable for longer time period
                  | `surveillance`         |              | parking space has surveillance
                  | `valet_service`        |              | parking space contains valet service
`price`           |                        | `decimal`    | the actual price shown to the user, can be **null** if `start` or `end` were not provided
`price_period`    |                        | `string`     | contains the period for how long the price is valid, can be `day`, `week`, `month`, `timeframe`, can be **null** if `start` or `end` was not provided
`pricing`         |                        | `dictionary` | contains information about the pricing and price prediction. It contains the keys
                  | `rate_hourly`          | `decimal`    | shows the price for per hour
                  | `rate_daily`           | `decimal`    | shows the price per day
                  | `rate_weekly`          | `decimal`    | shows the price per week
                  | `rate_monthly`         | `decimal`    | shows the price per month
`post_code`       |                        | `string`     | post code of the location
`provider`        |                        | `string`     | names the parking space provider. Additional information(terms and conditions, logo, ...) about the provider can found be using the provider key from the field in [settings](/api/settings/)
`required_fields` |                        | `list`       | lists all additionally required fields when creating a booking for this location, can be **empty** if no fields are required. The field names correspond to the `booking.fields.*` entries in the settings endpoint which can be used for retrieving translated strings for these fields.
`settings`        |                        | `dictionary` | provides booking requirements for the location. The settings of a location are used in favor of the global settings that can be found in the settings endpoint.
                  | `bookable_range_start` | `number`     | start of the range wherein a booking is allowed in minutes from now.
                  | `bookable_range_end`   | `number`     | end of the range wherein a booking is allowed in minutes from now.
                  | `booking_duration_min` | `number`     | minimum duration of a booking in minutes.
                  | `booking_duration_max` | `number`     | maximum duration of a booking in minutes.
`street`          |                        | `string`     | the street name of the location without number
`street_number`   |                        | `string`     | the street number of the location
`support`         |                        | `dictionary` | contains field `phone_number` that returns the support center phone number for this location
`type`            |                        | `string`      | describes the type of location and can be one of the following
                  | `off-street`           |              | Off-Street parking space. _Default_
                  | `park-and-ride`        |              | Park & Ride (P+R)
                  | `professional-garage`  |              | Professional garage
                  | `airport-parking`      |              | Airport-Parking
                  | `harbor-parking`       |              | Harbor-Parking
`user_owned`      |                        | `boolean`    | `true` if the user who requested the location is also the owner of the parking space. This allows to determine if the user could block the parking space from bookings. The blocking feature itself is not yet supported in API.




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
        "street": "Hopfenstrasse",
        "street_number": "20",
        "postcode": "8045",
        "city": "Zürich",
        "country": "CH",
        "bookable": true,
        "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
        "type": "off-street",
        "code": "ZHRTHW",
        "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
        "latitude": 52.505681,
        "longitude": 13.303608,
        "image_urls": [
            "https://parku.de/images/parkingspace/020a81f5-c8b9-11e4-bfd2-d43d7eece658/640x286.jpg"
        ],
        "options": [
            "excess length", "indoor", "disabled", "patio", "barrier"
        ],
        "support": {
            "phone_number": "+41 43 928 72 52"
        },
        "notifications": [],
        "currency": "EUR",
        "price": 3.5,
        "price_period": "timeframe",
        "pricing": {
            "rate_hourly": 2,
            "rate_daily": 10,
            "rate_weekly": null,
            "rate_monthly": null
        },
        "address_slug": "hopfenstrasse-20",
        "user_owned": false,
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
        ],
        "provider": "parku",
        "availability": {
            "current": 13,
            "maximum": 15,
            "next_start": "2016-09-12T03:45:00+02:00",
            "next_end": "2016-10-13T04:00:00+02:00"
        }
    },
    { ... },
    { ... }
]
```

### HTTP Request

`GET {{ site.parku.api }}/locations`

### Parameters

Parameter      | Value      | Description
-------------- | ---------- | ----
`sw`           | `decimal`  | Comma separated latitude and longitude of the southwest position. _Required_.
`ne`           | `decimal`  | Comma separated latitude and longitude of the northeast position. _Required_.
`date_start`   | `datetime` | Filter parking spaces for the start date. `date_start` will have no effect unless `date_end` is also provided. _Optional._
`date_end`     | `datetime` | Filter parking spaces for the end date. `date_end` will have no effect unless `date_start` is also provided. _Optional._
`availability` | `string`   | Filters returned locations regarding their availability if `start` and `end` are also given. Can be:
               | `"true"`   | only returns available locations (this is default if `availability` is not specified and `start` and `end` were given)
               | `"false"`  | only returns non-available locations
               | `"all"`    | return all locations, including ones that no availability information is available for
`bookability`  | `string`   | Filters returned locations regarding their general bookability. Can be:
               | `"true"`   | only returns locations that could be booked through the api if they are available ( _DEFAULT_)
               | `"false"`  | only returns locations that can not be booked through the api, even though they might be available
               | `"all"`    | return all locations, no matter if they would be bookable though the API or not

When no `date_start` or `date_end` was provided, all locations are returned. That does not mean, that they are available.

### Return values

Returns a list of locations that provide the same format as the single location.

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
