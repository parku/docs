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


## Update Credit

Top up the credit of the user.

```sh
$ curl {{ site.parku.api }}/payment/creditcards \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -d amount=10 \
    -d currency=EUR \
    -d provider=braintree \
    -d provider_info[id]=6tvts6
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
  "credit": 10,
  "currency": "EUR",
  "country": "DE",
  "facebook_id": null,
  "token": "098f6bcd4621d373cade4e832627b4f6"
}
```

### HTTP Request

`PUT {{ site.parku.api }}/payment/credit`

### Parameters

Parameter      | Description
---            | ---
`amount`       | The amount. __Required.__
`currency`     | The currency. __Required.__
`provider`     | The payment method. Available options are _paypal_ and _braintree_. __Required.__
`provider_info`| The information of the payment provider to perform a payment. __Required.__ [See how to make a booking for more information using Braintree or PayPal.][payment-info]


  [payment-info]: /api/bookings/#toc_4
