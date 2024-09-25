USE  [Autorizador]
GO

BEGIN TRAN

	DECLARE @commit BIT = 1

    BEGIN TRY

		DECLARE @ClaveNumericaDivisa VARCHAR (3)= '484'

        PRINT('DECLARACION TIPOS COLECTIVA, TIPOS CUENTA, CLAVE EVENTOS')
	
	DECLARE @ClaveEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR VARCHAR(50)= 'M00LQ0000MXN484'
		DECLARE @DescEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR VARCHAR(500) = 'LIQUIDACIÓN (DE SUBEMISOR A EMISOR)'
		DECLARE @DescEdoCuentaLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR VARCHAR(500) = 'LIQUIDACIÓN DE SUBEMISOR A EMISOR'
		
		DECLARE @ClaveEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR VARCHAR(50)= 'M00AG0000MXN484'
		DECLARE @DescEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR VARCHAR(500)= 'AUMENTO DE GARANTÍA DEL SUBEMISOR'
		DECLARE @DescEdoCuentaAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR VARCHAR(500)= 'AUMENTO DE GARANTÍA DEL SUBEMISOR'

		DECLARE @ClaveEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR VARCHAR(50)= 'M00DG0000MXN484'
		DECLARE @DescEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR VARCHAR(500) = 'DISMINUCIÓN DE GARANTÍA DEL SUBEMISOR'
		DECLARE @DescEdoCuentaDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR VARCHAR(500) = 'DISMINUCIÓN DE GARANTÍA DEL SUBEMISOR'

		  DECLARE @idEventoExistente BIGINT,
           @script1  BIGINT,
           @script2  BIGINT,
           @script3  BIGINT,
           @script4  BIGINT,
           @script5  BIGINT,
           @script6  BIGINT,
		   @idScriptEventoExistente BIGINT,
		   @idScriptExistente BIGINT


--TIPOS DE EVENTOS
	DECLARE @IDTipoEventoAutomatico VARCHAR(3) = (SELECT ID_TipoEvento FROM TipoEvento WITH (NOLOCK) WHERE Clave = '003')
	DECLARE @IDTipoEventoManual VARCHAR(3) = (SELECT ID_TipoEvento FROM TipoEvento WITH (NOLOCK) WHERE Clave = '002')
	DECLARE @IDTipoEventoTransaccional VARCHAR(3) = (SELECT ID_TipoEvento FROM TipoEvento WITH (NOLOCK) WHERE Clave = '001')

	

--TIPOS DE COLECTIVAS
        --DECLARE @colectivaPadreTarjeta INT = ( SELECT ID_TipoColectiva FROM TipoColectiva  WHERE ClaveTipoColectiva = 'PTH' )
		--IF NOT EXISTS
		--(
		--	SELECT * FROM TipoColectiva WITH (NOLOCK) 
		--	WHERE ClaveTipoColectiva = 'BANE'
		--)
		--BEGIN
		--	INSERT INTO TipoColectiva(ID_TipoColectivaPadre, ID_TipoColectivaHijo, ClaveTipoColectiva, Descripcion, LongitudClave, EsPolimorfica)
		--	VALUES (NULL, NULL, 'BANE', 'Banco del Emisor', 50, 0)
		--END
		--IF NOT EXISTS
		--(
		--	SELECT * FROM TipoColectiva WITH (NOLOCK) 
		--	WHERE ClaveTipoColectiva = 'BANS'
		--)
		--BEGIN
		--	INSERT INTO TipoColectiva(ID_TipoColectivaPadre, ID_TipoColectivaHijo, ClaveTipoColectiva, Descripcion, LongitudClave, EsPolimorfica)
		--	VALUES (NULL, NULL, 'BANS', 'Banco del SubEmisor', 50, 0)
		--END
        DECLARE @colectivaSubEmisor INT = ( SELECT ID_TipoColectiva FROM TipoColectiva  WHERE ClaveTipoColectiva = 'GCM' )
		DECLARE @colectivaSwitch INT = ( SELECT ID_TipoColectiva FROM TipoColectiva WHERE ClaveTipoColectiva = 'SWITCH' )
        DECLARE @colectivaEmisor INT = ( SELECT ID_TipoColectiva FROM TipoColectiva WHERE ClaveTipoColectiva = 'EMI' ) 
        DECLARE @colectivaCH INT = (SELECT ID_TipoColectiva FROM TipoColectiva WHERE ClaveTipoColectiva = 'CCH' )
		--DECLARE @colectivaBANE INT = (SELECT ID_TipoColectiva FROM TipoColectiva WHERE ClaveTipoColectiva = 'BANE' )
		--DECLARE @colectivaBANS INT = (SELECT ID_TipoColectiva FROM TipoColectiva WHERE ClaveTipoColectiva = 'BANS' )


		--TIPOS DE CUENTA
        DECLARE @idCuenta3 INT  =   ( SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'CCLC'  )

        DECLARE @idCuenta54 INT  =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'CDC' )
        
		DECLARE @idCuenta15 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'CXP' )
        
		DECLARE @idCuenta57 INT  =   ( SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'PRAUT' )
        
		DECLARE @idCuenta70 INT =   ( SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'FEECOLL')
        
		DECLARE @idCuenta28 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'TXACL' )

		DECLARE @idCuenta72 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'SBC' )

		DECLARE @idCuenta7 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'IVA' )

		DECLARE @idCuenta13 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'COMS' )

		DECLARE @idCuentaX INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'MRKUP' )

		DECLARE @idCuenta8 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'CBNR' )

		DECLARE @idCuenta5 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'BAN' )

		DECLARE @idCuenta61 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'INTORD' )

		DECLARE @idCuenta62 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'INTMOR' )

		DECLARE @idCuenta2 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'CLDC' )

		DECLARE @idCuenta29 INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'CRED' )

		DECLARE @idCuentaCBND INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'CBND' )

		DECLARE @idCuentaSTP INT =   (  SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'STP' )

			IF (
				   @idCuenta3 IS NULL
				   OR @idCuenta54 IS NULL
				   OR @idCuenta15 IS NULL
				   OR @idCuenta57 IS NULL
				   OR @idCuenta72 IS NULL
				   OR @idCuenta28 IS NULL
				   OR @idCuenta70 IS NULL
				   OR @idCuenta7 IS NULL
				   OR @idCuenta13 IS NULL
				   --OR @idCuentaX IS NULL
				   OR @idCuenta8 IS NULL
				   OR @idCuenta5 IS NULL
				   OR @idCuenta61 IS NULL
				   OR @idCuenta62 IS NULL
				   OR @idCuenta2 IS NULL
				   OR @idCuenta29 IS NULL
				   OR @idCuentaCBND IS NULL
			   )
				BEGIN

				SELECT  @idCuenta3 AS C03, @idCuenta54 AS C54, @idCuenta15 AS C15, @idCuenta57 AS C57, @idCuenta72 AS C72,  @idCuenta28 AS C28,  
				@idCuenta72 AS C72, @idCuenta70 AS C70, @idCuenta7 AS C7, @idCuenta13 AS C13, --@idCuentaX AS CX, 
				@idCuenta8 AS C8, @idCuenta5 AS C5,
				@idCuenta61 AS C61, @idCuenta62 AS C62, @idCuenta2 AS C2, @idCuenta29 AS C29, @idCuentaCBND AS CCBND
					RAISERROR('NO SE IDENTIFICO ALGUNO DE LOS TIPOS DE CUENTA', 16, 1)
					RETURN
				END

			IF (
				   @colectivaSubEmisor IS NULL
				   OR @colectivaSwitch IS NULL
				   OR @colectivaCH IS NULL
				   OR @colectivaEmisor IS NULL
				   --OR @colectivaBANE IS NULL
				   --OR @colectivaBANS IS NULL
			   )
				BEGIN
					RAISERROR('NO SE IDENTIFICO ALGUNO DE LOS TIPOS DE COLECTIVA', 16, 1)
					RETURN
				END

		--EXEC ProcMan_Comp_GetEventoScripts @ClaveEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR
		--EXEC ProcMan_Comp_GetEventoScripts @ClaveEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR  
		--EXEC ProcMan_Comp_GetEventoScripts @ClaveEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR

/**ACLARACIÓN EN PROCESO (ABONO)*/
PRINT('INICIO GENERACIÓN EVENTOS')
/**LIQUIDACIÓN (DE SUBEMISOR A EMISOR)*/
	IF NOT EXISTS
	(
		SELECT ID_Evento FROM Eventos e WITH (NOLOCK) 
		WHERE ClaveEvento = @ClaveEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR
	)
		BEGIN 

            INSERT INTO Eventos ( ClaveEvento, Descripcion,  EsActivo, EsReversable, EsCancelable, EsTransaccional, ID_TipoEvento,  DescripcionEdoCta, GeneraPoliza, PreValidaciones, PostValidaciones, ClaveEventoEdoCta )
            VALUES ( @ClaveEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR, @DescEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR, 1, 1, 1, 0, @IDTipoEventoManual	, @DescEdoCuentaLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR, 1, 0, 0, @ClaveEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR )

            SET @idEventoExistente = SCOPE_IDENTITY()
		END
	ELSE
	BEGIN
		SET @idEventoExistente = (SELECT ID_Evento FROM Eventos e WITH (NOLOCK) WHERE ClaveEvento = @ClaveEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR )
	END
	BEGIN
	
		IF EXISTS 
		(
			SELECT ID_Script FROM dbo.EventoScript
			WHERE ID_Evento = @idEventoExistente
		)
		BEGIN
			IF OBJECT_ID('tempdb..#TempLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR') IS NOT NULL
			BEGIN
				DROP TABLE #TempLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR
			END
				SELECT * INTO #TempLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR FROM EventoScript WHERE ID_Evento = @idEventoExistente
				DELETE FROM EventoScript WHERE ID_Evento = @idEventoExistente
				--DELETE FROM ScriptContable WHERE ID_Script IN (SELECT ID_Script FROM #TempLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR WHERE ID_Evento = @idEventoExistente)
			IF OBJECT_ID('tempdb..#TempLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR') IS NOT NULL
			BEGIN
				DROP TABLE #TempLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR
			END	
			PRINT(CONCAT('Existen Scipts Contables Relacionados al Evento ', @idEventoExistente))
		END
		--ELSE --Se comenta si se eliminan los scripts contables con la tabla temporal
		--BEGIN
		 --cargos
            INSERT INTO ScriptContable ( ID_TipoColectiva, ID_TipoCuenta, ID_ClaveAplicacion, Formula, EsAbono, ValidaSaldo, ValidaEstatusCuenta )
            VALUES  ( @colectivaEmisor, @idCuenta5, NULL, '@Importe', 0, 0, 1 )
			SET @script1 = SCOPE_IDENTITY()
                   
            --abonos
            INSERT INTO ScriptContable  ( ID_TipoColectiva,  ID_TipoCuenta, ID_ClaveAplicacion,  Formula, EsAbono, ValidaSaldo, ValidaEstatusCuenta )
            VALUES  ( @colectivaSubEmisor, @idCuenta3, NULL, '@Importe', 1, 0, 1 )
			SET @script2 = SCOPE_IDENTITY()

            INSERT INTO dbo.EventoScript  ( ID_Evento,  ID_Script, EsActiva, OrdenEjecucion )
            VALUES
                ( @idEventoExistente, @script1, 1, 1 ),
                ( @idEventoExistente, @script2, 1, 2 )
		--END
	END

/**AUMENTO DE GARANTÍA DEL SUBEMISOR*/
	IF NOT EXISTS
	(
		SELECT ID_Evento FROM Eventos e WITH (NOLOCK)
		WHERE ClaveEvento = @ClaveEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR
	)
        BEGIN 

            INSERT INTO Eventos ( ClaveEvento, Descripcion,  EsActivo, EsReversable, EsCancelable, EsTransaccional, ID_TipoEvento,  DescripcionEdoCta, GeneraPoliza, PreValidaciones, PostValidaciones, ClaveEventoEdoCta )
            VALUES ( @ClaveEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR, @DescEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR, 1, 1, 1, 0, @IDTipoEventoManual	, @DescEdoCuentaAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR, 1, 0, 0, @ClaveEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR )

            SET @idEventoExistente = SCOPE_IDENTITY()
 		END
	ELSE
	BEGIN
		SET @idEventoExistente = (SELECT ID_Evento FROM Eventos e WITH (NOLOCK) WHERE ClaveEvento = @ClaveEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR )
	END
	BEGIN
		IF EXISTS 
		(
			SELECT ID_Script FROM dbo.EventoScript
			WHERE ID_Evento = @idEventoExistente
		)
		BEGIN
			IF OBJECT_ID('tempdb..#TempAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR') IS NOT NULL
			BEGIN
				DROP TABLE #TempAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR
			END
				SELECT * INTO #TempAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR FROM EventoScript WHERE ID_Evento = @idEventoExistente
				DELETE FROM EventoScript WHERE ID_Evento = @idEventoExistente
				--DELETE FROM ScriptContable WHERE ID_Script IN (SELECT ID_Script FROM #TempAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR WHERE ID_Evento = @idEventoExistente)
			IF OBJECT_ID('tempdb..#TempAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR') IS NOT NULL
			BEGIN
				DROP TABLE #TempAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR
			END	
			PRINT(CONCAT('Existen Scipts Contables Relacionados al Evento ', @idEventoExistente))
		END
		--ELSE --Se comenta si se eliminan los scripts contables con la tabla temporal
		--BEGIN
		--cargos
            INSERT INTO ScriptContable ( ID_TipoColectiva, ID_TipoCuenta, ID_ClaveAplicacion, Formula, EsAbono, ValidaSaldo, ValidaEstatusCuenta )
            VALUES  ( @colectivaEmisor, @idCuenta5, NULL, '@Importe', 0, 0, 1 )
			SET @script1 = SCOPE_IDENTITY()
                   
            --abonos
            INSERT INTO ScriptContable  ( ID_TipoColectiva,  ID_TipoCuenta, ID_ClaveAplicacion,  Formula, EsAbono, ValidaSaldo, ValidaEstatusCuenta )
            VALUES  ( @colectivaSubEmisor, @idCuenta3, NULL, '@Importe', 1, 0, 1 )
			SET @script2 = SCOPE_IDENTITY()


            INSERT INTO dbo.EventoScript  ( ID_Evento,  ID_Script, EsActiva, OrdenEjecucion )
            VALUES
                ( @idEventoExistente, @script1, 1, 1 ),
                ( @idEventoExistente, @script2, 1, 2 )
		--END
	END
/**DISMINUCIÓN DE GARANTÍA DEL SUBEMISOR*/

	IF NOT EXISTS
	(
		SELECT ID_Evento FROM Eventos e WITH (NOLOCK)
		WHERE ClaveEvento = @ClaveEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR
	)
        BEGIN 

            INSERT INTO Eventos ( ClaveEvento, Descripcion,  EsActivo, EsReversable, EsCancelable, EsTransaccional, ID_TipoEvento,  DescripcionEdoCta, GeneraPoliza, PreValidaciones, PostValidaciones, ClaveEventoEdoCta )
            VALUES ( @ClaveEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR, @DescEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR, 1, 1, 1, 0, @IDTipoEventoManual	, @DescEdoCuentaDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR, 1, 0, 0, @ClaveEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR )

            SET @idEventoExistente = SCOPE_IDENTITY()
 		END
	ELSE
	BEGIN
		SET @idEventoExistente = (SELECT ID_Evento FROM Eventos e WITH (NOLOCK) WHERE ClaveEvento = @ClaveEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR )
	END
	BEGIN
	
		IF EXISTS 
		(
			SELECT ID_Script FROM dbo.EventoScript
			WHERE ID_Evento = @idEventoExistente
		)
		BEGIN
			IF OBJECT_ID('tempdb..#TempDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR') IS NOT NULL
			BEGIN
				DROP TABLE #TempDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR
			END
				SELECT * INTO #TempDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR FROM EventoScript WHERE ID_Evento = @idEventoExistente
				DELETE FROM EventoScript WHERE ID_Evento = @idEventoExistente
				--DELETE FROM ScriptContable WHERE ID_Script IN (SELECT ID_Script FROM #TempDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR WHERE ID_Evento = @idEventoExistente)
			IF OBJECT_ID('tempdb..#TempDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR') IS NOT NULL
			BEGIN
				DROP TABLE #TempDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR
			END	
			PRINT(CONCAT('Existen Scipts Contables Relacionados al Evento ', @idEventoExistente))
		END
		--ELSE --Se comenta si se eliminan los scripts contables con la tabla temporal
		--BEGIN
		  --cargos
			INSERT INTO ScriptContable  ( ID_TipoColectiva,  ID_TipoCuenta, ID_ClaveAplicacion,  Formula, EsAbono, ValidaSaldo, ValidaEstatusCuenta )
            VALUES  ( @colectivaSubEmisor, @idCuenta3, NULL, '@Importe', 0, 1, 1)
			SET @script1 = SCOPE_IDENTITY()
     
            --abonos
            INSERT INTO ScriptContable ( ID_TipoColectiva, ID_TipoCuenta, ID_ClaveAplicacion, Formula, EsAbono, ValidaSaldo, ValidaEstatusCuenta )
            VALUES  ( @colectivaEmisor, @idCuenta5, NULL, '@Importe', 1, 0, 1 )
			SET @script2 = SCOPE_IDENTITY()


            INSERT INTO dbo.EventoScript  ( ID_Evento,  ID_Script, EsActiva, OrdenEjecucion )
            VALUES
                ( @idEventoExistente, @script1, 1, 1 ),
                ( @idEventoExistente, @script2, 1, 2 )
		--END
	END

		--EXEC ProcMan_Comp_GetEventoScripts @ClaveEventoLIQUIDACIÓN_DE_SUBEMISOR_A_EMISOR
		--EXEC ProcMan_Comp_GetEventoScripts @ClaveEventoAUMENTO_DE_GARANTÍA_DEL_SUBEMISOR  
		--EXEC ProcMan_Comp_GetEventoScripts @ClaveEventoDISMINUCIÓN_DE_GARANTÍA_DEL_SUBEMISOR

    END TRY
    BEGIN CATCH
          ROLLBACK TRAN
        SELECT ERROR_MESSAGE() AS error
    END CATCH


	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN