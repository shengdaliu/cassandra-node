CREATE KEYSPACE IF NOT EXISTS stocksexchange WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor': 3};

CREATE TABLE IF NOT EXISTS stocks (id VARCHAR, 
	Company VARCHAR, 
	Price DOUBLE, 
	EarningDate TIMESTAMP, 
	Description MAP<VARCHAR,VARCHAR>, 
	TwentyDaySimpleMovingAverage DOUBLE, 
	TwoHundredDaySimpleMovingAverage DOUBLE, 
	FiftyDay LIST<DOUBLE>, 
	FiftyTwoWeek LIST<DOUBLE>, 
	AnalystRecom DOUBLE, 
	AverageTrueRange DOUBLE, 
	AverageVolume DOUBLE, 
	Beta DOUBLE, 
	Change DOUBLE,
	EPSttm DOUBLE,
	ROI DOUBLE,
	Ratio MAP<VARCHAR, DOUBLE>,
	Performance MAP<VARCHAR, DOUBLE>, 
	PRIMARY KEY (id)
);


INSERT INTO stocks (id, Company, Price, EarningDate, Description, TwentyDaySimpleMovingAverage, TwoHundredDaySimpleMovingAverage, FiftyDay, FiftyTwoWeek, AnalystRecom, AverageTrueRange, AverageVolume, Beta, Change EPSttm ROI Ratio, Performance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
