---
layout: page
categories: ["API"]
title: Cars
---

# Cars

All API requests to `{{ site.parku.api }}/cars` need a __private key__.


## Create a new car

```sh
$ curl {{ site.parku.api }}/cars \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d "license_plate=B-AB 1234" \
    -d vehicle=Isetta
```

> Response

```nginx
Status: 201 Created
Location: {{ site.parku.api }}/cars/23
```
```json
{
  "id": 23,
  "license_plate": "B-AB 1234",
  "vehicle": "Isetta"
}
```

### HTTP Request

`POST {{ site.parku.api }}/cars`

You can store multiple cars for a user.

### Parameters

Parameter      | Description
---            | ---
`license_plate`| The license plate for the stored car. __Required.__
`vehicle`      | A name for the car to be identified easier.


## Retrieve a car

```sh
$ curl {{ site.parku.api }}/cars/23 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "id": 23,
  "license_plate": "B-AB 1234",
  "vehicle": "Isetta"
}
```

### HTTP Request

`GET {{ site.parku.api }}/cars/:car_id`

### Parameters

Parameter | Description
---       | ---
`car_id`  | The identifier of the car to be retrieved. __Required.__


## Update a car

Updates the car by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

This request accepts mostly the same arguments as the car creation call.

```sh
$ curl {{ site.parku.api }}/cars/23 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT
    -d vehicle=Polo
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "id": 23,
  "license_plate": "B-AB 1234",
  "vehicle": "Polo"
}
```

### HTTP Request

`PUT {{ site.parku.api }}/cars/:car_id`

Parameter      | Description
---            | ---
`car_id`       | The identifier of the car to update. __Required.__
`license_plate`| The license plate for the stored car.
`vehicle`      | A name for the car to be identified easier.


## Delete a car

```sh
$ curl {{ site.parku.api }}/cars/23 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
    -X DELETE
```

> Response

```nginx
Status: 204 No Content
```
```json

```

### HTTP Request

`DELETE {{ site.parku.api }}/cars/:car_id`

Parameter      | Description
---            | ---
`car_id`       | The identifier of the car to delete. __Required.__


## List all cars

Returns a list of all cars of the user. The cars are returned sorted by creation date, with the most recently created car appearing first.

```sh
$ curl {{ site.parku.api }}/cars \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
```json
[
  {
    "id": 22,
    "vehicle": "Ducati Monster S4Rs",
    "license_plate": "ABCDE1234"
  },
  {
    "id": 21,
    "vehicle": "Harley Davidson FortyEight 1200",
    "license_plate": "ABCDE2345"
  },
  {...},
  {...}
]
```

### HTTP Request

`GET {{ site.parku.api }}/cars`
