USE [Autorizador]
go

BEGIN TRAN

	
	DECLARE @commit BIT = 1

	DECLARE @IdColectivaEmisor INT,
			@ClaveAfiliacion VARCHAR(20)


	DECLARE @ClaveTipoProducto VARCHAR (10) = 'JSON01';

	DECLARE @ClaveTipoMensajeOnline VARCHAR (10) = '0200';
	DECLARE @ClaveTipoMensajeStandin VARCHAR (10) = '0220';

	DECLARE @CodigosProceso_DevolucionSbcTddGcCHIP VARCHAR (200) ='20%'
	DECLARE @CodigosProceso_CancelacionSbcTddGcCHIP VARCHAR (200) ='02%'
	DECLARE @CodigosProceso_FastFundSbcTddGcCHIP VARCHAR (200) ='26%'
	DECLARE @CodigosProceso_VerificacionSbcTddGcCHIP VARCHAR (200) ='81%'
	DECLARE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV2 VARCHAR (200) ='80%'

	DECLARE @ID_TipoProducto INT;
	SET @ID_TipoProducto = (SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @ClaveTipoProducto)

	DECLARE @Grupos_MA TABLE 
	(
		ID INT IDENTITY(1,1),
		IdGrupoMA INT 
	)
	
	
	DECLARE @PERTENENCIA_TIPO TABLE 
	(
		IdPertenenciaTipo INT,
		IdColectivaEmisor BIGINT,
		IdGrupoMA INT,
		IdGrupoCuenta INT,
		TipoMensaje  VARCHAR(50),
		ClaveAfiliacion VARCHAR(20),
		CodigoProceso VARCHAR(50),
		POSEM VARCHAR(5),
		EsActiva BIT,
		Descripcion VARCHAR(150),
		IdEstatusOperacion INT,
		IdEstatusPostOperacion INT,
		ClavePertenenciaTipo VARCHAR(50)  
	)

	
	DECLARE @PERTENENCIAS_INSERTADAS TABLE 
	(
		IdColectivaEmisor BIGINT,
		IdGrupoMA INT,
		IdGrupoCuenta INT,
		TipoMensaje  VARCHAR(50),
		ClaveAfiliacion VARCHAR(20),
		CodigoProceso VARCHAR(50),
		POSEM VARCHAR(5),
		EsActiva BIT,
		Descripcion VARCHAR(150),
		IdEstatusOperacion INT,
		IdEstatusPostOperacion INT,
		ClavePertenenciaTipo VARCHAR(50)  
	)
		
	DECLARE @NuevasPertenencias TABLE 
	(
		IdProducto INT,
		IdPertenencia BIGINT,
		Activa BIT 
	)

	DECLARE @Pertenencias_PertenenciasTipo TABLE 
	(
		IdPertenencia BIGINT,
		IdPertenenciaTipo BIGINT 
	)

	DECLARE @Pertenencias_Eventos TABLE 
	(
		IdPertenencia BIGINT,
		IdEvento INT,
		Activo BIT 
	)
	

	SELECT	
		@IdColectivaEmisor = c.ID_Colectiva
	FROM	
		Colectivas c WITH (NOLOCK)
	WHERE	
		c.ID_TipoColectiva = 
		(
			SELECT 
				tc.ID_TipoColectiva 
			FROM 
				TipoColectiva tc WITH (NOLOCK) 
			WHERE 
				tc.ClaveTipoColectiva = 'EMI'
		)


	SELECT
		TOP 1 @ClaveAfiliacion = _vi.Formula
	FROM		
		ValoresISO8583 _vi WITH (NOLOCK)
		INNER JOIN PlugIns _pi WITH (NOLOCK)
			ON _vi.ID_PlugIn = _pi.ID_Plugin
	WHERE
		_vi.Nombre = '@afiliacion'


----PERTENENCIAS AGRUPADAS
--SELECT COUNT(*) AS NumeroPertenencias, pe.ID_GrupoCuenta, po.Descripcion, po.Clave, po.ID_Producto, tp.ClaveTipoProducto, tp.Descripcion  
--FROM Pertenencia pe
--INNER JOIN Producto po ON po.ID_GrupoCuenta = pe.ID_GrupoCuenta
--INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = po.ID_TipoProducto
--WHERE tp.ClaveTipoProducto = @ClaveTipoProducto
--GROUP BY pe.ID_GrupoCuenta, po.Descripcion, po.Clave, po.ID_Producto, tp.ClaveTipoProducto, tp.Descripcion

----PERTENENCIAS POR TIPO DE PRODUCTO
--SELECT ev.ClaveEvento, ev.Descripcion, p.CodigoProceso, p.POSEM, p.TipoMensaje, * FROM Pertenencia p
--INNER JOIN PertenenciaEventos pe ON pe.ID_Pertenencia = P.ID_Pertenencia
--INNER JOIN Eventos ev ON ev.ID_Evento = pe.ID_Evento
--WHERE ID_GrupoCuenta IN (
--	SELECT po.ID_GrupoCuenta FROM Producto po
--	INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = po.ID_TipoProducto
--	WHERE ClaveTipoProducto = @ClaveTipoProducto
--)

--  --PERTENENCIAS DUPLICADAS

--  --PERTENENCIAS DUPLICADAS
--SELECT 'PERTENENCIAS DUPLICADAS', pt.CodigoProceso, pt.POSEM, pt.TipoMensaje, pt.ID_EstatusOperacion, pt.ID_EstatusPostOperacion, pt.ID_GrupoCuenta, pt.ID_GrupoMA, COUNT(*)
--FROM ProductoPertenencias tppt
--INNER JOIN Pertenencia pt ON pt.ID_Pertenencia = tppt.ID_Pertenencia
--INNER JOIN PertenenciaEventos pte ON pte.ID_Pertenencia =  pt.ID_Pertenencia
--INNER JOIN Eventos ev ON ev.ID_Evento = pte.ID_Evento
--WHERE ID_GrupoCuenta IN (
--	SELECT po.ID_GrupoCuenta FROM Producto po
--	INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = po.ID_TipoProducto
--	WHERE ClaveTipoProducto = @ClaveTipoProducto
--)
--GROUP BY pt.CodigoProceso, pt.POSEM, pt.TipoMensaje, pt.ID_EstatusOperacion, pt.ID_EstatusPostOperacion, pt.ID_GrupoCuenta, pt.ID_GrupoMA
--HAVING COUNT(*) > 1 



--/***********************************************************/
----ELIMINACIÓN DE PERTENENCIAS TIPO Y PERTENENCIAS TIPO EVENTO ANTERIORES
--/***********************************************************/

--DELETE FROM ProductoPertenencias
----SELECT * FROM ProductoPertenencias
--WHERE ID_Pertenencia IN (
--	SELECT ID_Pertenencia FROM Pertenencia
--	WHERE ID_GrupoCuenta IN (SELECT ID_GrupoCuenta FROM Producto WHERE ID_TipoProducto = (SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @ClaveTipoProducto))
--	AND (--Clave LIKE 'P0%' OR
--	CodigoProceso IN(
--	SELECT CodigoProceso FROM CodigoProceso WHERE --CodigoProceso LIKE @CodigosProceso_POS OR 
--																	--CodigoProceso LIKE @CodigosProceso_ATMCHIP OR
--																	--CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_FastFundSbcTddGcCHIP OR
--																	--CodigoProceso LIKE @CodigosProceso_EnvioDineroMS OR
--																	CodigoProceso LIKE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV2 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance14 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashBack OR
--																	CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCHIP 												
--															AND ID_TipoMensaje IN (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje IN (@ClaveTipoMensajeOnline, @ClaveTipoMensajeStandin))
--															)
--	)
--	AND ClavePertenenciaTipo NOT LIKE 'P%'
--)

--DELETE FROM PertenenciaEventos
----SELECT * FROM PertenenciaEventos
--WHERE ID_Pertenencia IN (
--	SELECT ID_Pertenencia FROM Pertenencia
--	WHERE ID_GrupoCuenta IN (SELECT ID_GrupoCuenta FROM Producto WHERE ID_TipoProducto = (SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @ClaveTipoProducto))
--	AND (--Clave LIKE 'P0%'
--	CodigoProceso IN(
--	SELECT CodigoProceso FROM CodigoProceso WHERE --CodigoProceso LIKE @CodigosProceso_POS OR 
--															--CodigoProceso LIKE @CodigosProceso_ATMCHIP OR
--																	--CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_FastFundSbcTddGcCHIP OR
--																	--CodigoProceso LIKE @CodigosProceso_EnvioDineroMS OR
--																	CodigoProceso LIKE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV2 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance14 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashBack OR
--																	CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCHIP 													
--															AND ID_TipoMensaje IN (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje IN (@ClaveTipoMensajeOnline, @ClaveTipoMensajeStandin))
--	)
--)
--AND ClavePertenenciaTipo NOT LIKE 'P%'
--)


--DELETE FROM Pertenencia
----SELECT * FROM Pertenencia
--WHERE ID_GrupoCuenta IN (SELECT ID_GrupoCuenta FROM Producto WHERE ID_TipoProducto = (SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @ClaveTipoProducto))
--AND (--Clave LIKE 'P0%'
--	CodigoProceso IN(
--	SELECT CodigoProceso FROM CodigoProceso WHERE --CodigoProceso LIKE @CodigosProceso_POS OR 
--																	--CodigoProceso LIKE @CodigosProceso_ATMCHIP OR
--																	--CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_FastFundSbcTddGcCHIP OR
--																	--CodigoProceso LIKE @CodigosProceso_EnvioDineroMS OR
--																	CodigoProceso LIKE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV2 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance14 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashBack OR
--																	CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCHIP
--														AND ID_TipoMensaje IN (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje IN (@ClaveTipoMensajeOnline, @ClaveTipoMensajeStandin))
																	
--	)
--)
--AND ClavePertenenciaTipo NOT LIKE 'P%'


	
	--/////PERTENENCIAS
						--Obtención de Pertenencias Tipo
						INSERT INTO 
							@PERTENENCIA_TIPO
						SELECT		
							pt.ID_PertenenciaTipo,
							@IdColectivaEmisor,
							pgma.ID_GrupoMA,
							p.ID_GrupoCuenta,
							tm.ClaveTipoMensaje,
							@ClaveAfiliacion,
							cp.CodigoProceso,
							pem.Clave,
							1,
							pt.Descripcion,
							pt.ID_EstatusOperacion,
							pt.ID_EstatusPostOperacion,
							ISNULL(pt.Clave, '')
						FROM		
							TipoProductoPertenenciaTipo tppt WITH (NOLOCK)
							INNER JOIN Producto p WITH (NOLOCK)
								ON tppt.ID_TipoProducto = p.ID_TipoProducto
							INNER JOIN ProductoGrupoMA pgma WITH (NOLOCK)
								ON p.ID_Producto = pgma.ID_Producto
							INNER JOIN PertenenciaTipo pt WITH (NOLOCK)
								ON tppt.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
							INNER JOIN TipoProducto tp WITH (NOLOCK)
								ON pt.ClaveTipoProducto = tp.ClaveTipoProducto
							INNER JOIN CodigoProceso cp WITH (NOLOCK)
								ON pt.ID_CodigoProceso = cp.ID_CodigoProceso
							INNER JOIN TipoMensajes tm WITH (NOLOCK)
								ON cp.ID_TipoMensaje = tm.ID_TipoMensaje
							LEFT JOIN POSEntryMode pem WITH (NOLOCK)
								ON pt.ID_POSEntryMode = pem.ID_POSEntryMode
						WHERE
							tppt.ID_TipoProducto = @ID_TipoProducto
							--AND p.ID_Producto = @IdNuevoProducto

							--SELECT * FROM @PERTENENCIA_TIPO
				
						--IF EXISTS 
						--(
						--	SELECT 
						--		ClaveAfiliacion, 
						--		CodigoProceso, 
						--		IdColectivaEmisor, 
						--		IdGrupoCuenta, 
						--		IdGrupoMA, 
						--		POSEM, 
						--		TipoMensaje, 
						--		IdEstatusOperacion, 
						--		IdEstatusPostOperacion, 
						--		COUNT(*)
						--	FROM 
						--		@PERTENENCIA_TIPO
						--	GROUP BY 
						--		ClaveAfiliacion, 
						--		CodigoProceso, 
						--		IdColectivaEmisor, 
						--		IdGrupoCuenta, 
						--		IdGrupoMA,
						--		POSEM, 
						--		TipoMensaje, 
						--		IdEstatusOperacion, 
						--		IdEstatusPostOperacion
						--	HAVING 
						--		COUNT(*) > 1 
						--)
						--BEGIN
						--	--SET @IdNuevoProducto = -1
						--	 RAISERROR('Error de Configuración.<br/><br/>Pertenencias Tipo duplicadas.', 16, 1);
						--	 RETURN;
						--END
						--ELSE
						--BEGIN
							--Creación de Pertenencias
						
							INSERT INTO 
								@PERTENENCIAS_INSERTADAS 
							
							SELECT	
								pt.IdColectivaEmisor,
								pt.IdGrupoMA,
								pt.IdGrupoCuenta,
								pt.TipoMensaje,
								pt.ClaveAfiliacion,
								pt.CodigoProceso,
								pt.POSEM,
								pt.EsActiva,
								pt.Descripcion,
								pt.IdEstatusOperacion,
								pt.IdEstatusPostOperacion,
								pt.ClavePertenenciaTipo
							FROM	
								@PERTENENCIA_TIPO pt
								LEFT JOIN Pertenencia p ON pt.IdGrupoMA = p.ID_GrupoMA
									AND pt.IdGrupoCuenta = p.ID_GrupoCuenta
									AND pt.TipoMensaje = p.TipoMensaje
									AND	pt.CodigoProceso = p.CodigoProceso
									AND	
									(
										pt.POSEM IS NULL
										OR pt.POSEM = p.POSEM
									)
									--AND pt.Descripcion = p.Descripcion
									AND	
									(
										pt.IdEstatusOperacion IS NULL
										OR pt.IdEstatusOperacion = p.ID_EstatusOperacion
									)
									AND
									(
										pt.IdEstatusOperacion IS NULL
										OR pt.IdEstatusPostOperacion = p.ID_EstatusPostOperacion
									)
								WHERE p.CodigoProceso IS NULL

							--SELECT *
							--FROM @PERTENENCIAS_INSERTADAS 

							INSERT INTO 
								Pertenencia 
								(
									ID_ColectivaEmisor,
									ID_GrupoMA,
									ID_GrupoCuenta,
									TipoMensaje,
									ClaveAfiliacion,
									CodigoProceso,
									POSEM,
									EsActiva,
									Descripcion,
									ID_EstatusOperacion,
									ID_EstatusPostOperacion,
									ClavePertenenciaTipo
								)
							--SELECT *
							--FROM @PERTENENCIAS_INSERTADAS 
	
							--Se relacionan las pertenencias al producto
							INSERT INTO 
								@NuevasPertenencias 
							SELECT	
								po.ID_Producto,
								p.ID_Pertenencia,
								1
							FROM	
								Pertenencia p WITH (NOLOCK)
								INNER JOIN @PERTENENCIAS_INSERTADAS pt ON pt.IdGrupoMA = p.ID_GrupoMA
									AND pt.IdGrupoCuenta = p.ID_GrupoCuenta
									AND pt.TipoMensaje = p.TipoMensaje
									AND	pt.CodigoProceso = p.CodigoProceso
									AND	
									(
										pt.POSEM IS NULL
										OR pt.POSEM = p.POSEM
									)
									AND pt.Descripcion = p.Descripcion
									AND	
									(
										pt.IdEstatusOperacion IS NULL
										OR pt.IdEstatusOperacion = p.ID_EstatusOperacion
									)
									AND
									(
										pt.IdEstatusOperacion IS NULL
										OR pt.IdEstatusPostOperacion = p.ID_EstatusPostOperacion
									)
								INNER JOIN Producto po ON po.ID_GrupoCuenta = pt.IdGrupoCuenta
							
							--SELECT 
							--	* 
							--FROM 
							--	@NuevasPertenencias

				
							INSERT INTO 
								ProductoPertenencias
							SELECT 
								* 
							FROM 
								@NuevasPertenencias
				
							--Se relacionan las pertenencias a los eventos
							INSERT INTO 
								@Pertenencias_PertenenciasTipo
							SELECT
								p.ID_Pertenencia,
								pti.IdPertenenciaTipo
							FROM
								ProductoPertenencias pp WITH (NOLOCK)
								INNER JOIN Pertenencia p WITH (NOLOCK)
									ON pp.ID_Pertenencia = p.ID_Pertenencia
								INNER JOIN @PERTENENCIAS_INSERTADAS pt
									ON pt.IdGrupoMA = p.ID_GrupoMA
									AND pt.IdGrupoCuenta = p.ID_GrupoCuenta
									AND pt.TipoMensaje = p.TipoMensaje
									AND	pt.CodigoProceso = p.CodigoProceso
									AND	
									(
										pt.POSEM IS NULL
										OR pt.POSEM = p.POSEM
									)
									AND pt.Descripcion = p.Descripcion
									AND	
									(
										pt.IdEstatusOperacion IS NULL
										OR pt.IdEstatusOperacion = p.ID_EstatusOperacion
									)
									AND
									(
										pt.IdEstatusOperacion IS NULL
										OR pt.IdEstatusPostOperacion = p.ID_EstatusPostOperacion
									)
								INNER JOIN @PERTENENCIA_TIPO pti
									ON pt.IdGrupoMA = pti.IDGrupoMA
									AND pt.IdGrupoCuenta = pti.IDGrupoCuenta
									AND pt.TipoMensaje = pti.TipoMensaje
									AND	pt.CodigoProceso = pti.CodigoProceso
									AND	
									(
										pt.POSEM IS NULL
										OR pt.POSEM = pti.POSEM
									)
									AND pt.Descripcion = pti.Descripcion
									AND	
									(
										pt.IdEstatusOperacion IS NULL
										OR pt.IdEstatusOperacion = pti.IdEstatusOperacion
									)
									AND
									(
										pt.IdEstatusOperacion IS NULL
										OR pt.IdEstatusPostOperacion = pti.IdEstatusPostOperacion
									)
								
							--WHERE
							--	pp.ID_Producto = @IdNuevoProducto


							INSERT INTO 
								@Pertenencias_Eventos
							SELECT
								ppt.IdPertenencia,
								pte.ID_Evento,
								pte.Activo
							FROM
								@Pertenencias_PertenenciasTipo ppt
								INNER JOIN PertenenciaTipoEvento pte WITH (NOLOCK)
									ON ppt.IdPertenenciaTipo = pte.ID_PertenenciaTipo

							--SELECT * FROM @Pertenencias_Eventos

							INSERT INTO 
								PertenenciaEventos
							SELECT 
								* 
							FROM 
								@Pertenencias_Eventos   
								

								
----PERTENENCIAS AGRUPADAS
--SELECT COUNT(*) AS NumeroPertenencias, pe.ID_GrupoCuenta, po.Descripcion, po.Clave, po.ID_Producto, tp.ClaveTipoProducto, tp.Descripcion  
--FROM Pertenencia pe
--INNER JOIN Producto po ON po.ID_GrupoCuenta = pe.ID_GrupoCuenta
--INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = po.ID_TipoProducto
--WHERE tp.ClaveTipoProducto = @ClaveTipoProducto
--GROUP BY pe.ID_GrupoCuenta, po.Descripcion, po.Clave, po.ID_Producto, tp.ClaveTipoProducto, tp.Descripcion

----PERTENENCIAS POR TIPO DE PRODUCTO
--SELECT ev.ClaveEvento, ev.Descripcion, p.CodigoProceso, p.POSEM, p.TipoMensaje, * FROM Pertenencia p
--INNER JOIN PertenenciaEventos pe ON pe.ID_Pertenencia = P.ID_Pertenencia
--INNER JOIN Eventos ev ON ev.ID_Evento = pe.ID_Evento
--WHERE ID_GrupoCuenta IN (
--	SELECT po.ID_GrupoCuenta FROM Producto po
--	INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = po.ID_TipoProducto
--	WHERE ClaveTipoProducto = @ClaveTipoProducto
--)


-- --PERTENENCIAS DUPLICADAS
--SELECT 'PERTENENCIAS DUPLICADAS', pt.CodigoProceso, pt.POSEM, pt.TipoMensaje, pt.ID_EstatusOperacion, pt.ID_EstatusPostOperacion, pt.ID_GrupoCuenta, pt.ID_GrupoMA, COUNT(*)
--FROM ProductoPertenencias tppt
--INNER JOIN Pertenencia pt ON pt.ID_Pertenencia = tppt.ID_Pertenencia
--INNER JOIN PertenenciaEventos pte ON pte.ID_Pertenencia =  pt.ID_Pertenencia
--INNER JOIN Eventos ev ON ev.ID_Evento = pte.ID_Evento
--WHERE ID_GrupoCuenta IN (
--	SELECT po.ID_GrupoCuenta FROM Producto po
--	INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = po.ID_TipoProducto
--	WHERE ClaveTipoProducto = @ClaveTipoProducto
--)
--GROUP BY pt.CodigoProceso, pt.POSEM, pt.TipoMensaje, pt.ID_EstatusOperacion, pt.ID_EstatusPostOperacion, pt.ID_GrupoCuenta, pt.ID_GrupoMA
--HAVING COUNT(*) > 1 

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN