// this gets the qty for the orders
mapf1 = function() {
    for (let i = 0; i < this.items.length; i++) {
        emit(this.customer, this.items[i].qty);
    }
};

// this counts the qty 
reducef1 = function(key, values) {
    return {qty: Array.sum(values)};
}

// out 
db.orders.mapReduce(mapf1, reducef1, {out:"orders_out"})
// db.orders_out.find();

// this gets the customerid and zipcode 
mapf2 = function(){
    emit(this.customerId, {zip:this.address.zip});
}

// reduce 
reducef2 = function(key, values) {
    sums = 0
    zip = "" 
    for (x of values) {
        if ("qty" in x) {
            sums = sums + x.qty;
        } 
        if ("zip" in x) {
            zip = x.zip
        }
    }    
    return {qty: sums, zip: zip};
}

// out 
db.customers.mapReduce(mapf2, reducef2, {out:{reduce :"orders_out"}});

// combines the last 2 maps 
mapf3 = function() {
    emit(this.value.zip, this.value.qty)
};

reduce3 = function(key, values) {
    return Array.sum(values)
}

db.orders_out.mapReduce(mapf3, reduce3, {out:"script4_out"});
res = db.script4_out.find().sort({value:-1}).limit(30);

while (res.hasNext()) {
    printjson(res.next());
}