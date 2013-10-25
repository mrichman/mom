-- =============================================
-- Author:		Lance Ricci
-- Create date: 5/7/2013
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[EmailVision_NonAutoShipsWithOrders]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    /*
	SELECT DISTINCT C.CUSTNUM, C.ALTNUM, C.FIRSTNAME, C.LASTNAME, C.ADDR, C.CITY, C.STATE, C.ZIPCODE, C.EMAIL, I.ITEM
           FROM CUST C
           LEFT OUTER JOIN ClubView CV ON C.CUSTNUM = CV.BILL_CUST
           INNER JOIN CMS ON C.CUSTNUM = CMS.CUSTNUM
           INNER JOIN ITEMS I ON CMS.ORDERNO = I.ORDERNO
           WHERE C.EMAIL <> '' AND C.NOEMAIL = 0 AND CV.Stat <> 'A' AND CMS.ORDER_ST2 = 'SH' AND I.ITEM_STATE = 'SH' AND I.IT_UNLIST > 0  AND NOT I.ITEM LIKE 'C%'
    --UNION ALL
    SELECT DISTINCT C.CUSTNUM, C.ALTNUM, C.FIRSTNAME, C.LASTNAME, C.ADDR, C.CITY, C.STATE, C.ZIPCODE, C.EMAIL, I.ITEM
           FROM CUST C
           INNER JOIN ClubView CV ON C.CUSTNUM = CV.BILL_CUST
           LEFT OUTER JOIN ITEMS I ON CV.OrdNum = I.ORDERNO
           WHERE C.EMAIL <> ''  AND CV.Stat <> 'A'
           */
           /*
           SELECT DISTINCT C.CUSTNUM, C.ALTNUM, C.FIRSTNAME, C.LASTNAME, C.ADDR, C.CITY, C.STATE, C.ZIPCODE, C.EMAIL, I.ITEM
           FROM CUST C
           --LEFT OUTER JOIN ClubView CV ON C.CUSTNUM = CV.BILL_CUST
           INNER JOIN CMS ON C.CUSTNUM = CMS.CUSTNUM
           INNER JOIN ITEMS I ON CMS.ORDERNO = I.ORDERNO
           WHERE C.EMAIL <> ''
           AND C.NOEMAIL = 0
           --AND CV.Stat <> 'A'
           AND CMS.ORDER_ST2 = 'SH'
           AND I.ITEM_STATE = 'SH'
           AND I.IT_UNLIST > 0
           AND NOT I.ITEM LIKE 'C%'
           AND (NOT (C.CUSTNUM IN
                          (SELECT DISTINCT CLUB_CUST
                            FROM          [Mom-Nutri-Health].dbo.CLUBSUBS
                            WHERE      (STATUS = 'A'))))
                            */
    SELECT DISTINCT CMS.CUSTNUM AS CustNum, CUST.FIRSTNAME AS FName, CUST.LASTNAME AS LName, CUST.ADDR, CUST.CITY, CUST.STATE, CUST.ZIPCODE, CUST.EMAIL AS Email, ITEMS.ITEM, STOCK.ASSOC, CV.Stat AS AutoShip--, P.Type
	FROM CUST
	INNER JOIN CMS ON CUST.CUSTNUM = CMS.CUSTNUM
	INNER JOIN ITEMS ON ITEMS.ORDERNO = CMS.ORDERNO
	INNER JOIN STOCK ON ITEMS.ITEM = STOCK.NUMBER
	INNER JOIN EmailSender..Prospect P ON CUST.CUSTNUM = P.CustNum
	INNER JOIN ClubView CV ON CUST.CUSTNUM = CV.BILL_CUST --AND ITEMS.ITEM = CV.ITEM
	WHERE (STOCK.ASSOC = 'FG' OR STOCK.ASSOC = 'DISCONTINUED') AND CUST.EMAIL > '' AND P.TYPE > 1 AND CUST.NOEMAIL = 0 AND NOT (CUST.CUSTNUM IN
                          (SELECT DISTINCT ClubView.BILL_CUST
                            FROM          ClubView
                            WHERE ClubView.Stat = 'A'
                            ))

                           -- AND (ITEMS.ITEM = '11802')
	ORDER BY ITEMS.ITEM --, CUST.EMAIL



END
