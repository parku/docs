---
layout: page
title: Changelog
---

# Changelog

<!--
  Add new changes to the log in historically descending order.
-->

## 22. Mai 2015

* Removed the `currency` as a parameter for [updating the users credit](/api/payment/#update-credit). `currency` is still accepted as a parameter, but is ignored. The users country currency setting will be used instead.
