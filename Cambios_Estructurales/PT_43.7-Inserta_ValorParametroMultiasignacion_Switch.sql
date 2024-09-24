USE [Autorizador]
GO

BEGIN TRAN

	DECLARE @commit BIT = 1


	--SELECT * FROM ValorParametroMultiasignacion vpm
	--INNER JOIN ParametrosMultiasignacion pm ON pm.ID_ParametroMultiasignacion = vpm.ID_ParametroMultiasignacion
	--WHERE Clave = '@switchProcesador'


	--select * from Plantillas

	--select * from Producto

	--SELECT * FROM TipoPlantilla

		INSERT INTO [dbo].[ValorParametroMultiasignacion]
           ([ID_ParametroMultiasignacion]
           ,[ID_Plantilla]
           ,[Valor]
           ,[ValorAlertar]
           ,[ValorRechazar]
           ,[ValorBloquear]
           ,[Activo])
		SELECT 
			(SELECT ID_ParametroMultiasignacion FROM ParametrosMultiasignacion WHERE Clave = '@switchProcesador') AS ID_ParametroMultiasignacion ,
			pl.ID_Plantilla,
			(SELECT TOP 1 ID_Colectiva FROM Colectivas WHERE ID_TipoColectiva = (SELECT ID_TipoColectiva FROM TipoColectiva WHERE ClaveTipoColectiva = 'SWITCH')) AS Valor,
			NULL,
			NULL,
			NULL,
			1
		FROM Plantillas pl
		--LEFT JOIN ValorParametroMultiasignacion vpm ON vpm.ID_Plantilla = pl.ID_Plantilla
		WHERE ID_Producto IN (
			SELECT ID_Producto FROM Producto WHERE ID_TipoProducto IN (
				SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = 'JSON01'
				)
			)
		AND ID_TipoPlantilla = (SELECT ID_TipoPlantilla FROM TipoPlantilla WHERE Clave = 'PROD')
		--AND ID_ValorParametroMultiasignacion IS NULL
   
	--SELECT * FROM ValorParametroMultiasignacion vpm
	--INNER JOIN ParametrosMultiasignacion pm ON pm.ID_ParametroMultiasignacion = vpm.ID_ParametroMultiasignacion
	--WHERE Clave = '@switchProcesador'

		IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN