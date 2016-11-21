<!--
  Add new changes to the log in historically descending order.
-->

### 2016-11-21

* New examples and formatting

### 2016-09-22

* Extended location with `availability` and `bookability`
* Reformatted location

### 2016-09-12

* Extended login with new information fields.

### 2016-09-09

* Extended coupon with error message 40.

### 2016-05-19

* Extended settings with `provider`
* Extended location with `provider`
* Added terms and conditions remark to the top of bookings

### 2016-05-18

* Adding type to required fields in settings endpoint with `booking.fields`
* Extended new booking in bookings endpoint with `required_fields`

### 2016-05-09

* Extended settings endpoint with `booking.fields`
* Extended location endpoints with `required_fields`

### 2016-05-02

* Added features settings endpoint. Return feature flags based on parameters and user agent.

### 2016-04-28

* Added new properties to locations endpoint.
* Introduced type for locations endpoint.
* Added optional status filter to bookings endpoint. Retrieve bookings filtered by status.

### 2016-04-08

* Added availability endpoint. Retrieve information
  about the availability times of a parking space.

### 2016-03-07

* Added coupon endpoint. It enables 3rd parties to validate a
  coupon code.

### 2016-02-16

* Response in user endpoint returns a `code` node, containing a
  character/number combination, unique to each customer.

### 2016-02-02

* Extended settings endpoint with *gps* node.
* Added *notifications* to settings endpoint.
* Added `PUT` to toggle notification in settings endpoint.

### 2015-11-24

* Added the sesam settings to the settings endpoint.

### 2015-11-17

* Changed the naming of the location node in the response of the settings endpoint.

### 2015-11-17

* Added `/v4/settings` endpoint.

### 2015-10-20

* Remove _Launch Messages_.

### 2015-09-25

* Removing the `minimum_displayprice` and `minimum_displayprice_unit`.
* Adding the `price_period` to location endpoints.

### 2015-09-14

* New endpoint for deleting credit cards.

### 2015-09-11

* New user_owned attribute added to the location endpoint. This returns true if the user who requests the location is also the owner of that parking space.

### 2015-08-28

* Add attributes to a new user or update them for existing ones

### 2015-08-07

* Expose post booking information to every booking for storing more sensitive data

### 2015-08-03

* Expose gate information to every booking on how to open a gate (via api or via bt)

### 2015-07-30

* Added cars and phone_numbers to user endpoint
* Parameter "password" is optional when creating User
* Added minimum_displayprice_unit and minimum_displayprice to location endpoint.

### 2015-07-05

* Added the _beacon_ directive to the boxes endpoint.

### 2015-07-01

* Added the boxes endpoint.

### 2015-05-22

* Removed the `currency` as a parameter for updating the users credit. `currency` is still accepted as a parameter, but is ignored. The users country currency setting will be used instead.
