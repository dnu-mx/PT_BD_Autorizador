USE  [Autorizador]
GO

BEGIN TRAN
	
	DECLARE @commit BIT = 1

	DECLARE @newEvents TABLE
	(
		idEvento BIGINT,
		claveEvento CHAR(20)
	)

	DECLARE @abono BIT = 1
	DECLARE @cargo BIT = 0

		
	DECLARE @ClaveNumericaDivisa VARCHAR (3)= '484'
	
	DECLARE @cveClaveAplicacionOperation VARCHAR(10) = 'OPERATION'
	DECLARE @cveClaveAplicacionToday VARCHAR(10) = 'TODAY'

	DECLARE @cveTipoColectivaCCH VARCHAR(10) = 'CCH'
	DECLARE @cveTipoColectivaEMI VARCHAR(10) = 'EMI'
	DECLARE @cveTipoColectivaGCM VARCHAR(10) = 'GCM'
	DECLARE @cveTipoColectivaSWT VARCHAR(10) = 'SWITCH'
	
	DECLARE @cveTipoCuentaAUS VARCHAR(10) = 'ASAAS'
	DECLARE @cveTipoCuentaAUT VARCHAR(10) = 'CCLC'
	DECLARE @cveTipoCuentaCMP VARCHAR(10) = 'CDC'
	DECLARE @cveTipoCuentaCOM VARCHAR(10) = 'COMS'
	DECLARE @cveTipoCuentaCOS VARCHAR(10) = 'CSAAS'
	DECLARE @cveTipoCuentaCRD VARCHAR(10) = 'CRED'
	DECLARE @cveTipoCuentaCRS VARCHAR(10) = 'CBNR'
	DECLARE @cveTipoCuentaCXP VARCHAR(10) = 'CXP'
	DECLARE @cveTipoCuentaFEE VARCHAR(10) = 'FEECOLL'
	DECLARE @cveTipoCuentaIVA VARCHAR(10) = 'IVA'
	DECLARE @cveTipoCuentaMUP VARCHAR(10) = 'MRKUP'
	DECLARE @cveTipoCuentaPRE VARCHAR(10) = 'PRAUT'
	DECLARE @cveTipoCuentaSBC VARCHAR(10) = 'SBC'
	DECLARE @cveTipoCuentaTXA VARCHAR(10) = 'TXACL'
	
	DECLARE @cveTipoEventoCompensacion VARCHAR(3) = '003'


	--DECLARE @formulaComision VARCHAR(200) = '((@Imp_77_COMP - + @Imp_45_COMP -) * @PorcComisionDisposicion) + @ImpComisionDisposicion'
	--DECLARE @formulaCompensacion VARCHAR(200) = '@Imp_77_COMP - + @Imp_45_COMP -'
	--DECLARE @formulaCompensacionMU VARCHAR(200) = '@Imp_77_COMP - + @Imp_45_COMP - + (((@Imp_77_COMP - * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
	--DECLARE @formulaIvaComision VARCHAR(200) = '(((@Imp_77_COMP - + @Imp_45_COMP -) * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA'
	--DECLARE @formulaMarkUp VARCHAR(200) = '(((@Imp_77_COMP - * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
	--DECLARE @formulaOriginal VARCHAR(200) = '@Imp_06_TRX'
	--DECLARE @formulaOriginalRetiro VARCHAR(200) = '@Imp_06_TRX + ((@Imp_06_TRX * @PorcComisionDisposicion) + @ImpComisionDisposicion) + (((@Imp_06_TRX * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA)'
	--DECLARE @formulaPostDevolucion VARCHAR(200) = '@Imp_Devolucion_Post'
	--DECLARE @formulaImporte VARCHAR(200) = '@Importe'
		
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
		
	DECLARE @idClaveAplicacionOperation INT = 
	(
		SELECT
			ID_ClaveAplicacion
		FROM
			ClaveAplicacion WITH (NOLOCK)
		WHERE
			ClaveAplicacion = @cveClaveAplicacionOperation
	)

	DECLARE @idClaveAplicacionToday INT = 
	(
		SELECT
			ID_ClaveAplicacion
		FROM
			ClaveAplicacion WITH (NOLOCK)
		WHERE
			ClaveAplicacion = @cveClaveAplicacionToday
	)

	DECLARE @idTipoColectivaCCH INT = 
	(
		SELECT
			ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveTipoColectivaCCH
	)
	
	DECLARE @idTipoColectivaEMI INT = 
	(
		SELECT
			ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveTipoColectivaEMI
	)

	DECLARE @idTipoColectivaGCM INT = 
	(
		SELECT
			ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveTipoColectivaGCM
	)

	DECLARE @idTipoColectivaSWT INT =  
	(
		SELECT
			ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveTipoColectivaSWT
	)
	
	DECLARE @idTipoCuentaAUS INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaAUS
	)
	
	DECLARE @idTipoCuentaAUT INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaAUT
	)

	DECLARE @idTipoCuentaCMP INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaCMP
	)

	DECLARE @idTipoCuentaCOM INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaCOM
	)

	DECLARE @idTipoCuentaCOS INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaCOS
	)

	DECLARE @idTipoCuentaCRD INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaCRD
	)

	DECLARE @idTipoCuentaCRS INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaCRS
	)

	DECLARE @idTipoCuentaCXP INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaCXP
	)

	DECLARE @idTipoCuentaFEE INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaFEE
	)

	DECLARE @idTipoCuentaMUP INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaMUP
	)

	DECLARE @idTipoCuentaIVA INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaIVA
	)

	DECLARE @idTipoCuentaPRE INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaPRE
	)

	DECLARE @idTipoCuentaSBC INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaSBC
	)

	DECLARE @idTipoCuentaTXA INT = 
	(
		SELECT 
			ID_TipoCuenta 
		FROM 
			TipoCuenta 
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@ClaveNumericaDivisa 
			AND TipoCuenta.ClaveGenerica = @cveTipoCuentaTXA
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
		--SELECT @idClaveAplicacionOperation
		--,@idClaveAplicacionToday
		--,@idTipoColectivaCCH
		--,@idTipoColectivaEMI
		--,@idTipoColectivaGCM
		--,@idTipoColectivaSWT 
		--,@idTipoCuentaAUS
		--,@idTipoCuentaAUT
		--,@idTipoCuentaCMP
		--,@idTipoCuentaCOM
		--,@idTipoCuentaCOS
		--,@idTipoCuentaCRD
		--,@idTipoCuentaCRS
		--,@idTipoCuentaCXP
		--,@idTipoCuentaFEE
		--,@idTipoCuentaMUP
		--,@idTipoCuentaIVA
		--,@idTipoCuentaPRE 
		--,@idTipoCuentaSBC 
		--,@idTipoCuentaTXA
		--,@idTipoEventoCompensacion

		IF 	@idClaveAplicacionOperation IS NOT NULL
		AND @idClaveAplicacionToday IS NOT NULL
		AND @idTipoColectivaCCH IS NOT NULL
		AND @idTipoColectivaEMI IS NOT NULL
		AND @idTipoColectivaGCM IS NOT NULL
		AND @idTipoColectivaSWT IS NOT NULL
		AND @idTipoCuentaAUS IS NOT NULL
		AND @idTipoCuentaAUT IS NOT NULL
		AND @idTipoCuentaCMP IS NOT NULL
		AND @idTipoCuentaCOM IS NOT NULL
		AND @idTipoCuentaCOS IS NOT NULL
		AND @idTipoCuentaCRD IS NOT NULL
		AND @idTipoCuentaCRS IS NOT NULL
		AND @idTipoCuentaCXP IS NOT NULL
		AND @idTipoCuentaFEE IS NOT NULL
		AND @idTipoCuentaMUP IS NOT NULL
		AND @idTipoCuentaIVA IS NOT NULL
		AND @idTipoCuentaPRE IS NOT NULL
		AND @idTipoCuentaSBC IS NOT NULL
		AND @idTipoCuentaTXA IS NOT NULL
		AND @idTipoEventoCompensacion IS NOT NULL

	BEGIN
	
	----PASO 1 GENERA EVENTOS FALTANTES
	----EXEC ProcMan_Comp_GetIdEvento 'E01201300MXN484', 'COMP - DEVOLUCIÓN SI (LIBERADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E01201400MXN484', 'COMP - DEVOLUCIÓN SI (CANCELADA)', @idTipoEventoCompensacion, 'E00201400MXN484', 'DEVOLUCIÓN EN DISPUTA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E03201300MXN484', 'COMP - DEVOLUCIÓN SAAS (LIBERADA)', @idTipoEventoCompensacion, 'E00200000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'E03201400MXN484', 'COMP - DEVOLUCIÓN SAAS (CANCELADA)', @idTipoEventoCompensacion, 'E00201400MXN484', 'DEVOLUCIÓN EN DISPUTA', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'M01201300MXN484', 'DEVOLUCIÓN SI (LIBERADA)', @idTipoEventoCompensacion, 'M00201300MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'M01201400MXN484', 'DEVOLUCIÓN SI (CANCELADA)', @idTipoEventoCompensacion, 'M00201400MXN484', 'CANCELACIÓN DE DEVOLUCIÓN', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'M03201300MXN484', 'DEVOLUCIÓN SAAS (LIBERADA)', @idTipoEventoCompensacion, 'M00201300MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	----EXEC ProcMan_Comp_GetIdEvento 'M03201400MXN484', 'DEVOLUCIÓN SAAS (CANCELADA)', @idTipoEventoCompensacion, 'M00201400MXN484', 'CANCELACIÓN DE DEVOLUCIÓN', @idEvento OUTPUT
	
	EXEC ProcMan_Comp_GetIdEvento 'E00CD0001MXN484', 'COMP - CARGO DE REGISTRO EN DISPUTA', @idTipoEventoCompensacion, 'E00CD0001MXN484', 'CARGO DE REGISTRO EN DISPUTA', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E00AD0001MXN484', 'COMP - ABONO DE REGISTRO EN DISPUTA', @idTipoEventoCompensacion, 'E00AD0001MXN484', 'ABONO DE REGISTRO EN DISPUTA', @idEvento OUTPUT
	
	--EXEC ProcMan_Comp_GetIdEvento 'E01201500MXN484', 'COMP - DEVOLUCIÓN SI (EN LÍNEA)', @idTipoEventoCompensacion, 'E00201500MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01260000MXN484', 'COMP - FAST FUNDS SI', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261300MXN484', 'COMP - FAST FUNDS SI (LIBERADA)', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261400MXN484', 'COMP - FAST FUNDS SI (CANCELADA)', @idTipoEventoCompensacion, 'E00261400MXN484', 'RECEPCIÓN DE DINERO EN DISPUTA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280000MXN484', 'COMP - PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01281300MXN484', 'COMP - PAGO/ABONO A TARJETA SI (LIBERADA)', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01281400MXN484', 'COMP - PAGO/ABONO A TARJETA SI (CANCELADA)', @idTipoEventoCompensacion, 'E00281400MXN484', 'PAGO DE TRANSFERENCIA EN DISPUTA', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02201500MXN484', 'COMP - DEVOLUCIÓN SE (EN LÍNEA)', @idTipoEventoCompensacion, 'E00201500MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02260000MXN484', 'COMP - FAST FUNDS SE', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	EXEC ProcMan_Comp_GetIdEvento 'E02280000MXN484', 'COMP - PAGO/ABONO A TARJETA SE', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	
	--EXEC ProcMan_Comp_GetIdEvento 'E03201500MXN484', 'COMP - DEVOLUCIÓN SAAS (EN LÍNEA)', @idTipoEventoCompensacion, 'E00201500MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03260000MXN484', 'COMP - FAST FUNDS SAAS', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03261300MXN484', 'COMP - FAST FUNDS SAAS (LIBERADA)', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03261400MXN484', 'COMP - FAST FUNDS SAAS (CANCELADA)', @idTipoEventoCompensacion, 'E00261400MXN484', 'RECEPCIÓN DE DINERO EN DISPUTA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03280000MXN484', 'COMP - PAGO/ABONO A TARJETA SAAS', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03281300MXN484', 'COMP - PAGO/ABONO A TARJETA SAAS (LIBERADA)', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E03281400MXN484', 'COMP - PAGO/ABONO A TARJETA SAAS (CANCELADA)', @idTipoEventoCompensacion, 'E00281400MXN484', 'PAGO DE TRANSFERENCIA EN DISPUTA', @idEvento OUTPUT
	
	--EXEC ProcMan_Comp_GetIdEvento 'E05201500MXN484', 'COMP - DEVOLUCIÓN TDC (EN LÍNEA)', @idTipoEventoCompensacion, 'E00201500MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05280000MXN484', 'COMP - PAGO/ABONO A TARJETA TDC', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05281300MXN484', 'COMP - PAGO/ABONO A TARJETA TDC (LIBERADA)', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E05281400MXN484', 'COMP - PAGO/ABONO A TARJETA TDC (CANCELADA)', @idTipoEventoCompensacion, 'E00281400MXN484', 'PAGO DE TRANSFERENCIA EN DISPUTA', @idEvento OUTPUT
	
	--EXEC ProcMan_Comp_GetIdEvento 'M01261300MXN484', 'FAST FUNDS SI (LIBERADA)', @idTipoEventoCompensacion, 'M00261300MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'M01261400MXN484', 'FAST FUNDS SI (CANCELADA)', @idTipoEventoCompensacion, 'M00261400MXN484', 'DEVOLUCIÓN RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'M01281300MXN484', 'PAGO/ABONO A TARJETA SI (LIBERADA)', @idTipoEventoCompensacion, 'M00281300MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'M01281400MXN484', 'PAGO/ABONO A TARJETA SI (CANCELADA)', @idTipoEventoCompensacion, 'M00281400MXN484', 'DEVOLUCIÓN PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	
	--EXEC ProcMan_Comp_GetIdEvento 'M03261300MXN484', 'FAST FUNDS SAAS (LIBERADA)', @idTipoEventoCompensacion, 'M00261300MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'M03261400MXN484', 'FAST FUNDS SAAS (CANCELADA)', @idTipoEventoCompensacion, 'M00261400MXN484', 'DEVOLUCIÓN RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'M03281300MXN484', 'PAGO/ABONO A TARJETA SAAS (LIBERADA)', @idTipoEventoCompensacion, 'M00281300MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'M03281400MXN484', 'PAGO/ABONO A TARJETA SAAS (CANCELADA)', @idTipoEventoCompensacion, 'M00281400MXN484', 'DEVOLUCIÓN PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	
	--EXEC ProcMan_Comp_GetIdEvento 'M05281300MXN484', 'PAGO/ABONO A TARJETA TDC (LIBERADA)', @idTipoEventoCompensacion, 'M00281300MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'M05281400MXN484', 'PAGO/ABONO A TARJETA TDC (CANCELADA)', @idTipoEventoCompensacion, 'M00281400MXN484', 'DEVOLUCIÓN PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	
	----MXN484
	--EXEC ProcMan_Comp_GetIdEvento 'E00CD0001MXN484', 'COMP - CARGO DE REGISTRO EN DISPUTA', @idTipoEventoCompensacion, 'E00CD0001MXN484', 'CARGO DE REGISTRO EN DISPUTA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E00AD0001MXN484', 'COMP - ABONO DE REGISTRO EN DISPUTA', @idTipoEventoCompensacion, 'E00AD0001MXN484', 'ABONO DE REGISTRO EN DISPUTA', @idEvento OUTPUT
	
	--EXEC ProcMan_Comp_GetIdEvento 'E01201500MXN484', 'COMP - DEVOLUCIÓN SI (EN LÍNEA)', @idTipoEventoCompensacion, 'E00201500MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01260000MXN484', 'COMP - FAST FUNDS SI', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261300MXN484', 'COMP - FAST FUNDS SI (LIBERADA)', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261400MXN484', 'COMP - FAST FUNDS SI (CANCELADA)', @idTipoEventoCompensacion, 'E00261400MXN484', 'RECEPCIÓN DE DINERO EN DISPUTA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280000MXN484', 'COMP - PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01281300MXN484', 'COMP - PAGO/ABONO A TARJETA SI (LIBERADA)', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01281400MXN484', 'COMP - PAGO/ABONO A TARJETA SI (CANCELADA)', @idTipoEventoCompensacion, 'E00281400MXN484', 'PAGO DE TRANSFERENCIA EN DISPUTA', @idEvento OUTPUT
	
		
	----MXN484
	--EXEC ProcMan_Comp_GetIdEvento 'E00CD0001MXN484', 'COMP - CARGO DE REGISTRO EN DISPUTA', @idTipoEventoCompensacion, 'E00CD0001MXN484', 'CARGO DE REGISTRO EN DISPUTA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E00AD0001MXN484', 'COMP - ABONO DE REGISTRO EN DISPUTA', @idTipoEventoCompensacion, 'E00AD0001MXN484', 'ABONO DE REGISTRO EN DISPUTA', @idEvento OUTPUT
	
	--EXEC ProcMan_Comp_GetIdEvento 'E01201500MXN484', 'COMP - DEVOLUCIÓN SI (EN LÍNEA)', @idTipoEventoCompensacion, 'E00201500MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01260000MXN484', 'COMP - FAST FUNDS SI', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261300MXN484', 'COMP - FAST FUNDS SI (LIBERADA)', @idTipoEventoCompensacion, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01261400MXN484', 'COMP - FAST FUNDS SI (CANCELADA)', @idTipoEventoCompensacion, 'E00261400MXN484', 'RECEPCIÓN DE DINERO EN DISPUTA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01280000MXN484', 'COMP - PAGO/ABONO A TARJETA SI', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01281300MXN484', 'COMP - PAGO/ABONO A TARJETA SI (LIBERADA)', @idTipoEventoCompensacion, 'E00280000MXN484', 'PAGO DE TRANSFERENCIA', @idEvento OUTPUT
	--EXEC ProcMan_Comp_GetIdEvento 'E01281400MXN484', 'COMP - PAGO/ABONO A TARJETA SI (CANCELADA)', @idTipoEventoCompensacion, 'E00281400MXN484', 'PAGO DE TRANSFERENCIA EN DISPUTA', @idEvento OUTPUT
	

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
	WHERE
		ClaveEvento IN
		(
			----'E01201300MXN484',
			----'E01201400MXN484',
			----'E03201300MXN484',
			----'E03201400MXN484',
			----'M01201300MXN484',
			----'M01201400MXN484',
			----'M03201300MXN484',
			----'M03201400MXN484',
			
			'E00CD0001MXN484',
			'E00AD0001MXN484',
			
			--'E01201500MXN484',
			--'E01260000MXN484',
			--'E01261300MXN484',
			--'E01261400MXN484',
			--'E01280000MXN484',
			--'E01281300MXN484',
			--'E01281400MXN484',
			
			'E02201500MXN484',
			'E02260000MXN484',
			'E02280000MXN484'--,
			
			--'E03201500MXN484',
			--'E03260000MXN484',
			--'E03261300MXN484',
			--'E03261400MXN484',
			--'E03280000MXN484',
			--'E03281300MXN484',
			--'E03281400MXN484',
			
			--'E05201500MXN484',
			--'E05280000MXN484',
			--'E05281300MXN484',
			--'E05281400MXN484',
			
			--'M01261300MXN484',
			--'M01261400MXN484',
			--'M01281300MXN484',
			--'M01281400MXN484',
			
			--'M03261300MXN484',
			--'M03261400MXN484',
			--'M03281300MXN484',
			--'M03281400MXN484',
			
			--'M05281300MXN484',
			--'M05281400MXN484'

			--'E00CD0001MXN484',
			--'E00AD0001MXN484',

			--'E01201500MXN484',
			--'E01260000MXN484',
			--'E01261300MXN484',
			--'E01261400MXN484',
			--'E01280000MXN484',
			--'E01281300MXN484',
			--'E01281400MXN484'

			--'E00CD0001MXN484',
			--'E00AD0001MXN484',

			--'E01201500MXN484',
			--'E01260000MXN484',
			--'E01261300MXN484',
			--'E01261400MXN484',
			--'E01280000MXN484',
			--'E01281300MXN484',
			--'E01281400MXN484'
		)

	SELECT
		e.*
	FROM
		Eventos e WITH (NOLOCK)
		INNER JOIN @newEvents ne
			ON ne.idEvento = e.ID_Evento

	--PASO 5 GENERA REGISTROS EN REGLAS
	--EXEC ProcMan_Comp_CreateEventosReglas

	--PASO 6 ACTUALIZA CLAVE EDO CTA
	--EXEC ProcMan_Comp_UpdateEventosEdoCta 'DOCK'

	--SELECT
	--	ne.idEvento,
	--	ne.claveEvento,
	--	e.ID_Regla,
	--	e.EsActiva
	--FROM
	--	EventosReglas e WITH (NOLOCK)
	--	INNER JOIN @newEvents ne
	--		ON ne.idEvento = e.ID_Evento
	
	--PASO 7 GENERA REGISTROS EN SCRIPTS Y PERTENENCIAS
	DECLARE @CCHAUTO_Compensacion_A INT
	DECLARE @CCHAUTT_Compensacion_A INT
	DECLARE @CCHCMPO_Compensacion_A INT
	DECLARE @CCHCMPT_Compensacion_A INT
	
	DECLARE @CCHCXPO_Compensacion_C INT
	DECLARE @CCHCXPT_Compensacion_C INT
	
	DECLARE @EMICRSO_Compensacion_A INT
	DECLARE @EMICRST_Compensacion_A INT 
	
	DECLARE @GCMAUSO_Compensacion_A INT
	DECLARE @GCMAUTO_Compensacion_A INT
	DECLARE @GCMAUTT_Compensacion_A INT
	DECLARE @GCMCMPO_Compensacion_A INT
	DECLARE @GCMCMPT_Compensacion_A INT --NEW
	DECLARE @GCMCOSO_Compensacion_A INT
	
	DECLARE @GCMAUTO_Compensacion_C INT
	DECLARE @GCMCMPO_Compensacion_C INT
	DECLARE @GCMCRDT_Compensacion_C INT --NEW
	DECLARE @GCMCXPO_Compensacion_C INT
	DECLARE @GCMCXPT_Compensacion_C INT
	
	DECLARE @CCHAUTO_Importe_A INT 
	
	DECLARE @CCHSBCO_Importe_C INT
	
	DECLARE @EMIPREO_Importe_A INT
	
	DECLARE @GCMAUSO_Importe_A INT
	DECLARE @GCMAUTO_Importe_A INT
	DECLARE @GCMPREO_Importe_A INT
	
	DECLARE @GCMAUTO_Importe_C INT
	DECLARE @GCMCXPO_Importe_C INT
	DECLARE @GCMSBCO_Importe_C INT
		
	DECLARE @CCHAUTO_Original_A INT
	
	DECLARE @CCHAUTO_Original_C INT
	DECLARE @CCHAUTT_Original_C INT
	DECLARE @CCHSBCO_Original_C INT
	DECLARE @CCHSBCT_Original_C INT

	DECLARE @GCMAUSO_Original_A INT
	DECLARE @GCMAUTO_Original_A INT
	DECLARE @GCMCOSO_Original_A INT
	DECLARE @GCMCXPO_Original_A INT
	DECLARE @GCMCXPT_Original_A INT
	DECLARE @GCMPREO_Original_A INT
	DECLARE @GCMPRET_Original_A INT
	
	DECLARE @GCMAUSO_Original_C INT
	DECLARE @GCMAUTO_Original_C INT
	DECLARE @GCMAUTT_Original_C INT
	DECLARE @GCMCXPO_Original_C INT	
	DECLARE @GCMSBCO_Original_C INT
	DECLARE @GCMSBCT_Original_C INT
	
	DECLARE @EMIPREO_Original_A INT
	DECLARE @EMIPRET_Original_A INT
	
	DECLARE @SWTCXPO_Compensacion_A INT
	DECLARE @SWTTXAO_Compensacion_A INT
	
	DECLARE @SWTCXPO_Compensacion_C INT
	DECLARE @SWTCXPT_Compensacion_C INT
	DECLARE @SWTTXAO_Compensacion_C INT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @CCHAUTO_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @CCHAUTT_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @CCHCMPO_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @CCHCMPT_Compensacion_A OUTPUT	

	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionOperation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @CCHCXPO_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @CCHCXPT_Compensacion_C OUTPUT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaCRS, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @EMICRSO_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaCRS, @idClaveAplicacionToday, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @EMICRST_Compensacion_A OUTPUT

	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUS, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @GCMAUSO_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @GCMAUTO_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @GCMAUTT_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCMP, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @GCMCMPO_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @GCMCMPT_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCOS, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @GCMCOSO_Compensacion_A OUTPUT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMAUTO_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCMP, @idClaveAplicacionOperation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMCMPO_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMCRDT_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionOperation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMCXPO_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMCXPT_Compensacion_C OUTPUT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaCXP, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @SWTCXPO_Compensacion_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaTXA, @idClaveAplicacionOperation, @formulaCompensacion, @abono, @validaSaldo, @validaEstatusCuenta, @SWTTXAO_Compensacion_A OUTPUT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaCXP, @idClaveAplicacionOperation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @SWTCXPO_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @SWTCXPT_Compensacion_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaTXA, @idClaveAplicacionOperation, @formulaCompensacion, @cargo, @validaSaldo, @validaEstatusCuenta, @SWTTXAO_Compensacion_C OUTPUT
	
	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaImporte, @abono, @validaSaldo, @validaEstatusCuenta, @CCHAUTO_Importe_A OUTPUT
	
	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaSBC, @idClaveAplicacionOperation, @formulaImporte, @cargo, @validaSaldo, @validaEstatusCuenta, @CCHSBCO_Importe_C OUTPUT

	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaPRE, @idClaveAplicacionOperation, @formulaImporte, @abono, @validaSaldo, @validaEstatusCuenta, @EMIPREO_Importe_A OUTPUT

	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUS, @idClaveAplicacionOperation, @formulaImporte, @abono, @validaSaldo, @validaEstatusCuenta, @GCMAUSO_Importe_A OUTPUT
	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaImporte, @abono, @validaSaldo, @validaEstatusCuenta, @GCMAUTO_Importe_A OUTPUT
	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionOperation, @formulaImporte, @abono, @validaSaldo, @validaEstatusCuenta, @GCMPREO_Importe_A OUTPUT
	
	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaImporte, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMAUTO_Importe_C OUTPUT
	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionOperation, @formulaImporte, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMCXPO_Importe_C OUTPUT
	--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaSBC, @idClaveAplicacionOperation, @formulaImporte, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMSBCO_Importe_C OUTPUT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @CCHAUTO_Original_A OUTPUT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @CCHAUTO_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @CCHAUTT_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaSBC, @idClaveAplicacionOperation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @CCHSBCO_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaSBC, @idClaveAplicacionToday, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @CCHSBCT_Original_C OUTPUT

	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaPRE, @idClaveAplicacionOperation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @EMIPREO_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @EMIPRET_Original_A OUTPUT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUS, @idClaveAplicacionOperation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @GCMAUSO_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @GCMAUTO_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCOS, @idClaveAplicacionOperation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @GCMCOSO_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionOperation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @GCMCXPO_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @GCMCXPT_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionOperation, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @GCMPREO_Original_A OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaOriginal, @abono, @validaSaldo, @validaEstatusCuenta, @GCMPRET_Original_A OUTPUT
	
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUS, @idClaveAplicacionOperation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMAUSO_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionOperation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMAUTO_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMAUTT_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionOperation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMCXPO_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaSBC, @idClaveAplicacionOperation, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMSBCO_Original_C OUTPUT
	EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaSBC, @idClaveAplicacionToday, @formulaOriginal, @cargo, @validaSaldo, @validaEstatusCuenta, @GCMSBCT_Original_C OUTPUT
	
	SELECT 'ProcMan_Comp_GetScriptInfo'
	
	EXEC ProcMan_Comp_GetScriptInfo '@CCHAUTO_Compensacion_A', @CCHAUTO_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@CCHAUTT_Compensacion_A', @CCHAUTT_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@CCHCMPO_Compensacion_A', @CCHCMPO_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@CCHCMPT_Compensacion_A', @CCHCMPT_Compensacion_A
	
	EXEC ProcMan_Comp_GetScriptInfo '@CCHCXPO_Compensacion_C', @CCHCXPO_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@CCHCXPT_Compensacion_C', @CCHCXPT_Compensacion_C
	
	EXEC ProcMan_Comp_GetScriptInfo '@EMICRSO_Compensacion_A', @EMICRSO_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@EMICRST_Compensacion_A', @EMICRST_Compensacion_A
	
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUSO_Compensacion_A', @GCMAUSO_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUTO_Compensacion_A', @GCMAUTO_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUTT_Compensacion_A', @GCMAUTT_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCMPO_Compensacion_A', @GCMCMPO_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCMPT_Compensacion_A', @GCMCMPT_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCOSO_Compensacion_A', @GCMCOSO_Compensacion_A
		
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUTO_Compensacion_C', @GCMAUTO_Compensacion_C	
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCMPO_Compensacion_C', @GCMCMPO_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCRDT_Compensacion_C', @GCMCRDT_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCXPO_Compensacion_C', @GCMCXPO_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCXPT_Compensacion_C', @GCMCXPT_Compensacion_C
	
	EXEC ProcMan_Comp_GetScriptInfo '@SWTCXPO_Compensacion_A', @SWTCXPO_Compensacion_A
	EXEC ProcMan_Comp_GetScriptInfo '@SWTTXAO_Compensacion_A', @SWTTXAO_Compensacion_A
	
	EXEC ProcMan_Comp_GetScriptInfo '@SWTCXPO_Compensacion_C', @SWTCXPO_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@SWTCXPT_Compensacion_C', @SWTCXPT_Compensacion_C
	EXEC ProcMan_Comp_GetScriptInfo '@SWTTXAO_Compensacion_C', @SWTTXAO_Compensacion_C
		
	EXEC ProcMan_Comp_GetScriptInfo '@CCHAUTO_Importe_A', @CCHAUTO_Importe_A
	
	EXEC ProcMan_Comp_GetScriptInfo '@EMIPREO_Importe_A', @EMIPREO_Importe_A
	
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUSO_Importe_A', @GCMAUSO_Importe_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUTO_Importe_A', @GCMAUTO_Importe_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMPREO_Importe_A', @GCMPREO_Importe_A 

	EXEC ProcMan_Comp_GetScriptInfo '@CCHSBCO_Importe_C', @CCHSBCO_Importe_C
	
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUTO_Importe_C', @GCMAUTO_Importe_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCXPO_Importe_C', @GCMCXPO_Importe_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMSBCO_Importe_C', @GCMSBCO_Importe_C

	EXEC ProcMan_Comp_GetScriptInfo '@CCHAUTO_Original_A', @CCHAUTO_Original_A
	
	EXEC ProcMan_Comp_GetScriptInfo '@CCHAUTO_Original_C', @CCHAUTO_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@CCHAUTT_Original_C', @CCHAUTT_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@CCHSBCO_Original_C', @CCHSBCO_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@CCHSBCT_Original_C', @CCHSBCT_Original_C
	
	EXEC ProcMan_Comp_GetScriptInfo '@EMIPREO_Original_A', @EMIPREO_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@EMIPRET_Original_A', @EMIPRET_Original_A

	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUSO_Original_A', @GCMAUSO_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUTO_Original_A', @GCMAUTO_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCOSO_Original_A', @GCMCOSO_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCXPO_Original_A', @GCMCXPO_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCXPT_Original_A', @GCMCXPT_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMPREO_Original_A', @GCMPREO_Original_A
	EXEC ProcMan_Comp_GetScriptInfo '@GCMPRET_Original_A', @GCMPRET_Original_A
	
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUSO_Original_C', @GCMAUSO_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUTO_Original_C', @GCMAUTO_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMAUTT_Original_C', @GCMAUTT_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMCXPO_Original_C', @GCMCXPO_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMSBCO_Original_C', @GCMSBCO_Original_C
	EXEC ProcMan_Comp_GetScriptInfo '@GCMSBCT_Original_C', @GCMSBCT_Original_C
		
	SELECT 'ProcMan_Comp_CreateEventoScripts'

	EXEC ProcMan_Comp_CreateEventoScripts 'E00CD0001MXN484', @SWTCXPO_Compensacion_A, @SWTTXAO_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E00AD0001MXN484', @SWTCXPO_Compensacion_C, @SWTTXAO_Compensacion_A
	
	----EXEC ProcMan_Comp_CreateEventoScripts 'E01201300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	----EXEC ProcMan_Comp_CreateEventoScripts 'E01201400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C
	----EXEC ProcMan_Comp_CreateEventoScripts 'E03201300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCMPO_Compensacion_C, @GCMCXPO_Compensacion_C, @GCMAUSO_Compensacion_A, @GCMAUSO_Original_C, @GCMCOSO_Original_A, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	----EXEC ProcMan_Comp_CreateEventoScripts 'E03201400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C
	----EXEC ProcMan_Comp_CreateEventoScripts 'M01201300MXN484', @CCHAUTO_Original_A, @CCHSBCO_Original_C, @GCMAUTO_Original_C
	----EXEC ProcMan_Comp_CreateEventoScripts 'M01201400MXN484', @CCHSBCO_Original_C, @EMIPREO_Original_A
	----EXEC ProcMan_Comp_CreateEventoScripts 'M03201300MXN484', @CCHAUTO_Original_A, @CCHSBCO_Original_C, @GCMAUTO_Original_C, @GCMPREO_Original_A, @GCMSBCO_Original_C, @GCMAUSO_Original_A
	----EXEC ProcMan_Comp_CreateEventoScripts 'M03201400MXN484', @CCHSBCO_Original_C, @GCMPREO_Original_A, @GCMSBCO_Original_C, @EMIPREO_Original_A
	
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01201500MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01260000MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280000MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01281300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01281400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C
	
	
	EXEC ProcMan_Comp_CreateEventoScripts 'E02201500MXN484', @GCMAUTO_Compensacion_A, @GCMCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @GCMAUTO_Original_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02260000MXN484', @GCMAUTO_Compensacion_A, @GCMCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @GCMAUTO_Original_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	EXEC ProcMan_Comp_CreateEventoScripts 'E02280000MXN484', @GCMAUTO_Compensacion_A, @GCMCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @GCMAUTO_Original_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03201500MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMAUTO_Compensacion_C, @GCMCMPO_Compensacion_C, @GCMPREO_Original_A, @GCMCXPO_Compensacion_C, @GCMSBCO_Original_C, @GCMAUSO_Compensacion_A, @GCMCOSO_Compensacion_A, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03260000MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMAUTO_Compensacion_C, @GCMCMPO_Compensacion_C, @GCMPREO_Original_A, @GCMCXPO_Compensacion_C, @GCMSBCO_Original_C, @GCMAUSO_Compensacion_A, @GCMCOSO_Compensacion_A, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03261300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCMPO_Compensacion_C, @GCMCXPO_Compensacion_C, @GCMAUSO_Compensacion_A, @GCMAUSO_Original_C, @GCMCOSO_Original_A, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03261400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03280000MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMAUTO_Compensacion_C, @GCMCMPO_Compensacion_C, @GCMPREO_Original_A, @GCMCXPO_Compensacion_C, @GCMSBCO_Original_C, @GCMAUSO_Compensacion_A, @GCMCOSO_Compensacion_A, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03281300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCMPO_Compensacion_C, @GCMCXPO_Compensacion_C, @GCMAUSO_Compensacion_A, @GCMAUSO_Original_C, @GCMCOSO_Original_A, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E03281400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C

	--EXEC ProcMan_Comp_CreateEventoScripts 'E05201500MXN484', @CCHAUTT_Compensacion_A, @CCHCMPT_Compensacion_A, @CCHCXPT_Compensacion_C, @CCHSBCT_Original_C, @GCMAUTT_Compensacion_A, @GCMCMPT_Compensacion_A, @GCMCXPT_Compensacion_C, @GCMCRDT_Compensacion_C, @EMIPRET_Original_A, @SWTCXPT_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05280000MXN484', @CCHAUTT_Compensacion_A, @CCHCMPT_Compensacion_A, @CCHCXPT_Compensacion_C, @CCHSBCT_Original_C, @GCMAUTT_Compensacion_A, @GCMCXPT_Compensacion_C, @GCMPRET_Original_A, @GCMSBCT_Original_C, @EMIPRET_Original_A, @SWTCXPT_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05281300MXN484', @CCHAUTT_Compensacion_A, @CCHAUTT_Original_C, @CCHCMPT_Compensacion_A, @CCHCXPT_Compensacion_C, @GCMAUTT_Compensacion_A, @GCMAUTT_Original_C, @GCMCXPT_Compensacion_C, @GCMCXPT_Original_A, @EMIPRET_Original_A, @SWTCXPT_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E05281400MXN484', @EMICRST_Compensacion_A, @SWTCXPT_Compensacion_C

	--EXEC ProcMan_Comp_CreateEventoScripts 'M01261300MXN484', @CCHAUTO_Importe_A, @CCHSBCO_Importe_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'M01261400MXN484', @CCHSBCO_Importe_C, @EMIPREO_Importe_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'M01281300MXN484', @CCHAUTO_Importe_A, @CCHSBCO_Importe_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'M01281400MXN484', @CCHSBCO_Importe_C, @EMIPREO_Importe_A
	
	--EXEC ProcMan_Comp_CreateEventoScripts 'M03261300MXN484', @CCHAUTO_Importe_A, @CCHSBCO_Importe_C, @GCMAUTO_Importe_C, @GCMPREO_Importe_A, @GCMSBCO_Importe_C, @GCMAUSO_Importe_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'M03261400MXN484', @CCHSBCO_Importe_C, @GCMPREO_Importe_A, @GCMSBCO_Importe_C, @EMIPREO_Importe_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'M03281300MXN484', @CCHAUTO_Importe_A, @CCHSBCO_Importe_C, @GCMAUTO_Importe_C, @GCMPREO_Importe_A, @GCMSBCO_Importe_C, @GCMAUSO_Importe_A
	--EXEC ProcMan_Comp_CreateEventoScripts 'M03281400MXN484', @CCHSBCO_Importe_C, @GCMPREO_Importe_A, @GCMSBCO_Importe_C, @EMIPREO_Importe_A
	
	--EXEC ProcMan_Comp_CreateEventoScripts 'M05281300MXN484', @CCHAUTO_Importe_A, @CCHSBCO_Importe_C, @GCMAUTO_Importe_A, @GCMCXPO_Importe_C, @GCMPREO_Importe_A, @GCMSBCO_Importe_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'M05281400MXN484', @CCHSBCO_Importe_C, @GCMPREO_Importe_A, @GCMSBCO_Importe_C, @EMIPREO_Importe_A

	----MXN484
	--EXEC ProcMan_Comp_CreateEventoScripts 'E00CD0001MXN484', @SWTCXPO_Compensacion_A, @SWTTXAO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E00AD0001MXN484', @SWTCXPO_Compensacion_C, @SWTTXAO_Compensacion_A

	--EXEC ProcMan_Comp_CreateEventoScripts 'E01201500MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01260000MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280000MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01281300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01281400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C

	----MXN484
	--EXEC ProcMan_Comp_CreateEventoScripts 'E00CD0001MXN484', @SWTCXPO_Compensacion_A, @SWTTXAO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E00AD0001MXN484', @SWTCXPO_Compensacion_C, @SWTTXAO_Compensacion_A

	--EXEC ProcMan_Comp_CreateEventoScripts 'E01201500MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01260000MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01261400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01280000MXN484', @CCHAUTO_Compensacion_A, @CCHCMPO_Compensacion_A, @CCHSBCO_Original_C, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01281300MXN484', @CCHAUTO_Compensacion_A, @CCHAUTO_Original_C, @CCHCMPO_Compensacion_A, @GCMCXPO_Compensacion_C, @EMIPREO_Original_A, @SWTCXPO_Compensacion_C
	--EXEC ProcMan_Comp_CreateEventoScripts 'E01281400MXN484', @EMICRSO_Compensacion_A, @SWTCXPO_Compensacion_C
	
	----EXEC ProcMan_Comp_GetEventoScripts 'E01201300MXN484'
	----EXEC ProcMan_Comp_GetEventoScripts 'E01201400MXN484'
	----EXEC ProcMan_Comp_GetEventoScripts 'E03201300MXN484'
	----EXEC ProcMan_Comp_GetEventoScripts 'E03201400MXN484'
	----EXEC ProcMan_Comp_GetEventoScripts 'M01201300MXN484'
	----EXEC ProcMan_Comp_GetEventoScripts 'M01201400MXN484'
	----EXEC ProcMan_Comp_GetEventoScripts 'M03201300MXN484'
	----EXEC ProcMan_Comp_GetEventoScripts 'M03201400MXN484'
	
	EXEC ProcMan_Comp_GetEventoScripts 'E00CD0001MXN484'
	EXEC ProcMan_Comp_GetEventoScripts 'E00AD0001MXN484'

	--EXEC ProcMan_Comp_GetEventoScripts 'E01201500MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01260000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261400MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01281300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01281400MXN484'
	
	
	EXEC ProcMan_Comp_GetEventoScripts 'E02201500MXN484'
	EXEC ProcMan_Comp_GetEventoScripts 'E02260000MXN484'
	EXEC ProcMan_Comp_GetEventoScripts 'E02280000MXN484'
	
	--EXEC ProcMan_Comp_GetEventoScripts 'E03201500MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E03260000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E03261300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E03261400MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E03280000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E03281300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E03281400MXN484'

	--EXEC ProcMan_Comp_GetEventoScripts 'E05201500MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E05280000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E05281300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E05281400MXN484'

	--EXEC ProcMan_Comp_GetEventoScripts 'M01261300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'M01261400MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'M01281300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'M01281400MXN484'
	
	--EXEC ProcMan_Comp_GetEventoScripts 'M03261300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'M03261400MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'M03281300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'M03281400MXN484'
	
	--EXEC ProcMan_Comp_GetEventoScripts 'M05281300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'M05281400MXN484'


	----MXN484
	--EXEC ProcMan_Comp_GetEventoScripts 'E00CD0001MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E00AD0001MXN484'

	--EXEC ProcMan_Comp_GetEventoScripts 'E01201500MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01260000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261400MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01281300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01281400MXN484'

	----MXN484
	--EXEC ProcMan_Comp_GetEventoScripts 'E00CD0001MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E00AD0001MXN484'

	--EXEC ProcMan_Comp_GetEventoScripts 'E01201500MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01260000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01261400MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01280000MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01281300MXN484'
	--EXEC ProcMan_Comp_GetEventoScripts 'E01281400MXN484'

	END
	ELSE
	BEGIN	
		--====================================================================================================
		--Nota: Si existe variable NULL, forzamos ROLLBACK
		--====================================================================================================
		SET @commit = 0
		PRINT 'EXISTEN VARIABLES NULL'
		SELECT @idClaveAplicacionOperation
		,@idClaveAplicacionToday
		,@idTipoColectivaCCH
		,@idTipoColectivaEMI
		,@idTipoColectivaGCM
		,@idTipoColectivaSWT 
		,@idTipoCuentaAUS
		,@idTipoCuentaAUT
		,@idTipoCuentaCMP
		,@idTipoCuentaCOM
		,@idTipoCuentaCOS
		,@idTipoCuentaCRD
		,@idTipoCuentaCRS
		,@idTipoCuentaCXP
		,@idTipoCuentaFEE
		,@idTipoCuentaMUP
		,@idTipoCuentaIVA
		,@idTipoCuentaPRE 
		,@idTipoCuentaSBC 
		,@idTipoCuentaTXA
		,@idTipoEventoCompensacion

	END


IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN