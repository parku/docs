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
  "services": ["FEFB"],
  "identifiers": [
    {
      "identifier": "PARKU121",
      "device": "0080254943ED"
    },
    {
      "identifier": "PARKU3KU",
      "device": "0080254943E5"
    }
  ]
}
```

### HTTP Request

`GET {{ site.parku.api }}/boxes`

Request will return a list of all bluetooth services and boxes.

### How to implement it

The result might contain a long list of boxes. Please call this endpoint only _once a day_.

When the app is running and bluetooth is active, start scanning for bluetooth devices that expose the given services (named _services_ in the JSON response). When the app found a few devices, start looking for the nearest devices and check the result, whether the exposed bluetooth name is in the result list (named _device_ in the JSON response).

If one device is found that is listed in the JSON response, connect to it using the custom format we agreed on.
