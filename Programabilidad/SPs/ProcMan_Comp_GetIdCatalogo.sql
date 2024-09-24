USE [Autorizador]
GO
IF EXISTS
(
	SELECT TOP 1 
		id 
	FROM 
		sysobjects  
	WHERE 
		name ='ProcMan_Comp_GetIdCatalogo'
		AND type ='P'
)
BEGIN
	DROP PROCEDURE [dbo].[ProcMan_Comp_GetIdCatalogo]
END
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcMan_Comp_GetIdCatalogo]
(
	@catalogo VARCHAR(50),
	@cveCatalogo VARCHAR(10),
	@cveNumericaDivisa VARCHAR(50) NULL,
	@idCatalogo INT OUTPUT
	
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
	Descripción:	Obtiene el ID asociado a la Clave del Catalogo indicado
	==========================================================================================
	Versión:		1.1
	Autor:			Martin Laguero        
	Fecha:			24 May 2024
	Descripción:	Se agrega la Divisa para consultar el Tipo de Cuenta
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	DECLARE @catalogo VARCHAR(50) = 'ClaveAplicacion'
    DECLARE @cveCatalogo VARCHAR(10) = 'OPERATION'
    DECLARE @idCatalogo INT
	
	EXEC [dbo].[ProcMan_Comp_GetIdCatalogo] 
		@catalogo, @cveCatalogo, @idCatalogo OUTPUT

	SELECT
		@idCatalogo
	==========================================================================================
	*/
    SET NOCOUNT ON

	IF @catalogo = 'ClaveAplicacion'
    BEGIN
		SELECT
			@idCatalogo = ID_ClaveAplicacion
		FROM
			ClaveAplicacion WITH (NOLOCK)
		WHERE
			ClaveAplicacion = @cveCatalogo
	END
    
	IF @catalogo = 'TipoColectiva'
    BEGIN
		SELECT
			@idCatalogo = ID_TipoColectiva
		FROM
			TipoColectiva WITH (NOLOCK)
		WHERE
			ClaveTipoColectiva = @cveCatalogo
    END

	IF @catalogo = 'TipoCuenta'
    BEGIN
		--SELECT
		--	@idCatalogo = ID_TipoCuenta
		--FROM
		--	TipoCuenta WITH (NOLOCK)
		--WHERE
		--	ClaveTipoCuenta = @cveCatalogo
		SELECT 
			@idCatalogo = ID_TipoCuenta 
		FROM 
			TipoCuenta WITH (NOLOCK)
		INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa 
		WHERE 
			ClaveNumericaMoneda=@cveNumericaDivisa
			AND TipoCuenta.ClaveGenerica = @cveCatalogo
    END
	
	IF @catalogo = 'TipoEvento'
    BEGIN
		SELECT
			@idCatalogo = ID_TipoEvento
		FROM
			TipoEvento WITH (NOLOCK)
		WHERE
			Clave = @cveCatalogo
	END
END
GO
