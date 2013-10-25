CREATE PROCEDURE [dbo].[ListPull_GetCatXSell]
	@item_list varchar(max)
AS

DECLARE @tbl TABLE (id VARCHAR(7))

INSERT @tbl SELECT * FROM SplitList(@item_list, ',')

BEGIN

SELECT DISTINCT
	(LTRIM(RTRIM(c.email))) AS email
FROM
	CMS o
INNER JOIN ITEMS i ON (o.ORDERNO = i.ORDERNO)
INNER JOIN CUST c ON (c.CUSTNUM = o.CUSTNUM)
WHERE
	i.ITEM IN (SELECT id FROM @tbl)
AND o.ODR_DATE >= DATEADD(DAY ,- 2, GETDATE())
AND LEN(c.email) > 0
AND c.email IS NOT NULL
AND c.email NOT LIKE '%@amazon.com'

END

