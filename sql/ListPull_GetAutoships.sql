-- =============================================
-- Author:		Mark Richman
-- Create date: 10/9/2013
-- Description: Gets all Autoship customers shipping in the next 7 days
-- Example:     exec ListPull_GetAutoships
-- =============================================
ALTER PROCEDURE [dbo].[ListPull_GetAutoships]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT DISTINCT
		CMS.CUSTNUM,
		LTRIM(RTRIM(CUST.FIRSTNAME)) AS FIRSTNAME,
		LTRIM(RTRIM(CUST.LASTNAME)) AS LASTNAME,
		LTRIM(RTRIM(CUST.EMAIL)) AS EMAIL
		-- SHIP_DATE
	FROM CUST
		INNER JOIN CMS ON CUST.CUSTNUM = CMS.CUSTNUM
		INNER JOIN ITEMS ON ITEMS.ORDERNO = CMS.ORDERNO
		INNER JOIN STOCK ON ITEMS.ITEM = STOCK.NUMBER
		INNER JOIN ClubView CV ON CUST.CUSTNUM = CV.BILL_CUST AND ITEMS.ITEM = CV.ITEM
	WHERE SHIP_DATE >= DATEADD(DAY, -21, GETDATE())
		-- orders shipped 3 weeks ago will ship again in 1 week
		AND STOCK.ASSOC = 'FG'
		AND CUST.EMAIL <> ''
		AND CUST.EMAIL IS NOT NULL
		AND CV.Stat = 'A'
		AND CUST.NOEMAIL = 0
	ORDER BY EMAIL

END
