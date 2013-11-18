USE [Mom-Nutri-Health]
GO
/****** Object:  StoredProcedure [dbo].[ListPull_Reengagement]    Script Date: 11/07/2013 05:32:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mark Richman
-- Create date: 10/8/2013
-- Description:	Re-engagement File
-- Example: exec ListPull_Reengagement
-- =============================================
ALTER PROCEDURE [dbo].[ListPull_Reengagement]
AS
BEGIN
	SET NOCOUNT ON;
	
	;WITH CTE_LastOrder(CUSTNUM, ODR_DATE) AS
	(
		SELECT o.CUSTNUM, MAX(o.ODR_DATE) ODR_DATE
		FROM CMS o
		GROUP By o.CUSTNUM
	)
	
    SELECT 
		LTRIM(RTRIM(EMAIL)) AS EMAIL,
		c.CUSTNUM,
		LTRIM(RTRIM(FIRSTNAME)) AS FIRSTNAME,
		LTRIM(RTRIM(LASTNAME)) AS LASTNAME,
		-- MAX(o.ODR_DATE) AS ODR_DATE,
		0 AS ACTIVE
	FROM CUST c
	INNER JOIN CMS o ON (c.CUSTNUM = o.CUSTNUM)
	JOIN CTE_LastOrder LO ON (c.CUSTNUM = LO.CUSTNUM)
	LEFT OUTER JOIN ClubView cv ON(c.CUSTNUM = cv.BILL_CUST)
	WHERE c.NOEMAIL = 0
		AND c.EMAIL IS NOT NULL
		AND c.EMAIL <> ''
		AND c.EMAIL NOT LIKE '%@amazon.com'
		AND cv.Stat <> 'A' -- exclude autoships
		AND LO.ODR_DATE <= DATEADD(MONTH, -3, CURRENT_TIMESTAMP)
	GROUP BY EMAIL, c.CUSTNUM, FIRSTNAME, LASTNAME
	ORDER BY MAX(o.ODR_DATE) DESC
	
END
