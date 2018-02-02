var cassandra = require('cassandra-driver');
var async = require('async');
var fs = require('fs');
const readline = require('readline');

// This function convert keys of a json collection to lowercase
function ConvertKeysToLowerCase(obj) {
    var output = {};
    for (i in obj) {
        if (Object.prototype.toString.apply(obj[i]) === '[object Object]') {
           output[i.toLowerCase()] = ConvertKeysToLowerCase(obj[i]);
        }else if(Object.prototype.toString.apply(obj[i]) === '[object Array]'){
			output[i.toLowerCase()]=[];
             output[i.toLowerCase()].push(ConvertKeysToLowerCase(obj[i][0]));
        } else {
            output[i.toLowerCase()] = obj[i];
        }
    }
    return output;
};

//Connect to the cluster
var client = new cassandra.Client({
    contactPoints: ['127.0.0.1'],
    keyspace: 'stocksexchange'
});

// Streaming the stock.json file
const rl = readline.createInterface({
    input: fs.createReadStream('stocks.json')
});

// Read the json file line by line then convert the data and call the insert statement to the cassandra database
rl.on('line', function (line) {
    var jsonObject = JSON.parse(line);

    var date = null;
    if (jsonObject['Earnings Date'] !== null) {
        date = Date.parse(jsonObject['Earnings Date'].$date);
    }

    var description = JSON.parse(JSON.stringify(ConvertKeysToLowerCase(jsonObject.description)));
    var performance = JSON.parse(JSON.stringify(ConvertKeysToLowerCase(jsonObject.performance)).replace("half year", "halfyear"));

    var params = [jsonObject._id.$oid, jsonObject.Company,
        jsonObject.Price, date,
        description, jsonObject["20-Day Simple Moving Average"],
        jsonObject["200-Day Simple Moving Average"], jsonObject["50-Day"],
        jsonObject["52-Week"], jsonObject["Analyst Recom"],
        jsonObject["Average True Range"], jsonObject["Average Volume"],
        jsonObject.Beta, jsonObject.Change,
        jsonObject["EPS ttm"], jsonObject.ROI,
        jsonObject.ratio, performance
    ];

    // console.log(params);

    const query = 'INSERT INTO stocks (id, Company, Price, EarningDate, Description, TwentyDaySimpleMovingAverage, TwoHundredDaySimpleMovingAverage, FiftyDay, FiftyTwoWeek, AnalystRecom, AverageTrueRange, AverageVolume, Beta, Change, EPSttm, ROI, Ratio, Performance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    client.execute(query, params, { prepare: true });
});
