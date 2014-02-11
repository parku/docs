---
layout: api
title: Bookings
---

* [Create a new booking](#create)
* [Retrieve a booking](#retrieve)
* [Update a booking](#update)
* [Cancel a booking](#cancel)
* [List all bookings](#list)

All API requests to `{{ site.parku.api }}/bookings` need a _private key_.

## <a name="create"></a>Create a new booking

### Definition

```nginx
POST {{ site.parku.api }}/bookings
```

### Arguments

* __location\_id__ _required_<br/>
  The ID of the location you get returned from the [`locations`][locations] request.
* __date\_start__ _required_
* __date\_end__ _required_
* __car\_id__ _required_<br/>
  The ID of the used car. Get all cars for the user from the [`cars`][cars] request.
* __phone\_number\_id__ _required_<br/>
  The ID of the phone number of the [`phone_numbers`][phone_numbers] request.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d location_id=00cd7cfd-e42d-11e2-8bf1-8a83f3373875 \
    -d "date_start={{ site.time | date: '%Y-%m-%d' }} 10:00:00{{ site.time | date: '%z' }}" \
    -d "date_end={{ site.time | date: '%Y-%m-%d' }} 16:30:00{{ site.time | date: '%z' }}" \
    -d car_id=118 \
    -d phone_number_id=332
```

### Example Response

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
    "country": "Switzerland",
    "sesam_use": false,
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
  "currency": "CHF"
}
```


##  <a name="retrieve"></a>Retrieve a booking

Retrieves the details of an existing booking. You need only supply the unique booking identifier that was returned upon booking creation.

### Definition

```nginx
GET {{ site.parku.api }}/bookings/:booking_id
```

### Arguments

* __booking\_id__ _required_<br/>
  The identifier of the booking to be retrieved.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings/005c4826-4e28-11e3-a675-d43d7eece53d \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

Returns a booking object if a valid identifier was provided.

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
    "country": "Switzerland",
    "sesam_use": false,
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
  "currency": "CHF"
}
```


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
    "country": "Switzerland",
    "sesam_use": false,
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
  "currency": "CHF"
}
```


##  <a name="cancel"></a>Cancel a booking

Permanently cancels a booking. It cannot be undone.

### Definition

```nginx
DELETE {{ site.parku.api }}/bookings/:booking_id
```

### Arguments

* __booking\_id__ _required_<br/>
  The identifier of the booking to be canceled.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings/005c4826-4e28-11e3-a675-d43d7eece53d \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
    -X DELETE
```

### Example Response

```nginx
Status: 204 No Content
```

```

```

##  <a name="list"></a>List all bookings

Returns a list of the user's bookings. A _private key_ is required.

### Definition

```nginx
GET {{ site.parku.api }}/bookings
```

### Arguments

* __count__ _optional_ - default is 10<br/>
  A limit on the number of objects to be returned. Count can range between 1 and 100 items.
* __offset__ _optional_ - default is 0<br/>
  An offset into the list of returned items. The API will return the requested number of items starting at that offset.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings?count=3 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

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
      "country": "Switzerland",
      "sesam_use": false,
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
    "date_start": "2013-07-06 16:00:00+02:00",
    "date_end": "2013-07-07 00:00:00+02:00",
    "price": 13.75,
    "currency": "CHF"
  },
  {...},
  {...}
]
```

  [locations]:      /api/locations/
  [cars]:           /api/cars/
  [phone_numbers]:  /api/phone_numbers/
