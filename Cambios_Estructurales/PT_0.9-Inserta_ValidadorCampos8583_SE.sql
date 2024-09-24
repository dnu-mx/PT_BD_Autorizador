USE [Autorizador]
BEGIN TRAN

	DECLARE @commit BIT = 1
		
		DECLARE @Aplica_nCripter_ValidacioniCVV BIT = 1
		DECLARE @Aplica_nCripter_ValidacionCVV BIT = 1
		DECLARE @Aplica_nCripter_ValidacionCVV2 BIT = 1
		DECLARE @Aplica_ValidarCVDP BIT = 1
		DECLARE @Aplica_nCripter_ValidacionPIN BIT = 1
		DECLARE @Aplica_@TKNB4_19_4 BIT = 1


		DECLARE @Tipo_Producto VARCHAR(1200) = 'JSON01';

		--SELECT * FROM ValidadorCampos8583

		DECLARE @VC_nCripter_ValidacioniCVV VARCHAR(1200) = 'nCripter_Validacion_iCVV';
		DECLARE @VC_nCripter_ValidacionCVV VARCHAR(1200) = 'nCripter_ValidacionCVV';
		DECLARE @VC_nCripter_ValidacionCVV2 VARCHAR(1200) = 'nCripter_ValidacionCVV2';
		DECLARE @VC_ValidarCVDP VARCHAR(1200) = 'ValidarCVDP';
		DECLARE @VC_nCripter_ValidacionPIN VARCHAR(1200) = 'nCripter_ValidacionPIN';
		--DECLARE @VC_@TKNB4_19_4 VARCHAR(1200) = '@TKNB4_19-4';
		DECLARE @VC_@TKNB4_19_4 VARCHAR(1200) = 'nCripter_ValidacionARQC';


		--DECLARE @Formula_@TKNB4_19_4 VARCHAR(1200) = '''@TKNB4_8''==''4'' || ''@TKNB4_8''==''0'' || ''@TKNB4_8''==''9''';
		DECLARE @Formula_@TKNB4_19_4 VARCHAR(1200) = 'nCripter_ValidacionARQC';

		--select * from ValidadorCampos8583
		--where Campo in (
		--@VC_nCripter_Validacion_iCVV,
		--@VC_nCripter_ValidacionCVV,
		--@VC_nCripter_ValidacionCVV2,
		--@VC_ValidarCVDP,
		--@VC_nCripter_ValidacionPIN
		--)
		DECLARE @Nombre_VC_nCripter_ValidacioniCVV VARCHAR(1200) = 'Validación de iCVV';
		DECLARE @Nombre_VC_nCripter_ValidacionCVV VARCHAR(1200) = 'Validación de CVV';
		DECLARE @Nombre_VC_nCripter_ValidacionCVV2 VARCHAR(1200) = 'Validación de CVV2';
		DECLARE @Nombre_VC_ValidarCVDP VARCHAR(1200) = 'Validación de CVV Dinámico';
		DECLARE @Nombre_VC_nCripter_ValidacionPIN VARCHAR(1200) = 'Validación de PIN';
		DECLARE @Nombre_VC_@TKNB4_19_4 VARCHAR(1200) = 'Validacion de ARQC y Generacion ARQC';
		--DECLARE @Nombre_VC_@TKNB4_19_4 VARCHAR(1200) = 'Validación de Correcto ARQC';
		

		

		DECLARE @EventosChipContactless VARCHAR(1200) = 'T02004100MXN484,T02001700MXN484,T02014100MXN484,T02011700MXN484,T02304100MXN484,T02301700MXN484,T02264100MXN484,T02261700MXN484,T02MS4100MXN484,T02MS1700MXN484,T02VC4100MXN484,T02VC1700MXN484,T02094100MXN484,T02144100MXN484,T02091700MXN484,T02141700MXN484';
		DECLARE @EventosBanda VARCHAR(1200) = 'T02002700MXN484,T02012700MXN484,T02302700MXN484,T02005400MXN484,T02262700MXN484,T02MS2700MXN484,T02015400MXN484,T02VC2700MXN484,T02092700MXN484,T02142700MXN484';
		DECLARE @EventosCVV2 VARCHAR(1200) = 'T02001600MXN484,T02011600MXN484,T02261600MXN484,T02MS1600MXN484,T02VC1600MXN484,T02801600MXN484,T02091600MXN484,T02141600MXN484';
		DECLARE @EventosCVV2Dinamico VARCHAR(1200) = 'T02004000MXN484,T02VC4000MXN484,T02804000MXN484,T02094000MXN484,T02144000MXN484,T02204000MXN484,T02MS4000MXN484,T02DA4000MXN484';
		--DECLARE @EventosCVV2Dinamico VARCHAR(1200) = 'T02001600MXN484,T02011600MXN484,T02261600MXN484,T02MS1600MXN484,T02VC1600MXN484,T02801600MXN484,T02004000MXN484,T02VC4000MXN484,T02804000MXN484';
		DECLARE @EventosValidaPin VARCHAR(1200) = 'T02014100MXN484,T02012700MXN484,T02011700MXN484,T02011600MXN484,T02304100MXN484,T02302700MXN484,T02301700MXN484,T02015400MXN484';
		DECLARE @EventosValidaARQC VARCHAR(1200) = 'T02004100MXN484,T02001700MXN484,T02014100MXN484,T02011700MXN484,T02304100MXN484,T02301700MXN484,T02264100MXN484,T02261700MXN484,T02MS4100MXN484,T02MS1700MXN484,T02VC4100MXN484,T02VC1700MXN484,T02094100MXN484,T02144100MXN484,T02204100MXN484';
					

		DECLARE @PrefijoEventos VARCHAR(1200) = 'T02%';
		--DECLARE @SufijoEventosTran0200CVVDin VARCHAR(1200) = '%4000MXN484';
		--DECLARE @SufijoEventosTran0200CVVD2 VARCHAR(1200) = '%1600MXN484';

	--SELECT * FROM ValidadorCampos8583
	--WHERE ID_Evento IN (
	--	SELECT ID_Evento FROM Eventos
	--	WHERE ClaveEvento LIKE @PrefijoEventos
	--)
	

		IF(@Aplica_nCripter_ValidacioniCVV = 1)
		BEGIN
		IF OBJECT_ID('tempdb..#TempnCripter_ValidacioniCVV') IS NOT NULL
				BEGIN
					DROP TABLE #TempnCripter_ValidacioniCVV
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempnCripter_ValidacioniCVV 
					----SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE 
					--	--CodigoProceso LIKE '00%'
					--	--AND 
					--	ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					--AND ID_POSEntryMode IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	'05_'
					--	--,'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_',
					--	,'07_'
					--	)
					--)
					--SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempnCripter_ValidacioniCVV
					--	SELECT DISTINCT ev.ClaveEvento,* 
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@EventosChipContactless, ',') Even
					)

		
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempnCripter_ValidacioniCVV)
		--AND vc.Campo = @VC_nCripter_ValidacioniCVV
		--ORDER BY ev.Descripcion DESC
					
					--ASIGNACIÓN DE VALIDADOR DE CAMPOS 8583
			INSERT INTO dbo.ValidadorCampos8583 (ID_Evento,
                                                 esValidacionBase,
                                                 Nombre,
                                                 Campo,
                                                 ID_TipoElemento,
                                                 Formula,
                                                 CodigoError,
                                                 ID_ValidacionTrue,
                                                 ID_ValidacionFalse,
                                                 OrdenValidacion,
                                                 EsActiva,
                                                 Declinar,
                                                 PreRegla,
                                                 PostRegla)
				SELECT 
					Even.ID_Evento, -- ID_Evento - int
                    1, -- esValidacionBase - bit
                    @Nombre_VC_nCripter_ValidacioniCVV, -- Nombre - varchar(150)
                    @VC_nCripter_ValidacioniCVV, -- Campo - varchar(50)
                    7, -- ID_TipoElemento - int
                    @VC_nCripter_ValidacioniCVV, -- Formula - varchar(800)
                    '87', -- CodigoError - varchar(4)
                    0, -- ID_ValidacionTrue - bigint
                    0, -- ID_ValidacionFalse - bigint
                    1, -- OrdenValidacion - int
                    1, -- EsActiva - bit
                    0, -- Declinar - bit
                    1, -- PreRegla - bit
                    0 -- PostRegla - bit
				FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM ValidadorCampos8583
							WHERE 
							Campo = @VC_nCripter_ValidacioniCVV
							AND ID_Evento IN (SELECT ID_Evento FROM #TempnCripter_ValidacioniCVV)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempnCripter_ValidacioniCVV)

					) Even
					
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempnCripter_ValidacioniCVV)
		--AND vc.Campo = @VC_nCripter_ValidacioniCVV
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempnCripter_ValidacioniCVV') IS NOT NULL
				BEGIN
					DROP TABLE #TempnCripter_ValidacioniCVV
				END

		END

		IF(@Aplica_nCripter_ValidacionCVV = 1)
		BEGIN
		IF OBJECT_ID('tempdb..#TempnCripter_ValidacionCVV') IS NOT NULL
				BEGIN
					DROP TABLE #TempnCripter_ValidacionCVV
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempnCripter_ValidacionCVV 
					--SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE 
					--	--CodigoProceso LIKE '00%'
					--	--AND 
					--	ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					--AND ID_POSEntryMode IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	--'05_'
					--	--,'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_',
					--	--,'07_'
					--	'90_', '91_',
					--	'80_'
					--	)
					--)
					--AND ev.ClaveEvento NOT LIKE @SufijoEventosTran0200CVVD2
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@EventosBanda, ',') Even
					)

		
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempnCripter_ValidacionCVV)
		--AND vc.Campo = @VC_nCripter_ValidacionCVV
		--ORDER BY ev.Descripcion DESC
					
					--ASIGNACIÓN DE VALIDADOR DE CAMPOS 8583
			INSERT INTO dbo.ValidadorCampos8583 (ID_Evento,
                                                 esValidacionBase,
                                                 Nombre,
                                                 Campo,
                                                 ID_TipoElemento,
                                                 Formula,
                                                 CodigoError,
                                                 ID_ValidacionTrue,
                                                 ID_ValidacionFalse,
                                                 OrdenValidacion,
                                                 EsActiva,
                                                 Declinar,
                                                 PreRegla,
                                                 PostRegla)
				SELECT 
					Even.ID_Evento, -- ID_Evento - int
                    1, -- esValidacionBase - bit
                    @Nombre_VC_nCripter_ValidacionCVV, -- Nombre - varchar(150)
                    @VC_nCripter_ValidacionCVV, -- Campo - varchar(50)
                    7, -- ID_TipoElemento - int
                    @VC_nCripter_ValidacionCVV, -- Formula - varchar(800)
                    '87', -- CodigoError - varchar(4)
                    0, -- ID_ValidacionTrue - bigint
                    0, -- ID_ValidacionFalse - bigint
                    1, -- OrdenValidacion - int
                    1, -- EsActiva - bit
                    0, -- Declinar - bit
                    1, -- PreRegla - bit
                    0 -- PostRegla - bit
				FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM ValidadorCampos8583
							WHERE 
							Campo = @VC_nCripter_ValidacionCVV
							AND ID_Evento IN (SELECT ID_Evento FROM #TempnCripter_ValidacionCVV)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempnCripter_ValidacionCVV)

					) Even
					
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempnCripter_ValidacionCVV)
		--AND vc.Campo = @VC_nCripter_ValidacionCVV
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempnCripter_ValidacionCVV') IS NOT NULL
				BEGIN
					DROP TABLE #TempnCripter_ValidacionCVV
				END

		END

		IF(@Aplica_nCripter_ValidacionCVV2 = 1)
		BEGIN
		IF OBJECT_ID('tempdb..#TempnCripter_ValidacionCVV2') IS NOT NULL
				BEGIN
					DROP TABLE #TempnCripter_ValidacionCVV2
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempnCripter_ValidacionCVV2 
					----SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE 
					--	--CodigoProceso LIKE '00%'
					--	--AND 
					--	ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					--AND ID_POSEntryMode IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	--'05_'
					--	'00_', '01_', '02_', '10_', '81_', '09_', '21_'
					--	--,'07_'
					--	--'90_', '91_',
					--	--'80_'
					--	)
					--)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@EventosCVV2, ',') Even
					)

		
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempnCripter_ValidacionCVV2)
		--AND vc.Campo = @VC_nCripter_ValidacionCVV2
		--ORDER BY ev.Descripcion DESC
					
					--ASIGNACIÓN DE VALIDADOR DE CAMPOS 8583
			INSERT INTO dbo.ValidadorCampos8583 (ID_Evento,
                                                 esValidacionBase,
                                                 Nombre,
                                                 Campo,
                                                 ID_TipoElemento,
                                                 Formula,
                                                 CodigoError,
                                                 ID_ValidacionTrue,
                                                 ID_ValidacionFalse,
                                                 OrdenValidacion,
                                                 EsActiva,
                                                 Declinar,
                                                 PreRegla,
                                                 PostRegla)
				SELECT 
					Even.ID_Evento, -- ID_Evento - int
                    1, -- esValidacionBase - bit
                    @Nombre_VC_nCripter_ValidacionCVV2, -- Nombre - varchar(150)
                    @VC_nCripter_ValidacionCVV2, -- Campo - varchar(50)
                    7, -- ID_TipoElemento - int
                    @VC_nCripter_ValidacionCVV2, -- Formula - varchar(800)
                    '87', -- CodigoError - varchar(4)
                    0, -- ID_ValidacionTrue - bigint
                    0, -- ID_ValidacionFalse - bigint
                    1, -- OrdenValidacion - int
                    1, -- EsActiva - bit
                    0, -- Declinar - bit
                    1, -- PreRegla - bit
                    0 -- PostRegla - bit
				FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM ValidadorCampos8583
							WHERE 
							Campo = @VC_nCripter_ValidacionCVV2
							AND ID_Evento IN (SELECT ID_Evento FROM #TempnCripter_ValidacionCVV2)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempnCripter_ValidacionCVV2)

					) Even
					
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempnCripter_ValidacionCVV2)
		--AND vc.Campo = @VC_nCripter_ValidacionCVV2
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempnCripter_ValidacionCVV2') IS NOT NULL
				BEGIN
					DROP TABLE #TempnCripter_ValidacionCVV2
				END

		END

		IF(@Aplica_ValidarCVDP = 1)
		BEGIN
		IF OBJECT_ID('tempdb..#TempValidarCVDP') IS NOT NULL
				BEGIN
					DROP TABLE #TempValidarCVDP
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempValidarCVDP 
					----SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE 
					--	--CodigoProceso LIKE '00%'
					--	--AND 
					--	ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					--AND ID_POSEntryMode IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	--'05_'
					--	'00_', '01_', '02_', '10_', '81_', '09_', '21_'
					--	--,'07_'
					--	--'90_', '91_',
					--	--'80_'
					--	)
					--)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@EventosCVV2Dinamico, ',') Even
					)
		
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempValidarCVDP)
		--AND vc.Campo = @VC_ValidarCVDP
		--ORDER BY ev.Descripcion DESC
					
					--ASIGNACIÓN DE VALIDADOR DE CAMPOS 8583
			INSERT INTO dbo.ValidadorCampos8583 (ID_Evento,
                                                 esValidacionBase,
                                                 Nombre,
                                                 Campo,
                                                 ID_TipoElemento,
                                                 Formula,
                                                 CodigoError,
                                                 ID_ValidacionTrue,
                                                 ID_ValidacionFalse,
                                                 OrdenValidacion,
                                                 EsActiva,
                                                 Declinar,
                                                 PreRegla,
                                                 PostRegla)
				SELECT 
					Even.ID_Evento, -- ID_Evento - int
                    1, -- esValidacionBase - bit
                    @Nombre_VC_ValidarCVDP, -- Nombre - varchar(150)
                    @VC_ValidarCVDP, -- Campo - varchar(50)
                    7, -- ID_TipoElemento - int
                    @VC_ValidarCVDP, -- Formula - varchar(800)
                    '87', -- CodigoError - varchar(4)
                    0, -- ID_ValidacionTrue - bigint
                    0, -- ID_ValidacionFalse - bigint
                    1, -- OrdenValidacion - int
                    1, -- EsActiva - bit
                    0, -- Declinar - bit
                    1, -- PreRegla - bit
                    0 -- PostRegla - bit
				FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM ValidadorCampos8583
							WHERE 
							Campo = @VC_ValidarCVDP
							AND ID_Evento IN (SELECT ID_Evento FROM #TempValidarCVDP)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempValidarCVDP)

					) Even
					
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempValidarCVDP)
		--AND vc.Campo = @VC_ValidarCVDP
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempValidarCVDP') IS NOT NULL
				BEGIN
					DROP TABLE #TempValidarCVDP
				END

		END

		IF(@Aplica_nCripter_ValidacionPIN = 1)
		BEGIN
		IF OBJECT_ID('tempdb..#TempnCripter_ValidacionPIN') IS NOT NULL
				BEGIN
					DROP TABLE #TempnCripter_ValidacionPIN
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempnCripter_ValidacionPIN 
					----SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE 
					--	(CodigoProceso LIKE '01%' OR CodigoProceso LIKE '31%')
					--	AND 
					--	ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					--AND ID_POSEntryMode NOT IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	--'05_'
					--	--'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_'
					--	--,'07_'
					--	--'90_', '91_',
					--	'80_'
					--	)
					--)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@EventosValidaPin, ',') Even
					)
		
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempnCripter_ValidacionPIN)
		--AND vc.Campo = @VC_nCripter_ValidacionPIN
		--ORDER BY ev.Descripcion DESC
					
					--ASIGNACIÓN DE VALIDADOR DE CAMPOS 8583
			INSERT INTO dbo.ValidadorCampos8583 (ID_Evento,
                                                 esValidacionBase,
                                                 Nombre,
                                                 Campo,
                                                 ID_TipoElemento,
                                                 Formula,
                                                 CodigoError,
                                                 ID_ValidacionTrue,
                                                 ID_ValidacionFalse,
                                                 OrdenValidacion,
                                                 EsActiva,
                                                 Declinar,
                                                 PreRegla,
                                                 PostRegla)
				SELECT 
					Even.ID_Evento, -- ID_Evento - int
                    1, -- esValidacionBase - bit
                    @Nombre_VC_nCripter_ValidacionPIN, -- Nombre - varchar(150)
                    @VC_nCripter_ValidacionPIN, -- Campo - varchar(50)
                    7, -- ID_TipoElemento - int
                    @VC_nCripter_ValidacionPIN, -- Formula - varchar(800)
                    '55', -- CodigoError - varchar(4)
                    0, -- ID_ValidacionTrue - bigint
                    0, -- ID_ValidacionFalse - bigint
                    2, -- OrdenValidacion - int
                    1, -- EsActiva - bit
                    0, -- Declinar - bit
                    0, -- PreRegla - bit
                    1 -- PostRegla - bit
				FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM ValidadorCampos8583
							WHERE 
							Campo = @VC_nCripter_ValidacionPIN
							AND ID_Evento IN (SELECT ID_Evento FROM #TempnCripter_ValidacionPIN)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempnCripter_ValidacionPIN)

					) Even
					
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempnCripter_ValidacionPIN)
		--AND vc.Campo = @VC_nCripter_ValidacionPIN
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempnCripter_ValidacionPIN') IS NOT NULL
				BEGIN
					DROP TABLE #TempnCripter_ValidacionPIN
				END

		END

		IF(@Aplica_@TKNB4_19_4 = 1)
		BEGIN
		IF OBJECT_ID('tempdb..#Temp@TKNB4_19_4') IS NOT NULL
				BEGIN
					DROP TABLE #Temp@TKNB4_19_4
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #Temp@TKNB4_19_4 
					----SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE 
					--	(CodigoProceso LIKE '01%' OR CodigoProceso LIKE '31%')
					--	AND 
					--	ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					--AND ID_POSEntryMode NOT IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	--'05_'
					--	--'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_'
					--	--,'07_'
					--	--'90_', '91_',
					--	'80_'
					--	)
					--)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@EventosValidaARQC, ',') Even
					)
		
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #Temp@TKNB4_19_4)
		--AND vc.Campo = @VC_@TKNB4_19_4
		--ORDER BY ev.Descripcion DESC
					
					--ASIGNACIÓN DE VALIDADOR DE CAMPOS 8583
			INSERT INTO dbo.ValidadorCampos8583 (ID_Evento,
                                                 esValidacionBase,
                                                 Nombre,
                                                 Campo,
                                                 ID_TipoElemento,
                                                 Formula,
                                                 CodigoError,
                                                 ID_ValidacionTrue,
                                                 ID_ValidacionFalse,
                                                 OrdenValidacion,
                                                 EsActiva,
                                                 Declinar,
                                                 PreRegla,
                                                 PostRegla)
				SELECT 
					Even.ID_Evento, -- ID_Evento - int
                    1, -- esValidacionBase - bit
                    @Nombre_VC_@TKNB4_19_4, -- Nombre - varchar(150)
                    @VC_@TKNB4_19_4, -- Campo - varchar(50)
                    4, -- ID_TipoElemento - int
                    @Formula_@TKNB4_19_4, -- Formula - varchar(800)
                    '05', -- CodigoError - varchar(4)
                    0, -- ID_ValidacionTrue - bigint
                    0, -- ID_ValidacionFalse - bigint
                    1, -- OrdenValidacion - int
                    1, -- EsActiva - bit
                    0, -- Declinar - bit
                    1, -- PreRegla - bit
                    0 -- PostRegla - bit
				FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM ValidadorCampos8583
							WHERE 
							Campo = @VC_@TKNB4_19_4
							AND ID_Evento IN (SELECT ID_Evento FROM #Temp@TKNB4_19_4)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #Temp@TKNB4_19_4)

					) Even
					
		--SELECT ev.ClaveEvento, ev.Descripcion, vc.Campo, * FROM ValidadorCampos8583 vc
		--INNER JOIN Eventos ev ON ev.ID_Evento = vc.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #Temp@TKNB4_19_4)
		--AND vc.Campo = @VC_@TKNB4_19_4
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#Temp@TKNB4_19_4') IS NOT NULL
				BEGIN
					DROP TABLE #Temp@TKNB4_19_4
				END

		END

	--UPDATE ValidadorCampos8583 
	--SET EsActiva = 1
	--WHERE ID_Evento IN (
	--	SELECT ID_Evento FROM Eventos
	--	WHERE ClaveEvento LIKE @PrefijoEventos

	--)

	--SELECT * FROM ValidadorCampos8583
	--WHERE ID_Evento IN (
	--	SELECT ID_Evento FROM Eventos
	--	WHERE ClaveEvento LIKE @PrefijoEventos
	--)

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN