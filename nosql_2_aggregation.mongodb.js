use("db_nosql")

//1. overall number of reviews (reviews)
db.reviews.countDocuments()

//2. how many reviews have pictures (reviews)
db.reviews.countDocuments({"photos": {$exists: true}})

//3. number of reviews with each rating (reviews)
db.reviews.aggregate([ 
  { $group: { _id: "$rating", totalReviews: { $sum: 1 } } }])

//4. average rating for each city (reviews)
db.reviews.aggregate([ 
  { $group: { _id: "$city_id", avgRating: { $avg: "$rating" } } }])

//5. number of reviews per month (reviews)
db.reviews.aggregate([ 
  { $group: { _id: {year: {$year: "$created_at"}, month: { $month: "$created_at"} }, totalReviews: { $sum: 1 } } }])

//6. number of reviews with tags (reviews)
db.reviews.countDocuments({"tags": {$exists: true}})



//////////////////////////////////////
//7. overall number of events (events)
db.events.countDocuments()

//8. number of events per city (events)
db.events.aggregate([ 
  { $group: { _id: "$city_id", totalEvents: { $sum: 1 } } }])

//9. number of events per city and type since april 2025 (events)
db.events.aggregate([ 
  { $match: {$expr: { $gte: [{ $month: "$date" }, 4] }}},
  { $group: { _id: {type: "$type", city_id: "$city_id"}, totalEvents: { $sum: 1 } } }])

//10. number of events per month (events)
db.events.aggregate([ 
  { $group: { _id: {year: {$year: "$date"}, month: { $month: "$date"} }, totalEvents: { $sum: 1 } } }])

//11. number of different events that cost less than 20 euros in Berlin (events)
db.events.aggregate([
  { $match: {$and: [ {cost: { $lte: 20 }}, {city_id: 1}] }},
  { $group: { _id: "$type", totalEvents: { $sum: 1 } } }])



//////////////////////////////////////
//12. overall number of wishlists (wishlist)
db.wishlist.countDocuments()

//13. number of wishlists per user (wishlist)
db.wishlist.aggregate([ 
  { $group: { _id: "$user_id", totalWishlists: { $sum: 1 } } },
  { $sort: { totalWishlists: -1 } } ])

//14. number of wishlists per city (wishlist)
db.wishlist.aggregate([ 
  { $group: { _id: "$city_id", totalWishlists: { $sum: 1 } } },
  { $sort: { totalWishlists: -1 } }])

//15. number of wishlists per publicity type (wishlist)
db.wishlist.aggregate([ 
  { $group: { _id: "$public", totalWishlists: { $sum: 1 } } }])

//16. number of wishlists with items (wishlist)
db.wishlist.countDocuments({"items": {$exists: true}})

//17. average number of items per withlist (wishlist)
db.wishlist.aggregate([
  { $project: { itemCount: { $size: "$items" } } },
  { $group: { _id: null, avgItemsPerDoc: { $avg: "$itemCount" } }}
])