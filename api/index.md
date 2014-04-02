---
layout: page
title: API
---

# API

The parku API is organized around [REST][REST]. Our API is designed to have predictable, resource-oriented URLs and to use HTTP response codes to indicate API errors. We use built-in HTTP features, like HTTP authentication and HTTP verbs, which can be understood by off-the-shelf HTTP clients. [JSON][JSON] will be returned in all responses from the API, including errors.

<!-- no
You can provide the `Accept-Language` header information for all your requests. Localized content is returned when available. Default content is english.
-->

## Authentication

```sh
$ curl {{ site.parku.api }}/version \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

Authentication to the API occurs via [HTTP Basic Auth][HTTP Basic Auth]. Provide your API key as the basic auth username. The password is always _parku_.

There are two types of keys: _public_ and _private_. _Public keys_ are used to obtain publicly available informations (eg. parking spaces). _Private keys_ are used to identify users. Whenever user information are requested or bookings on behalf of a user is made, the _private key_ is necessary.

_Private keys_ can be used to obtain public information.

All API requests must be made over HTTPS. Calls made over plain HTTP will fail. You must authenticate for all requests.


## Errors

```nginx
Status: 422 Unprocessable Entity
```

```json
{
  "errors": [
    {
      "code": "missing",
      "field": "date_start"
    }
  ]
}
```

parku uses conventional HTTP response codes to indicate success or failure of an API request. In general, codes in the 2xx range indicate success, codes in the 4xx range indicate an error that resulted from the provided information (e.g. a required parameter was missing, etc.), and codes in the 5xx range indicate an error with parku's servers.

### HTTP Status Codes Summary

Code   | Description
---    |---
`200`  | OK - Everything worked as expected.
`201`  | Created - Item was created successfully. The URL to the item can be found in the "Location"-Header.
`204`  | No Content - The request was successful.
`401`  | Unauthorized - No valid API key provided.
`404`  | Not Found - The requested item doesn't exist.
`422`  |  Unprocessable Entity
`5xx`  | Server errors - something went wrong on parku's end.

All error objects have _field_ properties so that your client can tell what the problem is. There is also an error _code_ to let you know what is wrong with the field. These are possible validation error codes:

<nobr>Error Code</nobr> | Description
---          |---
`missing`    | The _field_ is not present.
`invalid`    | The formatting of the _field_ is invalid. The documentation for that field should be able to give you more specific information.
`duplicate`  | The value for _field_ is already present in our database. Only used when trying to [create a user][createuser] with an existing email address.
`extra_field`| The _field_ should not be present.

## Endpoints

```sh
$ curl {{ site.parku.api }} \
    -u 6f1ed002ab5595859014ebf0951522d9:parku
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "urls_url": "{{ site.parku.api }}",
  "version_url": "{{ site.parku.api }}/version",
  "locations_url": "{{ site.parku.api }}/locations",
  "terms_url": "{{ site.parku.api }}/terms",
  "faq_url": "{{ site.parku.api }}/faq",
  "privacy_policy_url": "{{ site.parku.api }}/privacy_policy",
  "login_url": "{{ site.parku.api }}/login",
  "user_url": "{{ site.parku.api }}/user",
  "password_url": "{{ site.parku.api }}/password",
  "credit_url": "{{ site.parku.api }}/credit",
  "phone_numbers_url": "{{ site.parku.api }}/phone_numbers",
  "cars_url": "{{ site.parku.api }}/cars",
  "bookings_url": "{{ site.parku.api }}/bookings",
  "violation_url": "{{ site.parku.api }}/bookings/{booking_id}/violation",
  "sesam_url": "{{ site.parku.api }}/sesam"
}
```

Keep in mind, that some of these urls are private. You need a _private key_ which you get when [logging in a user][login].
For the public urls you need a _public key_.

With a _private key_ you can access public urls.

  [REST]: http://en.wikipedia.org/wiki/Representational_State_Transfer
  [JSON]: http://www.json.org/
  [HTTP Basic Auth]: http://en.wikipedia.org/wiki/Basic_access_authentication
  [HTTPS]: http://en.wikipedia.org/wiki/HTTP_Secure
  [login]: /api/login/
  [createuser]: /api/user/#toc_1
