---
layout: api
title: Payments
---

After [creating a booking][booking] or updating the [users credit][credit] we need some informations about the payment. The payment is usually done through an external provider (PayPal, etc.).

We need the information to verify the booking or credit. If no information is provided, the credit or the booking gets invalid.

## Create a payment

### Definition

```nginx
POST {{ site.parku.api }}/payment
```

### Arguments

The required arguments depends on the payment method. _Credit_ does not need any additional parameters other than _method_ and _amount_. _PayPal_ or _CreditCard_ needs all additional parameters.

* __method__ _required_<br/>
  The payment method. Valid values are _creditcard_, _paypal_ or _credit_.
* __amount__ _required_<br/>
  The amount of the payment transaction. If the amount is greater than the booking price, the difference gets added to the credit.
* __reference\_id__ _optional_<br/>
  The reference id from the provider. This ID is used to validate the payment.
* __provider\_info__ _optional_<br/>
  All additional information you get returned from the payment provider. For some providers more information than the reference_id are needed.
* __booking\_id__ _optional_<br/>
  Add the booking_id when the payment was for a booking. If no booking_id is submitted, the amount will be added to the users credit.

### Example Request

```sh
$ curl {{ site.parku.api }}/cars \
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