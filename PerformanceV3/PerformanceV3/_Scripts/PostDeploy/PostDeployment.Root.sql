SET NOCOUNT ON;

-- data distribution settings for orders
DECLARE
  @numorders   AS INT      =   1000000,
  @numcusts    AS INT      =     20000,
  @numemps     AS INT      =       500,
  @numshippers AS INT      =         5,
  @numyears    AS INT      =         4,
  @startdate   AS DATE     = '20110101';

-- creating and populating the Customers table

INSERT INTO dbo.Customers(custid, custname)
  SELECT
    'C' + RIGHT('000000000' + CAST(n AS VARCHAR(10)), 10) AS custid,
    N'Cust_' + CAST(n AS VARCHAR(10)) AS custname
  FROM dbo.GetNums(1, @numcusts);

-- creating and populating the Employees table

INSERT INTO dbo.Employees(empid, firstname, lastname)
  SELECT n AS empid,
    N'Fname_' + CAST(n AS NVARCHAR(10)) AS firstname,
    N'Lname_' + CAST(n AS NVARCHAR(10)) AS lastname
  FROM dbo.GetNums(1, @numemps);

-- creating and populating the Shippers table
INSERT INTO dbo.Shippers(shipperid, shippername)
  SELECT shipperid, N'Shipper_' + shipperid AS shippername
  FROM (SELECT CHAR(ASCII('A') - 2 + 2 * n) AS shipperid
        FROM dbo.GetNums(1, @numshippers)) AS D;

-- creating and populating the Orders table

INSERT INTO dbo.Orders(orderid, custid, empid, shipperid, orderdate)
  SELECT n AS orderid,
    'C' + RIGHT('000000000'
            + CAST(
                1 + ABS(CHECKSUM(NEWID())) % @numcusts
                AS VARCHAR(10)), 10) AS custid,
    1 + ABS(CHECKSUM(NEWID())) % @numemps AS empid,
    CHAR(ASCII('A') - 2
           + 2 * (1 + ABS(CHECKSUM(NEWID())) % @numshippers)) AS shipperid,
      DATEADD(day, n / (@numorders / (@numyears * 365.25))
                   -- late arrival with earlier date
	                 - CASE WHEN n % 10 = 0
                       THEN 1 + ABS(CHECKSUM(NEWID())) % 30
                       ELSE 0 
                     END, @startdate)
         AS orderdate
  FROM dbo.GetNums(1, @numorders)
  ORDER BY CHECKSUM(NEWID())
OPTION(MAXDOP 1);

-- data distribution settings for dw (2,500,000 rows)
DECLARE
  @dim1rows AS INT = 250,
  @dim2rows AS INT = 50,
  @dim3rows AS INT = 200;

INSERT INTO dbo.Dim1(key1, attr1)
  SELECT n, ABS(CHECKSUM(NEWID())) % 20 + 1
  FROM dbo.GetNums(1, @dim1rows);

INSERT INTO dbo.Dim2(key2, attr1)
  SELECT n, ABS(CHECKSUM(NEWID())) % 10 + 1
  FROM dbo.GetNums(1, @dim2rows);

INSERT INTO dbo.Dim3(key3, attr1)
  SELECT n, ABS(CHECKSUM(NEWID())) % 40 + 1
  FROM dbo.GetNums(1, @dim3rows);

INSERT INTO dbo.Fact WITH (TABLOCK) 
    (key1, key2, key3, measure1, measure2, measure3, measure4)
  SELECT D1.key1, D2.key2, D3.key3,
    ABS(CHECKSUM(NEWID())) % 10000 + 1,
    ABS(CHECKSUM(NEWID())) % 100000 + 1,
    ABS(CHECKSUM(NEWID())) % 1000000 + 1,
    N'S' + REPLICATE(CAST(ABS(CHECKSUM(NEWID())) % 100000 + 1 AS NVARCHAR(10)), 5)
  FROM dbo.Dim1 AS D1
    CROSS JOIN dbo.Dim2 AS D2
    CROSS JOIN dbo.Dim3 AS D3;
