CREATE DATABASE Cedarwood;
GO

use Cedarwood;

CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50)
);

CREATE TABLE Address (
	AddressID INT PRIMARY KEY NOT NULL,
	EmployeeID_Ref INT NOT NULL,
	StreetNumber INT,
	StreetName NVARCHAR(50),
	Suburb NVARCHAR(50),
	StateProvince NVARCHAR(50),
	Postcode NVARCHAR(10),
	Country NVARCHAR(50) NOT NULL,

	FOREIGN KEY (EmployeeID_Ref)
	REFERENCES Employee(EmployeeID)
);

CREATE TABLE TaxInformation (
	TaxInformationID INT PRIMARY KEY NOT NULL,
	EmployeeID_Ref INT NOT NULL,
	TFN INT,
	ThresholdClaimed BIT,

	FOREIGN KEY (EmployeeID_Ref)
	REFERENCES Employee(EmployeeID)
);

GO

ALTER TABLE Employee
ADD
Address_Ref INT NOT NULL,
TaxInformation_Ref INT NOT NULL,
HourlyRate INT,

FOREIGN KEY (Address_Ref)
REFERENCES Address(AddressID),

FOREIGN KEY (TaxInformation_Ref)
REFERENCES TaxInformation(TaxInformationID);

GO

CREATE TABLE PaySummary (
	PaySummaryID INT PRIMARY KEY NOT NULL,
	EmployeeID_Ref INT NOT NULL,
	HoursWorked INT NOT NULL,
	DateSubmitted DATE NOT NULL,

	FOREIGN KEY (EmployeeID_Ref)
	REFERENCES Employee(EmployeeID)
);

GO
