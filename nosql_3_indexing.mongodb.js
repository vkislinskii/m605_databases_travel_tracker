use("db_nosql")

//searching all user's reviews
db.reviews.find({"user_id" : 5}).explain("executionStats")

db.reviews.createIndex({ "user_id": 1 }) 


//searching all events in the city
db.events.find({"city_id" : 3}).explain("executionStats") 

db.events.createIndex({ "city_id": 1 })