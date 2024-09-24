USE [Autorizador]
GO
IF EXISTS
(
	SELECT TOP 1 
		id 
	FROM 
		sysobjects  
	WHERE 
		name ='ProcMan_Comp_UpdateEventosEdoCta'
		AND type ='P'
)
BEGIN
	DROP PROCEDURE [dbo].[ProcMan_Comp_UpdateEventosEdoCta]
END
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcMan_Comp_UpdateEventosEdoCta]
(
	@cvePersonalizado VARCHAR(10)
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
	Descripción:	Actualiza la ClaveEventoEdoCta a partir del valor recibido
	==========================================================================================
	Versión:		1.1
	Autor:			Ricardo Monroy        
	Fecha:			27 Sep 2022
	Descripción:	Incluye los Eventos Fast Funds, Money Send y Devoluciones en Línea
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	DECLARE @cvePersonalizado VARCHAR(10) = ''
    
	EXEC [dbo].[ProcMan_Comp_UpdateEventosEdoCta]
		@cvePersonalizado
	==========================================================================================
	*/
    SET NOCOUNT ON
	
    IF @cvePersonalizado = 'DOCK'
	BEGIN
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'CREDITO81'
		WHERE
			ClaveEventoEdoCta = 'E00011000MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'CREDITO81R'
		WHERE
			ClaveEventoEdoCta = 'E00011002MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'CREDITO82'
		WHERE
			ClaveEventoEdoCta = 'E00011100MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'CREDITO82R'
		WHERE
			ClaveEventoEdoCta = 'E00011102MXN484'

		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB34'
		WHERE
			ClaveEventoEdoCta = 'E00000100MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB35'
		WHERE
			ClaveEventoEdoCta = 'E00010100MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB43'
		WHERE
			ClaveEventoEdoCta = 'E00300100MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB51'
		WHERE
			ClaveEventoEdoCta = 'E00200000MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB76'
		WHERE
			ClaveEventoEdoCta = 'E00090100MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB78'
		WHERE
			ClaveEventoEdoCta = 'E00000000MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB80'
		WHERE
			ClaveEventoEdoCta = 'E00280100MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB87'
		WHERE
			ClaveEventoEdoCta = 'E00200100MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB88'
		WHERE
			ClaveEventoEdoCta = 'E00200700MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB117'
		WHERE
			ClaveEventoEdoCta = 'E00010000MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB119'
		WHERE
			ClaveEventoEdoCta = 'E00090000MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB121'
		WHERE
			ClaveEventoEdoCta = 'E00300000MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB126'
		WHERE
			ClaveEventoEdoCta = 'E00190001MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB127'
		WHERE
			ClaveEventoEdoCta = 'E00290001MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB160'
		WHERE
			ClaveEventoEdoCta = 'E00280102MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB161'
		WHERE
			ClaveEventoEdoCta = 'E00200102MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'PB162'
		WHERE
			ClaveEventoEdoCta = 'E00200002MXN484'
	
		--UPDATE
		--	Eventos
		--SET
		--	ClaveEventoEdoCta = 'TFFL'
		--WHERE
		--	ClaveEventoEdoCta = 'M00201300MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'TFFL'
		WHERE
			ClaveEventoEdoCta = 'M00261300MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'TMSL'
		WHERE
			ClaveEventoEdoCta = 'M00281300MXN484'
	
		--UPDATE
		--	Eventos
		--SET
		--	ClaveEventoEdoCta = 'REJ'
		--WHERE
		--	ClaveEventoEdoCta = 'M00201400MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'TFFC'
		WHERE
			ClaveEventoEdoCta = 'E00260000MXN484'
	
		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'TMSC'
		WHERE
			ClaveEventoEdoCta = 'E00280000MXN484'

		UPDATE
			Eventos
		SET
			ClaveEventoEdoCta = 'DO20'
		WHERE
			ClaveEventoEdoCta = 'E00201500MXN484'
	END
END
GO