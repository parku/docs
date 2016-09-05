---
layout: page
categories: ["API"]
title: Invitations
---

# Invitations

## Check validity

```sh
$ curl {{ site.parku.api }}/invitations/park4UAndMe= \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -X GET
```

> Response

```nginx
Status: 200 OK
```
```json
{
  "valid": true
}
```

### HTTP Request

`GET {{ site.parku.api }}/invitations/:invitation_code`

### Parameters

Parameter | Description
--- | ---
`invitation_code` | Base64 encoded invitation code. __Required__
