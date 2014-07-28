---
layout: page
categories: ["API"]
title: Messages
---

# Messages

All API requests to `{{ site.parku.api }}/messages` needs a _private key_.

# Request Messages

```sh
$ curl {{ site.parku.api }}/messages \
    -G \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d p=android \
    -d os=Android \
	-d osv=4.4 \
	-d aid=??? \
	-d did=62c7c7042511c086 \
	-d av=1.0 \
	-d abv=1.0 \
	-d uid=38fe8355-131d-11e4-bd51-b888e3f2a4ab \
    -d s=1,2,5 \
	-d b=Chrome \
	-d bv=30.0.0.0 \
	-d oids=1,2,3 \
```

> Response

```nginx
Status: 200 OK
```
```json
[
    {
        "id": "1",
        "type": "???",
        "title": "Obsolete",
        "message": "Please update your application",
        "call_to_action_text": "???",
        "call_to_action_link": "http://someupdates???"
    },
    {...},
    {...}
]
```

### HTTP Request

`GET {{ site.parku.api }}/messages`

### Parameters

Parameter		 | Description
---					 | ---
`p`					| Platform (android, ios, web)
`os`					| Operating system (Android, iOS, OS X, Windows, Windows Phone, Firefox OS, Chrome OS, Linux, Other)
`osv`					| OS Version
`aid`					| adjust ID ???
`did`					| Device unique ID depending on os and os version (INID, IMEI, UDID, DUID, BB Pin)
`av`					| App version
`abv`					| App build version
`uid`					| User id _(if applicable)_
`s`					| Comma separated list of already shown message IDs _(if applicable)_
`b`					| Browser name _(if applicable)_
`bv`					| Browser Version _(if applicable)_
`oids`					| Comma separated list of other Android or iOS IDs _optional_



