USE [Autorizador]
GO

IF EXISTS
(
	SELECT TOP 1 
		id 
	FROM 
		sysobjects  
	WHERE 
		name ='ProcMan_Comp_CreateEventosReglas' 
		AND type ='P'
)
BEGIN
	DROP PROCEDURE [dbo].[ProcMan_Comp_CreateEventosReglas]
END
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcMan_Comp_CreateEventosReglas]
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
	Descripción:	Actualiza la relación Eventos - Reglas de los Eventos de Compensación para
					la Regla Valida Operacion Original 
	==========================================================================================
	Versión:		1.1
	Autor:			Ricardo Monroy        
	Fecha:			22 Sep 2022
	Descripción:	Agrega los Eventos de Fast Funds 
	==========================================================================================
	Versión:		1.2
	Autor:			Ricardo Monroy        
	Fecha:			18 Oct 2022
	Descripción:	Agrega los Eventos de Devoluciones en Línea
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	EXEC [dbo].[ProcMan_Comp_CreateEventosReglas] 
	==========================================================================================
	*/
	SET NOCOUNT ON
    
		SELECT
			*
		FROM
			Reglas WITH (NOLOCK)
		WHERE
			Clave = '0003'

	DECLARE @cveRegla VARCHAR(4) = '0003'

	DECLARE @events TABLE
	(
		idEvento BIGINT,
		claveEvento CHAR(20)
	)
	
	DECLARE @idRegla INT = 
	(
		SELECT
			ID_Regla
		FROM
			Reglas WITH (NOLOCK)
		WHERE
			Clave = @cveRegla
	)
		
	INSERT INTO
		@events
		(
			idEvento,
			claveEvento
		)
	SELECT
		e.ID_Evento,
		e.ClaveEvento
	FROM
		Eventos e WITH (NOLOCK)
	WHERE
		e.ClaveEventoEdoCta IN
		(
			/*
				'T112 COMPRA/CARGO', 
				'T112 COMPRA/CARGO (DUPLICADA)'
				'T112 COMPRA/CARGO (POST DEVUELTA)'
				'T112 COMPRA/CARGO (REVERSADA PRESENTADA)'
			*/
			'E00000000MXN484', 
			/*
				'T112 COMPRA/CARGO (SIN OPERACIÓN)'
			*/
			--'E00000100MXN484',
			/*
				'T112 RETIRO EN ATM'
				'T112 RETIRO EN ATM (DUPLICADA)'
				'T112 RETIRO EN ATM (POST DEVUELTA)'
				'T112 RETIRO EN ATM (REVERSADA PRESENTADA)'
			*/
			'E00010000MXN484',
			/*
				'T112 RETIRO EN ATM (SIN OPERACIÓN)'
			*/
			--'E00010100MXN484',
			/*
				'T112 RETIRO EN ATM TDC (COMISIÓN)'
			*/
			--'E00011000MXN484',
			/*
				'T112 RETIRO EN ATM TDC (IVA COMISIÓN)'
			*/
			--'E00011100MXN484',
			/*
				'T112 DEVOLUCIÓN'
				'T112 DEVOLUCIÓN (REVERSADA PRESENTADA ACLARADA)'
				'T112 COMPRA/CARGO (POST DEVUELTA SIN COMPENSAR)'
				'T112 COMPRA/CARGO (A FAVOR ACLARADA)'
				'T112 RETIRO EN ATM (POST DEVUELTA SIN COMPENSAR)'
				'T112 RETIRO EN ATM (A FAVOR ACLARADA)'
				'T112 CONSULTA DE SALDO EN ATM (POST DEVUELTA SIN COMPENSAR)'
				'T112 CONSULTA DE SALDO EN ATM (A FAVOR ACLARADA)'
			*/
			'E00200000MXN484',
			/*
				'T112 REVERSO DEVOLUCIÓN'
			*/
			'E00200002MXN484',
			/*
				'T112 DEVOLUCIÓN (EN LÍNEA)'
			*/
			'E00201500MXN484',
			/*
				'T112 DEVOLUCIÓN (SIN OPERACIÓN)'
			*/
			--'E00200100MXN484',
			/*
				'T112 REVERSO DEVOLUCIÓN (SIN OPERACIÓN)'
			*/
			--'E00200102MXN484',
			/*
				'T112 DEVOLUCIÓN (SIN COMPENSAR)'
				'T112 DEVOLUCIÓN (A FAVOR)'
			*/
			'E00200700MXN484', 
			/*
				'T112 DEVOLUCIÓN (LIBERADA)'
			*/
			'E00201300MXN484', 
			/*
				'T112 RECEPCIÓN FAST FUNDS (LIBERADA)'
			*/
			'E00261300MXN484', 
			/*
				'T112 RECEPCIÓN MONEY SEND (LIBERADA)'
			*/
			'E00281300MXN484',
			/*
				'T112 DEVOLUCIÓN (CANCELADA)'
			*/
			'E00201400MXN484',
			/*
				'T112 RECEPCIÓN FAST FUNDS (CANCELADA)'
			*/
			'E00261400MXN484',
			/*
				'T112 RECEPCIÓN MONEY SEND (CANCELADA)'
			*/
			'E00281400MXN484',
			/*
				'T112 RECEPCIÓN FAST FUNDS'
			*/
			'E00260000MXN484',
			/*
				'T112 RECEPCIÓN MONEY SEND'
			*/
			'E00280000MXN484',
			/*
				'T112 PAGO/ABONO A TARJETA (SIN OPERACIÓN)'
			*/
			--'E00280100MXN484',
			/*
				'T112 REVERSO PAGO/ABONO A TARJETA (SIN OPERACIÓN)'
			*/
			--'E00280102MXN484',
			/*
				'T112 CONSULTA DE SALDO EN ATM'
				'T112 CONSULTA DE SALDO EN ATM (DUPLICADA)'
				'T112 CONSULTA DE SALDO EN ATM (POST DEVUELTA)'
				'T112 CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA)'
			*/
			'E00300000MXN484',
			/*
				'T112 CONSULTA DE SALDO EN ATM (SIN OPERACIÓN)'
			*/
			--'E00300100MXN484',
			/*
				'DEVOLUCIÓN (LIBERADA)'
				'RECEPCIÓN FAST FUNDS (LIBERADA)'
				'RECEPCIÓN MONEY SEND (LIBERADA)'
			*/
			'M00201300MXN484',
			/*
				'DEVOLUCIÓN (CANCELADA)'
				'RECEPCIÓN FAST FUNDS (CANCELADA)'
				'RECEPCIÓN MONEY SEND (CANCELADA)'
			*/
			'M00201400MXN484',
			'TMSL'
		)

		SELECT
			*
		FROM
			Eventos
		WHERE
			ClaveEvento LIKE 'E%20%15%'

		SELECT
			*
		FROM
			Eventos
		WHERE
			ClaveEvento LIKE 'E%2%13%'

		SELECT
			*
		FROM
			Eventos
		WHERE
			ClaveEvento LIKE 'E%2%14%'

	DELETE
		er
	FROM
		EventosReglas er
		INNER JOIN @events e
			ON e.idEvento = er.ID_Evento
			AND er.ID_Regla = @idRegla

	INSERT INTO 
		EventosReglas
		(
			ID_Evento,
			ID_Regla,
			EsActiva
		)
	SELECT
		e.idEvento,
		@idRegla,
		1
	FROM
		@events e
END
GO
