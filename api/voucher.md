---
layout: api
title: Voucher
---

### Definition

```nginx
PUT {{ site.parku.api }}/voucher
```

### Arguments

* __voucher__ _required_<br/>
* __device_id__ _optional_<br/>
  The ID of the mobile device (usually the IMEI) when voucher code can only be used once per device.

### Example Request

```sh
$ curl {{ site.parku.api }}/voucher \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -d voucher=parkieren12
```

### Example Response

```nginx
Status: 200 OK
```

```
{
  "gender": "female",
  "email": "test@example.com",
  "firstname": "Test",
  "lastname": "Name",
  "credit": 5.0,
  "currency": "EUR",
  "country": "DE",
  "facebook_id": null,
  "token": "098f6bcd4621d373cade4e832627b4f6"
}
```

