---
layout: page
title: Changelog
---

# Changelog

<!--
  Add new changes to the log in historically descending order.
-->

## {{ '2015-08-07' | date_to_string }}

* Expose post booking information to every booking for storing more sensetive data

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
