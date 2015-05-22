---
layout: page
title: Changelog
---

# Changelog

<!--
  Add new changes to the log in historically descending order.
-->

## {{ '2015-05-22' | date_to_string }}

* Removed the `currency` as a parameter for [updating the users credit](/api/payment/#update-credit). `currency` is still accepted as a parameter, but is ignored. The users country currency setting will be used instead.
