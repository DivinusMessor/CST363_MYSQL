mapf = function() {
    for (let i = 0; i < this.items.length; i++) {
        emit(this.orderId, this.items[i].qty);
    }
};

reducef = function(key, values) {
    count = 0;
    for (x of values) {
        count += x;
    }
    return (key, count);
};

db.orders.mapReduce(mapf, reducef, {out: "map_reduce"});

mapf2 = function() {
    emit (0, {qty: this.value, count: 1});
};

reducef2 = function(key, values) {
    reducedVal = { count: 0, qty: 0 };
    for (let i = 0; i < values.length; i++) {
        reducedVal.count += values[i].count;
        reducedVal.qty += values[i].qty;
    }
    return reducedVal;
 };

var finalizeFun = function (key, reducedVal) {
    reducedVal.avg = reducedVal.qty/reducedVal.count;
    return reducedVal.avg;
};

db.map_reduce.mapReduce(mapf2, reducef2, { out: "script3", finalize: finalizeFun });

res = db.script3.find();
while(res.hasNext()){
    printjson(res.next())
}   