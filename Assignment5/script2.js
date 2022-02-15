// Map function that gets the zipcodes that start with 9
mapf = function(){
    p = (this.address.zip.startsWith('9'));
    emit(this.address.zip, p);
}

// Reduce function that keeps counter
reducef = function(key, values){
    count = 0;

    for (x of values)
    {
        count = count + x;
    }
    return count;
}

// Map reduce that uses the mapf and reducef functions 
// Outputs collection 
db.customers.mapReduce(mapf, reducef, {out: "script2"});
res = db.script2.find({value: {"$gte": 1}})

// Prints to console 
while ( res.hasNext()) {
    printjson(res.next());
}