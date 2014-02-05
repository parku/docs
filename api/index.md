---
layout: api
title: API
---

The parku API is organized around [REST][REST]. Our API is designed to have predictable, resource-oriented URLs and to use HTTP response codes to indicate API errors. We use built-in HTTP features, like HTTP authentication and HTTP verbs, which can be understood by off-the-shelf HTTP clients. [JSON][JSON] will be returned in all responses from the API, including errors.

### Authentication

Authentication to the API occurs via [HTTP Basic Auth][HTTP Basic Auth]. Provide your API key as the basic auth username. You do not need to provide a password.

There are two types of keys: public and private. Public keys are used to obtain publicly available informations (eg. parking spaces). Private keys are used to identify users. Whenever user information are requested or bookings on behalf of a user is made, the private key is necessary.

Private keys can be used to obtain public information.

All API requests must be made over HTTPS. Calls made over plain HTTP will fail. You must authenticate for all requests.

#### Example Request

```sh
$ curl {{ site.parku.api }}/version \
    -u 6f1ed002ab5595859014ebf0951522d9:
```

### Errors

parku uses conventional HTTP response codes to indicate success or failure of an API request. In general, codes in the 2xx range indicate success, codes in the 4xx range indicate an error that resulted from the provided information (e.g. a required parameter was missing, etc.), and codes in the 5xx range indicate an error with parku's servers.

#### HTTP Status Codes Summary

```
200 OK - Everything worked as expected
201 Created - Item was created successfully.
    The URL to the item can be found in the
	"Location"-Header.
204 No Content - The request was successful.
400 Bad Request - Often missing a required
	parameter.
401 Unauthorized - No valid API key provided.
402 Request Failed - Parameters were valid but
	request failed.
404 Not Found - The requested item doesn't exist.
422 Unprocessable Entity
5xx Server errors - something went wrong on
	parku's end.
```

#### Example Error




  [REST]: http://en.wikipedia.org/wiki/Representational_State_Transfer
  [JSON]: http://www.json.org/
  [HTTP Basic Auth]: http://en.wikipedia.org/wiki/Basic_access_authentication
  [HTTPS]: http://en.wikipedia.org/wiki/HTTP_Secure