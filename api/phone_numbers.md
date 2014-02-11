---
layout: api
title: Phone Numbers
---

* [Create a new phone number](#create)
* [Retrieve a phone number](#retrieve)
* [Update a phone number](#update)
* [Delete a phone number](#delete)
* [List all phone numbers](#list)

All API requests to `{{ site.parku.api }}/phone_numbers` need a _private key_.

## <a name="create"></a>Create a new phone number

You can store multiple phone numbers for a user.

### Definition

```nginx
POST {{ site.parku.api }}/phone_numbers
```

### Arguments

* __phone\_number__ _required_<br/>

### Example Request

```sh
$ curl {{ site.parku.api }}/phone_numbers \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d "phone_number=+493057701873"
```

### Example Response

```nginx
Status: 201 Created
Location: {{ site.parku.api }}/phone_numbers/151
```

```json
{
  "id": "151",
  "phone_number": "+493057701873"
}
```


## <a name="retrieve"></a>Retrieve a phone number

### Definition

```nginx
GET {{ site.parku.api }}/phone_numbers/:phone_number_id
```

### Arguments

* __phone\_number\_id__ _required_<br/>
  The identifier of the phone number to be retrieved.

### Example Request

```sh
$ curl {{ site.parku.api }}/phone_numbers/151 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "id": 151,
  "phone_number": "+493057701873"
}
```


## <a name="update"></a>Update a phone number


### Definition

```nginx
PUT {{ site.parku.api }}/phone_numbers/:phone_number_id
```

### Arguments

* __phone\_number__ _required_<br/>

### Example Request

```sh
$ curl {{ site.parku.api }}/phone_numbers/151 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT
    -d "phone_number=+493057701874"
```

### Example Response

```nginx
Status: 200 OK
```

```json
{
  "id": 151,
  "phone_number": "+493057701874"
}
```


## <a name="delete"></a>Delete a phone number

### Definition

```nginx
DELETE {{ site.parku.api }}/phone_numbers/:phone_number_id
```

### Arguments

* __phone\_number__ _required_<br/>
  The identifier of the phone number to be deleted.

### Example Request

```sh
$ curl {{ site.parku.api }}/phone_numbers/151 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
    -X DELETE
```

### Example Response

```nginx
Status: 204 No Content
```

```

```


## <a name="list"></a>List all phone numbers

Returns a list of all phone numbers of the user. The phone numbers are returned sorted by creation date, with the most recently created phone number appearing first.

### Definition

```nginx
GET {{ site.parku.api }}/phone_numbers
```

### Example Request

```sh
$ curl {{ site.parku.api }}/phone_numbers \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

### Example Response

```nginx
Status: 200 OK
```

```json
[
  {
    "id": 150,
    "phone_number": "+493057701872"
  },
  {
    "id": 149,
    "phone_number": "+493057701871"
  },
  {...},
  {...}
]
```

