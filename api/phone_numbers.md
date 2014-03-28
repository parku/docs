---
layout: page
categories: ["API"]
title: Phone Numbers
---

# Phone Numbers

All API requests to `{{ site.parku.api }}/phone_numbers` need a _private key_.

## Create a new phone number

You can store multiple phone numbers for a user.

```sh
$ curl {{ site.parku.api }}/phone_numbers \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d "phone_number=+493057701873"
```

> Response

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

### HTTP Request

`POST {{ site.parku.api }}/phone_numbers`

### Parameters

Parameter      | &nbsp;
---            | ---
`phone_number` | __Required.__


## Retrieve a phone number

```sh
$ curl {{ site.parku.api }}/phone_numbers/151 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

```nginx
Status: 200 OK
```

```json
{
  "id": 151,
  "phone_number": "+493057701873"
}
```

### HTTP Request

`GET {{ site.parku.api }}/phone_numbers/:phone_number_id`

### Parameters

Parameter         | Description
---               | ---
`phone_number_id` | The identifier of the phone number to be retrieved. __Required.__


## Update a phone number

```sh
$ curl {{ site.parku.api }}/phone_numbers/151 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X PUT
    -d "phone_number=+493057701874"
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "id": 151,
  "phone_number": "+493057701874"
}
```

### HTTP Request

`PUT {{ site.parku.api }}/phone_numbers/:phone_number_id`

### Parameters

Parameter         | Description
---               | ---
`phone_number_id` | The identifier of the phone number to be updated. __Required.__
`phone_number`    | __Required.__


## Delete a phone number

```sh
$ curl {{ site.parku.api }}/phone_numbers/151 \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
    -X DELETE
```

> Response

```nginx
Status: 204 No Content
```
```

```

### HTTP Request

`DELETE {{ site.parku.api }}/phone_numbers/:phone_number_id`

### Parameters

Parameter         | Description
---               | ---
`phone_number_id` | The identifier of the phone number to be deleted. __Required.__


## List all phone numbers

Returns a list of all phone numbers of the user. The phone numbers are returned sorted by creation date, with the most recently created phone number appearing first.

```sh
$ curl {{ site.parku.api }}/phone_numbers \
    -u 098f6bcd4621d373cade4e832627b4f6:parku
```

> Response

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


### HTTP Request

`GET {{ site.parku.api }}/phone_numbers`
