USE Autorizador
GO

BEGIN TRAN trx_Emb

DECLARE @idClasificacion INT = (SELECT ID_ClasificacionParametros FROM ClasificacionParametros WHERE Clave = 'nCripter')

DECLARE @posicion INT = (SELECT COUNT(*) FROM ValoresContrato WHERE ID_ClasificacionParametros = @idClasificacion) + 1;

IF NOT EXISTS(SELECT * FROM ValoresContrato WHERE Nombre= '@keyPINBlockEmbozo')
BEGIN
	INSERT INTO ValoresContrato(Nombre, Descripcion, TipoDatoJava,TipoDatoSQL, esClave, ID_ClasificacionParametros, Posicion)
	VALUES('@keyPINBlockEmbozo','Etiqueta de la llave de trabajo (ZPK) para el metodo Validación de PIN Embozo',
		'string','string',0,@idClasificacion,@posicion)
END

UPDATE EMBOZO_Instancia SET Embozador = 'MYCARD'

INSERT INTO EMBOZO_OrigenDatos(ID_EMBOZO_Instancia,q_text,q_type,q_connStringConfigurationKey,q_timeOut,ID_Colectiva,GeneraNIP,ObtieneDireccionEntregaAutorizador)
SELECT '1','EMBOZO_Paycard_ObtenerTarjetas','SP','BDReadAutorizador','600',ID_Colectiva,1,1 FROM Colectivas WHERE ID_TipoColectiva = 5

DELETE FROM EMBOZO_Parametros
GO

SET IDENTITY_INSERT [dbo].[EMBOZO_Parametros] ON 
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (1, 1, 1, N'N', 6, 1, 6, N'N_CORRELATIVO', N'Nro. correlativo', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (2, 1, 1, N'A', 1, 7, 7, N'', N'Separador de Línea ($)', N'36', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (3, 1, 1, N'A', 19, 8, 26, N'N_TARJETA_SEC', N'PAN indent', N'', N'TS')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (4, 1, 1, N'A', 1, 27, 27, N'', N'Separador de Línea 2 (*)', N'42', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (5, 1, 1, N'A', 5, 28, 32, N'FEC_VIGENCIA_HASTA', N'Fecha de Expiración  MM/YY', N'MM/yy', N'PLF')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (6, 1, 1, N'A', 1, 33, 33, N'', N'Separador de Línea 3 ())', N'41', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (7, 1, 1, N'A', 21, 34, 54, N'NOMBRE_EMBOZO', N'Nombre a embozar del Tarjetahabiente', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (8, 1, 1, N'A', 1, 55, 55, N'', N'Separador de Línea 4 (:)', N'58', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (9, 1, 1, N'N', 3, 56, 58, N'CVV2', N'Código de Seguridad a imprimir en la tarjeta', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (10, 1, 1, N'A', 1, 59, 59, N'', N'Encoding Command Character (*)', N'42', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (11, 1, 1, N'A', 1, 60, 60, N'', N'Caracter de inicio Track 1 (%)', N'37', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (12, 1, 1, N'A', 1, 61, 61, N'', N'Format Code (B)', N'66', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (13, 1, 1, N'N', 16, 62, 77, N'N_TARJETA', N'Número de Tarjeta', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (14, 1, 1, N'A', 1, 78, 78, N'', N'Separador de Campo (^)', N'94', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (15, 1, 1, N'A', 26, 79, 104, N'NOMBRE_TARJETAHABIENTE', N'Nombre del Tarjetahabiente seperando apellido/nombre con "/"', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (16, 1, 1, N'A', 1, 105, 105, N'', N'Separador de Campo (^)', N'94', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (17, 1, 1, N'N', 4, 106, 109, N'FEC_VIGENCIA_HASTA', N'Fecha de Expiración  yyMM', N'yyMM', N'PLF')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (18, 1, 1, N'N', 3, 110, 112, N'SERVICE_CODE', N'Service Code', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (19, 1, 1, N'N', 1, 113, 113, N'PVK', N'PIN Verification Key Index', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (20, 1, 1, N'N', 4, 114, 117, N'PVV', N'PIN Validation Value', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (21, 1, 1, N'A', 10, 118, 127, N'', N'Reservado 1', N'48', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (22, 1, 1, N'N', 3, 128, 130, N'CVV', N'CVV/CVC', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (23, 1, 1, N'A', 6, 131, 136, N'', N'Reservado 2', N'48', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (24, 1, 1, N'A', 1, 137, 137, N'', N'Caracter de fin Track 1 (?)', N'63', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (25, 1, 1, N'A', 1, 138, 138, N'', N'Caracter de inicio Track 2 (;)', N'59', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (26, 1, 1, N'N', 16, 139, 154, N'N_TARJETA', N'Número de Tarjeta', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (27, 1, 1, N'A', 1, 155, 155, N'', N'Separador de Campo (=)', N'61', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (28, 1, 1, N'N', 4, 156, 159, N'FEC_VIGENCIA_HASTA', N'Fecha de Expiración  yyMM', N'yyMM', N'PLF')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (29, 1, 1, N'N', 3, 160, 162, N'SERVICE_CODE', N'Service Code', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (30, 1, 1, N'N', 1, 163, 163, N'PVK', N'PIN Verification Key Index', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (31, 1, 1, N'N', 4, 164, 167, N'PVV', N'PIN Validation Value', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (32, 1, 1, N'N', 3, 168, 170, N'CVV', N'CVV/CVC', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (33, 1, 1, N'A', 5, 171, 175, N'', N'Reservado 3 (0)', N'48', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (34, 1, 1, N'A', 1, 176, 176, N'', N'Caracter de fin Track 2 (?)', N'63', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (35, 1, 1, N'A', 1, 177, 177, N'TIPO_TAR', N'Tipo de Tarjeta T=Titular, A=Adicional', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (36, 1, 1, N'A', 1, 178, 178, N'RAZON_FAB', N'Razón de fabricación N =Nueva, R=Reposición, V=Renovación', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (37, 1, 1, N'N', 3, 179, 181, N'ICVV', N'iCVV/iCVC', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (38, 1, 1, N'N', 16, 182, 197, N'PIN_BLOCK', N'PIN Block', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (39, 1, 1, N'A', 30, 198, 227, N'CALLE', N'Calle del Domicilio del Tarjetahabiente', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (40, 1, 1, N'N', 4, 228, 231, N'N_EXTERIOR', N'Número Exterior del Domicilio del Tarjetahabiente', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (41, 1, 1, N'N', 4, 232, 235, N'N_INTERIOR', N'Número Interior del Domicilio del Tarjetahabiente', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (42, 1, 1, N'N', 5, 236, 240, N'CP', N'Código postal', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (43, 1, 1, N'A', 20, 241, 260, N'COLONIA', N'Colonia', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (44, 1, 1, N'A', 20, 261, 280, N'MUNICIPIO', N'Municipio', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (45, 1, 1, N'A', 20, 281, 300, N'ESTADO', N'Estado', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (46, 1, 1, N'A', 20, 301, 320, N'PAIS', N'Pais', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (47, 1, 1, N'A', 30, 321, 350, N'NOM_EMPRESA', N'Nombre de la empresa', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (48, 1, 1, N'A', 2, 351, 352, N'CLAVE_DISENO', N'Clave del diseño a imprimir', N'', N'PL')

GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (49, 1, 1, N'N', 20, 353, 372, N'FOLIO_QR', N'Folio QR', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (50, 1, 1, N'A', 100, 373, 472, N'CODIGO_QR', N'Codigo QR', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (51, 1, 1, N'A', 36, 473, 508, N'BIN7', N'Bin 7', N'', N'PL')

GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (52, 1, 2, N'F', 10, 1, 10, N'CLIENTE', N'Código de CLIENTE', N'', N'PLT')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (53, 1, 2, N'F', 1, 11, 11, N'', N'underscore', N'95', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (54, 1, 2, N'F', 7, 12, 18, N'PRODUCTO', N'Classic', N'', N'PLT')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (55, 1, 2, N'F', 1, 19, 19, N'', N'underscore', N'95', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (56, 1, 2, N'A', 8, 20, 27, N'FECHA_ACTUAL', N'Fecha Actual', N'yyyyMMdd', N'C')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (57, 1, 2, N'F', 6, 28, 33, N'HORA_ACTUAL_S', N'Hora Actual', N'HHMMss', N'C')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (58, 1, 2, N'F', 1, 34, 34, N'', N'underscore', N'95', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (59, 1, 2, N'N', 8, 35, 42, N'CANT_REGISTROS_ARCHIVO', N'Cantidad de registros que contiene el archivo', N'', N'PL')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (60, 1, 2, N'F', 1, 43, 43, N'', N'DOT', N'46', N'CHR')
GO
INSERT [dbo].[EMBOZO_Parametros] ([ID_EMBOZO_Parametros], [ID_EMBOZO_Instancia], [ID_EMBOZO_ParameterType], [form], [long], [initial_index], [final_index], [f_key], [content], [formato], [origin]) VALUES (61, 1, 2, N'F', 3, 44, 46, N'', N'EXTENSION', N'txt', N'F')
GO
SET IDENTITY_INSERT [dbo].[EMBOZO_Parametros] OFF
GO



COMMIT TRAN trx_Emb