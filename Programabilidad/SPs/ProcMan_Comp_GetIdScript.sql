USE AUTO_ETHOSPAY_SB
GO
IF EXISTS
(
	SELECT TOP 1 
		id 
	FROM 
		sysobjects  
	WHERE 
		name ='ProcMan_Comp_GetIdScript'
		AND type ='P'
)
BEGIN
	DROP PROCEDURE [dbo].[ProcMan_Comp_GetIdScript]
END
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcMan_Comp_GetIdScript]
(
	@idTipoColectiva INT,
	@idTipoCuenta INT,
	@idClaveAplicacion INT NULL,
	@formula VARCHAR(200),
	@esAbono BIT,
	@validaSaldo BIT,
	@validaEstatusCuenta BIT NULL,
	@idScript INT OUTPUT
)
WITH ENCRYPTION
AS
BEGIN
	/*
	==========================================================================================
	==================================Historial de Versiones==================================
	==========================================================================================
	Versión:		1.0
	Autor:			Ricardo Monroy        
	Fecha:			10 Mar 2022
	Descripción:	Obtiene el ID_Script, si no existe lo genera
	==========================================================================================
	Versión:		1.1
	Autor:			Martin Larguero        
	Fecha:			15 Mayo 2024
	Descripción:	Se agrego poder recibir @idClaveAplicacion y @validaEstatusCuenta en NULL
					para Eventos Transaccionales
	
	==========================================================================================
	=====================================Script de Pruebas====================================
	==========================================================================================
	DECLARE @idTipoColectiva INT = 0
    DECLARE @idTipoCuenta INT = 0
    DECLARE @idClaveAplicacion INT = 0
    DECLARE @formula VARCHAR(200) = ''
    DECLARE @esAbono BIT = 0
    DECLARE @validaSaldo BIT = 0
	DECLARE @validaEstatusCuenta BIT = 0
    DECLARE @idScript INT
	
	EXEC [dbo].[ProcMan_Comp_GetIdScript] 
		@idTipoColectiva, @idTipoCuenta, @idClaveAplicacion, @formula, @esAbono, @validaSaldo,
		@validaEstatusCuenta, @idScript OUTPUT

	SELECT
		@idScript
	==========================================================================================
	*/
    SET NOCOUNT ON
    
	
		IF(@idClaveAplicacion IS NULL AND @validaEstatusCuenta IS NULL)
		BEGIN
			IF NOT EXISTS
			(
				SELECT
					ID_Script
				FROM
					ScriptContable sc WITH (NOLOCK)
				WHERE
					ID_TipoColectiva = @idTipoColectiva
					AND ID_TipoCuenta = @idTipoCuenta
					AND ID_ClaveAplicacion IS NULL
					AND Formula = @formula
					AND EsAbono = @esAbono
					AND ValidaSaldo = @validaSaldo
					AND ValidaEstatusCuenta IS NULL
			)
			BEGIN
			INSERT INTO
				ScriptContable
				(
					ID_TipoColectiva,
					ID_TipoCuenta,
					ID_ClaveAplicacion,
					Formula,
					EsAbono,
					ValidaSaldo,
					ValidaEstatusCuenta
				)
			SELECT
				@idTipoColectiva,
				@idTipoCuenta,
				@idClaveAplicacion,
				@formula,
				@esAbono,
				@validaSaldo,
				@validaEstatusCuenta

			END
			SELECT
				@idScript = ID_Script
				FROM
				ScriptContable sc WITH (NOLOCK)
				WHERE
					ID_TipoColectiva = @idTipoColectiva
					AND ID_TipoCuenta = @idTipoCuenta
					AND ID_ClaveAplicacion IS NULL
					AND Formula = @formula
					AND EsAbono = @esAbono
					AND ValidaSaldo = @validaSaldo
					AND ValidaEstatusCuenta IS NULL	
		END
		ELSE
		BEGIN
			IF(@idClaveAplicacion IS NULL AND @validaEstatusCuenta IS NOT NULL)
			BEGIN
				IF NOT EXISTS
				(
					SELECT
						ID_Script
					FROM
						ScriptContable sc WITH (NOLOCK)
					WHERE
						ID_TipoColectiva = @idTipoColectiva
						AND ID_TipoCuenta = @idTipoCuenta
						AND ID_ClaveAplicacion IS NULL
						AND Formula = @formula
						AND EsAbono = @esAbono
						AND ValidaSaldo = @validaSaldo
						AND ValidaEstatusCuenta = @validaEstatusCuenta
				)
				BEGIN
				INSERT INTO
					ScriptContable
					(
						ID_TipoColectiva,
						ID_TipoCuenta,
						ID_ClaveAplicacion,
						Formula,
						EsAbono,
						ValidaSaldo,
						ValidaEstatusCuenta
					)
				SELECT
					@idTipoColectiva,
					@idTipoCuenta,
					@idClaveAplicacion,
					@formula,
					@esAbono,
					@validaSaldo,
					@validaEstatusCuenta
				END
				SELECT
					@idScript = ID_Script
					FROM
					ScriptContable sc WITH (NOLOCK)
					WHERE
						ID_TipoColectiva = @idTipoColectiva
						AND ID_TipoCuenta = @idTipoCuenta
						AND ID_ClaveAplicacion IS NULL
						AND Formula = @formula
						AND EsAbono = @esAbono
						AND ValidaSaldo = @validaSaldo
						AND ValidaEstatusCuenta = @validaEstatusCuenta
			END
			ELSE
			BEGIN
				IF(@idClaveAplicacion IS NOT NULL AND @validaEstatusCuenta IS NULL)
				BEGIN
					IF NOT EXISTS
					(
						SELECT
							ID_Script
						FROM
							ScriptContable sc WITH (NOLOCK)
						WHERE
							ID_TipoColectiva = @idTipoColectiva
							AND ID_TipoCuenta = @idTipoCuenta
							AND ID_ClaveAplicacion = @idClaveAplicacion
							AND Formula = @formula
							AND EsAbono = @esAbono
							AND ValidaSaldo = @validaSaldo
							AND ValidaEstatusCuenta IS NULL
					)
					BEGIN
					INSERT INTO
						ScriptContable
						(
							ID_TipoColectiva,
							ID_TipoCuenta,
							ID_ClaveAplicacion,
							Formula,
							EsAbono,
							ValidaSaldo,
							ValidaEstatusCuenta
						)
					SELECT
						@idTipoColectiva,
						@idTipoCuenta,
						@idClaveAplicacion,
						@formula,
						@esAbono,
						@validaSaldo,
						@validaEstatusCuenta
	
					END
					SELECT
						@idScript = ID_Script
						FROM
						ScriptContable sc WITH (NOLOCK)
						WHERE
							ID_TipoColectiva = @idTipoColectiva
							AND ID_TipoCuenta = @idTipoCuenta
							AND ID_ClaveAplicacion = @idClaveAplicacion
							AND Formula = @formula
							AND EsAbono = @esAbono
							AND ValidaSaldo = @validaSaldo
							AND ValidaEstatusCuenta IS NULL
				END
				ELSE
				BEGIN
					IF NOT EXISTS
					(
						SELECT
							ID_Script
						FROM
							ScriptContable sc WITH (NOLOCK)
						WHERE
							ID_TipoColectiva = @idTipoColectiva
							AND ID_TipoCuenta = @idTipoCuenta
							AND ID_ClaveAplicacion = @idClaveAplicacion
							AND Formula = @formula
							AND EsAbono = @esAbono
							AND ValidaSaldo = @validaSaldo
							AND ValidaEstatusCuenta = @validaEstatusCuenta
					)
					BEGIN
					INSERT INTO
						ScriptContable
						(
							ID_TipoColectiva,
							ID_TipoCuenta,
							ID_ClaveAplicacion,
							Formula,
							EsAbono,
							ValidaSaldo,
							ValidaEstatusCuenta
						)
					SELECT
						@idTipoColectiva,
						@idTipoCuenta,
						@idClaveAplicacion,
						@formula,
						@esAbono,
						@validaSaldo,
						@validaEstatusCuenta

					END
						SELECT
						@idScript = ID_Script
						FROM
						ScriptContable sc WITH (NOLOCK)
						WHERE
							ID_TipoColectiva = @idTipoColectiva
							AND ID_TipoCuenta = @idTipoCuenta
							AND ID_ClaveAplicacion = @idClaveAplicacion
							AND Formula = @formula
							AND EsAbono = @esAbono
							AND ValidaSaldo = @validaSaldo
							AND ValidaEstatusCuenta = @validaEstatusCuenta
				END
			END
		END
	
END
GO
