---
layout: page
categories: ["API"]
title: Voucher
---

# Voucher

All API requests to `https://api.parku.ch/v4/voucher` need a __private key__.

## Redeem Voucher

```sh
$ curl {{ site.parku.api }}/voucher \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -d voucher=parkieren12
```

> Response

```nginx
Status: 200 OK
```
```json
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

### HTTP Request

`PUT {{ site.parku.api }}/voucher`

### Parameters

Parameter    | Description
---          | ---
`voucher`    | __Required.__
`device_id`  | The ID of the mobile device (usually the IMEI) when voucher code can only be used once per device. _Optional._
