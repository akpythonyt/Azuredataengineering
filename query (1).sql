CREATE TABLE Salarydata(
    UserName	VARCHAR(50),
    Domain	VARCHAR(50),
    Salary		INT
)
    
INSERT INTO Salarydata VALUES ('Fred','USA',10000)
INSERT INTO Salarydata VALUES ('Chris','USA',9500)
INSERT INTO Salarydata VALUES ('Tom','France',9600)
INSERT INTO Salarydata VALUES ('Arun','Spain',9200)
INSERT INTO Salarydata VALUES ('Christopher','Germany',9000)


CREATE USER Fred WITHOUT LOGIN;
GO
CREATE USER Chris WITHOUT LOGIN;
GO
CREATE USER Tom WITHOUT LOGIN;
GO
CREATE USER Arun WITHOUT LOGIN;
GO
CREATE USER Christopher WITHOUT LOGIN;
GO
    
GRANT SELECT ON dbo.Salarydata TO Fred;
GRANT SELECT ON dbo.Salarydata TO Chris;
GRANT SELECT ON dbo.Salarydata TO Tom;
GRANT SELECT ON dbo.Salarydata TO Arun;
GRANT SELECT ON dbo.Salarydata TO Christopher;

CREATE FUNCTION dbo.fn_SalarySecurity(@UserName AS sysname)
    RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS fn_SalarySecurity_Result
    -- Logic for filter predicate
    WHERE @UserName = USER_NAME();
GO

CREATE SECURITY POLICY namefilter
ADD FILTER PREDICATE dbo.fn_SalarySecurity(UserName) 
ON dbo.Salarydata
WITH (STATE = ON);
GO

SELECT * FROM Salarydata

EXECUTE AS USER = 'Arun';
SELECT * FROM [dbo].[Salarydata];
REVERT;
GO