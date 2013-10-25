
/**
By Products Purchased (Time to Reorder)
	Does the customer qualify for being sent an email?
	Does the customer have an email? [If no, disqualify]
	Is the customer’s email in the Do Not Email list? [If yes, then disqualify]
	Did the customer’s email come from Amazon.com [If yes, then disqualify]
	Is the product that the customer ordered an autoship?  [If yes, exclude the autoship product ordered from the logic of this program and put this autoship in the autoship basket.  Keep the non-autoship product in the order remaining in this program]
	Has the qualified email customer made a purchase within the last 90 days?
If yes, apply the following logic:
	How many did the customer order of the same product?
	When did the order with all of the bottles ship?
	From the order’s shipment date add 5 days and then IDENTIFY which orders are at the end of use to QUALIFY for the email.
See examples in README

exec [ListPull_TimeToReorder]

*/

ALTER PROCEDURE [dbo].[ListPull_TimeToReorder]
AS

BEGIN

SELECT
	o.ORDERNO,
	LTRIM(RTRIM(c.EMAIL)) as EMAIL,
	o.ODR_DATE,
	i.ITEM
FROM CMS o
	INNER JOIN ITEMS i ON (o.ORDERNO = i.ORDERNO)
	INNER JOIN CUST c ON (c.CUSTNUM = o.CUSTNUM)
WHERE
	o.ODR_DATE >= DATEADD(DAY , -90, GETDATE())
	AND LEN(i.ITEM) = 5
	AND ISNUMERIC(i.ITEM) = 1
	AND LEN(c.email) > 0
	AND c.email IS NOT NULL
	AND c.email NOT LIKE '%@amazon.com'
ORDER BY o.ORDERNO DESC

END

