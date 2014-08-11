---
layout: page
categories: ["API"]
title: Launch Messages
---

# Messages

All API requests to `{{ site.parku.api }}/launch_messages` needs a _private key_.

# Request Launch Messages

```sh
$ curl {{ site.parku.api }}/launch_messages \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d os=Android \
	-d os_version=4.4 \
	-d adjust_id=132 \
	-d advertisement_id=13 \
	-d device_main_id=62c7c7042511c086 \
	-d device_other_ids["example_id"]=123 \
	-d device_other_ids["another_example_id"]=456 \
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

`POST {{ site.parku.api }}/launch_messages`

### Parameters

Parameter		 | Description
---					 | ---
`os`					| Operating system (Android, iOS, OS X, Windows, Windows Phone, Firefox OS, Chrome OS, Linux, Other) _(if applicable)_
`os_version`					| OS Version _(if applicable)_
`adjust_id`					| Adjust ID _(if applicable)_
`advertisement_id`					| Advertisement ID _(if applicable)_
`device_main_id`					| Device unique ID depending on os and os version (INID, IMEI, UDID, DUID, BB Pin) _(if applicable)_
`device_other_ids`					| Other Android or iOS IDs as a dictionary _(if applicable)_
`app_version`					| App version _(if applicable)_
`app_build_version`					| App build version _(if applicable)_



