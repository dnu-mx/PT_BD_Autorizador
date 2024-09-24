use [Autorizador]
GO
BEGIN TRAN

	DECLARE @commit BIT = 1

	DECLARE @VariableNuevaUNO VARCHAR(20) = '0100'
	DECLARE @VariableBaseUNO VARCHAR(20) = '0200'

	DECLARE @VariableNuevaDOS VARCHAR(20) = '0120'
	DECLARE @VariableBaseDOS VARCHAR(20) = '0220'

		--select * from CodigoProceso
		--	where ID_TipoMensaje =  (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = @VariableBaseUNO)

			--select * from CodigoProceso
			--WHERE ID_TipoMensaje  =  (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = @VariableNuevaUNO)

			--select * from CodigoProceso
			--WHERE ID_TipoMensaje  =  (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = @VariableNuevaDOS)
			
----------------------------------------------------------------------------------------------------------------------------
		DELETE CodigoProceso
		WHERE ID_TipoMensaje IN ( SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje IN (
		@VariableNuevaUNO,
		@VariableNuevaDOS
		)
		)
		
		--Insertar en temporal (0100)
		INSERT CodigoProceso
			SELECT CodigoProceso, 
			Descripcion,
			(SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = @VariableNuevaUNO),
			1,
			NULL,
			NULL,
			NULL,
			NULL
		FROM CodigoProceso 
		where ID_TipoMensaje = (Select ID_TipoMensaje from TipoMensajes where ClaveTipoMensaje = @VariableBaseUNO)

		--Insertar en temporal (0120)
		INSERT CodigoProceso
			SELECT CodigoProceso, 
			Descripcion,
			(SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = @VariableNuevaDOS),
			1,
			NULL,
			NULL,
			NULL,
			NULL
		FROM CodigoProceso 
		where ID_TipoMensaje = (Select ID_TipoMensaje from TipoMensajes where ClaveTipoMensaje = @VariableBaseDOS)

---------------------------------------------------------------------------------------------------------------------------
		--select * from CodigoProceso
		--	WHERE ID_TipoMensaje  =  (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = @VariableNuevaUNO)

		--select * from CodigoProceso
		--	WHERE ID_TipoMensaje  =  (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje = @VariableNuevaDOS)

		--select * from CodigoProceso

	IF @commit = 1
		COMMIT TRAN
		ELSE
	ROLLBACK TRAN

