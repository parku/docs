---
layout: page
categories: ["API"]
title: Bookings
---

# Bookings

All API requests to `https://api.parku.ch/v4/bookings` need a __private key__.

## Create a new booking

```sh
$ curl {{ site.parku.api }}/bookings \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d location_id=00cd7cfd-e42d-11e2-8bf1-8a83f3373875 \
    --data-urlencode license_plate="B-AB 1234" \
    --data-urlencode phone_number="+493057701873" \
    --data-urlencode date_start="{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}" \
    --data-urlencode date_end="{{ site.time | date: '%Y-%m-%d' }}T16:30:00{{ site.time | date: '%z' }}" \
    -d provider=paypal \
    --data-urlencode 'provider_info={
  "client": {
    "environment": "sandbox",
    "paypal_sdk_version": "2.0.1",
    "platform": "iOS",
    "product_name": "PayPal iOS SDK"
  },
  "response": {
    "create_time": "2014-03-31T12:51:14Z",
    "id": "PAY-1CM399047K4649003KM4WJQQ",
    "intent": "authorize",
    "state": "approved"
  },
  "response_type": "payment"
}'
```

> Response

```nginx
Status: 201 Created
Location: {{ site.parku.api }}/bookings/005c4826-4e28-11e3-a675-d43d7eece53d
```

```json
{
  "id": "005c4826-4e28-11e3-a675-d43d7eece53d",
  "license_plate": "B-AB 1234",
  "phone_number": "+493057701872",
  "location": {
    "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
    "code": "ZHRTHW",
    "latitude": 47.365398,
    "longitude": 8.51987,
    "street": "Hopfenstrasse",
    "street_number": "20",
    "postcode": "8045",
    "city": "Zürich",
    "country": "CH",
    "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
    "image_urls": [
      "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image",
      "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image"
    ],
    "options": [],
    "notifications": [],
    "currency": "CHF",
    "support": {
      "phone_number": "+41 43 928 72 52"
    }
  },
  "reference": "HRS5J",
  "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
  "date_end": "{{ site.time | date: '%Y-%m-%d' }}T16:30:00{{ site.time | date: '%z' }}",
  "price": 13.75,
  "currency": "CHF",
  "violation": null,
  "extend": [
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T17:00:00{{ site.time | date: '%z' }}",
      "price": 1.25,
      "currency": "CHF"
    },
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T17:30:00{{ site.time | date: '%z' }}",
      "price": 2.5,
      "currency": "CHF"
    },
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T18:30:00{{ site.time | date: '%z' }}",
      "price": 5,
      "currency": "CHF"
    },
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T19:30:00{{ site.time | date: '%z' }}",
      "price": 7.5,
      "currency": "CHF"
    },
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T21:30:00{{ site.time | date: '%z' }}",
      "price": 7.5,
      "currency": "CHF"
    }
  ]
}
```

### HTTP Request

`POST {{ site.parku.api }}/bookings`

### Parameters

Parameter      | Description
---            | ---
`location_id`  | The ID of the location you get returned from the [`locations`][locations] request. __Required.__
`date_start`   | [ISO 8601][iso-8601] format: `{{ site.time | date_to_xmlschema }}`.  __Required.__
`date_end`     | [ISO 8601][iso-8601] format: `{{ site.time | date_to_xmlschema }}`.  __Required.__
`license_plate`| The license_plate of the used car. Get all cars of a user from the [`cars`][cars] request. __Required.__
`phone_number` | The phone number. Get all phone numbers of a user from the [`phone_numbers`][phone_numbers] request. __Required.__
`provider`     | The payment method. Available options are _paypal_, _braintree_ or _credit_. __Required.__
`provider_info`| The information of the payment provider to perform a payment. __Required__ for payment methods _paypal_ and _braintree_.


## Retrieve a booking

Retrieves the details of an existing booking. You need only supply the unique booking identifier that was returned upon booking creation.

```sh
$ curl {{ site.parku.api }}/bookings/005c4826-4e28-11e3-a675-d43d7eece53d \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "id": "005c4826-4e28-11e3-a675-d43d7eece53d",
  "license_plate": "B-AB 1234",
  "phone_number": "+493057701872",
  "location": {
    "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
    "code": "ZHRTHW",
    "latitude": 47.365398,
    "longitude": 8.51987,
    "street": "Hopfenstrasse",
    "street_number": "20",
    "postcode": "8045",
    "city": "Zürich",
    "country": "CH",
    "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
    "image_urls": [
      "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image",
      "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image"
    ],
    "options": [],
    "notifications": [],
    "currency": "CHF",
    "support": {
      "phone_number": "+41 43 928 72 52"
    }
  },
  "reference": "HRS5J",
  "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
  "date_end": "{{ site.time | date: '%Y-%m-%d' }}T16:30:00{{ site.time | date: '%z' }}",
  "price": 13.75,
  "currency": "CHF",
  "violation": {
    "license_plate": "B-DC 4321",
    "comment": "This car parked on my parking space!!!",
    "image_url": "{{ site.parku.url }}/images/reports/12.jpeg"
  },
  "extend": [
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T17:00:00{{ site.time | date: '%z' }}",
      "price": 1.25,
      "currency": "CHF"
    },
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T17:30:00{{ site.time | date: '%z' }}",
      "price": 2.5,
      "currency": "CHF"
    },
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T18:30:00{{ site.time | date: '%z' }}",
      "price": 5,
      "currency": "CHF"
    },
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T19:30:00{{ site.time | date: '%z' }}",
      "price": 7.5,
      "currency": "CHF"
    },
    {
      "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
      "date_end": "{{ site.time | date: '%Y-%m-%d' }}T21:30:00{{ site.time | date: '%z' }}",
      "price": 7.5,
      "currency": "CHF"
    }
  ]
}
```

### HTTP Request

`GET {{ site.parku.api }}/bookings/:booking_id`

### Parameters

Parameter      | Description
---            | ---
`booking_id`   | The identifier of the booking to be retrieved. __Required.__


## Custom extend prices

Retrieving a booking returns a few prices for standard intervals. Use this endpoint for custom intervals.

```sh
$ curl {{ site.parku.api }}/bookings/005c4826-4e28-11e3-a675-d43d7eece53d/extend?date_end={{ site.time | date: '%Y-%m-%d' }}T17:45:00{{ site.time | date: '%z' }} \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
  "date_end": "{{ site.time | date: '%Y-%m-%d' }}T17:45:00{{ site.time | date: '%z' }}",
  "price": 3.15,
  "currency": "CHF"
}
```

### HTTP Request

`GET {{ site.parku.api }}/bookings/:booking_id/extend?date_end=:date_end`

### Parameters

Parameter      | Description
---            | ---
`booking_id`   | The identifier of the booking to be updated. __Required.__
`date_end`     | The customized datetime. __Required.__

If the booking cannot be extended for the given date, the HTTP status code `404` is returned.

## Update a booking

Updates the booking by setting the values of the parameters passes. Any parameter not provided will be left unchanges.

```sh
$ curl {{ site.parku.api }}/bookings \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    --data-urlencode license_plate="B-BC 4567" \
    --data-urlencode phone_number="+493057701871" \
    --data-urlencode date_end="{{ site.time | date: '%Y-%m-%d' }}T17:00:00{{ site.time | date: '%z' }}" \
    -d provider=credit
```

> Response

```nginx
Status: 200 OK
```

```json
{
  "id": "005c4826-4e28-11e3-a675-d43d7eece53d",
  "license_plate": "B-BC 4567",
  "phone_number": "+493057701871",
  "location": {
    "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
    "code": "ZHRTHW",
    "latitude": 47.365398,
    "longitude": 8.51987,
    "street": "Hopfenstrasse",
    "street_number": "20",
    "postcode": "8045",
    "city": "Zürich",
    "country": "CH",
    "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
    "image_urls": [
      "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image",
      "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image"
    ],
    "options": [],
    "notifications": [],
    "currency": "CHF",
    "support": {
      "phone_number": "+41 43 928 72 52"
    }
  },
  "reference": "HRS5J",
  "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
  "date_end": "{{ site.time | date: '%Y-%m-%d' }}T17:00:00{{ site.time | date: '%z' }}",
  "price": 13.75,
  "currency": "CHF",
  "violation": null
}
```

### HTTP Request

`PUT {{ site.parku.api }}/bookings/:booking_id`

### Parameters

Parameter      | Description
---            | ---
`booking_id`   | The identifier of the booking to be updated. __Required.__
`license_plate`| The license_plate of the used car.
`phone_number` | The phone number.
`date_end`     | The new datetime when extending the booking.
`provider`     | __Required__ when extending the booking.
`provider_info`| The information of the payment provider to perform a payment. __Required__ when extending a booking and for payment methods _paypal_ and _braintree_.


## Cancel a booking

Permanently cancels a booking. It cannot be undone.

```sh
$ curl {{ site.parku.api }}/bookings/005c4826-4e28-11e3-a675-d43d7eece53d \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X DELETE
```

> Response

```nginx
Status: 204 No Content
```

### HTTP Request

`DELETE {{ site.parku.api }}/bookings/:booking_id`

### Parameters

Parameter      | Description
---            | ---
`booking_id`   | The identifier of the booking to be canceled. __Required.__


## List all bookings

Returns a list of the user's bookings. A _private key_ is required.

```sh
$ curl {{ site.parku.api }}/bookings?count=3 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
```json
[
  {
    "id": "0072c629-e622-11e2-8bf1-8a83f3373875",
    "license_plate": "B-AB 1234",
    "location": {
      "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
      "code": "ZHRTHW",
      "latitude": 47.365398,
      "longitude": 8.51987,
      "street": "Hopfenstrasse",
      "street_number": "20",
      "postcode": "8045",
      "city": "Zürich",
      "country": "CH",
      "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
      "image_urls": [
        "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image",
        "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image"
      ],
      "options": [],
      "notifications": [],
      "currency": "CHF",
      "support": {
        "phone_number": "+41 43 928 72 52"
      }
    },
    "phone_number": "+493057701872",
    "reference": "HRS5J",
    "date_start": "{{ site.time | date: '%Y-%m-%d' }}T10:00:00{{ site.time | date: '%z' }}",
    e"date_end": "{{ site.time | date: '%Y-%m-%d' }}T16:30:00{{ site.time | date: '%z' }}",
    "price": 13.75,
    "currency": "CHF",
    "violation": null
  },
  {...},
  {...}
]
```

### HTTP Request

`GET {{ site.parku.api }}/bookings`

### Parameters

Parameter  | Description
---        | ---
`count`    | A limit on the number of objects to be returned. Count can range between 1 and 100 items. __Optional, default is 10.__
`offset`   | An offset into the list of returned items. The API will return the requested number of items starting at that offset. __Optional, default is 0.__

The result will be ordered by start and end date. The latest bookings will be first.


<!--

* [Update a booking](#update)
* [Cancel a booking](#cancel)
* [List all bookings](#list)

All API requests to `{{ site.parku.api }}/bookings` need a _private key_.


##  <a name="update"></a>Update a booking

Updates the booking by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

### Definition

```nginx
PUT {{ site.parku.api }}/bookings/:booking_id
```

### Arguments

* __car\_id__ _optional_<br/>
  The ID of the used car. Get all cars for the user from the [`cars`][cars] request.
* __phone\_number\_id__ _optional_<br/>
  The ID of the phone number from the [`phone_numbers`][phone_numbers] request.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings/005c4826-4e28-11e3-a675-d43d7eece53d \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
    -X PUT
    -d car_id=117
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "id": "005c4826-4e28-11e3-a675-d43d7eece53d",
  "license_plate": "B-AB 1234",
  "phone_number": "+493057701872",
  "location": {
    "id": "00cd7cfd-e42d-11e2-8bf1-8a83f3373875",
    "code": "ZHRTHW",
    "latitude": 47.365398,
    "longitude": 8.51987,
    "street": "Hopfenstrasse",
    "street_number": "20",
    "postcode": "8045",
    "city": "Zürich",
    "country": "CH",
    "description": "Doppelparkplatz. Jedoch nur für ein Auto zu vermieten. Die andere Hälfte wird benötigt. Aufteilung wie im Bild.",
    "image_urls": [
      "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image",
      "http://parku.ch/parkingspace/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/image"
    ],
    "options": [],
    "notifications": [],
    "currency": "CHF",
    "support": {
      "phone_number": "+41 43 928 72 52"
    }
  },
  "reference": "HRS5J",
  "date_start": "{{ site.time | date: '%Y-%m-%d' }} 10:00:00{{ site.time | date: '%z' }}",
  "date_end": "{{ site.time | date: '%Y-%m-%d' }} 16:30:00{{ site.time | date: '%z' }}",
  "price": 13.75,
  "currency": "CHF",
  "violation": {
    "license_plate": "B-DC 4321",
    "comment": "This car parked on my parking space!!!",
    "image_url": "{{ site.parku.url }}/images/reports/12.jpeg"
  }
}
```



-->

  [iso-8601]:       http://en.wikipedia.org/wiki/ISO_8601
  [locations]:      /api/locations/
  [cars]:           /api/cars/
  [phone_numbers]:  /api/phone_numbers/
  [payment]:        /api/payments/
