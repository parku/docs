---
layout: page
categories: ["API"]
title: Violations
---

# Violations

All API requests `https://api.parku.ch/v4/bookings/:booking_id/violation` need a __private key__. You can store one violation per booking. A violation report is done in two steps:

1. [Create a new violation](#toc_1)
2. [Add a photo](#toc_4)

## Create a new violation

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d "license_plate=B-CD 4321" \
    -d "comment=This car parked on my parking space!!!"
```

> Response

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

### HTTP Request

`POST {{ site.parku.api }}/bookings/:booking_id/violation`

### Parameters

Parameter       | Description
---             | ---
`booking_id`    | The identifier of the booking to which the violation belongs to. __Required.__
`license_plate` | The license plate of the car that should not park on the parking space. __Required.__
`comment`    | An optional comment of the user. _Optional._


## Add a photo

You can add one photo to the violation. If you add a new photo the previous one gets overwritten.

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation/image \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -T file.jpeg
```

> Response

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

### HTTP Request

`PUT {{ site.parku.api }}/bookings/:booking_id/violation/image`

### Parameters

The entire `PUT` body will be treated as the file. Make sure to add the `Content-Type: application/octet-stream` to your header.


## Retrieve a violation

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

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

### HTTP Request

`GET {{ site.parku.api }}/bookings/:booking_id/violation`

### Parameters

Parameter       | Description
---             | ---
`booking_id`    | The identifier of the booking to which the violation belongs to. __Required.__


## Update a violation

Updates the violation by setting the values of the parameters passed. Any parameters not provided will be left unchanged. The photo can be updated [through adding a new photo](#toc_4).

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT \
    -d "license_plate=B-DC 4321"
```

> Response

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

### HTTP Request

`PUT {{ site.parku.api }}/bookings/:booking_id/violation`

### Parameters

Parameter       | Description
---             | ---
`booking_id`    | The identifier of the booking to which the violation belongs to. __Required.__
`license_plate` | The license plate of the car that should not park on the parking space. _Optional._
`comment`       | An optional comment of the user. _Optional._


## Delete a violation

```sh
$ curl {{ site.parku.api }}/bookings/0072c629-e622-11e2-8bf1-8a83f3373875/violation \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X DELETE
```

> Response

```nginx
Status: 204 No Content
```
```

```

### HTTP Request

`DELETE {{ site.parku.api }}/bookings/:booking_id/violation`

### Parameters

Parameter       | Description
---             | ---
`booking_id`    | The identifier of the booking to which the violation belongs to. __Required.__
