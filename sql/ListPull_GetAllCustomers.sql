-- =============================================
-- Author:		Mark Richman
-- Create date: 10/3/2013
-- Description:	Get all customers for ListPull
-- Example: exec ListPull_GetAllCustomers
-- =============================================
ALTER PROCEDURE [dbo].ListPull_GetAllCustomers
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
	WHERE c.NOEMAIL = 0
		AND c.EMAIL IS NOT NULL
		AND c.EMAIL <> ''
		AND c.EMAIL NOT LIKE '%@amazon.com'
	ORDER BY EMAIL ASC
END
