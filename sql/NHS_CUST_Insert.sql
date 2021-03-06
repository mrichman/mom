USE [MailOrderManager]
GO

-- EXEC Amazon_CUST_Insert @FIRSTNAME='John', @LASTNAME='Doe'

IF OBJECT_ID('[dbo].[NHS_CUST_Insert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[NHS_CUST_Insert] 
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[NHS_CUST_Insert] 
    @ALTNUM CHAR(15) = '',
    @CUSTTYPE CHAR(1) = '',
    @LASTNAME CHAR(20) = '',
    @FIRSTNAME CHAR(15) = '',
    @COMPANY CHAR(40) = '',
    @ADDR CHAR(40) = '',
    @ADDR2 CHAR(40) = '',
    @CITY CHAR(30) = '',
    @COUNTY CHAR(3) = '',
    @STATE CHAR(3) = '',
    @ZIPCODE CHAR(10) = '',
    @COUNTRY CHAR(3) = '',
    @PHONE CHAR(18) = '',
    @PHONE2 CHAR(18) = '',
    @ORIG_AD CHAR(9) = '',
    @CTYPE CHAR(1) = '',
    @LAST_AD CHAR(9) = '',
    @CATCOUNT NUMERIC(3,0) = 0,
    @ODR_DATE DATETIME = NULL,
    @PAYMETHOD CHAR(2) = '',
    @CARDNUM CHAR(60) = '',
    @CARDTYPE CHAR(2) = '',
    @EXP CHAR(5) = '',
    @SHIPLIST CHAR(3) = '',
    @EXPIRED BIT = 0,
    @BADCHECK BIT = 0,
    @ORDERREC NUMERIC(8,0) = 0,
    @NET NUMERIC(10,2) = 0,
    @GROSS NUMERIC(10, 2) = 0,
    @ORD_FREQ NUMERIC(6, 0) = 0,
    @COMMENT CHAR(60) = '',
    @CUSTBAL NUMERIC(9, 2) = 0,
    @CUSTREF NUMERIC(8, 0) = 0,
    @DISCOUNT NUMERIC(3, 0) = 0,
    @EXEMPT BIT = '',
    @AR_BALANCE NUMERIC(11, 2) = 0,
    @CREDIT_LIM NUMERIC(9, 0) = 0,
    @DISCT_DAYS NUMERIC(3, 0) = 0,
    @DUE_DAYS NUMERIC(3, 0) = 0,
    @DISCT_PCT NUMERIC(4, 1) = 0,
    @PROMO_BAL NUMERIC(6, 2) = 0,
    @COMMENT2 CHAR(60) = '',
    @SALES_ID CHAR(3) = '',
    @NOMAIL BIT = 0,
    @BELONGNUM NUMERIC(10, 0) = 0,
    @CTYPE2 CHAR(2) = '',
    @CTYPE3 CHAR(4) = '',
    @CARROUTE CHAR(4) = '',
    @DELPOINT CHAR(3) = '',
    @NCOACHANGE CHAR(1) = '',
    @ENTRYDATE DATETIME = NULL,
    @SEARCHCOMP CHAR(15) = '',
    @EMAIL CHAR(75) = '',
    @N_EXEMPT BIT = 0,
    @TAX_ID CHAR(15) = '',
    @CASHONLY BIT = 0,
    @SALU CHAR(6) = '',
    @HONO CHAR(6) = '',
    @TITLE CHAR(40) = '',
    @NOEMAIL BIT = 0,
    @PASSWORD CHAR(20) = '',
    @RFM NUMERIC(5, 0) = 0,
    @POINTS NUMERIC(8, 0) = 0,
    @NORENT BIT = 0,
    @ADDR_TYPE CHAR(1) = '',
    @WEB CHAR(50) = '',
    @EXTENSION CHAR(5) = '',
    @EXTENSION2 CHAR(5) = '',
    @DATE_LIMIT CHAR(1) = '',
    @START_DATE DATETIME = NULL,
    @END_DATE DATETIME = NULL,
    @FROM_MONTH NUMERIC(2, 0) = 0,
    @FROM_DAY NUMERIC(2, 0) = 0,
    @TO_MONTH NUMERIC(2, 0) = 0,
    @TO_DAY NUMERIC(2, 0) = 0,
    @ADDRISSAME BIT = 0,
    @LASTUSER CHAR(3) = '',
    @NOPOINTS BIT = 0,
    @UPSCOMDELV BIT = 0,
    @PREF_SHIP CHAR(3) = '',
    @PREF_PAY CHAR(2) = '',
    @ADDR3 CHAR(40) = '',
    @VALADDR CHAR(2) = '',
    @VALDATE DATETIME = NULL,
    @SOUNDLNAME CHAR(4) = '',
    @ADDREXPIRE DATETIME = NULL,
    @ACVMEDATE DATETIME = NULL,
    @MODI_USER CHAR(3) = '',
    @MODI_DATE DATETIME = NULL,
    @ACT_DATE DATETIME = NULL,
    @DSCTSTDATE DATETIME = NULL,
    @DSCTENDATE DATETIME = NULL,
    @PREFWARE CHAR(6) = '',
    @BESTTTC CHAR(13) = '',
    @FRAUD BIT = 0,
    @NOCALL BIT = 0,
    @TAX_ID2 CHAR(15) = '',
    @EMAILDEF CHAR(8) = '',
    @EMAILPREF CHAR(5) = '',
    @NOFAX BIT = 0,
    @C_EXEMPT BIT = 0,
    @I_EXEMPT BIT = 0,
    @CUST_TERMS BIT = 0
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[CUST] ([ALTNUM], [CUSTTYPE], [LASTNAME], [FIRSTNAME], [COMPANY], [ADDR], [ADDR2], [CITY], [COUNTY], [STATE], [ZIPCODE], [COUNTRY], [PHONE], [PHONE2], [ORIG_AD], [CTYPE], [LAST_AD], [CATCOUNT], [ODR_DATE], [PAYMETHOD], [CARDNUM], [CARDTYPE], [EXP], [SHIPLIST], [EXPIRED], [BADCHECK], [ORDERREC], [NET], [GROSS], [ORD_FREQ], [COMMENT], [CUSTBAL], [CUSTREF], [DISCOUNT], [EXEMPT], [AR_BALANCE], [CREDIT_LIM], [DISCT_DAYS], [DUE_DAYS], [DISCT_PCT], [PROMO_BAL], [COMMENT2], [SALES_ID], [NOMAIL], [BELONGNUM], [CTYPE2], [CTYPE3], [CARROUTE], [DELPOINT], [NCOACHANGE], [ENTRYDATE], [SEARCHCOMP], [EMAIL], [N_EXEMPT], [TAX_ID], [CASHONLY], [SALU], [HONO], [TITLE], [NOEMAIL], [PASSWORD], [RFM], [POINTS], [NORENT], [ADDR_TYPE], [WEB], [EXTENSION], [EXTENSION2], [DATE_LIMIT], [START_DATE], [END_DATE], [FROM_MONTH], [FROM_DAY], [TO_MONTH], [TO_DAY], [ADDRISSAME], [LASTUSER], [NOPOINTS], [UPSCOMDELV], [PREF_SHIP], [PREF_PAY], [ADDR3], [VALADDR], [VALDATE], [SOUNDLNAME], [ADDREXPIRE], [ACVMEDATE], [MODI_USER], [MODI_DATE], [ACT_DATE], [DSCTSTDATE], [DSCTENDATE], [PREFWARE], [BESTTTC], [FRAUD], [NOCALL], [TAX_ID2], [EMAILDEF], [EMAILPREF], [NOFAX], [C_EXEMPT], [I_EXEMPT], [CUST_TERMS])
	SELECT @ALTNUM, @CUSTTYPE, @LASTNAME, @FIRSTNAME, @COMPANY, @ADDR, @ADDR2, @CITY, @COUNTY, @STATE, @ZIPCODE, @COUNTRY, @PHONE, @PHONE2, @ORIG_AD, @CTYPE, @LAST_AD, @CATCOUNT, @ODR_DATE, @PAYMETHOD, @CARDNUM, @CARDTYPE, @EXP, @SHIPLIST, @EXPIRED, @BADCHECK, @ORDERREC, @NET, @GROSS, @ORD_FREQ, @COMMENT, @CUSTBAL, @CUSTREF, @DISCOUNT, @EXEMPT, @AR_BALANCE, @CREDIT_LIM, @DISCT_DAYS, @DUE_DAYS, @DISCT_PCT, @PROMO_BAL, @COMMENT2, @SALES_ID, @NOMAIL, @BELONGNUM, @CTYPE2, @CTYPE3, @CARROUTE, @DELPOINT, @NCOACHANGE, @ENTRYDATE, @SEARCHCOMP, @EMAIL, @N_EXEMPT, @TAX_ID, @CASHONLY, @SALU, @HONO, @TITLE, @NOEMAIL, @PASSWORD, @RFM, @POINTS, @NORENT, @ADDR_TYPE, @WEB, @EXTENSION, @EXTENSION2, @DATE_LIMIT, @START_DATE, @END_DATE, @FROM_MONTH, @FROM_DAY, @TO_MONTH, @TO_DAY, @ADDRISSAME, @LASTUSER, @NOPOINTS, @UPSCOMDELV, @PREF_SHIP, @PREF_PAY, @ADDR3, @VALADDR, @VALDATE, @SOUNDLNAME, @ADDREXPIRE, @ACVMEDATE, @MODI_USER, @MODI_DATE, @ACT_DATE, @DSCTSTDATE, @DSCTENDATE, @PREFWARE, @BESTTTC, @FRAUD, @NOCALL, @TAX_ID2, @EMAILDEF, @EMAILPREF, @NOFAX, @C_EXEMPT, @I_EXEMPT, @CUST_TERMS
	
	-- Begin Return Select <- do not remove
	SELECT [CUSTNUM], [ALTNUM], [CUSTTYPE], [LASTNAME], [FIRSTNAME], [COMPANY], [ADDR], [ADDR2], [CITY], [COUNTY], [STATE], [ZIPCODE], [COUNTRY], [PHONE], [PHONE2], [ORIG_AD], [CTYPE], [LAST_AD], [CATCOUNT], [ODR_DATE], [PAYMETHOD], [CARDNUM], [CARDTYPE], [EXP], [SHIPLIST], [EXPIRED], [BADCHECK], [ORDERREC], [NET], [GROSS], [ORD_FREQ], [COMMENT], [CUSTBAL], [CUSTREF], [DISCOUNT], [EXEMPT], [AR_BALANCE], [CREDIT_LIM], [DISCT_DAYS], [DUE_DAYS], [DISCT_PCT], [PROMO_BAL], [COMMENT2], [SALES_ID], [NOMAIL], [BELONGNUM], [CTYPE2], [CTYPE3], [CARROUTE], [DELPOINT], [NCOACHANGE], [ENTRYDATE], [SEARCHCOMP], [EMAIL], [N_EXEMPT], [TAX_ID], [CASHONLY], [SALU], [HONO], [TITLE], [NOEMAIL], [PASSWORD], [RFM], [POINTS], [NORENT], [ADDR_TYPE], [WEB], [EXTENSION], [EXTENSION2], [DATE_LIMIT], [START_DATE], [END_DATE], [FROM_MONTH], [FROM_DAY], [TO_MONTH], [TO_DAY], [ADDRISSAME], [LASTUSER], [NOPOINTS], [UPSCOMDELV], [PREF_SHIP], [PREF_PAY], [ADDR3], [VALADDR], [VALDATE], [SOUNDLNAME], [ADDREXPIRE], [ACVMEDATE], [MODI_USER], [MODI_DATE], [ACT_DATE], [DSCTSTDATE], [DSCTENDATE], [PREFWARE], [BESTTTC], [FRAUD], [NOCALL], [TAX_ID2], [EMAILDEF], [EMAILPREF], [NOFAX], [C_EXEMPT], [I_EXEMPT], [CUST_TERMS]
	FROM   [dbo].[CUST]
	WHERE  [CUSTNUM] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO