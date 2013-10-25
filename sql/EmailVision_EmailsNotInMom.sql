-- =============================================
-- Author:
-- Create date: 5/8/2013
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[EmailVision_EmailsNotInMom]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT CustNum, FName, LName, NULL AS Address, NULL AS City, NULL AS State, NULL AS ZIP, Email, NULL AS ITEM, NULL AS Assoc, NULL AS AutoShip
	FROM EmailSender..Prospect P
	WHERE P.Type > 1 AND P.Source > 1 AND P.Unsubed = 0 AND P.Email NOT LIKE 'test%' AND CustNum IS NULL
	ORDER BY Email
END
