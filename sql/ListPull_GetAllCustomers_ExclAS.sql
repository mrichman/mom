-- =============================================
-- Author:		Mark Richman
-- Create date: 10/8/2013
-- Description:	Get all customers for ListPull
--     excluding Autoship
-- Example: exec ListPull_GetAllCustomers_ExclAS
-- =============================================
ALTER PROCEDURE [dbo].ListPull_GetAllCustomers_ExclAS
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT
		LTRIM(RTRIM(EMAIL)) AS EMAIL,
		CUSTNUM,
		LTRIM(RTRIM(FIRSTNAME)) AS FIRSTNAME,
		LTRIM(RTRIM(LASTNAME)) AS LASTNAME
	FROM CUST c
	LEFT OUTER JOIN ClubView cv ON(c.CUSTNUM = cv.BILL_CUST)
	WHERE c.NOEMAIL = 0
		AND c.EMAIL IS NOT NULL
		AND c.EMAIL <> ''
		AND c.EMAIL NOT LIKE '%@amazon.com'
		AND cv.Stat <> 'A' -- exclude autoships
	ORDER BY EMAIL ASC
END
