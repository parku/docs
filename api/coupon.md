---
layout: page
categories: ["API"]
title: Coupon
---

# Coupon

All API requests to `https://api.parku.ch/v4/coupon` need a __private key__.

## Test a coupon

```sh
$ curl {{ site.parku.api }}/coupon/Zm9vYmFyMTIz\?action\=test\&amount\=42 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### HTTP Request

`GET {{ site.parku.api }}/coupon/:encoded_code?action=test&amount=:amount`

### Parameters

Parameter     | Description
---           | ---
`encoded_code`| __Required.__ A base64url encoded coupon code string
`action`      | __Required.__ `test` will use amount and coupon code to test
`amount`      | __Required.__ Amount coupon has to be tested against

```nginx
Status: 200 OK
```
```json
{
  "code": "foobar123",
  "value": 10,
  "deduction": 10
}
```

### Response

Key               | Description
---               | ---
`code`            | Decoded, sanitized coupon code
`value`           | Coupons value
`deduction`       | Amount used of coupon value

### Errors

```nginx
Status: 422 Unprocessable Entity
```
```json
{
  "errors": [
    {
      "field": "coupon",
      "code": 31,
      "message": "Coupon usage exceeded."
    }
  ]
}
```

Error Code | HTTP Status Code | Description
---        | ---              | ---
10         | 422              | "amount" is faulty, probably below 0.
20         | 404              | Coupon not found.
21         | 404              | Coupon is inactive.
22         | 404              | Coupon expired.
23         | 404              | Coupon date (start or end) prohibit coupon usage.
30         | 422              | Coupon quota exhausted.
31         | 422              | User usage quota for this coupon is exhausted.
32         | 422              | User usage quota for a coupon is same grouping is exhausted.
40         | 422              | Platform (Android, iOS, web) is not enabled. Some coupons only work on specific a platform.
