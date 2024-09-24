USE [Autorizador]
BEGIN TRAN

	DECLARE @commit BIT = 1

	--select * from Eventos
	--where ClaveEvento like 'T18%'
		
		DECLARE @AplicaReglaValidaMedioAcceso BIT = 1
		DECLARE @AplicaReglaMaxCompra BIT = 1
		DECLARE @AplicaReglaMaxRetiroATM BIT = 1
		DECLARE @AplicaReglaValidaNIPPorRechazosDeOperaciones BIT = 0
		DECLARE @AplicaRegla_ValidaTokensPOS BIT = 0
		DECLARE @AplicaRegla_ValidaTokensATM BIT = 0

		--SELECT * FROM TipoProducto

		--SELECT * FROM Eventos

		DECLARE @Tipo_Producto VARCHAR(1200) = 'JSON01';

		DECLARE @SPsReglaValidaMedioAcceso VARCHAR(1200) = 'regla_ValidaMedioAcceso';
		DECLARE @SPsReglasMaxCompra VARCHAR(1200) = 'regla_MontosMaximosCompra';
		DECLARE @SPsReglasMaxRetiroATM VARCHAR(1200) = 'regla_ValidaMontoMaximoRetiroATM';
		DECLARE @SPsReglasValidaNIPPorRechazosDeOperaciones VARCHAR(1200) = 'regla_ValidaNIPPorRechazosDeOperaciones';
		DECLARE @SPsReglas_ValidaTokensPOS VARCHAR(1200) = 'regla_ValidaTokensPOS';
		DECLARE @SPsReglas_ValidaTokensATM VARCHAR(1200) = 'regla_ValidaTokensATM';

		DECLARE @ClaveEventosMaxCompra VARCHAR(1200) = 'T02004100MXN484,T02001700MXN484,T02001600MXN484,T02004000MXN484,T02005400MXN484,T02801600MXN484,T02804000MXN484';
		DECLARE @ClaveEventosMaxRetiroATM VARCHAR(1200) = 'T02014100MXN484,T02012700MXN484,T02011700MXN484,T02011600MXN484,T02304100MXN484,T02302700MXN484,T02301700MXN484,T02015400MXN484';
		DECLARE @ClaveEventosValidaNIP VARCHAR(1200) = 'T02014100MXN484,T02012700MXN484,T02011700MXN484,T02011600MXN484,T02304100MXN484,T02302700MXN484,T02301700MXN484,T02015400MXN484';
		
		--tener que agregar los de Valida Medio Acceso
		DECLARE @ClaveEventosValidaTokensPOS VARCHAR(1200) ='T02261503MXN484,T02MS1503MXN484,T02201500MXN484,T02201503MXN484,T02DA1500MXN484,T02DA1503MXN484,T02VC0003MXN484,T02204100MXN484,T02202700MXN484,T02201700MXN484,T02DA4100MXN484,T02DA2700MXN484,T02DA1700MXN484,T02201600MXN484,T02DA1600MXN484,T02002703MXN484,T02001703MXN484,T02001603MXN484,T02004003MXN484,T02005403MXN484,T02204103MXN484,T02202703MXN484,T02201703MXN484,T02DA4103MXN484,T02DA2703MXN484,T02DA1703MXN484,T02264103MXN484,T02262703MXN484,T02261703MXN484,T02MS4103MXN484,T02MS2703MXN484,T02MS1703MXN484,T02DA1603MXN484,T02261603MXN484,T02MS1603MXN484,T02VC4103MXN484,T02VC2703MXN484,T02VC1703MXN484,T02VC1603MXN484,T02VC4003MXN484,T02801603MXN484,T02804003MXN484,T02004103MXN484';
		DECLARE @ClaveEventosValidaTokensATM VARCHAR(1200) = 'T02014100MXN484,T02012700MXN484,T02011700MXN484,T02011600MXN484,T02304100MXN484,T02302700MXN484,T02301700MXN484,T02015400MXN484,T02014103MXN484,T02012703MXN484,T02011703MXN484,T02011603MXN484,T02304103MXN484,T02302703MXN484,T02301703MXN484,T02015403MXN484';		

		DECLARE @PrefijoEventosTran VARCHAR(1200) = 'T02%';
		DECLARE @SufijoEventosTran0200 VARCHAR(1200) = '%00MXN484';

		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * 
		--FROM Eventos ev
		--INNER JOIN EventosReglas er ON er.ID_Evento = ev.ID_Evento
		--INNER JOIN Reglas re ON re.ID_Regla = er.ID_Regla
		--WHERE ClaveEvento LIKE @PrefijoEventosTran

		IF(@AplicaReglaMaxCompra = 1)
		BEGIN
		--REGLA DE COMPRAS
		IF OBJECT_ID('tempdb..#TempEventoCompra') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventoCompra
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempEventoCompra 
					--SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE CodigoProceso LIKE '00%'
					--	AND ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					--AND ID_POSEntryMode IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	'05_' --Chip
					--	,'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_', --Ecommerce
					--	'07_' --Contactless
					--	)
					--)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@ClaveEventosMaxCompra, ',') Even
					)

		
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventoCompra)
		--AND re.StoreProcedure = @SPsReglasMaxCompra
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO dbo.EventosReglas (ID_Evento, ID_Regla, EsActiva)
			SELECT *, 1 FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventosReglas
							WHERE 
							ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglasMaxCompra)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempEventoCompra)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempEventoCompra)

					) Eventos,
					(
						SELECT ID_Regla FROM Reglas
						WHERE ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglasMaxCompra )
					) Reglas
					
					
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventoCompra)
		--AND re.StoreProcedure = @SPsReglasMaxCompra
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempEventoCompra') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventoCompra
				END

		END

		IF(@AplicaReglaMaxRetiroATM = 1)
		BEGIN
--REGLA DE RETIROS ATM
		IF OBJECT_ID('tempdb..#TempEventoRetiroATM') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventoRetiroATM
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempEventoRetiroATM 
					--SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE (CodigoProceso LIKE '01%' OR CodigoProceso LIKE '31%')
					--	AND ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					----AND ID_POSEntryMode IN (
					----	SELECT ID_POSEntryMode FROM POSEntryMode
					----	WHERE Clave IN (
					----	'05_'
					----	,'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_',
					----	'07_'
					----	)
					----)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@ClaveEventosMaxRetiroATM, ',') Even
					)

		
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventoRetiroATM)
		--AND re.StoreProcedure = @SPsReglasMaxRetiroATM
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO dbo.EventosReglas (ID_Evento, ID_Regla, EsActiva)
			SELECT *, 1 FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventosReglas
							WHERE 
							ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglasMaxRetiroATM)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempEventoRetiroATM)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempEventoRetiroATM)

					) Eventos,
					(
						SELECT ID_Regla FROM Reglas
						WHERE ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglasMaxRetiroATM )

					) Reglas
					
					
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventoRetiroATM)
		--AND re.StoreProcedure = @SPsReglasMaxRetiroATM
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempEventoRetiroATM') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventoRetiroATM
				END
		END

		IF(@AplicaReglaValidaNIPPorRechazosDeOperaciones = 1)
		BEGIN
--REGLA DE VALIDA NIP POR RECHAZOS DE OPERACIONES
		IF OBJECT_ID('tempdb..#TempReglaNIPPorRechazosDeOperaciones') IS NOT NULL
				BEGIN
					DROP TABLE #TempReglaNIPPorRechazosDeOperaciones
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempReglaNIPPorRechazosDeOperaciones 
					--SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE CodigoProceso LIKE '01%'
					--	AND ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					--AND ID_POSEntryMode IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	'05_'
					--	,'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_',
					--	'07_'
					--	)
					--)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@ClaveEventosValidaNIP, ',') Even
					)

		
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempReglaNIPPorRechazosDeOperaciones)
		--AND re.StoreProcedure = @SPsReglasValidaNIPPorRechazosDeOperaciones
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO dbo.EventosReglas (ID_Evento, ID_Regla, EsActiva)
			SELECT *, 1 FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventosReglas
							WHERE 
							ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglasValidaNIPPorRechazosDeOperaciones)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempReglaNIPPorRechazosDeOperaciones)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempReglaNIPPorRechazosDeOperaciones)

					) Eventos,
					(
						SELECT ID_Regla FROM Reglas
						WHERE ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglasValidaNIPPorRechazosDeOperaciones )

					) Reglas
					
					
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempReglaNIPPorRechazosDeOperaciones)
		--AND re.StoreProcedure = @SPsReglasValidaNIPPorRechazosDeOperaciones
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempReglaNIPPorRechazosDeOperaciones') IS NOT NULL
				BEGIN
					DROP TABLE #TempReglaNIPPorRechazosDeOperaciones
				END
		END

		IF(@AplicaReglaValidaMedioAcceso = 1)
		BEGIN
--REGLA DE VALIDA MEDIO DE ACCESO
		IF OBJECT_ID('tempdb..#TempReglaValidaMedioAcceso') IS NOT NULL
				BEGIN
					DROP TABLE #TempReglaValidaMedioAcceso
				END
					--SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempReglaValidaMedioAcceso
					----SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND ID_CodigoProceso IN(
					--	SELECT ID_CodigoProceso FROM CodigoProceso
					--	WHERE 
					--	--CodigoProceso LIKE '01%'
					--	--AND 
					--	ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--)
					----AND ID_POSEntryMode IN (
					----	SELECT ID_POSEntryMode FROM POSEntryMode
					----	WHERE Clave IN (
					----	'05_'
					----	,'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_',
					----	'07_'
					----	)
					----)
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempReglaValidaMedioAcceso
					--SELECT DISTINCT ev.ClaveEvento 
					FROM Eventos ev
					WHERE ClaveEvento LIKE @PrefijoEventosTran
					AND ClaveEvento LIKE @SufijoEventosTran0200

		
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempReglaValidaMedioAcceso)
		--AND re.StoreProcedure = @SPsReglaValidaMedioAcceso
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO dbo.EventosReglas (ID_Evento, ID_Regla, EsActiva)
			SELECT *, 1 FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventosReglas
							WHERE 
							ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglaValidaMedioAcceso)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempReglaValidaMedioAcceso)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempReglaValidaMedioAcceso)

					) Eventos,
					(
						SELECT ID_Regla FROM Reglas
						WHERE 
						ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglaValidaMedioAcceso )

					) Reglas
					
					
		--	SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempReglaValidaMedioAcceso)
		--AND re.StoreProcedure = @SPsReglaValidaMedioAcceso
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempReglaValidaMedioAcceso') IS NOT NULL
				BEGIN
					DROP TABLE #TempReglaValidaMedioAcceso
				END
		END

		IF(@AplicaRegla_ValidaTokensPOS = 1)
		BEGIN
--REGLA DE VALIDA TOKEN POS
		IF OBJECT_ID('tempdb..#TempReglaValidaTokensPOS') IS NOT NULL
				BEGIN
					DROP TABLE #TempReglaValidaTokensPOS
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempReglaValidaTokensPOS 
					--SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND (
					--    (
					--        ID_CodigoProceso IN (
					--            SELECT ID_CodigoProceso FROM CodigoProceso
					--            WHERE CodigoProceso LIKE '00%' OR CodigoProceso LIKE '20%' OR CodigoProceso LIKE '02%' OR CodigoProceso LIKE '81%'
					--		  --WHERE (CodigoProceso LIKE '01%' OR CodigoProceso LIKE '31%')
					--            AND ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0220')
					--        )
					--    )
					--    OR
					--    (
					--        ID_CodigoProceso IN (
					--            SELECT ID_CodigoProceso FROM CodigoProceso
					--            WHERE CodigoProceso LIKE '20%' OR CodigoProceso LIKE '02%'
					--            AND ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--        )
					--	)
					--)
					--AND ID_POSEntryMode IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	'05_'
					--	,'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_',
					--	'07_'
					--	)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@ClaveEventosValidaTokensPOS, ',') Even
					)

		
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempReglaValidaTokensPOS)
		--AND re.StoreProcedure = @SPsReglas_ValidaTokensPOS
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO dbo.EventosReglas (ID_Evento, ID_Regla, EsActiva)
			SELECT *, 1 FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventosReglas
							WHERE 
							ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglas_ValidaTokensPOS)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempReglaValidaTokensPOS)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempReglaValidaTokensPOS)

					) Eventos,
					(
						SELECT ID_Regla FROM Reglas
						WHERE ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglas_ValidaTokensPOS )
					) Reglas
					
					
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempReglaValidaTokensPOS)
		--AND re.StoreProcedure = @SPsReglas_ValidaTokensPOS
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempReglaValidaTokensPOS') IS NOT NULL
				BEGIN
					DROP TABLE #TempReglaValidaTokensPOS
				END
		END

		IF(@AplicaRegla_ValidaTokensATM = 1)
		BEGIN
--REGLA DE VALIDA TOKENS ATM
		IF OBJECT_ID('tempdb..#TempReglaValidaTokensATM') IS NOT NULL
				BEGIN
					DROP TABLE #TempReglaValidaTokensATM
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempReglaValidaTokensATM 
					--SELECT DISTINCT ev.ClaveEvento 
					--FROM Eventos ev
					--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_Evento = ev.ID_Evento
					--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = pte.ID_PertenenciaTipo
					--WHERE pt.ClaveTipoProducto = @Tipo_Producto
					--AND (
					--    (
					--        ID_CodigoProceso IN (
					--            SELECT ID_CodigoProceso FROM CodigoProceso
					--            WHERE CodigoProceso LIKE '01%' OR CodigoProceso LIKE '31%'
					--		  --WHERE (CodigoProceso LIKE '01%' OR CodigoProceso LIKE '31%')
					--            AND ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0220')
					--        )
					--    )
					--    OR
					--    (
					--        ID_CodigoProceso IN (
					--            SELECT ID_CodigoProceso FROM CodigoProceso
					--            WHERE CodigoProceso LIKE '01%' OR CodigoProceso LIKE '31%'
					--            AND ID_TipoMensaje = (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = '0200')
					--        )
					--	)
					--)
					--AND ID_POSEntryMode IN (
					--	SELECT ID_POSEntryMode FROM POSEntryMode
					--	WHERE Clave IN (
					--	'05_'
					--	,'00_', '01_', '02_', '10_', '81_', '09_', '80_', '21_',
					--	'07_'
					--	)
					FROM Eventos ev
					WHERE ClaveEvento IN(
					SELECT Even.value AS NombreParam
							FROM STRING_SPLIT(@ClaveEventosValidaTokensATM, ',') Even
					)

		
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempReglaValidaTokensATM)
		--AND re.StoreProcedure = @SPsReglas_ValidaTokensATM
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO dbo.EventosReglas (ID_Evento, ID_Regla, EsActiva)
			SELECT *, 1 FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventosReglas
							WHERE 
							ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglas_ValidaTokensATM)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempReglaValidaTokensATM)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempReglaValidaTokensATM)

					) Eventos,
					(
						SELECT ID_Regla FROM Reglas
						WHERE ID_Regla = (SELECT ID_Regla FROM Reglas WHERE StoreProcedure = @SPsReglas_ValidaTokensATM )
					) Reglas
					
					
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * FROM Reglas re
		--INNER JOIN EventosReglas er ON Er.ID_Regla = re.ID_Regla
		--INNER JOIN Eventos ev ON ev.ID_Evento = er.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempReglaValidaTokensATM)
		--AND re.StoreProcedure = @SPsReglas_ValidaTokensATM
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempReglaValidaTokensATM') IS NOT NULL
				BEGIN
					DROP TABLE #TempReglaValidaTokensATM
				END
		END

		UPDATE er
		SET er.EsActiva = 1
		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * 
		FROM Eventos ev
		INNER JOIN EventosReglas er ON er.ID_Evento = ev.ID_Evento
		INNER JOIN Reglas re ON re.ID_Regla = er.ID_Regla
		WHERE ClaveEvento LIKE @PrefijoEventosTran

		--SELECT ev.ClaveEvento, ev.Descripcion, re.StoreProcedure, * 
		--FROM Eventos ev
		--INNER JOIN EventosReglas er ON er.ID_Evento = ev.ID_Evento
		--INNER JOIN Reglas re ON re.ID_Regla = er.ID_Regla
		--WHERE ClaveEvento LIKE @PrefijoEventosTran

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN