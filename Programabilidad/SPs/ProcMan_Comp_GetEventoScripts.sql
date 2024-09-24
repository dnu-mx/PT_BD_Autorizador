USE [Autorizador]
GO
IF EXISTS
(
	SELECT TOP 1 
		id 
	FROM 
		sysobjects  
	WHERE 
		name ='ProcMan_Comp_GetEventoScripts' 
		AND type ='P'
)
BEGIN
	DROP PROCEDURE [dbo].[ProcMan_Comp_GetEventoScripts]
END
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ricardo Monroy
-- Create date: 10 Mar 2022
-- Description:	Obtiene consulta EventoScript
-- =============================================
-- PRUEBA:
-- EXEC ProcMan_Comp_GetEventoScripts 'E05000400MXN484'
-- =============================================
CREATE PROCEDURE [dbo].[ProcMan_Comp_GetEventoScripts]
(
	@claveEvento VARCHAR(20)
)
WITH ENCRYPTION
AS
BEGIN
	/*
	==========================================================================================
	==================================Historial de Versiones==================================
	==========================================================================================
	Versión:		1.0
	Autor:			Ricardo Monroy        
	Fecha:			10 Mar 2022
	Descripción:	Obtiene el detalle contable de un Evento
	==========================================================================================
	Versión:		1.1
	Autor:			Martin Larguero        
	Fecha:			24 May 2024
	Descripción:	Obtiene más campos necesarios para evaluar si el Evento es correcto
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	DECLARE @claveEvento VARCHAR(20) = ''
    
	EXEC [dbo].[ProcMan_Comp_GetEventoScripts] 
		@claveEvento
	==========================================================================================
	*/
    SET NOCOUNT ON
    
	--SELECT
	--	e.ID_Evento,
	--	e.ClaveEvento,
	--	e.Descripcion,
	--	sc.ID_TipoColectiva,
	--	sc.ID_TipoCuenta,
	--	tcl.ClaveTipoColectiva,
	--	tct.ClaveTipoCuenta,
	--	sc.Formula,
	--	sc.EsAbono,
	--	es.OrdenEjecucion,
	--	ca.ClaveAplicacion
	--FROM
	--	Eventos e WITH (NOLOCK)
	--	INNER JOIN EventoScript es WITH (NOLOCK)
	--		ON es.ID_Evento = e.ID_Evento
	--	INNER JOIN ScriptContable sc WITH (NOLOCK)
	--		ON sc.ID_Script = es.ID_Script
	--	INNER JOIN TipoColectiva tcl WITH (NOLOCK)
	--		ON tcl.ID_TipoColectiva = sc.ID_TipoColectiva
	--	INNER JOIN TipoCuenta tct WITH (NOLOCK)
	--		ON tct.ID_TipoCuenta = sc.ID_TipoCuenta
	--	LEFT JOIN ClaveAplicacion ca WITH (NOLOCK)
	--		ON ca.ID_ClaveAplicacion = sc.ID_ClaveAplicacion
	--WHERE
	--	e.claveEvento = @claveEvento
	--ORDER BY
	--	es.OrdenEjecucion

	
 --Para Validación contable de Eventos
SELECT --* 
 es.OrdenEjecucion,
 di.ClaveNumericaMoneda AS Divisa,
 te.Descripcion AS TipoEvento,
 ev.ClaveEvento,
 ev.Descripcion AS DescripcionEvento,
 ev.ClaveEventoEdoCta,
 ev.DescripcionEdoCta,
  tco.ClaveTipoColectiva,
 tco.Descripcion AS DescTipoColectiva,
 tcu.ClaveTipoCuenta,
 tcu.Descripcion AS DescTipoCuenta,
 ca.ClaveAplicacion,
 sc.Formula,
 sc.EsAbono,
 --CASE (SELECT TOP 1(ID_Evento) FROM Poliza WHERE ID_Evento = ev.ID_Evento) WHEN ev.ID_Evento THEN 1 ELSE 0 END AS TienePolizas,
 sc.ValidaSaldo,
 sc.ValidaEstatusCuenta,
 --re.StoreProcedure AS Regla,
 pl.Nombre AS Plugin,
 re.StoreProcedure AS Regla,
 vc.Campo AS ValidadorCampos8583
-- po.*
 FROM Eventos ev
 LEFT JOIN EventosReglas er ON er.ID_Evento = ev.ID_Evento
 LEFT JOIN reglas re ON re.ID_Regla = er.ID_Regla
 LEFT JOIN EventoScript es ON es.ID_Evento = ev.ID_Evento
 LEFT JOIN ScriptContable sc ON sc.ID_Script = es.ID_Script
 LEFT JOIN TipoColectiva tco ON tco.ID_TipoColectiva = sc.ID_TipoColectiva
 LEFT JOIN TipoCuenta tcu ON tcu.ID_TipoCuenta = sc.ID_TipoCuenta
 LEFT JOIN EventoPlugin ep ON ep.ID_Evento = ev.ID_Evento
 LEFT JOIN PlugIns pl ON pl.ID_Plugin = ep.ID_Plugin
 LEFT JOIN Divisas di ON di.ID_Divisa = tcu.ID_Divisa
 --LEFT JOIN Poliza po on po.ID_Evento =  ev.ID_Evento
 LEFT JOIN ValidadorCampos8583 vc ON vc.ID_Evento = ev.ID_Evento
 LEFT JOIN TipoEvento te ON te.ID_TipoEvento = ev.ID_TipoEvento
 LEFT JOIN ClaveAplicacion ca ON ca.ID_ClaveAplicacion = sc.ID_ClaveAplicacion
WHERE ev.ClaveEvento = @claveEvento
 ORDER BY ev.Descripcion, es.OrdenEjecucion, ev.ID_TipoEvento
END
GO
