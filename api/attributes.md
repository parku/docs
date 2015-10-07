---
layout: page
categories: ["API"]
title: Attributes
---

# Attributes

All API requests to `{{ site.parku.api }}/attributes` need a __private key__.


## Create a new attribute

```sh
$ curl {{ site.parku.api }}/attributes \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d key=adac \
    -d value=12345 
```

> Response

```nginx
Status: 201 Created
Location: {{ site.parku.api }}/attributes/32
```
```json
{
  "id": 32,
  "key": "adac",
  "value": "12345"
}
```

### HTTP Request

`POST {{ site.parku.api }}/attributes`

You can store multiple attributes for a user.

### Parameters

Parameter | Description
---       | ---
`key`     | The name of the attribute. Currently only 'adac' and 'test' are allowed. __Required.__
`value`   | The value of the attribute, eg. a membership number. __Required.__

## Retrieve an attribute

```sh
$ curl {{ site.parku.api }}/attributes/32 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "id": 32,
  "key": "adac",
  "value": "12345"
}
```

### HTTP Request

`GET {{ site.parku.api }}/attributes/:attribute_id`

### Parameters

Parameter | Description
---       | ---
`attribute_id`  | The identifier of the attribute to be retrieved. __Required.__


## Update an attribute

Updates the value of the attribute.

```sh
$ curl {{ site.parku.api }}/attributes/32 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT
    -d value=54321
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "id": 32,
  "key": "adac",
  "value": "54321"
}
```

### HTTP Request

`PUT {{ site.parku.api }}/attributes/:attribute_id`

Parameter      | Description
---            | ---
`car_id`       | The identifier of the car to update. __Required.__

## Delete an attribute

```sh
$ curl {{ site.parku.api }}/attributes/32 \
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

`DELETE {{ site.parku.api }}/attributes/:attribute_id`

Parameter      | Description
---            | ---
`attribute_id`       | The identifier of the attribute to delete. __Required.__


## List all attributes

Returns a list of all attributes of the user.

```sh
$ curl {{ site.parku.api }}/attributes \
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
    "key": "test",
    "value": "ABCDE1234"
  },
  {
    "id": 21,
    "key": "adac",
    "value": "ABCDE2345"
  },
  {...},
  {...}
]
```

### HTTP Request

`GET {{ site.parku.api }}/attributes`
