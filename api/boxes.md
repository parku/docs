---
layout: page
categories: ["API"]
title: Boxes
---

# Boxes

All API requests to `{{ site.parku.api }}/boxes` need a __private key__.

## List all boxes

```sh
$ curl {{ site.parku.api }}/boxes \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "beacons": [
    "6544A9B4-8539-41F9-9D0A-7FE15566EE65",
    "67D9FC16-0EBD-4779-BED7-50800367EA7B"
  ],
  "services": [
    "FEFB",
    "BEA57"
  ],
  "identifiers": [
    {
      "identifier": "PARKU121",
      "device": "PRK-297"
    },
    {
      "identifier": "PARKU3KU",
      "device": "PRK-238"
    },
    {
      "identifier": "6544A9B4-8539-41F9-9D0A-7FE15566EE65:34:1F",
      "device": "PRK-238"
    }
  ]
}
```

### HTTP Request

`GET {{ site.parku.api }}/boxes`

Request will return a list of all bluetooth services and boxes.

### What do I get

The _beacons_ directive contains all UUIDs that are used by our beacons. _Services_ are the UUIDs exposed by our sesam boxes. _Identifiers_ list all devices available.

### How to implement it

The result might contain a long list of boxes. Please call this endpoint only _once a day_.

The app can scan for all beacons with the given UUIDs. If one was found, the major and minor should be validated against the list of identifiers. The format is `[UUID]:[major]:[minor]`. The associated device should used for the bluetooth connection.

When the app is running and bluetooth is active, start scanning for bluetooth devices that expose the given services (named _services_ in the JSON response). When the app found a few devices, start looking for the nearest devices and check the result, whether the exposed bluetooth name is in the result list (named _device_ in the JSON response).

If one device is found that is listed in the JSON response, connect to it using the custom format we agreed on.
