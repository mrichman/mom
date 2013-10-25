-- =============================================
-- Author:		Mark Richman
-- Create date: 10/8/2013
-- Description:	Re-engagement File
-- Example: exec ListPull_Reengagement
-- =============================================
ALTER PROCEDURE [dbo].ListPull_Reengagement
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @120daysago DATETIME = DATEADD(DAY, -120, DATEDIFF(DAY,0,GETDATE()))
	PRINT @120daysago
    SELECT
		LTRIM(RTRIM(EMAIL)) AS EMAIL,
		c.CUSTNUM,
		LTRIM(RTRIM(FIRSTNAME)) AS FIRSTNAME,
		LTRIM(RTRIM(LASTNAME)) AS LASTNAME,
		MAX(o.ODR_DATE) AS ODR_DATE
	FROM CUST c
	INNER JOIN CMS o ON (c.CUSTNUM = o.CUSTNUM)
	LEFT OUTER JOIN ClubView cv ON(c.CUSTNUM = cv.BILL_CUST)
	WHERE c.NOEMAIL = 0
		AND c.EMAIL IS NOT NULL
		AND c.EMAIL <> ''
		AND c.EMAIL NOT LIKE '%@amazon.com'
		AND cv.Stat <> 'A' -- exclude autoships
		AND o.ODR_DATE <= @120daysago
	GROUP BY EMAIL, c.CUSTNUM, FIRSTNAME, LASTNAME
	ORDER BY MAX(o.ODR_DATE) DESC
END
