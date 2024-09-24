USE [Autorizador]
GO

BEGIN TRAN

	DECLARE @commit BIT = 1
	

--AJUSTAR PARA CADA TIPO DE PRODUCTO
DECLARE @ClaveTipoProducto VARCHAR (10) = 'JSON01';
DECLARE @ClaveNumericaDivisa VARCHAR(3) ='484'

--PODRIAN CAMBIAR DEPENDIENDO DEL TIPO DE PRODUCTO QUE SE DESEE GENERAR
DECLARE @NombrePrametros VARCHAR(5000)
  --  = '@LongitudBIN,@ComApertura,@IVA,@ComReposicion,@VigPlastico,@DiaFechaCorte,@DiaFechaLimPago,@ImpComisionDisposicion,@PorcComisionDisposicion,@GeneraCorte,@SwitchProcesador,@pr_montoMaxPOS,@pr_montoMaxATM,@pr_montoMaxINT,@pr_montoDiaPOS,@pr_montoDiaATM,@pr_montoDiaINT,@pr_montoSemanaPOS,@pr_montoSemanaATM,@pr_montoSemanaINT,@pr_montoMesPOS,@pr_montoMesATM,@pr_montoMesINT,@pr_cantidadDiaINT,@pr_cantidadDiaATM,@pr_cantidadDiaPOS,@pr_cantidadSemanaINT,@pr_cantidadSemanaATM,@pr_cantidadSemanaPOS,@pr_cantidadMesPOS,@pr_cantidadMesATM,@pr_cantidadMesINT,@wsPlugin,@ClaveEmbozador,@Aforo,@MaxImporteChip,@MaxImporteChipDia,@MaxImporteChipMes,@MaxImporteContactless,@MaxImporteContactlessDia,@MaxImporteContactlessMes,@MaxImporteEcommerce,@MaxImporteEcommerceDia,@MaxImporteEcommerceMes,@MaxImporteDia,@MaxImporteMes,@MaxRetiroPorEvento,@MaxRetiroDia,@MaxRetiroMes';
	= '@ImpComisionDisposicion,@PorcComisionDisposicion,@LongitudBIN,@ClaveEmbozador,@IVA,@SwitchProcesador,@VigPlastico,@DiaFechaCorte,@ContadorNIPInvalido,@MaxImporteChip,@MaxImporteChipDia,@MaxImporteChipMes,@MaxImporteEcommerce,@MaxImporteEcommerceDia,@MaxImporteEcommerceMes,@MaxImporteContactless,@MaxImporteContactlessDia,@MaxImporteContactlessMes,@MaxImporteDia,@MaxImporteMes,@MaxRetiroPorEvento,@MaxRetiroDia,@MaxRetiroMes'


DECLARE @ID_TipoProducto INT;

SET @ID_TipoProducto = (SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @ClaveTipoProducto)

/***********************************************************/
--Selects Excluidos
/***********************************************************/
--select * from TipoProductoParametroMultiAsginacion tppm
--inner join ParametrosMultiasignacion pm on pm.ID_ParametroMultiasignacion = tppm.ID_ParametroMultiasignacion
--where tppm.ID_TipoProducto = @ID_TipoProducto*/

/***********************************************************/

/***********************************************************/
--VALIDACIÓN PARAMETROS MULTIASIGNACIÓN
/***********************************************************/

/***********************************************************/
--Selects Excluidos
/***********************************************************/
--IF EXISTS (SELECT Parametros.value AS NombreParam
--                     FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
--					 WHERE Parametros.value NOT IN(
--					select Nombre from 
--							(SELECT Parametros.value AS NombreParam
--							FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
--							)                                        Config
--							INNER JOIN dbo.ParametrosMultiasignacion pma
--							ON Config.NombreParam = pma.Nombre
--					)
--					)
--BEGIN
--	SELECT Parametros.value AS ParametrosFaltantes
--                     FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
--					 WHERE Parametros.value NOT IN(
--					select Nombre from 
--							(SELECT Parametros.value AS NombreParam
--							FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
--							)                                        Config
--							INNER JOIN dbo.ParametrosMultiasignacion pma
--							ON Config.NombreParam = pma.Nombre
--					)
--	RAISERROR('FALTAN PARÁMETROS EN LA TABLA "ParametrosMultiasignacion", CONSULTAR VENTANA RESULTS', 16, 1);
--    RETURN;							
--END
--ELSE
--BEGIN
--	PRINT('Parámetros validados correctamente')
--END
/***********************************************************/

/***********************************************************/
--PARAMÉTROS A INSERTAR
/***********************************************************/

   SELECT 
   'Parámetros a Insertar',
   @ID_TipoProducto,
   pma.ID_ParametroMultiasignacion,
   pma.Nombre
            FROM (
                     SELECT Parametros.value AS NombreParam
                     FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
                 )                                        Config
                 INNER JOIN dbo.ParametrosMultiasignacion pma
                     ON Config.NombreParam = pma.Nombre and ID_ParametroMultiasignacion not in ( select TipoProductoParametroMultiAsginacion.ID_ParametroMultiasignacion from TipoProductoParametroMultiAsginacion where ID_TipoProducto=@ID_TipoProducto);

/***********************************************************/
--INSERTAR LOS PARAMETROS MULTIASGINACION AL TIPO PRODUCTO
/***********************************************************/
INSERT INTO dbo.TipoProductoParametroMultiAsginacion
    ( ID_TipoProducto,
      ID_ParametroMultiasignacion )
            SELECT @ID_TipoProducto,
                   pma.ID_ParametroMultiasignacion
            FROM (
                     SELECT Parametros.value AS NombreParam
                     FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
                 )                                        Config
                 INNER JOIN dbo.ParametrosMultiasignacion pma
                     ON Config.NombreParam = pma.Nombre and ID_ParametroMultiasignacion not in ( select TipoProductoParametroMultiAsginacion.ID_ParametroMultiasignacion from TipoProductoParametroMultiAsginacion where ID_TipoProducto=@ID_TipoProducto);


--DELETE FROM TipoProductoParametroMultiAsginacion
--WHERE ID_TipoProductoParametroMultiAsginacion IN (
--select tppm.ID_TipoProductoParametroMultiAsginacion from TipoProductoParametroMultiAsginacion tppm
--inner join ParametrosMultiasignacion pm on pm.ID_ParametroMultiasignacion = tppm.ID_ParametroMultiasignacion
----left join ValorParametroMultiasignacion vpm on vpm.ID_ParametroMultiasignacion = pm.ID_ParametroMultiasignacion
--where tppm.ID_TipoProducto = (select ID_TipoProducto from tipoproducto where ClaveTipoProducto = @ClaveTipoProducto)
----and vpm.Valor IS NULL
--and pm.Nombre IN (
--'@MontoMinTx'
--,'@NumTxMaxDia'
--,'@NumTxMaxDiaEcommerce'
--,'@NumTxMaxDiaFondeo'
--,'@NumTxMaxDiaPOS'
--,'@NumTxMaxMes'
--,'@NumTxMaxMesATM'
--,'@NumTxMaxMesEcommerce'
--,'@NumTxMaxMesFondeo'
--,'@NumTxMaxMesPOS'
--,'@NumTxMaxNIPErr'
--,'@TDD_AplicaReglaCumplimiento'
--,'@TDD_MaximoCashIn'
--,'@TDD_NivelCuentaCumplimiento'
--,'@TDD_NivelCuentaCumplimientoCashIn'
--,'@TDD_UDISMaximoAbonoN1'
--,'@TDD_UDISMaximoAbonoN2'
--,'@TDD_UDISMaximoAbonoN3'
--,'@TDD_UDISMaximoAbonoPersonalizado'
--,'@TDD_UDISSaldoMaximoN1'
--,'@TDD_UDISSaldoMaximoN2'
--,'@TDD_UDISSaldoMaximoPersonalizado'
--,'@TDD_UDISSaldoMaximoN3'
--,'@TDD_NivelCuenta'
--,'@TDD_NivelCuentaCumplimientoPersonalizado'
--,'@MontoMaxDia'
--,'@MontoMaxDiaATM'
--,'@MontoMaxDiaEcommerce'
--,'@MontoMaxDiaPOS'
--,'@MontoMaxEcommerce'
--,'@MontoMaxMes'
--,'@MontoMaxMesATM'
--,'@MontoMaxMesEcommerce'
--,'@MontoMaxMesPOS'
--,'@MontoMinTx'
--,'@MontoMaxFondeo'
--,'@MontoMaxDiaFondeo'
--,'@MontoMaxMesFondeo'
--,'@MontoMinFondeo'
--,'@MesesLimRetEfectivo'
--,'@TelefonoLegalContacto'
--,'@ImagenLogoEstadoDeCuenta'
--,'@ProveedorSPEI'
--,'@TextoLegalContacto'
--,'@EnvioCorreoEdoCta'
--,'@ImagenLogoCredito'
--,'@ImagenRedesSocialesEstadoDeCuenta'
--,'@ImagenDatosCondusef'
--,'@LimiteCredito'
--,'@ComDispEfectivo'
--,'@Cat_DisTarjetaFisica'
--,'@embozoSucursalCiudad'
--,'@RutaKeySAT'
--,'@embozoSucursalDenominacion'
--,'@GeneraFacturaTimbrada'
--,'@embozoSucursalNoExterno'
--,'@embozoSucursalCP'
--,'@ComSinPagoTarjeta'
--,'@embozoDenominacion'
--,'@UserNamePACTimbre'
--,'@RutaCerSAT'
--,'@embozoSucursalEmisor'
--,'@PACFacturacion'
--,'@ImagenCat'
--,'@embozoSucursalPais'
--,'@embozoSucursalCalle'
--,'@TDD_NivelCuentasCumplimientoCashIn'
--,'@PassCerSAT'
--,'@embozoCodigoProducto'
--,'@RequestPACTimbre'
--,'@RequestorPACTimbre'
--,'@embozoInstitucion'
--,'@UserPassPACTimbre'
--,'@embozoSucursalColonia'
--,'@NumTxMaxDiaATM'
--,'@NumTxtMaxDiaFondeo'
--,'@NumTxtMaxDiaPOS'
--,'@NumTxtMaxMes'
--,'@NumTxtMaxMesATM'
--,'@NumTxMaxMesEcommerce'
--,'@NumTxtMaxMesFondeo'
--,'@NumTxtMaxMesPOS'
--,'@ComPagoTarjetaTardio'
--,'@TelefonoContacto'
--,'@CorreoContacto'
--,'@Procesador'
--,'@CobrarComisionReposicion'
--,'@CobrarComisionReasignacion'
--,'@LimRetEfectivo'
--,'@TelefonosLegalContacto'
--,'@ProvedorSPEI'
--,'@InteresMor'
--,'@ComAnualAdicional'
--,'@DiaFechaLimPago'
--,'@LimiteCreditoMaximo'
--,'@LimiteCreditoMinimo'
--,'@NumCorteCobranza'
--,'@UsoMinimo_Comision'
--,'@UsoMinimo_MontoMin'
--,'@UsoMinimo_NumTxMin'
--,'@AplicarReglaImpagos'
--,'@BloqueoImpagos'
--,'@BloqueoImpagos_DiasHolgura'
--,'@MSI_FechaValor'
--,'@TipoAnualidad'
--,'@TasaInteresOrd'
--,'@DiasLimitePago'
--,'@FactorLimiteCredito'
--,'@FactorSaldoCuenta'
--,'@ComSobregiro'
--,'@FactorSaldoInsoluto'
--,'@ComAnualTitular'
--,'@RutaGenEdC'
--,'@ComGastosCob'
--,'@MultIntMor'
--)
--)

/***********************************************************/
--Selects Excluidos
/***********************************************************/
--select * from TipoProductoParametroMultiAsginacion tppm
--inner join ParametrosMultiasignacion pm on pm.ID_ParametroMultiasignacion = tppm.ID_ParametroMultiasignacion
--where tppm.ID_TipoProducto = @ID_TipoProducto
/***********************************************************/

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN


--		select * from ParametrosMultiasignacion
--		where ID_ParametroMultiasignacion in(
--		312
--,313
--,314
--,319
--,320
--,321
--,10363
--,10364
--,10385
--,10386
--,10387
--,10388
--,10389
--,10390
--,10391
--		)