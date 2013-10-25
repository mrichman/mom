-- =============================================
-- Author:
-- Create date: 5/7/2013
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[EmailVision_AutoShips]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    /*
	SELECT DISTINCT C.CUSTNUM, C.ALTNUM, C.FIRSTNAME, C.LASTNAME, C.ADDR, C.CITY, C.STATE, C.ZIPCODE, C.EMAIL, CV.ITEM--, CV.OrdNum, I.ITEM, CMS.ORDERNO
           FROM ClubView CV
           INNER JOIN CUST C ON CV.BILL_CUST = C.CUSTNUM

           --INNER JOIN CMS ON C.CUSTNUM = CMS.CUSTNUM
           INNER JOIN ITEMS I ON CV.OrdNum = I.ORDERNO
           WHERE CV.Stat = 'A' AND C.EMAIL <> '' AND CV.ClubPrice > 0 AND I.ITEM_STATE = 'SH' AND NOT I.ITEM_STATE = 'SV'--AND I.ITEM_STATE = 'SH' AND I.IT_UNLIST > 0 AND NOT I.ITEM LIKE 'C%'
           --Order By C.CUSTNUM
           */
           /*
           SELECT DISTINCT C.CUSTNUM, C.ALTNUM, C.FIRSTNAME, C.LASTNAME, C.ADDR, C.CITY, C.STATE, C.ZIPCODE, C.EMAIL, I.ITEM--, CV.OrdNum, I.ITEM, CMS.ORDERNO
           FROM CUST C
           INNER JOIN CLUBSUBS CC ON C.CUSTNUM = CC.BILL_CUST

           --INNER JOIN CMS ON C.CUSTNUM = CMS.CUSTNUM
           INNER JOIN ITEMS I ON CC.ORDERNO = I.ORDERNO
           WHERE CC.STATUS = 'A' AND C.EMAIL <> '' AND CC.PRICE > 0--AND CV.ClubPrice > 0 AND I.ITEM_STATE = 'SH' AND NOT I.ITEM_STATE = 'SV'--AND I.ITEM_STATE = 'SH' AND I.IT_UNLIST > 0 AND NOT I.ITEM LIKE 'C%'

           SELECT DISTINCT CLUB_CUST, TRIG_ITEM, ORDERNO
                            FROM          [Mom-Nutri-Health].dbo.CLUBSUBS
                            WHERE      STATUS = 'A'
           */

           SELECT DISTINCT CMS.CUSTNUM AS CustNum, CUST.FIRSTNAME AS FName, CUST.LASTNAME AS LName, CUST.ADDR AS Address, CUST.CITY AS City, CUST.STATE AS State, CUST.ZIPCODE AS Zip,
			CUST.EMAIL AS Email, ITEMS.ITEM, STOCK.ASSOC AS Assoc, CV.Stat AS AutoShip--, P.Type
	FROM CUST INNER JOIN CMS ON CUST.CUSTNUM = CMS.CUSTNUM
				INNER JOIN ITEMS ON ITEMS.ORDERNO = CMS.ORDERNO
				INNER JOIN STOCK ON ITEMS.ITEM = STOCK.NUMBER
				INNER JOIN ClubView CV ON CUST.CUSTNUM = CV.BILL_CUST AND ITEMS.ITEM = CV.ITEM
				INNER JOIN EmailSender..Prospect P ON CUST.CUSTNUM = P.CustNum
	WHERE --(SHIP_DATE BETWEEN DATEADD(M, -24, GETDATE()) AND DATEADD(M, -18, GETDATE())) AND
			 (STOCK.ASSOC = 'FG') AND (CUST.EMAIL > '') AND (CV.Stat = 'A') AND CUST.NOEMAIL = 0--AND (ITEMS.ITEM = '10400')
	ORDER BY ITEMS.ITEM --, CUST.EMAIL


END
