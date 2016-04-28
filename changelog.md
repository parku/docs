---
layout: page
title: Changelog
---

# Changelog

<!--
  Add new changes to the log in historically descending order.
-->
## {{ '2016-04-28' | date_to_string }}

* Added new properties to [locations endpoint](/api/locations/).
* Introduced type for [locations endpoint](/api/locations/). 
* Added optional status filter to [bookings endpoint](/api/bookings/). Retrieve bookings filtered by status.

## {{ '2016-04-08' | date_to_string }}

* Added [availability endpoint](/api/locations/{location_id}/availability). Retrieve information
  about the availability times of a parking space.

## {{ '2016-03-07' | date_to_string }}

* Added [coupon endpoint](/api/coupon/). It enables 3rd parties to validate a
  coupon code.

## {{ '2016-02-16' | date_to_string }}

* Response in [user endpoint](/api/user/) returns a `code` node, containing a
  character/number combination, unique to each customer.

## {{ '2016-02-02' | date_to_string }}

* Extended [settings endpoint](/api/settings/) with *gps* node.
* Added *notifications* to [settings endpoint](/api/settings/).
* Added `PUT` to toggle notification in [settings endpoint](/api/settings/).

## {{ '2015-11-24' | date_to_string }}

* Added the sesam settings to the [settings endpoint](/api/settings/).

## {{ '2015-11-17' | date_to_string }}

* Changed the naming of the location node in the response of the [settings endpoint](/api/settings/).

## {{ '2015-11-17' | date_to_string }}

* Added `/v4/settings` [endpoint](/api/settings/).

## {{ '2015-10-20' | date_to_string }}

* Remove _Launch Messages_.

## {{ '2015-09-25' | date_to_string }}

* Removing the `minimum_displayprice` and `minimum_displayprice_unit`.
* Adding the `price_period` to [location endpoints](/api/locations/).

## {{ '2015-09-14' | date_to_string }}

* New endpoint for [deleting credit cards](/api/payment/#delete-a-credit-card).

## {{ '2015-09-11' | date_to_string }}

* New user_owned attribute added to the location endpoint. This returns true if the user who requests the location is also the owner of that parking space.

## {{ '2015-08-28' | date_to_string }}

* Add attributes to a new user or update them for existing ones

## {{ '2015-08-07' | date_to_string }}

* Expose post booking information to every booking for storing more sensitive data

## {{ '2015-08-03' | date_to_string }}

* Expose gate information to every booking on how to open a gate (via api or via bt)

## {{ '2015-07-30' | date_to_string }}

* Added cars and phone_numbers to user endpoint
* Parameter "password" is optional when creating User
* Added minimum_displayprice_unit and minimum_displayprice to location endpoint.

## {{ '2015-07-05' | date_to_string }}

* Added the _beacon_ directive to the [boxes endpoint][boxes].

## {{ '2015-07-01' | date_to_string }}

* Added the [boxes endpoint][boxes].

## {{ '2015-05-22' | date_to_string }}

* Removed the `currency` as a parameter for [updating the users credit](/api/payment/#update-credit). `currency` is still accepted as a parameter, but is ignored. The users country currency setting will be used instead.


  [boxes]: /api/boxes/ "Boxes Endpoint"
