USE [Autorizador]
GO
IF EXISTS
(
	SELECT TOP 1 
		id 
	FROM 
		sysobjects  
	WHERE 
		name ='ProcMan_Comp_GetIdEvento' 
		AND type ='P'
)
BEGIN
	DROP PROCEDURE [dbo].[ProcMan_Comp_GetIdEvento]
END
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcMan_Comp_GetIdEvento]
(
	@claveEvento VARCHAR(20),
	@descripcion VARCHAR(100),
	@idTipoEvento INT,
	@claveEventoEdoCta VARCHAR(20),
	@descripcionEdoCta VARCHAR(100),
	@idEvento INT OUTPUT
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
	Descripción:	Obtiene el ID_Evento de una ClaveEvento, si no existe lo genera
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	DECLARE @claveEvento VARCHAR(20) = ''
    DECLARE @descripcion VARCHAR(100) = ''
    DECLARE @idTipoEvento INT = 0
    DECLARE @claveEventoEdoCta VARCHAR(20) = ''
    DECLARE @descripcionEdoCta VARCHAR(100) = ''
    DECLARE @idEvento INT
	
	EXEC [dbo].[ProcMan_Comp_GetIdEvento] 
		@claveEvento, @descripcion, @idTipoEvento, @claveEventoEdoCta, @descripcionEdoCta, 
		@idEvento OUTPUT

	SELECT
		@idEvento
	==========================================================================================
	*/
    SET NOCOUNT ON
    
	IF NOT EXISTS
	(
		SELECT
			ID_Evento
		FROM
			Eventos e WITH (NOLOCK)
		WHERE
			ClaveEvento = @claveEvento
	)
	BEGIN
		INSERT INTO
			Eventos
			(
				ClaveEvento,
				Descripcion,
				EsActivo,
				EsReversable,
				EsCancelable,
				EsTransaccional,
				ID_TipoEvento,
				DescripcionEdoCta,
				GeneraPoliza,
				PreValidaciones,
				PostValidaciones,
				ClaveEventoEdoCta
			)
		SELECT
			@claveEvento,
			@descripcion,
			1,
			1,
			1,
			1,
			@idTipoEvento,
			@descripcionEdoCta,
			1,
			1,
			1,
			@claveEventoEdoCta
	END
	ELSE
	BEGIN
		UPDATE
			Eventos
		SET
			Descripcion = @descripcion,
			ClaveEventoEdoCta = @claveEventoEdoCta,
			DescripcionEdoCta = @descripcionEdoCta,
			EsActivo = 1,
			EsReversable = 1,
			EsCancelable = 1,
			EsTransaccional = 1,
			GeneraPoliza = 1,
			PreValidaciones = 1,
			PostValidaciones = 1
		WHERE
			ClaveEvento = @claveEvento
	END

	SELECT
		@idEvento = ID_Evento
	FROM
		Eventos e WITH (NOLOCK)
	WHERE
		ClaveEvento = @claveEvento
END
GO
