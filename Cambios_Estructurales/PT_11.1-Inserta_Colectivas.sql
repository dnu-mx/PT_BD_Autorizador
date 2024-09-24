USE [Autorizador]
GO

BEGIN TRAN

	DECLARE @commit BIT = 1

	DECLARE @ClaveColectivaSwitch VARCHAR(50) = 'SWITCH';

	DECLARE @DescColectivaSwitch VARCHAR(50) = 'SWITCH';

	SELECT * FROM Colectivas
	WHERE ClaveColectiva = @ClaveColectivaSwitch

IF NOT EXISTS(
	SELECT * FROM [dbo].[Colectivas]
	WHERE ClaveColectiva = @ClaveColectivaSwitch
)
BEGIN		   		   
INSERT INTO [dbo].[Colectivas]
           ([ID_TipoColectiva]
           ,[ID_EstatusColectiva]
           ,[ID_ColectivaPadre]
           ,[ID_DUbicacion]
           ,[ID_DFacturacion]
           ,[ClaveColectiva]
           ,[NombreORazonSocial]
           ,[APaterno]
           ,[AMaterno]
           ,[RFC]
           ,[CURP]
           ,[Telefono]
           ,[Movil]
           ,[Email]
           ,[ID_CadenaComercial]
           ,[EsAdministrativa]
           ,[FechaNacimiento]
           ,[FechaCreacion]
           ,[PasswordOperacion]
           ,[Solicitud]
           ,[Email2]
           ,[Aceptacion]
           ,[Nacionalidad]
           ,[EntidadNacimiento]
           ,[Genero]
           ,[TipoIdentificacion]
           ,[NumeroIdentificacion]
           ,[NombreComercial]
           ,[Ocupacion]
           ,[Profesion]
           ,[GiroNegocio])
     VALUES
           ((SELECT ID_TipoColectiva FROM TipoColectiva WHERE ClaveTipoColectiva = 'SWITCH'),
		   1,
		   NULL,
		   NULL,
		   NULL,
		   @ClaveColectivaSwitch,
		   @DescColectivaSwitch,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   GETDATE(),
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL,
		   NULL
		   )
END

	SELECT * FROM Colectivas
	WHERE ClaveColectiva = @ClaveColectivaSwitch

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN