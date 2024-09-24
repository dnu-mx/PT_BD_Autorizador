USE Autorizador
GO

DECLARE @commit BIT
DECLARE @descripcionValorContrato VARCHAR(250)
DECLARE @nombreValorContrato VARCHAR(100)
DECLARE @tipoClasificacionParametro VARCHAR(10)

SET @commit = 1
SET @descripcionValorContrato = 'Valor del Porcentaje de Cuota de Intercambio que comparte el Emisor con el Subemisor'
SET @nombreValorContrato = '@pjeCuotaIntercambioEmisorASubEmisor'
SET @tipoClasificacionParametro = 'COMP'

BEGIN TRAN
	IF NOT EXISTS
	(
		SELECT
			ID_ValorContrato
		FROM
			ValoresContrato p WITH (NOLOCK)
		WHERE
			Nombre = @nombreValorContrato
		)
	BEGIN
		INSERT INTO
			ValoresContrato
			(
				Nombre,
				Descripcion,
				TipoDatoJava,
				TipoDatoSQL,
				esClave,
				ID_ClasificacionParametros,
				Posicion
			)
		SELECT
			@nombreValorContrato,
			@descripcionValorContrato,
			'string',
			'string',
			0,
			(
				SELECT 
					cp.ID_ClasificacionParametros
				FROM 
					ClasificacionParametros cp WITH (NOLOCK)
				WHERE 
					cp.Clave = @tipoClasificacionParametro
			),
			1
	END

	SELECT
		*
	FROM
		ValoresContrato p WITH (NOLOCK)
	WHERE
		Nombre = @nombreValorContrato
	ORDER BY
		Nombre

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN