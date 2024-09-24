use [Autorizador]
GO

BEGIN TRAN

DECLARE @commit BIT = 1
		--AJUSTAR PARA CADA TIPO DE PRODUCTO
DECLARE @ClaveTipoProducto VARCHAR (10) = 'JSON01';
DECLARE @DescripcionTipoProducto VARCHAR (100) = 'JSON SALDO EXTERNO';
DECLARE @ClaveNumericaDivisa VARCHAR(3) ='484'
DECLARE @AplicaStandIn BIT =1


--PODRIAN CAMBIAR DEPENDIENDO DEL TIPO DE PRODUCTO QUE SE DESEE GENERAR
DECLARE @ClavesTipoCuentaGenericas VARCHAR (200) = 'CLDC,CCLC,CDC,CXP,CREJER,SBC';
DECLARE @ClavesTipoMA VARCHAR (200) = 'TAR,CLABE,CTAINT,NOCTA';

DECLARE @NombrePrametros VARCHAR(5000)
	= '@LongitudBIN,@ClaveEmbozador,@IVA,@SwitchProcesador,@VigPlastico,@DiaFechaCorte,@ContadorNIPInvalido,@MaxImporteChip,@MaxImporteChipDia,@MaxImporteChipMes,@MaxImporteEcommerce,@MaxImporteEcommerceDia,@MaxImporteEcommerceMes,@MaxImporteContactless,@MaxImporteContactlessDia,@MaxImporteContactlessMes,@MaxImporteDia,@MaxImporteMes,@MaxRetiroPorEvento,@MaxRetiroDia,@MaxRetiroMes'


DECLARE @ID_TipoCuentaPrincipal INT = ( SELECT ID_TipoCuenta FROM TipoCuenta INNER JOIN TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = TipoCuenta.ClaveGenerica 
		INNER JOIN dbo.Divisas ON Divisas.ID_Divisa = TipoCuenta.ID_Divisa WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa and TipoCuenta.ClaveGenerica = 'CCLC'  )

DECLARE @ID_TipoProducto INT;
DECLARE @AllEventos VARCHAR (5000) = ''
DECLARE @AllPosEntryMode VARCHAR(5000) = ''

/***********************************************************/
--VALIDACIÓN PARAMETROS MULTIASIGNACIÓN
/***********************************************************/

IF EXISTS (SELECT Parametros.value AS NombreParam
                     FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
					 WHERE Parametros.value NOT IN(
					select Nombre from 
							(SELECT Parametros.value AS NombreParam
							FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
							)                                        Config
							INNER JOIN dbo.ParametrosMultiasignacion pma
							ON Config.NombreParam = pma.Nombre
					)
					)
BEGIN
	SELECT Parametros.value AS ParametrosFaltantes
                     FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
					 WHERE Parametros.value NOT IN(
					select Nombre from 
							(SELECT Parametros.value AS NombreParam
							FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
							)                                        Config
							INNER JOIN dbo.ParametrosMultiasignacion pma
							ON Config.NombreParam = pma.Nombre
					)
	RAISERROR('FALTAN PARÁMETROS EN LA TABLA "ParametrosMultiasignacion", CONSULTAR VENTANA RESULTS', 16, 1);
    RETURN;							
END
ELSE
BEGIN
	PRINT('Parámetros validados correctamente')
END

/***********************************************************/
--VALIDACIÓN DE TIPOS CUENTAS
/***********************************************************/
IF EXISTS (SELECT TiposCuenta2.value AS tcClave
FROM STRING_SPLIT(@ClavesTipoCuentaGenericas, ',') TiposCuenta2
WHERE TiposCuenta2.value NOT IN(
				  SELECT 
                  TiposCuenta2.value
				  FROM (
                     SELECT TiposCuenta2.value AS tcClave,
                            TiposMA2.value     AS tmaCalve
                     FROM STRING_SPLIT(@ClavesTipoCuentaGenericas, ',') TiposCuenta2,
                          STRING_SPLIT(@ClavesTipoMA, ',') TiposMA2
                 )                              Config
                 INNER JOIN dbo.TipoCuenta      AS tp
                     ON Config.tcClave = tp.ClaveGenerica
                 INNER JOIN dbo.TipoMedioAcceso tma
                     ON Config.tmaCalve = tma.Clave
					 INNER JOIN dbo.TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = tp.ClaveGenerica
					 WHERE tp.ID_Divisa = (SELECT ID_Divisa FROM dbo.Divisas WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa)
					 )
)
BEGIN
SELECT TiposCuenta2.value AS TiposCuentaFaltantes
FROM STRING_SPLIT(@ClavesTipoCuentaGenericas, ',') TiposCuenta2
WHERE TiposCuenta2.value NOT IN(
				  SELECT 
                  TiposCuenta2.value
				  FROM (
                     SELECT TiposCuenta2.value AS tcClave,
                            TiposMA2.value     AS tmaCalve
                     FROM STRING_SPLIT(@ClavesTipoCuentaGenericas, ',') TiposCuenta2,
                          STRING_SPLIT(@ClavesTipoMA, ',') TiposMA2
                 )                              Config
                 INNER JOIN dbo.TipoCuenta      AS tp
                     ON Config.tcClave = tp.ClaveGenerica
                 INNER JOIN dbo.TipoMedioAcceso tma
                     ON Config.tmaCalve = tma.Clave
					 INNER JOIN dbo.TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = tp.ClaveGenerica
					 WHERE tp.ID_Divisa = (SELECT ID_Divisa FROM dbo.Divisas WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa)
					 )
RAISERROR('FALTAN TIPOS DE CUENTA EN LA TABLA "TipoCuenta", CONSULTAR VENTANA RESULTS', 16, 1);
    RETURN;							
END
ELSE
BEGIN
	PRINT('Tipos de Cuenta validados correctamente')
END

/***********************************************************/
--VALIDAR LOS TIPOS DE MA
/***********************************************************/
 IF EXISTS (SELECT TiposMA2.value AS tmaCalve
        FROM STRING_SPLIT(@ClavesTipoMA, ',') TiposMA2
		WHERE TiposMA2.value NOT IN(
				SELECT tma.Clave      
				FROM (
                     SELECT TiposMA2.value AS tmaCalve
                     FROM STRING_SPLIT(@ClavesTipoMA, ',') TiposMA2
                 )                              Config
                 INNER JOIN dbo.TipoMedioAcceso tma
                     ON Config.tmaCalve = tma.Clave
				)
)
BEGIN
SELECT TiposMA2.value AS clavesMAFaltantes
        FROM STRING_SPLIT(@ClavesTipoMA, ',') TiposMA2
		WHERE TiposMA2.value NOT IN(
				SELECT tma.Clave      
				FROM (
                     SELECT TiposMA2.value AS tmaCalve
                     FROM STRING_SPLIT(@ClavesTipoMA, ',') TiposMA2
                 )                              Config
                 INNER JOIN dbo.TipoMedioAcceso tma
                     ON Config.tmaCalve = tma.Clave
				)
RAISERROR('FALTAN TIPOS DE MEDIOS DE ACCESO EN LA TABLA "TipoMedioAcceso", CONSULTAR VENTANA RESULTS', 16, 1);
    RETURN;							
END
ELSE
BEGIN
	PRINT('Tipos de Medio Acceso validados correctamente')
END


/***********************************************************/
--INSERCCION DE TIPO DE PRODUCTO
/***********************************************************/
IF NOT EXISTS
( 
	SELECT * FROM TipoProducto WHERE ClaveTipoProducto = @ClaveTipoProducto
)
BEGIN
INSERT INTO dbo.TipoProducto
    ( ClaveTipoProducto,
      Descripcion,
      ID_TipoCuentaPrincipal )
VALUES
    ( @ClaveTipoProducto,       -- ClaveProducto - varchar(10)
      @DescripcionTipoProducto, -- Descripcion - varchar(150)
      @ID_TipoCuentaPrincipal   -- ID_TipoCuentaPrincipal - int
    );

SET @ID_TipoProducto = @@IDENTITY;
END
ELSE
BEGIN
	SET @ID_TipoProducto = (SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @ClaveTipoProducto)
END
 
 /***********************************************************/
--AGREGAR CUENTAS AL TIPO DE PRODUCTOS
/***********************************************************/
INSERT INTO dbo.TipoProductoTipoCuenta
    ( ID_TipoProducto,
      ID_TipoCuenta,
      ID_TipoMA,
      Activo )
            SELECT @ID_TipoProducto,
                   tp.ID_TipoCuenta,
                   tma.ID_TipoMA,
                   1
            FROM (
                     SELECT TiposCuenta2.value AS tcClave,
                            TiposMA2.value     AS tmaCalve
                     FROM STRING_SPLIT(@ClavesTipoCuentaGenericas, ',') TiposCuenta2,
                          STRING_SPLIT(@ClavesTipoMA, ',') TiposMA2
                 )                              Config
                 INNER JOIN dbo.TipoCuenta      AS tp
                     ON Config.tcClave = tp.ClaveGenerica
                 INNER JOIN dbo.TipoMedioAcceso tma
                     ON Config.tmaCalve = tma.Clave
					 INNER JOIN dbo.TiposCuentaGenerica ON TiposCuentaGenerica.ClaveGenerica = tp.ClaveGenerica
					 WHERE tp.ID_Divisa = (SELECT ID_Divisa FROM dbo.Divisas WHERE ClaveNumericaMoneda=@ClaveNumericaDivisa)




/***********************************************************/
--INSERTAR LOS TIPO DE MA AL TIPO DE PRODUCTO
/***********************************************************/
INSERT INTO dbo.TipoProductoTipoMA
    ( ID_TipoProducto,
      ID_TipoMA,
      Activo )
            SELECT @ID_TipoProducto,
                   tma.ID_TipoMA,
                   1
            FROM (
                     SELECT TiposMA2.value AS tmaCalve
                     FROM STRING_SPLIT(@ClavesTipoMA, ',') TiposMA2
                 )                              Config
                 INNER JOIN dbo.TipoMedioAcceso tma
                     ON Config.tmaCalve = tma.Clave;


/***********************************************************/
--INSERTAR LOS PARAMETROS MULTIASGINACION AL TIPO PRODUCTO
/***********************************************************/
INSERT INTO dbo.TipoProductoParametroMultiAsginacion
    ( ID_TipoProducto,
      ID_ParametroMultiasignacion )
            SELECT @ID_TipoProducto,
                   pma.ID_ParametroMultiasignacion
            FROM (
                     SELECT Parametros.value AS NombreParam
                     FROM STRING_SPLIT(@NombrePrametros, ',') Parametros
                 )                                        Config
                 INNER JOIN dbo.ParametrosMultiasignacion pma
                     ON Config.NombreParam = pma.Nombre and ID_ParametroMultiasignacion not in ( select TipoProductoParametroMultiAsginacion.ID_ParametroMultiasignacion from TipoProductoParametroMultiAsginacion where ID_TipoProducto=@ID_TipoProducto);


--SELECT *
--FROM TipoProducto WHERE ID_TipoProducto=@ID_TipoProducto

--SELECT *
--FROM TipoProductoTipoCuenta WHERE ID_TipoProducto=@ID_TipoProducto

--SELECT *
--FROM TipoProductoTipoMA WHERE ID_TipoProducto=@ID_TipoProducto

--SELECT *
--FROM TipoProductoParametroMultiAsginacion WHERE ID_TipoProducto=@ID_TipoProducto


	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN