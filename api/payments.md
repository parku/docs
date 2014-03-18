---
layout: api
title: Payments
---

After [creating a booking][booking] or when updating the users credit we need some informations about the payment. The payment is usually done through an external provider (PayPal, etc.).

We need the information to verify the booking or credit charge. If no information is provided, the credit charge or the booking gets invalid.

* [PayPal](#paypal)
* [Braintree](#braintree)
* [Credit](#credit)

## <a name="paypal"></a>PayPal

### Definition

```nginx
POST {{ site.parku.api }}/payment/paypal
```

### Arguments

* __amount__ _required_<br/>
  The amount of the payment transaction. If the amount is greater than the booking price, the difference gets added to the credit.
* __currency__ _required_<br/>
  _CHF_ and _EUR_ are valid.
* __provider\_info__ _required_<br/>
  All information you get returned from paypal. This is used for backend validation of the payment.
* __booking\_id__ _optional_<br/>
  Add the booking\_id when the payment was for a booking. If no booking\_id is submitted, the amount will be added to the users credit.

### Example Request

```sh
$ curl {{ site.parku.api }}/payment/paypal \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X POST \
    -d amount=12.50 \
    -d currency=EUR \
    -d "provider_info={\"client\":{\"paypal...}}" \
    -d booking_id=0072c629-e622-11e2-8bf1-8a83f3373875
```

### Example Response

```nginx
Status: 204 No Content
```

```

```

## <a name="braintree"></a>Braintree

### Definition

```nginx
POST {{ site.parku.api }}/payment/braintree
```

### Arguments

TBD

### Example Request

TBD

### Example Response

TBD


## <a name="credit"></a>Credit

If the credit is lower than the booking amount, the [error][error] `Status: 422 Unprocessable Entity` gets returned.

### Definition

```nginx
POST {{ site.parku.api }}/payment/credit
```

### Arguments

* __booking\_id__ _required_<br/>

### Example Request

```sh
$ curl {{ site.parku.api }}/payment/credit \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X POST \
    -d booking_id=0072c629-e622-11e2-8bf1-8a83f3373875
```

### Example Response

```nginx
Status: 204 No Content
```

```

```

  [booking]:  /api/bookings/
  [error]:    /api/#errors
