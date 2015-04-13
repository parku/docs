---
layout: page
categories: ["API"]
title: Devices
---

# Devices

All API requests to `{{ site.parku.api }}/devices` need a __private key__.

This endpoint is used to send the latest device identifier to the backend. The device identifier is used to send push notifications.

Only the creation of identifiers is allowed. Retrieving is _not_ allowed.

## Create an identifier

```sh
$ curl {{ site.parku.api }}/devices \
    -u 098f6bcd4621d373cade4e832627b4f6:parku \
    -d ios_device_token=A339F8BE4F…
```

> Response

```nginx
Status: 204 No Content
```

### HTTP Request

`POST {{ site.parku.api }}/device`

Send the latest device identifier to the backend.

### Parameters

Parameter      | Description
---            | ---
`ios_device_token`| iOS push notification identifier via APNs. Full integration and how to request a push notification Device Token through Apple's APM service is accessible [here](https://developer.apple.com/library/mac/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Introduction.html). Device Token may be raw format <a339f8be4f…> or in push format. _Optional_
`android_registration_id` | Android push notification identifier via GCM. Full integration and how to request a push notification Registration ID through Android's GCM service is accessible [here](http://developer.android.com/google/gcm/gs.html).

The _iOS device token_ can change through time. [Apple suggests](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/IPhoneOSClientImp.html#//apple_ref/doc/uid/TP40008194-CH103-SW2) to send the device token every time the app launches.
