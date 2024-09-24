USE Autorizador
GO

DECLARE @commit BIT

/*	CREDITO CORPORATIVO 01
SET @cveTipoProducto = 'TDCCO001'
SET @cvePais = 'MXN'
SET @cveDivisa = '484'
SET @prefijoEvento = 'E14'
SET @prefijoPertenencia = 'P14'
*/
/*	CREDITO REVOLVENTE 01	
SET @cveTipoProducto = 'TDCRE001'
SET @cvePais = 'MXN'
SET @cveDivisa = '484'
SET @prefijoEvento = 'E05'
SET @prefijoPertenencia = 'P05'
*/
/*	
SET @cveTipoProducto = 'TDDC001'
SET @cvePais = 'MXN'
SET @cveDivisa = '484'
SET @prefijoEvento = 'E08'
SET @prefijoPertenencia = 'P08'
*/
/*	
SET @cveTipoProducto = 'TDCG001'
SET @cvePais = 'MXN'
SET @cveDivisa = '484'
SET @prefijoEvento = 'E11'
SET @prefijoPertenencia = 'P11'
*/
DECLARE @cveDivisa VARCHAR(3)

DECLARE @cveEmisor VARCHAR(10)

DECLARE @cveGrupoMA1 VARCHAR(10)
DECLARE @cveGrupoMA2 VARCHAR(10)

DECLARE @cvePais VARCHAR(3)

DECLARE @cveTipoProducto VARCHAR(10)

DECLARE @idEmisor INT

DECLARE @idGrupoMA1 INT
DECLARE @idGrupoMA2 INT

DECLARE @prefijoEvento VARCHAR(3)
DECLARE @prefijoPertenencia VARCHAR(3)

--select * from eventos where claveevento like 'e%'

SET @commit =  1

SET @cveTipoProducto = 'JSON01'
SET @cvePais = 'MXN'
SET @cveDivisa = '484'
SET @prefijoEvento = 'E02'
SET @prefijoPertenencia = 'P02'

SET @cveEmisor = 'EMI'

SET @cveGrupoMA1 = '001'
SET @cveGrupoMA2 = '002'

BEGIN TRAN

	/***********************************************************/
	--Selects Excluidos
	/***********************************************************/
	--SELECT TOP 1
--		@idEmisor = c.ID_Colectiva
--	FROM
--		Colectivas c
--		INNER JOIN TipoColectiva tc
--			ON tc.ID_TipoColectiva = c.ID_TipoColectiva
--	WHERE
--		tc.ClaveTipoColectiva = @cveEmisor--

--	SELECT
--		@idGrupoMA1 = g.ID_GrupoMA
--	FROM
--		GrupoMA g WITH (NOLOCK)
--	WHERE
--		g.ClaveGrupo = @cveGrupoMA1--

--	SELECT
--		@idGrupoMA2 = g.ID_GrupoMA
--	FROM
--		GrupoMA g WITH (NOLOCK)
--	WHERE
--		g.ClaveGrupo = @cveGrupoMA2
	/***********************************************************/

	IF @idEmisor IS NOT NULL AND @idGrupoMA1 IS NOT NULL AND @idGrupoMA2 IS NOT NULL
	BEGIN

	/***********************************************************/
	--Selects Excluidos
	/***********************************************************/
		--SELECT
--			tp.ClaveTipoProducto,
--			p.Clave,
--			p.Descripcion,
--			P.ID_GrupoCuenta,
--			pt.ClavePertenenciaTipo,
--			pt.Descripcion,
--			pt.CodigoProceso,
--			pt.ID_EstatusOperacion,
--			eo.Clave,
--			eo.Descripcion,
--			pt.ID_EstatusPostOperacion,
--			epo.Clave,
--			epo.Descripcion,
--			e.ClaveEvento,
--			e.Descripcion
--		FROM
--			Producto p
--			INNER JOIN TipoProducto tp
--				ON tp.ID_TipoProducto = p.ID_TipoProducto
--			INNER JOIN Pertenencia pt
--				ON pt.ID_GrupoCuenta = p.ID_GrupoCuenta
--			INNER JOIN PertenenciaEventos pe
--				ON pe.ID_Pertenencia = pt.ID_Pertenencia
--			INNER JOIN Eventos e
--				ON e.ID_Evento = pe.ID_Evento
--			LEFT JOIN EstatusOperacion eo
--				ON eo.ID_EstatusOperacion = pt.ID_EstatusOperacion
--			LEFT JOIN EstatusPostOperacion epo
--				ON epo.ID_EstatusPostOperacion = pt.ID_EstatusPostOperacion
--		WHERE
--			pt.ID_EstatusOperacion IS NOT NULL
--			AND pt.TipoMensaje IN 
--			(
--				'T112',
--				'COMP',
--				'PROC'
--			)
--			AND tp.ClaveTipoProducto IN
--			(
--				@cveTipoProducto
--			)
--		ORDER BY
--			pt.ID_GrupoCuenta,
--			pt.CodigoProceso,
--			pt.ID_EstatusOperacion,
--			pt.ID_EstatusPostOperacion
		/***********************************************************/

		DELETE
			pe
		FROM
			Pertenencia p
			INNER JOIN Producto pr
				ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta
			INNER JOIN TipoProducto tp
				ON tp.ID_TipoProducto = pr.ID_TipoProducto
			LEFT JOIN PertenenciaEventos pe
				ON pe.ID_Pertenencia = p.ID_Pertenencia
			LEFT JOIN ProductoPertenencias pp
				ON pp.ID_Pertenencia = p.ID_Pertenencia
		WHERE
			p.TipoMensaje IN
			(
				'T112',
				'COMP',
				'PROC'
			)
			AND tp.ClaveTipoProducto IN
			(
				@cveTipoProducto
			)
	
		DELETE
			pp
		FROM
			Pertenencia p
			INNER JOIN Producto pr
				ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta
			INNER JOIN TipoProducto tp
				ON tp.ID_TipoProducto = pr.ID_TipoProducto
			LEFT JOIN PertenenciaEventos pe
				ON pe.ID_Pertenencia = p.ID_Pertenencia
			LEFT JOIN ProductoPertenencias pp
				ON pp.ID_Pertenencia = p.ID_Pertenencia
		WHERE
			p.TipoMensaje IN
			(
				'T112',
				'COMP',
				'PROC'
			)
			AND tp.ClaveTipoProducto IN
			(
				@cveTipoProducto
			)

		DELETE
			p
		FROM
			Pertenencia p
			INNER JOIN Producto pr
				ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta
			INNER JOIN TipoProducto tp
				ON tp.ID_TipoProducto = pr.ID_TipoProducto
			LEFT JOIN PertenenciaEventos pe
				ON pe.ID_Pertenencia = p.ID_Pertenencia
			LEFT JOIN ProductoPertenencias pp
				ON pp.ID_Pertenencia = p.ID_Pertenencia
		WHERE
			p.TipoMensaje IN
			(
				'T112',
				'COMP',
				'PROC'
			)
			AND tp.ClaveTipoProducto IN
			(
				@cveTipoProducto
			)
	
		INSERT INTO
			Pertenencia
			(
				ID_ColectivaEmisor,
				ID_GrupoMA,
				ID_GrupoCuenta,
				TipoMensaje,
				Descripcion,
				CodigoProceso,
				ID_EstatusOperacion,
				ID_EstatusPostOperacion,
				EsActiva,
				Moneda,
				ClavePertenenciaTipo
			)
		SELECT DISTINCT
			@idEmisor,
			@idGrupoMA1,
			p.ID_GrupoCuenta,
			--'COMP',
			LEFT(pt.Descripcion, 4),
			pt.Descripcion,
			cp.CodigoProceso,
			pt.ID_EstatusOperacion,
			pt.ID_EstatusPostOperacion,
			1,
			@cveDivisa,
			pt.Clave
		FROM
			Producto p
			INNER JOIN TipoProducto tp
				ON tp.ID_TipoProducto = p.ID_TipoProducto
			INNER JOIN PertenenciaTipo pt
				ON pt.ClaveTipoProducto = tp.ClaveTipoProducto
			INNER JOIN CodigoProceso cp
				ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
		WHERE
			pt.ID_EstatusOperacion IS NOT NULL
			AND pt.Clave LIKE 'P%'
			AND tp.ClaveTipoProducto IN
			(
				@cveTipoProducto
			)
		--ORDER BY
		--	pt.ClaveTipoProducto,
		--	p.Clave,
		--	cp.CodigoProceso,
		--	pt.ID_EstatusOperacion,
		--	pt.ID_EstatusPostOperacion
	
		INSERT INTO
			Pertenencia
			(
				ID_ColectivaEmisor,
				ID_GrupoMA,
				ID_GrupoCuenta,
				TipoMensaje,
				Descripcion,
				CodigoProceso,
				ID_EstatusOperacion,
				ID_EstatusPostOperacion,
				EsActiva,
				Moneda,
				ClavePertenenciaTipo
			)
		SELECT DISTINCT
			@idEmisor,
			@idGrupoMA2,
			p.ID_GrupoCuenta,
			--'COMP',
			LEFT(pt.Descripcion, 4),
			pt.Descripcion,
			cp.CodigoProceso,
			pt.ID_EstatusOperacion,
			pt.ID_EstatusPostOperacion,
			1,
			@cveDivisa,
			pt.Clave
		FROM
			Producto p
			INNER JOIN TipoProducto tp
				ON tp.ID_TipoProducto = p.ID_TipoProducto
			INNER JOIN PertenenciaTipo pt
				ON pt.ClaveTipoProducto = tp.ClaveTipoProducto
			INNER JOIN CodigoProceso cp
				ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
		WHERE
			pt.ID_EstatusOperacion IS NOT NULL
			AND pt.Clave LIKE 'P%'
			AND tp.ClaveTipoProducto IN
			(
				@cveTipoProducto
			)
		--ORDER BY
		--	pt.ClaveTipoProducto,
		--	p.Clave,
		--	cp.CodigoProceso,
		--	pt.ID_EstatusOperacion,
		--	pt.ID_EstatusPostOperacion

		PRINT 'PERTENENCIAEVENTOS'
		
		--SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA/CARGO (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto

		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA/CARGO (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA/CARGO' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000200' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - COMPRA/CARGO (DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003') AND p.Descripcion = 'COMP - COMPRA/CARGO (POST DEVUELTA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000400' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - COMPRA/CARGO (POST DEVUELTA SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - COMPRA/CARGO (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - COMPRA/CARGO (DEVUELTA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA/CARGO (REVERSADA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - COMPRA/CARGO (REVERSADA PRESENTADA DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000600' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012') AND p.Descripcion = 'COMP - COMPRA/CARGO (A FAVOR ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - RETIRO EN ATM (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - RETIRO EN ATM (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - RETIRO EN ATM (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - RETIRO EN ATM' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - RETIRO EN ATM' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - RETIRO EN ATM' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010200' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - RETIRO EN ATM (DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003') AND p.Descripcion = 'COMP - RETIRO EN ATM (POST DEVUELTA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010400' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - RETIRO EN ATM (POST DEVUELTA SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - RETIRO EN ATM (POST DEVUELTA SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - RETIRO EN ATM (POST DEVUELTA SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - RETIRO EN ATM (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - RETIRO EN ATM (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '011100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - RETIRO EN ATM (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - RETIRO EN ATM (DEVUELTA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - RETIRO EN ATM (REVERSADA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - RETIRO EN ATM (REVERSADA PRESENTADA DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '010600' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012') AND p.Descripcion = 'COMP - RETIRO EN ATM (A FAVOR ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA CON CASHBACK' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090200' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (POST DEVUELTA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090400' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (POST DEVUELTA SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (DEVUELTA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (REVERSADA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (REVERSADA PRESENTADA DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090600' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '09' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (A FAVOR ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA CON CASHBACK' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090200' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (POST DEVUELTA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090400' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (POST DEVUELTA SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (DEVUELTA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (REVERSADA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (REVERSADA PRESENTADA DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '090600' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '12' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012') AND p.Descripcion = 'COMP - COMPRA CON CASHBACK (A FAVOR ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA/CARGO (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA/CARGO' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000200' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - COMPRA/CARGO (DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003') AND p.Descripcion = 'COMP - COMPRA/CARGO (POST DEVUELTA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000400' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - COMPRA/CARGO (POST DEVUELTA SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - COMPRA/CARGO (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - COMPRA/CARGO (DEVUELTA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - COMPRA/CARGO (REVERSADA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - COMPRA/CARGO (REVERSADA PRESENTADA DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '000600' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012') AND p.Descripcion = 'COMP - COMPRA/CARGO (A FAVOR ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '19' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - CARGO DE MISCELÁNEO' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - DEVOLUCIÓN (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - DEVOLUCIÓN (SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - DEVOLUCIÓN' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003') AND p.Descripcion = 'COMP - DEVOLUCIÓN' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - DEVOLUCIÓN (SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - DEVOLUCIÓN (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - DEVOLUCIÓN (REVERSADA PRESENTADA ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - DEVOLUCIÓN (A FAVOR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - DEVOLUCIÓN (REVERSADA PRESENTADA ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '280100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '28' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - PAGO/ABONO A TARJETA (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '280000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '28' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - PAGO/ABONO A TARJETA' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '281300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '28' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '014') AND p.Descripcion = 'COMP - PAGO/ABONO A TARJETA (LIBERADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '281400' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '28' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '015') AND p.Descripcion = 'COMP - PAGO/ABONO A TARJETA (CANCELADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00290001' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '29' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - ABONO DE MISCELÁNEO' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300200' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003') AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (POST DEVUELTA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300400' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '005') AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (POST DEVUELTA SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300300' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '009') AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (POST DEVUELTA POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (DEVUELTA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300500' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA DUPLICADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '300600' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = '30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '012') AND p.Descripcion = 'COMP - CONSULTA DE SALDO EN ATM (A FAVOR ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'P00' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REPRESENTACIÓN COMPRA/CARGO' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'P01' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REPRESENTACIÓN RETIRO EN ATM' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'P18' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REPRESENTACIÓN COMPRA/CARGO' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = 'E00190001' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'P30' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REPRESENTACIÓN CONSULTA DE SALDO EN ATM' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R00' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO (SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO (A FAVOR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R00' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO (REVERSADA PRESENTADA ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R01' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO RETIRO EN ATM (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO RETIRO EN ATM (SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - REVERSO RETIRO EN ATM' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO RETIRO EN ATM (A FAVOR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R01' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - REVERSO RETIRO EN ATM (REVERSADA PRESENTADA ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R18' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO (SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO (A FAVOR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R18' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - REVERSO COMPRA/CARGO (REVERSADA PRESENTADA ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200102' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R20' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO DEVOLUCIÓN (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200002' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '003') AND p.Descripcion = 'COMP - REVERSO DEVOLUCIÓN' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '280102' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R28' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO PAGO/ABONO A TARJETA (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200100' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R30' AND ID_EstatusOperacion = 0 AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO CONSULTA DE SALDO EN ATM (SIN OPERACIÓN)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200700' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO CONSULTA DE SALDO EN ATM (SIN COMPENSAR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200000' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '001') AND p.Descripcion = 'COMP - REVERSO CONSULTA DE SALDO EN ATM' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200800' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'COMP - REVERSO CONSULTA DE SALDO EN ATM (A FAVOR)' AND tp.ClaveTipoProducto = @cveTipoProducto
		INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '200900' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'COMP' AND p.EsActiva = 1 AND p.CodigoProceso = 'R30' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'ROK') AND ID_EstatusPostOperacion = (SELECT ID_EstatusPostOperacion FROM EstatusPostOperacion WHERE Clave = '011') AND p.Descripcion = 'COMP - REVERSO CONSULTA DE SALDO EN ATM (REVERSADA PRESENTADA ACLARADA)' AND tp.ClaveTipoProducto = @cveTipoProducto
		--INSERT INTO PertenenciaEventos (ID_Pertenencia, ID_Evento, EsActivo) SELECT DISTINCT p.ID_Pertenencia,(SELECT ID_Evento FROM Eventos WHERE ClaveEvento = @prefijoEvento + '204900' + @cvePais +  @cveDivisa),1 FROM Pertenencia p  INNER JOIN Producto pr ON pr.ID_GrupoCuenta = p.ID_GrupoCuenta INNER JOIN TipoProducto tp ON tp.ID_TipoProducto = pr.ID_TipoProducto WHERE p.TipoMensaje = 'PROC' AND p.EsActiva = 1 AND p.CodigoProceso = '20' AND ID_EstatusOperacion = (SELECT ID_EstatusOperacion FROM EstatusOperacion WHERE Clave = 'AOK') AND ID_EstatusPostOperacion = 0 AND p.Descripcion = 'PROC - DEVOLUCIÓN (POR VENCIMIENTO)' AND tp.ClaveTipoProducto = @cveTipoProducto
		
		/***********************************************************/
		--Selects Excluidos
		/***********************************************************/
		--SELECT
--			pt.ID_Pertenencia,
--			tp.ClaveTipoProducto,
--			p.Clave,
--			p.Descripcion,
--			P.ID_GrupoCuenta,
--			pt.ClavePertenenciaTipo,
--			pt.Descripcion,
--			pt.CodigoProceso,
--			pt.ID_EstatusOperacion,
--			eo.Clave,
--			eo.Descripcion,
--			pt.ID_EstatusPostOperacion,
--			epo.Clave,
--			epo.Descripcion,
--			e.ClaveEvento,
--			e.Descripcion
--		FROM
--			Producto p
--			INNER JOIN TipoProducto tp
--				ON tp.ID_TipoProducto = p.ID_TipoProducto
--			INNER JOIN Pertenencia pt
--				ON pt.ID_GrupoCuenta = P.ID_GrupoCuenta
--			INNER JOIN PertenenciaEventos pe
--				ON pe.ID_Pertenencia = pt.ID_Pertenencia
--			INNER JOIN Eventos e
--				ON e.ID_Evento = pe.ID_Evento
--			LEFT JOIN EstatusOperacion eo
--				ON eo.ID_EstatusOperacion = pt.ID_EstatusOperacion
--			LEFT JOIN EstatusPostOperacion epo
--				ON epo.ID_EstatusPostOperacion = pt.ID_EstatusPostOperacion
--		WHERE
--			pt.ID_EstatusOperacion IS NOT NULL
--			AND pt.TipoMensaje IN 
--			(
--				'COMP',
--				'PROC'
--			)
--			AND tp.ClaveTipoProducto IN
--			(
--				@cveTipoProducto
--			)
--		ORDER BY
--			pt.ID_GrupoCuenta,
--			pt.CodigoProceso,
--			pt.ID_EstatusOperacion,
--			pt.ID_EstatusPostOperacion,
--			pt.ClavePertenenciaTipo
		/***********************************************************/

		--SELECT
		--	tp.ClaveTipoProducto,
		--	p.Clave,
		--	p.Descripcion,
		--	P.ID_GrupoCuenta,
		--	pt.ClavePertenenciaTipo,
		--	pt.Descripcion,
		--	pt.CodigoProceso,
		--	pt.ID_EstatusOperacion,
		--	pt.ID_EstatusPostOperacion,
		--	e.ClaveEvento,
		--	e.Descripcion
		--FROM
		--	Producto p
		--	INNER JOIN TipoProducto tp
		--		ON tp.ID_TipoProducto = p.ID_TipoProducto
		--	INNER JOIN Pertenencia pt
		--		ON pt.ID_GrupoCuenta = P.ID_GrupoCuenta
		--	LEFT JOIN PertenenciaEventos pe
		--		ON pe.ID_Pertenencia = pt.ID_Pertenencia
		--	LEFT JOIN Eventos e
		--		ON e.ID_Evento = pe.ID_Evento
		--WHERE
		--	pt.ID_EstatusOperacion IS NOT NULL
		--	AND pt.TipoMensaje LIKE 'COMP'
		--	AND tp.ClaveTipoProducto IN
		--	(
		--		@cveTipoProducto
		--	)
		--ORDER BY
		--	pt.ID_GrupoCuenta,
		--	pt.CodigoProceso,
		--	pt.ID_EstatusOperacion,
		--	pt.ID_EstatusPostOperacion
	END
	ELSE
		PRINT 'No se obtuvo información'
	
	IF @commit = 1
		COMMIT TRAN
	ELSE 
		ROLLBACK TRAN