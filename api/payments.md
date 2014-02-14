---
layout: api
title: Payments
---

After [creating a booking][booking] or updating the [users credit][credit] we need some informations about the payment. The payment is usually done through an external provider (PayPal, etc.).

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
* __reference\_id__ _required_<br/>
  The reference id from the provider. This ID is used to validate the payment.
* __provider\_info__ _optional_<br/>
  All additional information you get returned from the payment provider. For some providers more information than the reference_id are needed.
* __booking\_id__ _optional_<br/>
  Add the booking_id when the payment was for a booking. If no booking_id is submitted, the amount will be added to the users credit.

### Example Request

```sh
$ curl {{ site.parku.api }}/payment \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X POST \
    -d method=paypal \
    -d amount=12.50 \
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
  [credit]:   /api/credit/