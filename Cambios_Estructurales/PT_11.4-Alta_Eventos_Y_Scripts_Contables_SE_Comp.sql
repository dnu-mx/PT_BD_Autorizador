USE [Autorizador]
GO

BEGIN TRAN

	DECLARE @commit BIT = 1

	DECLARE @oldEvents TABLE
	(
		idEvento BIGINT,
		claveEvento CHAR(20)
	)

	DECLARE @newEvents TABLE
	(
		idEvento BIGINT,
		claveEvento CHAR(20)
	)


	DECLARE @ClaveNumericaDivisa VARCHAR (3)= '484'
	DECLARE @abono BIT = 1
	DECLARE @cargo BIT = 0
	DECLARE @cveAplicacionOperation VARCHAR(10) = 'OPERATION'
	DECLARE @cveAplicacionToday VARCHAR(10) = 'TODAY'
	DECLARE @cveEventosEdoCtaDock BIT = 1 -- INDICA SI DEBE ACTUALIZAR O NO LOS CLAVEEVENTOEDOCTA POR PERSONALIZACIÓN
	DECLARE @cveTipoColectivaCuentahabiente VARCHAR(10) = 'CCH'
	DECLARE @cveTipoColectivaEmisor VARCHAR(10) = 'EMI'
	DECLARE @cveTipoColectivaSubEmisor VARCHAR(10) = 'GCM'
	DECLARE @cveTipoColectivaSwitch VARCHAR(10) = 'SWITCH'
	DECLARE @cveTipoCuentaAclaraciones VARCHAR(10) = 'TXACL'
	DECLARE @cveTipoCuentaAutorizacion VARCHAR(10) = 'CCLC'
	DECLARE @cveTipoCuentaAutorizacionSaaS VARCHAR(10) = 'ASAAS'
	DECLARE @cveTipoCuentaComisiones VARCHAR(10) = 'COMS'
	DECLARE @cveTipoCuentaCompensacion VARCHAR(10) = 'CDC'
	DECLARE @cveTipoCuentaCompensacionSaaS VARCHAR(10) = 'CSAAS'
	DECLARE @cveTipoCuentaCredito VARCHAR(10) = 'CRED'
	DECLARE @cveTipoCuentaFeeCollection VARCHAR(10) = 'FEECOLL'
	DECLARE @cveTipoCuentaIVA VARCHAR(10) = 'IVA'
	DECLARE @cveTipoCuentaMarkUp VARCHAR(10) = 'MRKUP'
	DECLARE @cveTipoCuentaPorAplicar VARCHAR(10) = 'SBC'
	DECLARE @cveTipoCuentaPorPagar VARCHAR(10) = 'CXP'
	DECLARE @cveTipoCuentaPreautorizados VARCHAR(10) = 'PRAUT'
	DECLARE @cveTipoCuentaResguardo VARCHAR(10) = 'CBNR'
	DECLARE @cveTipoEventoCompensacion VARCHAR(3) = '003'
	--DECLARE @formulaComision VARCHAR(200) = '((@Imp_77_T112 + @Imp_45_T112) * @PorcComisionDisposicion) + @ImpComisionDisposicion'
	--DECLARE @formulaCompensacion VARCHAR(200) = '@Imp_77_T112 + @Imp_45_T112'
	--DECLARE @formulaCompensacionMU VARCHAR(200) = '@Imp_77_T112 + @Imp_45_T112 + (((@Imp_77_T112 * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
	--DECLARE @formulaIvaComision VARCHAR(200) = '(((@Imp_77_T112 + @Imp_45_T112) * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA'
	--DECLARE @formulaMarkUp VARCHAR(200) = '(((@Imp_77_T112 * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
	--DECLARE @formulaOriginal VARCHAR(200) = '@Imp_06_TRX'
	--DECLARE @formulaOriginalRetiro VARCHAR(200) = '@Imp_06_TRX + ((@Imp_06_TRX * @PorcComisionDisposicion) + @ImpComisionDisposicion) + (((@Imp_06_TRX * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA)'
	--DECLARE @formulaPostDevolucion VARCHAR(200) = '@Imp_Devolucion_Post'
	
	--DECLARE @formulaComision VARCHAR(200) = '((@impCompensacion + @impMCCR) * @PorcComisionDisposicion) + @ImpComisionDisposicion'
	--DECLARE @formulaCompensacion VARCHAR(200) = '@impCompensacion + @impMCCR'
	--DECLARE @formulaCompensacionMU VARCHAR(200) = '@impCompensacion + @impMCCR + (((@impCompensacion * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
	--DECLARE @formulaIvaComision VARCHAR(200) = '(((@impCompensacion + @impMCCR) * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA'
	--DECLARE @formulaMarkUp VARCHAR(200) = '(((@impCompensacion * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
	--DECLARE @formulaOriginal VARCHAR(200) = '@impOperacionOriginal'
	--DECLARE @formulaOriginalRetiro VARCHAR(200) = '@impOperacionOriginal + ((@impOperacionOriginal * @PorcComisionDisposicion) + @ImpComisionDisposicion) + (((@impOperacionOriginal * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA)'
	--DECLARE @formulaPostDevolucion VARCHAR(200) = '@impPreviamenteDevuelto'

	DECLARE @formulaComision VARCHAR(200) = '((@impCompensacion) * @PorcComisionDisposicion) + @ImpComisionDisposicion'
	DECLARE @formulaCompensacion VARCHAR(200) = '@impCompensacion'
	DECLARE @formulaCompensacionMU VARCHAR(200) = '@impCompensacion + (((@impCompensacion * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
	DECLARE @formulaIvaComision VARCHAR(200) = '(((@impCompensacion) * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA'
	DECLARE @formulaMarkUp VARCHAR(200) = '(((@impCompensacion * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
	DECLARE @formulaOriginal VARCHAR(200) = '@impOperacionOriginal'
	DECLARE @formulaOriginalRetiro VARCHAR(200) = '@impOperacionOriginal + ((@impOperacionOriginal * @PorcComisionDisposicion) + @ImpComisionDisposicion) + (((@impOperacionOriginal * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA)'
	DECLARE @formulaPostDevolucion VARCHAR(200) = '@impPreviamenteDevuelto'

	DECLARE @idScriptTemp  BIGINT = NULL
	DECLARE @validaEstatusCuenta BIT = 0
	DECLARE @validaSaldo BIT = 0
	DECLARE @version VARCHAR(4) = '-V01'
	
	DECLARE @esAbono BIT
	DECLARE @formula VARCHAR(200)
	DECLARE @idEvento INT
	DECLARE @idTipoColectiva INT
	DECLARE @idTipoCuenta INT
	
	DECLARE @idClaveAplicacion_Operation INT = 
	(
		SELECT
			ID_ClaveAplicacion
		FROM
			ClaveAplicacion WITH (NOLOCK)
		WHERE
			ClaveAplicacion = @cveAplicacionOperation
	)
	
	DECLARE @idClaveAplicacion_Today INT = 
	(
		SELECT
			ID_ClaveAplicacion
		FROM
			ClaveAplicacion WITH (NOLOCK)
		WHERE
			ClaveAplicacion = @cveAplicacionToday
	)
	
	DECLARE @idTipoColectiva_04_Emisor INT = 
	(
		SELECT
			ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveTipoColectivaEmisor
	)

	DECLARE @idTipoColectiva_10_Cuentahabiente INT = 
	(
		SELECT
			ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveTipoColectivaCuentahabiente
	)

	DECLARE @idTipoColectiva_34_SubEmisor INT = 
	(
		SELECT
			ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveTipoColectivaSubEmisor
	)

	DECLARE @idTipoColectiva_40_Switch INT =  
	(
		SELECT
			ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveTipoColectivaSwitch
	)
	
	DECLARE @idTipoCuenta_03_Autorizacion INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaAutorizacion
	)

	DECLARE @idTipoCuenta_08_Resguardo INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaResguardo
	)

	DECLARE @idTipoCuenta_13_Comisiones INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaComisiones
	)

	DECLARE @idTipoCuenta_15_PorPagar INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaPorPagar
	)

	DECLARE @idTipoCuenta_28_EnAclaracion INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaAclaraciones
	)

	DECLARE @idTipoCuenta_29_CreditoOtorgado INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaCredito
	)

	DECLARE @idTipoCuenta_54_Compensacion INT = 
	(

		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaCompensacion
	)

	DECLARE @idTipoCuenta_57_Preautorizacion INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaPreautorizados
	)

	DECLARE @idTipoCuenta_70_FeeCollection INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaFeeCollection
	)

	DECLARE @idTipoCuenta_71_IVA INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaIVA
	)

	DECLARE @idTipoCuenta_72_PorAplicar INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaPorAplicar
	)

	DECLARE @idTipoCuenta_73_AutorizacionSaaS INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaAutorizacionSaaS
	)

	DECLARE @idTipoCuenta_74_CompensacionSaaS INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaCompensacionSaaS
	)

	DECLARE @idTipoCuenta_110_MarkUp INT = 
	(
		SELECT ID_TipoCuenta FROM TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa AND
		TipoCuenta.ClaveGenerica = @cveTipoCuentaMarkUp
	)

	DECLARE @idTipoEventoCompensacion INT = 
	(
		SELECT
			ID_TipoEvento
		FROM
			TipoEvento WITH (NOLOCK)
		WHERE
			Clave = @cveTipoEventoCompensacion
	)

		--	SELECT @idClaveAplicacion_Operation
		--,@idClaveAplicacion_Today
		--,@idTipoColectiva_04_Emisor
		--,@idTipoColectiva_10_Cuentahabiente
		--,@idTipoColectiva_34_SubEmisor
		--,@idTipoColectiva_40_Switch 
		--,@idTipoCuenta_03_Autorizacion
		--,@idTipoCuenta_08_Resguardo 
		--,@idTipoCuenta_13_Comisiones 
		--,@idTipoCuenta_15_PorPagar 
		--,@idTipoCuenta_28_EnAclaracion 
		--,@idTipoCuenta_29_CreditoOtorgado 
		--,@idTipoCuenta_54_Compensacion 
		--,@idTipoCuenta_57_Preautorizacion 
		--,@idTipoCuenta_70_FeeCollection 
		--,@idTipoCuenta_71_IVA 
		--,@idTipoCuenta_72_PorAplicar
		--,@idTipoCuenta_73_AutorizacionSaaS 
		--,@idTipoCuenta_74_CompensacionSaaS 
		--,@idTipoCuenta_110_MarkUp 
		--,@idTipoEventoCompensacion 

	IF 	@idClaveAplicacion_Operation IS NOT NULL
		AND @idClaveAplicacion_Today IS NOT NULL
		AND @idTipoColectiva_04_Emisor IS NOT NULL
		AND @idTipoColectiva_10_Cuentahabiente IS NOT NULL
		AND @idTipoColectiva_34_SubEmisor IS NOT NULL
		AND @idTipoColectiva_40_Switch IS NOT NULL
		AND @idTipoCuenta_03_Autorizacion IS NOT NULL
		AND @idTipoCuenta_08_Resguardo IS NOT NULL
		AND @idTipoCuenta_13_Comisiones IS NOT NULL
		AND @idTipoCuenta_15_PorPagar IS NOT NULL
		AND @idTipoCuenta_28_EnAclaracion IS NOT NULL
		AND @idTipoCuenta_29_CreditoOtorgado IS NOT NULL
		AND @idTipoCuenta_54_Compensacion IS NOT NULL
		AND @idTipoCuenta_57_Preautorizacion IS NOT NULL
		AND @idTipoCuenta_70_FeeCollection IS NOT NULL
		AND @idTipoCuenta_71_IVA IS NOT NULL
		AND @idTipoCuenta_72_PorAplicar IS NOT NULL
		AND @idTipoCuenta_73_AutorizacionSaaS IS NOT NULL
		AND @idTipoCuenta_74_CompensacionSaaS IS NOT NULL
		AND @idTipoCuenta_110_MarkUp IS NOT NULL
		AND @idTipoEventoCompensacion IS NOT NULL

	BEGIN

	--PASO 1 GENERA EVENTOS FALTANTES
	--MXN 484
	EXEC ProcMan_Comp_GetIdEvento 'E00190001MXN484', 'COMP - CARGO DE MISCELANEO', @idTipoEventoCompensacion, 'E00190001MXN484', 'CARGO DE MISCELÁNEO', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E00290001MXN484', 'COMP - ABONO DE MISCELANEO', @idTipoEventoCompensacion, 'E00290001MXN484', 'ABONO DE MISCELÁNEO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000100MXN484', 'COMP - COMPRA/CARGO SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00000100MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000000MXN484', 'COMP - COMPRA/CARGO SI', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000200MXN484', 'COMP - COMPRA/CARGO SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000300MXN484', 'COMP - COMPRA/CARGO SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000400MXN484', 'COMP - COMPRA/CARGO SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000500MXN484', 'COMP - COMPRA/CARGO SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000600MXN484', 'COMP - COMPRA/CARGO SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010100MXN484', 'COMP - RETIRO EN ATM SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00010100MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010000MXN484', 'COMP - RETIRO EN ATM SI', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010200MXN484', 'COMP - RETIRO EN ATM SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010300MXN484', 'COMP - RETIRO EN ATM SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010400MXN484', 'COMP - RETIRO EN ATM SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010500MXN484', 'COMP - RETIRO EN ATM SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010600MXN484', 'COMP - RETIRO EN ATM SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090100MXN484', 'COMP - COMPRA CON CASHBACK SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00090100MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090000MXN484', 'COMP - COMPRA CON CASHBACK SI', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090200MXN484', 'COMP - COMPRA CON CASHBACK SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090300MXN484', 'COMP - COMPRA CON CASHBACK SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090400MXN484', 'COMP - COMPRA CON CASHBACK SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090500MXN484', 'COMP - COMPRA CON CASHBACK SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090600MXN484', 'COMP - COMPRA CON CASHBACK SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200100MXN484', 'COMP - DEVOLUCIÓN SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200100MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200700MXN484', 'COMP - DEVOLUCIÓN SI (SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200000MXN484', 'COMP - DEVOLUCIÓN SI', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200800MXN484', 'COMP - DEVOLUCIÓN SI (A FAVOR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200900MXN484', 'COMP - DEVOLUCIÓN SI (REVERSADA PRESENTADA ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01260000MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261300MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI (LIBERADA)', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261400MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI (CANCELADA)', @idTipoEventoCompensacion, 'E00261400MXN484', 'PAGO DE TRANSFERENCIA (CANCELADA)', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280100MXN484', 'COMP - PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280100MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E01280000MXN484', 'COMP - PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300100MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00300100MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300000MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300200MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300300MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300400MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300500MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300600MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200102MXN484', 'COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200102MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200002MXN484', 'COMP - REVERSO DEVOLUCIÓN SI', @idTipoEventoCompensacion, 'E00200002MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280102MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280102MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E01280002MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280002MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02000100MXN484', 'COMP - COMPRA/CARGO SE (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00000100MXN484', 'COMPRA POS', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02000000MXN484', 'COMP - COMPRA/CARGO SE', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02000200MXN484', 'COMP - COMPRA/CARGO SE (DUPLICADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02000300MXN484', 'COMP - COMPRA/CARGO SE (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02000400MXN484', 'COMP - COMPRA/CARGO SE (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02000500MXN484', 'COMP - COMPRA/CARGO SE (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02000600MXN484', 'COMP - COMPRA/CARGO SE (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02010100MXN484', 'COMP - RETIRO EN ATM SE (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00010100MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02010000MXN484', 'COMP - RETIRO EN ATM SE', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02010200MXN484', 'COMP - RETIRO EN ATM SE (DUPLICADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02010300MXN484', 'COMP - RETIRO EN ATM SE (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02010400MXN484', 'COMP - RETIRO EN ATM SE (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02010500MXN484', 'COMP - RETIRO EN ATM SE (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02010600MXN484', 'COMP - RETIRO EN ATM SE (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02090100MXN484', 'COMP - COMPRA CON CASHBACK SE (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00090100MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02090000MXN484', 'COMP - COMPRA CON CASHBACK SE', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02090200MXN484', 'COMP - COMPRA CON CASHBACK SE (DUPLICADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02090300MXN484', 'COMP - COMPRA CON CASHBACK SE (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02090400MXN484', 'COMP - COMPRA CON CASHBACK SE (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02090500MXN484', 'COMP - COMPRA CON CASHBACK SE (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02090600MXN484', 'COMP - COMPRA CON CASHBACK SE (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02200100MXN484', 'COMP - DEVOLUCIÓN SE (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200100MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02200700MXN484', 'COMP - DEVOLUCIÓN SE (SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02200000MXN484', 'COMP - DEVOLUCIÓN SE', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02200800MXN484', 'COMP - DEVOLUCIÓN SE (A FAVOR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02200900MXN484', 'COMP - DEVOLUCIÓN SE (REVERSADA PRESENTADA ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02260000MXN484', 'COMP - RECEPCIÓN FAST FUNDS SE', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02280100MXN484', 'COMP - PAGO/ABONO A TARJETA SE (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280100MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E02280000MXN484', 'COMP - PAGO/ABONO A TARJETA SE', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02300100MXN484', 'COMP - CONSULTA DE SALDO EN ATM SE (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00300100MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02300000MXN484', 'COMP - CONSULTA DE SALDO EN ATM SE', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02300200MXN484', 'COMP - CONSULTA DE SALDO EN ATM SE (DUPLICADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02300300MXN484', 'COMP - CONSULTA EN ATM SE (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02300400MXN484', 'COMP - CONSULTA DE SALDO EN ATM SE (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02300500MXN484', 'COMP - CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02300600MXN484', 'COMP - CONSULTA DE SALDO EN ATM SE (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02200102MXN484', 'COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200102MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02200002MXN484', 'COMP - REVERSO DEVOLUCIÓN SI', @idTipoEventoCompensacion, 'E00200002MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02280102MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SE (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280102MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E02280002MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SE', @idTipoEventoCompensacion, 'E00280002MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03000100MXN484', 'COMP - COMPRA/CARGO SAAS (SIN OPERACION)', @idTipoEventoCompensacion, 'E00000100MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03000000MXN484', 'COMP - COMPRA/CARGO SAAS', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03000200MXN484', 'COMP - COMPRA/CARGO SAAS (DUPLICADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03000300MXN484', 'COMP - COMPRA/CARGO SAAS (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03000400MXN484', 'COMP - COMPRA/CARGO SAAS (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03000500MXN484', 'COMP - COMPRA/CARGO SAAS (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03000600MXN484', 'COMP - COMPRA/CARGO SAAS (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03010100MXN484', 'COMP - RETIRO EN ATM SAAS (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00010100MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03010000MXN484', 'COMP - RETIRO EN ATM SAAS', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03010200MXN484', 'COMP - RETIRO EN ATM SAAS (DUPLICADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03010300MXN484', 'COMP - RETIRO EN ATM SAAS (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03010400MXN484', 'COMP - RETIRO EN ATM SAAS (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03010500MXN484', 'COMP - RETIRO EN ATM SAAS (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03010600MXN484', 'COMP - RETIRO EN ATM SAAS (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03090100MXN484', 'COMP - COMPRA CON CASHBACK SAAS (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00090100MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03090000MXN484', 'COMP - COMPRA CON CASHBACK SAAS', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03090200MXN484', 'COMP - COMPRA CON CASHBACK SAAS (DUPLICADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03090300MXN484', 'COMP - COMPRA CON CASHBACK SAAS (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03090400MXN484', 'COMP - COMPRA CON CASHBACK SAAS (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03090500MXN484', 'COMP - COMPRA CON CASHBACK SAAS (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03090600MXN484', 'COMP - COMPRA CON CASHBACK SAAS (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03200100MXN484', 'COMP - DEVOLUCION SAAS (SIN OPERACIÓN) ', @idTipoEventoCompensacion, 'E00200100MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03200700MXN484', 'COMP - DEVOLUCION SAAS (SIN COMPENSAR) ', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03200000MXN484', 'COMP - DEVOLUCION SAAS', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03200800MXN484', 'COMP - DEVOLUCION SAAS (A FAVOR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03200900MXN484', 'COMP - DEVOLUCION SAAS (REVERSADA PRESENTADA ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03260000MXN484', 'COMP - RECEPCIÓN FAST FUNDS SAAS', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03261300MXN484', 'COMP - RECEPCIÓN FAST FUNDS SAAS (LIBERADA)', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03261400MXN484', 'COMP - RECEPCIÓN FAST FUNDS SAAS (CANCELADA)', @idTipoEventoCompensacion, 'E00261400MXN484', 'PAGO DE TRANSFERENCIA (CANCELADA)', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03280100MXN484', 'COMP - PAGO/ABONO A TARJETA SAAS (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280100MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E03280000MXN484', 'COMP - PAGO/ABONO A TARJETA SAAS', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03300100MXN484', 'COMP - CONSULTA DE SALDO EN ATM SAAS (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00300100MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03300000MXN484', 'COMP - CONSULTA DE SALDO EN ATM SAAS', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03300200MXN484', 'COMP - CONSULTA DE SALDO EN ATM SAAS (DUPLICADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03300300MXN484', 'COMP - CONSULTA DE SALDO EN ATM SAAS (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03300400MXN484', 'COMP - CONSULTA DE SALDO EN ATM SAAS (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03300500MXN484', 'COMP - CONSULTA DE SALDO EN ATM SAAS (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03300600MXN484', 'COMP - CONSULTA DE SALDO EN ATM SAAS (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03200102MXN484', 'COMP - REVERSO DEVOLUCION SAAS (SIN OPERACIÓN) ', @idTipoEventoCompensacion, 'E00200102MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03200002MXN484', 'COMP - REVERSO DEVOLUCION SAAS', @idTipoEventoCompensacion, 'E00200002MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03280102MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SAAS (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280102MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E03280002MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SAAS', @idTipoEventoCompensacion, 'E00280002MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E04000000MXN484', 'COMP - COMPRA/CARGO SAAS PRE SI', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E04000400MXN484', 'COMP - COMPRA/CARGO SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E04010000MXN484', 'COMP - RETIRO ATM SAAS PRE SI', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E04010400MXN484', 'COMP - RETIRO EN ATM SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E04090000MXN484', 'COMP - COMPRA CON CAHBACK SAAS PRE SI', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E04090400MXN484', 'COMP - COMPRA CON CASHBACK SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E04280000MXN484', 'COMP - PAGO/ABONO A TARJETA SAAS PRE SI', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E04300000MXN484', 'COMP - CONSULTA DE SALDO ATM SAAS PRE SI', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E04300400MXN484', 'COMP - CONSULTA DE SALDO EN ATM SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05000100MXN484', 'COMP - COMPRA/CARGO TDC (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00000100MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05000000MXN484', 'COMP - COMPRA/CARGO TDC', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05000200MXN484', 'COMP - COMPRA/CARGO TDC (DUPLICADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05000300MXN484', 'COMP - COMPRA/CARGO TDC (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05000400MXN484', 'COMP - COMPRA/CARGO TDC (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05000500MXN484', 'COMP - COMPRA/CARGO TDC (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05000600MXN484', 'COMP - COMPRA/CARGO TDC (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05010100MXN484', 'COMP - RETIRO EN ATM TDC (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00010100MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05010000MXN484', 'COMP - RETIRO EN ATM TDC', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05010200MXN484', 'COMP - RETIRO EN ATM TDC (DUPLICADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05010300MXN484', 'COMP - RETIRO EN ATM TDC (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05010400MXN484', 'COMP - RETIRO EN ATM TDC (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05010500MXN484', 'COMP - RETIRO EN ATM TDC (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05010600MXN484', 'COMP - RETIRO EN ATM TDC (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05011000MXN484', 'COMP - RETIRO EN ATM TDC (COMISIÓN)', @idTipoEventoCompensacion, 'E00011000MXN484', 'COMISIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05011100MXN484', 'COMP - RETIRO EN ATM TDC (IVA COMISIÓN)', @idTipoEventoCompensacion, 'E00011100MXN484', 'IVA COMISIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05200100MXN484', 'COMP - DEVOLUCION TDC (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200100MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05200700MXN484', 'COMP - DEVOLUCION TDC (SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05200000MXN484', 'COMP - DEVOLUCION TDC', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05200800MXN484', 'COMP - DEVOLUCION TDC (A FAVOR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05200900MXN484', 'COMP - DEVOLUCION TDC (REVERSADA PRESENTADA ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05280100MXN484', 'COMP - PAGO/ABONO A TARJETA TDC (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280100MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E05280000MXN484', 'COMP - PAGO/ABONO A TARJETA TDC', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05300100MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00300100MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05300000MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05300200MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (DUPLICADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05300300MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05300400MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05300500MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05300600MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05010002MXN484', 'COMP - REVERSO RETIRO EN ATM TDC', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05011002MXN484', 'COMP - REVERSO RETIRO EN ATM TDC (COMISIÓN)', @idTipoEventoCompensacion, 'E00011002MXN484', 'DEVOLUCIÓN COMISIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05011102MXN484', 'COMP - REVERSO RETIRO EN ATM TDC (IVA COMISIÓN)', @idTipoEventoCompensacion, 'E00011102MXN484', 'DEVOLUCIÓN IVA COMISIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05200102MXN484', 'COMP - REVERSO DEVOLUCION TDC (SIN OPERACIÓN) ', @idTipoEventoCompensacion, 'E00200102MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05200002MXN484', 'COMP - REVERSO DEVOLUCION TDC', @idTipoEventoCompensacion, 'E00200002MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05280102MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA TDC (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280102MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E05280002MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA TDC', @idTipoEventoCompensacion, 'E00280002MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT

	----CRI 188
	--EXEC ProcMan_Comp_GetIdEvento 'E00190001MXN484', 'COMP - CARGO DE MISCELANEO', @idTipoEventoCompensacion, 'E00190001MXN484', 'CARGO DE MISCELÁNEO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E00290001MXN484', 'COMP - ABONO DE MISCELANEO', @idTipoEventoCompensacion, 'E00290001MXN484', 'ABONO DE MISCELÁNEO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000100MXN484', 'COMP - COMPRA/CARGO SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00000100MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000000MXN484', 'COMP - COMPRA/CARGO SI', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000200MXN484', 'COMP - COMPRA/CARGO SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000300MXN484', 'COMP - COMPRA/CARGO SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000400MXN484', 'COMP - COMPRA/CARGO SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000500MXN484', 'COMP - COMPRA/CARGO SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000600MXN484', 'COMP - COMPRA/CARGO SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010100MXN484', 'COMP - RETIRO EN ATM SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00010100MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010000MXN484', 'COMP - RETIRO EN ATM SI', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010200MXN484', 'COMP - RETIRO EN ATM SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010300MXN484', 'COMP - RETIRO EN ATM SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010400MXN484', 'COMP - RETIRO EN ATM SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010500MXN484', 'COMP - RETIRO EN ATM SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010600MXN484', 'COMP - RETIRO EN ATM SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090100MXN484', 'COMP - COMPRA CON CASHBACK SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00090100MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090000MXN484', 'COMP - COMPRA CON CASHBACK SI', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090200MXN484', 'COMP - COMPRA CON CASHBACK SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090300MXN484', 'COMP - COMPRA CON CASHBACK SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090400MXN484', 'COMP - COMPRA CON CASHBACK SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090500MXN484', 'COMP - COMPRA CON CASHBACK SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090600MXN484', 'COMP - COMPRA CON CASHBACK SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200100MXN484', 'COMP - DEVOLUCIÓN SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200100MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200700MXN484', 'COMP - DEVOLUCIÓN SI (SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200000MXN484', 'COMP - DEVOLUCIÓN SI', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200800MXN484', 'COMP - DEVOLUCIÓN SI (A FAVOR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200900MXN484', 'COMP - DEVOLUCIÓN SI (REVERSADA PRESENTADA ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01260000MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261300MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI (LIBERADA)', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261400MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI (CANCELADA)', @idTipoEventoCompensacion, 'E00261400MXN484', 'PAGO DE TRANSFERENCIA (CANCELADA)', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280100MXN484', 'COMP - PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280100MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E01280000MXN484', 'COMP - PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300100MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00300100MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300000MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300200MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300300MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300400MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300500MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300600MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200102MXN484', 'COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200102MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200002MXN484', 'COMP - REVERSO DEVOLUCIÓN SI', @idTipoEventoCompensacion, 'E00200002MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280102MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280102MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E01280002MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280002MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT

	--	--CRI 840
	--EXEC ProcMan_Comp_GetIdEvento 'E00190001MXN484', 'COMP - CARGO DE MISCELANEO', @idTipoEventoCompensacion, 'E00190001MXN484', 'CARGO DE MISCELÁNEO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E00290001MXN484', 'COMP - ABONO DE MISCELANEO', @idTipoEventoCompensacion, 'E00290001MXN484', 'ABONO DE MISCELÁNEO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000100MXN484', 'COMP - COMPRA/CARGO SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00000100MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000000MXN484', 'COMP - COMPRA/CARGO SI', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000200MXN484', 'COMP - COMPRA/CARGO SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000300MXN484', 'COMP - COMPRA/CARGO SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000400MXN484', 'COMP - COMPRA/CARGO SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000500MXN484', 'COMP - COMPRA/CARGO SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00000000MXN484', 'COMPRA POS', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01000600MXN484', 'COMP - COMPRA/CARGO SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010100MXN484', 'COMP - RETIRO EN ATM SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00010100MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010000MXN484', 'COMP - RETIRO EN ATM SI', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010200MXN484', 'COMP - RETIRO EN ATM SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010300MXN484', 'COMP - RETIRO EN ATM SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010400MXN484', 'COMP - RETIRO EN ATM SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010500MXN484', 'COMP - RETIRO EN ATM SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01010600MXN484', 'COMP - RETIRO EN ATM SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090100MXN484', 'COMP - COMPRA CON CASHBACK SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00090100MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090000MXN484', 'COMP - COMPRA CON CASHBACK SI', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090200MXN484', 'COMP - COMPRA CON CASHBACK SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090300MXN484', 'COMP - COMPRA CON CASHBACK SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090400MXN484', 'COMP - COMPRA CON CASHBACK SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090500MXN484', 'COMP - COMPRA CON CASHBACK SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00090000MXN484', 'COMPRA CON CASHBACK', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01090600MXN484', 'COMP - COMPRA CON CASHBACK SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200100MXN484', 'COMP - DEVOLUCIÓN SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200100MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200700MXN484', 'COMP - DEVOLUCIÓN SI (SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200000MXN484', 'COMP - DEVOLUCIÓN SI', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200800MXN484', 'COMP - DEVOLUCIÓN SI (A FAVOR)', @idTipoEventoCompensacion, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200900MXN484', 'COMP - DEVOLUCIÓN SI (REVERSADA PRESENTADA ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01260000MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261300MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI (LIBERADA)', @idTipoEventoCompensacion, 'E00260000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261400MXN484', 'COMP - RECEPCIÓN FAST FUNDS SI (CANCELADA)', @idTipoEventoCompensacion, 'E00261400MXN484', 'PAGO DE TRANSFERENCIA (CANCELADA)', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280100MXN484', 'COMP - PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280100MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E01280000MXN484', 'COMP - PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300100MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00300100MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300000MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300200MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (DUPLICADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300300MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300400MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300500MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (REVERSADA PRESENTADA)', @idTipoEventoCompensacion, 'E00300000MXN484', 'CONSULTA SALDO EN ATM', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01300600MXN484', 'COMP - CONSULTA DE SALDO EN ATM SI (A FAVOR ACLARADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200102MXN484', 'COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00200102MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01200002MXN484', 'COMP - REVERSO DEVOLUCIÓN SI', @idTipoEventoCompensacion, 'E00200002MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280102MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)', @idTipoEventoCompensacion, 'E00280102MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E01280002MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280002MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT


	/*	
	--PASO 3 OBTIENE LISTA DE EVENTOS OBSOLETOS
	INSERT INTO
		@oldEvents
		(
			idEvento,
			claveEvento
		)
	SELECT
		e.ID_Evento,
		TRIM(e.ClaveEvento) + @version
	FROM
		Eventos e WITH (NOLOCK)
	WHERE
		e.ClaveEvento IN
		(
			--E00
			'E00190001MXN484', --COMP - CARGO DE MISCELANEO
			'E00290001MXN484', --COMP - ABONO DE MISCELANEO
			--E01
			'E01000100MXN484', --COMP - COMPRA/CARGO SI (SIN OPERACIÓN)
			'E01000000MXN484', --COMP - COMPRA/CARGO SI
			'E01000200MXN484', --COMP - COMPRA/CARGO SI (DUPLICADA)
			'E01000300MXN484', --COMP - COMPRA/CARGO SI (POST DEVUELTA)
			'E01000400MXN484', --COMP - COMPRA/CARGO SI (POST DEVUELTA SIN COMPENSAR)
			'E01000500MXN484', --COMP - COMPRA/CARGO SI (REVERSADA PRESENTADA)
			'E01000600MXN484', --COMP - COMPRA/CARGO SI (A FAVOR ACLARADA)
			'E01010100MXN484', --COMP - RETIRO EN ATM SI (SIN OPERACIÓN)
			'E01010000MXN484', --COMP - RETIRO EN ATM SI
			'E01010200MXN484', --COMP - RETIRO EN ATM SI (DUPLICADA)
			'E01010300MXN484', --COMP - RETIRO EN ATM SI (POST DEVUELTA)
			'E01010400MXN484', --COMP - RETIRO EN ATM SI (POST DEVUELTA SIN COMPENSAR)
			'E01010500MXN484', --COMP - RETIRO EN ATM SI (REVERSADA PRESENTADA)
			'E01010600MXN484', --COMP - RETIRO EN ATM SI (A FAVOR ACLARADA)
			'E01090100MXN484', --COMP - COMPRA CON CASHBACK SI (SIN OPERACIÓN)
			'E01090000MXN484', --COMP - COMPRA CON CASHBACK SI
			'E01090200MXN484', --COMP - COMPRA CON CASHBACK SI (DUPLICADA)
			'E01090300MXN484', --COMP - COMPRA CON CASHBACK SI (POST DEVUELTA)
			'E01090400MXN484', --COMP - COMPRA CON CASHBACK SI (POST DEVUELTA SIN COMPENSAR)
			'E01090500MXN484', --COMP - COMPRA CON CASHBACK SI (REVERSADA PRESENTADA)
			'E01090600MXN484', --COMP - COMPRA CON CASHBACK SI (A FAVOR ACLARADA)
			'E01200100MXN484', --COMP - DEVOLUCIÓN SI (SIN OPERACIÓN)
			'E01200700MXN484', --COMP - DEVOLUCIÓN SI (SIN COMPENSAR)
			'E01200000MXN484', --COMP - DEVOLUCIÓN SI
			'E01200800MXN484', --COMP - DEVOLUCIÓN SI (A FAVOR)
			'E01200900MXN484', --COMP - DEVOLUCIÓN SI (REVERSADA PRESENTADA ACLARADA)
			'E01260000MXN484', --COMP - RECEPCIÓN FAST FUNDS SI
			'E01261300MXN484', --COMP - RECEPCIÓN FAST FUNDS SI (LIBERADA)
			'E01261400MXN484', --COMP - RECEPCIÓN FAST FUNDS SI (CANCELADA)
			'E01280100MXN484', --COMP - PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)
			--'E01280000MXN484', --COMP - PAGO/ABONO A TARJETA SI
			'E01300100MXN484', --COMP - CONSULTA DE SALDO EN ATM SI (SIN OPERACIÓN)
			'E01300000MXN484', --COMP - CONSULTA DE SALDO EN ATM SI
			'E01300200MXN484', --COMP - CONSULTA DE SALDO EN ATM SI (DUPLICADA)
			'E01300300MXN484', --COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA)
			'E01300400MXN484', --COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA SIN COMPENSAR)
			'E01300500MXN484', --COMP - CONSULTA DE SALDO EN ATM SI (REVERSADA PRESENTADA)
			'E01300600MXN484', --COMP - CONSULTA DE SALDO EN ATM SI (A FAVOR ACLARADA)
			'E01200102MXN484', --COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)
			'E01200002MXN484', --COMP - REVERSO DEVOLUCIÓN SI
			'E01280102MXN484', --COMP - REVERSO PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)
			--'E01280002MXN484', --COMP - REVERSO PAGO/ABONO A TARJETA SI
			--E02
			'E02000100MXN484', --COMP - COMPRA/CARGO SE (SIN OPERACIÓN)
			'E02000000MXN484', --COMP - COMPRA/CARGO SE
			'E02000200MXN484', --COMP - COMPRA/CARGO SE (DUPLICADA)
			'E02000300MXN484', --COMP - COMPRA/CARGO SE (POST DEVUELTA)
			'E02000400MXN484', --COMP - COMPRA/CARGO SE (POST DEVUELTA SIN COMPENSAR)
			'E02000500MXN484', --COMP - COMPRA/CARGO SE (REVERSADA PRESENTADA)
			'E02000600MXN484', --COMP - COMPRA/CARGO SE (A FAVOR ACLARADA)
			'E02010100MXN484', --COMP - RETIRO EN ATM SE (SIN OPERACIÓN)
			'E02010000MXN484', --COMP - RETIRO EN ATM SE
			'E02010200MXN484', --COMP - RETIRO EN ATM SE (DUPLICADA)
			'E02010300MXN484', --COMP - RETIRO EN ATM SE (POST DEVUELTA)
			'E02010400MXN484', --COMP - RETIRO EN ATM SE (POST DEVUELTA SIN COMPENSAR)
			'E02010500MXN484', --COMP - RETIRO EN ATM SE (REVERSADA PRESENTADA)
			'E02010600MXN484', --COMP - RETIRO EN ATM SE (A FAVOR ACLARADA)
			'E02090100MXN484', --COMP - COMPRA CON CASHBACK SE (SIN OPERACIÓN)
			'E02090000MXN484', --COMP - COMPRA CON CASHBACK SE
			'E02090200MXN484', --COMP - COMPRA CON CASHBACK SE (DUPLICADA)
			'E02090300MXN484', --COMP - COMPRA CON CASHBACK SE (POST DEVUELTA)
			'E02090400MXN484', --COMP - COMPRA CON CASHBACK SE (POST DEVUELTA SIN COMPENSAR)
			'E02090500MXN484', --COMP - COMPRA CON CASHBACK SE (REVERSADA PRESENTADA)
			'E02090600MXN484', --COMP - COMPRA CON CASHBACK SE (A FAVOR ACLARADA)
			'E02200100MXN484', --COMP - DEVOLUCIÓN SE (SIN OPERACIÓN)
			'E02200700MXN484', --COMP - DEVOLUCIÓN SE (SIN COMPENSAR)
			'E02200000MXN484', --COMP - DEVOLUCIÓN SE
			'E02200800MXN484', --COMP - DEVOLUCIÓN SE (A FAVOR)
			'E02200900MXN484', --COMP - DEVOLUCIÓN SE (REVERSADA PRESENTADA ACLARADA)
			'E02260000MXN484', --COMP - RECEPCIÓN FAST FUNDS SE
			'E02280100MXN484', --COMP - PAGO/ABONO A TARJETA SE (SIN OPERACIÓN)
			--'E02280000MXN484', --COMP - PAGO/ABONO A TARJETA SE
			'E02300100MXN484', --COMP - CONSULTA DE SALDO EN ATM SE (SIN OPERACIÓN)
			'E02300000MXN484', --COMP - CONSULTA DE SALDO EN ATM SE
			'E02300200MXN484', --COMP - CONSULTA DE SALDO EN ATM SE (DUPLICADA)
			'E02300300MXN484', --COMP - CONSULTA EN ATM SE (POST DEVUELTA)
			'E02300400MXN484', --COMP - CONSULTA DE SALDO EN ATM SE (POST DEVUELTA SIN COMPENSAR)
			'E02300500MXN484', --COMP - CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA)
			'E02300600MXN484', --COMP - CONSULTA DE SALDO EN ATM SE (A FAVOR ACLARADA)
			'E02200102MXN484', --COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)
			'E02200002MXN484', --COMP - REVERSO DEVOLUCIÓN SI
			'E02280102MXN484', --COMP - REVERSO PAGO/ABONO A TARJETA SE (SIN OPERACIÓN)
			--'E02280002MXN484', --COMP - REVERSO PAGO/ABONO A TARJETA SE
			--E03
			'E03000100MXN484', --COMP - COMPRA/CARGO SAAS (SIN OPERACION)
			'E03000000MXN484', --COMP - COMPRA/CARGO SAAS
			'E03000200MXN484', --COMP - COMPRA/CARGO SAAS (DUPLICADA)
			'E03000300MXN484', --COMP - COMPRA/CARGO SAAS (POST DEVUELTA)
			'E03000400MXN484', --COMP - COMPRA/CARGO SAAS (POST DEVUELTA SIN COMPENSAR)
			'E03000500MXN484', --COMP - COMPRA/CARGO SAAS (REVERSADA PRESENTADA)
			'E03000600MXN484', --COMP - COMPRA/CARGO SAAS (A FAVOR ACLARADA)
			'E03010100MXN484', --COMP - RETIRO EN ATM SAAS (SIN OPERACIÓN)
			'E03010000MXN484', --COMP - RETIRO EN ATM SAAS
			'E03010200MXN484', --COMP - RETIRO EN ATM SAAS (DUPLICADA)
			'E03010300MXN484', --COMP - RETIRO EN ATM SAAS (POST DEVUELTA)
			'E03010400MXN484', --COMP - RETIRO EN ATM SAAS (POST DEVUELTA SIN COMPENSAR)
			'E03010500MXN484', --COMP - RETIRO EN ATM SAAS (REVERSADA PRESENTADA)
			'E03010600MXN484', --COMP - RETIRO EN ATM SAAS (A FAVOR ACLARADA)
			'E03090100MXN484', --COMP - COMPRA CON CASHBACK SAAS (SIN OPERACIÓN)
			'E03090000MXN484', --COMP - COMPRA CON CASHBACK SAAS
			'E03090200MXN484', --COMP - COMPRA CON CASHBACK SAAS (DUPLICADA)
			'E03090300MXN484', --COMP - COMPRA CON CASHBACK SAAS (POST DEVUELTA)
			'E03090400MXN484', --COMP - COMPRA CON CASHBACK SAAS (POST DEVUELTA SIN COMPENSAR)
			'E03090500MXN484', --COMP - COMPRA CON CASHBACK SAAS (REVERSADA PRESENTADA)
			'E03090600MXN484', --COMP - COMPRA CON CASHBACK SAAS (A FAVOR ACLARADA)
			'E03200100MXN484', --COMP - DEVOLUCION SAAS (SIN OPERACIÓN) 
			'E03200700MXN484', --COMP - DEVOLUCION SAAS (SIN COMPENSAR) 
			'E03200000MXN484', --COMP - DEVOLUCION SAAS
			'E03200800MXN484', --COMP - DEVOLUCION SAAS (A FAVOR)
			'E03200900MXN484', --COMP - DEVOLUCION SAAS (REVERSADA PRESENTADA ACLARADA)
			'E03260000MXN484', --COMP - RECEPCIÓN FAST FUNDS SAAS
			'E03261300MXN484', --COMP - RECEPCIÓN FAST FUNDS SAAS (LIBERADA)
			'E03261400MXN484', --COMP - RECEPCIÓN FAST FUNDS SAAS (CANCELADA)
			'E03280100MXN484', --COMP - PAGO/ABONO A TARJETA SAAS (SIN OPERACIÓN)
			--'E03280000MXN484', --COMP - PAGO/ABONO A TARJETA SAAS
			'E03300100MXN484', --COMP - CONSULTA DE SALDO EN ATM SAAS (SIN OPERACIÓN)
			'E03300000MXN484', --COMP - CONSULTA DE SALDO EN ATM SAAS
			'E03300200MXN484', --COMP - CONSULTA DE SALDO EN ATM SAAS (DUPLICADA)
			'E03300300MXN484', --COMP - CONSULTA DE SALDO EN ATM SAAS (POST DEVUELTA)
			'E03300400MXN484', --COMP - CONSULTA DE SALDO EN ATM SAAS (POST DEVUELTA SIN COMPENSAR)
			'E03300500MXN484', --COMP - CONSULTA DE SALDO EN ATM SAAS (REVERSADA PRESENTADA)
			'E03300600MXN484', --COMP - CONSULTA DE SALDO EN ATM SAAS (A FAVOR ACLARADA)
			'E03200102MXN484', --COMP - REVERSO DEVOLUCION SAAS (SIN OPERACIÓN) 
			'E03200002MXN484', --COMP - REVERSO DEVOLUCION SAAS
			'E03280102MXN484', --COMP - REVERSO PAGO/ABONO A TARJETA SAAS (SIN OPERACIÓN)
			--'E03280002MXN484', --COMP - REVERSO PAGO/ABONO A TARJETA SAAS
			--E04
			'E04000000MXN484', --COMP - COMPRA/CARGO SAAS PRE SI
			'E04000400MXN484', --COMP - COMPRA/CARGO SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)
			'E04010000MXN484', --COMP - RETIRO ATM SAAS PRE SI
			'E04010400MXN484', --COMP - RETIRO EN ATM SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)
			'E04090000MXN484', --COMP - COMPRA CON CAHBACK SAAS PRE SI
			'E04090400MXN484', --COMP - COMPRA CON CASHBACK SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)
			--'E04280000MXN484', --COMP - PAGO/ABONO A TARJETA SAAS PRE SI
			'E04300000MXN484', --COMP - CONSULTA DE SALDO ATM SAAS PRE SI
			'E04300400MXN484', --COMP - CONSULTA DE SALDO EN ATM SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)
			--E05
			'E05000100MXN484', --COMP - COMPRA/CARGO TDC (SIN OPERACIÓN)
			'E05000000MXN484', --COMP - COMPRA/CARGO TDC
			'E05000200MXN484', --COMP - COMPRA/CARGO TDC (DUPLICADA)
			'E05000300MXN484', --COMP - COMPRA/CARGO TDC (POST DEVUELTA)
			'E05000400MXN484', --COMP - COMPRA/CARGO TDC (POST DEVUELTA SIN COMPENSAR)
			'E05000500MXN484', --COMP - COMPRA/CARGO TDC (REVERSADA PRESENTADA)
			'E05000600MXN484', --COMP - COMPRA/CARGO TDC (A FAVOR ACLARADA)
			'E05010100MXN484', --COMP - RETIRO EN ATM TDC (SIN OPERACIÓN)
			'E05010000MXN484', --COMP - RETIRO EN ATM TDC
			'E05010200MXN484', --COMP - RETIRO EN ATM TDC (DUPLICADA)
			'E05010300MXN484', --COMP - RETIRO EN ATM TDC (POST DEVUELTA)
			'E05010400MXN484', --COMP - RETIRO EN ATM TDC (POST DEVUELTA SIN COMPENSAR)
			'E05010500MXN484', --COMP - RETIRO EN ATM TDC (REVERSADA PRESENTADA)
			'E05010600MXN484', --COMP - RETIRO EN ATM TDC (A FAVOR ACLARADA)
			'E05011000MXN484', --COMP - RETIRO EN ATM TDC (COMISIÓN)
			'E05011100MXN484', --COMP - RETIRO EN ATM TDC (IVA COMISIÓN)
			'E05200100MXN484', --COMP - DEVOLUCION TDC (SIN OPERACIÓN)
			'E05200700MXN484', --COMP - DEVOLUCION TDC (SIN COMPENSAR)
			'E05200000MXN484', --COMP - DEVOLUCION TDC
			'E05200800MXN484', --COMP - DEVOLUCION TDC (A FAVOR)
			'E05200900MXN484', --COMP - DEVOLUCION TDC (DEVUELTA PRESENTADA ACLARADA)
			'E05280100MXN484', --COMP - PAGO/ABONO A TARJETA TDC (SIN OPERACIÓN)
			--'E05280000MXN484', --COMP - PAGO/ABONO A TARJETA TDC
			'E05300100MXN484', --COMP - CONSULTA DE SALDO EN ATM TDC (SIN OPERACIÓN)
			'E05300000MXN484', --COMP - CONSULTA DE SALDO EN ATM TDC
			'E05300200MXN484', --COMP - CONSULTA DE SALDO EN ATM TDC (DUPLICADA)
			'E05300300MXN484', --COMP - CONSULTA DE SALDO EN ATM TDC (POST DEVUELTA)
			'E05300400MXN484', --COMP - CONSULTA DE SALDO EN ATM TDC (POST DEVUELTA SIN COMPENSAR)
			'E05300500MXN484', --COMP - CONSULTA DE SALDO EN ATM TDC (REVERSADA PRESENTADA)
			'E05300600MXN484', --COMP - CONSULTA DE SALDO EN ATM TDC (A FAVOR ACLARADA)
			'E05010002MXN484', --COMP - REVERSO RETIRO EN ATM TDC
			'E05011002MXN484', --COMP - REVERSO RETIRO EN ATM TDC (COMISIÓN)
			'E05011102MXN484', --COMP - REVERSO RETIRO EN ATM TDC (IVA COMISIÓN)
			'E05200102MXN484', --COMP - REVERSO DEVOLUCION TDC (SIN OPERACIÓN) 
			'E05200002MXN484', --COMP - REVERSO DEVOLUCION TDC
			'E05280102MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA TDC (SIN OPERACIÓN)
			--'E05280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA TDC
		)
	
	--PASO 4 ACTUALIZA CLAVE EVENTO AGREGANDO LA VERSIÓN AL FINAL AL FINAL DE LA CLAVE ACTUAL
	UPDATE
		e
	SET
		e.ClaveEvento = oe.claveEvento
	FROM
		Eventos e WITH (NOLOCK)
		INNER JOIN @oldEvents oe
			ON oe.idEvento = e.ID_Evento

	SELECT
		e.*
	FROM
		Eventos e WITH (NOLOCK)
		INNER JOIN @oldEvents oe
			ON oe.idEvento = e.ID_Evento
	
	--PASO 5 CREAR EVENTOS CLONES
	INSERT INTO
		Eventos
		(
			ClaveEvento,
			Descripcion,
			EsActivo,
			EsReversable,
			EsCancelable,
			EsTransaccional,
			ID_TipoEvento,
			DescripcionEdoCta,
			GeneraPoliza,
			PreValidaciones,
			PostValidaciones,
			ID_EventoCompensacion,
			ClaveEventoEdoCta
		)
	SELECT
		REPLACE(TRIM(e.ClaveEvento), @version, ''),
		e.Descripcion,
		e.EsActivo,
		e.EsReversable,
		e.EsCancelable,
		e.EsTransaccional,
		e.ID_TipoEvento,
		e.DescripcionEdoCta,
		e.GeneraPoliza,
		e.PreValidaciones,
		e.PostValidaciones,
		e.ID_EventoCompensacion,
		e.ClaveEventoEdoCta
	FROM
		Eventos e WITH (NOLOCK)
		INNER JOIN @oldEvents oe
			ON oe.idEvento = e.ID_Evento

	INSERT INTO
		@newEvents
		(
			idEvento,
			claveEvento
		)
	SELECT
		e.ID_Evento,
		e.ClaveEvento
	FROM
		Eventos e WITH (NOLOCK)
		INNER JOIN @oldEvents oe
			ON REPLACE(oe.ClaveEvento, @version, '') = e.ClaveEvento

	SELECT
		e.*
	FROM
		Eventos e WITH (NOLOCK)
		INNER JOIN @newEvents ne
			ON ne.idEvento = e.ID_Evento

	--PASO 6 GENERA REGISTROS EN REGLAS
	EXEC ProcMan_Comp_CreateEventosReglas

	SELECT
		ne.idEvento,
		ne.claveEvento,
		e.ID_Regla,
		e.EsActiva
	FROM
		EventosReglas e WITH (NOLOCK)
		INNER JOIN @newEvents ne
			ON ne.idEvento = e.ID_Evento
		
	--PASO 7 ACTUALIZA CLAVEEVENTOEDOCTA POR LA PERSONALIZADA
	IF @cveEventosEdoCtaDock = 1
	BEGIN
		EXEC ProcMan_Comp_UpdateEventosEdoCta 'DOCK'
	END

	SELECT
		e.ID_Evento,
		e.ClaveEvento,
		e.ClaveEventoEdoCta,
		e.Descripcion,
		e.DescripcionEdoCta
	FROM
		Eventos e WITH (NOLOCK)
		INNER JOIN @newEvents ne
			ON ne.idEvento = e.ID_Evento
			*/

	--PASO 6 GENERA REGISTROS EN REGLAS
	--EXEC ProcMan_Comp_CreateEventosReglas
	--PASO 8 GENERA REGISTROS EN SCRIPTS Y PERTENENCIAS
	-- 134 TOTAL
	DECLARE @04008O_Compensacion_A INT
	DECLARE @04008T_Compensacion_A INT
	DECLARE @04008T_Compensacion_C INT
	DECLARE @04008T_PostDevolucion_C INT
	DECLARE @04028O_Compensacion_A INT
	DECLARE @04028O_Compensacion_C INT
	DECLARE @04028T_Compensacion_A INT
	DECLARE @04028T_Compensacion_C INT
	DECLARE @04057O_Original_A INT
	DECLARE @04057O_Original_C INT
	DECLARE @04057T_Original_C INT
	DECLARE @04057T_OriginalRetiro_A INT
	DECLARE @04057T_OriginalRetiro_C INT
	DECLARE @04070O_Compensacion_A INT
	DECLARE @04070O_Compensacion_C INT
	DECLARE @10003O_Compensacion_A INT
	DECLARE @10003O_Compensacion_C INT
	DECLARE @10003O_CompensacionMU_C INT
	DECLARE @10003O_Original_A INT
	DECLARE @10003O_Original_C INT
	DECLARE @10003T_Comision_A INT
	DECLARE @10003T_Comision_C INT
	DECLARE @10003T_Compensacion_A INT
	DECLARE @10003T_Compensacion_C INT
	DECLARE @10003T_CompensacionMU_A INT
	DECLARE @10003T_CompensacionMU_C INT
	DECLARE @10003T_IVA_A INT
	DECLARE @10003T_IVA_C INT
	DECLARE @10003T_Original_A INT
	DECLARE @10003T_OriginalRetiro_A INT
	DECLARE @10003T_OriginalRetiro_C INT
	DECLARE @10003T_PostDevolucion_A INT
	DECLARE @10015T_Comision_A INT
	DECLARE @10015T_Comision_C INT
	DECLARE @10015T_Compensacion_A INT
	DECLARE @10015T_Compensacion_C INT
	DECLARE @10015T_CompensacionMU_A INT
	DECLARE @10015T_CompensacionMU_C INT
	DECLARE @10015T_IVA_A INT
	DECLARE @10015T_IVA_C INT
	DECLARE @10015T_PostDevolucion_C INT
	DECLARE @10054O_Compensacion_A INT
	DECLARE @10054O_Compensacion_C INT
	DECLARE @10054O_CompensacionMU_C INT
	DECLARE @10054T_Comision_A INT
	DECLARE @10054T_Comision_C INT
	DECLARE @10054T_Compensacion_A INT
	DECLARE @10054T_Compensacion_C INT
	DECLARE @10054T_CompensacionMU_A INT
	DECLARE @10054T_CompensacionMU_C INT
	DECLARE @10054T_IVA_A INT
	DECLARE @10054T_IVA_C INT
	DECLARE @10054T_PostDevolucion_A INT
	DECLARE @10072O_Original_C INT
	DECLARE @34003O_Compensacion_A INT
	DECLARE @34003O_Compensacion_C INT
	DECLARE @34003O_CompensacionMU_A INT
	DECLARE @34003O_Original_A INT
	DECLARE @34003O_Original_C INT
	DECLARE @34003T_Comision_A INT
	DECLARE @34003T_Comision_C INT
	DECLARE @34003T_Compensacion_A INT
	DECLARE @34003T_Compensacion_C INT
	DECLARE @34003T_CompensacionMU_A INT
	DECLARE @34003T_CompensacionMU_C INT
	DECLARE @34003T_IVA_A INT
	DECLARE @34003T_IVA_C INT
	DECLARE @34003T_Original_A INT
	DECLARE @34003T_OriginalRetiro_A INT
	DECLARE @34003T_OriginalRetiro_C INT
	DECLARE @34003T_PostDevolucion_A INT
	DECLARE @34003T_PostDevolucion_C INT
	DECLARE @34013T_Comision_A INT
	DECLARE @34013T_Comision_C INT
	DECLARE @34015O_Compensacion_A INT
	DECLARE @34015O_Compensacion_C INT
	DECLARE @34015O_CompensacionMU_A INT
	DECLARE @34015T_Comision_A INT
	DECLARE @34015T_Comision_C INT
	DECLARE @34015T_Compensacion_A INT
	DECLARE @34015T_Compensacion_C INT
	DECLARE @34015T_CompensacionMU_A INT
	DECLARE @34015T_CompensacionMU_C INT
	DECLARE @34015T_IVA_A INT
	DECLARE @34015T_IVA_C INT
	DECLARE @34015T_PostDevolucion_C INT
	DECLARE @34028O_Compensacion_A INT
	DECLARE @34028O_Compensacion_C INT
	DECLARE @34028T_Compensacion_A INT
	DECLARE @34028T_Compensacion_C INT
	DECLARE @34029O_Compensacion_A INT
	DECLARE @34029O_Compensacion_C INT
	DECLARE @34029T_Comision_A INT
	DECLARE @34029T_Comision_C INT
	DECLARE @34029T_Compensacion_A INT
	DECLARE @34029T_Compensacion_C INT
	DECLARE @34029T_CompensacionMU_A INT
	DECLARE @34029T_CompensacionMU_C INT
	DECLARE @34029T_IVA_A INT
	DECLARE @34029T_IVA_C INT
	DECLARE @34029T_PostDevolucion_C INT
	DECLARE @34054O_Compensacion_A INT
	DECLARE @34054O_Compensacion_C INT
	DECLARE @34054O_CompensacionMU_A INT	
	DECLARE @34054T_Comision_A INT
	DECLARE @34054T_Comision_C INT
	DECLARE @34054T_Compensacion_A INT
	DECLARE @34054T_Compensacion_C INT
	DECLARE @34054T_CompensacionMU_A INT
	DECLARE @34054T_CompensacionMU_C INT
	DECLARE @34054T_IVA_A INT
	DECLARE @34054T_IVA_C INT	
	DECLARE @34054T_PostDevolucion_A INT
	DECLARE @34054T_PostDevolucion_C INT
	DECLARE @34057O_Original_A INT
	DECLARE @34057O_Original_C INT
	DECLARE @34057T_Original_C INT
	DECLARE @34057T_OriginalRetiro_A INT
	DECLARE @34057T_OriginalRetiro_C INT
	DECLARE @34071T_IVA_A INT
	DECLARE @34071T_IVA_C INT
	DECLARE @34072O_Original_C INT
	DECLARE @34073O_Compensacion_A INT
	DECLARE @34073O_Compensacion_C INT
	DECLARE @34073O_CompensacionMU_C INT
	DECLARE @34073O_Original_A INT
	DECLARE @34073O_Original_C INT
	DECLARE @34073T_CompensacionMU_A INT
	DECLARE @34073T_CompensacionMU_C INT
	DECLARE @34073T_Original_A INT
	DECLARE @34073T_PostDevolucion_A INT
	DECLARE @34074O_Compensacion_A INT
	DECLARE @34074O_Compensacion_C INT
	DECLARE @34074O_CompensacionMU_C INT
	DECLARE @34074O_Original_A INT
	DECLARE @34074T_CompensacionMU_A INT
	DECLARE @34074T_CompensacionMU_C INT
	DECLARE @34074T_PostDevolucion_A INT
	DECLARE @34110O_MarkUp_A INT
	DECLARE @34110T_MarkUp_A INT
	DECLARE @34110T_MarkUp_C INT
	DECLARE @40015O_Compensacion_A INT
	DECLARE @40015O_Compensacion_C INT
	DECLARE @40015T_Compensacion_A INT 
	DECLARE @40015T_Compensacion_C INT 
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_08_Resguardo, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @04008O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_08_Resguardo, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @04008T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_08_Resguardo, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @04008T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_08_Resguardo, @idClaveAplicacion_Today, @formulaPostDevolucion, @cargo, @validaSaldo, @validaEstatusCuenta, @04008T_PostDevolucion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_28_EnAclaracion, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @04028O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_28_EnAclaracion, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @04028O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_28_EnAclaracion, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @04028T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_28_EnAclaracion, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @04028T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Operation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @04057O_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Operation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @04057O_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Today, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @04057T_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Today, @formulaOriginalRetiro, @abono, @validaSaldo, @validaEstatusCuenta, @04057T_OriginalRetiro_A OUTPUT --AQUI SE CAMBIO LA FORMULA 
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Today, @formulaOriginalRetiro, @cargo, @validaSaldo, @validaEstatusCuenta, @04057T_OriginalRetiro_C OUTPUT --AQUI SE CAMBIO LA FORMULA
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_70_FeeCollection, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @04070O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_04_Emisor, @idTipoCuenta_70_FeeCollection, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @04070O_Compensacion_C OUTPUT	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @10003O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @10003O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @10003O_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @10003O_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @10003O_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaComision, @abono, @validaSaldo, @validaEstatusCuenta, @10003T_Comision_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @10003T_Comision_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @10003T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @10003T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @10003T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @10003T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaIvaComision, @abono, @validaSaldo, @validaEstatusCuenta, @10003T_IVA_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaIvaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @10003T_IVA_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @10003T_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaOriginalRetiro, @abono, @validaSaldo, @validaEstatusCuenta, @10003T_OriginalRetiro_A OUTPUT --AQUI SE CAMBIO LA FORMULA
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaOriginalRetiro, @cargo, @validaSaldo, @validaEstatusCuenta, @10003T_OriginalRetiro_C OUTPUT --AQUI SE CAMBIO LA FORMULA
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaPostDevolucion, @abono, @validaSaldo, @validaEstatusCuenta, @10003T_PostDevolucion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaComision, @abono, @validaSaldo, @validaEstatusCuenta, @10015T_Comision_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @10015T_Comision_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @10015T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @10015T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @10015T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @10015T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaIvaComision, @abono, @validaSaldo, @validaEstatusCuenta, @10015T_IVA_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaIvaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @10015T_IVA_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaPostDevolucion, @cargo, @validaSaldo, @validaEstatusCuenta, @10015T_PostDevolucion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @10054O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @10054O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Operation, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @10054O_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaComision, @abono, @validaSaldo, @validaEstatusCuenta, @10054T_Comision_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @10054T_Comision_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @10054T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @10054T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @10054T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @10054T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaIvaComision, @abono, @validaSaldo, @validaEstatusCuenta, @10054T_IVA_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaIvaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @10054T_IVA_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaPostDevolucion, @abono, @validaSaldo, @validaEstatusCuenta, @10054T_PostDevolucion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_10_Cuentahabiente, @idTipoCuenta_72_PorAplicar, @idClaveAplicacion_Operation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @10072O_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34003O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34003O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34003O_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @34003O_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Operation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @34003O_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaComision, @abono, @validaSaldo, @validaEstatusCuenta, @34003T_Comision_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34003T_Comision_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34003T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34003T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34003T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @34003T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaIVAComision, @abono, @validaSaldo, @validaEstatusCuenta, @34003T_IVA_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaIVAComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34003T_IVA_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @34003T_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaOriginalRetiro, @abono, @validaSaldo, @validaEstatusCuenta, @34003T_OriginalRetiro_A OUTPUT --AQUI SE CAMBIO LA FORMULA
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaOriginalRetiro, @cargo, @validaSaldo, @validaEstatusCuenta, @34003T_OriginalRetiro_C OUTPUT --AQUI SE CAMBIO LA FORMULA
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaPostDevolucion, @abono, @validaSaldo, @validaEstatusCuenta, @34003T_PostDevolucion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_03_Autorizacion, @idClaveAplicacion_Today, @formulaPostDevolucion, @cargo, @validaSaldo, @validaEstatusCuenta, @34003T_PostDevolucion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_13_Comisiones, @idClaveAplicacion_Today, @formulaComision, @abono, @validaSaldo, @validaEstatusCuenta, @34013T_Comision_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_13_Comisiones, @idClaveAplicacion_Today, @formulaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34013T_Comision_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34015O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34015O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Operation, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34015O_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaComision, @abono, @validaSaldo, @validaEstatusCuenta, @34015T_Comision_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34015T_Comision_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34015T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34015T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34015T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @34015T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaIvaComision, @abono, @validaSaldo, @validaEstatusCuenta, @34015T_IVA_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaIvaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34015T_IVA_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaPostDevolucion, @cargo, @validaSaldo, @validaEstatusCuenta, @34015T_PostDevolucion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_28_EnAclaracion, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34028O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_28_EnAclaracion, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34028O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_28_EnAclaracion, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34028T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_28_EnAclaracion, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34028T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34029O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34029O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaComision, @abono, @validaSaldo, @validaEstatusCuenta, @34029T_Comision_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34029T_Comision_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34029T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34029T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34029T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @34029T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaIVAComision, @abono, @validaSaldo, @validaEstatusCuenta, @34029T_IVA_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaIVAComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34029T_IVA_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_29_CreditoOtorgado, @idClaveAplicacion_Today, @formulaPostDevolucion, @cargo, @validaSaldo, @validaEstatusCuenta, @34029T_PostDevolucion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34054O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34054O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Operation, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34054O_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaComision, @abono, @validaSaldo, @validaEstatusCuenta, @34054T_Comision_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34054T_Comision_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34054T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34054T_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34054T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @34054T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaIVAComision, @abono, @validaSaldo, @validaEstatusCuenta, @34054T_IVA_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaIVAComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34054T_IVA_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaPostDevolucion, @abono, @validaSaldo, @validaEstatusCuenta, @34054T_PostDevolucion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_54_Compensacion, @idClaveAplicacion_Today, @formulaPostDevolucion, @cargo, @validaSaldo, @validaEstatusCuenta, @34054T_PostDevolucion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Operation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @34057O_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Operation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @34057O_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Today, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @34057T_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Today, @formulaOriginalRetiro, @abono, @validaSaldo, @validaEstatusCuenta, @34057T_OriginalRetiro_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_57_Preautorizacion, @idClaveAplicacion_Today, @formulaOriginalRetiro, @cargo, @validaSaldo, @validaEstatusCuenta, @34057T_OriginalRetiro_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_71_IVA, @idClaveAplicacion_Today, @formulaIvaComision, @abono, @validaSaldo, @validaEstatusCuenta, @34071T_IVA_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_71_IVA, @idClaveAplicacion_Today, @formulaIvaComision, @cargo, @validaSaldo, @validaEstatusCuenta, @34071T_IVA_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_72_PorAplicar, @idClaveAplicacion_Operation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @34072O_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34073O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34073O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Operation, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @34073O_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Operation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @34073O_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Operation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @34073O_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34073T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @34073T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Today, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @34073T_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_73_AutorizacionSaaS, @idClaveAplicacion_Today, @formulaPostDevolucion, @abono, @validaSaldo, @validaEstatusCuenta, @34073T_PostDevolucion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_74_CompensacionSaaS, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @34074O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_74_CompensacionSaaS, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @34074O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_74_CompensacionSaaS, @idClaveAplicacion_Operation, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @34074O_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_74_CompensacionSaaS, @idClaveAplicacion_Operation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @34074O_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_74_CompensacionSaaS, @idClaveAplicacion_Today, @formulaCompensacionMU, @abono, @validaSaldo, @validaEstatusCuenta, @34074T_CompensacionMU_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_74_CompensacionSaaS, @idClaveAplicacion_Today, @formulaCompensacionMU, @cargo, @validaSaldo, @validaEstatusCuenta, @34074T_CompensacionMU_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_74_CompensacionSaaS, @idClaveAplicacion_Today, @formulaPostDevolucion, @abono, @validaSaldo, @validaEstatusCuenta, @34074T_PostDevolucion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_110_MarkUp, @idClaveAplicacion_Operation, @formulaMarkUp, @abono, @validaSaldo, @validaEstatusCuenta, @34110O_MarkUp_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_110_MarkUp, @idClaveAplicacion_Today, @formulaMarkUp, @abono, @validaSaldo, @validaEstatusCuenta, @34110T_MarkUp_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_34_SubEmisor, @idTipoCuenta_110_MarkUp, @idClaveAplicacion_Today, @formulaMarkUp, @cargo, @validaSaldo, @validaEstatusCuenta, @34110T_MarkUp_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_40_Switch, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Operation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @40015O_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_40_Switch, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Operation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @40015O_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_40_Switch, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @40015T_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectiva_40_Switch, @idTipoCuenta_15_PorPagar, @idClaveAplicacion_Today, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @40015T_Compensacion_C OUTPUT
	
	EXEC ProcMan_Comp_GetScriptInfo '@04008O_Compensacion_A', @04008O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@04008T_Compensacion_A', @04008T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@04008T_Compensacion_C', @04008T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@04008T_PostDevolucion_C', @04008T_PostDevolucion_C
	EXEC ProcMan_Comp_GetScriptInfo '@04028O_Compensacion_A', @04028O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@04028O_Compensacion_C', @04028O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@04028T_Compensacion_A', @04028T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@04028T_Compensacion_C', @04028T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@04057O_Original_A', @04057O_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@04057O_Original_C', @04057O_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@04057T_Original_C', @04057T_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@04057T_OriginalRetiro_A', @04057T_OriginalRetiro_A
	EXEC ProcMan_Comp_GetScriptInfo '@04057T_OriginalRetiro_C', @04057T_OriginalRetiro_C
	EXEC ProcMan_Comp_GetScriptInfo '@04070O_Compensacion_A', @04070O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@04070O_Compensacion_C', @04070O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003O_Compensacion_A', @10003O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@10003O_Compensacion_C', @10003O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003O_CompensacionMU_C', @10003O_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003O_Original_A', @10003O_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@10003O_Original_C', @10003O_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_Comision_A', @10003T_Comision_A
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_Comision_C', @10003T_Comision_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_Compensacion_A', @10003T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_Compensacion_C', @10003T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_CompensacionMU_A', @10003T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_CompensacionMU_C', @10003T_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_IVA_A', @10003T_IVA_A
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_IVA_C', @10003T_IVA_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_Original_A', @10003T_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_OriginalRetiro_A', @10003T_OriginalRetiro_A
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_OriginalRetiro_C', @10003T_OriginalRetiro_C
	EXEC ProcMan_Comp_GetScriptInfo '@10003T_PostDevolucion_A', @10003T_PostDevolucion_A
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_Comision_A', @10015T_Comision_A
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_Comision_C', @10015T_Comision_C
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_Compensacion_A', @10015T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_Compensacion_C', @10015T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_CompensacionMU_A', @10015T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_CompensacionMU_C', @10015T_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_IVA_A', @10015T_IVA_A
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_IVA_C', @10015T_IVA_C
	EXEC ProcMan_Comp_GetScriptInfo '@10015T_PostDevolucion_C', @10015T_PostDevolucion_C
	EXEC ProcMan_Comp_GetScriptInfo '@10054O_Compensacion_A', @10054O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@10054O_Compensacion_C', @10054O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@10054O_CompensacionMU_C', @10054O_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_Comision_A', @10054T_Comision_A
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_Comision_C', @10054T_Comision_C
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_Compensacion_A', @10054T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_Compensacion_C', @10054T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_CompensacionMU_A', @10054T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_CompensacionMU_C', @10054T_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_IVA_A', @10054T_IVA_A
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_IVA_C', @10054T_IVA_C
	EXEC ProcMan_Comp_GetScriptInfo '@10072O_Original_C', @10072O_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@10054T_PostDevolucion_A', @10054T_PostDevolucion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003O_Compensacion_A', @34003O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003O_Compensacion_C', @34003O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34003O_CompensacionMU_A', @34003O_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003O_Original_A', @34003O_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003O_Original_C', @34003O_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_Comision_A', @34003T_Comision_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_Comision_C', @34003T_Comision_C
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_Compensacion_A', @34003T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_Compensacion_C', @34003T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_CompensacionMU_A', @34003T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_CompensacionMU_C', @34003T_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_IVA_A', @34003T_IVA_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_IVA_C', @34003T_IVA_C
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_Original_A', @34003T_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_OriginalRetiro_A', @34003T_OriginalRetiro_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_OriginalRetiro_C', @34003T_OriginalRetiro_C
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_PostDevolucion_A', @34003T_PostDevolucion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34003T_PostDevolucion_C', @34003T_PostDevolucion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34013T_Comision_A', @34013T_Comision_A
	EXEC ProcMan_Comp_GetScriptInfo '@34013T_Comision_C', @34013T_Comision_C
	EXEC ProcMan_Comp_GetScriptInfo '@34015O_Compensacion_A', @34015O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34015O_Compensacion_C', @34015O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34015O_CompensacionMU_A', @34015O_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_Comision_A', @34015T_Comision_A
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_Comision_C', @34015T_Comision_C
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_Compensacion_A', @34015T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_Compensacion_C', @34015T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_CompensacionMU_A', @34015T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_CompensacionMU_C', @34015T_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_IVA_A', @34015T_IVA_A
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_IVA_C', @34015T_IVA_C
	EXEC ProcMan_Comp_GetScriptInfo '@34015T_PostDevolucion_C', @34015T_PostDevolucion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34028O_Compensacion_A', @34028O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34028O_Compensacion_C', @34028O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34028T_Compensacion_A', @34028T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34028T_Compensacion_C', @34028T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34029O_Compensacion_A', @34029O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34029O_Compensacion_C', @34029O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_Comision_A', @34029T_Comision_A
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_Comision_C', @34029T_Comision_C
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_Compensacion_A', @34029T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_Compensacion_C', @34029T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_CompensacionMU_A', @34029T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_CompensacionMU_C', @34029T_CompensacionMU_C	
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_IVA_A', @34029T_IVA_A
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_IVA_C', @34029T_IVA_C
	EXEC ProcMan_Comp_GetScriptInfo '@34029T_PostDevolucion_C', @34029T_PostDevolucion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34054O_Compensacion_A', @34054O_Compensacion_A 
	EXEC ProcMan_Comp_GetScriptInfo '@34054O_Compensacion_C', @34054O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34054O_CompensacionMU_A', @34054O_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_Comision_A', @34054T_Comision_A
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_Comision_C', @34054T_Comision_C
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_Compensacion_A', @34054T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_Compensacion_C', @34054T_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_CompensacionMU_A', @34054T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_CompensacionMU_C', @34054T_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_IVA_A', @34054T_IVA_A
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_IVA_C', @34054T_IVA_C
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_PostDevolucion_A', @34054T_PostDevolucion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34054T_PostDevolucion_C', @34054T_PostDevolucion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34057O_Original_A', @34057O_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@34057O_Original_C', @34057O_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@34057T_Original_C', @34057T_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@34057T_OriginalRetiro_A', @34057T_OriginalRetiro_A
	EXEC ProcMan_Comp_GetScriptInfo '@34057T_OriginalRetiro_C', @34057T_OriginalRetiro_C
	EXEC ProcMan_Comp_GetScriptInfo '@34071T_IVA_A', @34071T_IVA_A
	EXEC ProcMan_Comp_GetScriptInfo '@34071T_IVA_C', @34071T_IVA_C
	EXEC ProcMan_Comp_GetScriptInfo '@34072O_Original_C', @34072O_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@34073O_Compensacion_A', @34073O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34073O_Compensacion_C', @34073O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34073O_CompensacionMU_C', @34073O_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@34073O_Original_A', @34073O_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@34073T_CompensacionMU_A', @34073T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34073T_CompensacionMU_C', @34073T_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@34073T_Original_A', @34073T_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@34073O_Original_C', @34073O_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@34073T_PostDevolucion_A', @34073T_PostDevolucion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34074O_Compensacion_A', @34074O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34074O_Compensacion_C', @34074O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@34074O_CompensacionMU_C', @34074O_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@34074O_Original_A', @34074O_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@34074T_CompensacionMU_A', @34074T_CompensacionMU_A
	EXEC ProcMan_Comp_GetScriptInfo '@34074T_CompensacionMU_C', @34074T_CompensacionMU_C
	EXEC ProcMan_Comp_GetScriptInfo '@34074T_PostDevolucion_A', @34074T_PostDevolucion_A
	EXEC ProcMan_Comp_GetScriptInfo '@34110O_MarkUp_A', @34110O_MarkUp_A
	EXEC ProcMan_Comp_GetScriptInfo '@34110T_MarkUp_A', @34110T_MarkUp_A
	EXEC ProcMan_Comp_GetScriptInfo '@34110T_MarkUp_C', @34110T_MarkUp_C
	EXEC ProcMan_Comp_GetScriptInfo '@40015O_Compensacion_A', @40015O_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@40015O_Compensacion_C', @40015O_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@40015T_Compensacion_A', @40015T_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@40015T_Compensacion_C', @40015T_Compensacion_C





	--MXN484
	EXEC ProcMan_Comp_CreateEventoScripts 'E00190001MXN484', @04070O_Compensacion_C, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E00290001MXN484', @04070O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200100MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34028T_Compensacion_C, @34110T_MarkUp_C, @04028T_Compensacion_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200700MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200000MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34110T_MarkUp_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200800MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200900MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34028T_Compensacion_A, @34110T_MarkUp_C, @04028T_Compensacion_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01260000MXN484', @10003O_Compensacion_A, @10054O_Compensacion_A, @10072O_Original_C, @04057O_Original_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261300MXN484', @10003O_Compensacion_A, @10003O_Original_C, @10054O_Compensacion_A, @34015O_Compensacion_C, @04057O_Original_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261400MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280000MXN484', @10003O_Compensacion_A, @10054O_Compensacion_A, @34015O_Compensacion_C, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200102MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_A, @34110O_MarkUp_A, @04028O_Compensacion_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200002MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280002MXN484', @10003O_Compensacion_C, @10054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A

	EXEC ProcMan_Comp_CreateEventoScripts 'E02000100MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02000000MXN484', @34003O_Original_A, @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @04057O_Original_C, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02000200MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02000300MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02000400MXN484', @34003T_Original_A, @34003T_PostDevolucion_A, @34003T_Compensacion_C, @34054T_PostDevolucion_A, @34054T_Compensacion_C, @34015T_PostDevolucion_C, @34015T_Compensacion_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02000500MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02000600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02010100MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02010000MXN484', @34003O_Original_A, @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @04057O_Original_C, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02010200MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02010300MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02010400MXN484', @34003T_Original_A, @34003T_PostDevolucion_A, @34003T_Compensacion_C, @34054T_PostDevolucion_A, @34054T_Compensacion_C, @34015T_PostDevolucion_C, @34015T_Compensacion_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02010500MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02010600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02090100MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02090000MXN484', @34003O_Original_A, @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @04057O_Original_C, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02090200MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02090300MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02090400MXN484', @34003T_Original_A, @34003T_PostDevolucion_A, @34003T_Compensacion_C, @34054T_PostDevolucion_A, @34054T_Compensacion_C, @34015T_PostDevolucion_C, @34015T_Compensacion_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02090500MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02090600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02200100MXN484', @34003T_Compensacion_A, @34054T_Compensacion_A, @34015T_Compensacion_C, @40015T_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02200700MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02200000MXN484', @34003T_Compensacion_A, @34054T_Compensacion_A, @34015T_Compensacion_C, @40015T_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02200800MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02200900MXN484', @34003T_Compensacion_A, @34054T_Compensacion_A, @34015T_Compensacion_C, @40015T_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02260000MXN484', @34003O_Compensacion_A, @34054O_Compensacion_A, @34015O_Compensacion_C, @34072O_Original_C, @04057O_Original_A, @40015O_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02280100MXN484', @34003O_Compensacion_A, @34054O_Compensacion_A, @34015O_Compensacion_C, @40015O_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02300100MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02300000MXN484', @34003O_Original_A, @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @04057O_Original_C, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02300200MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02300300MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02300400MXN484', @34003T_Original_A, @34003T_PostDevolucion_A, @34003T_Compensacion_C, @34054T_PostDevolucion_A, @34054T_Compensacion_C, @34015T_PostDevolucion_C, @34015T_Compensacion_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02300500MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02300600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02200102MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02200002MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A
	EXEC ProcMan_Comp_CreateEventoScripts 'E02280102MXN484', @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A

	--EXEC ProcMan_Comp_CreateEventoScripts 'E03000100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03000000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34057O_Original_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_Original_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03000200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03000300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03000400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34003T_PostDevolucion_C, @34003T_CompensacionMU_A, @34054T_PostDevolucion_C, @34054T_CompensacionMU_A, @34057T_Original_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @34073T_Original_A, @34073T_PostDevolucion_A, @34073T_CompensacionMU_C, @34074T_PostDevolucion_A, @34074T_CompensacionMU_C, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03000500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03000600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03010100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03010000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34057O_Original_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_Original_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03010200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03010300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03010400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34003T_PostDevolucion_C, @34003T_CompensacionMU_A, @34054T_PostDevolucion_C, @34054T_CompensacionMU_A, @34057T_Original_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @34073T_Original_A, @34073T_PostDevolucion_A, @34073T_CompensacionMU_C, @34074T_PostDevolucion_A, @34074T_CompensacionMU_C, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03010500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03010600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03090100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03090000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34057O_Original_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_Original_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03090200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03090300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03090400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34003T_PostDevolucion_C, @34003T_CompensacionMU_A, @34054T_PostDevolucion_C, @34054T_CompensacionMU_A, @34057T_Original_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @34073T_Original_A, @34073T_PostDevolucion_A, @34073T_CompensacionMU_C, @34074T_PostDevolucion_A, @34074T_CompensacionMU_C, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03090500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03090600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03200100MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_C, @34028T_Compensacion_C, @34110T_MarkUp_C, @34073T_CompensacionMU_A, @34074T_CompensacionMU_A, @04028T_Compensacion_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03200700MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03200000MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_C, @34110T_MarkUp_C, @34073T_CompensacionMU_A, @34074T_CompensacionMU_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03200800MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03200900MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_C, @34028T_Compensacion_A, @34110T_MarkUp_C, @34073T_CompensacionMU_A, @34074T_CompensacionMU_A, @04028T_Compensacion_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03260000MXN484', @10003O_Compensacion_A, @10054O_Compensacion_A, @10072O_Original_C, @34003O_Compensacion_C, @34054O_Compensacion_C, @34057O_Original_A, @34015O_Compensacion_C, @34072O_Original_C, @34073O_Compensacion_A, @34074O_Compensacion_A, @04057O_Original_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03261300MXN484', @10003O_Compensacion_A, @10003O_Original_C, @10054O_Compensacion_A, @34054O_Compensacion_C, @34015O_Compensacion_C, @34073O_Compensacion_A, @34073O_Original_C, @34074O_Original_A, @04057O_Original_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03261400MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03280000MXN484', @10003O_Compensacion_A, @10054O_Compensacion_A, @34003O_Compensacion_C, @34054O_Compensacion_C, @34015O_Compensacion_C, @34073O_Compensacion_A, @34074O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03300100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03300000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34057O_Original_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_Original_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03300200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03300300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03300400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34003T_PostDevolucion_C, @34003T_CompensacionMU_A, @34054T_PostDevolucion_C, @34054T_CompensacionMU_A, @34057T_Original_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @34073T_Original_A, @34073T_PostDevolucion_A, @34073T_CompensacionMU_C, @34074T_PostDevolucion_A, @34074T_CompensacionMU_C, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03300500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03300600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03200102MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34028O_Compensacion_A, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04028O_Compensacion_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03200002MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03280002MXN484', @10003O_Compensacion_C, @10054O_Compensacion_C, @34003O_Compensacion_A, @34054O_Compensacion_A, @34015O_Compensacion_A, @34073O_Compensacion_C, @34074O_Compensacion_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E04000000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E04000400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E04010000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E04010400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E04090000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E04090400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E04300000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34003O_CompensacionMU_A, @34054O_CompensacionMU_A, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @34073O_CompensacionMU_C, @34074O_CompensacionMU_C, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E04300400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05000100MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05000000MXN484', @10003T_Original_A, @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_Original_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34057T_Original_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05000200MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05000300MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05000400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @10015T_PostDevolucion_C, @10015T_CompensacionMU_A, @34003T_Original_A, @34003T_PostDevolucion_A, @34003T_CompensacionMU_C, @34054T_PostDevolucion_A, @34054T_CompensacionMU_C, @34057T_Original_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34029T_PostDevolucion_C, @34029T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05000500MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05000600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05010100MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05010000MXN484', @10003T_OriginalRetiro_A, @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_OriginalRetiro_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34057T_OriginalRetiro_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_OriginalRetiro_C, @40015T_Compensacion_A --REVISAR
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05010200MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05010300MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05010400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @10015T_PostDevolucion_C, @10015T_CompensacionMU_A, @34003T_Original_A, @34003T_PostDevolucion_A, @34003T_CompensacionMU_C, @34054T_PostDevolucion_A, @34054T_CompensacionMU_C, @34057T_Original_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34029T_PostDevolucion_C, @34029T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05010500MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05010600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05011000MXN484', @10003T_Comision_C, @10054T_Comision_C, @10015T_Comision_A, @34003T_Comision_C, @34054T_Comision_C, @34015T_Comision_A, @34029T_Comision_A, @34013T_Comision_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05011100MXN484', @10003T_IVA_C, @10054T_IVA_C, @10015T_IVA_A, @34003T_IVA_C, @34054T_IVA_C, @34015T_IVA_A, @34029T_IVA_A, @34071T_IVA_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05200100MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @10015T_CompensacionMU_C, @34003T_CompensacionMU_A, @34054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34029T_CompensacionMU_C, @34028T_Compensacion_C, @34110T_MarkUp_C, @04028T_Compensacion_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05200700MXN484', @04008T_Compensacion_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05200000MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @10015T_CompensacionMU_C, @34003T_CompensacionMU_A, @34054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34029T_CompensacionMU_C, @34110T_MarkUp_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05200800MXN484', @04008T_Compensacion_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05200900MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @10015T_CompensacionMU_C, @34003T_CompensacionMU_A, @34054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34029T_CompensacionMU_C, @34028T_Compensacion_A, @34110T_MarkUp_C, @04028T_Compensacion_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05280000MXN484', @10003T_Compensacion_A, @10054T_Compensacion_A, @10015T_Compensacion_C, @34003T_Compensacion_A, @34054T_Compensacion_A, @34015T_Compensacion_C, @34029T_Compensacion_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05300100MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05300000MXN484', @10003T_Original_A, @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_Original_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34057T_Original_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05300200MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05300300MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05300400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @10015T_PostDevolucion_C, @10015T_CompensacionMU_A, @34003T_Original_A, @34003T_PostDevolucion_A, @34003T_CompensacionMU_C, @34054T_PostDevolucion_A, @34054T_CompensacionMU_C, @34057T_Original_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34029T_PostDevolucion_C, @34029T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05300500MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_C, @34110T_MarkUp_A, @04028T_Compensacion_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05300600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05010002MXN484', @10003T_OriginalRetiro_C, @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @10015T_CompensacionMU_C, @34003T_OriginalRetiro_C, @34003T_CompensacionMU_A, @34054T_CompensacionMU_A, @34057T_OriginalRetiro_A, @34015T_CompensacionMU_C, @34029T_CompensacionMU_C, @34110T_MarkUp_C, @04057T_OriginalRetiro_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05011002MXN484', @10003T_Comision_A, @10054T_Comision_A, @10015T_Comision_C, @34003T_Comision_A, @34054T_Comision_A, @34015T_Comision_C, @34029T_Comision_C, @34013T_Comision_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05011102MXN484', @10003T_IVA_A, @10054T_IVA_A, @10015T_IVA_C, @34003T_IVA_A, @34054T_IVA_A, @34015T_IVA_C, @34029T_IVA_C, @34071T_IVA_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05200102MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34028T_Compensacion_A, @34110T_MarkUp_A, @04028T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05200002MXN484', @10003T_CompensacionMU_C, @10054T_CompensacionMU_C, @10015T_CompensacionMU_A, @34003T_CompensacionMU_C, @34054T_CompensacionMU_C, @34015T_CompensacionMU_A, @34029T_CompensacionMU_A, @34110T_MarkUp_A, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05280002MXN484', @10003T_Compensacion_C, @10054T_Compensacion_C, @10015T_Compensacion_A, @34003T_Compensacion_C, @34054T_Compensacion_C, @34015T_Compensacion_A, @34029T_Compensacion_A, @40015T_Compensacion_A
	

	----PREPAGO CRI 188
	--EXEC ProcMan_Comp_CreateEventoScripts 'E00190001MXN484', @04070O_Compensacion_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E00290001MXN484', @04070O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200100MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34028T_Compensacion_C, @34110T_MarkUp_C, @04028T_Compensacion_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200700MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200000MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34110T_MarkUp_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200800MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200900MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34028T_Compensacion_A, @34110T_MarkUp_C, @04028T_Compensacion_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01260000MXN484', @10003O_Compensacion_A, @10054O_Compensacion_A, @10072O_Original_C, @04057O_Original_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261300MXN484', @10003O_Compensacion_A, @10003O_Original_C, @10054O_Compensacion_A, @34015O_Compensacion_C, @04057O_Original_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261400MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280100MXN484', @10003O_Compensacion_A, @10054O_Compensacion_A, @34015O_Compensacion_C, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200102MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_A, @34110O_MarkUp_A, @04028O_Compensacion_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200002MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280102MXN484', @10003O_Compensacion_C, @10054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A

	--PREPAGO CRI 840
	--EXEC ProcMan_Comp_CreateEventoScripts 'E00190001MXN484', @04070O_Compensacion_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E00290001MXN484', @04070O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01000600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01010600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01090600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200100MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34028T_Compensacion_C, @34110T_MarkUp_C, @04028T_Compensacion_A, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200700MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200000MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34110T_MarkUp_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200800MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200900MXN484', @10003T_CompensacionMU_A, @10054T_CompensacionMU_A, @34015T_CompensacionMU_C, @34028T_Compensacion_A, @34110T_MarkUp_C, @04028T_Compensacion_C, @40015T_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01260000MXN484', @10003O_Compensacion_A, @10054O_Compensacion_A, @10072O_Original_C, @04057O_Original_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261300MXN484', @10003O_Compensacion_A, @10003O_Original_C, @10054O_Compensacion_A, @34015O_Compensacion_C, @04057O_Original_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261400MXN484', @04008O_Compensacion_A, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280100MXN484', @10003O_Compensacion_A, @10054O_Compensacion_A, @34015O_Compensacion_C, @40015O_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300100MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300000MXN484', @10003O_Original_A, @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @04057O_Original_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300200MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300300MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300400MXN484', @10003T_Original_A, @10003T_PostDevolucion_A, @10003T_CompensacionMU_C, @10054T_PostDevolucion_A, @10054T_CompensacionMU_C, @34015T_PostDevolucion_C, @34015T_CompensacionMU_A, @34110T_MarkUp_A, @04057T_Original_C, @04008T_PostDevolucion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300500MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_C, @34110O_MarkUp_A, @04028O_Compensacion_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01300600MXN484', @04008T_Compensacion_C, @40015T_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200102MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34028O_Compensacion_A, @34110O_MarkUp_A, @04028O_Compensacion_C, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01200002MXN484', @10003O_CompensacionMU_C, @10054O_CompensacionMU_C, @34015O_CompensacionMU_A, @34110O_MarkUp_A, @40015O_Compensacion_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280102MXN484', @10003O_Compensacion_C, @10054O_Compensacion_C, @34015O_Compensacion_A, @40015O_Compensacion_A


	-- CREAR TODOS
	EXEC ProcMan_Comp_GetEventoScripts 'E00190001MXN484' --COMP - CARGO DE MISCELANEO
	EXEC ProcMan_Comp_GetEventoScripts 'E00290001MXN484' --COMP - ABONO DE MISCELANEO

	--CRI 188
	--EXEC ProcMan_Comp_GetEventoScripts 'E00190001MXN484' --COMP - CARGO DE MISCELANEO
	--EXEC ProcMan_Comp_GetEventoScripts 'E00290001MXN484' --COMP - ABONO DE MISCELANEO

	----CRI 840
	--EXEC ProcMan_Comp_GetEventoScripts 'E00190001MXN484' --COMP - CARGO DE MISCELANEO
	--EXEC ProcMan_Comp_GetEventoScripts 'E00290001MXN484' --COMP - ABONO DE MISCELANEO



	--MXN484

	--EXEC ProcMan_Comp_GetEventoScripts 'E01000100MXN484' --COMP - COMPRA/CARGO SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000000MXN484' --COMP - COMPRA/CARGO SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000200MXN484' --COMP - COMPRA/CARGO SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000300MXN484' --COMP - COMPRA/CARGO SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000400MXN484' --COMP - COMPRA/CARGO SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000500MXN484' --COMP - COMPRA/CARGO SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000600MXN484' --COMP - COMPRA/CARGO SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010100MXN484' --COMP - RETIRO EN ATM SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010000MXN484' --COMP - RETIRO EN ATM SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010200MXN484' --COMP - RETIRO EN ATM SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010300MXN484' --COMP - RETIRO EN ATM SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010400MXN484' --COMP - RETIRO EN ATM SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010500MXN484' --COMP - RETIRO EN ATM SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010600MXN484' --COMP - RETIRO EN ATM SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090100MXN484' --COMP - COMPRA CON CASHBACK SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090000MXN484' --COMP - COMPRA CON CASHBACK SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090200MXN484' --COMP - COMPRA CON CASHBACK SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090300MXN484' --COMP - COMPRA CON CASHBACK SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090400MXN484' --COMP - COMPRA CON CASHBACK SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090500MXN484' --COMP - COMPRA CON CASHBACK SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090600MXN484' --COMP - COMPRA CON CASHBACK SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200100MXN484' --COMP - DEVOLUCIÓN SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200700MXN484' --COMP - DEVOLUCIÓN SI (SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200000MXN484' --COMP - DEVOLUCIÓN SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200800MXN484' --COMP - DEVOLUCIÓN SI (A FAVOR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200900MXN484' --COMP - DEVOLUCIÓN SI (REVERSADA PRESENTADA ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01260000MXN484' --COMP - RECEPCIÓN FAST FUNDS SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261300MXN484' --COMP - RECEPCIÓN FAST FUNDS SI (LIBERADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261400MXN484' --COMP - RECEPCIÓN FAST FUNDS SI (CANCELADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280000MXN484' --COMP - PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)
	----'E01280000MXN484' --COMP - PAGO/ABONO A TARJETA SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300100MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300000MXN484' --COMP - CONSULTA DE SALDO EN ATM SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300200MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300300MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300400MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300500MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300600MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200102MXN484' --COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200002MXN484' --COMP - REVERSO DEVOLUCIÓN SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)
	----'E01280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SI
	----E02
	EXEC ProcMan_Comp_GetEventoScripts 'E02000100MXN484' --COMP - COMPRA/CARGO SE (SIN OPERACIÓN)
	EXEC ProcMan_Comp_GetEventoScripts 'E02000000MXN484' --COMP - COMPRA/CARGO SE
	EXEC ProcMan_Comp_GetEventoScripts 'E02000200MXN484' --COMP - COMPRA/CARGO SE (DUPLICADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02000300MXN484' --COMP - COMPRA/CARGO SE (POST DEVUELTA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02000400MXN484' --COMP - COMPRA/CARGO SE (POST DEVUELTA SIN COMPENSAR)
	EXEC ProcMan_Comp_GetEventoScripts 'E02000500MXN484' --COMP - COMPRA/CARGO SE (REVERSADA PRESENTADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02000600MXN484' --COMP - COMPRA/CARGO SE (A FAVOR ACLARADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02010100MXN484' --COMP - RETIRO EN ATM SE (SIN OPERACIÓN)
	EXEC ProcMan_Comp_GetEventoScripts 'E02010000MXN484' --COMP - RETIRO EN ATM SE
	EXEC ProcMan_Comp_GetEventoScripts 'E02010200MXN484' --COMP - RETIRO EN ATM SE (DUPLICADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02010300MXN484' --COMP - RETIRO EN ATM SE (POST DEVUELTA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02010400MXN484' --COMP - RETIRO EN ATM SE (POST DEVUELTA SIN COMPENSAR)
	EXEC ProcMan_Comp_GetEventoScripts 'E02010500MXN484' --COMP - RETIRO EN ATM SE (REVERSADA PRESENTADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02010600MXN484' --COMP - RETIRO EN ATM SE (A FAVOR ACLARADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02090100MXN484' --COMP - COMPRA CON CASHBACK SE (SIN OPERACIÓN)
	EXEC ProcMan_Comp_GetEventoScripts 'E02090000MXN484' --COMP - COMPRA CON CASHBACK SE
	EXEC ProcMan_Comp_GetEventoScripts 'E02090200MXN484' --COMP - COMPRA CON CASHBACK SE (DUPLICADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02090300MXN484' --COMP - COMPRA CON CASHBACK SE (POST DEVUELTA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02090400MXN484' --COMP - COMPRA CON CASHBACK SE (POST DEVUELTA SIN COMPENSAR)
	EXEC ProcMan_Comp_GetEventoScripts 'E02090500MXN484' --COMP - COMPRA CON CASHBACK SE (REVERSADA PRESENTADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02090600MXN484' --COMP - COMPRA CON CASHBACK SE (A FAVOR ACLARADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02200100MXN484' --COMP - DEVOLUCIÓN SE (SIN OPERACIÓN)
	EXEC ProcMan_Comp_GetEventoScripts 'E02200700MXN484' --COMP - DEVOLUCIÓN SE (SIN COMPENSAR)
	EXEC ProcMan_Comp_GetEventoScripts 'E02200000MXN484' --COMP - DEVOLUCIÓN SE
	EXEC ProcMan_Comp_GetEventoScripts 'E02200800MXN484' --COMP - DEVOLUCIÓN SE (A FAVOR)
	EXEC ProcMan_Comp_GetEventoScripts 'E02200900MXN484' --COMP - DEVOLUCIÓN SE (REVERSADA PRESENTADA ACLARADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02260000MXN484' --COMP - RECEPCIÓN FAST FUNDS SE
	EXEC ProcMan_Comp_GetEventoScripts 'E02280100MXN484' --COMP - PAGO/ABONO A TARJETA SE (SIN OPERACIÓN)
	--'E02280000MXN484' --COMP - PAGO/ABONO A TARJETA SE
	EXEC ProcMan_Comp_GetEventoScripts 'E02300100MXN484' --COMP - CONSULTA DE SALDO EN ATM SE (SIN OPERACIÓN)
	EXEC ProcMan_Comp_GetEventoScripts 'E02300000MXN484' --COMP - CONSULTA DE SALDO EN ATM SE
	EXEC ProcMan_Comp_GetEventoScripts 'E02300200MXN484' --COMP - CONSULTA DE SALDO EN ATM SE (DUPLICADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02300300MXN484' --COMP - CONSULTA EN ATM SE (POST DEVUELTA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02300400MXN484' --COMP - CONSULTA DE SALDO EN ATM SE (POST DEVUELTA SIN COMPENSAR)
	EXEC ProcMan_Comp_GetEventoScripts 'E02300500MXN484' --COMP - CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02300600MXN484' --COMP - CONSULTA DE SALDO EN ATM SE (A FAVOR ACLARADA)
	EXEC ProcMan_Comp_GetEventoScripts 'E02200102MXN484' --COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)
	EXEC ProcMan_Comp_GetEventoScripts 'E02200002MXN484' --COMP - REVERSO DEVOLUCIÓN SI
	EXEC ProcMan_Comp_GetEventoScripts 'E02280102MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SE (SIN OPERACIÓN)
	--'E02280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SE
	----E03
	--EXEC ProcMan_Comp_GetEventoScripts 'E03000100MXN484' --COMP - COMPRA/CARGO SAAS (SIN OPERACION)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03000000MXN484' --COMP - COMPRA/CARGO SAAS
	--EXEC ProcMan_Comp_GetEventoScripts 'E03000200MXN484' --COMP - COMPRA/CARGO SAAS (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03000300MXN484' --COMP - COMPRA/CARGO SAAS (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03000400MXN484' --COMP - COMPRA/CARGO SAAS (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03000500MXN484' --COMP - COMPRA/CARGO SAAS (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03000600MXN484' --COMP - COMPRA/CARGO SAAS (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03010100MXN484' --COMP - RETIRO EN ATM SAAS (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03010000MXN484' --COMP - RETIRO EN ATM SAAS
	--EXEC ProcMan_Comp_GetEventoScripts 'E03010200MXN484' --COMP - RETIRO EN ATM SAAS (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03010300MXN484' --COMP - RETIRO EN ATM SAAS (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03010400MXN484' --COMP - RETIRO EN ATM SAAS (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03010500MXN484' --COMP - RETIRO EN ATM SAAS (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03010600MXN484' --COMP - RETIRO EN ATM SAAS (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03090100MXN484' --COMP - COMPRA CON CASHBACK SAAS (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03090000MXN484' --COMP - COMPRA CON CASHBACK SAAS
	--EXEC ProcMan_Comp_GetEventoScripts 'E03090200MXN484' --COMP - COMPRA CON CASHBACK SAAS (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03090300MXN484' --COMP - COMPRA CON CASHBACK SAAS (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03090400MXN484' --COMP - COMPRA CON CASHBACK SAAS (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03090500MXN484' --COMP - COMPRA CON CASHBACK SAAS (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03090600MXN484' --COMP - COMPRA CON CASHBACK SAAS (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03200100MXN484' --COMP - DEVOLUCION SAAS (SIN OPERACIÓN) 
	--EXEC ProcMan_Comp_GetEventoScripts 'E03200700MXN484' --COMP - DEVOLUCION SAAS (SIN COMPENSAR) 
	--EXEC ProcMan_Comp_GetEventoScripts 'E03200000MXN484' --COMP - DEVOLUCION SAAS
	--EXEC ProcMan_Comp_GetEventoScripts 'E03200800MXN484' --COMP - DEVOLUCION SAAS (A FAVOR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03200900MXN484' --COMP - DEVOLUCION SAAS (REVERSADA PRESENTADA ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03260000MXN484' --COMP - RECEPCIÓN FAST FUNDS SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E03261300MXN484' --COMP - RECEPCIÓN FAST FUNDS SI (LIBERADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03261400MXN484' --COMP - RECEPCIÓN FAST FUNDS SI (CANCELADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03280000MXN484' --COMP - PAGO/ABONO A TARJETA SAAS (SIN OPERACIÓN)
	----'E03280000MXN484' --COMP - PAGO/ABONO A TARJETA SAAS
	--EXEC ProcMan_Comp_GetEventoScripts 'E03300100MXN484' --COMP - CONSULTA DE SALDO EN ATM SAAS (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03300000MXN484' --COMP - CONSULTA DE SALDO EN ATM SAAS
	--EXEC ProcMan_Comp_GetEventoScripts 'E03300200MXN484' --COMP - CONSULTA DE SALDO EN ATM SAAS (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03300300MXN484' --COMP - CONSULTA DE SALDO EN ATM SAAS (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03300400MXN484' --COMP - CONSULTA DE SALDO EN ATM SAAS (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03300500MXN484' --COMP - CONSULTA DE SALDO EN ATM SAAS (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03300600MXN484' --COMP - CONSULTA DE SALDO EN ATM SAAS (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E03200102MXN484' --COMP - REVERSO DEVOLUCION SAAS (SIN OPERACIÓN) 
	--EXEC ProcMan_Comp_GetEventoScripts 'E03200002MXN484' --COMP - REVERSO DEVOLUCION SAAS
	--EXEC ProcMan_Comp_GetEventoScripts 'E03280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SAAS (SIN OPERACIÓN)
	----'E03280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SAAS
	----E04
	--EXEC ProcMan_Comp_GetEventoScripts 'E04000000MXN484' --COMP - COMPRA/CARGO SAAS PRE SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E04000400MXN484' --COMP - COMPRA/CARGO SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E04010000MXN484' --COMP - RETIRO ATM SAAS PRE SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E04010400MXN484' --COMP - RETIRO EN ATM SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E04090000MXN484' --COMP - COMPRA CON CAHBACK SAAS PRE SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E04090400MXN484' --COMP - COMPRA CON CASHBACK SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)
	----'E04280000MXN484' --COMP - PAGO/ABONO A TARJETA SAAS PRE SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E04300000MXN484' --COMP - CONSULTA DE SALDO ATM SAAS PRE SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E04300400MXN484' --COMP - CONSULTA DE SALDO EN ATM SAAS PRE SI (POST DEVUELTA SIN COMPENSAR)
	----E05
	--EXEC ProcMan_Comp_GetEventoScripts 'E05000100MXN484' --COMP - COMPRA/CARGO TDC (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05000000MXN484' --COMP - COMPRA/CARGO TDC
	--EXEC ProcMan_Comp_GetEventoScripts 'E05000200MXN484' --COMP - COMPRA/CARGO TDC (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05000300MXN484' --COMP - COMPRA/CARGO TDC (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05000400MXN484' --COMP - COMPRA/CARGO TDC (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05000500MXN484' --COMP - COMPRA/CARGO TDC (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05000600MXN484' --COMP - COMPRA/CARGO TDC (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05010100MXN484' --COMP - RETIRO EN ATM TDC (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05010000MXN484' --COMP - RETIRO EN ATM TDC
	--EXEC ProcMan_Comp_GetEventoScripts 'E05010200MXN484' --COMP - RETIRO EN ATM TDC (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05010300MXN484' --COMP - RETIRO EN ATM TDC (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05010400MXN484' --COMP - RETIRO EN ATM TDC (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05010500MXN484' --COMP - RETIRO EN ATM TDC (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05010600MXN484' --COMP - RETIRO EN ATM TDC (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05011000MXN484' --COMP - RETIRO EN ATM TDC (COMISIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05011100MXN484' --COMP - RETIRO EN ATM TDC (IVA COMISIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05200100MXN484' --COMP - DEVOLUCION TDC (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05200700MXN484' --COMP - DEVOLUCION TDC (SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05200000MXN484' --COMP - DEVOLUCION TDC
	--EXEC ProcMan_Comp_GetEventoScripts 'E05200800MXN484' --COMP - DEVOLUCION TDC (A FAVOR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05200900MXN484' --COMP - DEVOLUCION TDC (DEVUELTA PRESENTADA ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05280000MXN484' --COMP - PAGO/ABONO A TARJETA TDC (SIN OPERACIÓN)
	----'E05280000MXN484' --COMP - PAGO/ABONO A TARJETA TDC
	--EXEC ProcMan_Comp_GetEventoScripts 'E05300100MXN484' --COMP - CONSULTA DE SALDO EN ATM TDC (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05300000MXN484' --COMP - CONSULTA DE SALDO EN ATM TDC
	--EXEC ProcMan_Comp_GetEventoScripts 'E05300200MXN484' --COMP - CONSULTA DE SALDO EN ATM TDC (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05300300MXN484' --COMP - CONSULTA DE SALDO EN ATM TDC (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05300400MXN484' --COMP - CONSULTA DE SALDO EN ATM TDC (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05300500MXN484' --COMP - CONSULTA DE SALDO EN ATM TDC (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05300600MXN484' --COMP - CONSULTA DE SALDO EN ATM TDC (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05010002MXN484' --COMP - REVERSO RETIRO EN ATM TDC
	--EXEC ProcMan_Comp_GetEventoScripts 'E05011002MXN484' --COMP - REVERSO RETIRO EN ATM TDC (COMISIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05011102MXN484' --COMP - REVERSO RETIRO EN ATM TDC (IVA COMISIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E05200102MXN484' --COMP - REVERSO DEVOLUCION TDC (SIN OPERACIÓN) 
	--EXEC ProcMan_Comp_GetEventoScripts 'E05200002MXN484' --COMP - REVERSO DEVOLUCION TDC
	--EXEC ProcMan_Comp_GetEventoScripts 'E05280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA TDC (SIN OPERACIÓN)



	----CRI 188
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000100MXN484' --COMP - COMPRA/CARGO SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000000MXN484' --COMP - COMPRA/CARGO SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000200MXN484' --COMP - COMPRA/CARGO SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000300MXN484' --COMP - COMPRA/CARGO SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000400MXN484' --COMP - COMPRA/CARGO SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000500MXN484' --COMP - COMPRA/CARGO SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000600MXN484' --COMP - COMPRA/CARGO SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010100MXN484' --COMP - RETIRO EN ATM SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010000MXN484' --COMP - RETIRO EN ATM SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010200MXN484' --COMP - RETIRO EN ATM SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010300MXN484' --COMP - RETIRO EN ATM SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010400MXN484' --COMP - RETIRO EN ATM SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010500MXN484' --COMP - RETIRO EN ATM SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010600MXN484' --COMP - RETIRO EN ATM SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090100MXN484' --COMP - COMPRA CON CASHBACK SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090000MXN484' --COMP - COMPRA CON CASHBACK SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090200MXN484' --COMP - COMPRA CON CASHBACK SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090300MXN484' --COMP - COMPRA CON CASHBACK SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090400MXN484' --COMP - COMPRA CON CASHBACK SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090500MXN484' --COMP - COMPRA CON CASHBACK SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090600MXN484' --COMP - COMPRA CON CASHBACK SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200100MXN484' --COMP - DEVOLUCIÓN SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200700MXN484' --COMP - DEVOLUCIÓN SI (SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200000MXN484' --COMP - DEVOLUCIÓN SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200800MXN484' --COMP - DEVOLUCIÓN SI (A FAVOR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200900MXN484' --COMP - DEVOLUCIÓN SI (REVERSADA PRESENTADA ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01260000MXN484' --COMP - RECEPCIÓN FAST FUNDS SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261300MXN484' --COMP - RECEPCIÓN FAST FUNDS SI (LIBERADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261400MXN484' --COMP - RECEPCIÓN FAST FUNDS SI (CANCELADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280100MXN484' --COMP - PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)
	----'E01280000MXN484' --COMP - PAGO/ABONO A TARJETA SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300100MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300000MXN484' --COMP - CONSULTA DE SALDO EN ATM SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300200MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300300MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300400MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300500MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300600MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200102MXN484' --COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200002MXN484' --COMP - REVERSO DEVOLUCIÓN SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280102MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)
	----'E01280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SI
	
	----CRI 840
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000100MXN484' --COMP - COMPRA/CARGO SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000000MXN484' --COMP - COMPRA/CARGO SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000200MXN484' --COMP - COMPRA/CARGO SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000300MXN484' --COMP - COMPRA/CARGO SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000400MXN484' --COMP - COMPRA/CARGO SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000500MXN484' --COMP - COMPRA/CARGO SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01000600MXN484' --COMP - COMPRA/CARGO SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010100MXN484' --COMP - RETIRO EN ATM SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010000MXN484' --COMP - RETIRO EN ATM SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010200MXN484' --COMP - RETIRO EN ATM SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010300MXN484' --COMP - RETIRO EN ATM SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010400MXN484' --COMP - RETIRO EN ATM SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010500MXN484' --COMP - RETIRO EN ATM SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01010600MXN484' --COMP - RETIRO EN ATM SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090100MXN484' --COMP - COMPRA CON CASHBACK SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090000MXN484' --COMP - COMPRA CON CASHBACK SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090200MXN484' --COMP - COMPRA CON CASHBACK SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090300MXN484' --COMP - COMPRA CON CASHBACK SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090400MXN484' --COMP - COMPRA CON CASHBACK SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090500MXN484' --COMP - COMPRA CON CASHBACK SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01090600MXN484' --COMP - COMPRA CON CASHBACK SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200100MXN484' --COMP - DEVOLUCIÓN SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200700MXN484' --COMP - DEVOLUCIÓN SI (SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200000MXN484' --COMP - DEVOLUCIÓN SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200800MXN484' --COMP - DEVOLUCIÓN SI (A FAVOR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200900MXN484' --COMP - DEVOLUCIÓN SI (REVERSADA PRESENTADA ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01260000MXN484' --COMP - RECEPCIÓN FAST FUNDS SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261300MXN484' --COMP - RECEPCIÓN FAST FUNDS SI (LIBERADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261400MXN484' --COMP - RECEPCIÓN FAST FUNDS SI (CANCELADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280100MXN484' --COMP - PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)
	----'E01280000MXN484' --COMP - PAGO/ABONO A TARJETA SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300100MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300000MXN484' --COMP - CONSULTA DE SALDO EN ATM SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300200MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (DUPLICADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300300MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300400MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (POST DEVUELTA SIN COMPENSAR)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300500MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (REVERSADA PRESENTADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01300600MXN484' --COMP - CONSULTA DE SALDO EN ATM SI (A FAVOR ACLARADA)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200102MXN484' --COMP - REVERSO DEVOLUCIÓN SI (SIN OPERACIÓN)
	--EXEC ProcMan_Comp_GetEventoScripts 'E01200002MXN484' --COMP - REVERSO DEVOLUCIÓN SI
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280102MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SI (SIN OPERACIÓN)
	----'E01280002MXN484' --COMP - REVERSO PAGO/ABONO A TARJETA SI
	
	END
	ELSE
	BEGIN	
		--====================================================================================================
		--Nota: Si existe variable NULL, forzamos ROLLBACK
		--====================================================================================================
		SET @commit = 0
		PRINT 'EXISTEN VARIABLES NULL'
		SELECT @idClaveAplicacion_Operation
		,@idClaveAplicacion_Today
		,@idTipoColectiva_04_Emisor
		,@idTipoColectiva_10_Cuentahabiente
		,@idTipoColectiva_34_SubEmisor
		,@idTipoColectiva_40_Switch 
		,@idTipoCuenta_03_Autorizacion
		,@idTipoCuenta_08_Resguardo 
		,@idTipoCuenta_13_Comisiones 
		,@idTipoCuenta_15_PorPagar 
		,@idTipoCuenta_28_EnAclaracion 
		,@idTipoCuenta_29_CreditoOtorgado 
		,@idTipoCuenta_54_Compensacion 
		,@idTipoCuenta_57_Preautorizacion 
		,@idTipoCuenta_70_FeeCollection 
		,@idTipoCuenta_71_IVA 
		,@idTipoCuenta_72_PorAplicar
		,@idTipoCuenta_73_AutorizacionSaaS 
		,@idTipoCuenta_74_CompensacionSaaS 
		,@idTipoCuenta_110_MarkUp 
		,@idTipoEventoCompensacion 
	END


IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN

--SELECT
--	*
--FROM
--	Eventos e
--	INNER JOIN EventoScript es
--		ON es.ID_Evento = e.ID_Evento
--	INNER JOIN ScriptContable sc
--		ON sc.ID_Script = es.ID_Script
--WHERE
--	e.ClaveEvento LIKE 'E%28%484'
--ORDER BY
--	e.ClaveEvento