---
layout: page
categories: ["API"]
title: Coupon
---

# Coupon

All API requests to `https://api.parku.ch/v4/coupon` need a __private key__.

## Validate a coupon

```sh
$ curl {{ site.parku.api }}/coupon/Zm9vYmFyMTIz \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X POST \
    -d amount=42
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "amount_requested": 42,
  "coupon_code": "foobar123",
  "coupon_type": "amount",
  "coupon_value": 10,
  "coupon_using": 10,
  "coupon_leftover": 0,
  "amount_leftover": 32
}
```

### HTTP Request

`PUT {{ site.parku.api }}/voucher/:encoded_code`

### Parameters

Parameter     | Description
---           | ---
`encoded_code`| __Required.__ A base64url encoded coupon code string

### Return values

Key               | Description
---               | ---
`amount_requested`| `amount` a coupon is validated against
`coupon_code`     | Decoded, sanitized coupon code
`coupon_type`     | Either `amount` or `discount`
`coupon_value`    | Coupons value
`coupon_using`    | Amount used of coupon value
`coupon_leftover` | Amount left of coupon value
`amount_leftover` | Amount left of originally, requested `amount`

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
10         | 422              | Form is not valid. Likely amount in body is missing.
20         | 404              | Coupon not found.
21         | 404              | Coupon is inactive.
22         | 404              | Coupon expired.
23         | 404              | Coupon date (start or end) prohibit coupon usage.
30         | 422              | Coupon quota exhausted.
31         | 422              | User usage quota for this coupon is exhausted.
32         | 422              | User usage quota for a coupon is same grouping is exhausted.
