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
			?s=1,2,5 \
			&p=android \
			&os=Android \
			&osv=4.4 \
			&aid=??? \
			&did=62c7c7042511c086 \
			&av=1.0 \
			&abv=1.0 \
			&uid=38fe8355-131d-11e4-bd51-b888e3f2a4ab \
			&b=Chrome \
			&bv=30.0.0.0 \
			&oids=1,2,3 \
		-u 6f1ed002ab5595859014ebf0951522d9:parku
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
`s`					| Comma separated list of already shown message IDs
`p`					| Platform (android, ios, web)
`os`					| Operating system (Android, iOS, OS X, Windows, Windows Phone, Firefox OS, Chrome OS, Linux, Other)
`osv`					| OS Version
`aid`					| adjust ID ???
`did`					| Device unique ID depending on os and os version (INID, IMEI, UDID, DUID, BB Pin)
`av`					| App version
`abv`					| App build version
`uid`					| User id _(if applicable)_
`b`					| Browser name _(if applicable)_
`bv`					| Browser Version _(if applicable)_
`oids`					| Comma separated list of other Android or iOS IDs _optional_



