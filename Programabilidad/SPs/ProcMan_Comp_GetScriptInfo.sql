USE [Autorizador]
GO
IF EXISTS
(
	SELECT TOP 1 
		id 
	FROM 
		sysobjects  
	WHERE 
		name ='ProcMan_Comp_GetScriptInfo' 
		AND type ='P'
)
BEGIN
	DROP PROCEDURE [dbo].[ProcMan_Comp_GetScriptInfo]
END
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcMan_Comp_GetScriptInfo]
(
	@Script VARCHAR(100),
	@idScript INT
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
	Descripción:	Obtiene el detalle contable del Script
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	DECLARE @Script VARCHAR(100) = ''
    DECLARE @idScript INT
	
	EXEC [dbo].[ProcMan_Comp_GetScriptInfo] 
		@Script, @idScript
	==========================================================================================
	*/
    SET NOCOUNT ON
    
	SELECT
		@Script,
		sc.*
	FROM
		ScriptContable sc WITH (NOLOCK)
	WHERE
		sc.ID_Script = @idScript
END
GO