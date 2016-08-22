Items API
=========

Requirements
------------

A typical item has the following structure (all fields are required):

1. Item title
2. Item description
3. Item Category (list of available values)
	* Car
	* Clothing
	* Others
4. Item Price
5. Seller Name
6. Seller Latitude
7. Seller Longitude
8. Item Status (list of available values)
	* Available
	* Pending
	* Sold
	* Expired
	* Banned
9. Item Published Date

The API will generate:

1. a list of all items
2. a list of all sold items for a particular seller
3. details of one item
4. a list of available items for a particular category

A banned item should never have the following fields returned by the API:
* Seller Name
* Item Publishing Date

How to run
----------
Deployed version of this app is here:
https://item-api.herokuapp.com/api/v1/items

1. Clone this repo
2. Have Rails 5 and Ruby 2.2.4 installed
3. cd into repo folder
4. resolve the bundle
5. run 'rails s' command. by default it will run on http://localhost:3000/

List of all items: 
`http://localhost:3000/api/v1/items`

Details of one item:
`http://localhost:3000/api/v1/items/<item>`
where <item> is item id (e.g.: `1`) or name of the item (e.g.: Item 1)

A list of all sold items for a particular seller:
`http://localhost:3000/api/v1/item_by_seller/<seller>`
where <seller> is seller id (e.g.: `1`) or name of the seller (e.g.: `Seller_1`)

A list of available items for a particular category:
`http://localhost:3000/api/v1/item_by_category/<status>`
where <status> is status id (e.g.: `1`) or name of the status (e.g.: `Car`)

* Ruby version
2.2.4

* Rails version
5.0.0.1

* Database creation
`rake db:migrate`

* Database seeding
`rake db:seed`

* Test suite
`rspec`