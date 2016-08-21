Status.destroy_all
Category.destroy_all
Seller.destroy_all
Item.destroy_all

dates = [
	"2016-08-20", "2015-07-10", "2014-06-01", "2013-05-25", "2012-04-15", "2011-03-05"
]

prices = [12.50, 50.00, 10.20, 35.40, 130.12, 210.22, 115.05]

categories = Category.create! [
{value: "Car"},{value:"Clothing"},{value:"Others"}]

statuses = Status.create! [
{value:"Available"},{value:"Pending"},{value:"Sold"},{value:"Expired"}, value:"Banned"]

sellers = Seller.create! [
	{name: "Seller_1", latitude: 51.112825, longitude: -114.111586},
	{name: "Seller_2", latitude: -15.9137734, longitude: -69.8635037},
	{name: "Seller_3", latitude: 42.567398, longitude: 2.100528}
]

50.times do |num|
	Item.create! (
		{title: "Item "+num.to_s, description: "The "+num.to_s+" item in the row", price: prices.sample,
			published_date: dates.sample, status_id: statuses.sample.id, seller_id: sellers.sample.id,
			category_id: categories.sample.id}
	)
end 