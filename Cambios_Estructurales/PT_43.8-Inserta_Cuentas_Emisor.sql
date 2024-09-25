USE [Autorizador]
GO

BEGIN TRAN
	DECLARE @commit BIT = 1

	--SELECT * FROM Colectivas
	--WHERE ID_TipoColectiva = (SELECT ID_TipoColectiva FROM TipoColectiva WHERE ClaveTipoColectiva = 'EMI')

	DECLARE @ID_Colectiva VARCHAR(50) = (SELECT ID_Colectiva FROM Colectivas WHERE ClaveColectiva = 'PAGATODO') 

	--DECLARE @CuentaCLDC VARCHAR(50) = 'CLDC'
--	DECLARE @CuentaAuto VARCHAR(50) = 'CCLC'
	--DECLARE @CuentaCXP VARCHAR(50) = 'CXP'
	--DECLARE @CuentaTXACL VARCHAR(50) = 'TXACL'
	DECLARE @CuentaBAN VARCHAR(50) = 'BAN'
	--DECLARE @CuentaPRAUT VARCHAR(50) = 'PRAUT'
	--DECLARE @CuentaCBNR VARCHAR(50) = 'CBNR'
	--DECLARE @CuentaFEECOLL VARCHAR(50) = 'FEECOLL' 
	--DECLARE @CuentaCRED VARCHAR(50) = 'CRED'
	--DECLARE @CuentaCOMS VARCHAR(50) = 'COMS'
	--DECLARE @CuentaIVA VARCHAR(50) = 'IVA'
	--DECLARE @CuentaComp VARCHAR(50) = 'CDC'
	--DECLARE @CuentaSTP VARCHAR(50) = 'STP'
	--DECLARE @CuentaCINT VARCHAR(50) = 'CINT'



      
--	  SELECT * FROM TipoCuenta
--	  WHERE ClaveTipoCuenta IN (
--@CuentaAuto,
--@CuentaCXP,
--@CuentaTXACL,
--@CuentaBAN,
--@CuentaPRAUT,
--@CuentaCBNR,
--@CuentaFEECOLL,
--@CuentaCRED,
--@CuentaCOMS,
--@CuentaIVA,
--@CuentaComp,
--@CuentaSTP,
--@CuentaCLDC
--)

	  
	IF OBJECT_ID('tempdb..#TempTiposCuentaInsertar') IS NOT NULL
BEGIN
	DROP TABLE #TempTiposCuentaInsertar
END
SELECT tc.*
INTO #TempTiposCuentaInsertar
FROM TipoCuenta tc 
LEFT JOIN Cuentas cu ON tc.ID_TipoCuenta = cu.ID_TipoCuenta AND cu.ID_ColectivaCuentahabiente = @ID_Colectiva
--lEFT JOIN Colectivas co ON co.ID_Colectiva = @ID_Colectiva
WHERE tc.ClaveTipoCuenta IN (
--@CuentaCLDC,
--@CuentaAuto,
--@CuentaCXP,
--@CuentaTXACL,
@CuentaBAN--,
--@CuentaPRAUT,
--@CuentaCBNR,
--@CuentaFEECOLL,
--@CuentaCRED,
--@CuentaCOMS,
--@CuentaIVA,
--@CuentaComp,
--@CuentaSTP
--@CuentaCINT
)
AND cu.ID_Cuenta IS NULL

  	 
	--SELECT 'Cuentas Previas a Inserción', * FROM Cuentas WITH (NOLOCK) 
	--WHERE ID_ColectivaCuentahabiente = @ID_Colectiva

	----SELECT * FROM #TempTiposCuentaInsertar
	--	   SELECT
	--	   'Cuentas a Insertar'
	--	   ,NULL
	--	   ,1
	--	   ,ClaveTipoCuenta
	--	   ,NULL --ID_GrupoCuenta
	--	   ,@ID_Colectiva
	--	   ,NULL
	--	   ,NULL
	--	   ,Descripcion
	--	   ,0
	--	   ,NULL
	--	   ,NULL
	--	   ,NULL
	--	   ,NULL
	--	   ,GETDATE()
	--	   ,NULL
 --          ,NULL
 --          ,NULL
 --          ,NULL
 --          ,NULL
 --          ,NULL
 --          ,NULL
 --          ,NULL
 --          ,NULL
 --          ,NULL
	--	   FROM
	--	   #TempTiposCuentaInsertar

INSERT INTO [dbo].[Cuentas]
           ([ID_CuentaPadre]
           ,[ID_EstatusCuenta]
           ,[ID_TipoCuenta]
           ,[ID_GrupoCuenta]
           ,[ID_ColectivaCuentahabiente]
           ,[ID_CuentaLC]
           ,[Nivel]
           ,[Descripcion]
           ,[SaldoActual]
           ,[HeredaSaldo]
           ,[ID_ColectivaCadenaComercial]
           ,[ID_Periodo]
           ,[Vigencia]
           ,[FechaRegistro]
           ,[BloqueoReintentos]
           ,[BloqueoMorosidad]
           ,[BloqueoAutoridad]
           ,[BloqueoFraude]
           ,[BloqueoLavadoDinero]
           ,[BloqueoReqOperativo]
           ,[BloqueoCargo]
           ,[BloqueoAbono]
           ,[ID_Plantilla]
           ,[ID_PlantillaPreaut])
		   SELECT
		   NULL
		   ,1
		   ,ID_TipoCuenta
		   ,NULL --ID_GrupoCuenta
		   ,@ID_Colectiva
		   ,NULL
		   ,NULL
		   ,Descripcion
		   ,0
		   ,NULL
		   ,NULL
		   ,NULL
		   ,NULL
		   ,GETDATE()
		   ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
		   FROM
		   #TempTiposCuentaInsertar

	--UPDATE Cuentas
	--SET ID_CuentaLC = (SELECT ID_Cuenta FROM CUENTAS WHERE ID_TipoCuenta = (SELECT ID_TipoCuenta FROM TipoCuenta WHERE ClaveTipoCuenta = @CuentaCLDC) AND ID_ColectivaCuentahabiente = @ID_Colectiva)
	--WHERE ID_Cuenta = (SELECT ID_Cuenta FROM CUENTAS WHERE ID_TipoCuenta = (SELECT ID_TipoCuenta FROM TipoCuenta WHERE ClaveTipoCuenta = @CuentaAuto) AND ID_ColectivaCuentahabiente = @ID_Colectiva)

	--SELECT 'Cuentas Después a Inserción', * FROM Cuentas WITH (NOLOCK) 
	--WHERE ID_ColectivaCuentahabiente = @ID_Colectiva



IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN