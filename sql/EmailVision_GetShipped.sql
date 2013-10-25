
-- =============================================
-- Author:		Mark Richman
-- Create date: 9/12/2013
-- Description:	Get Shipped Orders for EmailVision
-- =============================================
ALTER PROCEDURE [dbo].[EmailVision_GetShipped]

AS
BEGIN

	SET NOCOUNT ON;

	select
		box.ORDERNO, box.TRACKINGNO, cust.FIRSTNAME, box.SHIP_DATE, cust.EMAIL
	from
		box
		inner join cms on (box.orderno = cms.orderno)
		inner join cust on (cust.custnum = cms.custnum)
	where
		cust.email <> ''
		and CUST.EMAIL not like '%@amazon.com'
		and box.trackingno <> ''
		and cms.ship_date >= CAST(CONVERT(varchar(8), DATEADD(d, -1, GETDATE()), 112) AS DATETIME)
	order by cms.ship_date desc

END
