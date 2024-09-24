USE Autorizador
GO

DECLARE @commit BIT

/*	CREDITO CORPORATIVO 01
	SET @cveTipoProducto = 'TDCCO001'
	SET @cvePais = 'MXN'
	SET @cveDivisa = '484'
	SET @prefijoEvento = 'E14'
	SET @prefijoPertenencia = 'P14'
		
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 1
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 1
	SET @codigoProceso_FastFund = 0
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
/*	CREDITO REVOLVENTE 01	
	SET @cveTipoProducto = 'TDCRE001'
	SET @cvePais = 'MXN'
	SET @cveDivisa = '484'
	SET @prefijoEvento = 'E05'
	SET @prefijoPertenencia = 'P05'
		
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 1
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 1
	SET @codigoProceso_FastFund = 0
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
/*	COSTA RICA COLONES
	SET @cveTipoProducto = 'CRC-CRI001'
	SET @cvePais = 'CRI'
	SET @cveDivisa = '188'
	SET @prefijoEvento = 'E01'
	SET @prefijoPertenencia = 'P01'
		
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 1
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 1
	SET @codigoProceso_FastFund = 0
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
/*	COSTA RICA DOLARES
	SET @cveTipoProducto = 'USD-CRI001'
	SET @cvePais = 'CRI'
	SET @cveDivisa = '840'
	SET @prefijoEvento = 'E01'
	SET @prefijoPertenencia = 'P01'
		
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 1
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 1
	SET @codigoProceso_FastFund = 0
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
/*	EL SALVADOR DOLARES
	SET @cveTipoProducto = 'USD-SLV001'
	SET @cvePais = 'SLV'
	SET @cveDivisa = '840'
	SET @prefijoEvento = 'E01'
	SET @prefijoPertenencia = 'P01'
		
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 1
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 1
	SET @codigoProceso_FastFund = 0
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
/*	HONDURAS LEMPIRAS
	SET @cveTipoProducto = 'HNL-001'
	SET @cvePais = 'HNL'
	SET @cveDivisa = '340'
	SET @prefijoEvento = 'E01'
	SET @prefijoPertenencia = 'P01'
		
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 1
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 1
	SET @codigoProceso_FastFund = 0
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
/*	COSTA RICA RIDIVI
	SET @cveTipoProducto = 'RIDIVI'
	SET @cvePais = 'CRI'
	SET @cveDivisa = '188'
	SET @prefijoEvento = 'E02'
	SET @prefijoPertenencia = 'P02'
	
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 0
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 0
	SET @codigoProceso_FastFund = 1
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
/*	ULTRANOVEL MXN
	SET @cveTipoProducto = 'TDDC001'
	SET @cvePais = 'MXN'
	SET @cveDivisa = '484'
	SET @prefijoEvento = 'E08'
	SET @prefijoPertenencia = 'P08'
	
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_RetiroComision = 0
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 0
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 0
	SET @codigoProceso_FastFund = 0
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
/*	ULTRANOVEL MXN
	SET @cveTipoProducto = 'TDCG001'
	SET @cvePais = 'MXN'
	SET @cveDivisa = '484'
	SET @prefijoEvento = 'E11'
	SET @prefijoPertenencia = 'P11'
	
	SET @codigoProceso_Compra = 1
	SET @codigoProceso_Retiro = 1
	SET @codigoProceso_RetiroComision = 0
	SET @codigoProceso_Consulta = 1
	SET @codigoProceso_CashBack = 0
	SET @codigoProceso_Devolucion = 1
	SET @codigoProceso_PagoTarjeta = 1
	SET @codigoProceso_MoneySend = 0
	SET @codigoProceso_FastFund = 0
	SET @codigoProceso_Miscelaneo = 1
	SET @codigoProceso_Representacion = 1
*/
DECLARE @codigoProceso_CashBack BIT
DECLARE @codigoProceso_Compra BIT
DECLARE @codigoProceso_Consulta BIT
DECLARE @codigoProceso_Devolucion BIT
DECLARE @codigoProceso_FastFund BIT
DECLARE @codigoProceso_Miscelaneo BIT
DECLARE @codigoProceso_MoneySend BIT
DECLARE @codigoProceso_PagoTarjeta BIT
DECLARE @codigoProceso_Representacion BIT
DECLARE @codigoProceso_Retiro BIT
DECLARE @codigoProceso_RetiroComision BIT

DECLARE @cveTipoProducto VARCHAR(10)
DECLARE @cvePais VARCHAR(3)
DECLARE @cveDivisa VARCHAR(3)

DECLARE @prefijoEvento VARCHAR(3)
DECLARE @prefijoPertenencia VARCHAR(3)

SET @commit =  1

--SELECT * FROM PertenenciaTIPO WHERE CLAVE LIKE 'P%'
--SELECT * FROM TipoProducto
--SELECT * FROM Producto

SET @cveTipoProducto = 'JSON01'
SET @cvePais = 'MXN'
SET @cveDivisa = '484'
SET @prefijoEvento = 'E02'
SET @prefijoPertenencia = 'P02'

SET @codigoProceso_Compra = 1
SET @codigoProceso_Retiro = 1
SET @codigoProceso_RetiroComision = 0
SET @codigoProceso_Consulta = 1
SET @codigoProceso_CashBack = 1
SET @codigoProceso_Devolucion = 1
SET @codigoProceso_PagoTarjeta = 1
SET @codigoProceso_MoneySend = 1
SET @codigoProceso_FastFund = 0
SET @codigoProceso_Miscelaneo = 1
SET @codigoProceso_Representacion = 1

BEGIN TRAN

/***********************************************************/
--Selects Excluidos
/***********************************************************/
--	SELECT
--		pt.ClaveTipoProducto,
--		pt.Clave,
--		pt.Descripcion,
--		cp.CodigoProceso,
--		pt.ID_EstatusOperacion,
--		eo.Clave,
--		eo.Descripcion,
--		pt.ID_EstatusPostOperacion,
--		epo.Clave,
--		epo.Descripcion,
--		e.ClaveEvento,
--		e.Descripcion,
--		e.EsActivo
--	FROM
--		PertenenciaTipo pt
--		INNER JOIN CodigoProceso cp
--			ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
--		LEFT JOIN PertenenciaTipoEvento pe
--			ON pe.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
--		LEFT JOIN Eventos e
--			ON e.ID_Evento = pe.ID_Evento
--		LEFT JOIN EstatusOperacion eo
--			ON eo.ID_EstatusOperacion = pt.ID_EstatusOperacion
--		LEFT JOIN EstatusPostOperacion epo
--			ON epo.ID_EstatusPostOperacion = pt.ID_EstatusPostOperacion
--	WHERE
--		pt.ID_EstatusPostOperacion IS NOT NULL
--		AND pt.Clave LIKE 'P%'
--		AND pt.ClaveTipoProducto IN
--		(
--			@cveTipoProducto
--		)
--	ORDER BY
--		pt.ClaveTipoProducto,
--		cp.CodigoProceso,
--		pt.ID_EstatusOperacion,
--		pt.ID_EstatusPostOperacion
/***********************************************************/

	DELETE
		tppt
	FROM
		PertenenciaTipo pt
		LEFT JOIN PertenenciaTipoEvento pte
			ON pte.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
		LEFT JOIN TipoProductoPertenenciaTipo tppt
			ON tppt.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
	WHERE
		ID_EstatusOperacion IS NOT NULL
		AND Clave LIKE 'P%'
		AND ClaveTipoProducto IN
		(
			@cveTipoProducto
		)

	DELETE
		pte
	FROM
		PertenenciaTipo pt
		LEFT JOIN PertenenciaTipoEvento pte
			ON pte.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
		LEFT JOIN TipoProductoPertenenciaTipo tppt
			ON tppt.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
	WHERE
		ID_EstatusOperacion IS NOT NULL
		AND Clave LIKE 'P%'
		AND ClaveTipoProducto IN
		(
			@cveTipoProducto
		)

	DELETE
		pt
	FROM
		PertenenciaTipo pt
		LEFT JOIN PertenenciaTipoEvento pte
			ON pte.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
		LEFT JOIN TipoProductoPertenenciaTipo tppt
			ON tppt.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
	WHERE
		ID_EstatusOperacion IS NOT NULL
		AND Clave LIKE 'P%'
		AND ClaveTipoProducto IN
		(
			@cveTipoProducto
		)
		
	PRINT 'PertenenciaTipo'

	IF @codigoProceso_Compra = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000000' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000100' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000101' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000103' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (POST DEVUELTA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000105' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (POST DEVUELTA SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000109' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (POST DEVUELTA POR VENCIMIENTO)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000110' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (DEVUELTA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000400' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (REVERSADA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000410' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (REVERSADA PRESENTADA DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0000412' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (A FAVOR ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012')
		
		/***********************************************************/
		--Selects Excluidos
		/***********************************************************/
		--SELECT * FROM Eventos WHERE ClaveEvento LIKE 'E%'
		/***********************************************************/

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000200' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000103' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000400' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000110' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000412' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000600' + @cvePais + @cveDivisa), 1
		
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000103' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000105' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000109' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000110' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0000412' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180000' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180100' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180101' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180103' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (POST DEVUELTA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180105' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (POST DEVUELTA SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180109' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (POST DEVUELTA POR VENCIMIENTO)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180110' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (DEVUELTA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180400' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (REVERSADA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180410' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (REVERSADA PRESENTADA DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0180412' + @cvePais + @cveDivisa,'COMP - COMPRA/CARGO (A FAVOR ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012')

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000200' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180103' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000400' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180110' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180412' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000600' + @cvePais + @cveDivisa), 1
			
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180103' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180105' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180109' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180110' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0180412' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1

		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R000000' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R00'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R000100' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO (SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R000101' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R000400' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO (A FAVOR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R000410' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO (REVERSADA PRESENTADA ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R00'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais + @cveDivisa), 1
		
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R000410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R180000' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R18'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R180100' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO (SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R180101' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R180400' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO (A FAVOR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R180410' + @cvePais + @cveDivisa,'COMP - REVERSO COMPRA/CARGO (REVERSADA PRESENTADA ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R18'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R180410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais + @cveDivisa), 1
	
		IF @codigoProceso_Representacion = 1
		BEGIN
			INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'P000000' + @cvePais + @cveDivisa,'COMP - REPRESENTACIÓN COMPRA/CARGO',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'P00'), 0, 0

			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'P000000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais + @cveDivisa), 1

			INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'P000000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1

			INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'P180000' + @cvePais + @cveDivisa,'COMP - REPRESENTACIÓN COMPRA/CARGO',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'P18'), 0, 0

			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'P180000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais + @cveDivisa), 1

			INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'P180000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		END
	END

	IF @codigoProceso_Retiro = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010000' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010100' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010101' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010103' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (POST DEVUELTA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010105' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (POST DEVUELTA SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010109' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (POST DEVUELTA POR VENCIMIENTO)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010110' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (DEVUELTA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010400' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (REVERSADA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010410' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (REVERSADA PRESENTADA DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0010412' + @cvePais + @cveDivisa,'COMP - RETIRO EN ATM (A FAVOR ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012')

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010200' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010103' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010400' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010110' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010412' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010600' + @cvePais + @cveDivisa), 1

		IF @codigoProceso_RetiroComision = 1
		BEGIN
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011000' + @cvePais + @cveDivisa), 1
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011100' + @cvePais + @cveDivisa), 1
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011000' + @cvePais + @cveDivisa), 1
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011100' + @cvePais + @cveDivisa), 1
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011000' + @cvePais + @cveDivisa), 1
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011100' + @cvePais + @cveDivisa), 1
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011000' + @cvePais + @cveDivisa), 1
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011100' + @cvePais + @cveDivisa), 1
		END

		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010103' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010105' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010109' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010110' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0010412' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1

		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R010000' + @cvePais + @cveDivisa,'COMP - REVERSO RETIRO EN ATM (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R01'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R010100' + @cvePais + @cveDivisa,'COMP - REVERSO RETIRO EN ATM (SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R010101' + @cvePais + @cveDivisa,'COMP - REVERSO RETIRO EN ATM',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R010400' + @cvePais + @cveDivisa,'COMP - REVERSO RETIRO EN ATM (A FAVOR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R010410' + @cvePais + @cveDivisa,'COMP - REVERSO RETIRO EN ATM (REVERSADA PRESENTADA ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R01'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais + @cveDivisa), 1
	
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R010410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
			
		IF @codigoProceso_Representacion = 1
		BEGIN
			INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'P010000' + @cvePais + @cveDivisa,'COMP - REPRESENTACIÓN RETIRO EN ATM',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'P01'), 0, 0
			
			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'P010000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais + @cveDivisa), 1
			
			INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'P010000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		END
	END

	IF @codigoProceso_Consulta = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300000' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300100' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300101' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300103' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (POST DEVUELTA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300105' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (POST DEVUELTA SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300109' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (POST DEVUELTA POR VENCIMIENTO)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300110' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (DEVUELTA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300400' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300410' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0300412' + @cvePais + @cveDivisa,'COMP - CONSULTA DE SALDO EN ATM (A FAVOR ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012')
				
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300200' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300103' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300400' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300110' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300412' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300600' + @cvePais + @cveDivisa), 1

		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300103' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300105' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300109' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300110' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0300412' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R300000' + @cvePais + @cveDivisa,'COMP - REVERSO CONSULTA DE SALDO EN ATM (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R30'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R300100' + @cvePais + @cveDivisa,'COMP - REVERSO CONSULTA DE SALDO EN ATM (SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R300101' + @cvePais + @cveDivisa,'COMP - REVERSO CONSULTA DE SALDO EN ATM',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R300400' + @cvePais + @cveDivisa,'COMP - REVERSO CONSULTA DE SALDO EN ATM (A FAVOR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R300410' + @cvePais + @cveDivisa,'COMP - REVERSO CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R30'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais + @cveDivisa), 1

		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R300410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		
		IF @codigoProceso_Representacion = 1
		BEGIN
			INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'P300000' + @cvePais + @cveDivisa,'COMP - REPRESENTACIÓN CONSULTA DE SALDO EN ATM',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'P30'), 0, 0

			INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'P300000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais + @cveDivisa), 1

			INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'P300000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		END
	END

	IF @codigoProceso_CashBack = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090000' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090100' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090101' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090103' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (POST DEVUELTA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090105' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (POST DEVUELTA SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090109' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (POST DEVUELTA POR VENCIMIENTO)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090110' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (DEVUELTA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090400' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (REVERSADA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090410' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (REVERSADA PRESENTADA DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0090412' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (A FAVOR ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '09'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012')

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090200' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090103' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090400' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090110' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090412' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090600' + @cvePais + @cveDivisa), 1

		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090103' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090105' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090109' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090110' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0090412' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120000' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120100' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120101' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120103' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (POST DEVUELTA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120105' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (POST DEVUELTA SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120109' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (POST DEVUELTA POR VENCIMIENTO)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120110' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (DEVUELTA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120400' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (REVERSADA PRESENTADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120410' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (REVERSADA PRESENTADA DUPLICADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0120412' + @cvePais + @cveDivisa,'COMP - COMPRA CON CASHBACK (A FAVOR ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '12'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012')

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090200' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120103' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090400' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120110' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120412' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090600' + @cvePais + @cveDivisa), 1
	
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120103' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120105' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120109' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120110' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0120412' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	END

	IF @codigoProceso_Devolucion = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200000' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200100' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN (SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200101' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200103' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200105' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN (SIN COMPENSAR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200109' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN (POST DEVUELTA POR VENCIMIENTO)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200110' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN (REVERSADA PRESENTADA ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200400' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN (A FAVOR)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0200410' + @cvePais + @cveDivisa,'COMP - DEVOLUCIÓN (REVERSADA PRESENTADA ACLARADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011')
	
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200101' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200103' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200105' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200109' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200110' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200400' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200410' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais + @cveDivisa), 1

		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200101' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200103' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200105' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200109' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200110' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200400' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0200410' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R200000' + @cvePais + @cveDivisa,'COMP - REVERSO DEVOLUCIÓN (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R20'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R200103' + @cvePais + @cveDivisa,'COMP - REVERSO DEVOLUCIÓN',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R20'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003')

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R200000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200102' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R200103' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200002' + @cvePais + @cveDivisa), 1
	
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R200000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R200103' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	END

	IF @codigoProceso_PagoTarjeta = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0280000' + @cvePais + @cveDivisa,'COMP - PAGO/ABONO A TARJETA (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '28'), 0, 0
		
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0280000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '280100' + @cvePais + @cveDivisa), 1
		
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0280000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + 'R280000' + @cvePais + @cveDivisa,'COMP - REVERSO PAGO/ABONO A TARJETA (SIN OPERACIÓN)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = 'R28'), 0, 0
	
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R280000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '280102' + @cvePais + @cveDivisa), 1

		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + 'R280000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	END

	IF @codigoProceso_MoneySend = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0280100' + @cvePais + @cveDivisa,'COMP - PAGO/ABONO A TARJETA',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '28'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		--INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0280114' + @cvePais + @cveDivisa,'COMP - PAGO/ABONO A TARJETA (LIBERADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '28'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '014') 
		--INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0280115' + @cvePais + @cveDivisa,'COMP - PAGO/ABONO A TARJETA (CANCELADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '28'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '015')

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0280100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '280000' + @cvePais + @cveDivisa), 1
		--INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0280114' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '281300' + @cvePais + @cveDivisa), 1
		--INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0280115' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '281400' + @cvePais + @cveDivisa), 1

		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0280100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		--INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0280114' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		--INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0280115' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	END

	IF @codigoProceso_FastFund = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0260100' + @cvePais + @cveDivisa,'COMP - FAST FUND',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '26'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0260114' + @cvePais + @cveDivisa,'COMP - FAST FUND (LIBERADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '26'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '014') 
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0260115' + @cvePais + @cveDivisa,'COMP - FAST FUND (CANCELADA)',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '26'), (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK'), (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '015')
	
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0260100' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '260000' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0260114' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '261300' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0260115' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '261400' + @cvePais + @cveDivisa), 1

		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0260100' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0260114' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0260115' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	END

	IF @codigoProceso_Miscelaneo = 1
	BEGIN
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0190000' + @cvePais + @cveDivisa,'COMP - CARGO DE MISCELÁNEO',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '19'), 0, 0
		INSERT INTO PertenenciaTipo (ClaveTipoProducto, Clave, Descripcion, ID_CodigoProceso, ID_EstatusOperacion, ID_EstatusPostOperacion) SELECT @cveTipoProducto, @prefijoPertenencia + '0290000' + @cvePais + @cveDivisa,'COMP - ABONO DE MISCELÁNEO',(SELECT cp.ID_CodigoProceso FROM CodigoProceso cp INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje WHERE tm.ClaveTipoMensaje = 'COMP' AND cp.CodigoProceso = '29'), 0, 0

		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0190000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais + @cveDivisa), 1
		INSERT INTO PertenenciaTipoEvento (ID_PertenenciaTipo, ID_Evento, Activo) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0290000' + @cvePais + @cveDivisa),(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00290001' + @cvePais + @cveDivisa), 1
	
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0190000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
		INSERT INTO TipoProductoPertenenciaTipo (ID_PertenenciaTipo, ID_TipoProducto, Activa) SELECT (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @cveTipoProducto AND Clave = @prefijoPertenencia + '0290000' + @cvePais + @cveDivisa),(SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @cveTipoProducto), 1
	END

/***********************************************************/
--Selects Excluidos
/***********************************************************/
--	SELECT
--		pt.ClaveTipoProducto,
--		pt.Clave,
--		pt.Descripcion,
--		cp.CodigoProceso,
--		pt.ID_EstatusOperacion,
--		eo.Clave,
--		eo.Descripcion,
--		pt.ID_EstatusPostOperacion,
--		epo.Clave,
--		epo.Descripcion,
--		e.ClaveEvento,
--		e.Descripcion,
--		e.EsActivo
--	FROM
--		PertenenciaTipo pt
--		INNER JOIN CodigoProceso cp
--			ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
--		LEFT JOIN PertenenciaTipoEvento pe
--			ON pe.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
--		LEFT JOIN Eventos e
--			ON e.ID_Evento = pe.ID_Evento
--		LEFT JOIN EstatusOperacion eo
--			ON eo.ID_EstatusOperacion = pt.ID_EstatusOperacion
--		LEFT JOIN EstatusPostOperacion epo
--			ON epo.ID_EstatusPostOperacion = pt.ID_EstatusPostOperacion
--	WHERE
--		pt.ID_EstatusPostOperacion IS NOT NULL
--		AND pt.Clave LIKE 'P%'
--		AND pt.ClaveTipoProducto IN
--		(
--			@cveTipoProducto
--		)
--	ORDER BY
--		pt.ClaveTipoProducto,
--		cp.CodigoProceso,
--		pt.ID_EstatusOperacion,
--		pt.ID_EstatusPostOperacion
/***********************************************************/
	
	IF @commit = 1
		COMMIT TRAN
	ELSE 
		ROLLBACK TRAN