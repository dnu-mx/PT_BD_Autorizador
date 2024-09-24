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
	Versi�n:		1.0
	Autor:			Ricardo Monroy        
	Fecha:			10 Mar 2022
	Descripci�n:	Actualiza la relaci�n Eventos - Reglas de los Eventos de Compensaci�n para
					la Regla Valida Operacion Original 
	==========================================================================================
	Versi�n:		1.1
	Autor:			Ricardo Monroy        
	Fecha:			22 Sep 2022
	Descripci�n:	Agrega los Eventos de Fast Funds 
	==========================================================================================
	Versi�n:		1.2
	Autor:			Ricardo Monroy        
	Fecha:			18 Oct 2022
	Descripci�n:	Agrega los Eventos de Devoluciones en L�nea
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
				'T112 COMPRA/CARGO (SIN OPERACI�N)'
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
				'T112 RETIRO EN ATM (SIN OPERACI�N)'
			*/
			--'E00010100MXN484',
			/*
				'T112 RETIRO EN ATM TDC (COMISI�N)'
			*/
			--'E00011000MXN484',
			/*
				'T112 RETIRO EN ATM TDC (IVA COMISI�N)'
			*/
			--'E00011100MXN484',
			/*
				'T112 DEVOLUCI�N'
				'T112 DEVOLUCI�N (REVERSADA PRESENTADA ACLARADA)'
				'T112 COMPRA/CARGO (POST DEVUELTA SIN COMPENSAR)'
				'T112 COMPRA/CARGO (A FAVOR ACLARADA)'
				'T112 RETIRO EN ATM (POST DEVUELTA SIN COMPENSAR)'
				'T112 RETIRO EN ATM (A FAVOR ACLARADA)'
				'T112 CONSULTA DE SALDO EN ATM (POST DEVUELTA SIN COMPENSAR)'
				'T112 CONSULTA DE SALDO EN ATM (A FAVOR ACLARADA)'
			*/
			'E00200000MXN484',
			/*
				'T112 REVERSO DEVOLUCI�N'
			*/
			'E00200002MXN484',
			/*
				'T112 DEVOLUCI�N (EN L�NEA)'
			*/
			'E00201500MXN484',
			/*
				'T112 DEVOLUCI�N (SIN OPERACI�N)'
			*/
			--'E00200100MXN484',
			/*
				'T112 REVERSO DEVOLUCI�N (SIN OPERACI�N)'
			*/
			--'E00200102MXN484',
			/*
				'T112 DEVOLUCI�N (SIN COMPENSAR)'
				'T112 DEVOLUCI�N (A FAVOR)'
			*/
			'E00200700MXN484', 
			/*
				'T112 DEVOLUCI�N (LIBERADA)'
			*/
			'E00201300MXN484', 
			/*
				'T112 RECEPCI�N FAST FUNDS (LIBERADA)'
			*/
			'E00261300MXN484', 
			/*
				'T112 RECEPCI�N MONEY SEND (LIBERADA)'
			*/
			'E00281300MXN484',
			/*
				'T112 DEVOLUCI�N (CANCELADA)'
			*/
			'E00201400MXN484',
			/*
				'T112 RECEPCI�N FAST FUNDS (CANCELADA)'
			*/
			'E00261400MXN484',
			/*
				'T112 RECEPCI�N MONEY SEND (CANCELADA)'
			*/
			'E00281400MXN484',
			/*
				'T112 RECEPCI�N FAST FUNDS'
			*/
			'E00260000MXN484',
			/*
				'T112 RECEPCI�N MONEY SEND'
			*/
			'E00280000MXN484',
			/*
				'T112 PAGO/ABONO A TARJETA (SIN OPERACI�N)'
			*/
			--'E00280100MXN484',
			/*
				'T112 REVERSO PAGO/ABONO A TARJETA (SIN OPERACI�N)'
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
				'T112 CONSULTA DE SALDO EN ATM (SIN OPERACI�N)'
			*/
			--'E00300100MXN484',
			/*
				'DEVOLUCI�N (LIBERADA)'
				'RECEPCI�N FAST FUNDS (LIBERADA)'
				'RECEPCI�N MONEY SEND (LIBERADA)'
			*/
			'M00201300MXN484',
			/*
				'DEVOLUCI�N (CANCELADA)'
				'RECEPCI�N FAST FUNDS (CANCELADA)'
				'RECEPCI�N MONEY SEND (CANCELADA)'
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
