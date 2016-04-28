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
  },
  "gps": {
    "ttl": 60,
    "accuracy": 1000
  },
  "booking": {
    "collection": {
      "ttl": 60
    },
    "notification": {
      "time_to_leave": {
        "enabled": true,
        "type": "time",
        "time": {
          "minutes": -5,
          "relative_to": "begin",
          "include_distance": true
        }
      },
      "near_location": {
        "enabled": true,
        "type": "region",
        "radius": 500
      },
      "near_entry": {
        "enabled": true,
        "type": "region",
        "radius": 50
      },
      "expiring": {
        "enabled": true,
        "type": "time",
        "time": {
          "minutes": -10,
          "relative_to": "end",
          "include_distance": false
        }
      },
      "over": {
        "enabled": true,
        "type": "time",
        "time": {
          "minutes": -2,
          "relative_to": "end",
          "include_distance": false
        }
      }
    },
    "fields": {
      "additional_services": {
        "label": "zusätzliche Dienste"
      },
      "car_colour": {
        "label": "Fahrzeugfarbe"
      },
      "car_model": {
        "label": "Fahrzeugmodell"
      }
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

Every location can have its own settings but these will always be the same or within the limits of the global settings.

The **sesam** node contains informations about how to work with the sesam boxes.

* `connection_trials` Amount of tries to connect to a sesam box.
* `connection_timeout` Amount of seconds allowed to connect to a box.
* `communication_timeout` Second until canceling the communication with the sesam box.

The **gps** node contains information on how to handle GPS data.

* `ttl` Time-To-Live for previously retrieved GPS data i.e. by operation system
* `accuracy` Accuracy of GPS data in meters, renders data invalid if exceeded

The **booking** node contains information on how to handle bookings.

* `booking.collection.ttl` Time-To-Live for previously retrieved booking list
* `booking.notification.*` List of notifications and their settings.
* `booking.fields.*` List of additional fields that may be required to make a booking.

#### Notifications

Each notification contains a `enabled` flag.
If set to `true`, the notification is enabled and should appear.
If set to `false`, that notification is disabled.

Node            | Description
---             | ---
`time_to_leave` | _n_ `minutes` before to leave to get to a booking location.
`near_location` | Entering a region, defined by `radius` in meters around a booking location.
`near_entry`    | Entering a region, defined by `radius` in meters around a booking location.
`expiring`      | Shown _n_ `minutes` to a bookings ending.
`over`          | Shown _n_ `minutes` to a bookings ending.

#### Additional Fields

Each additional field uses its name as a key to a dictionary containing the field `label`.
`label` contains the translated name of the field.

## Enable or disable notification

The request needs a _private key_. A list of possible notifications are mentioned above.

```sh
$ curl {{ site.parku.api }}/settings/booking/notifiction/time_to_leave \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \  
    -d enabled=false
```

> Response

```nginx
Status: 204 No Content
```

### HTTP Request

`PUT {{ site.parku.api }}/settings/booking/notification/:notification_key`

### Parameters

Parameter          | Description
---                | ---
`notification_key` | A notification key, see list above __Required.__
`enabled`          | `true` or `false` __Required.__

### Response

If updated successfully, API returns `204 No Content` — if "posted" value didn't
change, it returns `304 Not Modified`.
