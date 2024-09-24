USE Autorizador
GO

DECLARE @commit BIT
DECLARE @cveRegla_VDOL VARCHAR(10)

SET @commit = 1

SET @cveRegla_VDOL = 'VDOL'

BEGIN TRAN
	
	/***********************************************************/
	--Selects Excluidos
	/***********************************************************/
	--SELECT
--		*
--	FROM
--		PertenenciaVarianteEventos pve WITH (NOLOCK)
--		INNER JOIN PertenenciaVariantes pv
--			ON pv.ID_PertenenciaVariante = pve.ID_PertenenciaVariante
--	WHERE
--		pv.ClaveRegla = @cveRegla_VDOL
--	ORDER BY
--		ClaveEvento,
--		ClavePertenenciaTipo
	/***********************************************************/

	DELETE
		pve
	FROM
		PertenenciaVariantes pv
		LEFT JOIN PertenenciaVarianteEventos pve
			ON pve.ID_PertenenciaVariante = pv.ID_PertenenciaVariante
	WHERE
		pv.ClaveRegla = @cveRegla_VDOL

	DELETE
		pv
	FROM
		PertenenciaVariantes pv
		LEFT JOIN PertenenciaVarianteEventos pve
			ON pve.ID_PertenenciaVariante = pv.ID_PertenenciaVariante
	WHERE
		pv.ClaveRegla = @cveRegla_VDOL

	INSERT INTO
		PertenenciaVariantes
		(
			ClavePertenenciaTipo,
			ClaveRegla
		)
	SELECT DISTINCT
		pt.Clave,
		@cveRegla_VDOL
	FROM
		TipoProducto tp
		INNER JOIN PertenenciaTipo pt
			ON pt.ClaveTipoProducto = tp.ClaveTipoProducto
		INNER JOIN CodigoProceso cp
			ON cp.ID_codigoProceso = pt.ID_CodigoProceso
	WHERE
		pt.ID_EstatusOperacion IS NOT NULL
		AND pt.Clave LIKE 'P%'
		AND pt.Descripcion LIKE 'COMP%'
		AND SUBSTRING(pt.Clave, 4, 7) IN
		(
			'0200100'
		)

	/***********************************************************/
	--Selects Excluidos
	/***********************************************************/
	--SELECT
--		*
--	FROM
--		TipoProducto tp
--		INNER JOIN PertenenciaTipo pt
--			ON pt.ClaveTipoProducto = tp.ClaveTipoProducto
--		INNER JOIN CodigoProceso cp
--			ON cp.ID_codigoProceso = pt.ID_CodigoProceso
--	WHERE
--		pt.ID_EstatusOperacion IS NOT NULL
--		AND pt.Clave LIKE 'P%'
--		AND pt.Descripcion LIKE 'COMP%'
--	ORDER BY
--		tp.ClaveTipoProducto,
--		cp.CodigoProceso,
--		pt.ID_EstatusOperacion,
--		pt.ID_EstatusPostOperacion
	/***********************************************************/

	INSERT INTO
		PertenenciaVarianteEventos
		(
			ID_PertenenciaVariante,
			ClaveEvento
		)
	SELECT
		pv.ID_PertenenciaVariante,
		'E' + SUBSTRING(pv.ClavePertenenciaTipo, 2, 2) + '201500' + SUBSTRING(pv.ClavePertenenciaTipo, 11, 6)
	FROM
		PertenenciaVariantes pv WITH (NOLOCK)
	WHERE
		pv.ClaveRegla = @cveRegla_VDOL
		AND SUBSTRING(pv.ClavePertenenciaTipo, 4, 7) IN
		(
			'0200100'
		)

	/***********************************************************/
	--Selects Excluidos
	/***********************************************************/
	--SELECT
--		*
--	FROM
--		PertenenciaVarianteEventos pve WITH (NOLOCK)
--		INNER JOIN PertenenciaVariantes pv
--			ON pv.ID_PertenenciaVariante = pve.ID_PertenenciaVariante
--	WHERE
--		pv.ClaveRegla = @cveRegla_VDOL
--	ORDER BY
--		ClaveEvento,
--		ClavePertenenciaTipo
	/***********************************************************/


	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN

	--SELECT
	--	*
	--FROM
	--	PertenenciaVarianteEventos
		