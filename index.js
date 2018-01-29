var cassandra = require('cassandra-driver');
var async = require('async');
var fs = require('fs');
const readline = require('readline');

//Connect to the cluster
var client = new cassandra.Client({
    contactPoints: ['127.0.0.1'],
    keyspace: 'stocksexchange'
});

const rl = readline.createInterface({
    input: fs.createReadStream('stocks.json')
});

rl.on('line', function (line) {
    var jsonObject = JSON.parse(line);
    var date = null;
    if (jsonObject["Earnings Date"] !== null) {
        date = Date.parse(jsonObject["Earnings Date"].$date);
    }
    var params = [jsonObject._id.$oid, jsonObject.Company,
        jsonObject.Price, date,
        jsonObject.description, jsonObject["20-Day Simple Moving Average"],
        jsonObject["200-Day Simple Moving Average"], jsonObject["50-Day"],
        jsonObject["52-Week"], jsonObject["Analyst Recom"],
        jsonObject["Average True Range"], jsonObject["Average Volume"],
        jsonObject.Beta, jsonObject.Change,
        jsonObject["EPS ttm"], jsonObject.ROI,
        jsonObject.ratio, jsonObject.performance
    ];

    const query = 'INSERT INTO stocks (id, Company, Price, EarningDate, Description, TwentyDaySimpleMovingAverage, TwoHundredDaySimpleMovingAverage, FiftyDay, FiftyTwoWeek, AnalystRecom, AverageTrueRange, AverageVolume, Beta, Change, EPSttm, ROI, Ratio, Performance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    client.execute(query, params, {
            prepare: true
        })
        // .then(result => console.log('Results: %s', JSON.stringify(result)));
});

