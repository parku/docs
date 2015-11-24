---
layout: page
categories: ["API"]
title: Settings
---

# Settings

All API requests to `https://api.parku.ch/v4/settings` need a __public key__ or a __private key__.

This endpoint exposes the global settings for the ParkU-platform.
Only requesting these settings is possible. Changing them is not.

## Retrieve settings

```sh
$ curl {{ site.parku.api }}/settings \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X GET
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "location": {
    "bookable_range_start": -15,
    "bookable_range_end": 43200,
    "booking_duration_min": 30,
    "booking_duration_max": 43200
  },
  "sesam": {
    "bluetooth": {
      "connection_trials": 2,
      "connection_timeout": 2,
      "communication_timeout": 2
    }
  }
}
```

### HTTP Request

`GET {{ site.parku.api }}/settings`

The **location** node provides the booking requirements for a parking space:

* `bookable_range_start`: start of the range wherein a booking is allowed in minutes from now.
* `bookable_range_end`: end of the range wherein a booking is allowed in minutes from now.
* `booking_duration_min`: minimum duration of a booking in minutes.
* `booking_duration_max`: maximum duration of a booking in minutes.

Every location can have it's own settings but these will always be the same or within the limits of the global settings.

The **sesam** node contains informations about how to work with the sesam boxes.

* `connection_trials` Amount of tries to connect to a sesam box.
* `connection_timeout` Amount of seconds allowed to connect to a box.
* `communication_timeout` Second until canceling the communication with the sesam box.
