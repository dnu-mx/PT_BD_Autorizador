-- Rollback para actualizar instancia a isoPlugInPARABILIUMPOS en la tabla AplicativosFirmas
UPDATE dbo.AplicativosFirmas
SET Instancia = 'isoPlugInPARABILIUMPOS'
WHERE Instancia = 'isoPlugInMASTERCARDPOS';

-- Rollback para actualizar instancia a isoPlugInPARABILIUMATM en la tabla AplicativosFirmas
UPDATE dbo.AplicativosFirmas
SET Instancia = 'isoPlugInPARABILIUMATM'
WHERE Instancia = 'isoPlugInMASTERCARDATM';

-- Rollback para actualizar instancia a isoPlugInPARABILIUMPOS en la tabla PlugIns
UPDATE dbo.PlugIns
SET Nombre = 'isoPlugInPARABILIUMPOS',
    NombreArchivo = 'isoPlugInPARABILIUMPOS',
    ClavePlugin = 'isoPlugInPARABILIUMPOS',
    Descripcion = 'Entrada de ISO Parabilium'
WHERE Nombre = 'isoPlugInMASTERCARDPOS';

-- Rollback para actualizar instancia a isoPlugInPARABILIUMATM en la tabla PlugIns
UPDATE dbo.PlugIns
SET Nombre = 'isoPlugInPARABILIUMATM',
    NombreArchivo = 'isoPlugInPARABILIUMATM',
    ClavePlugin = 'isoPlugInPARABILIUMATM',
    Descripcion = 'Entrada de ISO Parabilium'
WHERE Nombre = 'isoPlugInMASTERCARDATM';

-- Rollback para actualizar DirUbicacion de Parabilium_Autorizador_MC a AUTO_KLAR_POS_SANTAFE en la tabla PlugIns
UPDATE dbo.PlugIns
SET DirUbicacion = REPLACE(DirUbicacion, 'Parabilium_Autorizador_MC', 'AUTO_KLAR_POS_SANTAFE')
WHERE DirUbicacion LIKE '%Parabilium_Autorizador_MC%';

-- Rollback para actualizar TipoMensaje de 0100 a 0200 en la tabla Pertenencia
UPDATE dbo.Pertenencia
SET TipoMensaje = '0200'
WHERE TipoMensaje = '0100';

-- Rollback para actualizar TipoMensaje de 0120 a 0220 en la tabla Pertenencia
UPDATE dbo.Pertenencia
SET TipoMensaje = '0220'
WHERE TipoMensaje = '0120';

-- Rollback para actualizar Archivo en la tabla AplicativosFirmas
UPDATE dbo.AplicativosFirmas
SET Archivo = 'log4jCorePROSA.xml'
WHERE Archivo = 'log4jCoreMC.xml';

-- Rollback para eliminar los registros insertados en la tabla ValoresISO8583 (@TagsCompo48)
DELETE FROM dbo.ValoresISO8583
WHERE Nombre = '@TagsCompo48';

-- Rollback para eliminar los registros insertados en la tabla ValoresISO8583 (@EMV)
DELETE FROM dbo.ValoresISO8583
WHERE Nombre = '@EMV';

-- Rollback para actualizar campo @ForwardingInstitutionIDCode en la tabla ValoresISO8583
-- Revirtiendo a los valores anteriores (CampoISO=90, SubCampoISO=5, SubCadena=0)
UPDATE dbo.ValoresISO8583
SET CampoISO = 90, SubCampoISO = 5, SubCadena = 0
WHERE Nombre = '@ForwardingInstitutionIDCode';

-- Rollback para actualizar campo @MedioAcceso en la tabla ValoresISO8583
-- Revirtiendo a los valores anteriores (CampoISO=35, SubCadena='0,16')
UPDATE dbo.ValoresISO8583
SET CampoISO = 35, SubCadena = '0,16'
WHERE Nombre = '@MedioAcceso';

-- Rollback para actualizar campo @Importe en la tabla ValoresISO8583
-- Revirtiendo a los valores anteriores (CampoISO=4)
UPDATE dbo.ValoresISO8583
SET CampoISO = 4
WHERE Nombre = '@Importe';

-- Rollback para actualizar campo @Moneda en la tabla ValoresISO8583
-- Revirtiendo a los valores anteriores (CampoISO=49)
UPDATE dbo.ValoresISO8583
SET CampoISO = 49
WHERE Nombre = '@Moneda';

-- Rollback para actualizar CampoISO de 127 a 59 en la tabla ValoresISO8583
UPDATE dbo.ValoresISO8583
SET CampoISO = 59
WHERE CampoISO = 127;

--Rollback para eliminar RespuestasISOAgregadas
DELETE dbo.EventoRespuestaISO
WHERE ID_RespuestaISO > 20

DELETE RespuestaISOCampos
WHERE ID_RespuestaISO > 20

DELETE dbo.RespuestaISO
WHERE ID_RespuestaISO > 20

UPDATE dbo.RespuestaISOCampos
SET OmitirVacio=1,OmitirNulo=1,ValorDefault=NULL,ID_TipoOrigenValor=1,Formula=NULL,esActivo=1
---------------------------

-- Reversión de la inserción en la tabla ValoresISO8583
DELETE FROM dbo.ValoresISO8583
WHERE Nombre = '@ImpComisionConsultaSaldo'
AND ID_PlugIn=(SELECT ID_Plugin FROM dbo.PlugIns WHERE Nombre='isoPlugInMASTERCARDPOS')

-- Reversión de la modificación de la columna LlaveEncriptada en la tabla Llaves
ALTER TABLE dbo.Llaves
ALTER COLUMN LlaveEncriptada VARCHAR(50);

-- Reversión de la actualización en la tabla ValidadorCampos8583
UPDATE dbo.ValidadorCampos8583
SET CodigoError='87'
WHERE Formula IN ('nCripter_ValidacionCVV',
'nCripter_ValidacionCVV2',
'nCripter_Validacion_iCVV')


