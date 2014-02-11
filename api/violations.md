---
layout: api
title: Violations
---

* [Create a new violation](#create)
* [Add a photo](#photo)
* [Retrieve a violation](#retrieve)
* [Update a violation](#update)
* [Delete a violation](#delete)

All API requests for violations need a _private key_. You can store one violation per booking. A violation report is done in two steps:

1. [Create a new violation](#create)
2. [Add a photo](#photo)

## <a name="create"></a>Create a new violation

### Definition

```nginx
POST {{ site.parku.api }}/bookings/:booking_id/violation
```

### Arguments

* __booking\_id__ _required_<br/>
  The identifier of the booking to which the violation belongs to.
* __license\_plate___ _required_<br/>
  The license plate of the car that should not park on the parking space.
* __comment___ _optional_<br/>
  An optional comment of the user.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d "license_plate=B-CD 4321" \
    -d "comment=This car parked on my parking space!!!"
```

### Example Response

```nginx
Status: 201 Created
Location: {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation
```

```json
{
  "license_plate": "B-CD 4321",
  "comment": "This car parked on my parking space!!!",
  "image_url": null
}
```

## <a name="photo"></a>Add a photo

You can add one photo to the violation. If you add a new photo the previous one gets overwritten.

### Definition

```nginx
PUT {{ site.parku.api }}/bookings/:booking_id/violation/image
```

### Arguments

The entire `PUT` body will be treated as the file. Make sure to add the `Content-Type: application/octet-stream` to your header.


### Example Request

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation/image \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -T file.jpeg
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "license_plate": "B-CD 4321",
  "comment": "This car parked on my parking space!!!",
  "image_url": "{{ site.parku.url }}/images/reports/12.jpeg"
}
```

## <a name="retrieve"></a>Retrieve a violation

### Definition

```nginx
GET {{ site.parku.api }}/bookings/:booking_id/violation
```

### Arguments

* __booking\_id__ _required_<br/>
  The identifier of the booking to which the violation belongs to.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "license_plate": "B-CD 4321",
  "comment": "This car parked on my parking space!!!",
  "image_url": "{{ site.parku.url }}/images/reports/12.jpeg"
}
```


## <a name="update"></a>Update a violation

Updates the violation by setting the values of the parameters passed. Any parameters not provided will be left unchanged. The photo can be updated [through adding a new photo](#photo).

### Definition

```nginx
PUT {{ site.parku.api }}/bookings/:booking_id/violation
```

### Arguments

* __booking\_id__ _required_<br/>
  The identifier of the booking to which the violation belongs to.
* __license\_plate___ _required_<br/>
  The license plate of the car that should not park on the parking space.
* __comment___ _optional_<br/>
  An optional comment of the user.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT
    -d "license_plate=B-DC 4321"
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "license_plate": "B-DC 4321",
  "comment": "This car parked on my parking space!!!",
  "image_url": "{{ site.parku.url }}/images/reports/12.jpeg"
}
```


## <a name="delete"></a>Delete a violation

### Definition

```nginx
DELETE {{ site.parku.api }}/bookings/:booking_id/violation
```

### Arguments

* __booking\_id__ _required_<br/>
  The identifier of the booking to which the violation belongs to.

### Example Request

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
    -X DELETE
```

### Example Response

```nginx
Status: 204 No Content
```

```

