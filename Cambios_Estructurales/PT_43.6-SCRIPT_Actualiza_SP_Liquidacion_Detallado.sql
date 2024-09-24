USE Autorizador
GO

UPDATE
	r
SET
	Sp = 'PN_RPT_LiquidacionDetalladoPlano'
FROM
	Reportes r
WHERE
	ClaveReporte = 'DLIQ'