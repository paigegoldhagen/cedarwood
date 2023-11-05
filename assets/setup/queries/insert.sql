use Cedarwood;

BULK INSERT Employee
FROM '/Cedarwood_Employee.csv'
WITH (FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\r\n',
	BATCHSIZE = 250000,
	MAXERRORS = 2);

BULK INSERT Address
FROM '/Cedarwood_Address.csv'
WITH (FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\r\n',
	BATCHSIZE = 250000,
	MAXERRORS = 2);

BULK INSERT TaxInformation
FROM '/Cedarwood_TaxInformation.csv'
WITH (FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\r\n',
	BATCHSIZE = 250000,
	MAXERRORS = 2);

SET DATEFORMAT DMY;

BULK INSERT PaySummary
FROM '/Cedarwood_PaySummary.csv'
WITH (FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\r\n',
	BATCHSIZE = 250000,
	MAXERRORS = 2);

GO