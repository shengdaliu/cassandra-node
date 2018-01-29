CREATE KEYSPACE IF NOT EXISTS stocksexchange WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor': 3};

CREATE TYPE IF NOT EXISTS description (
	Country VARCHAR,
	Sector VARCHAR,
	Industry VARCHAR
);

CREATE TYPE IF NOT EXISTS ratio (
	quick DOUBLE,
	current DOUBLE
);

CREATE TYPE IF NOT EXISTS performance (
	Year DOUBLE,
	HalfYear DOUBLE,
	Month DOUBLE,
	Week DOUBLE
);

CREATE TABLE IF NOT EXISTS stocks (id VARCHAR, 
	Company VARCHAR, 
	Price DOUBLE, 
	EarningDate TIMESTAMP, 
	Description frozen<description>, 
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
	Ratio frozen<ratio>,
	Performance frozen<performance>, 
	PRIMARY KEY (id)
);


INSERT INTO stocks (id, Company, Price, EarningDate, Description, TwentyDaySimpleMovingAverage, TwoHundredDaySimpleMovingAverage, FiftyDay, FiftyTwoWeek, AnalystRecom, AverageTrueRange, AverageVolume, Beta, Change EPSttm ROI Ratio, Performance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

select count(id) from stocks;