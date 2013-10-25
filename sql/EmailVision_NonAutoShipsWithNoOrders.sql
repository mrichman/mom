-- =============================================
-- Author:
-- Create date: 5/7/2013
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[EmailVision_NonAutoShipsWithNoOrders]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT CUST.CUSTNUM AS CustNum, CUST.FIRSTNAME AS FName, CUST.LASTNAME AS LName, CUST.ADDR, CUST.CITY, CUST.STATE, CUST.ZIPCODE, CUST.EMAIL AS Email, NULL AS Item, NULL AS Assoc, NULL AS AutoShip--, P.Type
	FROM CUST
	--LEFT OUTER JOIN ClubView CV ON CUST.CUSTNUM = CV.BILL_CUST AND ITEMS.ITEM = CV.ITEM
	INNER JOIN EmailSender..Prospect P ON CUST.CUSTNUM = P.CustNum
	WHERE  CUST.CUSTTYPE = 'P' AND CUST.EMAIL > '' AND P.Type > 1 AND CUST.NOEMAIL = 0
                           -- AND (ITEMS.ITEM = '11802')

END
