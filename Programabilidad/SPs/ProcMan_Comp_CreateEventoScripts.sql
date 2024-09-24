USE [Autorizador]
GO
IF EXISTS
(
	SELECT TOP 1 
		id 
	FROM 
		sysobjects  
	WHERE 
		name ='ProcMan_Comp_CreateEventoScripts' 
		AND type ='P'
)
BEGIN
	DROP PROCEDURE [dbo].[ProcMan_Comp_CreateEventoScripts]
END
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcMan_Comp_CreateEventoScripts]
(
	@claveEvento VARCHAR(20),
	@idScript01 INT,
	@idScript02 INT,
	@idScript03 INT = NULL,
	@idScript04 INT = NULL,
	@idScript05 INT = NULL,
	@idScript06 INT = NULL,
	@idScript07 INT = NULL,
	@idScript08 INT = NULL,
	@idScript09 INT = NULL,
	@idScript10 INT = NULL,
	@idScript11 INT = NULL,
	@idScript12 INT = NULL,
	@idScript13 INT = NULL,
	@idScript14 INT = NULL,
	@idScript15 INT = NULL,
	@idScript16 INT = NULL,
	@idScript17 INT = NULL,
	@idScript18 INT = NULL,
	@idScript19 INT = NULL,
	@idScript20 INT = NULL,
	@idScript21 INT = NULL,
	@idScript22 INT = NULL
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
	Descripción:	Genera la relación de Eventos - Scripts
	
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	DECLARE @claveEvento VARCHAR(20) = ''
    DECLARE @idScript01 INT = 0
	DECLARE @idScript02 INT = 0
	DECLARE @idScript03 INT = NULL
	DECLARE @idScript04 INT = NULL
	DECLARE @idScript05 INT = NULL
	DECLARE @idScript06 INT = NULL
	DECLARE @idScript07 INT = NULL
	DECLARE @idScript08 INT = NULL
	DECLARE @idScript09 INT = NULL
	DECLARE @idScript10 INT = NULL
	DECLARE @idScript11 INT = NULL
	DECLARE @idScript12 INT = NULL
	DECLARE @idScript13 INT = NULL
	DECLARE @idScript14 INT = NULL
	DECLARE @idScript15 INT = NULL
	DECLARE @idScript16 INT = NULL
	DECLARE @idScript17 INT = NULL
	DECLARE @idScript18 INT = NULL
	DECLARE @idScript19 INT = NULL
	DECLARE @idScript20 INT = NULL
	DECLARE @idScript21 INT = NULL
	DECLARE @idScript22 INT = NULL
	
	EXEC [dbo].[ProcMan_Comp_CreateEventoScripts] 
		@claveEvento, @idScript01, @idScript02, @idScript03, @idScript04, @idScript05,
		@idScript06, @idScript07, @idScript08, @idScript09, @idScript10, @idScript11,
		@idScript12, @idScript13, @idScript14, @idScript15, @idScript16, @idScript17,
		@idScript18, @idScript19, @idScript20, @idScript21, @idScript22
	==========================================================================================
	*/
    SET NOCOUNT ON
    
	DECLARE @idEvento INT

	SELECT
		@idEvento = ID_Evento
	FROM
		Eventos e WITH (NOLOCK)
	WHERE
		ClaveEvento = @claveEvento

	DELETE 
		EventoScript
	WHERE
		ID_Evento = @idEvento
	
	IF @idScript01 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript01,
			1,
			1
	END
	ELSE
		RETURN
	
	IF @idScript02 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript02,
			1,
			2
	END
	ELSE
		RETURN
	
	IF @idScript03 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript03,
			1,
			3
	END
	ELSE
		RETURN
	
	IF @idScript04 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript04,
			1,
			4
	END
	ELSE
		RETURN
		
	IF @idScript05 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript05,
			1,
			5
	END
	ELSE
		RETURN
	
	IF @idScript06 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript06,
			1,
			6
	END
	ELSE
		RETURN
	
	IF @idScript07 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript07,
			1,
			7
	END
	ELSE
		RETURN
	
	IF @idScript08 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript08,
			1,
			8
	END
	ELSE
		RETURN
	
	IF @idScript09 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript09,
			1,
			9
	END
	ELSE
		RETURN
	
	IF @idScript10 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript10,
			1,
			10
	END
	ELSE
		RETURN	
	
	IF @idScript11 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript11,
			1,
			11
	END
	ELSE
		RETURN
	
	IF @idScript12 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript12,
			1,
			12
	END
	ELSE
		RETURN
		
	IF @idScript13 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript13,
			1,
			13
	END
	ELSE
		RETURN
	
	IF @idScript14 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript14,
			1,
			14
	END
	ELSE
		RETURN

	IF @idScript15 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript15,
			1,
			15
	END
	ELSE
		RETURN
	
	IF @idScript16 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript16,
			1,
			16
	END
	ELSE
		RETURN
	
	IF @idScript17 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript17,
			1,
			17
	END
	ELSE
		RETURN
	
	IF @idScript18 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript18,
			1,
			18
	END
	ELSE
		RETURN	
	
	IF @idScript19 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript19,
			1,
			19
	END
	ELSE
		RETURN
	
	IF @idScript20 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript20,
			1,
			20
	END
	ELSE
		RETURN
		
	IF @idScript21 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript21,
			1,
			21
	END
	ELSE
		RETURN
	
	IF @idScript22 IS NOT NULL
	BEGIN
		INSERT INTO 
			EventoScript
			(
				ID_Evento,
				ID_Script,
				EsActiva,
				OrdenEjecucion
			)
		SELECT
			@idEvento,
			@idScript22,
			1,
			22
	END
	ELSE
		RETURN
END
GO
