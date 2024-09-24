USE Autorizador
GO

DECLARE @commit BIT
DECLARE @cveRegla_VCANA VARCHAR(10)

SET @commit = 1

SET @cveRegla_VCANA = 'VCANA'

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
--		pv.ClaveRegla = @cveRegla_VCANA
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
		pv.ClaveRegla = @cveRegla_VCANA

	DELETE
		pv
	FROM
		PertenenciaVariantes pv
		LEFT JOIN PertenenciaVarianteEventos pve
			ON pve.ID_PertenenciaVariante = pv.ID_PertenenciaVariante
	WHERE
		pv.ClaveRegla = @cveRegla_VCANA

	INSERT INTO
		PertenenciaVariantes
		(
			ClavePertenenciaTipo,
			ClaveRegla
		)
	SELECT DISTINCT
		pt.Clave,
		@cveRegla_VCANA
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
		AND SUBSTRING(pt.Clave, 4, 7) NOT IN
		(
			'0190000',
			'0290000',
			'P000000',
			'P010000',
			'P180000',
			'P300000'
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
		'E00AD0001' + SUBSTRING(pv.ClavePertenenciaTipo, 11, 6)
	FROM
		PertenenciaVariantes pv WITH (NOLOCK)
	WHERE
		pv.ClaveRegla = @cveRegla_VCANA
		AND SUBSTRING(pv.ClavePertenenciaTipo, 4, 7) IN
		(
			'0200000',
			'0200100',
			'0200101',
			'0200103',
			'0200105',
			'0200109',
			'0200110',
			'0200400',
			'0200410',
			'0260100',
			'0260114',
			'0260115',
			'0280000',
			'0280100',
			'0280114',
			'0280115',
			'R000000',
			'R000100',
			'R000101',
			'R000400',
			'R000410',
			'R010000',
			'R010100',
			'R010101',
			'R010400',
			'R010410',
			'R090000',
			'R090100',
			'R090101',
			'R090400',
			'R090410',
			'R300000',
			'R300100',
			'R300101',
			'R300400',
			'R300410',
			'R300410'
		)

	INSERT INTO
		PertenenciaVarianteEventos
		(
			ID_PertenenciaVariante,
			ClaveEvento
		)
	SELECT
		pv.ID_PertenenciaVariante,
		'E00CD0001' + SUBSTRING(pv.ClavePertenenciaTipo, 11, 6)
	FROM
		PertenenciaVariantes pv WITH (NOLOCK)
	WHERE
		pv.ClaveRegla = @cveRegla_VCANA
		AND SUBSTRING(pv.ClavePertenenciaTipo, 4, 7) IN
		(
			'0000000',
			'0000100',
			'0000101',
			'0000103',
			'0000105',
			'0000109',
			'0000110',
			'0000400',
			'0000410',
			'0000412',
			'0010000',
			'0010100',
			'0010101',
			'0010103',
			'0010105',
			'0010109',
			'0010110',
			'0010400',
			'0010410',
			'0010412',
			'0090000',
			'0090100',
			'0090101',
			'0090103',
			'0090105',
			'0090109',
			'0090110',
			'0090400',
			'0090410',
			'0090412',
			'0120000',
			'0120100',
			'0120101',
			'0120103',
			'0120105',
			'0120109',
			'0120110',
			'0120400',
			'0120410',
			'0120412',
			'0180000',
			'0180100',
			'0180101',
			'0180103',
			'0180105',
			'0180109',
			'0180110',
			'0180400',
			'0180410',
			'0180412',
			'0300000',
			'0300100',
			'0300101',
			'0300103',
			'0300105',
			'0300109',
			'0300110',
			'0300400',
			'0300410',
			'0300412',
			'R120000',
			'R120100',
			'R120101',
			'R120400',
			'R120410',
			'R180000',
			'R180100',
			'R180101',
			'R180400',
			'R180410',
			'R200000',
			'R200103',
			'R280000'
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
--		pv.ClaveRegla = @cveRegla_VCANA
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
		