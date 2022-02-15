// Dropping table to reset the database 
db.patients.drop()

// Question 1 and Question 2 answer  
// Inserts the patients with the 30yr old having a prescription 
db.patients.insert({"name": "Heather", "ssn": 222222222, "age": 10, "address": "789 Capitola St"})
db.patients.insert({"name": "Jack", "ssn": 123121234, "age": 20, "address": "345 Street"})
db.patients.insert({name: "Jill", "ssn": 333333333, "age": 30, "address": "543 Diff St", prescriptions : [ { id: "RX743009", tradename : "Hydrochlorothiazide" }, { id : "RX656003", tradename : "LEVAQUIN", formula : "levofloxacin" }]})

// Question 3
// Gets all the patients data
q = db.patients.find()
while (q.hasNext()){
   printjson(q.next())
}

// Question 4
// Get all patients who are 20 yr olds
db.patients.find({age: 20})

// Question 5
// Get patients who are younger than 25
db.patients.find({age: {$lt: 25}})

// Question 6
// Drop patients table 
db.patients.drop()
