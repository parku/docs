---
layout: api
title: Payments
---

After [creating a booking][booking] or when updating the users credit we need some informations about the payment. The payment is usually done through an external provider (PayPal, etc.).

We need the information to verify the booking or credit charge. If no information is provided, the credit charge or the booking gets invalid.

## Create a payment

### Definition

```nginx
POST {{ site.parku.api }}/payment
```

### Arguments

The required arguments depends on the payment method.

#### Credit

* __method__=credit _required_
* __amount__ _required_<br/>
  The amount of the payment transaction. If the amount is greater than the booking price, the difference gets added to the credit.
* __currency__ _required_<br/>
  _CHF_ and _EUR_ are valid.
* __booking\_id__ _required_<br/>

#### PayPal / Creditcard

* __method__ _required_<br/>
  The payment method. Valid values are _creditcard_ or _paypal_.
* __amount__ _required_<br/>
  The amount of the payment transaction. If the amount is greater than the booking price, the difference gets added to the credit.
* __currency__ _required_<br/>
  _CHF_ and _EUR_ are valid.
* __provider\_info__ _required_<br/>
  All information you get returned from the payment provider. This is used for backend validation of the payment.
* __booking\_id__ _optional_<br/>
  Add the booking\_id when the payment was for a booking. If no booking\_id is submitted, the amount will be added to the users credit.

### Example Request

```sh
$ curl {{ site.parku.api }}/payment \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X POST \
    -d method=paypal \
    -d amount=12.50 \
    -d currency=EUR \
    -d reference_id=AP-123456789012345 \
    -d "provider_info={\"client\":{\"paypal...}}" \
    -d booking_id=0072c629-e622-11e2-8bf1-8a83f3373875
```

### Example Response

```nginx
Status: 204 No Content
```

```

```


  [booking]:  /api/bookings/
