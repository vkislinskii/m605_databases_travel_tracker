use("db_nosql")

db.createCollection("reviews")
db.createCollection("events")
db.createCollection("wishlist")

//reviews - create
db.reviews.insertMany([
    {"city_id": 4, "user_id": 1, "rating": 5, "text": "the museums and coffee were amazing!", "tags": ["history", "art"], 
      "photos": ["pic1.jpg", "pic2.jpg"], "created_at": new Date("2025-02-10")},
    {"city_id": 6, "user_id": 1, "rating": 3, "text": "nothing special", "tags": ["boring"], 
      "created_at": new Date("2025-02-15")},
    {"city_id": 7, "user_id": 1, "rating": 4, "text": "the city is beautiful, but the weather was really bad",  
      "photos": ["pic3.jpg", "pic4.jpg", "pic5.jpg", "pic6.jpg", "pic7.jpg"], "created_at": new Date("2025-03-01")},
    {"city_id": 9, "user_id": 2, "rating": 5,  
      "photos": ["pic8.jpg", "pic9.jpg"], "created_at": new Date("2025-02-12")},
    {"city_id": 3, "user_id": 2, "rating": 5, "tags": ["familyvacation", "europe", "culture", "sunset"], "created_at": new Date("2025-02-20")},
    {"city_id": 7, "user_id": 3, "rating": 3, "tags": ["travel"], "photos": ["pic10.jpg"], "created_at": new Date("2025-02-01")},
    {"city_id": 10, "user_id": 3, "rating": 4, "text": "view to the Baltic Sea is something! the rest of the city was ok, nothing special", "tags": ["sea", "travel"], 
      "photos": ["pic11.jpg", "pic12.jpg", "pic13.jpg"], "created_at": new Date("2025-02-25")},
    {"city_id": 8, "user_id": 3, "rating": 5, "tags": ["history", "travel"], "created_at": new Date("2025-03-10")},
    {"city_id": 6, "user_id": 4, "rating": 4, "photos": ["pic14.jpg"], "created_at": new Date("2025-02-02")},
    {"city_id": 6, "user_id": 5, "rating": 4, "text": "Monument to the Battle of the Nations impressed me, but other than that there is nothing to see here", "created_at": new Date("2025-02-05")}  
  ])

//reviews - read
db.reviews.find({"rating" : {$in: [4, 5]}})

//reviews - update
db.reviews.updateOne(
  {$and: [
    {"city_id": 6},
    {"user_id": 1},
    {"created_at": new Date("2025-02-15")}
  ]},
  { $inc: {"rating": 1}}
)

//reviews - delete
db.reviews.deleteMany({"rating": 3})

//////////////////////////////////////
//events - create
db.events.insertMany([
    {"city_id": 1, "name": "Berlin Jazz Festival", "type": "festival", "date": new Date("2025-05-15"), "description": "Jazz festival at Brandenburger Tor", 
      "cost": 45, "artists": ["Snoop Dogg", "Rammstein"]},
    {"city_id": 1, "name": "DRG Forum 2025", "type": "conference", "date": new Date("2025-03-21"), "description": "Conference for hospital managers and decision-makers", 
      "cost": 20},
    {"city_id": 1, "name": "Amnon David Ar: Extended Moments", "type": "Art", "date": new Date("2025-03-08"), "description": "A selection of israeli painter Amnon David Ar pictures", 
      "cost": 15, "artists": "Amnon David Ar"},
    {"city_id": 1, "name": "Stadtbad RELOADED: AMBILIGHT", "type": "Art", "date": new Date("2025-03-30"), "description": "An exhibition of modern art that takes place in a 96-year-old, abandoned swimming pool", 
      "cost": 13},
    {"city_id": 1, "name": "Playful GDR - toy classics from the East", "type": "Exhibition", "date": new Date("2025-10-17"), 
      "description": "Exhibition of GDR toys and the history of an industry", "cost": 8},
    {"city_id": 3, "name": "Magdeburgs großes Speed Dating Event", "type": "Event", "date": new Date("2025-04-06"), "description": "Speed Dating Event", 
      "cost": 23},
    {"city_id": 3, "name": "Depolarize: Dialogue skills for transcending divides", "type": "Webinar", "date": new Date("2025-04-06"), "description": "Explore tools and techniques of dialogue that we can use to reach across differences", 
      "cost": 45.50},
    {"city_id": 3, "name": "Circle of women - Einzeltermine", "type": "Meetup", "date": new Date("2025-04-23"), "description": "Immerse yourself in the power of the Circle of Women, here you can simply be", 
      "cost": 33},
    {"city_id": 2, "name": "Date Night Potsdam", "type": "Event", "date": new Date("2025-03-21"), "description": "Date night - we'll make you fall in love!", 
      "cost": 15},
    {"city_id": 2, "name": "VAN HOLZEN LIVE 2025", "type": "Concert", "date": new Date("2025-04-05"), "description": "Modern alternative rock concert", 
      "cost": 24.70, "artists": ["VAN HOLZEN"]}
  ])

//events - read
db.events.findOne({"city_id": 3})

//events - update
db.events.updateOne(
  {$and: [
    {"name": "Berlin Jazz Festival"},
    {"date": new Date("2025-05-15")}
  ]},
  { $set: {"artists": ["Snoop Dogg", "Rammstein", "Tame Impala"]}}
)

//events - delete
db.events.deleteOne(
    {$and: [
      {"name": "DRG Forum 2025"},
      {"date": new Date("2025-03-21")}
    ]}
  )

//////////////////////////////////////
//wishlist - create
db.wishlist.insertMany([
    {"user_id": 1, "city_id": 3, "public": true, "items": [
      {"name": "Magdeburg Underground Tour", "type": "attraction", "notes": "remember to book VIP access to the underground tunnels"},
      {"name": "Culinaria Restaurant", "type": "restaurant", "notes": "nice pictures, but maybe too expensive"}]},
    {"user_id": 1, "city_id": 4, "public": true, "items": [
      {"name": "Bauhaus Dessau", "type": "museum", "notes": "the pinnacle of pre-war modern design in Europe"},
      {"name": "Technikmuseum Hugo Junkers", "type": "museum", "notes": "watch the plains"}]},
    {"user_id": 1, "city_id": 5, "public": true, "items": [
      {"name": "Insel Ziegenwerder", "type": "park", "notes": "pictures look nice"},
      {"name": "Słubice", "type": "attraction"}]},
    {"user_id": 1, "city_id": 6, "public": true},
    {"user_id": 1, "city_id": 8, "public": false},
    {"user_id": 3, "city_id": 3, "public": false, "items": [
      {"name": "Kunstmuseum Magdeburg - Kloster Unser Lieben Frauen", "type": "attraction"},
      {"name": "Magdeburg Cathedral", "type": "cathedral"}]},
    {"user_id": 3, "city_id": 6, "public": false, "items": [
      {"name": "Monument to the Battle of the Nations", "type": "attraction", "notes": "monument to the 1813 Battle of Leipzig"}]},
    {"user_id": 3, "city_id": 7, "public": false},
    {"user_id": 3, "city_id": 8, "public": false, "items": [
      {"name": "Schwerin Castle", "type": "castle"},
      {"name": "Schleifmühle Schwerin", "type": "museum", "notes": "old wind and watermills"},
      {"name": "Zoo Schwerin", "type": "zoo", "notes": "zoo"}]},
    {"user_id": 3, "city_id": 9, "public": false, "items": [
      {"name": "Jahrtausendbrücke", "type": "attraction"}]}
  ])

//wishlist - read
db.wishlist.find({"items" : {$exists: false}})

//wishlist - update
db.wishlist.updateMany(
  {"user_id": 1},
  { $set: {"public": false}}
)

//wishlist - delete
db.wishlist.deleteMany(
    {$and: [
    {"public": false},
    {"items": {$exists: false}}
  ]}
  )