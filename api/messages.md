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
    -d platform=android \
    -d os=Android \
	-d os_version=4.4 \
	-d adjust_id=132 \
	-d advertisement_id=13 \
	-d device_main_id=62c7c7042511c086 \
	-d device_other_ids=1,2,3 \
	-d app_version=1.0 \
	-d app_build_version=1.0 \
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
`platform`					| Platform (android, ios, web) _(if applicable)_
`os`					| Operating system (Android, iOS, OS X, Windows, Windows Phone, Firefox OS, Chrome OS, Linux, Other) _(if applicable)_
`os_version`					| OS Version _(if applicable)_
`adjust_id`					| Adjust ID _(if applicable)_
`advertisement_id`					| Advertisement ID _(if applicable)_
`device_main_id`					| Device unique ID depending on os and os version (INID, IMEI, UDID, DUID, BB Pin) _(if applicable)_
`device_other_ids`					| Comma separated list of other Android or iOS IDs _(if applicable)_
`app_version`					| App version _(if applicable)_
`app_build_version`					| App build version _(if applicable)_



