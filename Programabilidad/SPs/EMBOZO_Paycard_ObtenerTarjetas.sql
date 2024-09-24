USE Autorizador
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[EMBOZO_Paycard_ObtenerTarjetas] 
	@daysback VARCHAR(10) = NULL, @clavesEstatus VARCHAR(5) = NULL, @instanciaEmbozador VARCHAR(200) = NULL,
	@ID_Colectiva VARCHAR(10) = NULL
WITH ENCRYPTION
AS 
BEGIN 
	/*
	==========================================================================================
	==================================Historial de Versiones==================================
	==========================================================================================
	Versión:		1.0
	Autor:			Fernando Maya
	Fecha:			03 Feb 2023
	Descripción:	Se regresa el pinblock en los datos
	==========================================================================================
	Versión:		1.1
	Autor:			Fernando Maya
	Fecha:			07 Feb 2023
	Descripción:	Se agregan campos para generar el QR
	==========================================================================================
	Versión:		1.2
	Autor:			Fernando Maya
	Fecha:			25 Abr 2023
	Descripción:	Se cambia validacion de clave @instanciaEmbozador por el id instancia
	==========================================================================================
	Versión:		1.3
	Autor:			Fernando Maya
	Fecha:			30 May 2024
	Descripción:	Se toma pma @PrefijoUrlQR para url de QR
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	EXEC EMBOZO_Paycard_ObtenerTarjetas
	@daysback = '10', @clavesEstatus = '0002', @instanciaEmbozador = '1',@ID_Colectiva = 1496
	==========================================================================================
	*/
	SET NOCOUNT ON   

	DECLARE @p_daysback INT = 1,
		@p_clavesEstatus VARCHAR(100) = '0002',
		@p_instanciaEmbozador VARCHAR(50)

	DECLARE @idGrupoMA INT, @idtipoTar INT
	DECLARE @serviceCode VARCHAR(10) = '221'
	DECLARE @pvk VARCHAR(2) = '0'
	DECLARE @pvv VARCHAR(5) = '0000'
	DECLARE @tipoTar VARCHAR(2) = 'T'
	DECLARE @razonFab VARCHAR(2) = 'N'
	DECLARE @claveDiseno VARCHAR(5) = '00'
	
	SELECT @idGrupoMA = ID_GrupoMA FROM GrupoMA WHERE ClaveGrupo = '001'
	SELECT @idtipoTar = ID_TipoMA FROM TipoMedioAcceso WHERE Clave = 'TAR'

	DECLARE @ERROR VARCHAR(1000);

	------BUSQUEDA DE CLAVES PARA CATALOGOS
	DECLARE @Producto INT, @idTipoCuentaCCLC INT, @idTipoColectivaCliente INT

	SELECT @idTipoCuentaCCLC = ID_TipoCuenta FROM TipoCuenta (NOLOCK) WHERE ClaveTipoCuenta = 'CCLC'

	SELECT @idTipoColectivaCliente = ID_TipoColectiva FROM TipoColectiva (NOLOCK) WHERE ClaveTipoColectiva = 'GCM'

	SET @p_daysback = CAST(ISNULL(@daysback,1) AS INT)
	SET @p_clavesEstatus = ISNULL(@clavesEstatus, @p_clavesEstatus) 
	SET @p_instanciaEmbozador = ISNULL(@instanciaEmbozador, @p_instanciaEmbozador)

	IF @p_daysback IS NULL 
	BEGIN 
		SET @p_daysback  = 1
	END

	IF @p_clavesEstatus IS NULL 
	BEGIN
		SET @p_clavesEstatus = '0002'
	END

	IF @p_instanciaEmbozador IS NULL
	BEGIN 
		SET @ERROR
            = '[EMBOZO_Paycard_ObtenerTarjetas] - NO se ha seleccionado una Instancia para la Obtención de Tarjetas';

        RAISERROR(@ERROR, 16, 1);
        RETURN;
	END 

	-------------------OBTENCIÓN DE LOS DATOS------------------------
	SELECT 
     MA.ID_MA,
	 ROW_NUMBER() OVER( ORDER BY MA.ID_MA) N_CORRELATIVO,
	 MA.ClaveMA N_TARJETA,
	 MA.ClaveMA N_TARJETA_SEC,
	 MA.Expiracion FEC_VIGENCIA_HASTA,
	 MA.NombreEmbozo NOMBRE_EMBOZO,
	 (ISNULL(COL.APaterno,' ') + '/' + ISNULL(COL.NombreORazonSocial,' ')) NOMBRE_TARJETAHABIENTE,
	 @serviceCode SERVICE_CODE, 
	 @pvk PVK, 
	 @pvv PVV,
	 @tipoTar TIPO_TAR,
	 @razonFab RAZON_FAB,
	 ISNULL(DIR.Calle,' ')	CALLE,
	 ISNULL(DIR.NumExterior,'0') N_EXTERIOR,
	 ISNULL(DIR.NumIterior,'0') N_INTERIOR,
	 ISNULL(DIR.CP,'0') CP,
	 ISNULL(DIR.Colonia,' ') COLONIA,
	 ISNULL(DIR.Municipio,' ') MUNICIPIO,
	 ISNULL(ES.DesEstado,' ') ESTADO,
	 ISNULL(DIR.Pais,' ') PAIS,
	 ColPadre.NombreORazonSocial NOM_EMPRESA,
	 @claveDiseno CLAVE_DISENO,
	 ColPadre.ClaveColectiva CLIENTE,
	 Pr.Clave PRODUCTO,
	 MA.ID_MA FOLIO_QR,
	 A.ClaveAlias CODIGO_QR,
	 A.ClaveAlias BIN7,
	 (SELECT svpma.Valor
      FROM ParametrosMultiasignacion spma
     INNER JOIN ValorParametroMultiasignacion svpma ON spma.ID_ParametroMultiasignacion = svpma.ID_ParametroMultiasignacion
     WHERE	svpma.ID_Plantilla = ISNULL(p.ID_PlantillaPadre, p.ID_Plantilla)
       and spma.Clave = '@PrefijoUrlQR') PrefijoUrlQR
	 FROM MediosAcceso MA WITH (NOLOCK)
		INNER JOIN MediosAccesoCuenta MAC WITH (NOLOCK) on MAC.ID_MA = MA.ID_MA	
			INNER JOIN Cuentas C WITH (NOLOCK) on C.ID_Cuenta = MAC.ID_Cuenta AND C.ID_TipoCuenta = @idTipoCuentaCCLC
				INNER JOIN Alias A WITH (NOLOCK) ON A.ID_MA = MA.ID_MA
					INNER JOIN Plantillas P WITH (NOLOCK) on P.ID_Plantilla = C.ID_Plantilla
						INNER JOIN Producto Pr WITH (NOLOCK) ON Pr.ID_Producto = P.ID_Producto
							INNER JOIN ValorParametroMultiasignacion VPM WITH (NOLOCK) on VPM.ID_Plantilla = ISNULL(P.ID_PlantillaPadre,P.ID_Plantilla)
								INNER JOIN ParametrosMultiasignacion PM WITH (NOLOCK) on PM.ID_ParametroMultiasignacion = VPM.ID_ParametroMultiasignacion
									INNER JOIN EstatusMedioAcceso EMA WITH (NOLOCK) on EMA.ID_EstatusMA = MA.ID_EstatusMA
										INNER JOIN ColectivaMedioAcceso CMA WITH (NOLOCK) on CMA.ID_MA = MA.ID_MA
											INNER JOIN Colectivas COL WITH (NOLOCK) on COL.ID_Colectiva = CMA.ID_Colectiva
												LEFT JOIN Direcciones DIR WITH (NOLOCK) ON DIR.ID_Direccion = COL.ID_DUbicacion
													INNER JOIN Colectivas ColPadre WITH (NOLOCK) on ColPadre.ID_Colectiva = COL.ID_ColectivaPadre AND ColPadre.ID_TipoColectiva = @idTipoColectivaCliente
														INNER JOIN TipoMedioAcceso TM WITH (NOLOCK) on TM.ID_TipoMA = MA.ID_TipoMA
															INNER JOIN TipoColectiva TCOL WITH (NOLOCK) ON TCOL.ID_TipoColectiva = ColPadre.ID_TipoColectiva
																INNER JOIN EMBOZO_Instancia EMI WITH (NOLOCK) ON EMI.ID_EMBOZO_Instancia = @p_instanciaEmbozador
																	LEFT JOIN EMBOZO_MediosAccesoProcesados EMAP WITH (NOLOCK) ON EMAP.ID_MA = MA.ID_MA
																		LEFT JOIN Estado ES WITH (NOLOCK) ON ES.CveEstado = DIR.ClaveEstado
														
	WHERE PM.Clave = '@ClaveEmbozador'
	AND VPM.Valor = EMI.Embozador
	AND EMA.Clave in (@p_clavesEstatus)
	AND DATEDIFF(DAY,MA.FechaAlta,GETDATE()) <= @p_daysback 
	AND EMAP.fechaProceso IS NULL
	AND MA.Id_TipoMA = @idtipoTar
	AND MA.ID_GrupoMA = @idGrupoMA
	AND ColPadre.ID_Colectiva = @ID_Colectiva
END
GO
