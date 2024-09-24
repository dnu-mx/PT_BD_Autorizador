USE Autorizador

--SELECT * FROM AplicativosFirmas
--SELECT * FROM dbo.PlugIns

---------Actualizar instancia a isoPlugInMASTERCARDPOS de la tabla AplicativosFirmas
UPDATE dbo.AplicativosFirmas
SET Instancia='isoPlugInMASTERCARDPOS'
WHERE Instancia = 'isoPlugInPARABILIUMPOS'
--------------------------------------------------------
---------Actualizar instancia a isoPlugInMASTERCARDATM de la tabla AplicativosFirmas
UPDATE dbo.AplicativosFirmas
SET Instancia='isoPlugInMASTERCARDATM'
WHERE Instancia = 'isoPlugInPARABILIUMATM'
--------------------------------------------------------
---------Actualizar instancia a isoPlugInMASTERCARDPOS de la tabla PlugIns
UPDATE dbo.PlugIns
SET Nombre='isoPlugInMASTERCARDPOS',
NombreArchivo='isoPlugInMASTERCARDPOS',
ClavePlugin='isoPlugInMASTERCARDPOS',
Descripcion='Entrada de ISO Master Card'
WHERE Nombre = 'isoPlugInPARABILIUMPOS'
--------------------------------------------------------
---------Actualizar instancia a isoPlugInMASTERCARDPOS de la tabla PlugIns
UPDATE dbo.PlugIns
SET Nombre='isoPlugInMASTERCARDATM',
NombreArchivo='isoPlugInMASTERCARDATM',
ClavePlugin='isoPlugInMASTERCARDATM',
Descripcion='Entrada de ISO Master Card'
WHERE Nombre = 'isoPlugInPARABILIUMATM'
--------------------------------------------------------
---------Actualizar DirUbicacion de AUTO_KLAR_POS_SANTAFE a Parabilium_Autorizador_MC de la tabla PlugIns
UPDATE dbo.PlugIns
SET DirUbicacion=REPLACE(DirUbicacion,'AUTO_KLAR_POS_SANTAFE','Parabilium_Autorizador_MC')
WHERE DirUbicacion LIKE '%AUTO_KLAR_POS_SANTAFE%'
--------------------------------------------------------
----------Actualizar TipoMensaje de 0200 a 0100 de la tabla Pertenencia
UPDATE dbo.Pertenencia
SET TipoMensaje='0100'
WHERE TipoMensaje='0200'
--------------------------------------------------------
----------Actualizar TipoMensaje de 0220 a 0120 de la tabla Pertenencia
UPDATE dbo.Pertenencia
SET TipoMensaje='0120'
WHERE TipoMensaje='0220'
--------------------------------------------------------
----------Actualizar Archivo de la tabla AplicativosFirmas
UPDATE dbo.AplicativosFirmas
SET Archivo='log4jCoreMC.xml'
WHERE Archivo='log4jCorePROSA.xml'
--------------------------------------------------------
----------Insertar campo @TagsCompo48 en la tabla ValoresISO8583
INSERT INTO dbo.ValoresISO8583
SELECT 
       ID_TipoColectiva,
       ID_PlugIn,
       '@TagsCompo48',
       'Campo 48 con Tags',
       esValorSubCampo,
       esValorToken,
       esClave,
       '48',
       SubCampoISO,
       TipoDatoSQL,
       TipoDatoC,
       TipoDatoJava,
       SubCadena,
       ClaveToken,
       SubCampoToken,
       esFormula,
       Formula FROM dbo.ValoresISO8583
WHERE Nombre='@TokensCompo63'
--------------------------------------------------------
----------Insertar campo @EMV en la tabla ValoresISO8583
INSERT INTO dbo.ValoresISO8583
SELECT 
       ID_TipoColectiva,
       ID_PlugIn,
       '@EMV',
       'Campo 55 con Tags EMV',
       esValorSubCampo,
       esValorToken,
       esClave,
       '55',
       SubCampoISO,
       TipoDatoSQL,
       TipoDatoC,
       TipoDatoJava,
       SubCadena,
       ClaveToken,
       SubCampoToken,
       esFormula,
       Formula FROM dbo.ValoresISO8583
WHERE Nombre='@TokensCompo63'
--------------------------------------------------------
----------Actualizar campo @ForwardingInstitutionIDCode en la tabla ValoresISO8583
--Anterior CampoISO=90,SubCampoISO=5,SubCadena=0
UPDATE dbo.ValoresISO8583
SET CampoISO=33,SubCampoISO=0,SubCadena=NULL
WHERE Nombre='@ForwardingInstitutionIDCode'
--------------------------------------------------------
----------Actualizar campo @MedioAcceso en la tabla ValoresISO8583
--Anterior CampoISO=35,SubCadena='0,16' --SET CampoISO=2,SubCadena=NULL
UPDATE dbo.ValoresISO8583
SET CampoISO=2,SubCadena=NULL
WHERE Nombre='@MedioAcceso'
--------------------------------------------------------
----------Actualizar campo @Importe en la tabla ValoresISO8583
--Anterior CampoISO=4 --SET CampoISO=6
UPDATE dbo.ValoresISO8583
SET CampoISO=6
WHERE Nombre='@Importe'
--------------------------------------------------------
----------Actualizar campo @Moneda en la tabla ValoresISO8583
--Anterior CampoISO=49 --SET CampoISO=51
UPDATE dbo.ValoresISO8583
SET CampoISO=51
WHERE Nombre='@Moneda'
--------------------------------------------------------
----------Actualizar CampoISO 59 a 127 en la tabla ValoresISO8583
--Anterior CampoISO=59
UPDATE dbo.ValoresISO8583
SET CampoISO=127
WHERE CampoISO=59
--------------------------------------------------------
----------Actualizar Campos para solo responder los necesarios en MTI 0100 en la tabla RespuestaISO
UPDATE dbo.RespuestaISO
SET Descripcion='Respuesta ISO 0100'
WHERE ID_RespuestaISO=20

INSERT INTO dbo.EventoRespuestaISO
SELECT NULL,
(SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),
'0110',
ID_Plugin FROM dbo.PlugIns
WHERE ID_TipoPlugIn=2

DELETE dbo.RespuestaISOCampos
WHERE ID_RespuestaISO=20

INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'2',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'3',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'4',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'5',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'6',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'7',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'8',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'9',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'10',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'11',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'12',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'13',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'14',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'15',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'16',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'17',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'18',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'19',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'20',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'21',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'22',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'23',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'24',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'25',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'26',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'27',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'28',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'29',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'30',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'31',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'32',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'33',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'34',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'35',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'36',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'37',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'38',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'39',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'40',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'41',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'42',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'43',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'44',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'45',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'46',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'47',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'48',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'49',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'50',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'51',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'52',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'53',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'54',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'55',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'56',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'57',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'58',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'59',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'60',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'61',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'62',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'63',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'64',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'65',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'66',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'67',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'68',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'69',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'70',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'71',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'72',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'73',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'74',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'75',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'76',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'77',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'78',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'79',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'80',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'81',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'82',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'83',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'84',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'85',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'86',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'87',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'88',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'89',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'90',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'91',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'92',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'93',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'94',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'95',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'96',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'97',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'98',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'99',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'100',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'101',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'102',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'103',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'104',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'105',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'106',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'107',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'108',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'109',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'110',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'111',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'112',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'113',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'114',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'115',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'116',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'117',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'118',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'119',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'120',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'121',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'122',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'123',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'124',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'125',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100'),'126',1,1,NULL,1,NULL,1)

UPDATE dbo.RespuestaISOCampos
SET esActivo=0
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100')
AND NumeroCampoISO NOT IN ('2','3','4','5','6','7','9','10','11',
'15','16','20','28','32','33','37','38','39','41','44','48','49','50',
'51','55','56','62','63','102','103','108','112','120','121','123','124','127')


--------------------------------------------------------
----------Insertar lo necesario para MTI 0400 en la tabla RespuestaISO
INSERT INTO dbo.RespuestaISO
(
    Clave,
    Descripcion
)
VALUES
(   (SELECT MAX(Clave+1) FROM dbo.RespuestaISO), -- Clave - varchar(50)
    'Respuesta ISO 0400'  -- Descripcion - varchar(500)
    )

INSERT INTO dbo.EventoRespuestaISO
SELECT NULL,
(SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),
'0410',
ID_Plugin FROM dbo.PlugIns
WHERE ID_TipoPlugIn=2

INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'2',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'3',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'4',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'5',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'6',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'7',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'8',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'9',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'10',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'11',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'12',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'13',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'14',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'15',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'16',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'17',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'18',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'19',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'20',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'21',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'22',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'23',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'24',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'25',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'26',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'27',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'28',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'29',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'30',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'31',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'32',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'33',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'34',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'35',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'36',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'37',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'38',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'39',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'40',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'41',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'42',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'43',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'44',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'45',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'46',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'47',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'48',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'49',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'50',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'51',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'52',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'53',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'54',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'55',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'56',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'57',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'58',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'59',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'60',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'61',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'62',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'63',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'64',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'65',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'66',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'67',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'68',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'69',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'70',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'71',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'72',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'73',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'74',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'75',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'76',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'77',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'78',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'79',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'80',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'81',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'82',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'83',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'84',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'85',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'86',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'87',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'88',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'89',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'90',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'91',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'92',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'93',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'94',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'95',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'96',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'97',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'98',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'99',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'100',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'101',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'102',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'103',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'104',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'105',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'106',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'107',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'108',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'109',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'110',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'111',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'112',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'113',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'114',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'115',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'116',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'117',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'118',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'119',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'120',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'121',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'122',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'123',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'124',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'125',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400'),'126',1,1,NULL,1,NULL,1)

UPDATE dbo.RespuestaISOCampos
SET esActivo=0
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400')
AND NumeroCampoISO NOT IN ('2','3','4','5','6','7','9','10','11',
'15','16','20','28','32','33','37','39','41','44','48','49','50',
'51','56','62','63','90','95','108','112','121','124','127')
--------------------------------------------------------
----------Insertar lo necesario para MTI 0400 en la tabla RespuestaISO
INSERT INTO dbo.RespuestaISO
(
    Clave,
    Descripcion
)
VALUES
(   (SELECT MAX(Clave+1) FROM dbo.RespuestaISO), -- Clave - varchar(50)
    'Respuesta ISO 0420'  -- Descripcion - varchar(500)
    )

INSERT INTO dbo.EventoRespuestaISO
SELECT NULL,
(SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),
'0430',
ID_Plugin FROM dbo.PlugIns
WHERE ID_TipoPlugIn=2

INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'2',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'3',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'4',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'5',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'6',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'7',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'8',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'9',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'10',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'11',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'12',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'13',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'14',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'15',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'16',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'17',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'18',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'19',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'20',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'21',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'22',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'23',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'24',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'25',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'26',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'27',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'28',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'29',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'30',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'31',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'32',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'33',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'34',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'35',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'36',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'37',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'38',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'39',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'40',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'41',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'42',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'43',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'44',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'45',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'46',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'47',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'48',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'49',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'50',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'51',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'52',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'53',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'54',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'55',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'56',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'57',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'58',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'59',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'60',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'61',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'62',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'63',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'64',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'65',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'66',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'67',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'68',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'69',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'70',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'71',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'72',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'73',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'74',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'75',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'76',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'77',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'78',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'79',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'80',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'81',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'82',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'83',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'84',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'85',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'86',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'87',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'88',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'89',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'90',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'91',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'92',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'93',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'94',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'95',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'96',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'97',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'98',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'99',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'100',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'101',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'102',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'103',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'104',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'105',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'106',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'107',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'108',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'109',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'110',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'111',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'112',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'113',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'114',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'115',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'116',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'117',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'118',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'119',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'120',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'121',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'122',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'123',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'124',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'125',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420'),'126',1,1,NULL,1,NULL,1)

UPDATE dbo.RespuestaISOCampos
SET esActivo=0
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420')
AND NumeroCampoISO NOT IN ('2','3','4','5','6','7','9','10','11',
'15','16','20','28','32','33','37','39','41','44','49','50',
'51','56','62','63','90','95','108','112','121','124','127')
--------------------------------------------------------
----------Insertar lo necesario para MTI 0120 en la tabla RespuestaISO
INSERT INTO dbo.RespuestaISO
(
    Clave,
    Descripcion
)
VALUES
(   (SELECT MAX(Clave+1) FROM dbo.RespuestaISO), -- Clave - varchar(50)
    'Respuesta ISO 0120'  -- Descripcion - varchar(500)
    )

INSERT INTO dbo.EventoRespuestaISO
SELECT NULL,
(SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),
'0130',
ID_Plugin FROM dbo.PlugIns
WHERE ID_TipoPlugIn=2

INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'2',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'3',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'4',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'5',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'6',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'7',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'8',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'9',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'10',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'11',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'12',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'13',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'14',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'15',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'16',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'17',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'18',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'19',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'20',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'21',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'22',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'23',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'24',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'25',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'26',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'27',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'28',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'29',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'30',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'31',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'32',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'33',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'34',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'35',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'36',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'37',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'38',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'39',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'40',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'41',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'42',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'43',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'44',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'45',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'46',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'47',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'48',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'49',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'50',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'51',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'52',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'53',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'54',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'55',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'56',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'57',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'58',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'59',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'60',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'61',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'62',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'63',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'64',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'65',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'66',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'67',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'68',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'69',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'70',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'71',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'72',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'73',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'74',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'75',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'76',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'77',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'78',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'79',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'80',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'81',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'82',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'83',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'84',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'85',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'86',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'87',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'88',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'89',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'90',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'91',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'92',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'93',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'94',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'95',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'96',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'97',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'98',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'99',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'100',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'101',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'102',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'103',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'104',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'105',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'106',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'107',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'108',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'109',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'110',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'111',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'112',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'113',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'114',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'115',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'116',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'117',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'118',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'119',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'120',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'121',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'122',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'123',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'124',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'125',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120'),'126',1,1,NULL,1,NULL,1)

UPDATE dbo.RespuestaISOCampos
SET esActivo=0
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120')
AND NumeroCampoISO NOT IN ('2','3','4','5','6','7','9','10','11',
'15','16','20','23','28','32','33','37','39','41','44','49','50',
'51','56','62','63')
--------------------------------------------------------
----------Insertar lo necesario para MTI 0100 CHIP en la tabla RespuestaISO
INSERT INTO dbo.RespuestaISO
(
    Clave,
    Descripcion
)
VALUES
(   (SELECT MAX(Clave+1) FROM dbo.RespuestaISO), -- Clave - varchar(50)
    'Respuesta ISO 0100 CHIP'  -- Descripcion - varchar(500)
    )

INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'2',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'3',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'4',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'5',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'6',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'7',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'8',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'9',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'10',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'11',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'12',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'13',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'14',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'15',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'16',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'17',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'18',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'19',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'20',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'21',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'22',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'23',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'24',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'25',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'26',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'27',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'28',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'29',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'30',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'31',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'32',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'33',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'34',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'35',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'36',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'37',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'38',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'39',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'40',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'41',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'42',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'43',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'44',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'45',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'46',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'47',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'48',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'49',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'50',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'51',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'52',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'53',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'54',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'55',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'56',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'57',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'58',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'59',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'60',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'61',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'62',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'63',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'64',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'65',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'66',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'67',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'68',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'69',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'70',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'71',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'72',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'73',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'74',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'75',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'76',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'77',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'78',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'79',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'80',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'81',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'82',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'83',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'84',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'85',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'86',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'87',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'88',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'89',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'90',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'91',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'92',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'93',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'94',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'95',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'96',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'97',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'98',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'99',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'100',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'101',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'102',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'103',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'104',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'105',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'106',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'107',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'108',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'109',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'110',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'111',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'112',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'113',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'114',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'115',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'116',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'117',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'118',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'119',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'120',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'121',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'122',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'123',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'124',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'125',1,1,NULL,1,NULL,1)
INSERT INTO dbo.RespuestaISOCampos VALUES ((SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'126',1,1,NULL,1,NULL,1)

UPDATE dbo.RespuestaISOCampos
SET esActivo=0
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP')
AND NumeroCampoISO NOT IN ('2','3','4','5','6','7','9','10','11',
'15','16','20','28','32','33','37','38','39','41','44','48','49','50',
'51','55','56','62','63','102','103','108','112','120','121','123','124','127')


--------Insertar en la tabla EventoRespuestaISO todos los eventos chip y ligarlos al ID_RespuestaISO de Descripcion='Respuesta ISO 0100 CHIP'
INSERT INTO dbo.EventoRespuestaISO
SELECT DISTINCT(ID_Evento),(SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'0110',ID_Plugin FROM dbo.Pertenencia
INNER JOIN dbo.PertenenciaEventos ON PertenenciaEventos.ID_Pertenencia = Pertenencia.ID_Pertenencia
CROSS JOIN dbo.PlugIns
WHERE POSEM = '05_' AND dbo.Pertenencia.TipoMensaje = '0100'
AND ID_TipoPlugIn=2
--------------------------------------------------------
--------Insertar en la tabla EventoRespuestaISO todos los eventos CONTACLESS y ligarlos al ID_RespuestaISO de Descripcion='Respuesta ISO 0100 CHIP'
INSERT INTO dbo.EventoRespuestaISO
SELECT DISTINCT(ID_Evento),(SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP'),'0110',ID_Plugin FROM dbo.Pertenencia
INNER JOIN dbo.PertenenciaEventos ON PertenenciaEventos.ID_Pertenencia = Pertenencia.ID_Pertenencia
CROSS JOIN dbo.PlugIns
WHERE POSEM = '07_' AND dbo.Pertenencia.TipoMensaje = '0100'
AND ID_TipoPlugIn=2
--------------------------------------------------------
--------------------------------------------------------
---------Modificar campo Formula de 500 a 5000 de la tabla RespuestaISOCampos
ALTER TABLE RespuestaISOCampos
ALTER COLUMN Formula VARCHAR(5000) NULL
--------------------------------------------------------
---------Actualizar el Valor de NumeroCampoISO a Formular y con todos los tags de la tabla RespuestaISOCampos
UPDATE dbo.RespuestaISOCampos -- Se quita el 21 -- se quita el 61 -- se quita el 58 por ATM --se quita el 37 por ecommerce --se quita el 63 por ecommerce Credential on file ----se quita el 56 por ecommerce --se quita el 32 por ecommerce Credential on file -- se quita el 26 ecommerce -- se quita el 65 por banda
SET ID_TipoOrigenValor='3',Formula='@TagCampo48_TC+@TagCampo48_09+@TagCampo48_10+@TagCampo48_11+@TagCampo48_12+@TagCampo48_13+@TagCampo48_14+@TagCampo48_15+@TagCampo48_16+@TagCampo48_17+@TagCampo48_18+@TagCampo48_19+@TagCampo48_20+@TagCampo48_22+@TagCampo48_23+@TagCampo48_24+@TagCampo48_25+@TagCampo48_27+@TagCampo48_28+@TagCampo48_29+@TagCampo48_30+@TagCampo48_31+@TagCampo48_33+@TagCampo48_34+@TagCampo48_35+@TagCampo48_36+@TagCampo48_38+@TagCampo48_39+@TagCampo48_40+@TagCampo48_41+@TagCampo48_42+@TagCampo48_43+@TagCampo48_44+@TagCampo48_45+@TagCampo48_46+@TagCampo48_47+@TagCampo48_48+@TagCampo48_49+@TagCampo48_50+@TagCampo48_51+@TagCampo48_52+@TagCampo48_53+@TagCampo48_54+@TagCampo48_55+@TagCampo48_57+@TagCampo48_59+@TagCampo48_60+@TagCampo48_62+@TagCampo48_64+@TagCampo48_66+@TagCampo48_67+@TagCampo48_68+@TagCampo48_69+@TagCampo48_70+@TagCampo48_71+@TagCampo48_72+@TagCampo48_73+@TagCampo48_74+@TagCampo48_75+@TagCampo48_76+@TagCampo48_77+@TagCampo48_78+@TagCampo48_79+@TagCampo48_80+@TagCampo48_81+@TagCampo48_82+@TagCampo48_83+@TagCampo48_84+@TagCampo48_85+@TagCampo48_86+@TagCampo48_87+@TagCampo48_88+@TagCampo48_89+@TagCampo48_90+@TagCampo48_91+@TagCampo48_92+@TagCampo48_93+@TagCampo48_94+@TagCampo48_95+@TagCampo48_96+@TagCampo48_97+@TagCampo48_98+@TagCampo48_99'
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100')
AND NumeroCampoISO=48

UPDATE dbo.RespuestaISOCampos -- Se quita el 20
SET ID_TipoOrigenValor='3',Formula='@TagCampo48_TC+@TagCampo48_09+@TagCampo48_10+@TagCampo48_11+@TagCampo48_12+@TagCampo48_13+@TagCampo48_14+@TagCampo48_15+@TagCampo48_16+@TagCampo48_17+@TagCampo48_18+@TagCampo48_19+@TagCampo48_21+@TagCampo48_22+@TagCampo48_23+@TagCampo48_24+@TagCampo48_25+@TagCampo48_26+@TagCampo48_27+@TagCampo48_28+@TagCampo48_29+@TagCampo48_30+@TagCampo48_31+@TagCampo48_32+@TagCampo48_33+@TagCampo48_34+@TagCampo48_35+@TagCampo48_36+@TagCampo48_37+@TagCampo48_38+@TagCampo48_39+@TagCampo48_40+@TagCampo48_41+@TagCampo48_42+@TagCampo48_43+@TagCampo48_44+@TagCampo48_45+@TagCampo48_46+@TagCampo48_47+@TagCampo48_48+@TagCampo48_49+@TagCampo48_50+@TagCampo48_51+@TagCampo48_52+@TagCampo48_53+@TagCampo48_54+@TagCampo48_55+@TagCampo48_56+@TagCampo48_57+@TagCampo48_58+@TagCampo48_59+@TagCampo48_60+@TagCampo48_61+@TagCampo48_62+@TagCampo48_63+@TagCampo48_64+@TagCampo48_65+@TagCampo48_66+@TagCampo48_67+@TagCampo48_68+@TagCampo48_69+@TagCampo48_70+@TagCampo48_71+@TagCampo48_72+@TagCampo48_73+@TagCampo48_74+@TagCampo48_75+@TagCampo48_76+@TagCampo48_77+@TagCampo48_78+@TagCampo48_79+@TagCampo48_80+@TagCampo48_81+@TagCampo48_82+@TagCampo48_83+@TagCampo48_84+@TagCampo48_85+@TagCampo48_86+@TagCampo48_87+@TagCampo48_88+@TagCampo48_89+@TagCampo48_90+@TagCampo48_91+@TagCampo48_92+@TagCampo48_93+@TagCampo48_94+@TagCampo48_95+@TagCampo48_96+@TagCampo48_97+@TagCampo48_98+@TagCampo48_99'
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0400')
AND NumeroCampoISO=48

UPDATE dbo.RespuestaISOCampos -- Se quita el 20
SET ID_TipoOrigenValor='3',Formula='@TagCampo48_TC+@TagCampo48_09+@TagCampo48_10+@TagCampo48_11+@TagCampo48_12+@TagCampo48_13+@TagCampo48_14+@TagCampo48_15+@TagCampo48_16+@TagCampo48_17+@TagCampo48_18+@TagCampo48_19+@TagCampo48_21+@TagCampo48_22+@TagCampo48_23+@TagCampo48_24+@TagCampo48_25+@TagCampo48_26+@TagCampo48_27+@TagCampo48_28+@TagCampo48_29+@TagCampo48_30+@TagCampo48_31+@TagCampo48_32+@TagCampo48_33+@TagCampo48_34+@TagCampo48_35+@TagCampo48_36+@TagCampo48_37+@TagCampo48_38+@TagCampo48_39+@TagCampo48_40+@TagCampo48_41+@TagCampo48_42+@TagCampo48_43+@TagCampo48_44+@TagCampo48_45+@TagCampo48_46+@TagCampo48_47+@TagCampo48_48+@TagCampo48_49+@TagCampo48_50+@TagCampo48_51+@TagCampo48_52+@TagCampo48_53+@TagCampo48_54+@TagCampo48_55+@TagCampo48_56+@TagCampo48_57+@TagCampo48_58+@TagCampo48_59+@TagCampo48_60+@TagCampo48_61+@TagCampo48_62+@TagCampo48_63+@TagCampo48_64+@TagCampo48_65+@TagCampo48_66+@TagCampo48_67+@TagCampo48_68+@TagCampo48_69+@TagCampo48_70+@TagCampo48_71+@TagCampo48_72+@TagCampo48_73+@TagCampo48_74+@TagCampo48_75+@TagCampo48_76+@TagCampo48_77+@TagCampo48_78+@TagCampo48_79+@TagCampo48_80+@TagCampo48_81+@TagCampo48_82+@TagCampo48_83+@TagCampo48_84+@TagCampo48_85+@TagCampo48_86+@TagCampo48_87+@TagCampo48_88+@TagCampo48_89+@TagCampo48_90+@TagCampo48_91+@TagCampo48_92+@TagCampo48_93+@TagCampo48_94+@TagCampo48_95+@TagCampo48_96+@TagCampo48_97+@TagCampo48_98+@TagCampo48_99'
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0420')
AND NumeroCampoISO=48

UPDATE dbo.RespuestaISOCampos -- Se quita el 21
SET ID_TipoOrigenValor='3',Formula='@TagCampo48_TC+@TagCampo48_09+@TagCampo48_10+@TagCampo48_11+@TagCampo48_12+@TagCampo48_13+@TagCampo48_14+@TagCampo48_15+@TagCampo48_16+@TagCampo48_17+@TagCampo48_18+@TagCampo48_19+@TagCampo48_20+@TagCampo48_22+@TagCampo48_23+@TagCampo48_24+@TagCampo48_25+@TagCampo48_26+@TagCampo48_27+@TagCampo48_28+@TagCampo48_29+@TagCampo48_30+@TagCampo48_31+@TagCampo48_32+@TagCampo48_33+@TagCampo48_34+@TagCampo48_35+@TagCampo48_36+@TagCampo48_37+@TagCampo48_38+@TagCampo48_39+@TagCampo48_40+@TagCampo48_41+@TagCampo48_42+@TagCampo48_43+@TagCampo48_44+@TagCampo48_45+@TagCampo48_46+@TagCampo48_47+@TagCampo48_48+@TagCampo48_49+@TagCampo48_50+@TagCampo48_51+@TagCampo48_52+@TagCampo48_53+@TagCampo48_54+@TagCampo48_55+@TagCampo48_56+@TagCampo48_57+@TagCampo48_58+@TagCampo48_59+@TagCampo48_60+@TagCampo48_61+@TagCampo48_62+@TagCampo48_63+@TagCampo48_64+@TagCampo48_65+@TagCampo48_66+@TagCampo48_67+@TagCampo48_68+@TagCampo48_69+@TagCampo48_70+@TagCampo48_71+@TagCampo48_72+@TagCampo48_73+@TagCampo48_74+@TagCampo48_75+@TagCampo48_76+@TagCampo48_77+@TagCampo48_78+@TagCampo48_79+@TagCampo48_80+@TagCampo48_81+@TagCampo48_82+@TagCampo48_83+@TagCampo48_84+@TagCampo48_85+@TagCampo48_86+@TagCampo48_87+@TagCampo48_88+@TagCampo48_89+@TagCampo48_90+@TagCampo48_91+@TagCampo48_92+@TagCampo48_93+@TagCampo48_94+@TagCampo48_95+@TagCampo48_96+@TagCampo48_97+@TagCampo48_98+@TagCampo48_99'
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0120')
AND NumeroCampoISO=48

UPDATE dbo.RespuestaISOCampos -- Se quita el 21 -- se quita el 61 -- se quita el 58 por ATM -- se quita el 18 -- se quita el 37 -- se quita el 23
SET ID_TipoOrigenValor='3',Formula='@TagCampo48_TC+@TagCampo48_09+@TagCampo48_10+@TagCampo48_11+@TagCampo48_12+@TagCampo48_13+@TagCampo48_14+@TagCampo48_15+@TagCampo48_16+@TagCampo48_17+@TagCampo48_19+@TagCampo48_20+@TagCampo48_22+@TagCampo48_24+@TagCampo48_25+@TagCampo48_26+@TagCampo48_27+@TagCampo48_28+@TagCampo48_29+@TagCampo48_30+@TagCampo48_31+@TagCampo48_32+@TagCampo48_33+@TagCampo48_34+@TagCampo48_35+@TagCampo48_36+@TagCampo48_38+@TagCampo48_39+@TagCampo48_40+@TagCampo48_41+@TagCampo48_42+@TagCampo48_43+@TagCampo48_44+@TagCampo48_45+@TagCampo48_46+@TagCampo48_47+@TagCampo48_48+@TagCampo48_49+@TagCampo48_50+@TagCampo48_51+@TagCampo48_52+@TagCampo48_53+@TagCampo48_54+@TagCampo48_55+@TagCampo48_56+@TagCampo48_57+@TagCampo48_59+@TagCampo48_60+@TagCampo48_62+@TagCampo48_63+@TagCampo48_64+@TagCampo48_65+@TagCampo48_66+@TagCampo48_67+@TagCampo48_68+@TagCampo48_69+@TagCampo48_70+@TagCampo48_71+@TagCampo48_72+@TagCampo48_73+@TagCampo48_74+@TagCampo48_75+@TagCampo48_76+@TagCampo48_77+@TagCampo48_78+@TagCampo48_79+@TagCampo48_80+@TagCampo48_81+@TagCampo48_82+@TagCampo48_83+@TagCampo48_84+@TagCampo48_85+@TagCampo48_86+@TagCampo48_87+@TagCampo48_88+@TagCampo48_89+@TagCampo48_90+@TagCampo48_91+@TagCampo48_92+@TagCampo48_93+@TagCampo48_94+@TagCampo48_95+@TagCampo48_96+@TagCampo48_97+@TagCampo48_98+@TagCampo48_99'
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP')
AND NumeroCampoISO=48

UPDATE dbo.RespuestaISOCampos -- Se quita el 21 -- se quita el 61 -- se quita el 58 por ATM
SET ID_TipoOrigenValor='2',Formula='@Tag_91'--@Tag_9F1A+@Tag_9C
WHERE ID_RespuestaISO = (SELECT ID_RespuestaISO FROM dbo.RespuestaISO WHERE Descripcion='Respuesta ISO 0100 CHIP')
AND NumeroCampoISO=55

--------------------------------------------------------
---------Insertar en la tabla ValoresISO8583 el parametro @ImpComisionConsultaSaldo para el plugin pos
INSERT INTO dbo.ValoresISO8583
SELECT 
       ID_TipoColectiva,
       (SELECT ID_Plugin FROM dbo.PlugIns WHERE Nombre='isoPlugInMASTERCARDPOS'),
       Nombre,
       Descripcion,
       esValorSubCampo,
       esValorToken,
       esClave,
       CampoISO,
       SubCampoISO,
       TipoDatoSQL,
       TipoDatoC,
       TipoDatoJava,
       SubCadena,
       ClaveToken,
       SubCampoToken,
       esFormula,
       Formula FROM dbo.ValoresISO8583
WHERE Nombre LIKE '%@ImpComisionConsultaSaldo%'

--Actualizarlo ya que no cobran comision, sino viene en el importe el valor a cobrar,
--ES ESTO O DEL SCRIPT CONTABLE CAMBIAR LA FORMULA PARA QUITAR EL @ImpComisionConsultaSaldo
UPDATE dbo.ValoresISO8583
SET esValorToken=0,CampoISO=-1,ClaveToken=NULL,SubCampoToken=NULL
WHERE Nombre LIKE '%@ImpComisionConsultaSaldo%'
--------------------------------------------------------
---------Modificar la columna LlaveEncriptada de la tabla Llaves, Aumentar los caracteres que soporta de 50 a 500
ALTER TABLE dbo.Llaves
ALTER COLUMN LlaveEncriptada VARCHAR(500);
--------------------------------------------------------
---------Modificar la tabla ValidadorCampos8583, Rechazo por CVV cambiar el codigo a 05
UPDATE dbo.ValidadorCampos8583
SET CodigoError='05'
WHERE Formula IN ('nCripter_ValidacionCVV',
'nCripter_ValidacionCVV2',
'nCripter_Validacion_iCVV')
--------------------------------------------------------


-----------Insertar nueva Clasificacion de Parametros para HSM REALSEC de la tabla ClasificacionParametros
--	INSERT INTO dbo.ClasificacionParametros
--	(
--	    Clave,
--	    Descripcion
--	)
--	VALUES
--	(   'REALSEC', -- Clave - varchar(10)
--	    'Parametros para HSM REALSEC'  -- Descripcion - varchar(150)
--	    )
----------------------------------------------------------
-----------Insertar Parametros para HSM REALSEC de la tabla ValoresContrato
--	INSERT INTO dbo.ValoresContrato
--	(
--	    Nombre,
--	    Descripcion,
--	    TipoDatoJava,
--	    ID_TipoColectiva,
--	    TipoDatoSQL,
--	    esClave,
--	    ID_ClasificacionParametros,
--	    Posicion
--	)
--	VALUES
--	(   '@keyCVV', -- Nombre - varchar(50)
--	    'CVV/CVC Key bajo la LMK (5,29,35,6)', -- Descripcion - varchar(150)
--	    'string', -- TipoDatoJava - varchar(20)
--	    NULL, -- ID_TipoColectiva - int
--	    'string', -- TipoDatoSQL - varchar(50)
--	    0, -- esClave - bit
--	    (SELECT ID_ClasificacionParametros FROM dbo.ClasificacionParametros WHERE Clave='REALSEC'), -- ID_ClasificacionParametros - int
--	    1  -- Posicion - int
--	    ),
--	(   '@keyARQC', -- Nombre - varchar(50)
--	    'MK-AC Key para ARQC bajo la LMK (29,6)', -- Descripcion - varchar(150)
--	    'string', -- TipoDatoJava - varchar(20)
--	    NULL, -- ID_TipoColectiva - int
--	    'string', -- TipoDatoSQL - varchar(50)
--	    0, -- esClave - bit
--	    (SELECT ID_ClasificacionParametros FROM dbo.ClasificacionParametros WHERE Clave='REALSEC'), -- ID_ClasificacionParametros - int
--	    2  -- Posicion - int
--	    )
--	(   '@KeyTransportPIN', -- Nombre - varchar(50)
--	    'Llave de transporte del PIN bajo la LMK (03)', -- Descripcion - varchar(150)
--	    'string', -- TipoDatoJava - varchar(20)
--	    NULL, -- ID_TipoColectiva - int
--	    'string', -- TipoDatoSQL - varchar(50)
--	    0, -- esClave - bit
--	    (SELECT ID_ClasificacionParametros FROM dbo.ClasificacionParametros WHERE Clave='REALSEC'), -- ID_ClasificacionParametros - int
--	    3  -- Posicion - int
--	    )
--	(   '@KeyTransportImport', -- Nombre - varchar(50)
--	    'Llave de decifrado para importar llaves bajo la LMK (02,60,62)', -- Descripcion - varchar(150)
--	    'string', -- TipoDatoJava - varchar(20)
--	    NULL, -- ID_TipoColectiva - int
--	    'string', -- TipoDatoSQL - varchar(50)
--	    0, -- esClave - bit
--	    (SELECT ID_ClasificacionParametros FROM dbo.ClasificacionParametros WHERE Clave='REALSEC'), -- ID_ClasificacionParametros - int
--	    4  -- Posicion - int
--	    )
----------------------------------------------------------

