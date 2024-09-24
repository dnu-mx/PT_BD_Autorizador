USE [Autorizador]
BEGIN TRAN

	DECLARE @commit BIT = 1

	 DECLARE @ID_pluginABONOS INT, @ID_PluginRETIROS INT, @ID_PluginCOMPRAS INT

	DECLARE @ClavePluginABONOS VARCHAR(50)= 'PlugInISOJSON' -- CLAVE DEL PLUGINS PARA ASIGNARSE A LOS EVENTOS
	DECLARE @ClavePluginRETIROS VARCHAR(50)= 'PlugInISOJSON' --'PlugInMONEYSEND' --CLAVE DEL PLUGINS PARA ASIGNARSE A LOS EVENTOS DE ENVIO DE DINERO
	DECLARE @ClavePluginCOMPRAS VARCHAR(50)= 'PlugInISOJSON' --'PlugInMONEYSEND' --CLAVE DEL PLUGINS PARA ASIGNARSE A LOS EVENTOS DE ENVIO DE DINERO
	DECLARE @PrefijoEventosCompras VARCHAR(1200) = 'T0200%';
	DECLARE @PrefijoEventosRetiros VARCHAR(1200) = 'T0201%';
	DECLARE @PrefijoEventosConsultas VARCHAR(1200) = 'T0230%';
	DECLARE @PrefijoEventosComprasCashback VARCHAR(1200) = 'T0209%';
	DECLARE @PrefijoEventosComprasCashAdvance VARCHAR(1200) = 'T0214%';
	DECLARE @PrefijoEventosComprasMoto VARCHAR(1200) = 'T0280%';
	DECLARE @PrefijoEventosVerificacion VARCHAR(1200) = 'T02VC%';
	DECLARE @PrefijoEventosDevolucion VARCHAR(1200) = 'T0220%';
	DECLARE @PrefijoEventosCancelacion VARCHAR(1200) = 'T02DA%';
	DECLARE @PrefijoEventosMoneySend VARCHAR(1200) = 'T02MS%';

	DECLARE @SufijoEventosTran0200 VARCHAR(1200) = '%00MXN484';


	 SELECT @ID_pluginABONOS = ID_Plugin
     FROM dbo.PlugIns
     WHERE ClavePlugin = @ClavePluginABONOS

	 SELECT @ID_pluginRETIROS = ID_Plugin
     FROM dbo.PlugIns
     WHERE ClavePlugin = @ClavePluginRETIROS

	 SELECT @ID_pluginCOMPRAS = ID_Plugin
     FROM dbo.PlugIns
     WHERE ClavePlugin = @ClavePluginCOMPRAS


	IF OBJECT_ID('tempdb..#TempEventosPluginCOMPRAS') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventosPluginCOMPRAS
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempEventosPluginCOMPRAS
					--SELECT DISTINCT ev.ClaveEvento 
					FROM Eventos ev
					WHERE (ClaveEvento LIKE @PrefijoEventosCompras
					OR ClaveEvento LIKE @PrefijoEventosComprasMoto
					OR ClaveEvento LIKE @PrefijoEventosComprasCashback
					OR ClaveEvento LIKE @PrefijoEventosComprasCashAdvance
					OR ClaveEvento LIKE @PrefijoEventosConsultas
					OR ClaveEvento LIKE @PrefijoEventosVerificacion
					)
					AND ClaveEvento LIKE @SufijoEventosTran0200

		
		--SELECT ev.ClaveEvento, ev.Descripcion, pl.ClavePlugin, * FROM PlugIns pl
		--INNER JOIN EventoPlugin ep ON ep.ID_Plugin = pl.ID_Plugin
		--INNER JOIN Eventos ev ON ev.ID_Evento = ep.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventosPluginCOMPRAS)
		--AND pl.ClavePlugin = @ClavePluginCOMPRAS
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO EventoPlugin( ID_Evento, ID_Plugin, EsActivo, OrdenEjecucion, EsRespuestaISO, EsObligatorioParaReverso )
			SELECT *, 1, 1, 1, 1  FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventoPlugin
							WHERE 
							ID_Plugin = (SELECT ID_Plugin FROM PlugIns WHERE ClavePlugin = @ClavePluginCOMPRAS)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempEventosPluginCOMPRAS)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempEventosPluginCOMPRAS)

					) Eventos,
					(
						SELECT ID_Plugin FROM PlugIns
						WHERE 
						ID_Plugin = (SELECT ID_Plugin FROM PlugIns WHERE ClavePlugin = @ClavePluginCOMPRAS )

					) Plugin
					
					
		--SELECT ev.ClaveEvento, ev.Descripcion, pl.ClavePlugin, * FROM PlugIns pl
		--INNER JOIN EventoPlugin ep ON ep.ID_Plugin = pl.ID_Plugin
		--INNER JOIN Eventos ev ON ev.ID_Evento = ep.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventosPluginCOMPRAS)
		--AND pl.ClavePlugin = @ClavePluginCOMPRAS
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempEventosPluginCOMPRAS') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventosPluginCOMPRAS
				END
--************************************************************************
	IF OBJECT_ID('tempdb..#TempEventosPluginRETIROS') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventosPluginRETIROS
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempEventosPluginRETIROS
					--SELECT DISTINCT ev.ClaveEvento 
					FROM Eventos ev
					WHERE (ClaveEvento LIKE @PrefijoEventosRetiros
					)
					AND ClaveEvento LIKE @SufijoEventosTran0200

		
		--SELECT ev.ClaveEvento, ev.Descripcion, pl.ClavePlugin, * FROM PlugIns pl
		--INNER JOIN EventoPlugin ep ON ep.ID_Plugin = pl.ID_Plugin
		--INNER JOIN Eventos ev ON ev.ID_Evento = ep.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventosPluginRETIROS)
		--AND pl.ClavePlugin = @ClavePluginRETIROS
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO EventoPlugin( ID_Evento, ID_Plugin, EsActivo, OrdenEjecucion, EsRespuestaISO, EsObligatorioParaReverso )
			SELECT *, 1, 1, 1, 1  FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventoPlugin
							WHERE 
							ID_Plugin = (SELECT ID_Plugin FROM PlugIns WHERE ClavePlugin = @ClavePluginRETIROS)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempEventosPluginRETIROS)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempEventosPluginRETIROS)

					) Eventos,
					(
						SELECT ID_Plugin FROM PlugIns
						WHERE 
						ID_Plugin = (SELECT ID_Plugin FROM PlugIns WHERE ClavePlugin = @ClavePluginRETIROS )

					) Plugin
					
					
		--SELECT ev.ClaveEvento, ev.Descripcion, pl.ClavePlugin, * FROM PlugIns pl
		--INNER JOIN EventoPlugin ep ON ep.ID_Plugin = pl.ID_Plugin
		--INNER JOIN Eventos ev ON ev.ID_Evento = ep.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventosPluginRETIROS)
		--AND pl.ClavePlugin = @ClavePluginRETIROS
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempEventosPluginRETIROS') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventosPluginRETIROS
				END
--**************************************************************************************************
	IF OBJECT_ID('tempdb..#TempEventosPluginABONOS') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventosPluginABONOS
				END
					SELECT  DISTINCT EV.ID_Evento, ev.ClaveEvento  INTO #TempEventosPluginABONOS
					--SELECT DISTINCT ev.ClaveEvento 
					FROM Eventos ev
					WHERE (ClaveEvento LIKE @PrefijoEventosDevolucion
					OR ClaveEvento LIKE @PrefijoEventosCancelacion
					OR ClaveEvento LIKE @PrefijoEventosMoneySend
					)
					AND ClaveEvento LIKE @SufijoEventosTran0200

		
		--SELECT ev.ClaveEvento, ev.Descripcion, pl.ClavePlugin, * FROM PlugIns pl
		--INNER JOIN EventoPlugin ep ON ep.ID_Plugin = pl.ID_Plugin
		--INNER JOIN Eventos ev ON ev.ID_Evento = ep.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventosPluginABONOS)
		--AND pl.ClavePlugin = @ClavePluginABONOS
		--ORDER BY ev.Descripcion DESC
					

			INSERT INTO EventoPlugin( ID_Evento, ID_Plugin, EsActivo, OrdenEjecucion, EsRespuestaISO, EsObligatorioParaReverso )
			SELECT *, 1, 1, 1, 1  FROM 
					(
						SELECT ID_Evento FROM Eventos
						WHERE ID_Evento NOT IN (
							SELECT ID_Evento FROM EventoPlugin
							WHERE 
							ID_Plugin = (SELECT ID_Plugin FROM PlugIns WHERE ClavePlugin = @ClavePluginABONOS)
							AND ID_Evento IN (SELECT ID_Evento FROM #TempEventosPluginABONOS)
							)
						AND ID_Evento IN (SELECT ID_Evento FROM #TempEventosPluginABONOS)

					) Eventos,
					(
						SELECT ID_Plugin FROM PlugIns
						WHERE 
						ID_Plugin = (SELECT ID_Plugin FROM PlugIns WHERE ClavePlugin = @ClavePluginABONOS )

					) Plugin
					
					
		--SELECT ev.ClaveEvento, ev.Descripcion, pl.ClavePlugin, * FROM PlugIns pl
		--INNER JOIN EventoPlugin ep ON ep.ID_Plugin = pl.ID_Plugin
		--INNER JOIN Eventos ev ON ev.ID_Evento = ep.ID_Evento
		--WHERE ev.ID_Evento IN ( SELECT ID_Evento FROM #TempEventosPluginABONOS)
		--AND pl.ClavePlugin = @ClavePluginABONOS
		--ORDER BY ev.Descripcion DESC

				IF OBJECT_ID('tempdb..#TempEventosPluginABONOS') IS NOT NULL
				BEGIN
					DROP TABLE #TempEventosPluginABONOS
				END

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN