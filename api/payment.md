---
layout: page
categories: ["API"]
title: Payment
---

# Payment

All API requests to `https://api.parku.ch/v4/payment` need a __private key__.

## List Credit Cards

Requests shows all credit cards the user used before.

```sh
$ curl {{ site.parku.api }}/payment/creditcards \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
```json
[
    {
        "id": "gphsyb",
        "type": "Visa",
        "number": "400934******1881",
        "expiration_date": "05/2020",
        "image_url": "https://assets.braintreegateway.com/payment_method_logo/visa.png?environment=sandbox&merchant_id=8fbxty8dhjmy8g4j"
    },
    {
        "id": "6tvts6",
        "type": "Visa",
        "number": "411111******1111",
        "expiration_date": "01/2014",
        "image_url": "https://assets.braintreegateway.com/payment_method_logo/visa.png?environment=sandbox&merchant_id=8fbxty8dhjmy8g4j"
    }
]
```

### HTTP Request

`GET {{ site.parku.api }}/payment/creditcards`
