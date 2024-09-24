BEGIN TRAN
DECLARE @ID_Colectiva INT 

INSERT INTO dbo.Colectivas (ID_TipoColectiva,
                            ID_EstatusColectiva,
                            ClaveColectiva,
                            NombreORazonSocial
                        )
VALUES (4, -- ID_TipoColectiva - int
        1, -- ID_EstatusColectiva - int
      'PAGATODO',
	  'EMISOR PAGATODO'
    )

	SET @ID_Colectiva = @@IDENTITY
	--CREAR LAS CUENTAS DEL EMISOR
	/* 	13, 15,29,57,69,	*/

INSERT INTO dbo.Cuentas (ID_EstatusCuenta,
                         ID_TipoCuenta,
                         ID_GrupoCuenta,
                         ID_ColectivaCuentahabiente,
                         Descripcion,
                         SaldoActual,
                         FechaRegistro)
VALUES (1, 13, NULL, @ID_Colectiva, '', 0, GETDATE());

INSERT INTO dbo.Cuentas (ID_EstatusCuenta,
                         ID_TipoCuenta,
                         ID_GrupoCuenta,
                         ID_ColectivaCuentahabiente,
                         Descripcion,
                         SaldoActual,
                         FechaRegistro)
VALUES (1, 15, NULL, @ID_Colectiva, '', 0, GETDATE());

INSERT INTO dbo.Cuentas (ID_EstatusCuenta,
                         ID_TipoCuenta,
                         ID_GrupoCuenta,
                         ID_ColectivaCuentahabiente,
                         Descripcion,
                         SaldoActual,
                         FechaRegistro)
VALUES (1, 29, NULL, @ID_Colectiva, '', 0, GETDATE());

INSERT INTO dbo.Cuentas (ID_EstatusCuenta,
                         ID_TipoCuenta,
                         ID_GrupoCuenta,
                         ID_ColectivaCuentahabiente,
                         Descripcion,
                         SaldoActual,
                         FechaRegistro)
VALUES (1, 57, NULL, @ID_Colectiva, '', 0, GETDATE());

INSERT INTO dbo.Cuentas (ID_EstatusCuenta,
                         ID_TipoCuenta,
                         ID_GrupoCuenta,
                         ID_ColectivaCuentahabiente,
                         Descripcion,
                         SaldoActual,
                         FechaRegistro)
VALUES (1, 69, NULL, @ID_Colectiva, '', 0, GETDATE());



INSERT INTO dbo.Colectivas (ID_TipoColectiva,
                            ID_EstatusColectiva,
                            ClaveColectiva,
							ID_ColectivaPadre,
                            NombreORazonSocial
                        )
VALUES (5, -- ID_TipoColectiva - int
        1, -- ID_EstatusColectiva - int
		 'GPOPAGATODO',
		@ID_Colectiva,
     
	  'GRUPO PAGATODO'
    )
		SET @ID_Colectiva = @@IDENTITY
	
INSERT INTO dbo.Colectivas (ID_TipoColectiva,
                            ID_EstatusColectiva,
                            ClaveColectiva,
							ID_ColectivaPadre,
                            NombreORazonSocial
                        )
VALUES (6, -- ID_TipoColectiva - int
        1, -- ID_EstatusColectiva - int
		 'CADENAPAGATODO',
		@ID_Colectiva,
     
	  'CADENA PAGATODO'
    )

		SET @ID_Colectiva = @@IDENTITY
		
INSERT INTO dbo.Colectivas (ID_TipoColectiva,
                            ID_EstatusColectiva,
                            ClaveColectiva,
							ID_ColectivaPadre,
                            NombreORazonSocial
                        )
VALUES (2, -- ID_TipoColectiva - int
        1, -- ID_EstatusColectiva - int
		 'EFE001',
		@ID_Colectiva,
     
	  'SUCURSAL PAGATODO'
    )

		SET @ID_Colectiva = @@IDENTITY

		INSERT INTO dbo.Colectivas (ID_TipoColectiva,
                            ID_EstatusColectiva,
                            ClaveColectiva,
							ID_ColectivaPadre,
                            NombreORazonSocial
                        )
VALUES (1, -- ID_TipoColectiva - int
        1, -- ID_EstatusColectiva - int
		 '2000001',
		@ID_Colectiva,
     
	  'AFILIACION PAGATODO'
    )

	INSERT INTO dbo.Colectivas (ID_TipoColectiva,
                            ID_EstatusColectiva,
                            ClaveColectiva,
							ID_ColectivaPadre,
                            NombreORazonSocial
                        )
VALUES (1, -- ID_TipoColectiva - int
        1, -- ID_EstatusColectiva - int
		   '4000002',
		@ID_Colectiva,
   
	  'AFILIACION PAGATODO'
    )


	-- ROLLBACK

--	DBCC CHECKIDENT ('Colectivas', RESEED, 0);  

	
	COMMIT
