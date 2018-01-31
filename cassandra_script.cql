CREATE KEYSPACE IF NOT EXISTS stocksexchange WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor': 3};

DROP TABLE stocks;
DROP TYPE IF EXISTS description;
DROP TYPE IF EXISTS ratio;
DROP TYPE IF EXISTS performance;

CREATE TYPE IF NOT EXISTS description (
	country VARCHAR,
	sector VARCHAR,
	industry VARCHAR
);

CREATE TYPE IF NOT EXISTS ratio (
	quick DOUBLE,
	current DOUBLE
);

CREATE TYPE IF NOT EXISTS performance (
	year DOUBLE,
	halfyear DOUBLE,
	month DOUBLE,
	week DOUBLE
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

-- INSERT INTO stocks (id, Company, Price, EarningDate, Description, TwentyDaySimpleMovingAverage, TwoHundredDaySimpleMovingAverage, FiftyDay, FiftyTwoWeek, AnalystRecom, AverageTrueRange, AverageVolume, Beta, Change EPSttm ROI Ratio, Performance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- select count(id) from stocks;

-- 6756 lines