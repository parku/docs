---
layout: api
title: Cars
---

* [Create a new car](#create)
* [Retrieve a car](#retrieve)
* [Update a car](#update)
* [Delete a car](#delete)
* [List all cars](#list)

All API requests to `{{ site.parku.api }}/cars` need a _private key_.

## <a name="create"></a>Create a new car

You can store multiple cars for a user.

### Definition

```nginx
POST {{ site.parku.api }}/cars
```

### Arguments

* __license\_plate__ _required_<br/>
  The license plate for the stored car.
* __vehicle__ _optional_<br/>
  A name for the car to be identified easier.

### Example Request

```sh
$ curl {{ site.parku.api }}/cars \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d "license_plate=B-AB 1234" \
    -d vehicle=Isetta
```

### Example Response

```nginx
Status: 201 Created
Location: {{ site.parku.api }}/cars/23
```

```json
{
  "id": "23",
  "license_plate": "B-AB 1234",
  "vehicle": "Isetta"
}
```


## <a name="retrieve"></a>Retrieve a car

### Definition

```nginx
GET {{ site.parku.api }}/cars/{car_id}
```

### Arguments

* __car\_id__ _required_<br/>
  The identifier of the car to be retrieved.

### Example Request

```sh
$ curl {{ site.parku.api }}/cars/23 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "id": "23",
  "license_plate": "B-AB 1234",
  "vehicle": "Isetta"
}
```


## <a name="update"></a>Update a car

Updates the car by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

This request accepts mostly the same arguments as the car creation call.

### Definition

```nginx
PUT {{ site.parku.api }}/cars/{car_id}
```

### Arguments

* __license\_plate__ _optional_
* __vehicle__ _optional_

### Example Request

```sh
$ curl {{ site.parku.api }}/cars/23 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT
    -d vehicle=Polo
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "id": "23",
  "license_plate": "B-AB 1234",
  "vehicle": "Polo"
}
```


## <a name="delete"></a>Delete a car

### Definition

```nginx
DELETE {{ site.parku.api }}/cars/{car_id}
```

### Arguments

* __car\_id__ _required_<br/>
  The identifier of the car to be deleted.

### Example Request

```sh
$ curl {{ site.parku.api }}/cars/23 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
    -X DELETE
```

### Example Response

```nginx
Status: 204 No Content
```

```

```


## <a name="list"></a>List all cars

Returns a list of all cars of the user. The cars are returned sorted by creation date, with the most recently created car appearing first.

### Definition

```nginx
GET {{ site.parku.api }}/cars
```

### Example Request

```sh
$ curl {{ site.parku.api }}/cars \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

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


