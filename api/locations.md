---
layout: page
categories: ["API"]
title: Locations
---

# Locations

All API requests to `{{ site.parku.api }}/locations` need a __private key__.

## List Locations

```sh
$ curl {{ site.parku.api }}/locations \
			?sw=45.74001,5.67868 \
			&ne=47.74236,10.24900 \
			&date_start={{ site.time | date: '%Y-%m-%d' }} 10:00:00{{ site.time | date: '%z' }} \
			&date_end={{ site.time | date: '%Y-%m-%d' }} 16:30:00{{ site.time | date: '%z' }} \
		-u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```json
[
	{
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
		"options": [
			"excess length", "indoor", "disabled", "patio", "barrier"
		],
		"notifications": [],
		"currency": "CHF",
		"support": {
			"phone_number": "+41 43 928 72 52"
		},
		"price": 3.5
	},
	{...},
	{...}
]
```

### HTTP Request

`GET {{ site.parku.api }}/locations`

### Parameters

Parameter		 | Description
---					 | ---
`sw`					| Comma separated latitude and longitude of the southwest position. _Optional._
`ne`					| Comma separated latitude and longitude of the northeast position. _Optional._
`date_start`	| Filter parking spaces for the start date. _Optional._
`date_end`		| Filter parking spaces for the end date. _Optional._

If only one parameter of the pairs _ne_ - _sw_ or _date\_start_ - _date\_end_ is provided, the other parameter gets skipped.

If no parameter is given, all parking spaces are returned. Keep in mind, that some of them might not be available at the current time.


## Terms and Conditions

Each location can have different terms and conditions. With this endpoint you can retrieve location based terms and conditions.

```sh
$ curl {{ site.parku.api }}/locations/00cd7cfd-e42d-11e2-8bf1-8a83f3373875/terms \
		-u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"...

```

### HTTP Request

`GET {{ site.parku.api }}/locations/:location_id/terms`

### Parameters

Parameter		| Description
---					| ---
`location_id`| The location you like to retrieve the T&C for. __Required.__
