use [Autorizador]
GO
BEGIN TRAN

	DECLARE @commit BIT = 1

	--DECLARANDO LAS VARIABLES A INSERTAR
	DECLARE @Clave1 VARCHAR (10) = '0100'
	DECLARE @Clave2 VARCHAR (10) = '0120'
	DECLARE @Desc1 VARCHAR (100) = 'Transaccional MC'
	DECLARE @Desc2 VARCHAR (100) = 'Avisos de Standing MC'

	----Se reliza un select previo a la operacion
	--Select * From TipoMensajes
	--Where ClaveTipoMensaje IN (
	--	@Clave1,
	--	@Clave2
	--)

	--SE REALIZA UNA REVISION DE SI ESTAN LOS VALORES ANTES DE REALIZAR UN INSERT DE LAS VARIABLES
	
	INSERT INTO TipoMensajes (ClaveTipoMensaje, Descripcion, Activo)
	SELECT @Clave1, @Desc1, 1
	WHERE NOT EXISTS (
		SELECT 1
		FROM TipoMensajes
		WHERE ClaveTipoMensaje = @Clave1 AND Descripcion = @Desc1
	);

	INSERT INTO TipoMensajes (ClaveTipoMensaje, Descripcion, Activo)
	SELECT @Clave2, @Desc2, 1
	WHERE NOT EXISTS (
		SELECT 1
		FROM TipoMensajes
		WHERE ClaveTipoMensaje = @Clave2 AND Descripcion = @Desc2
	);
	----------------------------------------------------------------------------------------------

	----SEGUNDO SELECT PARA REVISAR SI YA SE DIO DE ALTA LOS TIPOS DE MENSAJE
	--Select * From TipoMensajes
	--Where ClaveTipoMensaje IN (
	--	@Clave1,
	--	@Clave2
	--)

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN

