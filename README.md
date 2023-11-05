# Cedarwood
Cedarwood is a weekly pay calculator app for viewing, calculating and exporting payslip data for employees. Developed for macOS using:
+ Python
+ pyodbc
+ SQL
+ SQL Server
+ Docker
+ Tkinter

![Cedarwood GUI](/assets/images/GUI.png)

The documentation for Cedarwood can be found [here](https://paigegoldhagen.github.io/cedarwood-docs)

## Setup instructions
This list outlines the basics of what I did before I started writing the actual program. I’ve included a [setup folder](/assets/setup) which contains the queries and CSV data I used.

1. Download and install [Docker](https://docs.docker.com/engine/install/)

2. In Terminal, set up SQL Server inside a locally hosted Docker container:
```
docker run --platform linux/amd64 -d --name SQLServerExpress -e 'ACCEPT_EULA=Y' -e 'MSSQL_PID=Express' -e 'SA_PASSWORD=[strong password here]' -p 1433:1433 mcr.microsoft.com/mssql/server:2022-latest
```

3. Copy the [CSV files](/assets/setup/csv) to the container

4. Connect to the server using a data management tool (I used Azure Data Studio) and [create the database](/assets/setup/queries/create.sql)

5. [Bulk insert](/assets/setup/queries/insert.sql) the CSV data to the database tables

6. In Terminal, install the packages needed to run Cedarwood:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_ACCEPT_EULA=Y brew install python python-tk unixodbc msodbcsql18 mssql-tools18
pip install --no-binary :all: pyodbc
```

## Running the app (macOS)
1. Download the [latest release](https://github.com/paigegoldhagen/astral/releases/latest)
2. Extract the .zip file
3. Launch `cedarwood_applesilicon` or `cedarwood_intel` executable

On the login page, connect to the localhost SQL Server database using the credentials created during setup.

## Pay calculator functionality
This app uses information from the Australian Taxation Office (ATO) to calculate the weekly gross pay, superannuation, and net pay using the following formulas:
+ Gross pay = `hourly rate * hours worked`
+ Superannuation = `(gross pay * current super guarantee) / 100`[^1]
+ Net pay = `gross pay - tax amount - superannuation`

### Tax formulas
If a Tax File Number (TFN) is not provided:
+ Tax rate = 0.4700 for Australian residents, 0.4500 for foreign residents
+ Tax amount = `gross pay * tax rate`

If a TFN is provided:
+ Get the calculation coefficients from the tax table[^2] based on the earnings range (the tax table varies based on residency and tax threshold being claimed/unclaimed)
+ Tax amount = `coefficient A * (gross pay + 99 cents) - coefficient B`

[^1]:The current [super guarantee percentage](https://www.ato.gov.au/Rates/Key-superannuation-rates-and-thresholds/?page=7) for 2023 - 2024 is 11%
[^2]:Weekly payment [tax tables](https://www.ato.gov.au/Rates/Schedule-1---Statement-of-formulas-for-calculating-amounts-to-be-withheld/?anchor=Coefficientsforcalculationofamountstobew#Coefficientsforcalculationofamountstobew)
