USE [Autorizador]
GO

BEGIN TRAN

	DECLARE @commit BIT = 1

	--====================================================================================================
	--Paso: 1
	--Nota: Declaración de variables
	--====================================================================================================
	DECLARE @cveNumericaDivisa VARCHAR (3)= '484'
	
	DECLARE @abono BIT = 1
	DECLARE @cargo BIT = 0

	DECLARE @validaEstatusCuenta_No BIT = 0
	DECLARE @validaEstatusCuenta_Si BIT = 1

	DECLARE @validaSaldo_No BIT = 0
	DECLARE @validaSaldo_Si BIT = 1

	DECLARE @catalogoClaveAplicacion VARCHAR(20) = 'ClaveAplicacion'
	DECLARE @catalogoTipoColectiva VARCHAR(20) = 'TipoColectiva'
	DECLARE @catalogoTipoCuenta VARCHAR(20) = 'TipoCuenta'
	DECLARE @catalogoTipoEvento VARCHAR(20) = 'TipoEvento'

	DECLARE @cveClaveAplicacionOperation VARCHAR(10) = 'OPERATION'
	DECLARE @cveClaveAplicacionToday VARCHAR(10) = 'TODAY'

	DECLARE @cveTipoColectivaBAN VARCHAR(10) = 'BAN'
	DECLARE @cveTipoColectivaCCH VARCHAR(10) = 'CCH'
	DECLARE @cveTipoColectivaEMI VARCHAR(10) = 'EMI'
	DECLARE @cveTipoColectivaGCM VARCHAR(10) = 'GCM'
	DECLARE @cveTipoColectivaPTH VARCHAR(10) = 'PTH'
	DECLARE @cveTipoColectivaSWT VARCHAR(10) = 'SWITCH'
	
	DECLARE @cveTipoCuentaAUT VARCHAR(10) = 'CCLC'
	DECLARE @cveTipoCuentaBAN VARCHAR(10) = 'BAN'
	DECLARE @cveTipoCuentaCMP VARCHAR(10) = 'CDC'
	DECLARE @cveTipoCuentaCOM VARCHAR(10) = 'COMS'
	DECLARE @cveTipoCuentaCRD VARCHAR(10) = 'CRED'
	DECLARE @cveTipoCuentaCRS VARCHAR(10) = 'CBNR'
	DECLARE @cveTipoCuentaCXP VARCHAR(10) = 'CXP'	
	DECLARE @cveTipoCuentaFEE VARCHAR(10) = 'FEECOLL'
	DECLARE @cveTipoCuentaINM VARCHAR(10) = 'INTMOR'
	DECLARE @cveTipoCuentaINO VARCHAR(10) = 'INTORD'
	DECLARE @cveTipoCuentaIVA VARCHAR(10) = 'IVA'
	DECLARE @cveTipoCuentaLCR VARCHAR(10) = 'CLDC'
	DECLARE @cveTipoCuentaMUP VARCHAR(10) = 'MRKUP'
	DECLARE @cveTipoCuentaPRE VARCHAR(10) = 'PRAUT'
	DECLARE @cveTipoCuentaTXA VARCHAR(10) = 'TXACL'
	DECLARE @cveTipoCuentaSBC VARCHAR(10) = 'SBC'
	DECLARE @cveTipoCuentaCINT VARCHAR(10) = 'CINT'
	
	DECLARE @cveTipoEventoAutomatico VARCHAR(3) = '003'
	DECLARE @cveTipoEventoManual VARCHAR(3) = '002'
	DECLARE @cveTipoEventoCompensacion VARCHAR(3) = '003'
	DECLARE @cveTipoEventoTransaccional VARCHAR(3) = '001'

	DECLARE @idClaveAplicacionOperation INT
	DECLARE @idClaveAplicacionToday INT


	EXEC ProcMan_Comp_GetIdCatalogo @catalogoClaveAplicacion, @cveClaveAplicacionOperation, NULL, @idClaveAplicacionOperation OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoClaveAplicacion, @cveClaveAplicacionToday, NULL, @idClaveAplicacionToday OUTPUT

	DECLARE @idTipoColectivaBAN INT
	DECLARE @idTipoColectivaCCH INT
	DECLARE @idTipoColectivaEMI INT
	DECLARE @idTipoColectivaGCM INT
	DECLARE @idTipoColectivaPTH INT
	DECLARE @idTipoColectivaSWT INT

	
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoColectiva, @cveTipoColectivaBAN, NULL, @idTipoColectivaBAN OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoColectiva, @cveTipoColectivaCCH, NULL, @idTipoColectivaCCH OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoColectiva, @cveTipoColectivaEMI, NULL, @idTipoColectivaEMI OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoColectiva, @cveTipoColectivaGCM, NULL, @idTipoColectivaGCM OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoColectiva, @cveTipoColectivaPTH, NULL, @idTipoColectivaPTH OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoColectiva, @cveTipoColectivaSWT, NULL, @idTipoColectivaSWT OUTPUT
		
	DECLARE @idTipoCuentaAUT INT
	DECLARE @idTipoCuentaBAN INT
	DECLARE @idTipoCuentaCMP INT
	DECLARE @idTipoCuentaCOM INT
	DECLARE @idTipoCuentaCRD INT
	DECLARE @idTipoCuentaCRS INT
	DECLARE @idTipoCuentaCXP INT
	DECLARE @idTipoCuentaFEE INT
	DECLARE @idTipoCuentaINM INT
	DECLARE @idTipoCuentaINO INT
	DECLARE @idTipoCuentaIVA INT
	DECLARE @idTipoCuentaLCR INT
	DECLARE @idTipoCuentaMUP INT
	DECLARE @idTipoCuentaPRE INT
	DECLARE @idTipoCuentaTXA INT
	DECLARE @idTipoCuentaSBC INT
	DECLARE @idTipoCuentaCINT INT

	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaAUT, @cveNumericaDivisa, @idTipoCuentaAUT OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaBAN, @cveNumericaDivisa, @idTipoCuentaBAN OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaCMP, @cveNumericaDivisa, @idTipoCuentaCMP OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaCOM, @cveNumericaDivisa, @idTipoCuentaCOM OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaCRD, @cveNumericaDivisa, @idTipoCuentaCRD OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaCRS, @cveNumericaDivisa, @idTipoCuentaCRS OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaCXP, @cveNumericaDivisa, @idTipoCuentaCXP OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaFEE, @cveNumericaDivisa, @idTipoCuentaFEE OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaINM, @cveNumericaDivisa, @idTipoCuentaINM OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaINO, @cveNumericaDivisa, @idTipoCuentaINO OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaIVA, @cveNumericaDivisa, @idTipoCuentaIVA OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaLCR, @cveNumericaDivisa, @idTipoCuentaLCR OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaMUP, @cveNumericaDivisa, @idTipoCuentaMUP OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaPRE, @cveNumericaDivisa, @idTipoCuentaPRE OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaTXA, @cveNumericaDivisa, @idTipoCuentaTXA OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaSBC, @cveNumericaDivisa, @idTipoCuentaSBC OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoCuenta, @cveTipoCuentaCINT,@cveNumericaDivisa, @idTipoCuentaCINT OUTPUT


	DECLARE @idTipoEventoAutomatico INT
	DECLARE @idTipoEventoManual INT
	DECLARE @idTipoEventoCompensacion INT
	DECLARE @idTipoEventoTransaccional INT

	
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoEvento, @cveTipoEventoAutomatico, NULL, @idTipoEventoAutomatico OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoEvento, @cveTipoEventoManual, NULL, @idTipoEventoManual OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoEvento, @cveTipoEventoCompensacion, NULL, @idTipoEventoCompensacion OUTPUT
	EXEC ProcMan_Comp_GetIdCatalogo @catalogoTipoEvento, @cveTipoEventoTransaccional, NULL, @idTipoEventoTransaccional OUTPUT
	

	--SELECT 	@idClaveAplicacionOperation, 
	--	 @idClaveAplicacionToday,
	--	 @idTipoColectivaBAN ,
	--	 @idTipoColectivaCCH ,
	--	 @idTipoColectivaEMI, 
	--	 @idTipoColectivaGCM, 
	--	 @idTipoColectivaPTH, 
	--	 @idTipoColectivaSWT, 
	--	 @idTipoCuentaAUT, 
	--	 @idTipoCuentaBAN, 
	--	 @idTipoCuentaCMP, 
	--	 @idTipoCuentaCOM, 
	--	 @idTipoCuentaCRD, 
	--	 @idTipoCuentaCRS, 
	--	 @idTipoCuentaCXP, 
	--	 @idTipoCuentaFEE, 
	--	 @idTipoCuentaINM, 
	--	 @idTipoCuentaINO, 
	--	 @idTipoCuentaIVA, 
	--	 @idTipoCuentaLCR, 
	--	 @idTipoCuentaMUP, 
	--	 @idTipoCuentaPRE, 
	--	 @idTipoCuentaTXA, 
	--	 @idTipoCuentaSBC,
	--   @idTipoCuentaCINT,
	--	 @idTipoEventoAutomatico, 
	--	 @idTipoEventoCompensacion, 
	--	 @idTipoEventoManual

	--====================================================================================================
	--Paso: 2
	--Nota: Validación de que no se tengan variables NULL
	--====================================================================================================
	IF 	@idClaveAplicacionOperation IS NOT NULL
		AND @idClaveAplicacionToday IS NOT NULL
		AND @idTipoColectivaBAN IS NOT NULL
		AND @idTipoColectivaCCH IS NOT NULL
		AND @idTipoColectivaEMI IS NOT NULL
		AND @idTipoColectivaGCM IS NOT NULL
		AND @idTipoColectivaPTH IS NOT NULL
		AND @idTipoColectivaSWT IS NOT NULL
		AND @idTipoCuentaAUT IS NOT NULL
		--AND @idTipoCuentaBAN IS NOT NULL
		AND @idTipoCuentaCMP IS NOT NULL
		AND @idTipoCuentaCOM IS NOT NULL
		AND @idTipoCuentaCRD IS NOT NULL
		AND @idTipoCuentaCRS IS NOT NULL
		AND @idTipoCuentaCXP IS NOT NULL
		AND @idTipoCuentaFEE IS NOT NULL
		--AND @idTipoCuentaINM IS NOT NULL
		--AND @idTipoCuentaINO IS NOT NULL
		--AND @idTipoCuentaIVA IS NOT NULL
		AND @idTipoCuentaLCR IS NOT NULL
		--AND @idTipoCuentaMUP IS NOT NULL
		AND @idTipoCuentaPRE IS NOT NULL
		AND @idTipoCuentaTXA IS NOT NULL
		AND @idTipoCuentaSBC IS NOT NULL
		--AND @idTipoCuentaCINT IS NOT NULL
		AND @idTipoEventoAutomatico IS NOT NULL
		AND @idTipoEventoCompensacion IS NOT NULL
		AND @idTipoEventoManual IS NOT NULL
	BEGIN

		--====================================================================================================
		--Paso: 3
		--Nota: Definición de fórmulas
		--====================================================================================================
		--DECLARE @formulaImp VARCHAR(200) = '@Importe'
		--DECLARE @formulaImpBonificacion VARCHAR(200) = '@Importe / (1 + @IVA)'
		--DECLARE @formulaImpBonificacionIva VARCHAR(200) = '@Importe - (@Importe / (1 + @IVA))'
		--DECLARE @formulaImpComision VARCHAR(200) = '((@Imp_77_T112 + @Imp_45_T112) * @PorcComisionDisposicion) + @ImpComisionDisposicion'
		--DECLARE @formulaImpComisionIva VARCHAR(200) = '(((@Imp_77_T112 + @Imp_45_T112) * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA'
		--DECLARE @formulaImpComp VARCHAR(200) = '@Imp_77_T112 + @Imp_45_T112'
		--DECLARE @formulaImpCompMarkUp VARCHAR(200) = '@Imp_77_T112 + @Imp_45_T112 + (((@Imp_77_T112 * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
		--DECLARE @formulaImpCompMarkUpPostDev VARCHAR(200) = '(@Imp_77_T112 + @Imp_45_T112 + (((@Imp_77_T112 * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)) - @Imp_Devolucion_Post'
		--DECLARE @formulaImpCompOriginal VARCHAR(200) = '@Imp_06_TRX'
		--DECLARE @formulaImpCompOriginalRetiro VARCHAR(200) = '(@Imp_06_TRX + ((@Imp_06_TRX * @PorcComisionDisposicion) + @ImpComisionDisposicion) * (1 + @IVA))'
		--DECLARE @formulaImpLimCredito VARCHAR(200) = '@Saldo_CLDC'
		--DECLARE @formulaImpMarkUp VARCHAR(200) = '(((@Imp_77_T112 * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
		--DECLARE @formulaImpPostDev VARCHAR(200) = '@Imp_Devolucion_Post'
		--DECLARE @formulaImpRetiro VARCHAR(200) = '@Importe + ((@Importe * @PorcComisionDisposicion) + @ImpComisionDisposicion) * (1 + @IVA))'
		--DECLARE @formulaImpSpei VARCHAR(200) = '((@Importe * @PjeComisionSPEIout) + @ImpComisionSPEIout)'
		--DECLARE @formulaCuotaIntercambioSwitch VARCHAR(200) = '@CuotaIntercambio'
		--DECLARE @formulaCuotaIntercambioEmisor VARCHAR(200) = '@CuotaIntercambio * (1 - @PjeCuotaIntercambioEmisorASubEmisor)'
		--DECLARE @formulaCuotaIntercambioSubEmisor VARCHAR(200) = '@CuotaIntercambio * @PjeCuotaIntercambioEmisorASubEmisor'

		DECLARE @formulaImp VARCHAR(200) = '@Importe'
		DECLARE @formulaImpBonificacion VARCHAR(200) = '@Importe / (1 + @IVA)'
		DECLARE @formulaImpBonificacionIva VARCHAR(200) = '@Importe - (@Importe / (1 + @IVA))'
		DECLARE @formulaImpRetiroTRXComision VARCHAR(200) = '@Importe + (((@Importe * @PorcComisionDisposicion) + @ImpComisionDisposicion) * (1 + @IVA))'
		DECLARE @formulaImpComision VARCHAR(200) = '((@impCompensacion) * @PorcComisionDisposicion) + @ImpComisionDisposicion'
		DECLARE @formulaImpComisionIva VARCHAR(200) = '(((@impCompensacion) * @PorcComisionDisposicion) + @ImpComisionDisposicion) * @IVA'
		DECLARE @formulaImpComp VARCHAR(200) = '@impCompensacion'
		--DECLARE @formulaImpCompMarkUp VARCHAR(200) = '(((@impCompensacion * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
		--DECLARE @formulaImpCompMarkUpPostDev VARCHAR(200) = '(((@impCompensacion * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp) - @impPreviamenteDevuelto'
		DECLARE @formulaImpCompMarkUp VARCHAR(200) = '@impCompensacion'
		DECLARE @formulaImpCompMarkUpPostDev VARCHAR(200) = '@impCompensacion - @impPreviamenteDevuelto'
		DECLARE @formulaImpCompOriginal VARCHAR(200) = '@impOperacionOriginal'
		--DECLARE @formulaImpCompOriginalRetiro VARCHAR(200) = '(@impOperacionOriginal + ((@impOperacionOriginal * @PorcComisionDisposicion) + @ImpComisionDisposicion) * (1 + @IVA))'
		DECLARE @formulaImpCompOriginalRetiro VARCHAR(200) = '@impOperacionOriginal'
		DECLARE @formulaImpLimCredito VARCHAR(200) = '@Saldo_CLDC'
		DECLARE @formulaImpMarkUp VARCHAR(200) = '(((@impCompensacion * @MarkUpPorcentaje) + @MarkUpFijo) * @aplica_MarkUp)'
		DECLARE @formulaImpPostDev VARCHAR(200) = '@impPreviamenteDevuelto'
		DECLARE @formulaImpRetiro VARCHAR(200) = '@Importe + ((@Importe * @PorcComisionDisposicion) + @ImpComisionDisposicion) * (1 + @IVA))'
		DECLARE @formulaImpSpei VARCHAR(200) = '((@Importe * @PjeComisionSPEIout) + @ImpComisionSPEIout)'

		DECLARE @formulaCuotaIntercambioSwitch VARCHAR(200) = '@impCuotaIntercambio'
		DECLARE @formulaCuotaIntercambioEmisor VARCHAR(200) = '(@impCuotaIntercambio * (1 - @pjeCuotaIntercambioEmisorASubEmisor))'
		DECLARE @formulaCuotaIntercambioSubEmisor VARCHAR(200) = '(@impCuotaIntercambio * @pjeCuotaIntercambioEmisorASubEmisor)'

		--====================================================================================================
		--Paso: 4
		--Nota: Generación y obtención de script contables. La composición de la variable es
		--		TipoColectiva_TipoCuenta_ClaveAplicacion_Formula_EsAbono_ValidaSaldo_ValidaEstatusCuenta
		--
		--		Si se requiere generar una nueva, se debe declarar a partir de la composición arriba descrita,
		--		se debe invocar el ProcMan_Comp_GetIdScript y con el ProcMan_Comp_GetScriptInfo se valida
		--====================================================================================================
		
		--SCRIPTS CONTABLES TRANSACCIONALES

		DECLARE @CCH_AUT_NULL_Imp_A_No_NULL INT
		DECLARE @CCH_AUT_NULL_Imp_C_Si_NULL INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, NULL, @formulaImp, @abono, @validaSaldo_No, NULL, @CCH_AUT_NULL_Imp_A_No_NULL OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, NULL, @formulaImp, @cargo, @validaSaldo_Si, NULL, @CCH_AUT_NULL_Imp_C_Si_NULL OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_NULL_Imp_A_No_NULL', @CCH_AUT_NULL_Imp_A_No_NULL
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_NULL_Imp_C_Si_NULL', @CCH_AUT_NULL_Imp_C_Si_NULL

		DECLARE @PTH_AUT_NULL_Imp_A_No_NULL INT
		DECLARE @PTH_AUT_NULL_Imp_C_Si_NULL INT
		DECLARE @PTH_AUT_NULL_Imp_C_No_NULL INT

		
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, NULL, @formulaImp, @abono, @validaSaldo_No, NULL, @PTH_AUT_NULL_Imp_A_No_NULL OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, NULL, @formulaImp, @cargo, @validaSaldo_Si, NULL, @PTH_AUT_NULL_Imp_C_Si_NULL OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, NULL, @formulaImp, @cargo, @validaSaldo_No, NULL, @PTH_AUT_NULL_Imp_C_No_NULL OUTPUT


		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_NULL_Imp_A_No_NULL', @PTH_AUT_NULL_Imp_A_No_NULL
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_NULL_Imp_C_Si_NULL', @PTH_AUT_NULL_Imp_C_Si_NULL
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_NULL_Imp_C_No_NULL', @PTH_AUT_NULL_Imp_C_No_NULL

		
		DECLARE @PTH_AUT_NULL_ImpRetiroTRXCom_A_No_NULL INT
		DECLARE @PTH_AUT_NULL_ImpRetiroTRXCom_C_Si_NULL INT
		DECLARE @PTH_AUT_NULL_ImpRetiroTRXCom_C_No_NULL INT

		
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, NULL, @formulaImpRetiroTRXComision, @abono, @validaSaldo_No, NULL, @PTH_AUT_NULL_ImpRetiroTRXCom_A_No_NULL OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, NULL, @formulaImpRetiroTRXComision, @cargo, @validaSaldo_Si, NULL, @PTH_AUT_NULL_ImpRetiroTRXCom_C_Si_NULL OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, NULL, @formulaImpRetiroTRXComision, @cargo, @validaSaldo_No, NULL, @PTH_AUT_NULL_ImpRetiroTRXCom_C_No_NULL OUTPUT


		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_NULL_ImpRetiroTRXCom_A_No_NULL', @PTH_AUT_NULL_ImpRetiroTRXCom_A_No_NULL
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_NULL_ImpRetiroTRXCom_C_Si_NULL', @PTH_AUT_NULL_ImpRetiroTRXCom_C_Si_NULL
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_NULL_ImpRetiroTRXCom_C_No_NULL', @PTH_AUT_NULL_ImpRetiroTRXCom_C_No_NULL

		DECLARE @EMI_PRE_NULL_Imp_A_No_NULL INT
		DECLARE @EMI_PRE_NULL_Imp_C_No_NULL INT
		
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, NULL, @formulaImp, @abono, @validaSaldo_No, NULL, @EMI_PRE_NULL_Imp_A_No_NULL OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, NULL, @formulaImp, @cargo, @validaSaldo_No, NULL, @EMI_PRE_NULL_Imp_C_No_NULL OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_NULL_Imp_A_No_NULL', @EMI_PRE_NULL_Imp_A_No_NULL
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_NULL_Imp_C_No_NULL', @EMI_PRE_NULL_Imp_C_No_NULL

		DECLARE @EMI_PRE_NULL_ImpRetiroTRXCom_A_No_NULL INT
		DECLARE @EMI_PRE_NULL_ImpRetiroTRXCom_C_No_NULL INT
		
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, NULL, @formulaImpRetiroTRXComision, @abono, @validaSaldo_No, NULL, @EMI_PRE_NULL_ImpRetiroTRXCom_A_No_NULL OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, NULL, @formulaImp, @cargo, @validaSaldo_No, NULL, @EMI_PRE_NULL_ImpRetiroTRXCom_C_No_NULL OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_NULL_ImpRetiroTRXCom_A_No_NULL', @EMI_PRE_NULL_ImpRetiroTRXCom_A_No_NULL
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_NULL_ImpRetiroTRXCom_C_No_NULL', @EMI_PRE_NULL_ImpRetiroTRXCom_C_No_NULL

		DECLARE @EMI_PRE_NULL_T_Imp_A_No_NULL INT
		DECLARE @EMI_PRE_NULL_T_Imp_C_No_NULL INT
		
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, NULL, @formulaImp, @abono, @validaSaldo_No, NULL, @EMI_PRE_NULL_T_Imp_A_No_NULL OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, NULL, @formulaImp, @cargo, @validaSaldo_No, NULL, @EMI_PRE_NULL_T_Imp_C_No_NULL OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_NULL_T_Imp_A_No_NULL', @EMI_PRE_NULL_T_Imp_A_No_NULL
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_NULL_T_Imp_C_No_NULL', @EMI_PRE_NULL_T_Imp_C_No_NULL

		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		--SCRIPTS CONTABLES COMPENSACIÓN
		DECLARE @BAN_BAN_T_Imp_A_No_No INT
		DECLARE @BAN_BAN_T_Imp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaBAN, @idTipoCuentaBAN, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @BAN_BAN_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaBAN, @idTipoCuentaBAN, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @BAN_BAN_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@BAN_BAN_T_Imp_A_No_No', @BAN_BAN_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@BAN_BAN_T_Imp_C_No_No', @BAN_BAN_T_Imp_C_No_No

		DECLARE @CCH_AUT_T_Imp_A_No_No INT
		DECLARE @CCH_AUT_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_Imp_A_No_No', @CCH_AUT_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_Imp_C_No_No', @CCH_AUT_T_Imp_C_No_No

		--Se agregaron scripts contables para validar el saldo en @formulaImp para colectiva tipo CuentaHabiente CCH
		--DECLARE @CCH_AUT_T_Imp_A_Si_No INT
		DECLARE @CCH_AUT_T_Imp_C_Si_No INT
	
		--EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_Si, @validaEstatusCuenta_No, @CCH_AUT_T_Imp_A_Si_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_Si, @validaEstatusCuenta_No, @CCH_AUT_T_Imp_C_Si_No OUTPUT
	
		--EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_Imp_A_Si_No', @CCH_AUT_T_Imp_A_Si_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_Imp_C_Si_No', @CCH_AUT_T_Imp_C_Si_No
	
	
		DECLARE @CCH_AUT_T_ImpComision_A_No_No INT
		DECLARE @CCH_AUT_T_ImpComision_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComision, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpComision_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComision, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpComision_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpComision_A_No_No', @CCH_AUT_T_ImpComision_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpComision_C_No_No', @CCH_AUT_T_ImpComision_C_No_No
	
		DECLARE @CCH_AUT_T_ImpComisionIVA_A_No_No INT
		DECLARE @CCH_AUT_T_ImpComisionIVA_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComisionIva, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpComisionIVA_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComisionIva, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpComisionIVA_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpComisionIVA_A_No_No', @CCH_AUT_T_ImpComisionIVA_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpComisionIVA_C_No_No', @CCH_AUT_T_ImpComisionIVA_C_No_No
	
		DECLARE @CCH_AUT_T_ImpComp_A_No_No INT
		DECLARE @CCH_AUT_T_ImpComp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpComp_A_No_No', @CCH_AUT_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpComp_C_No_No', @CCH_AUT_T_ImpComp_C_No_No
	
		DECLARE @CCH_AUT_T_ImpCompMarkUp_A_No_No INT
		DECLARE @CCH_AUT_T_ImpCompMarkUp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpCompMarkUp_A_No_No', @CCH_AUT_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpCompMarkUp_C_No_No', @CCH_AUT_T_ImpCompMarkUp_C_No_No
	
		DECLARE @CCH_AUT_T_ImpCompMarkUpPostDev_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUpPostDev, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpCompMarkUpPostDev_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpCompMarkUpPostDev_C_No_No', @CCH_AUT_T_ImpCompMarkUpPostDev_C_No_No
	
		DECLARE @CCH_AUT_T_ImpCompOriginal_A_No_No INT
		DECLARE @CCH_AUT_T_ImpCompOriginal_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompOriginal, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpCompOriginal_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompOriginal, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpCompOriginal_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpCompOriginal_A_No_No', @CCH_AUT_T_ImpCompOriginal_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpCompOriginal_C_No_No', @CCH_AUT_T_ImpCompOriginal_C_No_No
	
		DECLARE @CCH_AUT_T_ImpCompOriginalRetiro_A_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompOriginalRetiro, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpCompOriginalRetiro_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpCompOriginalRetiro_A_No_No', @CCH_AUT_T_ImpCompOriginalRetiro_A_No_No
	
		DECLARE @CCH_AUT_T_ImpRetiro_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpRetiro, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpRetiro_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpRetiro_C_No_No', @CCH_AUT_T_ImpRetiro_C_No_No

		--Se agrega Script Contable para validar saldo en @formulaImpRetiro para Colectiva Tipo CuentaHabiente CCH
		DECLARE @CCH_AUT_T_ImpRetiro_C_Si_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpRetiro, @cargo, @validaSaldo_Si, @validaEstatusCuenta_No, @CCH_AUT_T_ImpRetiro_C_Si_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpRetiro_C_Si_No', @CCH_AUT_T_ImpRetiro_C_Si_No
	
		DECLARE @CCH_AUT_T_ImpSpei_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpSpei, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_AUT_T_ImpSpei_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpSpei_C_No_No', @CCH_AUT_T_ImpSpei_C_No_No

		-- Se agrega Script Contable para validar saldo en @formulaImpSpei para Colectiva Tipo CuentaHabiente CCH
		DECLARE @CCH_AUT_T_ImpSpei_C_Si_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpSpei, @cargo, @validaSaldo_Si, @validaEstatusCuenta_No, @CCH_AUT_T_ImpSpei_C_Si_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_AUT_T_ImpSpei_C_Si_No', @CCH_AUT_T_ImpSpei_C_Si_No
	
		DECLARE @CCH_CMP_T_Imp_A_No_No INT
		DECLARE @CCH_CMP_T_Imp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_Imp_A_No_No', @CCH_CMP_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_Imp_C_No_No', @CCH_CMP_T_Imp_C_No_No
	
		DECLARE @CCH_CMP_T_ImpComision_A_No_No INT
		DECLARE @CCH_CMP_T_ImpComision_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpComision, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpComision_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpComision, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpComision_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpComision_A_No_No', @CCH_CMP_T_ImpComision_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpComision_C_No_No', @CCH_CMP_T_ImpComision_C_No_No
	
		DECLARE @CCH_CMP_T_ImpComisionIVA_A_No_No INT
		DECLARE @CCH_CMP_T_ImpComisionIVA_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpComisionIva, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpComisionIVA_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpComisionIva, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpComisionIVA_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpComisionIVA_A_No_No', @CCH_CMP_T_ImpComisionIVA_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpComisionIVA_C_No_No', @CCH_CMP_T_ImpComisionIVA_C_No_No
	
		DECLARE @CCH_CMP_T_ImpComp_A_No_No INT
		DECLARE @CCH_CMP_T_ImpComp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpComp_A_No_No', @CCH_CMP_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpComp_C_No_No', @CCH_CMP_T_ImpComp_C_No_No
	
		DECLARE @CCH_CMP_T_ImpCompMarkUp_A_No_No INT
		DECLARE @CCH_CMP_T_ImpCompMarkUp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpCompMarkUp_A_No_No', @CCH_CMP_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpCompMarkUp_C_No_No', @CCH_CMP_T_ImpCompMarkUp_C_No_No
	
		DECLARE @CCH_CMP_T_ImpCompMarkUpPostDev_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCMP, @idClaveAplicacionToday, @formulaImpCompMarkUpPostDev, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CMP_T_ImpCompMarkUpPostDev_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CMP_T_ImpCompMarkUpPostDev_C_No_No', @CCH_CMP_T_ImpCompMarkUpPostDev_C_No_No
	
		DECLARE @CCH_CXP_T_Imp_A_No_No INT
		DECLARE @CCH_CXP_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_Imp_A_No_No', @CCH_CXP_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_Imp_C_No_No', @CCH_CXP_T_Imp_C_No_No
	
		DECLARE @CCH_CXP_T_ImpComision_A_No_No INT
		DECLARE @CCH_CXP_T_ImpComision_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComision, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpComision_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComision, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpComision_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpComision_A_No_No', @CCH_CXP_T_ImpComision_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpComision_C_No_No', @CCH_CXP_T_ImpComision_C_No_No
	
		DECLARE @CCH_CXP_T_ImpComisionIVA_A_No_No INT
		DECLARE @CCH_CXP_T_ImpComisionIVA_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComisionIva, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpComisionIVA_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComisionIva, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpComisionIVA_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpComisionIVA_A_No_No', @CCH_CXP_T_ImpComisionIVA_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpComisionIVA_C_No_No', @CCH_CXP_T_ImpComisionIVA_C_No_No
	
		DECLARE @CCH_CXP_T_ImpComp_A_No_No INT
		DECLARE @CCH_CXP_T_ImpComp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpComp_A_No_No', @CCH_CXP_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpComp_C_No_No', @CCH_CXP_T_ImpComp_C_No_No
	
		DECLARE @CCH_CXP_T_ImpCompMarkUp_A_No_No INT
		DECLARE @CCH_CXP_T_ImpCompMarkUp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpCompMarkUp_A_No_No', @CCH_CXP_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpCompMarkUp_C_No_No', @CCH_CXP_T_ImpCompMarkUp_C_No_No
	
		DECLARE @CCH_CXP_T_ImpCompMarkUpPostDev_A_No_No INT
			
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUpPostDev, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_CXP_T_ImpCompMarkUpPostDev_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_CXP_T_ImpCompMarkUpPostDev_A_No_No', @CCH_CXP_T_ImpCompMarkUpPostDev_A_No_No
	
		DECLARE @CCH_LCR_T_Imp_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaLCR, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_LCR_T_Imp_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_LCR_T_Imp_A_No_No', @CCH_LCR_T_Imp_A_No_No
	
		DECLARE @CCH_LCR_T_ImpLimCredito_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaLCR, @idClaveAplicacionToday, @formulaImpLimCredito, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_LCR_T_ImpLimCredito_C_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@CCH_LCR_T_ImpLimCredito_C_No_No', @CCH_LCR_T_ImpLimCredito_C_No_No

		DECLARE @CCH_SBC_T_ImpCompOriginal_A_No_No INT
		DECLARE @CCH_SBC_T_ImpCompOriginal_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaSBC, @idClaveAplicacionToday, @formulaImpCompOriginal, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_SBC_T_ImpCompOriginal_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaCCH, @idTipoCuentaSBC, @idClaveAplicacionToday, @formulaImpCompOriginal, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @CCH_SBC_T_ImpCompOriginal_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_SBC_T_ImpCompOriginal_A_No_No', @CCH_SBC_T_ImpCompOriginal_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@CCH_SBC_T_ImpCompOriginal_C_No_No', @CCH_SBC_T_ImpCompOriginal_C_No_No
	
		DECLARE @EMI_CRS_T_ImpComp_A_No_No INT
		DECLARE @EMI_CRS_T_ImpComp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaCRS, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_CRS_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaCRS, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_CRS_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_CRS_T_ImpComp_A_No_No', @EMI_CRS_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_CRS_T_ImpComp_C_No_No', @EMI_CRS_T_ImpComp_C_No_No
	
		DECLARE @EMI_CRS_T_ImpPostDev_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaCRS, @idClaveAplicacionToday, @formulaImpPostDev, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_CRS_T_ImpPostDev_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_CRS_T_ImpPostDev_C_No_No', @EMI_CRS_T_ImpPostDev_C_No_No
	
		DECLARE @EMI_FEE_T_ImpComp_A_No_No INT
		DECLARE @EMI_FEE_T_ImpComp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaFEE, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_FEE_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaFEE, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_FEE_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_FEE_T_ImpComp_A_No_No', @EMI_FEE_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_FEE_T_ImpComp_C_No_No', @EMI_FEE_T_ImpComp_C_No_No
	
		DECLARE @EMI_PRE_T_Imp_A_No_No INT
		DECLARE @EMI_PRE_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_PRE_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_PRE_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_T_Imp_A_No_No', @EMI_PRE_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_T_Imp_C_No_No', @EMI_PRE_T_Imp_C_No_No
	
		DECLARE @EMI_PRE_T_ImpCompOriginal_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpCompOriginal, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_PRE_T_ImpCompOriginal_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_T_ImpCompOriginal_C_No_No', @EMI_PRE_T_ImpCompOriginal_C_No_No
	
		DECLARE @EMI_PRE_T_ImpCompOriginalRetiro_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpCompOriginalRetiro, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_PRE_T_ImpCompOriginalRetiro_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_T_ImpCompOriginalRetiro_C_No_No', @EMI_PRE_T_ImpCompOriginalRetiro_C_No_No
	
		DECLARE @EMI_PRE_T_ImpRetiro_A_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpRetiro, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_PRE_T_ImpRetiro_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_PRE_T_ImpRetiro_A_No_No', @EMI_PRE_T_ImpRetiro_A_No_No
	
		DECLARE @EMI_TXA_T_ImpCompMarkUp_A_No_No INT
		DECLARE @EMI_TXA_T_ImpCompMarkUp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_TXA_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_TXA_T_ImpCompMarkUp_A_No_No', @EMI_TXA_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_TXA_T_ImpCompMarkUp_C_No_No', @EMI_TXA_T_ImpCompMarkUp_C_No_No

		DECLARE @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No INT
		DECLARE @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaCINT, @idClaveAplicacionToday, @formulaCuotaIntercambioEmisor, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaEMI, @idTipoCuentaCINT, @idClaveAplicacionToday, @formulaCuotaIntercambioEmisor, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_CINT_T_CuotaIntercambioEmisor_A_No_No', @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@EMI_CINT_T_CuotaIntercambioEmisor_C_No_No', @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No

	    --Scripts Contables del Subemisor
		DECLARE @GCM_AUT_T_Imp_A_No_No INT
		DECLARE @GCM_AUT_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_Imp_A_No_No', @GCM_AUT_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_Imp_C_No_No', @GCM_AUT_T_Imp_C_No_No

		--Se agrega Script Contable para validar saldo en @formulaImp para colectiva tipo SubEmisor
		DECLARE @GCM_AUT_T_Imp_A_Si_No INT
		DECLARE @GCM_AUT_T_Imp_C_Si_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_Si, @validaEstatusCuenta_No, @GCM_AUT_T_Imp_A_Si_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_Si, @validaEstatusCuenta_No, @GCM_AUT_T_Imp_C_Si_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_Imp_A_Si_No', @GCM_AUT_T_Imp_A_Si_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_Imp_C_Si_No', @GCM_AUT_T_Imp_C_Si_No
	
		DECLARE @GCM_AUT_T_ImpComp_A_No_No INT
		DECLARE @GCM_AUT_T_ImpComp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpComp_A_No_No', @GCM_AUT_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpComp_C_No_No', @GCM_AUT_T_ImpComp_C_No_No
	
		DECLARE @GCM_AUT_T_ImpCompMarkUp_A_No_No INT
		DECLARE @GCM_AUT_T_ImpCompMarkUp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpCompMarkUp_A_No_No', @GCM_AUT_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpCompMarkUp_C_No_No', @GCM_AUT_T_ImpCompMarkUp_C_No_No
	
		DECLARE @GCM_AUT_T_ImpCompMarkUpPostDev_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUpPostDev, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_ImpCompMarkUpPostDev_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpCompMarkUpPostDev_C_No_No', @GCM_AUT_T_ImpCompMarkUpPostDev_C_No_No
	
		DECLARE @GCM_AUT_T_ImpCompOriginal_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompOriginal, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_ImpCompOriginal_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpCompOriginal_A_No_No', @GCM_AUT_T_ImpCompOriginal_A_No_No
	
		DECLARE @GCM_AUT_T_ImpCompOriginalRetiro_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompOriginalRetiro, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_ImpCompOriginalRetiro_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpCompOriginalRetiro_A_No_No', @GCM_AUT_T_ImpCompOriginalRetiro_A_No_No
	
		DECLARE @GCM_AUT_T_ImpRetiro_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaImpRetiro, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_AUT_T_ImpRetiro_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpRetiro_C_No_No', @GCM_AUT_T_ImpRetiro_C_No_No

		-- Se agrega Script Contable para validar saldo en @formulaImpRetiro para Colectiva Tipo SubEmisor GCM
		DECLARE @GCM_AUT_T_ImpRetiro_C_Si_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaImpRetiro, @cargo, @validaSaldo_Si, @validaEstatusCuenta_No, @GCM_AUT_T_ImpRetiro_C_Si_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_AUT_T_ImpRetiro_C_Si_No', @GCM_AUT_T_ImpRetiro_C_Si_No
	
		DECLARE @GCM_BAN_T_Imp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaBAN, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_BAN_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_BAN_T_Imp_C_No_No', @GCM_BAN_T_Imp_C_No_No
	
		DECLARE @GCM_COM_T_Imp_A_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCOM, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_COM_T_Imp_A_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@GCM_COM_T_Imp_A_No_No', @GCM_COM_T_Imp_A_No_No
	
		DECLARE @GCM_COM_T_ImpSpei_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCOM, @idClaveAplicacionToday, @formulaImpSpei, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_COM_T_ImpSpei_A_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@GCM_COM_T_ImpSpei_A_No_No', @GCM_COM_T_ImpSpei_A_No_No
	
		DECLARE @GCM_COM_T_ImpComision_A_No_No INT
		DECLARE @GCM_COM_T_ImpComision_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCOM, @idClaveAplicacionToday, @formulaImpComision, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_COM_T_ImpComision_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCOM, @idClaveAplicacionToday, @formulaImpComision, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_COM_T_ImpComision_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_COM_T_ImpComision_A_No_No', @GCM_COM_T_ImpComision_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_COM_T_ImpComision_C_No_No', @GCM_COM_T_ImpComision_C_No_No
	
		DECLARE @GCM_CRD_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CRD_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CRD_T_Imp_C_No_No', @GCM_CRD_T_Imp_C_No_No
	
		DECLARE @GCM_CRD_T_ImpLimCredito_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaImpLimCredito, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CRD_T_ImpLimCredito_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CRD_T_ImpLimCredito_A_No_No', @GCM_CRD_T_ImpLimCredito_A_No_No
	
		DECLARE @GCM_CXP_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CXP_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CXP_T_Imp_C_No_No', @GCM_CXP_T_Imp_C_No_No
	
		DECLARE @GCM_CXP_T_ImpComp_A_No_No INT
		DECLARE @GCM_CXP_T_ImpComp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CXP_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CXP_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CXP_T_ImpComp_A_No_No', @GCM_CXP_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CXP_T_ImpComp_C_No_No', @GCM_CXP_T_ImpComp_C_No_No
	
		DECLARE @GCM_CXP_T_ImpCompMarkUp_A_No_No INT
		DECLARE @GCM_CXP_T_ImpCompMarkUp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CXP_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CXP_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CXP_T_ImpCompMarkUp_A_No_No', @GCM_CXP_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CXP_T_ImpCompMarkUp_C_No_No', @GCM_CXP_T_ImpCompMarkUp_C_No_No
	
		DECLARE @GCM_CXP_T_ImpCompMarkUpPostDev_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUpPostDev, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CXP_T_ImpCompMarkUpPostDev_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CXP_T_ImpCompMarkUpPostDev_A_No_No', @GCM_CXP_T_ImpCompMarkUpPostDev_A_No_No
	
		DECLARE @GCM_INM_T_Imp_A_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaINM, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_INM_T_Imp_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_INM_T_Imp_A_No_No', @GCM_INM_T_Imp_A_No_No
	
		DECLARE @GCM_INO_T_Imp_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaINO, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_INO_T_Imp_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_INO_T_Imp_A_No_No', @GCM_INO_T_Imp_A_No_No
	
		DECLARE @GCM_INO_T_ImpBonificacion_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaINO, @idClaveAplicacionToday, @formulaImpBonificacion, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_INO_T_ImpBonificacion_C_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@GCM_INO_T_ImpBonificacion_C_No_No', @GCM_INO_T_ImpBonificacion_C_No_No
	
		DECLARE @GCM_IVA_T_Imp_A_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaIVA, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_IVA_T_Imp_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_IVA_T_Imp_A_No_No', @GCM_IVA_T_Imp_A_No_No
	
		DECLARE @GCM_IVA_T_ImpBonificacionIVA_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaIVA, @idClaveAplicacionToday, @formulaImpBonificacionIva, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_IVA_T_ImpBonificacionIVA_C_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@GCM_IVA_T_ImpBonificacionIVA_C_No_No', @GCM_IVA_T_ImpBonificacionIVA_C_No_No
	
		DECLARE @GCM_IVA_T_ImpComisionIVA_A_No_No INT
		DECLARE @GCM_IVA_T_ImpComisionIVA_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaIVA, @idClaveAplicacionToday, @formulaImpComisionIva, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_IVA_T_ImpComisionIVA_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaIVA, @idClaveAplicacionToday, @formulaImpComisionIva, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_IVA_T_ImpComisionIVA_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_IVA_T_ImpComisionIVA_A_No_No', @GCM_IVA_T_ImpComisionIVA_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_IVA_T_ImpComisionIVA_C_No_No', @GCM_IVA_T_ImpComisionIVA_C_No_No
	
		DECLARE @GCM_MUP_T_ImpMarkUp_A_No_No INT
		DECLARE @GCM_MUP_T_ImpMarkUp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaMUP, @idClaveAplicacionToday, @formulaImpMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_MUP_T_ImpMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaMUP, @idClaveAplicacionToday, @formulaImpMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_MUP_T_ImpMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_MUP_T_ImpMarkUp_A_No_No', @GCM_MUP_T_ImpMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_MUP_T_ImpMarkUp_C_No_No', @GCM_MUP_T_ImpMarkUp_C_No_No
	
		DECLARE @GCM_PRE_T_Imp_A_No_No INT
		DECLARE @GCM_PRE_T_Imp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_PRE_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_PRE_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_PRE_T_Imp_A_No_No', @GCM_PRE_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_PRE_T_Imp_C_No_No', @GCM_PRE_T_Imp_C_No_No
	
		DECLARE @GCM_PRE_T_ImpCompOriginalRetiro_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpCompOriginalRetiro, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_PRE_T_ImpCompOriginalRetiro_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_PRE_T_ImpCompOriginalRetiro_C_No_No', @GCM_PRE_T_ImpCompOriginalRetiro_C_No_No
	
		DECLARE @GCM_PRE_T_ImpRetiro_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpRetiro, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_PRE_T_ImpRetiro_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_PRE_T_ImpRetiro_A_No_No', @GCM_PRE_T_ImpRetiro_A_No_No
	
		DECLARE @GCM_TXA_T_Imp_A_No_No INT
		DECLARE @GCM_TXA_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_TXA_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_TXA_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_TXA_T_Imp_A_No_No', @GCM_TXA_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_TXA_T_Imp_C_No_No', @GCM_TXA_T_Imp_C_No_No
	
		DECLARE @GCM_TXA_T_ImpCompMarkUp_A_No_No INT
		DECLARE @GCM_TXA_T_ImpCompMarkUp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_TXA_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_TXA_T_ImpCompMarkUp_A_No_No', @GCM_TXA_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_TXA_T_ImpCompMarkUp_C_No_No', @GCM_TXA_T_ImpCompMarkUp_C_No_No

		DECLARE @GCM_PRE_T_ImpCompOriginal_A_No_No INT
		DECLARE @GCM_PRE_T_ImpCompOriginal_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpCompOriginal, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_PRE_T_ImpCompOriginal_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpCompOriginal, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_PRE_T_ImpCompOriginal_C_No_No OUTPUT
		
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_PRE_T_ImpCompOriginal_A_No_No', @GCM_PRE_T_ImpCompOriginal_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_PRE_T_ImpCompOriginal_C_No_No', @GCM_PRE_T_ImpCompOriginal_C_No_No

		DECLARE @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No INT
		DECLARE @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCINT, @idClaveAplicacionToday, @formulaCuotaIntercambioSubEmisor, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaGCM, @idTipoCuentaCINT, @idClaveAplicacionToday, @formulaCuotaIntercambioSubEmisor, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No', @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No', @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No

		--Scripts Contables de Padre Tarjeta
		DECLARE @PTH_AUT_T_Imp_A_No_No INT
		DECLARE @PTH_AUT_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_Imp_A_No_No', @PTH_AUT_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_Imp_C_No_No', @PTH_AUT_T_Imp_C_No_No

		--Se agrega Script Contable para validar saldo en @formulaImp para colectiva tipo SubEmisor
		DECLARE @PTH_AUT_T_Imp_A_Si_No INT
		DECLARE @PTH_AUT_T_Imp_C_Si_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_Si, @validaEstatusCuenta_No, @PTH_AUT_T_Imp_A_Si_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_Si, @validaEstatusCuenta_No, @PTH_AUT_T_Imp_C_Si_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_Imp_A_Si_No', @PTH_AUT_T_Imp_A_Si_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_Imp_C_Si_No', @PTH_AUT_T_Imp_C_Si_No
	
		DECLARE @PTH_AUT_T_ImpComp_A_No_No INT
		DECLARE @PTH_AUT_T_ImpComp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpComp_A_No_No', @PTH_AUT_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpComp_C_No_No', @PTH_AUT_T_ImpComp_C_No_No
	
		DECLARE @PTH_AUT_T_ImpCompMarkUp_A_No_No INT
		DECLARE @PTH_AUT_T_ImpCompMarkUp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpCompMarkUp_A_No_No', @PTH_AUT_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpCompMarkUp_C_No_No', @PTH_AUT_T_ImpCompMarkUp_C_No_No
	
		DECLARE @PTH_AUT_T_ImpCompMarkUpPostDev_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompMarkUpPostDev, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_ImpCompMarkUpPostDev_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpCompMarkUpPostDev_C_No_No', @PTH_AUT_T_ImpCompMarkUpPostDev_C_No_No
	
		DECLARE @PTH_AUT_T_ImpCompOriginal_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompOriginal, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_ImpCompOriginal_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpCompOriginal_A_No_No', @PTH_AUT_T_ImpCompOriginal_A_No_No
	
		DECLARE @PTH_AUT_T_ImpCompOriginalRetiro_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaAUT, @idClaveAplicacionToday, @formulaImpCompOriginalRetiro, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_ImpCompOriginalRetiro_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpCompOriginalRetiro_A_No_No', @PTH_AUT_T_ImpCompOriginalRetiro_A_No_No
	
		DECLARE @PTH_AUT_T_ImpRetiro_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaImpRetiro, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_AUT_T_ImpRetiro_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpRetiro_C_No_No', @PTH_AUT_T_ImpRetiro_C_No_No

		-- Se agrega Script Contable para validar saldo en @formulaImpRetiro para Colectiva Tipo SubEmisor PTH
		DECLARE @PTH_AUT_T_ImpRetiro_C_Si_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaImpRetiro, @cargo, @validaSaldo_Si, @validaEstatusCuenta_No, @PTH_AUT_T_ImpRetiro_C_Si_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_AUT_T_ImpRetiro_C_Si_No', @PTH_AUT_T_ImpRetiro_C_Si_No
	
		DECLARE @PTH_BAN_T_Imp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaBAN, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_BAN_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_BAN_T_Imp_C_No_No', @PTH_BAN_T_Imp_C_No_No
	
		DECLARE @PTH_COM_T_Imp_A_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCOM, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_COM_T_Imp_A_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@PTH_COM_T_Imp_A_No_No', @PTH_COM_T_Imp_A_No_No
	
		DECLARE @PTH_COM_T_ImpSpei_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCOM, @idClaveAplicacionToday, @formulaImpSpei, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_COM_T_ImpSpei_A_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@PTH_COM_T_ImpSpei_A_No_No', @PTH_COM_T_ImpSpei_A_No_No
	
		DECLARE @PTH_COM_T_ImpComision_A_No_No INT
		DECLARE @PTH_COM_T_ImpComision_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCOM, @idClaveAplicacionToday, @formulaImpComision, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_COM_T_ImpComision_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCOM, @idClaveAplicacionToday, @formulaImpComision, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_COM_T_ImpComision_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_COM_T_ImpComision_A_No_No', @PTH_COM_T_ImpComision_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_COM_T_ImpComision_C_No_No', @PTH_COM_T_ImpComision_C_No_No
	
		DECLARE @PTH_CRD_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_CRD_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_CRD_T_Imp_C_No_No', @PTH_CRD_T_Imp_C_No_No
	
		DECLARE @PTH_CRD_T_ImpLimCredito_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCRD, @idClaveAplicacionToday, @formulaImpLimCredito, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_CRD_T_ImpLimCredito_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_CRD_T_ImpLimCredito_A_No_No', @PTH_CRD_T_ImpLimCredito_A_No_No
	
		DECLARE @PTH_CXP_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_CXP_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_CXP_T_Imp_C_No_No', @PTH_CXP_T_Imp_C_No_No
	
		DECLARE @PTH_CXP_T_ImpComp_A_No_No INT
		DECLARE @PTH_CXP_T_ImpComp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_CXP_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_CXP_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_CXP_T_ImpComp_A_No_No', @PTH_CXP_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_CXP_T_ImpComp_C_No_No', @PTH_CXP_T_ImpComp_C_No_No
	
		DECLARE @PTH_CXP_T_ImpCompMarkUp_A_No_No INT
		DECLARE @PTH_CXP_T_ImpCompMarkUp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_CXP_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_CXP_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_CXP_T_ImpCompMarkUp_A_No_No', @PTH_CXP_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_CXP_T_ImpCompMarkUp_C_No_No', @PTH_CXP_T_ImpCompMarkUp_C_No_No
	
		DECLARE @PTH_CXP_T_ImpCompMarkUpPostDev_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpCompMarkUpPostDev, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_CXP_T_ImpCompMarkUpPostDev_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_CXP_T_ImpCompMarkUpPostDev_A_No_No', @PTH_CXP_T_ImpCompMarkUpPostDev_A_No_No
	
		DECLARE @PTH_INM_T_Imp_A_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaINM, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_INM_T_Imp_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_INM_T_Imp_A_No_No', @PTH_INM_T_Imp_A_No_No
	
		DECLARE @PTH_INO_T_Imp_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaINO, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_INO_T_Imp_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_INO_T_Imp_A_No_No', @PTH_INO_T_Imp_A_No_No
	
		DECLARE @PTH_INO_T_ImpBonificacion_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaINO, @idClaveAplicacionToday, @formulaImpBonificacion, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_INO_T_ImpBonificacion_C_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@PTH_INO_T_ImpBonificacion_C_No_No', @PTH_INO_T_ImpBonificacion_C_No_No
	
		DECLARE @PTH_IVA_T_Imp_A_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaIVA, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_IVA_T_Imp_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_IVA_T_Imp_A_No_No', @PTH_IVA_T_Imp_A_No_No
	
		DECLARE @PTH_IVA_T_ImpBonificacionIVA_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaIVA, @idClaveAplicacionToday, @formulaImpBonificacionIva, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_IVA_T_ImpBonificacionIVA_C_No_No OUTPUT

		EXEC ProcMan_Comp_GetScriptInfo '@PTH_IVA_T_ImpBonificacionIVA_C_No_No', @PTH_IVA_T_ImpBonificacionIVA_C_No_No
	
		DECLARE @PTH_IVA_T_ImpComisionIVA_A_No_No INT
		DECLARE @PTH_IVA_T_ImpComisionIVA_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaIVA, @idClaveAplicacionToday, @formulaImpComisionIva, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_IVA_T_ImpComisionIVA_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaIVA, @idClaveAplicacionToday, @formulaImpComisionIva, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_IVA_T_ImpComisionIVA_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_IVA_T_ImpComisionIVA_A_No_No', @PTH_IVA_T_ImpComisionIVA_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_IVA_T_ImpComisionIVA_C_No_No', @PTH_IVA_T_ImpComisionIVA_C_No_No
	
		DECLARE @PTH_MUP_T_ImpMarkUp_A_No_No INT
		DECLARE @PTH_MUP_T_ImpMarkUp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaMUP, @idClaveAplicacionToday, @formulaImpMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_MUP_T_ImpMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaMUP, @idClaveAplicacionToday, @formulaImpMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_MUP_T_ImpMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_MUP_T_ImpMarkUp_A_No_No', @PTH_MUP_T_ImpMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_MUP_T_ImpMarkUp_C_No_No', @PTH_MUP_T_ImpMarkUp_C_No_No
	
		DECLARE @PTH_PRE_T_Imp_A_No_No INT
		DECLARE @PTH_PRE_T_Imp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_PRE_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_PRE_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_PRE_T_Imp_A_No_No', @PTH_PRE_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_PRE_T_Imp_C_No_No', @PTH_PRE_T_Imp_C_No_No
	
		DECLARE @PTH_PRE_T_ImpCompOriginal_A_No_No INT
		DECLARE @PTH_PRE_T_ImpCompOriginal_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpCompOriginal, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_PRE_T_ImpCompOriginal_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpCompOriginal, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_PRE_T_ImpCompOriginal_C_No_No OUTPUT
		
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_PRE_T_ImpCompOriginal_A_No_No', @PTH_PRE_T_ImpCompOriginal_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_PRE_T_ImpCompOriginal_C_No_No', @PTH_PRE_T_ImpCompOriginal_C_No_No
	
		DECLARE @PTH_PRE_T_ImpCompOriginalRetiro_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpCompOriginalRetiro, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_PRE_T_ImpCompOriginalRetiro_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_PRE_T_ImpCompOriginalRetiro_C_No_No', @PTH_PRE_T_ImpCompOriginalRetiro_C_No_No
	
		DECLARE @PTH_PRE_T_ImpRetiro_A_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaPRE, @idClaveAplicacionToday, @formulaImpRetiro, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_PRE_T_ImpRetiro_A_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_PRE_T_ImpRetiro_A_No_No', @PTH_PRE_T_ImpRetiro_A_No_No
	
		DECLARE @PTH_TXA_T_Imp_A_No_No INT
		DECLARE @PTH_TXA_T_Imp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_TXA_T_Imp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_TXA_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_TXA_T_Imp_A_No_No', @PTH_TXA_T_Imp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_TXA_T_Imp_C_No_No', @PTH_TXA_T_Imp_C_No_No
	
		DECLARE @PTH_TXA_T_ImpCompMarkUp_A_No_No INT
		DECLARE @PTH_TXA_T_ImpCompMarkUp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImpCompMarkUp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_TXA_T_ImpCompMarkUp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaPTH, @idTipoCuentaTXA, @idClaveAplicacionToday, @formulaImpCompMarkUp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @PTH_TXA_T_ImpCompMarkUp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_TXA_T_ImpCompMarkUp_A_No_No', @PTH_TXA_T_ImpCompMarkUp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@PTH_TXA_T_ImpCompMarkUp_C_No_No', @PTH_TXA_T_ImpCompMarkUp_C_No_No
	
		DECLARE @SWT_CXP_T_Imp_C_No_No INT

		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @SWT_CXP_T_Imp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@SWT_CXP_T_Imp_C_No_No', @SWT_CXP_T_Imp_C_No_No
	
		DECLARE @SWT_CXP_T_ImpComp_A_No_No INT 
		DECLARE @SWT_CXP_T_ImpComp_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComp, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @SWT_CXP_T_ImpComp_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaCXP, @idClaveAplicacionToday, @formulaImpComp, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @SWT_CXP_T_ImpComp_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@SWT_CXP_T_ImpComp_A_No_No', @SWT_CXP_T_ImpComp_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@SWT_CXP_T_ImpComp_C_No_No', @SWT_CXP_T_ImpComp_C_No_No

		DECLARE @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No INT
		DECLARE @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No INT
	
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaCINT, @idClaveAplicacionToday, @formulaCuotaIntercambioSwitch, @abono, @validaSaldo_No, @validaEstatusCuenta_No, @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No OUTPUT
		EXEC ProcMan_Comp_GetIdScript @idTipoColectivaSWT, @idTipoCuentaCINT, @idClaveAplicacionToday, @formulaCuotaIntercambioSwitch, @cargo, @validaSaldo_No, @validaEstatusCuenta_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No OUTPUT
	
		EXEC ProcMan_Comp_GetScriptInfo '@SWT_CINT_T_CuotaIntercambioSwitch_A_No_No', @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No
		EXEC ProcMan_Comp_GetScriptInfo '@SWT_CINT_T_CuotaIntercambioSwitch_C_No_No', @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No

		
		DECLARE @esAbono BIT
		DECLARE @formula VARCHAR(200)
		DECLARE @idEvento INT
		DECLARE @idTipoColectiva INT
		DECLARE @idTipoCuenta INT

		--CONSULTA PREVIA
		---------------------------------COMPRA-----------------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02004100MXN484' --COMPRA SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02004103MXN484' --COMPRA SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02002700MXN484' --COMPRA SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02002703MXN484' --COMPRA SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02001700MXN484' --COMPRA SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02001703MXN484' --COMPRA SE STANDIN (CONTACTLESS)
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02001600MXN484' --COMPRA SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02001603MXN484' --COMPRA SE STANDIN (E-COMMERCE CON CVV2)
		--E-COMMERCE CON CVV DINÁMICO
		EXEC ProcMan_Comp_GetEventoScripts 'T02004000MXN484' --COMPRA SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02004003MXN484' --COMPRA SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		--FALLBACK
		EXEC ProcMan_Comp_GetEventoScripts 'T02005400MXN484' --COMPRA SE (FALLBACK)
		EXEC ProcMan_Comp_GetEventoScripts 'T02005403MXN484' --COMPRA SE STANDIN (FALLBACK)
		---------------------------------RETIRO-----------------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02014100MXN484' --RETIRO ATM SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02014103MXN484' --RETIRO ATM SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02012700MXN484' --RETIRO ATM SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02012703MXN484' --RETIRO ATM SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02011700MXN484' --RETIRO ATM SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02011703MXN484' --RETIRO ATM SE STANDIN (CONTACTLESS)
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02011600MXN484' --RETIRO EN ATM SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02011603MXN484' --RETIRO EN ATM SE STANDIN (E-COMMERCE CON CVV2)
		--E-COMMERCE CON CVV DINÁMICO
		--EXEC ProcMan_Comp_GetEventoScripts 'T02004000MXN484' --RETIRO EN ATM SE (E-COMMERCE CON CVV DINÁMICO)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02004003MXN484' --RETIRO EN ATM SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		--FALLBACK
		EXEC ProcMan_Comp_GetEventoScripts 'T02015400MXN484' --RETIRO EN ATM SE (FALLBACK)
		EXEC ProcMan_Comp_GetEventoScripts 'T02015403MXN484' --RETIRO EN ATM SE STANDIN (FALLBACK)
		----------------------------CONSULTA DE SALDO-----------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02304100MXN484' --CONSULTA DE SALDO EN ATM SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02304103MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02302700MXN484' --CONSULTA DE SALDO EN ATM SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02302703MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02301700MXN484' --CONSULTA DE SALDO EN ATM SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02301703MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (CONTACTLESS)
		----E-COMMERCE CON CVV2
		--EXEC ProcMan_Comp_GetEventoScripts 'T02301600MXN484' --CONSULTA DE SALDO EN ATM SE (E-COMMERCE CON CVV2)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02301603MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (E-COMMERCE CON CVV2)
		----E-COMMERCE CON CVV DINÁMICO
		--EXEC ProcMan_Comp_GetEventoScripts 'T02304000MXN484' --CONSULTA DE SALDO EN ATM SE (E-COMMERCE CON CVV DINÁMICO)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02304003MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------------- COMPRA CASHBACK-----------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02094100MXN484' -- COMPRA CASHBACK SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02094103MXN484' -- COMPRA CASHBACK SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02092700MXN484' -- COMPRA CASHBACK SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02092703MXN484' -- COMPRA CASHBACK SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02091700MXN484' -- COMPRA CASHBACK SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02091703MXN484' -- COMPRA CASHBACK SE STANDIN (CONTACTLESS)
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02091600MXN484' -- COMPRA CASHBACK SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02091603MXN484' -- COMPRA CASHBACK SE STANDIN (E-COMMERCE CON CVV2)
		--E-COMMERCE CON CVV DINÁMICO
		EXEC ProcMan_Comp_GetEventoScripts 'T02094000MXN484' -- COMPRA CASHBACK SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02094003MXN484' -- COMPRA CASHBACK SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------------- COMPRA CASHADVANCE-----------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02144100MXN484' -- COMPRA CASHADVANCE SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02144103MXN484' -- COMPRA CASHADVANCE SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02142700MXN484' -- COMPRA CASHADVANCE SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02142703MXN484' -- COMPRA CASHADVANCE SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02141700MXN484' -- COMPRA CASHADVANCE SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02141703MXN484' -- COMPRA CASHADVANCE SE STANDIN (CONTACTLESS)
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02141600MXN484' -- COMPRA CASHADVANCE SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02141603MXN484' -- COMPRA CASHADVANCE SE STANDIN (E-COMMERCE CON CVV2)
		--E-COMMERCE CON CVV DINÁMICO
		EXEC ProcMan_Comp_GetEventoScripts 'T02144000MXN484' -- COMPRA CASHADVANCE SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02144003MXN484' -- COMPRA CASHADVANCE SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------------- COMPRA MOTO-----------------------------------------
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02801600MXN484' -- COMPRA MOTO SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02801603MXN484' -- COMPRA MOTO SE STANDIN (E-COMMERCE CON CVV2)
		--E-COMMERCE CON CVV DINÁMICO
		EXEC ProcMan_Comp_GetEventoScripts 'T02804000MXN484' -- COMPRA MOTO SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02804003MXN484' -- COMPRA MOTO SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------------- VERIFICACIÓN DE CUENTA-----------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC4100MXN484' -- VERIFICACIÓN DE CUENTA SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC4103MXN484' -- VERIFICACIÓN DE CUENTA SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC2700MXN484' -- VERIFICACIÓN DE CUENTA SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC2703MXN484' -- VERIFICACIÓN DE CUENTA SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC1700MXN484' -- VERIFICACIÓN DE CUENTA SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC1703MXN484' -- VERIFICACIÓN DE CUENTA SE STANDIN (CONTACTLESS)
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC1600MXN484' -- VERIFICACIÓN DE CUENTA SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC1603MXN484' -- VERIFICACIÓN DE CUENTA SE STANDIN (E-COMMERCE CON CVV2)
		--E-COMMERCE CON CVV DINÁMICO
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC4000MXN484' -- VERIFICACIÓN DE CUENTA SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC4003MXN484' -- VERIFICACIÓN DE CUENTA SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		----------------------------DEVOLUCIÓN-----------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02204100MXN484' --DEVOLUCIÓN SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02204103MXN484' --DEVOLUCIÓN SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02202700MXN484' --DEVOLUCIÓN SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02202703MXN484' --DEVOLUCIÓN SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02201700MXN484' --DEVOLUCIÓN SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02201703MXN484' --DEVOLUCIÓN SE STANDIN (CONTACTLESS)
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02201600MXN484' --DEVOLUCIÓN SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02201603MXN484' --DEVOLUCIÓN SE STANDIN (E-COMMERCE CON CVV2)
		----E-COMMERCE CON CVV DINÁMICO
		EXEC ProcMan_Comp_GetEventoScripts 'T02204000MXN484' --DEVOLUCIÓN SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02204003MXN484' --DEVOLUCIÓN SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		----------------------------CANCELACIÓN-----------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA4100MXN484' --CANCELACIÓN SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA4103MXN484' --CANCELACIÓN SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA2700MXN484' --CANCELACIÓN SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA2703MXN484' --CANCELACIÓN SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA1700MXN484' --CANCELACIÓN SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA1703MXN484' --CANCELACIÓN SE STANDIN (CONTACTLESS)
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA1600MXN484' --CANCELACIÓN SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA1603MXN484' --CANCELACIÓN SE STANDIN (E-COMMERCE CON CVV2)
		--E-COMMERCE CON CVV DINÁMICO
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA4000MXN484' --CANCELACIÓN SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA4003MXN484' --CANCELACIÓN SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		----------------------------MONEY SEND-----------------------------------------
		--CHIP
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS4100MXN484' --MONEY SEND SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS4103MXN484' --MONEY SEND SE STANDIN (CHIP)
		--BANDA
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS2700MXN484' --MONEY SEND SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS2703MXN484' --MONEY SEND SE STANDIN (BANDA)
		--CONTACTLESS
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS1700MXN484' --MONEY SEND SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS1703MXN484' --MONEY SEND SE STANDIN (CONTACTLESS)
		--E-COMMERCE CON CVV2
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS1600MXN484' --MONEY SEND SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS1603MXN484' --MONEY SEND SE STANDIN (E-COMMERCE CON CVV2)
		----E-COMMERCE CON CVV DINÁMICO
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS4000MXN484' --MONEY SEND SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS4003MXN484' --MONEY SEND SE STANDIN (E-COMMERCE CON CVV DINÁMICO)

		--====================================================================================================
		--Paso: 5.1
		--Nota: Generación o actualización de Eventos Manuales
		--====================================================================================================
		--EXEC ProcMan_Comp_GetIdEvento 'M00AC2000MXN484', 'ACLARACIÓN EN PROCESO (ABONO)', @idTipoEventoManual, 'M00AC2000MXN484', 'OPERACIÓN EN ACLARACIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00AI0000MXN484', 'ACLARACIÓN IMPROCEDENTE', @idTipoEventoManual, 'M00AI0000MXN484', 'COMPRA (ACLARACIÓN IMPROCEDENTE)', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00AI1000MXN484', 'ACLARACIÓN IMPROCEDENTE (COMISIÓN)', @idTipoEventoManual, 'M00AI1000MXN484', 'COMISIÓN POR ACLARACIÓN IMPROCEDENTE', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00AI1100MXN484', 'ACLARACIÓN IMPROCEDENTE (IVA COMISIÓN)', @idTipoEventoManual, 'M00AI1100MXN484', 'IVA DE COMISIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00AP1800MXN484', 'ACLARACIÓN PROCEDENTE (PREVIAMENTE ABONADA)', @idTipoEventoManual, 'M00AP1800MXN484', 'N/A', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00AP1900MXN484', 'ACLARACIÓN PROCEDENTE (PREVIAMENTE NO ABONADA)', @idTipoEventoManual, 'M00AP1900MXN484', 'OPERACIÓN ACLARADA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'A00AN1000MXN484', 'ANUALIDAD (COMISIÓN)', @idTipoEventoAutomatico, 'A00AN1000MXN484', 'COMISIÓN ANUAL TITULAR', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'A00AN1100MXN484', 'ANUALIDAD (IVA COMISIÓN)', @idTipoEventoAutomatico, 'A00AN1100MXN484', 'IVA DE COMISIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'A00AT1000MXN484', 'ANUALIDAD TARJETAS ADICIONALES (COMISIÓN)', @idTipoEventoAutomatico, 'A00AT1000MXN484', 'COMISIÓN ANUAL TARJETAS ADICIONALES', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'A00AT1100MXN484', 'ANUALIDAD TARJETAS ADICIONALES (IVA COMISIÓN)', @idTipoEventoAutomatico, 'A00AT1100MXN484', 'IVA DE COMISIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'B00BI1200MXN484', 'BONIFICACIÓN DE INTERESES (INCLUYE IVA)', @idTipoEventoAutomatico, 'B00BI1200MXN484', 'BONIFICACIÓN DE INTERESES E IVA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'B00GC1000MXN484', 'GASTOS DE COBRANZA (COMISIÓN)', @idTipoEventoAutomatico, 'B00GC1000MXN484', 'GASTOS DE COBRANZA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'B00GC1100MXN484', 'GASTOS DE COBRANZA (IVA COMISIÓN)', @idTipoEventoAutomatico, 'B00GC1100MXN484', 'IVA DE GASTOS DE COBRANZA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'C00IM1000MXN484', 'INTERESES MORATORIOS (COMISIÓN)', @idTipoEventoAutomatico, 'C00IM1000MXN484', 'INTERESES MORATORIOS', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'C00IM1100MXN484', 'INTERESES MORATORIOS (IVA COMISIÓN)', @idTipoEventoAutomatico, 'C00IM1100MXN484', 'IVA DE INTERESES', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'C00IO1000MXN484', 'INTERESES ORDINARIOS (COMISIÓN)', @idTipoEventoAutomatico, 'C00IO1000MXN484', 'INTERESES ORDINARIOS', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'C00IO1100MXN484', 'INTERESES ORDINARIOS (IVA COMISIÓN)', @idTipoEventoAutomatico, 'C00IO1100MXN484', 'IVA DE INTERESES', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00LC2300MXN484', 'LÍMITE DE CRÉDITO (ASIGNACIÓN)', @idTipoEventoManual, 'M00LC2300MXN484', 'N/A', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00LQ2400MXN484', 'LIQUIDACIÓN (FONDEO DE SUBEMISOR A EMISOR)', @idTipoEventoManual, 'M00LQ2400MXN484', 'N/A', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00LQ2500MXN484', 'LIQUIDACIÓN (RETIRO DE EMISOR A SUBEMISOR)', @idTipoEventoManual, 'M00LQ2500MXN484', 'N/A', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'B00NP1000MXN484', 'NO PAGO (COMISIÓN)', @idTipoEventoAutomatico, 'B00NP1000MXN484', 'GASTOS DE COBRANZA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'B00NP1100MXN484', 'NO PAGO (IVA COMISIÓN)', @idTipoEventoAutomatico, 'B00NP1100MXN484', 'IVA DE GASTOS DE COBRANZA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00282600MXN484', 'PAGO/ABONO A TARJETA (RECIBIDO EN CUENTA BANCARIA DEL SUBEMISOR)', @idTipoEventoManual, 'M00282600MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'B00PT1000MXN484', 'PAGO TARDÍO (COMISIÓN)', @idTipoEventoAutomatico, 'B00PT1000MXN484', 'GASTOS DE COBRANZA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'B00PT1100MXN484', 'PAGO TARDÍO (IVA COMISIÓN)', @idTipoEventoAutomatico, 'B00PT1100MXN484', 'IVA DE GASTOS DE COBRANZA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00RN1000MXN484', 'RENOVACIÓN (COMISIÓN)', @idTipoEventoManual, 'M00RN1000MXN484', 'COMISIÓN POR RENOVACIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00RN1100MXN484', 'RENOVACIÓN (IVA COMISIÓN)', @idTipoEventoManual, 'M00RN1100MXN484', 'IVA DE COMISIÓN POR RENOVACIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00RP1000MXN484', 'REPOSICIÓN (COMISIÓN)', @idTipoEventoManual, 'M00RP1000MXN484', 'COMISIÓN POR REPOSICIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00RP1100MXN484', 'REPOSICIÓN (IVA COMISIÓN)', @idTipoEventoManual, 'M00RP1100MXN484', 'IVA DE COMISIÓN POR REPOSICIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00SI2100MXN484', 'SPEI IN (RECIBIDO POR EMISOR)', @idTipoEventoManual, 'M00SI2100MXN484', 'SPEI RECIBIDO', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00SI2200MXN484', 'SPEI OUT (OPERADO POR EMISOR)', @idTipoEventoManual, 'M00SI2200MXN484', 'SPEI REALIZADO', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'M00SO1000MXN484', 'SPEI OUT (COMISIÓN)', @idTipoEventoManual, 'M00SO1000MXN484', 'COMISIÓN POR SPEI', @idEvento OUTPUT
	
		--====================================================================================================
		--Paso: 5.2
		--Nota: Generación o actualización de Eventos Transaccionales
		--====================================================================================================
		---------------------------------COMRPA--------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02004100MXN484', 'COMPRA SE (CHIP)', @idTipoEventoTransaccional, 'T02004100MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02004103MXN484', 'COMPRA SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02004103MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02002700MXN484', 'COMPRA SE (BANDA)', @idTipoEventoTransaccional, 'T02002700MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02002703MXN484', 'COMPRA SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02002703MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02001700MXN484', 'COMPRA SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02001700MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02001703MXN484', 'COMPRA SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02001703MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02001600MXN484', 'COMPRA SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02001600MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02001603MXN484', 'COMPRA SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02001603MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02004000MXN484', 'COMPRA SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02004000MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02004003MXN484', 'COMPRA SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02004003MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02005400MXN484', 'COMPRA SE (FALLBACK)', @idTipoEventoTransaccional, 'T020054000MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02005403MXN484', 'COMPRA SE STANDIN (FALLBACK)', @idTipoEventoTransaccional, 'T020054003MXN484', 'COMPRA', @idEvento OUTPUT
		------------------------------------RETIRO-------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02014100MXN484', 'RETIRO EN ATM SE (CHIP)', @idTipoEventoTransaccional, 'T02014100MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02014103MXN484', 'RETIRO EN ATM SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02014103MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02012700MXN484', 'RETIRO EN ATM SE (BANDA)', @idTipoEventoTransaccional, 'T02012700MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02012703MXN484', 'RETIRO EN ATM SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02012703MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02011700MXN484', 'RETIRO EN ATM SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02011700MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02011703MXN484', 'RETIRO EN ATM SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02011703MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02011600MXN484', 'RETIRO EN ATM SE (TECLEADA CON CVV2)', @idTipoEventoTransaccional, 'T02011600MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02011603MXN484', 'RETIRO EN ATM SE STANDIN (TECLEADA CON CVV2)', @idTipoEventoTransaccional, 'T02011603MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T02014000MXN484', 'RETIRO EN ATM SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02014000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T02014003MXN484', 'RETIRO EN ATM SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02014003MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02015400MXN484', 'RETIRO EN ATM SE (FALLBACK)', @idTipoEventoTransaccional, 'T02015400MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02015403MXN484', 'RETIRO EN ATM SE STANDIN (FALLBACK)', @idTipoEventoTransaccional, 'T02015403MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		---------------------------------CONSULTA DE SALDO ------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02304100MXN484', 'CONSULTA DE SALDO EN ATM SE (CHIP)', @idTipoEventoTransaccional, 'T02304100MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02304103MXN484', 'CONSULTA DE SALDO EN ATM SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02304103MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02302700MXN484', 'CONSULTA DE SALDO EN ATM SE (BANDA)', @idTipoEventoTransaccional, 'T02302700MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02302703MXN484', 'CONSULTA DE SALDO EN ATM SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02302703MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02301700MXN484', 'CONSULTA DE SALDO EN ATM SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02301700MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02301703MXN484', 'CONSULTA DE SALDO EN ATM SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02301703MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T02301600MXN484', 'CONSULTA DE SALDO EN ATM SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02301600MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T02301603MXN484', 'CONSULTA DE SALDO EN ATM SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02301603MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T02304000MXN484', 'CONSULTA DE SALDO EN ATM SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02304000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T02304003MXN484', 'CONSULTA DE SALDO EN ATM SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02304003MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		---------------------------------COMPRA CASHBACK ------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02094100MXN484', 'COMPRA CASHBACK SE (CHIP)', @idTipoEventoTransaccional, 'T02094100MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02094103MXN484', 'COMPRA CASHBACK SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02094103MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02092700MXN484', 'COMPRA CASHBACK SE (BANDA)', @idTipoEventoTransaccional, 'T02092700MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02092703MXN484', 'COMPRA CASHBACK SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02092703MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02091700MXN484', 'COMPRA CASHBACK SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02091700MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02091703MXN484', 'COMPRA CASHBACK SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02091703MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02091600MXN484', 'COMPRA CASHBACK SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02091600MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02091603MXN484', 'COMPRA CASHBACK SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02091603MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02094000MXN484', 'COMPRA CASHBACK SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02094000MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02094003MXN484', 'COMPRA CASHBACK SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02094003MXN484', 'COMPRA', @idEvento OUTPUT
		---------------------------------COMPRA CASHADVANCE ------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02144100MXN484', 'COMPRA CASHADVANCE SE (CHIP)', @idTipoEventoTransaccional, 'T02144100MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02144103MXN484', 'COMPRA CASHADVANCE SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02144103MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02142700MXN484', 'COMPRA CASHADVANCE SE (BANDA)', @idTipoEventoTransaccional, 'T02142700MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02142703MXN484', 'COMPRA CASHADVANCE SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02142703MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02141700MXN484', 'COMPRA CASHADVANCE SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02141700MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02141703MXN484', 'COMPRA CASHADVANCE SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02141703MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02141600MXN484', 'COMPRA CASHADVANCE SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02141600MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02141603MXN484', 'COMPRA CASHADVANCE SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02141603MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02144000MXN484', 'COMPRA CASHADVANCE SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02144000MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02144003MXN484', 'COMPRA CASHADVANCE SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02144003MXN484', 'COMPRA', @idEvento OUTPUT
		---------------------------------COMPRA MOTO ------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02801600MXN484', 'COMPRA MOTO SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02801600MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02801603MXN484', 'COMPRA MOTO SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02801603MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02804000MXN484', 'COMPRA MOTO SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02804000MXN484', 'COMPRA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02804003MXN484', 'COMPRA MOTO SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02804003MXN484', 'COMPRA', @idEvento OUTPUT
		---------------------------------VERIFICACIÓN DE CUENTA ------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02VC4100MXN484', 'VERIFICACIÓN DE CUENTA SE (CHIP)', @idTipoEventoTransaccional, 'T02VC4100MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC4103MXN484', 'VERIFICACIÓN DE CUENTA SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02VC4103MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC2700MXN484', 'VERIFICACIÓN DE CUENTA SE (BANDA)', @idTipoEventoTransaccional, 'T02VC2700MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC2703MXN484', 'VERIFICACIÓN DE CUENTA SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02VC2703MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC1700MXN484', 'VERIFICACIÓN DE CUENTA SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02VC1700MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC1703MXN484', 'VERIFICACIÓN DE CUENTA SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02VC1703MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC1600MXN484', 'VERIFICACIÓN DE CUENTA SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02VC1600MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC1603MXN484', 'VERIFICACIÓN DE CUENTA SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02VC1603MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC4000MXN484', 'VERIFICACIÓN DE CUENTA SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02VC4000MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02VC4003MXN484', 'VERIFICACIÓN DE CUENTA SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02VC4003MXN484', 'VERIFICACIÓN DE CUENTA', @idEvento OUTPUT
		---------------------------------DEVOLUCIÓN -----------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02204100MXN484', 'DEVOLUCIÓN EN LÍNEA SE (CHIP)', @idTipoEventoTransaccional, 'T02204100MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02204103MXN484', 'DEVOLUCIÓN EN LÍNEA SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02204103MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02202700MXN484', 'DEVOLUCIÓN EN LÍNEA SE (BANDA)', @idTipoEventoTransaccional, 'T02202700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02202703MXN484', 'DEVOLUCIÓN EN LÍNEA SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02202703MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02201700MXN484', 'DEVOLUCIÓN EN LÍNEA SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02201700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02201703MXN484', 'DEVOLUCIÓN EN LÍNEA SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02201703MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02201600MXN484', 'DEVOLUCIÓN EN LÍNEA SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02201600MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02201603MXN484', 'DEVOLUCIÓN EN LÍNEA SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02201603MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02204000MXN484', 'DEVOLUCIÓN SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02204000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02204003MXN484', 'DEVOLUCIÓN SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02204003MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		---------------------------------CANCELACIÓN -----------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02DA4100MXN484', 'CANCELACIÓN SE (CHIP)', @idTipoEventoTransaccional, 'T02DA4100MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA4103MXN484', 'CANCELACIÓN SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02DA4103MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA2700MXN484', 'CANCELACIÓN SE (BANDA)', @idTipoEventoTransaccional, 'T02DA2700MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA2703MXN484', 'CANCELACIÓN SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02DA2703MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA1700MXN484', 'CANCELACIÓN SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02DA1700MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA1703MXN484', 'CANCELACIÓN SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02DA1703MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA1600MXN484', 'CANCELACIÓN SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02DA1600MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA1603MXN484', 'CANCELACIÓN SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02DA1603MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA4000MXN484', 'CANCELACIÓN SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02DA4000MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02DA4003MXN484', 'CANCELACIÓN SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02DA4003MXN484', 'CANCELACIÓN', @idEvento OUTPUT
		---------------------------------MONEY SEND -----------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_GetIdEvento 'T02MS4100MXN484', 'MONEY SEND SE (CHIP)', @idTipoEventoTransaccional, 'T02MS4100MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS4103MXN484', 'MONEY SEND SE STANDIN (CHIP)', @idTipoEventoTransaccional, 'T02MS4103MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS2700MXN484', 'MONEY SEND SE (BANDA)', @idTipoEventoTransaccional, 'T02MS2700MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS2703MXN484', 'MONEY SEND SE STANDIN (BANDA)', @idTipoEventoTransaccional, 'T02MS2703MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS1700MXN484', 'MONEY SEND SE (CONTACTLESS)', @idTipoEventoTransaccional, 'T02MS1700MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS1703MXN484', 'MONEY SEND SE STANDIN (CONTACTLESS)', @idTipoEventoTransaccional, 'T02MS1703MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS1600MXN484', 'MONEY SEND SE (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02MS1600MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS1603MXN484', 'MONEY SEND SE STANDIN (E-COMMERCE CON CVV2)', @idTipoEventoTransaccional, 'T02MS1603MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS4000MXN484', 'MONEY SEND SE (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02MS4000MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT
		EXEC ProcMan_Comp_GetIdEvento 'T02MS4003MXN484', 'MONEY SEND SE STANDIN (E-COMMERCE CON CVV DINÁMICO)', @idTipoEventoTransaccional, 'T02MS4003MXN484', 'ENVÍO DE DINERO', @idEvento OUTPUT

		--EXEC ProcMan_Comp_GetIdEvento 'T05001600MXN484', 'COMPRA TDC (E-COMMERCE)', @idTipoEventoAutomatico, 'T00001600MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T05001700MXN484', 'COMPRA TDC (CONTACTLESS)', @idTipoEventoAutomatico, 'T00001700MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T05010000MXN484', 'RETIRO EN ATM TDC', @idTipoEventoAutomatico, 'T00100000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T05300000MXN484', 'CONSULTA DE SALDO EN ATM TDC', @idTipoEventoAutomatico, 'T03000000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'T05201500MXN484', 'DEVOLUCIÓN TDC (EN LÍNEA)', @idTipoEventoAutomatico, 'T00201500MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT

		--EXEC ProcMan_Comp_GetIdEvento 'DBT0004', 'compra Ecommerce', @idTipoEventoAutomatico, 'T00000000MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'DBT0011', 'Compra POS Banda', @idTipoEventoAutomatico, 'T00001600MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'DBT0001', 'Compra POS Chip', @idTipoEventoAutomatico, 'T00001700MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'DBT0012', 'Compra POS Contactless', @idTipoEventoAutomatico, 'T00100000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'DBT0003', 'Consulta Saldo', @idTipoEventoAutomatico, 'T03000000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'DBT0013', 'Devolucion Salvo Buen Cobro', @idTipoEventoAutomatico, 'T00201500MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'DBTSTAND0013', 'Devolucion Standin Salvo Buen Cobro', @idTipoEventoAutomatico, 'T00000000MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'DBT0008', 'Envio de Dinero-Abono Salvo Buen Cobro', @idTipoEventoAutomatico, 'T00001600MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'DBT0002', 'Retiro ATM', @idTipoEventoAutomatico, 'T00001700MXN484', 'COMPRA', @idEvento OUTPUT

		--====================================================================================================
		--Paso: 5.3
		--Nota: Generación o actualización de Eventos de Compensación
		--====================================================================================================
		--EXEC ProcMan_Comp_GetIdEvento 'E00190001MXN484', 'COMP - CARGO DE MISCELÁNEO', @idTipoEventoAutomatico, 'E00190001MXN484', 'CARGO DE MISCELÁNEO', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E00290001MXN484', 'COMP - ABONO DE MISCELÁNEO', @idTipoEventoAutomatico, 'E00290001MXN484', 'ABONO DE MISCELÁNEO', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11000000MXN484', 'COMP - COMPRA/CARGO TDC', @idTipoEventoAutomatico, 'E00000000MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11000100MXN484', 'COMP - COMPRA/CARGO TDC (SIN OPERACIÓN)', @idTipoEventoAutomatico, 'E00000100MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11000200MXN484', 'COMP - COMPRA/CARGO TDC (DUPLICADA)', @idTipoEventoAutomatico, 'E00000000MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11000300MXN484', 'COMP - COMPRA/CARGO TDC (POST DEVUELTA)', @idTipoEventoAutomatico, 'E00000000MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11000400MXN484', 'COMP - COMPRA/CARGO TDC (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoAutomatico, 'E00200000MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11000500MXN484', 'COMP - COMPRA/CARGO TDC (REVERSADA PRESENTADA)', @idTipoEventoAutomatico, 'E00000000MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11000600MXN484', 'COMP - COMPRA/CARGO TDC (A FAVOR ACLARADA)', @idTipoEventoAutomatico, 'E00200000MXN484', 'COMPRA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11010000MXN484', 'COMP - RETIRO EN ATM TDC', @idTipoEventoAutomatico, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11010100MXN484', 'COMP - RETIRO EN ATM TDC (SIN OPERACIÓN)', @idTipoEventoAutomatico, 'E00010100MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11010200MXN484', 'COMP - RETIRO EN ATM TDC (DUPLICADA)', @idTipoEventoAutomatico, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11010300MXN484', 'COMP - RETIRO EN ATM TDC (POST DEVUELTA)', @idTipoEventoAutomatico, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11010400MXN484', 'COMP - RETIRO EN ATM TDC (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoAutomatico, 'E00200000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11010500MXN484', 'COMP - RETIRO EN ATM TDC (REVERSADA PRESENTADA)', @idTipoEventoAutomatico, 'E00010000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11010600MXN484', 'COMP - RETIRO EN ATM TDC (A FAVOR ACLARADA)', @idTipoEventoAutomatico, 'E00200000MXN484', 'RETIRO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11011000MXN484', 'COMP - RETIRO EN ATM TDC (COMISIÓN)', @idTipoEventoAutomatico, 'E00011000MXN484', 'COMISIÓN POR DISPOSICIÓN DE EFECTIVO', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11011002MXN484', 'COMP - REVERSO RETIRO EN ATM TDC (COMISIÓN)', @idTipoEventoAutomatico, 'E00011002MXN484', 'REVERSO COMISIÓN POR DISPOSICIÓN DE EFECTIVO', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11011100MXN484', 'COMP - RETIRO EN ATM TDC (IVA COMISIÓN)', @idTipoEventoAutomatico, 'E00011100MXN484', 'IVA DE COMISIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11011102MXN484', 'COMP - REVERSO RETIRO EN ATM TDC (IVA COMISIÓN)', @idTipoEventoCompensacion, 'E00011102MXN484', 'REVERSO IVA DE COMISIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11200000MXN484', 'COMP - DEVOLUCIÓN TDC', @idTipoEventoAutomatico, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11200002MXN484', 'COMP - REVERSO DEVOLUCIÓN TDC', @idTipoEventoAutomatico, 'E00200002MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11200100MXN484', 'COMP - DEVOLUCIÓN TDC (SIN OPERACIÓN)', @idTipoEventoAutomatico, 'E00200100MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11200102MXN484', 'COMP - REVERSO DEVOLUCIÓN TDC (SIN OPERACIÓN)', @idTipoEventoAutomatico, 'E00200102MXN484', 'REVERSO DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11200700MXN484', 'COMP - DEVOLUCIÓN TDC (SIN COMPENSAR)', @idTipoEventoAutomatico, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11200800MXN484', 'COMP - DEVOLUCIÓN TDC (A FAVOR)', @idTipoEventoAutomatico, 'E00200700MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11200900MXN484', 'COMP - DEVOLUCIÓN TDC (REVERSADA PRESENTADA ACLARADA)', @idTipoEventoAutomatico, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11280100MXN484', 'COMP - PAGO/ABONO A TARJETA TDC (SIN OPERACIÓN)', @idTipoEventoAutomatico, 'E00280100MXN484', 'PAGO A TARJETA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11280102MXN484', 'COMP - REVERSO PAGO/ABONO A TARJETA TDC (SIN OPERACIÓN)', @idTipoEventoAutomatico, 'E00280102MXN484', 'REVERSO PAGO A TARJETA', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11300000MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC', @idTipoEventoAutomatico, 'E00300000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11300100MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (SIN OPERACIÓN)', @idTipoEventoAutomatico, 'E00300100MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11300200MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (DUPLICADA)', @idTipoEventoAutomatico, 'E00300000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11300300MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (POST DEVUELTA)', @idTipoEventoAutomatico, 'E00300000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11300400MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (POST DEVUELTA SIN COMPENSAR)', @idTipoEventoAutomatico, 'E00200000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11300500MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (REVERSADA PRESENTADA)', @idTipoEventoAutomatico, 'E00300000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11300600MXN484', 'COMP - CONSULTA DE SALDO EN ATM TDC (A FAVOR ACLARADA)', @idTipoEventoAutomatico, 'E00200000MXN484', 'CONSULTA DE SALDO EN ATM', @idEvento OUTPUT
		--AQUIIIIIIIIIIIIIIIIIIIIIIIII
		--EXEC ProcMan_Comp_GetIdEvento 'E11201500MXN484', 'COMP - DEVOLUCIÓN TDC (EN LINEA)', @idTipoEventoAutomatico, 'E00200000MXN484', 'DEVOLUCIÓN', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11260000MXN484', 'COMP - FAST FUND', @idTipoEventoAutomatico, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11261300MXN484', 'COMP - FAST FUND (LIBERADO)', @idTipoEventoAutomatico, 'E00260000MXN484', 'RECEPCIÓN DE DINERO', @idEvento OUTPUT
		--EXEC ProcMan_Comp_GetIdEvento 'E11261400MXN484', 'COMP - FAST FUND (CANCELADO)', @idTipoEventoAutomatico, 'E00261400MXN484', 'RECEPCIÓN DE DINERO EN DISPUTA', @idEvento OUTPUT



		--====================================================================================================
		--Paso: 6
		--Nota: Asocia las Reglas a los Eventos. 
		--		PENDIENTE confirmar que Reglas se asocian a que Eventos Automáticos y Manuales
		--====================================================================================================
		--EXEC ProcMan_Comp_CreateEventosReglas

		--====================================================================================================
		--Paso: 7.1
		--Nota: Asocia los Scripts Contables a los Eventos Manuales
		--		PENDIENTE Definir Eventos que Validan Saldo o Estatus de Cuenta
		--====================================================================================================
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00AC2000MXN484', @CCH_AUT_T_Imp_A_No_No, @CCH_CMP_T_Imp_A_No_No, @CCH_CXP_T_Imp_C_No_No, @GCM_TXA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00AI0000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_TXA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00AI1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_COM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00AI1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00AP1800MXN484', @GCM_AUT_T_Imp_A_No_No, @GCM_CXP_T_Imp_C_No_No, @GCM_TXA_T_Imp_A_No_No, @SWT_CXP_T_Imp_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00AP1900MXN484', @CCH_AUT_T_Imp_A_No_No, @CCH_CMP_T_Imp_A_No_No, @CCH_CXP_T_Imp_C_No_No, @GCM_AUT_T_Imp_A_No_No, @GCM_CXP_T_Imp_C_No_No, @SWT_CXP_T_Imp_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'A00AN1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_COM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'A00AN1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'A00AT1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_COM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'A00AT1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'B00BI1200MXN484', @CCH_AUT_T_Imp_A_No_No, @CCH_CMP_T_Imp_A_No_No, @CCH_CXP_T_Imp_C_No_No, @GCM_INO_T_ImpBonificacion_C_No_No, @GCM_IVA_T_ImpBonificacionIVA_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'B00GC1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_COM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'B00GC1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'C00IM1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_INM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'C00IM1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'C00IO1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_INO_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'C00IO1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00LC2300MXN484', @CCH_LCR_T_Imp_A_No_No, @CCH_LCR_T_ImpLimCredito_C_No_No, @GCM_CRD_T_Imp_C_No_No, @GCM_CRD_T_ImpLimCredito_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00LQ2400MXN484', @GCM_AUT_T_Imp_A_No_No, @BAN_BAN_T_Imp_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00LQ2500MXN484', @GCM_AUT_T_Imp_C_No_No, @BAN_BAN_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'B00NP1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_COM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'B00NP1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00282600MXN484', @CCH_AUT_T_Imp_A_No_No, @CCH_CMP_T_Imp_A_No_No, @CCH_CXP_T_Imp_C_No_No, @GCM_BAN_T_Imp_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'B00PT1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_COM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'B00PT1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00RN1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_COM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00RN1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00RP1000MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_COM_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00RP1100MXN484', @CCH_AUT_T_Imp_C_No_No, @CCH_CMP_T_Imp_C_No_No, @CCH_CXP_T_Imp_A_No_No, @GCM_IVA_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00SI2100MXN484', @CCH_AUT_T_Imp_A_No_No, @CCH_CXP_T_Imp_C_No_No, @GCM_AUT_T_Imp_A_No_No, @BAN_BAN_T_Imp_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00SI2200MXN484', @CCH_AUT_T_Imp_C_Si_No, @BAN_BAN_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'M00SO1000MXN484', @CCH_AUT_T_ImpSpei_C_Si_No, @GCM_COM_T_ImpSpei_A_No_No
	
		--====================================================================================================
		--Paso: 7.2
		--Nota: Asocia los Scripts Contables a los Eventos Automáticos
		--		PENDIENTE Definir Eventos que Validan Saldo o Estatus de Cuenta
		--====================================================================================================
		------------------------------------COMPRA---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02004100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02004103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02002700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02002703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02001700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02001703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02001600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02001603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02004000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02004003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02005400MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE (FALLBACK)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02005403MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA SE STANDIN (FALLBACK)
		------------------------------------RETIRO---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02014100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02014103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02012700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02012703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02011700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02011703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02011600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE (TECLEADA CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02011603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE STANDIN (TECLEADA CON CVV2)
		--EXEC ProcMan_Comp_CreateEventoScripts 'T02014000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE (E-COMMERCE CON CVV DINÁMICO)
		--EXEC ProcMan_Comp_CreateEventoScripts 'T02014003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02015400MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE (FALLBACK)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02015403MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --RETIRO EN ATM SE STANDIN (FALLBACK)
		------------------------------CONSULTA DE SALDO---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02304100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02304103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02302700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02302703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02301700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02301703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE STANDIN (CONTACTLESS)
		--EXEC ProcMan_Comp_CreateEventoScripts 'T02301600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE (E-COMMERCE CON CVV2)
		--EXEC ProcMan_Comp_CreateEventoScripts 'T02301603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE STANDIN (E-COMMERCE CON CVV2)
		--EXEC ProcMan_Comp_CreateEventoScripts 'T02304000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE (E-COMMERCE CON CVV DINÁMICO)
		--EXEC ProcMan_Comp_CreateEventoScripts 'T02304003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CONSULTA DE SALDO EN ATM SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		------------------------------COMPRA CASHBACK---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02094100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02094103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02092700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02092703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02091700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02091703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02091600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02091603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02094000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02094003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHBACK SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		------------------------------COMPRA CASHADVANCE---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02144100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02144103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02142700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02142703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02141700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02141703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02141600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02141603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02144000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02144003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA CASHADVANCE SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		------------------------------COMPRA MOTO---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02801600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA MOTO SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02801603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA MOTO SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02804000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA MOTO SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02804003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --COMPRA MOTO SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		------------------------------VERIFICACIÓN DE CUENTA---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC4100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC4103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC2700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC2703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC1700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC1703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC1600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC1603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC4000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02VC4003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --VERIFICACIÓN DE CUENTA SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		------------------------------DEVOLUCIÓN---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02204100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02204103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02202700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02202703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02201700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02201703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02201600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02201603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02204000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02204003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --DEVOLUCIÓN SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		------------------------------CANCELACIÓN---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA4100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA4103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA2700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA2703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA1700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA1703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA1600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA1603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA4000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02DA4003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --CANCELACIÓN SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		------------------------------MONEY SEND---------------------------------------------------------------------------------------------------------------------------
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS4100MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS4103MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE STANDIN (CHIP)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS2700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS2703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE STANDIN (BANDA)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS1700MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS1703MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS1600MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS1603MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS4000MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_CreateEventoScripts 'T02MS4003MXN484', @PTH_AUT_NULL_Imp_C_No_NULL, @EMI_PRE_NULL_Imp_A_No_NULL --MONEY SEND SE STANDIN (E-COMMERCE CON CVV DINÁMICO)

		--EXEC ProcMan_Comp_CreateEventoScripts 'T05001600MXN484', @CCH_AUT_NULL_Imp_C_Si_NULL, @GCM_AUT_T_Imp_C_Si_No, @GCM_PRE_T_Imp_A_No_No, @EMI_PRE_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'T05001700MXN484', @CCH_AUT_NULL_Imp_C_Si_NULL, @GCM_AUT_T_Imp_C_Si_No, @GCM_PRE_T_Imp_A_No_No, @EMI_PRE_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'T05010000MXN484', @CCH_AUT_T_ImpRetiro_C_Si_No, @GCM_AUT_T_ImpRetiro_C_Si_No, @GCM_PRE_T_ImpRetiro_A_No_No, @EMI_PRE_T_ImpRetiro_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'T05300000MXN484', @CCH_AUT_NULL_Imp_C_Si_NULL, @GCM_AUT_T_Imp_C_Si_No, @GCM_PRE_T_Imp_A_No_No, @EMI_PRE_T_Imp_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'T05201500MXN484', @CCH_AUT_NULL_Imp_C_Si_NULL, @GCM_AUT_T_Imp_A_No_No, @GCM_PRE_T_Imp_C_No_No, @EMI_PRE_T_Imp_C_No_No
	
		--====================================================================================================
		--Paso: 7.3
		--Nota: Asocia los Scripts Contables a los Eventos de Compensación
		--====================================================================================================
		--EXEC ProcMan_Comp_CreateEventoScripts 'E00190001MXN484', @EMI_FEE_T_ImpComp_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E00290001MXN484', @EMI_FEE_T_ImpComp_A_No_No, @SWT_CXP_T_ImpComp_C_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11000000MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_AUT_T_ImpCompOriginal_A_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_AUT_T_ImpCompOriginal_A_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_PRE_T_ImpCompOriginal_C_No_No, @EMI_PRE_T_ImpCompOriginal_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11000100MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11000200MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11000300MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11000400MXN484', @CCH_AUT_T_ImpCompMarkUpPostDev_C_No_No, @CCH_AUT_T_ImpCompOriginal_A_No_No, @CCH_CMP_T_ImpCompMarkUpPostDev_C_No_No, @CCH_CXP_T_ImpCompMarkUpPostDev_A_No_No, @GCM_AUT_T_ImpCompMarkUpPostDev_C_No_No, @GCM_AUT_T_ImpCompOriginal_A_No_No, @GCM_CXP_T_ImpCompMarkUpPostDev_A_No_No, @GCM_PRE_T_ImpCompOriginal_C_No_No, @EMI_PRE_T_ImpCompOriginal_C_No_No, @EMI_CRS_T_ImpPostDev_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11000500MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11000600MXN484', @EMI_CRS_T_ImpComp_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11010000MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_AUT_T_ImpCompOriginalRetiro_A_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_AUT_T_ImpCompOriginalRetiro_A_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_PRE_T_ImpCompOriginalRetiro_C_No_No, @EMI_PRE_T_ImpCompOriginalRetiro_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11010100MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11010200MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11010300MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11010400MXN484', @CCH_AUT_T_ImpCompMarkUpPostDev_C_No_No, @CCH_AUT_T_ImpCompOriginalRetiro_A_No_No, @CCH_CMP_T_ImpCompMarkUpPostDev_C_No_No, @CCH_CXP_T_ImpCompMarkUpPostDev_A_No_No, @GCM_AUT_T_ImpCompMarkUpPostDev_C_No_No, @GCM_AUT_T_ImpCompOriginalRetiro_A_No_No, @GCM_CXP_T_ImpCompMarkUpPostDev_A_No_No, @GCM_PRE_T_ImpCompOriginalRetiro_C_No_No, @EMI_PRE_T_ImpCompOriginalRetiro_C_No_No, @EMI_CRS_T_ImpPostDev_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11010500MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11010600MXN484', @EMI_CRS_T_ImpComp_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11011000MXN484', @CCH_AUT_T_ImpComision_C_No_No, @CCH_CMP_T_ImpComision_C_No_No, @CCH_CXP_T_ImpComision_A_No_No, @GCM_COM_T_ImpComision_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11011002MXN484', @CCH_AUT_T_ImpComision_A_No_No, @CCH_CMP_T_ImpComision_A_No_No, @CCH_CXP_T_ImpComision_C_No_No, @GCM_COM_T_ImpComision_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11011100MXN484', @CCH_AUT_T_ImpComisionIVA_C_No_No, @CCH_CMP_T_ImpComisionIVA_C_No_No, @CCH_CXP_T_ImpComisionIVA_A_No_No, @GCM_IVA_T_ImpComisionIVA_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11011102MXN484', @CCH_AUT_T_ImpComisionIVA_A_No_No, @CCH_CMP_T_ImpComisionIVA_A_No_No, @CCH_CXP_T_ImpComisionIVA_C_No_No, @GCM_IVA_T_ImpComisionIVA_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11200000MXN484', @CCH_AUT_T_ImpComp_A_No_No, @CCH_CMP_T_ImpComp_A_No_No, @CCH_CXP_T_ImpComp_C_No_No, @GCM_AUT_T_ImpComp_A_No_No, @GCM_CXP_T_ImpComp_C_No_No, @SWT_CXP_T_ImpComp_C_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11200002MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11200100MXN484', @CCH_AUT_T_ImpComp_A_No_No, @CCH_CMP_T_ImpComp_A_No_No, @CCH_CXP_T_ImpComp_C_No_No, @GCM_AUT_T_ImpComp_A_No_No, @GCM_CXP_T_ImpComp_C_No_No, @SWT_CXP_T_ImpComp_C_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11200102MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11200700MXN484', @EMI_CRS_T_ImpComp_A_No_No, @SWT_CXP_T_ImpComp_C_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11200800MXN484', @EMI_CRS_T_ImpComp_A_No_No, @SWT_CXP_T_ImpComp_C_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11200900MXN484', @CCH_AUT_T_ImpComp_A_No_No, @CCH_CMP_T_ImpComp_A_No_No, @CCH_CXP_T_ImpComp_C_No_No, @GCM_AUT_T_ImpComp_A_No_No, @GCM_CXP_T_ImpComp_C_No_No, @GCM_TXA_T_ImpCompMarkUp_A_No_No, @EMI_TXA_T_ImpCompMarkUp_C_No_No, @SWT_CXP_T_ImpComp_C_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11280100MXN484', @CCH_AUT_T_ImpComp_A_No_No, @CCH_CMP_T_ImpComp_A_No_No, @CCH_CXP_T_ImpComp_C_No_No, @GCM_AUT_T_ImpComp_A_No_No, @GCM_CXP_T_ImpComp_C_No_No, @SWT_CXP_T_ImpComp_C_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_A_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_C_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11280102MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11300000MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_AUT_T_ImpCompOriginal_A_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_AUT_T_ImpCompOriginal_A_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_PRE_T_ImpCompOriginal_C_No_No, @EMI_PRE_T_ImpCompOriginal_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11300100MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11300200MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11300300MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11300400MXN484', @CCH_AUT_T_ImpCompMarkUpPostDev_C_No_No, @CCH_AUT_T_ImpCompOriginal_A_No_No, @CCH_CMP_T_ImpCompMarkUpPostDev_C_No_No, @CCH_CXP_T_ImpCompMarkUpPostDev_A_No_No, @GCM_AUT_T_ImpCompMarkUpPostDev_C_No_No, @GCM_AUT_T_ImpCompOriginal_A_No_No, @GCM_CXP_T_ImpCompMarkUpPostDev_A_No_No, @GCM_PRE_T_ImpCompOriginal_C_No_No, @EMI_PRE_T_ImpCompOriginal_C_No_No, @EMI_CRS_T_ImpPostDev_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11300500MXN484', @CCH_AUT_T_ImpComp_C_No_No, @CCH_CMP_T_ImpComp_C_No_No, @CCH_CXP_T_ImpComp_A_No_No, @GCM_AUT_T_ImpComp_C_No_No, @GCM_CXP_T_ImpComp_A_No_No, @GCM_TXA_T_ImpCompMarkUp_C_No_No, @EMI_TXA_T_ImpCompMarkUp_A_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11300600MXN484', @EMI_CRS_T_ImpComp_C_No_No, @SWT_CXP_T_ImpComp_A_No_No, @SWT_CINT_T_CuotaIntercambioSwitch_C_No_No, @EMI_CINT_T_CuotaIntercambioEmisor_A_No_No, @GCM_CINT_T_CuotaIntercambioSubEmisor_A_No_No
		--AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11201500MXN484', @CCH_AUT_T_ImpComp_A_No_No, @CCH_CMP_T_ImpComp_A_No_No, @CCH_SBC_T_ImpCompOriginal_C_No_No, @CCH_CXP_T_ImpComp_C_No_No, @GCM_AUT_T_ImpComp_A_No_No, @GCM_CXP_T_ImpComp_C_No_No, @GCM_PRE_T_ImpCompOriginal_A_No_No, @SWT_CXP_T_ImpComp_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11260000MXN484', @CCH_AUT_T_ImpComp_A_No_No, @CCH_CMP_T_ImpComp_A_No_No, @CCH_SBC_T_ImpCompOriginal_C_No_No, @CCH_CXP_T_ImpComp_C_No_No, @GCM_AUT_T_ImpComp_A_No_No, @GCM_CXP_T_ImpComp_C_No_No, @GCM_PRE_T_ImpCompOriginal_A_No_No, @SWT_CXP_T_ImpComp_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11261300MXN484', @CCH_AUT_T_ImpCompOriginal_C_No_No, @CCH_AUT_T_ImpComp_A_No_No, @CCH_CMP_T_ImpComp_A_No_No, @CCH_CXP_T_ImpComp_C_No_No, @GCM_AUT_T_ImpComp_A_No_No, @GCM_CXP_T_ImpComp_C_No_No, @GCM_PRE_T_ImpCompOriginal_A_No_No, @SWT_CXP_T_ImpComp_C_No_No
		--EXEC ProcMan_Comp_CreateEventoScripts 'E11261400MXN484', @EMI_CRS_T_ImpComp_A_No_No, @SWT_CXP_T_ImpComp_C_No_No
		--====================================================================================================
		--Paso: 8
		--Nota: Verificación de la relación de los Eventos con sus Scripts Contables
		--====================================================================================================
		--EXEC ProcMan_Comp_GetEventoScripts 'M00AC2000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00AI0000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00AI1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00AI1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00AP1800MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00AP1900MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'A00AN1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'A00AN1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'A00AT1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'A00AT1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'B00BI1200MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'B00GC1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'B00GC1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'C00IM1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'C00IM1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'C00IO1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'C00IO1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00LC2300MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00LQ2400MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00LQ2500MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'B00NP1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'B00NP1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00282600MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'B00PT1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'B00PT1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00RN1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00RN1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00RP1000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00RP1100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00SI2100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00SI2200MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'M00SO1000MXN484'
		--AQUIIIIIIIIIIIIIIIIIIII
		--------------------------COMPRA------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02004100MXN484' --COMPRA SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02004103MXN484' --COMPRA SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02002700MXN484' --COMPRA SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02002703MXN484' --COMPRA SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02001700MXN484' --COMPRA SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02001703MXN484' --COMPRA SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02001600MXN484' --COMPRA SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02001603MXN484' --COMPRA SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02004000MXN484' --COMPRA SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02004003MXN484' --COMPRA SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02005400MXN484' --COMPRA SE (FALLBACK)
		EXEC ProcMan_Comp_GetEventoScripts 'T02005403MXN484' --COMPRA SE STANDIN (FALLBACK)
		--------------------------RETIRO------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02014100MXN484' --RETIRO EN ATM SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02014103MXN484' --RETIRO EN ATM SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02012700MXN484' --RETIRO EN ATM SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02012703MXN484' --RETIRO EN ATM SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02011700MXN484' --RETIRO EN ATM SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02011703MXN484' --RETIRO EN ATM SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02011600MXN484' --RETIRO EN ATM SE (TECLEADA CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02011603MXN484' --RETIRO EN ATM SE STANDIN (TECLEADA CON CVV2)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02014000MXN484' --RETIRO EN ATM SE (E-COMMERCE CON CVV DINÁMICO)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02014003MXN484' --RETIRO EN ATM SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02015400MXN484' --RETIRO EN ATM SE (FALLBACK)
		EXEC ProcMan_Comp_GetEventoScripts 'T02015403MXN484' --RETIRO EN ATM SE STANDIN (FALLBACK)
		---------------------CONSULTA DE SALDO------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02304100MXN484' --CONSULTA DE SALDO EN ATM SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02304103MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02302700MXN484' --CONSULTA DE SALDO EN ATM SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02302703MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02301700MXN484' --CONSULTA DE SALDO EN ATM SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02301703MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (CONTACTLESS)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02301600MXN484' --CONSULTA DE SALDO EN ATM SE (E-COMMERCE CON CVV2)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02301603MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (E-COMMERCE CON CVV2)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02304000MXN484' --CONSULTA DE SALDO EN ATM SE (E-COMMERCE CON CVV DINÁMICO)
		--EXEC ProcMan_Comp_GetEventoScripts 'T02304003MXN484' --CONSULTA DE SALDO EN ATM SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------COMPRA CASHBACK------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02094100MXN484' --COMPRA CASHBACK SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02094103MXN484' --COMPRA CASHBACK SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02092700MXN484' --COMPRA CASHBACK SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02092703MXN484' --COMPRA CASHBACK SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02091700MXN484' --COMPRA CASHBACK SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02091703MXN484' --COMPRA CASHBACK SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02091600MXN484' --COMPRA CASHBACK SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02091603MXN484' --COMPRA CASHBACK SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02094000MXN484' --COMPRA CASHBACK SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02094003MXN484' --COMPRA CASHBACK SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------COMPRA CASHADVANCE------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02144100MXN484' --COMPRA CASHADVANCE SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02144103MXN484' --COMPRA CASHADVANCE SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02142700MXN484' --COMPRA CASHADVANCE SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02142703MXN484' --COMPRA CASHADVANCE SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02141700MXN484' --COMPRA CASHADVANCE SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02141703MXN484' --COMPRA CASHADVANCE SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02141600MXN484' --COMPRA CASHADVANCE SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02141603MXN484' --COMPRA CASHADVANCE SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02144000MXN484' --COMPRA CASHADVANCE SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02144003MXN484' --COMPRA CASHADVANCE SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------COMPRA MOTO------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02801600MXN484' --COMPRA MOTO SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02801603MXN484' --COMPRA MOTO SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02804000MXN484' --COMPRA MOTO SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02804003MXN484' --COMPRA MOTO SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------VERIFICACIÓN DE CUENTA------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC4100MXN484' --VERIFICACIÓN DE CUENTA SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC4103MXN484' --VERIFICACIÓN DE CUENTA SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC2700MXN484' --VERIFICACIÓN DE CUENTA SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC2703MXN484' --VERIFICACIÓN DE CUENTA SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC1700MXN484' --VERIFICACIÓN DE CUENTA SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC1703MXN484' --VERIFICACIÓN DE CUENTA SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC1600MXN484' --VERIFICACIÓN DE CUENTA SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC1603MXN484' --VERIFICACIÓN DE CUENTA SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC4000MXN484' --VERIFICACIÓN DE CUENTA SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02VC4003MXN484' --VERIFICACIÓN DE CUENTA SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------DEVOLUCIÓN------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02204100MXN484' --DEVOLUCIÓN SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02204103MXN484' --DEVOLUCIÓN SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02202700MXN484' --DEVOLUCIÓN SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02202703MXN484' --DEVOLUCIÓN SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02201700MXN484' --DEVOLUCIÓN SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02201703MXN484' --DEVOLUCIÓN SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02201600MXN484' --DEVOLUCIÓN SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02201603MXN484' --DEVOLUCIÓN SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02204000MXN484' --DEVOLUCIÓN SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02204003MXN484' --DEVOLUCIÓN SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------CANCELACIÓN------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA4100MXN484' --CANCELACIÓN SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA4103MXN484' --CANCELACIÓN SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA2700MXN484' --CANCELACIÓN SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA2703MXN484' --CANCELACIÓN SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA1700MXN484' --CANCELACIÓN SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA1703MXN484' --CANCELACIÓN SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA1600MXN484' --CANCELACIÓN SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA1603MXN484' --CANCELACIÓN SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA4000MXN484' --CANCELACIÓN SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02DA4003MXN484' --CANCELACIÓN SE STANDIN (E-COMMERCE CON CVV DINÁMICO)
		---------------------MONEY SEND------------------------------------------------------------
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS4100MXN484' --MONEY SEND SE (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS4103MXN484' --MONEY SEND SE STANDIN (CHIP)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS2700MXN484' --MONEY SEND SE (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS2703MXN484' --MONEY SEND SE STANDIN (BANDA)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS1700MXN484' --MONEY SEND SE (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS1703MXN484' --MONEY SEND SE STANDIN (CONTACTLESS)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS1600MXN484' --MONEY SEND SE (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS1603MXN484' --MONEY SEND SE STANDIN (E-COMMERCE CON CVV2)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS4000MXN484' --MONEY SEND SE (E-COMMERCE CON CVV DINÁMICO)
		EXEC ProcMan_Comp_GetEventoScripts 'T02MS4003MXN484' --MONEY SEND SE STANDIN (E-COMMERCE CON CVV DINÁMICO)

		--EXEC ProcMan_Comp_GetEventoScripts 'T05001600MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'T05001700MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'T05010000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'T05300000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'T05201500MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E00190001MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E00290001MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11000000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11000100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11000200MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11000300MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11000400MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11000500MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11000600MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11010000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11010100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11010200MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11010300MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11010400MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11010500MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11010600MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11011000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11011002MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11011100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11011102MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11200000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11200002MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11200100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11200102MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11200700MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11200800MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11200900MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11280100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11280102MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11300000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11300100MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11300200MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11300300MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11300400MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11300500MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11300600MXN484'
		--AQUIIIIIIIIIIIIII
		--EXEC ProcMan_Comp_GetEventoScripts 'E11201500MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11260000MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11261300MXN484'
		--EXEC ProcMan_Comp_GetEventoScripts 'E11261400MXN484'
	END
	ELSE
	BEGIN	
		--====================================================================================================
		--Paso: 2
		--Nota: Si existe variable NULL, forzamos ROLLBACK
		--====================================================================================================
		SET @commit = 0
		PRINT 'VARIABLE NULL'
		SELECT @idClaveAplicacionOperation AS CveAplicacionOperation 
		, @idClaveAplicacionToday AS CveAplicacionToday
		, @idTipoColectivaBAN AS ColectivaBAN
		, @idTipoColectivaCCH AS ColectivaCCH
		, @idTipoColectivaEMI AS ColectivaEMI
		, @idTipoColectivaGCM AS ColectivaGCM
		, @idTipoColectivaPTH AS ColectivaPTH
		, @idTipoColectivaSWT AS ColectivaSWT
		, @idTipoCuentaAUT AS CuentaAUT
		, @idTipoCuentaBAN AS CuentaBAN
		, @idTipoCuentaCMP AS CuentaCMP
		, @idTipoCuentaCOM AS CuentaCOM
		, @idTipoCuentaCRD AS CuentaCRD
		, @idTipoCuentaCRS AS CuentaCRS
		, @idTipoCuentaCXP AS CuentaCXP
		, @idTipoCuentaFEE AS CuentaFEE
		, @idTipoCuentaINM AS CuentaINM
		, @idTipoCuentaINO AS CuentaINO
		, @idTipoCuentaIVA AS CuentaIVA
		, @idTipoCuentaLCR AS CuentaLCR
		, @idTipoCuentaMUP AS CuentaMUP
		, @idTipoCuentaPRE AS CuentaPRE
		, @idTipoCuentaTXA AS CuentaTXA
		, @idTipoCuentaSBC AS CuentaSBC
		--, @idTipoCuentaCINT AS CuentaCINT
		, @idTipoEventoAutomatico AS TipoEventoAutomatico
		, @idTipoEventoCompensacion AS TipoEventoCompensacion
		, @idTipoEventoManual AS TipoEventoManual
	END

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN