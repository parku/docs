---
layout: page
title: Changelog
---

# Changelog

<!--
  Add new changes to the log in historically descending order.
-->
## {{ '2015-07-30' | date_to_string }}

* Parameter "password" is optional when creating User


## {{ '2015-07-30' | date_to_string }}

* Added minimum_displayprice_unit and minimum_displayprice to location endpoint.


## {{ '2015-07-05' | date_to_string }}

* Added the _beacon_ directive to the [boxes endpoint][boxes].


## {{ '2015-07-01' | date_to_string }}

* Added the [boxes endpoint][boxes].


## {{ '2015-05-22' | date_to_string }}

* Removed the `currency` as a parameter for [updating the users credit](/api/payment/#update-credit). `currency` is still accepted as a parameter, but is ignored. The users country currency setting will be used instead.


  [boxes]: /api/boxes/ "Boxes Endpoint"
