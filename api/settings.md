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
The location object provides the booking requirements. These include the minimum and maximum start-time and the minimum and maximum duration of a booking.
All values are in minutes and the minimum and maximum start-time need to be calculated in minutes from now.

Every location can have it's own settings but these will always be the same or within the limits of the global settings.

### HTTP Request

`GET {{ site.parku.api }}/settings`

### Parameters

None.
