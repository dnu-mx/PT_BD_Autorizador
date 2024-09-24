USE [Autorizador]
go

BEGIN TRAN
	
	DECLARE @commit BIT = 1

--AJUSTAR PARA CADA TIPO DE PRODUCTO
DECLARE @ClaveTipoProducto VARCHAR (10) = 'JSON01';
DECLARE @ClaveNumericaDivisa VARCHAR(3) ='484'
DECLARE @AplicaStandIn BIT = 1
DECLARE @ClaveTipoMensajeOnline VARCHAR (10) = '0100';
DECLARE @ClaveTipoMensajeStandin VARCHAR (10) = '0120';

DECLARE @ID_TipoProducto INT;

--SELECT * FROM dbo.Eventos ORDER BY 1 desc
--EVENTOS PARA MARCAR LA PERTENENCIA TIPO

  ----PERTENENCIAS TIPO
  --SELECT EV.ClaveEvento, ev.Descripcion as DescripcionEvento, pt.Descripcion as DescripcionPetenenciaTipo, cp.CodigoProceso, pem.Clave, tm.ClaveTipoMensaje, * 
  --FROM PertenenciaTipo pt 
  --INNER JOIN PertenenciaTipoEvento pte ON pte.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
  --INNER JOIN Eventos ev ON ev.ID_Evento = pte.ID_Evento
  --INNER JOIN POSEntryMode pem ON pem.ID_POSEntryMode = pt.ID_POSEntryMode 
  --INNER JOIN CodigoProceso cp ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
  --INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje
  --WHERE pt.ClaveTipoProducto = @ClaveTipoProducto

-->SI
--COMPRA JSON (CHIP)
DECLARE @ID_EventoPOSCHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02004100MXN484' ) --1123;
DECLARE @EventosPertenenciaPOSCHIP VARCHAR (100) ='T02004100MXN484';
DECLARE @POSEM_POSCHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_POS VARCHAR (200) ='00%'

DECLARE @ID_EventoPOSCHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02004103MXN484' ) --1123;
DECLARE @EventosPertenenciaPOSCHIP_STANDIN VARCHAR (100) ='T02004103MXN484';
DECLARE @POSEM_POSCHIP_STANDIN VARCHAR (200) ='05_'
DECLARE @CodigosProceso_POSCHIP_STANDIN VARCHAR (200) ='00%'

-->SI
--COMPRA JSON (BANDA)
DECLARE @ID_EventoPOSBANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02002700MXN484' ) --1123;
DECLARE @EventosPertenenciaBANDA VARCHAR (100) = 'T02002700MXN484';
DECLARE @POSEM_POSBANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_POSBANDA VARCHAR (200) ='00%'

DECLARE @ID_EventoPOSBANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02002703MXN484' ) --1123;
DECLARE @EventosPertenenciaPOSBANDA_STANDIN VARCHAR (100) = 'T02002703MXN484';
DECLARE @POSEM_POSBANDA_STANDIN VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_POSBANDA_STANDIN VARCHAR (200) ='00%'

-->SI
--COMPRA JSON (CONTACTLESS)
DECLARE @ID_EventoPOSCL VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02001700MXN484' ) --1123;
DECLARE @EventosPertenenciaPOSCL VARCHAR (100) = 'T02001700MXN484';
DECLARE @POSEM_POSCL VARCHAR (200) ='07_'
DECLARE @CodigosProceso_POSCL VARCHAR (200) ='00%'

DECLARE @ID_EventoPOSCL_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02001703MXN484' ) --1123;
DECLARE @EventosPertenenciaPOSCL_STANDIN VARCHAR (100) = 'T02001703MXN484';
DECLARE @POSEM_POSCL_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_POSCL_STANDIN VARCHAR (200) ='00%'

--------------------------------------COMPRA CON CASHADVANCE------------------------------------------------------------------------------------
-->SI
--COMPRA CASHADVANCE JSON (CHIP)
DECLARE @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02144100MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHADVANCE_JSON_CHIP VARCHAR (100) ='T02144100MXN484';
DECLARE @POSEM_COMRPA_CASHADVANCE_JSON_CHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_COMRPA_CASHADVANCE_JSON_CHIP VARCHAR (200) ='17%'

DECLARE @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02144103MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHADVANCE_JSON_CHIP_STANDIN VARCHAR (100) ='T02144103MXN484';
DECLARE @POSEM_COMRPA_CASHADVANCE_JSON_CHIP_STANDIN VARCHAR (200) ='05_'
DECLARE @CodigosProceso_COMRPA_CASHADVANCE_JSON_CHIP_STANDIN VARCHAR (200) ='17%'

-->SI
--COMPRA CASHADVANCE JSON (BANDA)
DECLARE @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02142700MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHADVANCE_JSON_BANDA VARCHAR (100) = 'T02142700MXN484';
DECLARE @POSEM_COMRPA_CASHADVANCE_JSON_BANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_COMRPA_CASHADVANCE_JSON_BANDA VARCHAR (200) ='17%'

DECLARE @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02142703MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHADVANCE_JSON_BANDA_STANDIN VARCHAR (100) = 'T02142703MXN484';
DECLARE @POSEM_COMRPA_CASHADVANCE_JSON_BANDA_STANDIN VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_COMRPA_CASHADVANCE_JSON_BANDA_STANDIN VARCHAR (200) ='17%'

-->SI
--COMPRA CASHADVANCE JSON (CONTACTLESS)
DECLARE @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02141700MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHADVANCE_JSON_CONTACTLESS VARCHAR (100) = 'T02141700MXN484';
DECLARE @POSEM_COMRPA_CASHADVANCE_JSON_CONTACTLESS VARCHAR (200) ='07_'
DECLARE @CodigosProceso_COMRPA_CASHADVANCE_JSON_CONTACTLESS VARCHAR (200) ='17%'

DECLARE @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02141703MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN VARCHAR (100) = 'T02141703MXN484';
DECLARE @POSEM_COMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_COMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN VARCHAR (200) ='17%'

-->SI
--COMPRA CASHADVANCE JSON (E-COMMERCE CON CVV DINÁMICO)
DECLARE @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02144000MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO VARCHAR (100) ='T02144000MXN484';
DECLARE @POSEM_COMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO VARCHAR (200) ='10_,00_,01_,02_,81_'
DECLARE @CodigosProceso_COMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO VARCHAR (200) ='17%'

DECLARE @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02144003MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN VARCHAR (100) ='T02144003MXN484';
DECLARE @POSEM_COMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_'
DECLARE @CodigosProceso_COMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN VARCHAR (200) ='17%'
---------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------COMPRA CON CASHBACK------------------------------------------------------------------------------------
-->SI
--COMPRA CASHBACK JSON (CHIP)
DECLARE @ID_EventoCOMRPA_CASHBACK_JSON_CHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02094100MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHBACK_JSON_CHIP VARCHAR (100) ='T02094100MXN484';
DECLARE @POSEM_COMRPA_CASHBACK_JSON_CHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_COMRPA_CASHBACK_JSON_CHIP VARCHAR (200) ='09%'

DECLARE @ID_EventoCOMRPA_CASHBACK_JSON_CHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02094103MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHBACK_JSON_CHIP_STANDIN VARCHAR (100) ='T02094103MXN484';
DECLARE @POSEM_COMRPA_CASHBACK_JSON_CHIP_STANDIN VARCHAR (200) ='05_'
DECLARE @CodigosProceso_COMRPA_CASHBACK_JSON_CHIP_STANDIN VARCHAR (200) ='09%'

-->SI
--COMPRA CASHBACK JSON (BANDA)
DECLARE @ID_EventoCOMRPA_CASHBACK_JSON_BANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02092700MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHBACK_JSON_BANDA VARCHAR (100) = 'T02092700MXN484';
DECLARE @POSEM_COMRPA_CASHBACK_JSON_BANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_COMRPA_CASHBACK_JSON_BANDA VARCHAR (200) ='09%'

DECLARE @ID_EventoCOMRPA_CASHBACK_JSON_BANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02092703MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHBACK_JSON_BANDA_STANDIN VARCHAR (100) = 'T02092703MXN484';
DECLARE @POSEM_COMRPA_CASHBACK_JSON_BANDA_STANDIN VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_COMRPA_CASHBACK_JSON_BANDA_STANDIN VARCHAR (200) ='09%'

-->SI
--COMPRA CASHBACK JSON (CONTACTLESS)
DECLARE @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02091700MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHBACK_JSON_CONTACTLESS VARCHAR (100) = 'T02091700MXN484';
DECLARE @POSEM_COMRPA_CASHBACK_JSON_CONTACTLESS VARCHAR (200) ='07_'
DECLARE @CodigosProceso_COMRPA_CASHBACK_JSON_CONTACTLESS VARCHAR (200) ='09%'

DECLARE @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02091703MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN VARCHAR (100) = 'T02091703MXN484';
DECLARE @POSEM_COMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_COMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN VARCHAR (200) ='09%'

-->SI
--COMPRA CASHBACK JSON (E-COMMERCE CON CVV DINÁMICO)
DECLARE @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02094000MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO VARCHAR (100) ='T02094000MXN484';
DECLARE @POSEM_COMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO VARCHAR (200) ='10_,00_,01_,02_,81_'
DECLARE @CodigosProceso_COMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO VARCHAR (200) ='09%'

DECLARE @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02094003MXN484' ) --1123;
DECLARE @EventosPertenenciaCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN VARCHAR (100) ='T02094003MXN484';
DECLARE @POSEM_COMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_'
DECLARE @CodigosProceso_COMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN VARCHAR (200) ='09%'
---------------------------------------------------------------------------------------------------------------------------------------------


-->N/E
--RETIRO EN ATM JSON (CHIP)
DECLARE @CodigosProceso_ATMCHIP90 VARCHAR (200) ='95%'

DECLARE @ID_EventoATMCHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02014100MXN484' ) --1123;
DECLARE @EventosPertenenciaATMCHIP VARCHAR (100) = 'T02014100MXN484';
DECLARE @POSEM_ATMCHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_ATMCHIP VARCHAR (200) ='01%'

DECLARE @ID_EventoATMCHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02014103MXN484' ) --1123;
DECLARE @EventosPertenenciaATMCHIP_STANDIN VARCHAR (100) = 'T02014103MXN484';
DECLARE @POSEM_ATMCHIP_STANDIN VARCHAR (200) ='05_'
DECLARE @CodigosProceso_ATMCHIP_STANDIN VARCHAR (200) ='01%'

-->SI
--RETIRO EN ATM JSON (BANDA)
DECLARE @ID_EventoATMBANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02012700MXN484' ) --1123;
DECLARE @EventosPertenenciaATMBANDA VARCHAR (100) = 'T02012700MXN484';
DECLARE @POSEM_ATMBANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_ATMBANDA VARCHAR (200) ='01%'

DECLARE @ID_EventoATMBANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02012703MXN484' ) --1123;
DECLARE @EventosPertenenciaATMBANDA_STANDIN VARCHAR (100) = 'T02012703MXN484';
DECLARE @POSEM_ATMBANDA_STANDIN VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_ATMBANDA_STANDIN VARCHAR (200) ='01%'

-->SI
--RETIRO EN ATM JSON (CONTACTLESS)
DECLARE @ID_EventoATMCL VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02011700MXN484' ) --1123;
DECLARE @EventosPertenenciaATMCL VARCHAR (100) = 'T02011700MXN484';
DECLARE @POSEM_ATMCL VARCHAR (200) ='07_'
DECLARE @CodigosProceso_ATMCL VARCHAR (200) ='01%'

DECLARE @ID_EventoATMCL_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02011703MXN484' ) --1123;
DECLARE @EventosPertenenciaATMCL_STANDIN VARCHAR (100) = 'T02011703MXN484';
DECLARE @POSEM_ATMCL_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_ATMCL_STANDIN VARCHAR (200) ='01%'

-->N/E
--RETIRO EN ATM JSON (TECLEADA CON CVV2)
DECLARE @ID_EventoATMECOM VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02011600MXN484' ) --1123;
DECLARE @EventosPertenenciaATMECOM VARCHAR (100) = 'T02011600MXN484';
DECLARE @POSEM_ATMECOM VARCHAR (200) ='10_,00_,01_,02_,81_'
DECLARE @CodigosProceso_ATMECOM VARCHAR (200) ='01%'

DECLARE @ID_EventoATMECOM_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02011603MXN484' ) --1123;
DECLARE @EventosPertenenciaATMECOM_STANDIN VARCHAR (100) = 'T02011603MXN484';
DECLARE @POSEM_ATMECOM_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_'
DECLARE @CodigosProceso_ATMECOM_STANDIN VARCHAR (200) ='01%'

-->N/E
--CONSULTA DE SALDO EN ATM JSON (CHIP)
DECLARE @CodigosProceso_ConsultaSaldo30 VARCHAR (200) ='30%'

DECLARE @ID_EventoConsultaSaldoCHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02304100MXN484' ) --1123;
DECLARE @EventosPertenenciaConsultaSaldoCHIP VARCHAR (100) =  'T02304100MXN484';
DECLARE @POSEM_ConsultaSaldoCHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_ConsultaSaldoCHIP VARCHAR (200) ='31%'

DECLARE @ID_EventoConsultaSaldoCHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02304103MXN484' ) --1123;
DECLARE @EventosPertenenciaConsultaSaldoCHIP_STANDIN VARCHAR (100) =  'T02304103MXN484';
DECLARE @POSEM_ConsultaSaldoCHIP_STANDIN VARCHAR (200) ='05_'
DECLARE @CodigosProceso_ConsultaSaldoCHIP_STANDIN VARCHAR (200) ='31%'

-->SI
--CONSULTA DE SALDO EN ATM JSON (BANDA)
DECLARE @ID_EventoConsultaSaldoBANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02302700MXN484' ) --1123;
DECLARE @EventosPertenenciaConsultaSaldoBANDA VARCHAR (100) = 'T02302700MXN484';
DECLARE @POSEM_ConsultaSaldoBANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_ConsultaSaldoBANDA VARCHAR (200) ='31%'

DECLARE @ID_EventoConsultaSaldoBANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02302703MXN484' ) --1123;
DECLARE @EventosPertenenciaConsultaSaldoBANDA_STANDIN VARCHAR (100) = 'T02302703MXN484';
DECLARE @POSEM_ConsultaSaldoBANDA_STANDIN VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_ConsultaSaldoBANDA_STANDIN VARCHAR (200) ='31%'

-->SI
--CONSULTA DE SALDO EN ATM JSON (CONTACTLESS)
DECLARE @ID_EventoConsultaSaldoCL VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02301700MXN484' ) --1123;
DECLARE @EventosPertenenciaConsultaSaldoCL VARCHAR (100) = 'T02301700MXN484';
DECLARE @POSEM_ConsultaSaldoCL VARCHAR (200) ='07_'
DECLARE @CodigosProceso_ConsultaSaldoCL VARCHAR (200) ='31%'

DECLARE @ID_EventoConsultaSaldoCL_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02301703MXN484' ) --1123;
DECLARE @EventosPertenenciaConsultaSaldoCL_STANDIN VARCHAR (100) = 'T02301703MXN484';
DECLARE @POSEM_ConsultaSaldoCL_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_ConsultaSaldoCL_STANDIN VARCHAR (200) ='31%'

---->SI
----COMPRA JSON (E-COMMERCE CON CVV2)
--DECLARE @ID_EventoEcommerce VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02001600MXN484' ) --1123;
--DECLARE @EventosPertenenciaEcommerce VARCHAR (100) ='T02001600MXN484'
--DECLARE @POSEM_Ecommerce VARCHAR (200) ='10_,00_,01_,02_,81_'
--DECLARE @CodigosProceso_Ecommerce VARCHAR (200) ='00%'

-->SI
--COMPRA JSON (E-COMMERCE CON CVV DINÁMICO)
DECLARE @ID_EventoEcommerceDinamico VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02004000MXN484' ) --1123;
DECLARE @EventosPertenenciaEcommerceDinamico VARCHAR (100) ='T02004000MXN484'
DECLARE @POSEM_EcommerceDinamico VARCHAR (200) ='10_,00_,01_,02_,81_'
DECLARE @CodigosProceso_EcommerceDinamico VARCHAR (200) ='00%'

DECLARE @ID_EventoEcommerceDinamico_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02004003MXN484' ) --1123;
DECLARE @EventosPertenenciaEcommerceDinamico_STANDIN VARCHAR (100) ='T02004003MXN484'
DECLARE @POSEM_EcommerceDinamico_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_'
DECLARE @CodigosProceso_EcommerceDinamico_STANDIN VARCHAR (200) ='00%'

-->N/E
--COMPRA JSON (FALLBACK)
DECLARE @ID_EventoCompraTddGcFALLBACK VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02005400MXN484' ) --1123;
DECLARE @EventosPertenenciaCompraTddGcFALLBACK VARCHAR (100) =  'T02005400MXN484';
DECLARE @POSEM_CompraTddGcFALLBACK VARCHAR (200) ='80_'
DECLARE @CodigosProceso_CompraTddGcFALLBACK VARCHAR (200) ='00%'

DECLARE @ID_EventoCompraTddGcFALLBACK_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02005403MXN484' ) --1123;
DECLARE @EventosPertenenciaCompraTddGcFALLBACK_STANDIN VARCHAR (100) =  'T02005403MXN484';
DECLARE @POSEM_CompraTddGcFALLBACK_STANDIN VARCHAR (200) ='80_'
DECLARE @CodigosProceso_CompraTddGcFALLBACK_STANDIN VARCHAR (200) ='00%'

/*----------------------------------------------------DEVOLUCIONES--------------------------------------------------*/
-->N/E
--DEVOLUCIÓN SBC JSON (CHIP)
DECLARE @ID_EventoDevolucionSbcTddGcCHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02204100MXN484' ) --1123;
DECLARE @EventosPertenenciaDevolucionSbcTddGcCHIP VARCHAR (100) =  'T02204100MXN484';
DECLARE @POSEM_DevolucionSbcTddGcCHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_DevolucionSbcTddGcCHIP VARCHAR (200) ='20%'

DECLARE @ID_EventoDevolucionSbcTddGcCHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02204103MXN484' ) --1123;
DECLARE @EventosPertenenciaDevolucionSbcTddGcCHIP_STANDIN VARCHAR (100) =  'T02204103MXN484';
DECLARE @POSEM_DevolucionSbcTddGcCHIP_STANDIN VARCHAR (200) ='05_'
DECLARE @CodigosProceso_DevolucionSbcTddGcCHIP_STANDIN VARCHAR (200) ='20%'

-->N/E
--DEVOLUCIÓN SBC JSON (BANDA)
DECLARE @ID_EventoDevolucionSbcTddGcBANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02202700MXN484' ) --1123;
DECLARE @EventosPertenenciaDevolucionSbcTddGcBANDA VARCHAR (100) =  'T02202700MXN484';
DECLARE @POSEM_DevolucionSbcTddGcBANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_DevolucionSbcTddGcBANDA VARCHAR (200) ='20%'

DECLARE @ID_EventoDevolucionSbcTddGcBANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02202703MXN484' ) --1123;
DECLARE @EventosPertenenciaDevolucionSbcTddGcBANDA_STANDIN VARCHAR (100) =  'T02202703MXN484';
DECLARE @POSEM_DevolucionSbcTddGcBANDA_STANDIN VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_DevolucionSbcTddGcBANDA_STANDIN VARCHAR (200) ='20%'

-->N/E
--DEVOLUCIÓN SBC JSON (CONTACTLESS)
DECLARE @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02201700MXN484' ) --1123;
DECLARE @EventosPertenenciaDevolucionSbcTddGcCONTACTLESS_STANDIN VARCHAR (100) =  'T02201700MXN484';
DECLARE @POSEM_DevolucionSbcTddGcCONTACTLESS_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_DevolucionSbcTddGcCONTACTLESS_STANDIN VARCHAR (200) ='20%'

DECLARE @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02201703MXN484' ) --1123;
DECLARE @EventosPertenenciaDevolucionSbcTddGcCONTACTLESS_STANDIN_STANDIN VARCHAR (100) =  'T02201703MXN484';
DECLARE @POSEM_DevolucionSbcTddGcCONTACTLESS_STANDIN_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_DevolucionSbcTddGcCONTACTLESS_STANDIN_STANDIN VARCHAR (200) ='20%'

/*----------------------------------------------------CANCELACION--------------------------------------------------*/
-->N/E 
--CANCELACIÓN SBC JSON (CHIP)
DECLARE @ID_EventoCancelacionSbcTddGcCHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02DA4100MXN484' ) --1123;
DECLARE @EventosPertenenciaCancelacionSbcTddGcCHIP VARCHAR (100) =  'T02DA4100MXN484';
DECLARE @POSEM_CancelacionSbcTddGcCHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_CancelacionSbcTddGcCHIP VARCHAR (200) ='02%'

DECLARE @ID_EventoCancelacionSbcTddGcCHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02DA4103MXN484' ) --1123;
DECLARE @EventosPertenenciaCancelacionSbcTddGcCHIP_STANDIN VARCHAR (100) =  'T02DA4103MXN484';
DECLARE @POSEM_CancelacionSbcTddGcCHIP_STANDIN VARCHAR (200) ='05_'
DECLARE @CodigosProceso_CancelacionSbcTddGcCHIP_STANDIN VARCHAR (200) ='02%'

-->N/E
--CANCELACIÓN SBC JSON (BANDA)
DECLARE @ID_EventoCancelacionSbcTddGcBANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02DA2700MXN484' ) --1123;
DECLARE @EventosPertenenciaCancelacionSbcTddGcBANDA VARCHAR (100) =  'T02DA2700MXN484';
DECLARE @POSEM_CancelacionSbcTddGcBANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_CancelacionSbcTddGcBANDA VARCHAR (200) ='02%'

DECLARE @ID_EventoCancelacionSbcTddGcBANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02DA2703MXN484' ) --1123;
DECLARE @EventosPertenenciaCancelacionSbcTddGcBANDA_STANDIN VARCHAR (100) =  'T02DA2703MXN484';
DECLARE @POSEM_CancelacionSbcTddGcBANDA_STANDIN VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_CancelacionSbcTddGcBANDA_STANDIN VARCHAR (200) ='02%'

-->N/E
--CANCELACIÓN SBC JSON (CONTACTLESS)
DECLARE @ID_EventoCancelacionSbcTddGcCONTACTLESS VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02DA1700MXN484' ) --1123;
DECLARE @EventosPertenenciaCancelacionSbcTddGcCONTACTLESS VARCHAR (100) =  'T02DA1700MXN484';
DECLARE @POSEM_CancelacionSbcTddGcCONTACTLESS VARCHAR (200) ='07_'
DECLARE @CodigosProceso_CancelacionSbcTddGcCONTACTLESS VARCHAR (200) ='02%'

DECLARE @ID_EventoCancelacionSbcTddGcCONTACTLESS_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02DA1703MXN484' ) --1123;
DECLARE @EventosPertenenciaCancelacionSbcTddGcCONTACTLESS_STANDIN VARCHAR (100) =  'T02DA1703MXN484';
DECLARE @POSEM_CancelacionSbcTddGcCONTACTLESS_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_CancelacionSbcTddGcCONTACTLESS_STANDIN VARCHAR (200) ='02%'

/*----------------------------------------------------FastFund--------------------------------------------------*/
---->N/E
----FAST FUND SBC JSON (CHIP)
--DECLARE @ID_EventoFastFundSbcTddGcCHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02264100MXN484' ) --1123;
--DECLARE @EventosPertenenciaFastFundSbcTddGcCHIP VARCHAR (100) =  'T02264100MXN484';
--DECLARE @POSEM_FastFundSbcTddGcCHIP VARCHAR (200) ='05_'
--DECLARE @CodigosProceso_FastFundSbcTddGcCHIP VARCHAR (200) ='26%'

--DECLARE @ID_EventoFastFundSbcTddGcCHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02264103MXN484' ) --1123;
--DECLARE @EventosPertenenciaFastFundSbcTddGcCHIP_STANDIN VARCHAR (100) =  'T02264103MXN484';
--DECLARE @POSEM_FastFundSbcTddGcCHIP_STANDIN VARCHAR (200) ='05_'
--DECLARE @CodigosProceso_FastFundSbcTddGcCHIP_STANDIN VARCHAR (200) ='26%'

---->N/E
----FAST FUND SBC JSON (BANDA)
--DECLARE @ID_EventoFastFundSbcTddGcBANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02262700MXN484' ) --1123;
--DECLARE @EventosPertenenciaFastFundSbcTddGcBANDA VARCHAR (100) =  'T02262700MXN484';
--DECLARE @POSEM_FastFundSbcTddGcBANDA VARCHAR (200) ='90_,91_'
--DECLARE @CodigosProceso_FastFundSbcTddGcBANDA VARCHAR (200) ='26%'

--DECLARE @ID_EventoFastFundSbcTddGcBANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02262703MXN484' ) --1123;
--DECLARE @EventosPertenenciaFastFundSbcTddGcBANDA_STANDIN VARCHAR (100) =  'T02262703MXN484';
--DECLARE @POSEM_FastFundSbcTddGcBANDA_STANDIN VARCHAR (200) ='90_,91_'
--DECLARE @CodigosProceso_FastFundSbcTddGcBANDA_STANDIN VARCHAR (200) ='26%'

---->N/E
----FAST FUND SBC JSON (CONTACTLESS)
--DECLARE @ID_EventoFastFundSbcTddGcCONTACTLESS VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02261700MXN484' ) --1123;
--DECLARE @EventosPertenenciaFastFundSbcTddGcCONTACTLESS VARCHAR (100) =  'T02261700MXN484';
--DECLARE @POSEM_FastFundSbcTddGcCONTACTLESS VARCHAR (200) ='07_'
--DECLARE @CodigosProceso_FastFundSbcTddGcCONTACTLESS VARCHAR (200) ='26%'

--DECLARE @ID_EventoFastFundSbcTddGcCONTACTLESS_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02261703MXN484' ) --1123;
--DECLARE @EventosPertenenciaFastFundSbcTddGcCONTACTLESS_STANDIN VARCHAR (100) =  'T02261703MXN484';
--DECLARE @POSEM_FastFundSbcTddGcCONTACTLESS_STANDIN VARCHAR (200) ='07_'
--DECLARE @CodigosProceso_FastFundSbcTddGcCONTACTLESS_STANDIN VARCHAR (200) ='26%'

--/*----------------------------------------------------MoneySend--------------------------------------------------*/
-->N/E
--MONEY SEND SBC JSON (CHIP)
DECLARE @ID_EventoMoneySendSbcTddGcCHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02MS4100MXN484' ) --1123;
DECLARE @EventosPertenenciaMoneySendSbcTddGcCHIP VARCHAR (100) =  'T02MS4100MXN484';
DECLARE @POSEM_MoneySendSbcTddGcCHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_MoneySendSbcTddGcCHIP VARCHAR (200) ='28%'

-->N/E
--MONEY SEND SBC JSON (BANDA)
DECLARE @ID_EventoMoneySendSbcTddGcBANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02MS2700MXN484' ) --1123;
DECLARE @EventosPertenenciaMoneySendSbcTddGcBANDA VARCHAR (100) =  'T02MS2700MXN484';
DECLARE @POSEM_MoneySendSbcTddGcBANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_MoneySendSbcTddGcBANDA VARCHAR (200) ='28%'

-->N/E
--MONEY SEND SBC JSON (CONTACTLESS)
DECLARE @ID_EventoMoneySendSbcTddGcCONTACTLESS VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02MS1700MXN484' ) --1123;
DECLARE @EventosPertenenciaMoneySendSbcTddGcCONTACTLESS VARCHAR (100) =  'T02MS1700MXN484';
DECLARE @POSEM_MoneySendSbcTddGcCONTACTLESS VARCHAR (200) ='07_'
DECLARE @CodigosProceso_MoneySendSbcTddGcCONTACTLESS VARCHAR (200) ='28%'

/*----------------------------------------------------E-COMMERCE CON CVV2--------------------------------------------------*/
-->N/E
--DEVOLUCIÓN SBC JSON (E-COMMERCE CON CVV2)
DECLARE @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2 VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02204000MXN484' ) --1123;
DECLARE @EventosPertenenciaDevolucionSbcTddGcE_COMMERCE_CVV2 VARCHAR (100) =  'T02204000MXN484';
DECLARE @POSEM_DevolucionSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
DECLARE @CodigosProceso_DevolucionSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='20%'

DECLARE @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02204003MXN484' ) --1123;
DECLARE @EventosPertenenciaDevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (100) =  'T02204003MXN484';
DECLARE @POSEM_DevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
DECLARE @CodigosProceso_DevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (200) ='20%'

-->N/E
--CANCELACIÓN SBC JSON (E-COMMERCE CON CVV2)
DECLARE @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2 VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02DA4000MXN484' ) --1123;
DECLARE @EventosPertenenciaCancelacionSbcTddGcE_COMMERCE_CVV2 VARCHAR (100) =  'T02DA4000MXN484';
DECLARE @POSEM_CancelacionSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
DECLARE @CodigosProceso_CancelacionSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='02%'

DECLARE @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02DA4003MXN484' ) --1123;
DECLARE @EventosPertenenciaCancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (100) =  'T02DA4003MXN484';
DECLARE @POSEM_CancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
DECLARE @CodigosProceso_CancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (200) ='02%'

-->N/E
----FAST FUND SBC JSON (E-COMMERCE CON CVV2)
--DECLARE @ID_EventoFastFundSbcTddGcE_COMMERCE_CVV2 VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02264000MXN484' ) --1123;
--DECLARE @EventosPertenenciaFastFundSbcTddGcE_COMMERCE_CVV2 VARCHAR (100) =  'T02264000MXN484';
--DECLARE @POSEM_FastFundSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
--DECLARE @CodigosProceso_FastFundSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='26%'

--DECLARE @ID_EventoFastFundSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02264003MXN484' ) --1123;
--DECLARE @EventosPertenenciaFastFundSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (100) =  'T02264003MXN484';
--DECLARE @POSEM_FastFundSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
--DECLARE @CodigosProceso_FastFundSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (200) ='26%'

-->N/E
--MONEY SEND SBC JSON (E-COMMERCE CON CVV2)
DECLARE @ID_EventoMoneySendSbcTddGcE_COMMERCE_CVV2 VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02MS4000MXN484' ) --1123;
DECLARE @EventosPertenenciaMoneySendSbcTddGcE_COMMERCE_CVV2 VARCHAR (100) =  'T02MS4000MXN484';
DECLARE @POSEM_MoneySendSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
DECLARE @CodigosProceso_MoneySendSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='28%'

/*----------------------------------------------------RETIRO--------------------------------------------------*/
-->N/E
--RETIRO EN ATM JSON (FALLBACK)
DECLARE @ID_EventoRetiroAtmTddGc_FALLBACK VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02015400MXN484' ) --1123;
DECLARE @EventosPertenenciaRetiroAtmTddGc_FALLBACK VARCHAR (100) =  'T02015400MXN484';
DECLARE @POSEM_RetiroAtmTddGc_FALLBACK VARCHAR (200) ='80_'
DECLARE @CodigosProceso_RetiroAtmTddGc_FALLBACK VARCHAR (200) ='01%'

DECLARE @ID_EventoRetiroAtmTddGc_FALLBACK_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02015403MXN484' ) --1123;
DECLARE @EventosPertenenciaRetiroAtmTddGc_FALLBACK_STANDIN VARCHAR (100) =  'T02015403MXN484';
DECLARE @POSEM_RetiroAtmTddGc_FALLBACK_STANDIN VARCHAR (200) ='80_'
DECLARE @CodigosProceso_RetiroAtmTddGc_FALLBACK_STANDIN VARCHAR (200) ='01%'

/*----------------------------------------------------Verificacion--------------------------------------------------*/
-->N/E
--VERIFICACIÓN DE CUENTA JSON (CHIP)
DECLARE @ID_EventoVerificacionSbcTddGcCHIP VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC4100MXN484' ) --1123;
DECLARE @EventosPertenenciaVerificacionSbcTddGcCHIP VARCHAR (100) =  'T02VC4100MXN484';
DECLARE @POSEM_VerificacionSbcTddGcCHIP VARCHAR (200) ='05_'
DECLARE @CodigosProceso_VerificacionSbcTddGcCHIP VARCHAR (200) ='81%'

DECLARE @ID_EventoVerificacionSbcTddGcCHIP_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC4103MXN484' ) --1123;
DECLARE @EventosPertenenciaVerificacionSbcTddGcCHIP_STANDIN VARCHAR (100) =  'T02VC4103MXN484';
DECLARE @POSEM_VerificacionSbcTddGcCHIP_STANDIN VARCHAR (200) ='05_'
DECLARE @CodigosProceso_VerificacionSbcTddGcCHIP_STANDIN VARCHAR (200) ='81%'

-->N/E
--VERIFICACIÓN DE CUENTA JSON (BANDA)
DECLARE @ID_EventoVerificacionSbcTddGcBANDA VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC2700MXN484' ) --1123;
DECLARE @EventosPertenenciaVerificacionSbcTddGcBANDA VARCHAR (100) =  'T02VC2700MXN484';
DECLARE @POSEM_VerificacionSbcTddGcBANDA VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_VerificacionSbcTddGcBANDA VARCHAR (200) ='81%'

DECLARE @ID_EventoVerificacionSbcTddGcBANDA_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC2703MXN484' ) --1123;
DECLARE @EventosPertenenciaVerificacionSbcTddGcBANDA_STANDIN VARCHAR (100) =  'T02VC2703MXN484';
DECLARE @POSEM_VerificacionSbcTddGcBANDA_STANDIN VARCHAR (200) ='90_,91_'
DECLARE @CodigosProceso_VerificacionSbcTddGcBANDA_STANDIN VARCHAR (200) ='81%'

--N/E
--VERIFICACIÓN DE CUENTA JSON (CONTACTLESS)
DECLARE @ID_EventoVerificacionSbcTddGcCONTACTLESS VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC1700MXN484' ) --1123;
DECLARE @EventosPertenenciaVerificacionSbcTddGcCONTACTLESS VARCHAR (100) =  'T02VC1700MXN484';
DECLARE @POSEM_VerificacionSbcTddGcCONTACTLESS VARCHAR (200) ='07_'
DECLARE @CodigosProceso_VerificacionSbcTddGcCONTACTLESS VARCHAR (200) ='81%'

DECLARE @ID_EventoVerificacionSbcTddGcCONTACTLESS_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC1703MXN484' ) --1123;
DECLARE @EventosPertenenciaVerificacionSbcTddGcCONTACTLESS_STANDIN VARCHAR (100) =  'T02VC1703MXN484';
DECLARE @POSEM_VerificacionSbcTddGcCONTACTLESS_STANDIN VARCHAR (200) ='07_'
DECLARE @CodigosProceso_VerificacionSbcTddGcCONTACTLESS_STANDIN VARCHAR (200) ='81%'

-->N/E
--VERIFICACIÓN DE CUENTA JSON (ECOMMERCE CON CVV2)
DECLARE @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2 VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC4000MXN484' ) --1123;
DECLARE @EventosPertenenciaVerificacionSbcTddGcE_COMMERCE_CVV2 VARCHAR (100) =  'T02VC4000MXN484';
DECLARE @POSEM_VerificacionSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
DECLARE @CodigosProceso_VerificacionSbcTddGcE_COMMERCE_CVV2 VARCHAR (200) ='81%'

DECLARE @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC4003MXN484' ) --1123;
DECLARE @EventosPertenenciaVerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (100) =  'T02VC4003MXN484';
DECLARE @POSEM_VerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
DECLARE @CodigosProceso_VerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN VARCHAR (200) ='81%'

-->N/E
----VERIFICACIÓN DE CUENTA JSON (ECOMMERCE CON CVV DINÁMICO)
--DECLARE @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV_DINAMICO VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC4000MXN484' ) --1123;
--DECLARE @EventosPertenenciaVerificacionSbcTddGcE_COMMERCE_CVV_DINAMICO VARCHAR (100) =  'T02VC4000MXN484';
--DECLARE @POSEM_VerificacionSbcTddGcE_COMMERCE_CVV_DINAMICO VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
--DECLARE @CodigosProceso_VerificacionSbcTddGcE_COMMERCE_CVV_DINAMICO VARCHAR (200) ='81%'

/*----------------------------------------------------MOTO--------------------------------------------------*/
-->N/E
--COMPRA MOTO JSON (E-COMMERCE CON CVV2)
--DECLARE @ID_EventoCompraMotoJSONGcE_Commerce_CVV2 VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02801600MXN484' ) --1123;
--DECLARE @EventosPertenenciaCompraMotoJSONGcE_Commerce_CVV2 VARCHAR (100) =  'T02801600MXN484';
--DECLARE @POSEM_CompraMotoJSONGcE_Commerce_CVV2 VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
--DECLARE @CodigosProceso_CompraMotoJSONGcE_Commerce_CVV2 VARCHAR (200) ='80%'

--DECLARE @ID_EventoCompraMotoJSONGcE_Commerce_CVV2_STANDIN VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02801603MXN484' ) --1123;
--DECLARE @EventosPertenenciaCompraMotoJSONGcE_Commerce_CVV2_STANDIN VARCHAR (100) =  'T02801603MXN484';
--DECLARE @POSEM_CompraMotoJSONGcE_Commerce_CVV2_STANDIN VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
--DECLARE @CodigosProceso_CompraMotoJSONGcE_Commerce_CVV2_STANDIN VARCHAR (200) ='80%'


-->N/E
--COMPRA MOTO JSON (E-COMMERCE CON CVV DINÁMICO)
DECLARE @ID_EventoCompraMotoTdcGcE_Commerce_CVV_DINAMICO  VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02804000MXN484' ) --1123;
DECLARE @EventosPertenenciaCompraMotoTdcGcE_Commerce_CVV_DINAMICO  VARCHAR (100) =  'T02804000MXN484';
DECLARE @POSEM_CompraMotoTdcGcE_Commerce_CVV_DINAMICO  VARCHAR (200) ='10_,00_,01_,02_,81_,80_'
DECLARE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV_DINAMICO  VARCHAR (200) ='80%'

-->SI
--DECLARE @ID_EventoEcommerceDinamico VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02004000MXN484' ) --1123;
--DECLARE @EventosPertenenciaEcommerceDinamico VARCHAR (100) ='T02004000MXN484'
--DECLARE @POSEM_EcommerceDinamico VARCHAR (200) ='00_,01_,02_,81_'
--DECLARE @CodigosProceso_EcommerceDinamico VARCHAR (200) ='00%'

-->SI
--Separarlo por POS Entry Mode
--DECLARE @ID_EventoDevolucion VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02201500MXN484') --1123;
--DECLARE @EventosPertenenciaDevolucion VARCHAR (100) = 'T02201500MXN484';
--DECLARE @POSEM_Devolucion VARCHAR (200) ='05_,90_,91_,07_,00_,01_,02_,81_,10_'
--DECLARE @CodigosProceso_Devolcuion VARCHAR (200) ='20%'

-->SI
--Separarlo por POS Entry Mode
--DECLARE @ID_EventoAjuste VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento='T02DA1500MXN484' ) --1123;
--DECLARE @EventosPertenenciaAjuste VARCHAR (100) = 'T02DA1500MXN484';
--DECLARE @POSEM_Ajuste VARCHAR (200) ='05_,90_,91_,07_,00_,01_,02_,81_,10_'
--DECLARE @CodigosProceso_Ajuste VARCHAR (200) ='02%'

-->SI
--Separarlo por POS Entry Mode
--DECLARE @ID_EventoVerificacionCuenta VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02VC0000MXN484' ) --1123;
--DECLARE @EventosPertenenciaVerficacionCuenta VARCHAR (100) = 'T02VC0000MXN484'
--DECLARE @POSEM_VerficacionCuenta VARCHAR (200) ='00_,01_,02_,81_,10_,05_,07_,90_,91_'
--DECLARE @CodigosProceso_VerficacionCuenta VARCHAR (200) ='81%'

-->SI
--Separarlo por POS Entry Mode
--DECLARE @ID_EventoEnvioDinero VARCHAR (50) = (Select ID_Evento from Eventos where ClaveEvento= 'T02261500MXN484' ) --1123;
--DECLARE @EventosPertenenciaEnvioDinero VARCHAR (100) =  'T02261500MXN484';
--DECLARE @POSEM_EnvioDinero VARCHAR (200) ='00_,01_,02_,81_,10_,05_,07_,90_,91_'
--DECLARE @CodigosProceso_EnvioDinero VARCHAR (200) ='26%'

SET @ID_TipoProducto = (SELECT ID_TipoProducto FROM TipoProducto WHERE ClaveTipoProducto = @ClaveTipoProducto)

/***********************************************************/
--VALIDACION DUPLICADOS DE PERTENENCIAS TIPO
/***********************************************************/

DECLARE @IdColectivaEmisor INT,
			@ClaveAfiliacion VARCHAR(20)


	DECLARE @Grupos_MA TABLE 
	(
		ID INT IDENTITY(1,1),
		IdGrupoMA INT 
	)
	
	
	DECLARE @PERTENENCIA_TIPO TABLE 
	(
		IdPertenenciaTipo INT,
		IdColectivaEmisor BIGINT,
		IdGrupoMA INT,
		IdGrupoCuenta INT,
		TipoMensaje  VARCHAR(50),
		ClaveAfiliacion VARCHAR(20),
		CodigoProceso VARCHAR(50),
		POSEM VARCHAR(5),
		EsActiva BIT,
		Descripcion VARCHAR(150),
		IdEstatusOperacion INT,
		IdEstatusPostOperacion INT,
		ClavePertenenciaTipo VARCHAR(50)  
	)
	

	SELECT	
		@IdColectivaEmisor = c.ID_Colectiva
	FROM	
		Colectivas c WITH (NOLOCK)
	WHERE	
		c.ID_TipoColectiva = 
		(
			SELECT 
				tc.ID_TipoColectiva 
			FROM 
				TipoColectiva tc WITH (NOLOCK) 
			WHERE 
				tc.ClaveTipoColectiva = 'EMI'
		)


	SELECT
		TOP 1 @ClaveAfiliacion = _vi.Formula
	FROM		
		ValoresISO8583 _vi WITH (NOLOCK)
		INNER JOIN PlugIns _pi WITH (NOLOCK)
			ON _vi.ID_PlugIn = _pi.ID_Plugin
	WHERE
		_vi.Nombre = '@afiliacion'

		
		--/////PERTENENCIAS
						--Obtención de Pertenencias Tipo
						INSERT INTO 
							@PERTENENCIA_TIPO
						SELECT		
							pt.ID_PertenenciaTipo,
							@IdColectivaEmisor,
							pgma.ID_GrupoMA,
							p.ID_GrupoCuenta,
							tm.ClaveTipoMensaje,
							@ClaveAfiliacion,
							cp.CodigoProceso,
							pem.Clave,
							1,
							pt.Descripcion,
							pt.ID_EstatusOperacion,
							pt.ID_EstatusPostOperacion,
							ISNULL(pt.Clave, '')
						FROM		
							TipoProductoPertenenciaTipo tppt WITH (NOLOCK)
							INNER JOIN Producto p WITH (NOLOCK)
								ON tppt.ID_TipoProducto = p.ID_TipoProducto
							INNER JOIN ProductoGrupoMA pgma WITH (NOLOCK)
								ON p.ID_Producto = pgma.ID_Producto
							INNER JOIN PertenenciaTipo pt WITH (NOLOCK)
								ON tppt.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
							INNER JOIN TipoProducto tp WITH (NOLOCK)
								ON pt.ClaveTipoProducto = tp.ClaveTipoProducto
							INNER JOIN CodigoProceso cp WITH (NOLOCK)
								ON pt.ID_CodigoProceso = cp.ID_CodigoProceso
							INNER JOIN TipoMensajes tm WITH (NOLOCK)
								ON cp.ID_TipoMensaje = tm.ID_TipoMensaje
							LEFT JOIN POSEntryMode pem WITH (NOLOCK)
								ON pt.ID_POSEntryMode = pem.ID_POSEntryMode
						WHERE
							tppt.ID_TipoProducto = @ID_TipoProducto
							--AND p.ID_Producto = @IdNuevoProducto
		
		--SELECT 
		--						ClaveAfiliacion, 
		--						CodigoProceso, 
		--						IdColectivaEmisor, 
		--						IdGrupoCuenta, 
		--						IdGrupoMA, 
		--						POSEM, 
		--						TipoMensaje, 
		--						IdEstatusOperacion, 
		--						IdEstatusPostOperacion, 
		--						COUNT(*)
		--					FROM 
		--						@PERTENENCIA_TIPO
		--					GROUP BY 
		--						ClaveAfiliacion, 
		--						CodigoProceso, 
		--						IdColectivaEmisor, 
		--						IdGrupoCuenta, 
		--						IdGrupoMA,
		--						POSEM, 
		--						TipoMensaje, 
		--						IdEstatusOperacion, 
		--						IdEstatusPostOperacion
		--					HAVING 
		--						COUNT(*) > 1 

 --/***********************************************************/
----ELIMINACIÓN DE PERTENENCIAS TIPO Y PERTENENCIAS TIPO EVENTO ANTERIORES
--/***********************************************************/

DELETE FROM TipoProductoPertenenciaTipo
--SELECT * FROM TipoProductoPertenenciaTipo
WHERE ID_PertenenciaTipo IN (
	SELECT ID_PertenenciaTipo FROM PertenenciaTipo
	WHERE ClaveTipoProducto = @ClaveTipoProducto
	--AND (--Clave LIKE 'P0%' OR
	--ID_CodigoProceso IN(
	--SELECT ID_CodigoProceso FROM CodigoProceso WHERE CodigoProceso LIKE @CodigosProceso_POS OR 
	--																CodigoProceso LIKE @CodigosProceso_ATMCHIP OR
	--																CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCHIP OR
	--																CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCHIP OR
	--																CodigoProceso LIKE @CodigosProceso_FastFundSbcTddGcCHIP OR
	--																--CodigoProceso LIKE @CodigosProceso_EnvioDineroMS OR
	--																CodigoProceso LIKE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV2 OR
	--																--CodigoProceso LIKE @CodigosProceso_CashAdvance OR
	--																--CodigoProceso LIKE @CodigosProceso_CashAdvance14 OR
	--																--CodigoProceso LIKE @CodigosProceso_CashBack OR
	--																CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCHIP OR
	--																CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCHIP 												
	--														AND ID_TipoMensaje IN (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje IN (@ClaveTipoMensajeOnline, @ClaveTipoMensajeStandin))
	--														)
	--)
	AND Clave NOT LIKE 'P%'
)

DELETE FROM PertenenciaTipoEvento
--SELECT * FROM PertenenciaTipoEvento
WHERE ID_PertenenciaTipo IN (
	SELECT ID_PertenenciaTipo FROM PertenenciaTipo
	WHERE ClaveTipoProducto = @ClaveTipoProducto
--	AND (--Clave LIKE 'P0%'
--	ID_CodigoProceso IN(
--	SELECT ID_CodigoProceso FROM CodigoProceso WHERE CodigoProceso LIKE @CodigosProceso_POS OR 
--															CodigoProceso LIKE @CodigosProceso_ATMCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_FastFundSbcTddGcCHIP OR
--																	--CodigoProceso LIKE @CodigosProceso_EnvioDineroMS OR
--																	CodigoProceso LIKE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV2 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance14 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashBack OR
--																	CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCHIP 													
--															AND ID_TipoMensaje IN (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje IN (@ClaveTipoMensajeOnline, @ClaveTipoMensajeStandin))
--	)
--)
AND Clave NOT LIKE 'P%'
)


DELETE FROM PertenenciaTipo
--SELECT * FROM PertenenciaTipo
WHERE ClaveTipoProducto = @ClaveTipoProducto
--AND (--Clave LIKE 'P0%'
--	ID_CodigoProceso IN(
--	SELECT ID_CodigoProceso FROM CodigoProceso WHERE CodigoProceso LIKE @CodigosProceso_POS OR 
--																	CodigoProceso LIKE @CodigosProceso_ATMCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_FastFundSbcTddGcCHIP OR
--																	--CodigoProceso LIKE @CodigosProceso_EnvioDineroMS OR
--																	CodigoProceso LIKE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV2 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance OR
--																	--CodigoProceso LIKE @CodigosProceso_CashAdvance14 OR
--																	--CodigoProceso LIKE @CodigosProceso_CashBack OR
--																	CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCHIP OR
--																	CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCHIP
--														AND ID_TipoMensaje IN (SELECT ID_TipoMensaje FROM TipoMensajes WHERE ClaveTipoMensaje IN (@ClaveTipoMensajeOnline, @ClaveTipoMensajeStandin))
																	
--	)
--)
AND Clave NOT LIKE 'P%'


----PERTENENCIAS TIPO DUPLICADAS
--SELECT 'PERTENENCIAS TIPO DUPLICADAS', cp.CodigoProceso, pt.ID_CodigoProceso, pem.Clave, pt.ID_POSEntryMode, tm.ClaveTipoMensaje, pt.ID_EstatusOperacion, pt.ID_EstatusPostOperacion, COUNT(*)
--FROM TipoProductoPertenenciaTipo tppt
--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = tppt.ID_PertenenciaTipo
--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_PertenenciaTipo =  pt.ID_PertenenciaTipo
--INNER JOIN Eventos ev ON ev.ID_Evento = pte.ID_Evento
--LEFT JOIN CodigoProceso cp ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
--LEFT JOIN POSEntryMode pem ON pem.ID_POSEntryMode = pt.ID_POSEntryMode
--LEFT JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje
--WHERE ClaveTipoProducto = @ClaveTipoProducto
--GROUP BY cp.CodigoProceso, pt.ID_CodigoProceso, pem.Clave, pt.ID_POSEntryMode,tm.ClaveTipoMensaje, pt.ID_EstatusOperacion, pt.ID_EstatusPostOperacion
--HAVING COUNT(*) > 1 

  
--PRINT('PERTENENCIAS TIPO CON MAS DE UN EVENTOS')
--SELECT 'PERTENENCIAS TIPO CON MAS DE UN EVENTOS', * 
--FROM dbo.PertenenciaTipo 
--WHERE ID_PertenenciaTipo IN (
--	SELECT PertenenciaTipo.ID_PertenenciaTipo 
--	FROM dbo.PertenenciaTipoEvento 
--	INNER JOIN dbo.PertenenciaTipo ON PertenenciaTipo.ID_PertenenciaTipo = PertenenciaTipoEvento.ID_PertenenciaTipo 
--	WHERE ClaveTipoProducto=@ClaveTipoProducto
--	GROUP BY PertenenciaTipo.ID_PertenenciaTipo HAVING COUNT(*)>1 
--)

--PRINT('EVENTOS LIGADOS A LAS PERTENENCIAS TIPO CON MAS DE UN EVENTOS')
--SELECT 'EVENTOS LIGADOS A LAS PERTENENCIAS TIPO CON MAS DE UN EVENTOS', * 
--FROM dbo.PertenenciaTipoEvento pte
--INNER JOIN Eventos ev ON pte.ID_Evento = ev.ID_Evento
--WHERE ID_PertenenciaTipo IN  (
--	SELECT PertenenciaTipo.ID_PertenenciaTipo 
--	FROM dbo.PertenenciaTipoEvento 
--	INNER JOIN dbo.PertenenciaTipo ON PertenenciaTipo.ID_PertenenciaTipo = PertenenciaTipoEvento.ID_PertenenciaTipo 
--	WHERE ClaveTipoProducto=@ClaveTipoProducto
--	GROUP BY PertenenciaTipo.ID_PertenenciaTipo HAVING COUNT(*)>1 
--)

/***********************************************************/
--INSERTAR PERTENECIAS TIPO TRANSACCIONALES
/***********************************************************/

/**POS ONLINE*/

PRINT ('POS ONLINE CHIP')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoPOSCHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_POSCHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_POS
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoPOSCHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoPOSCHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoPOSCHIP)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaPOSCHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoPOSCHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto ) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('POS ONLINE CHIP STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoPOSCHIP_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_POSCHIP_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_POSCHIP_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoPOSCHIP_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoPOSCHIP_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoPOSCHIP_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaPOSCHIP_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoPOSCHIP_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto ) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('POS ONLINE BANDA')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoPOSBANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_POSBANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_POS
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoPOSBANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoPOSBANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoPOSBANDA)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaBANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoPOSBANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('POS ONLINE BANDA STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoPOSBANDA_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_POSBANDA_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_POSBANDA_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoPOSBANDA_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoPOSBANDA_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoPOSBANDA_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaPOSBANDA_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoPOSBANDA_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('POS ONLINE CONTACTLESS')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoPOSCL AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_POSCL, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_POSCL
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoPOSCL) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoPOSCL
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoPOSCL)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaPOSCL, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoPOSCL
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('POS ONLINE CONTACTLESS STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoPOSCL_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_POSCL_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_POSCL_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoPOSCL_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoPOSCL_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoPOSCL_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaPOSCL_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoPOSCL_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END
-----------------------------------------COMPRA CON CASHADVANCE----------------------------------------------------------------
PRINT ('COMPRA CASHADVANCE JSON (CHIP)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHADVANCE_JSON_CHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHADVANCE_JSON_CHIP
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHADVANCE_JSON_CHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto ) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('COMPRA CASHADVANCE JSON STANDIN (CHIP)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHADVANCE_JSON_CHIP_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHADVANCE_JSON_CHIP_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHADVANCE_JSON_CHIP_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_CHIP_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto ) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('COMPRA CASHADVANCE JSON (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHADVANCE_JSON_BANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHADVANCE_JSON_BANDA
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHADVANCE_JSON_BANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('COMPRA JSON STANDIN (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHADVANCE_JSON_BANDA_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHADVANCE_JSON_BANDA_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHADVANCE_JSON_BANDA_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_BANDA_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('COMPRA CASHADVANCE JSON (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHADVANCE_JSON_CONTACTLESS, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHADVANCE_JSON_CONTACTLESS
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHADVANCE_JSON_CONTACTLESS, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('COMPRA CASHADVANCE JSON STANDIN (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_CONTACTLESS_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

/**COMPRA CASHADVANCE JSON (E-COMMERCE CON CVV DINÁMICO)*/
PRINT ('COMPRA CASHADVANCE JSON (E-COMMERCE CON CVV DINÁMICO)')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
				FROM
					    (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento =  @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO)





  --  ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

/**COMPRA CASHADVANCE JSON STANDIN (E-COMMERCE CON CVV DINÁMICO)*/
PRINT ('COMPRA CASHADVANCE JSON STANDIN (E-COMMERCE CON CVV DINÁMICO)')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
				FROM
					    (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento =  @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN)





  --  ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHADVANCE_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END


END
-------------------------------------------------------------------------------------------------------------------------------

--------------------------------------- COMPRA CON CASHBACK--------------------------------------------------------------------
PRINT ('COMPRA CASHBACK JSON (CHIP)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHBACK_JSON_CHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHBACK_JSON_CHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHBACK_JSON_CHIP
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_CHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHBACK_JSON_CHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHBACK_JSON_CHIP)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHBACK_JSON_CHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_CHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto ) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('COMPRA CASHBACK JSON STANDIN (CHIP)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHBACK_JSON_CHIP_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHBACK_JSON_CHIP_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHBACK_JSON_CHIP_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_CHIP_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHBACK_JSON_CHIP_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHBACK_JSON_CHIP_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHBACK_JSON_CHIP_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_CHIP_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto ) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('COMPRA CASHBACK JSON (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHBACK_JSON_BANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHBACK_JSON_BANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHBACK_JSON_BANDA
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_BANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHBACK_JSON_BANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHBACK_JSON_BANDA)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHBACK_JSON_BANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_BANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('COMPRA JSON STANDIN (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHBACK_JSON_BANDA_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHBACK_JSON_BANDA_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHBACK_JSON_BANDA_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_BANDA_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHBACK_JSON_BANDA_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHBACK_JSON_BANDA_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHBACK_JSON_BANDA_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_BANDA_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('COMPRA CASHBACK JSON (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHBACK_JSON_CONTACTLESS, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHBACK_JSON_CONTACTLESS
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHBACK_JSON_CONTACTLESS, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('COMPRA CASHBACK JSON STANDIN (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_CONTACTLESS_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

/**ECOMMERCE ONLINE DINÁMICO*/
PRINT ('ECOMMERCE ONLINE DINÁMICO')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
				FROM
					    (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento =  @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO)





  --  ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

/**ECOMMERCE ONLINE DINÁMICO STANDIN*/
PRINT ('ECOMMERCE ONLINE DINÁMICO STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
				FROM
					    (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_COMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_COMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento =  @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN)





  --  ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCOMRPA_CASHBACK_JSON_ECOMMERCE_CVV_DINAMICO_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END


END
-------------------------------------------------------------------------------------------------------------------------------

/**ATM ONLINE*/
PRINT ('ATM ONLINE CHIP')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
               SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoATMCHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
                  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ATMCHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      (CodigoProceso.CodigoProceso LIKE @CodigosProceso_ATMCHIP OR CodigoProceso.CodigoProceso LIKE @CodigosProceso_ATMCHIP90)
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoATMCHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoATMCHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoATMCHIP)

				
				
			

    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaATMCHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoATMCHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN
/**ATM ONLINE STANDIN*/
PRINT ('ATM ONLINE CHIP STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
               SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoATMCHIP_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
                  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ATMCHIP_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso IN (@CodigosProceso_ATMCHIP_STANDIN, @CodigosProceso_ATMCHIP90)
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoATMCHIP_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoATMCHIP_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoATMCHIP_STANDIN)

				
				
			

    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaATMCHIP_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoATMCHIP_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('ATM ONLINE CONTACTLESS')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoATMCL AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
                  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ATMCL, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_ATMCL
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoATMCL) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoATMCL
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoATMCL)

				
				
			

    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaATMCL, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoATMCL
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('ATM ONLINE CONTACTLESS STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoATMCL_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
                  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ATMCL_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_ATMCL_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoATMCL_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoATMCL_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoATMCL_STANDIN)

				
				
			

    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaATMCL_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoATMCL_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('ATM ONLINE BANDA')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoATMBANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
                  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ATMBANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_ATMBANDA
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoATMBANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoATMBANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoATMBANDA)

				
				
			

    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaATMBANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoATMBANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('ATM ONLINE BANDA STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoATMBANDA_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
                  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ATMBANDA_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_ATMBANDA_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoATMBANDA_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoATMBANDA_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoATMBANDA_STANDIN)

				
				
			

    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaATMBANDA_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoATMBANDA_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('ATM TECLEADO CON CVV2')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoATMECOM AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
                  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ATMECOM, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_ATMECOM
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoATMECOM) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoATMECOM
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoATMECOM)

				
				
			

    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaATMECOM, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoATMECOM
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN
PRINT ('ATM TECLEADO CON CVV2 STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoATMECOM_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
                  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ATMECOM_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_ATMECOM_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoATMECOM_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoATMECOM_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoATMECOM_STANDIN)

				
				
			

    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaATMECOM_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoATMECOM_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

/**ConsultaSaldo ONLINE*/
PRINT ('COSULTA SALDO CHIP')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoConsultaSaldoCHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
					    FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ConsultaSaldoCHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      (CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCHIP OR CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldo30)
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento =  @ID_EventoConsultaSaldoCHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoConsultaSaldoCHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoConsultaSaldoCHIP)




    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaConsultaSaldoCHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
						  dbo.PertenenciaTipo 					
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoConsultaSaldoCHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto ) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN


/**ConsultaSaldo ONLINE STANDIN*/
PRINT ('COSULTA SALDO CHIP STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoConsultaSaldoCHIP_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
					    FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ConsultaSaldoCHIP_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE  (CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCHIP_STANDIN OR CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldo30) 
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento =  @ID_EventoConsultaSaldoCHIP_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoConsultaSaldoCHIP_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoConsultaSaldoCHIP_STANDIN)




    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaConsultaSaldoCHIP_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
						  dbo.PertenenciaTipo 					
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoConsultaSaldoCHIP_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto ) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

/**ConsultaSaldo ONLINE*/
PRINT ('COSULTA SALDO BANDA')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoConsultaSaldoBANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
					    FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ConsultaSaldoBANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE (CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldoBANDA OR CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldo30)     
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento =  @ID_EventoConsultaSaldoBANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoConsultaSaldoBANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoConsultaSaldoBANDA)




    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaConsultaSaldoBANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
						  dbo.PertenenciaTipo 					
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoConsultaSaldoBANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)
 
END

IF(@AplicaStandIn = 1)
BEGIN

/**ConsultaSaldo ONLINE STANDIN*/
PRINT ('COSULTA SALDO BANDA STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoConsultaSaldoBANDA_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
					    FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ConsultaSaldoBANDA_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      (CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldoBANDA_STANDIN OR CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldo30)
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento =  @ID_EventoConsultaSaldoBANDA_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoConsultaSaldoBANDA_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoConsultaSaldoBANDA_STANDIN)




    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaConsultaSaldoBANDA_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
						  dbo.PertenenciaTipo 					
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoConsultaSaldoBANDA_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)
 
END
END

/**ConsultaSaldo ONLINE*/
PRINT ('COSULTA SALDO CONTACT LESS')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoConsultaSaldoCl AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
					    FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ConsultaSaldoCL, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE (CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCL OR CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldo30)
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento =  @ID_EventoConsultaSaldoCl) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoConsultaSaldoCl
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoConsultaSaldoCl)




    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaConsultaSaldoCL, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
						  dbo.PertenenciaTipo 					
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoConsultaSaldoCL
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)
 
END

IF(@AplicaStandIn = 1)
BEGIN

/**ConsultaSaldo STANDIN*/
PRINT ('COSULTA SALDO CONTACT LESS STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoConsultaSaldoCL_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
					    FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_ConsultaSaldoCL_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      (CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldoCL_STANDIN OR CodigoProceso.CodigoProceso LIKE @CodigosProceso_ConsultaSaldo30)
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento =  @ID_EventoConsultaSaldoCL_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoConsultaSaldoCL_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoConsultaSaldoCL_STANDIN)




    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaConsultaSaldoCL_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
						  dbo.PertenenciaTipo 					
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoConsultaSaldoCL_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)
 
END
END

/**ECOMMERCE ONLINE DINÁMICO*/
PRINT ('ECOMMERCE ONLINE DINÁMICO')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoEcommerceDinamico AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
				FROM
					    (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_EcommerceDinamico, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_EcommerceDinamico
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento =  @ID_EventoEcommerceDinamico) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoEcommerceDinamico
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoEcommerceDinamico)





  --  ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaEcommerceDinamico, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoEcommerceDinamico
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

/**ECOMMERCE ONLINE DINÁMICO STANDIN*/
PRINT ('ECOMMERCE ONLINE DINÁMICO STANDIN')
BEGIN

    INSERT INTO dbo.PertenenciaTipo
        ( ID_CodigoProceso,
          ID_EstatusPostOperacion,
          ID_EstatusOperacion,
          ID_POSEntryMode,
          Clave,
          Descripcion,
          ClaveTipoProducto )
                SELECT PerTip.* FROM 
				(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoEcommerceDinamico_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
				FROM
					    (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_EcommerceDinamico_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_EcommerceDinamico_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento =  @ID_EventoEcommerceDinamico_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoEcommerceDinamico_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoEcommerceDinamico_STANDIN)





  --  ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS



    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaEcommerceDinamico_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoEcommerceDinamico_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END


END


PRINT ('COMPRA JSON (FALLBACK)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCompraTddGcFALLBACK AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CompraTddGcFALLBACK, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_POS
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCompraTddGcFALLBACK) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCompraTddGcFALLBACK
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCompraTddGcFALLBACK)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCompraTddGcFALLBACK, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCompraTddGcFALLBACK
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF (@AplicaStandIn=1)
BEGIN
PRINT ('COMPRA JSON (FALLBACK) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCompraTddGcFALLBACK_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CompraTddGcFALLBACK_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CompraTddGcFALLBACK_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCompraTddGcFALLBACK_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCompraTddGcFALLBACK_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCompraTddGcFALLBACK_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCompraTddGcFALLBACK_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCompraTddGcFALLBACK_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('DEVOLUCIÓN SBC JSON (CHIP)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoDevolucionSbcTddGcCHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_DevolucionSbcTddGcCHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCHIP
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoDevolucionSbcTddGcCHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoDevolucionSbcTddGcCHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoDevolucionSbcTddGcCHIP)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaDevolucionSbcTddGcCHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoDevolucionSbcTddGcCHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('DEVOLUCIÓN SBC JSON (CHIP) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoDevolucionSbcTddGcCHIP_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_DevolucionSbcTddGcCHIP_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCHIP_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoDevolucionSbcTddGcCHIP_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoDevolucionSbcTddGcCHIP_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoDevolucionSbcTddGcCHIP_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaDevolucionSbcTddGcCHIP_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoDevolucionSbcTddGcCHIP_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('DEVOLUCIÓN SBC JSON (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoDevolucionSbcTddGcBANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_DevolucionSbcTddGcBANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcBANDA
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoDevolucionSbcTddGcBANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoDevolucionSbcTddGcBANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoDevolucionSbcTddGcBANDA)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaDevolucionSbcTddGcBANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoDevolucionSbcTddGcBANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('DEVOLUCIÓN SBC JSON (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoDevolucionSbcTddGcBANDA_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_DevolucionSbcTddGcBANDA_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcBANDA_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoDevolucionSbcTddGcBANDA_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoDevolucionSbcTddGcBANDA_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoDevolucionSbcTddGcBANDA_STANDIN*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaDevolucionSbcTddGcBANDA_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoDevolucionSbcTddGcBANDA_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('DEVOLUCIÓN SBC JSON (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_DevolucionSbcTddGcCONTACTLESS_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCONTACTLESS_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaDevolucionSbcTddGcCONTACTLESS_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF (@AplicaStandIn = 1)
BEGIN

PRINT ('DEVOLUCIÓN SBC JSON (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_DevolucionSbcTddGcCONTACTLESS_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcCONTACTLESS_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaDevolucionSbcTddGcCONTACTLESS_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoDevolucionSbcTddGcCONTACTLESS_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('CANCELACIÓN SBC JSON (CHIP)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCancelacionSbcTddGcCHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CancelacionSbcTddGcCHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCHIP
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCancelacionSbcTddGcCHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCancelacionSbcTddGcCHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCancelacionSbcTddGcCHIP)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCancelacionSbcTddGcCHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCancelacionSbcTddGcCHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('CANCELACIÓN SBC JSON (CHIP) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCancelacionSbcTddGcCHIP_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CancelacionSbcTddGcCHIP_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCHIP_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCancelacionSbcTddGcCHIP_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCancelacionSbcTddGcCHIP_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCancelacionSbcTddGcCHIP_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCancelacionSbcTddGcCHIP_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCancelacionSbcTddGcCHIP_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('CANCELACIÓN SBC JSON (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCancelacionSbcTddGcBANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CancelacionSbcTddGcBANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcBANDA
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCancelacionSbcTddGcBANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCancelacionSbcTddGcBANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCancelacionSbcTddGcBANDA)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCancelacionSbcTddGcBANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCancelacionSbcTddGcBANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('CANCELACIÓN SBC JSON (BANDA) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCancelacionSbcTddGcBANDA_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CancelacionSbcTddGcBANDA_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcBANDA_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCancelacionSbcTddGcBANDA_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCancelacionSbcTddGcBANDA_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCancelacionSbcTddGcBANDA_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCancelacionSbcTddGcBANDA_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCancelacionSbcTddGcBANDA_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('CANCELACIÓN SBC JSON (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCancelacionSbcTddGcCONTACTLESS AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CancelacionSbcTddGcCONTACTLESS, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCONTACTLESS
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCancelacionSbcTddGcCONTACTLESS) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCancelacionSbcTddGcCONTACTLESS
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCancelacionSbcTddGcCONTACTLESS)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCancelacionSbcTddGcCONTACTLESS, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCancelacionSbcTddGcCONTACTLESS
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandin = 1)
BEGIN 

PRINT ('CANCELACIÓN SBC JSON (CONTACTLESS) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCancelacionSbcTddGcCONTACTLESS_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CancelacionSbcTddGcCONTACTLESS_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcCONTACTLESS_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCancelacionSbcTddGcCONTACTLESS_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCancelacionSbcTddGcCONTACTLESS_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCancelacionSbcTddGcCONTACTLESS_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCancelacionSbcTddGcCONTACTLESS_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCancelacionSbcTddGcCONTACTLESS_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('MONEY SEND SBC JSON (CHIP)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoMoneySendSbcTddGcCHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_MoneySendSbcTddGcCHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_MoneySendSbcTddGcCHIP
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoMoneySendSbcTddGcCHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoMoneySendSbcTddGcCHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoMoneySendSbcTddGcCHIP)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaMoneySendSbcTddGcCHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoMoneySendSbcTddGcCHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

PRINT ('MONEY SEND SBC JSON (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoMoneySendSbcTddGcBANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_MoneySendSbcTddGcBANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_MoneySendSbcTddGcBANDA
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoMoneySendSbcTddGcBANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoMoneySendSbcTddGcBANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoMoneySendSbcTddGcBANDA)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaMoneySendSbcTddGcBANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoMoneySendSbcTddGcBANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

PRINT ('MONEY SEND SBC JSON (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoMoneySendSbcTddGcCONTACTLESS AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_MoneySendSbcTddGcCONTACTLESS, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_MoneySendSbcTddGcCONTACTLESS
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoMoneySendSbcTddGcCONTACTLESS) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoMoneySendSbcTddGcCONTACTLESS
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoMoneySendSbcTddGcCONTACTLESS)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaMoneySendSbcTddGcCONTACTLESS, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoMoneySendSbcTddGcCONTACTLESS
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

PRINT ('DEVOLUCIÓN SBC JSON (E-COMMERCE CON CVV2)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2 AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_DevolucionSbcTddGcE_COMMERCE_CVV2, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcE_COMMERCE_CVV2
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaDevolucionSbcTddGcE_COMMERCE_CVV2, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('DEVOLUCIÓN SBC JSON (E-COMMERCE CON CVV2) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_DevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_DevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaDevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoDevolucionSbcTddGcE_COMMERCE_CVV2_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('CANCELACIÓN SBC JSON (E-COMMERCE CON CVV2)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2 AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CancelacionSbcTddGcE_COMMERCE_CVV2, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcE_COMMERCE_CVV2
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCancelacionSbcTddGcE_COMMERCE_CVV2, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandIn = 1)
BEGIN

PRINT ('CANCELACIÓN SBC JSON (E-COMMERCE CON CVV2) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCancelacionSbcTddGcE_COMMERCE_CVV2_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('MONEY SEND SBC JSON (E-COMMERCE CON CVV2)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoMoneySendSbcTddGcE_COMMERCE_CVV2 AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_MoneySendSbcTddGcE_COMMERCE_CVV2, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_MoneySendSbcTddGcE_COMMERCE_CVV2
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoMoneySendSbcTddGcE_COMMERCE_CVV2) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoMoneySendSbcTddGcE_COMMERCE_CVV2
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoMoneySendSbcTddGcE_COMMERCE_CVV2)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaMoneySendSbcTddGcE_COMMERCE_CVV2, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoMoneySendSbcTddGcE_COMMERCE_CVV2
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

PRINT ('RETIRO EN ATM JSON (FALLBACK)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoRetiroAtmTddGc_FALLBACK AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_RetiroAtmTddGc_FALLBACK, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_RetiroAtmTddGc_FALLBACK
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoRetiroAtmTddGc_FALLBACK) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoRetiroAtmTddGc_FALLBACK
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoRetiroAtmTddGc_FALLBACK)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaRetiroAtmTddGc_FALLBACK, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoRetiroAtmTddGc_FALLBACK
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandin = 1)
BEGIN

PRINT ('RETIRO EN ATM JSON (FALLBACK) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoRetiroAtmTddGc_FALLBACK_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_RetiroAtmTddGc_FALLBACK_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_RetiroAtmTddGc_FALLBACK_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoRetiroAtmTddGc_FALLBACK_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoRetiroAtmTddGc_FALLBACK_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoRetiroAtmTddGc_FALLBACK_STANDIN)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaRetiroAtmTddGc_FALLBACK_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoRetiroAtmTddGc_FALLBACK_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('VERIFICACIÓN DE CUENTA JSON (CHIP)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoVerificacionSbcTddGcCHIP AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_VerificacionSbcTddGcCHIP, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCHIP
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoVerificacionSbcTddGcCHIP) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoVerificacionSbcTddGcCHIP
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoVerificacionSbcTddGcCHIP*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaVerificacionSbcTddGcCHIP, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoVerificacionSbcTddGcCHIP
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandin = 1)
BEGIN

PRINT ('VERIFICACIÓN DE CUENTA JSON (CHIP) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoVerificacionSbcTddGcCHIP_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_VerificacionSbcTddGcCHIP_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCHIP_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoVerificacionSbcTddGcCHIP_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoVerificacionSbcTddGcCHIP_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoVerificacionSbcTddGcCHIP_STANDIN*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaVerificacionSbcTddGcCHIP_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoVerificacionSbcTddGcCHIP_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('VERIFICACIÓN DE CUENTA JSON (BANDA)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoVerificacionSbcTddGcBANDA AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_VerificacionSbcTddGcBANDA, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcBANDA
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoVerificacionSbcTddGcBANDA) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoVerificacionSbcTddGcBANDA
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoVerificacionSbcTddGcBANDA*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaVerificacionSbcTddGcBANDA, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoVerificacionSbcTddGcBANDA
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandin = 1)
BEGIN

PRINT ('VERIFICACIÓN DE CUENTA JSON (BANDA) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoVerificacionSbcTddGcBANDA_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_VerificacionSbcTddGcBANDA_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcBANDA_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoVerificacionSbcTddGcBANDA_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoVerificacionSbcTddGcBANDA_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoVerificacionSbcTddGcBANDA_STANDIN*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaVerificacionSbcTddGcBANDA_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoVerificacionSbcTddGcBANDA_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

END

PRINT ('VERIFICACIÓN DE CUENTA JSON (CONTACTLESS)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoVerificacionSbcTddGcCONTACTLESS AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_VerificacionSbcTddGcCONTACTLESS, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCONTACTLESS
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoVerificacionSbcTddGcCONTACTLESS) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoVerificacionSbcTddGcCONTACTLESS
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoVerificacionSbcTddGcCONTACTLESS*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaVerificacionSbcTddGcCONTACTLESS, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoVerificacionSbcTddGcCONTACTLESS
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandin = 1)
BEGIN

PRINT ('VERIFICACIÓN DE CUENTA JSON (CONTACTLESS) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoVerificacionSbcTddGcCONTACTLESS_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_VerificacionSbcTddGcCONTACTLESS_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcCONTACTLESS_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoVerificacionSbcTddGcCONTACTLESS_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoVerificacionSbcTddGcCONTACTLESS_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoVerificacionSbcTddGcCONTACTLESS_STANDIN*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaVerificacionSbcTddGcCONTACTLESS_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoVerificacionSbcTddGcCONTACTLESS_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('VERIFICACIÓN DE CUENTA JSON (ECOMMERCE CON CVV2)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2 AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_VerificacionSbcTddGcE_COMMERCE_CVV2, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcE_COMMERCE_CVV2
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaVerificacionSbcTddGcE_COMMERCE_CVV2, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

IF(@AplicaStandin = 1)
BEGIN

PRINT ('VERIFICACIÓN DE CUENTA JSON (ECOMMERCE CON CVV2) STANDIN')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_VerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_VerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeStandin
			   AND ID_Evento = @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode --AND pt.Clave = @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode /*AND Clave = @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN*/)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaVerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoVerificacionSbcTddGcE_COMMERCE_CVV2_STANDIN
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END
END

PRINT ('COMPRA MOTO JSON (E-COMMERCE CON CVV DINÁMICO)')
BEGIN

			INSERT INTO dbo.PertenenciaTipo (ID_CodigoProceso,
											 ID_EstatusPostOperacion,
											 ID_EstatusOperacion,
											 ID_POSEntryMode,
											 Clave,
											 Descripcion,
											 ClaveTipoProducto)
			SELECT PerTip.* FROM 
			(SELECT     CodigoProceso.ID_CodigoProceso,
						NULL AS ID_EstatusPostOperacion,
						NULL AS ID_EstatusOperacion,
						POSEntryMode.ID_POSEntryMode,
						@ID_EventoCompraMotoTdcGcE_Commerce_CVV_DINAMICO AS Clave,
						Eventos.Descripcion,
						@ClaveTipoProducto AS ClaveTipoProducto
			  FROM      (   SELECT PosEM.value AS clavePOSEM
							  FROM STRING_SPLIT(@POSEM_CompraMotoTdcGcE_Commerce_CVV_DINAMICO, ',') PosEM) AS POSEM_Codigo
			 INNER JOIN dbo.POSEntryMode
				ON POSEntryMode.Clave          = POSEM_Codigo.clavePOSEM,
						dbo.CodigoProceso
			 INNER      JOIN dbo.TipoMensajes
				ON TipoMensajes.ID_TipoMensaje = CodigoProceso.ID_TipoMensaje,
						dbo.Eventos
			 WHERE      CodigoProceso.CodigoProceso LIKE @CodigosProceso_CompraMotoTdcGcE_Commerce_CVV_DINAMICO
			   AND      dbo.TipoMensajes.ClaveTipoMensaje = @ClaveTipoMensajeOnline
			   AND ID_Evento = @ID_EventoCompraMotoTdcGcE_Commerce_CVV_DINAMICO) AS PerTip
			 LEFT JOIN PertenenciaTipo pt ON pt.ClaveTipoProducto = @ClaveTipoProducto AND pt.ID_CodigoProceso = PerTip.ID_CodigoProceso AND pt.ID_POSEntryMode = PerTip.ID_POSEntryMode AND pt.Clave = @ID_EventoCompraMotoTdcGcE_Commerce_CVV_DINAMICO
			 WHERE pt.ID_PertenenciaTipo NOT IN (SELECT ID_PertenenciaTipo FROM PertenenciaTipo WHERE ClaveTipoProducto = @ClaveTipoProducto AND ID_CodigoProceso = PerTip.ID_CodigoProceso AND ID_POSEntryMode = PerTip.ID_POSEntryMode AND Clave = @ID_EventoCompraMotoTdcGcE_Commerce_CVV_DINAMICO)


    --ASIGNACION DE EVENTO A LAS PERTENCIAS TIPO POS


    --SELECT @EventosPertenenciaPOS,
    --       @ClaveTipoProducto,
    --       @ID_EventoPOS
    INSERT INTO dbo.PertenenciaTipoEvento
        ( ID_PertenenciaTipo,
          ID_Evento,
          Activo )
                SELECT PerTipEv.* FROM (
                SELECT  ID_PertenenciaTipo,
                       miEvento.ID_Evento,
                       1 AS Activo
                FROM (
                         SELECT value AS claveEvento
                         FROM STRING_SPLIT(@EventosPertenenciaCompraMotoTdcGcE_Commerce_CVV_DINAMICO, ',')
                     )                      EventosToAsignar
                     INNER JOIN dbo.Eventos miEvento
                         ON miEvento.ClaveEvento = EventosToAsignar.claveEvento,
                     dbo.PertenenciaTipo
                WHERE PertenenciaTipo.Clave IN
                      (
                          SELECT CONVERT(VARCHAR (20), ID_Evento)
                          FROM dbo.Eventos
                          WHERE ID_Evento = @ID_EventoCompraMotoTdcGcE_Commerce_CVV_DINAMICO
                      )
                      AND ClaveTipoProducto = @ClaveTipoProducto) AS PerTipEv
					 LEFT JOIN PertenenciaTipoEvento pte ON pte.ID_Evento =  PerTipEv.ID_Evento AND pte.ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo
					 WHERE pte.ID_PertenenciaTipoEvento NOT IN (SELECT ID_PertenenciaTipoEvento FROM PertenenciaTipoEvento WHERE ID_Evento =  PerTipEv.ID_Evento AND ID_PertenenciaTipo = PerTipEv.ID_PertenenciaTipo)

END

--INSERTA LAS PERTENENCIAS TIPO A EL PRODUCTO TIPO 

INSERT dbo.TipoProductoPertenenciaTipo
    ( ID_TipoProducto,
      ID_PertenenciaTipo,
      Activa )
       SELECT TipoProducto.ID_TipoProducto,
              PertenenciaTipo.ID_PertenenciaTipo,
              1
       FROM dbo.PertenenciaTipo
            INNER JOIN dbo.TipoProducto
                ON PertenenciaTipo.ClaveTipoProducto = TipoProducto.ClaveTipoProducto
			LEFT JOIN TipoProductoPertenenciaTipo tppt ON tppt.ID_TipoProducto = TipoProducto.ID_TipoProducto AND tppt.ID_PertenenciaTipo = PertenenciaTipo.ID_PertenenciaTipo
			WHERE TipoProducto.clavetipoproducto=@ClaveTipoProducto
			AND tppt.ID_TipoProductoPertenenciaTipo NOT IN (SELECT ID_TipoProductoPertenenciaTipo FROM TipoProductoPertenenciaTipo WHERE ID_TipoProducto = TipoProducto.ID_TipoProducto AND ID_PertenenciaTipo = PertenenciaTipo.ID_PertenenciaTipo)



--SELECT *
--FROM TipoProducto WHERE ID_TipoProducto=@ID_TipoProducto

--SELECT *
--FROM TipoProductoTipoCuenta WHERE ID_TipoProducto=@ID_TipoProducto

--SELECT *
--FROM TipoProductoTipoMA WHERE ID_TipoProducto=@ID_TipoProducto

--SELECT *
--FROM TipoProductoParametroMultiAsginacion WHERE ID_TipoProducto=@ID_TipoProducto

--SELECT *
--FROM dbo.PertenenciaTipo
--     inner JOIN dbo.PertenenciaTipoEvento
--         ON PertenenciaTipoEvento.ID_PertenenciaTipo = PertenenciaTipo.ID_PertenenciaTipo
--     inner JOIN dbo.TipoProductoPertenenciaTipo
--         ON TipoProductoPertenenciaTipo.ID_PertenenciaTipo = PertenenciaTipo.ID_PertenenciaTipo
--            AND TipoProductoPertenenciaTipo.ID_PertenenciaTipo = PertenenciaTipoEvento.ID_PertenenciaTipo
--	 inner JOIN dbo.Eventos ON Eventos.ID_Evento = PertenenciaTipoEvento.ID_Evento
--WHERE ID_TipoProducto =@ID_TipoProducto

----PERTENENCIAS TIPO DUPLICADAS
--SELECT 'PERTENENCIAS TIPO DUPLICADAS', cp.CodigoProceso, pt.ID_CodigoProceso, pem.Clave, pt.ID_POSEntryMode, tm.ClaveTipoMensaje, pt.ID_EstatusOperacion, pt.ID_EstatusPostOperacion, COUNT(*)
--FROM TipoProductoPertenenciaTipo tppt
--INNER JOIN PertenenciaTipo pt ON pt.ID_PertenenciaTipo = tppt.ID_PertenenciaTipo
--INNER JOIN PertenenciaTipoEvento pte ON pte.ID_PertenenciaTipo =  pt.ID_PertenenciaTipo
--INNER JOIN Eventos ev ON ev.ID_Evento = pte.ID_Evento
--LEFT JOIN CodigoProceso cp ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
--LEFT JOIN POSEntryMode pem ON pem.ID_POSEntryMode = pt.ID_POSEntryMode
--LEFT JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje
--WHERE ClaveTipoProducto = @ClaveTipoProducto
--GROUP BY cp.CodigoProceso, pt.ID_CodigoProceso, pem.Clave, pt.ID_POSEntryMode,tm.ClaveTipoMensaje, pt.ID_EstatusOperacion, pt.ID_EstatusPostOperacion
--HAVING COUNT(*) > 1 

  
--PRINT('PERTENENCIAS TIPO CON MAS DE UN EVENTOS')
--SELECT 'PERTENENCIAS TIPO CON MAS DE UN EVENTOS', * 
--FROM dbo.PertenenciaTipo 
--WHERE ID_PertenenciaTipo IN (
--	SELECT PertenenciaTipo.ID_PertenenciaTipo 
--	FROM dbo.PertenenciaTipoEvento 
--	INNER JOIN dbo.PertenenciaTipo ON PertenenciaTipo.ID_PertenenciaTipo = PertenenciaTipoEvento.ID_PertenenciaTipo 
--	WHERE ClaveTipoProducto=@ClaveTipoProducto
--	GROUP BY PertenenciaTipo.ID_PertenenciaTipo HAVING COUNT(*)>1 
--)

--PRINT('EVENTOS LIGADOS A LAS PERTENENCIAS TIPO CON MAS DE UN EVENTOS')
--SELECT 'EVENTOS LIGADOS A LAS PERTENENCIAS TIPO CON MAS DE UN EVENTOS', * 
--FROM dbo.PertenenciaTipoEvento pte
--INNER JOIN Eventos ev ON pte.ID_Evento = ev.ID_Evento
--WHERE ID_PertenenciaTipo IN  (
--	SELECT PertenenciaTipo.ID_PertenenciaTipo 
--	FROM dbo.PertenenciaTipoEvento 
--	INNER JOIN dbo.PertenenciaTipo ON PertenenciaTipo.ID_PertenenciaTipo = PertenenciaTipoEvento.ID_PertenenciaTipo 
--	WHERE ClaveTipoProducto=@ClaveTipoProducto
--	GROUP BY PertenenciaTipo.ID_PertenenciaTipo HAVING COUNT(*)>1 
--)



--COMMIT
--SELECT * FROM dbo.PertenenciaTipo ORDER BY ID_PertenenciaTipo

--select * from dbo.PertenenciaTipoEvento ORDER BY ID_PertenenciaTipo

--ROLLBACK

--SELECT * FROM dbo.ParametrosMultiasignacion


--SELECT ID_CodigoProceso AS ID_CodigoProceso, ID_POSEntryMode AS ID_POSEntryMode, COUNT(*) AS totla INTO #temp FROM dbo.PertenenciaTipo group BY ID_CodigoProceso, ID_POSEntryMode HAVING COUNT(*)>1

--SELECT * FROM #temp INNER JOIN dbo.CodigoProceso on  CodigoProceso.ID_CodigoProceso = #temp.ID_CodigoProceso
--INNER JOIN dbo.POSEntryMode on  POSEntryMode.ID_POSEntryMode = #temp.ID_POSEntryMode ORDER BY CodigoProceso


--SELECT * from dbo.Producto

--SELECT * FROM dbo.RespuestaISO

--SELECT * FROM dbo.RespuestaISOCampos

--SELECT * from dbo.EventoRespuestaISO

  ----PERTENENCIAS TIPO
  --SELECT EV.ClaveEvento, ev.Descripcion as DescripcionEvento, pt.Descripcion as DescripcionPetenenciaTipo, cp.CodigoProceso, pem.Clave, tm.ClaveTipoMensaje, * 
  --FROM PertenenciaTipo pt 
  --INNER JOIN PertenenciaTipoEvento pte ON pte.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
  --INNER JOIN Eventos ev ON ev.ID_Evento = pte.ID_Evento
  --INNER JOIN POSEntryMode pem ON pem.ID_POSEntryMode = pt.ID_POSEntryMode 
  --INNER JOIN CodigoProceso cp ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
  --INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje
  --WHERE pt.ClaveTipoProducto = @ClaveTipoProducto

  --  SELECT pt.Descripcion, count(*)
  --FROM PertenenciaTipo pt 
  --INNER JOIN PertenenciaTipoEvento pte ON pte.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
  --INNER JOIN Eventos ev ON ev.ID_Evento = pte.ID_Evento
  --INNER JOIN POSEntryMode pem ON pem.ID_POSEntryMode = pt.ID_POSEntryMode 
  --INNER JOIN CodigoProceso cp ON cp.ID_CodigoProceso = pt.ID_CodigoProceso
  --INNER JOIN TipoMensajes tm ON tm.ID_TipoMensaje = cp.ID_TipoMensaje
  --WHERE pt.ClaveTipoProducto = @ClaveTipoProducto
  --GROUP BY pt.Descripcion


  /***********************************************************/
--VALIDACION DUPLICADOS DE PERTENENCIAS TIPO
/******/

  DECLARE @PERTENENCIA_TIPO_DESPUES TABLE 
	(
		IdPertenenciaTipo INT,
		IdColectivaEmisor BIGINT,
		IdGrupoMA INT,
		IdGrupoCuenta INT,
		TipoMensaje  VARCHAR(50),
		ClaveAfiliacion VARCHAR(20),
		CodigoProceso VARCHAR(50),
		POSEM VARCHAR(5),
		EsActiva BIT,
		Descripcion VARCHAR(150),
		IdEstatusOperacion INT,
		IdEstatusPostOperacion INT,
		ClavePertenenciaTipo VARCHAR(50)  
	)
			--/////PERTENENCIAS
						--Obtención de Pertenencias Tipo
						INSERT INTO 
							@PERTENENCIA_TIPO_DESPUES
						SELECT		
							pt.ID_PertenenciaTipo,
							@IdColectivaEmisor,
							pgma.ID_GrupoMA,
							p.ID_GrupoCuenta,
							tm.ClaveTipoMensaje,
							@ClaveAfiliacion,
							cp.CodigoProceso,
							pem.Clave,
							1,
							pt.Descripcion,
							pt.ID_EstatusOperacion,
							pt.ID_EstatusPostOperacion,
							ISNULL(pt.Clave, '')
						FROM		
							TipoProductoPertenenciaTipo tppt WITH (NOLOCK)
							INNER JOIN Producto p WITH (NOLOCK)
								ON tppt.ID_TipoProducto = p.ID_TipoProducto
							INNER JOIN ProductoGrupoMA pgma WITH (NOLOCK)
								ON p.ID_Producto = pgma.ID_Producto
							INNER JOIN PertenenciaTipo pt WITH (NOLOCK)
								ON tppt.ID_PertenenciaTipo = pt.ID_PertenenciaTipo
							INNER JOIN TipoProducto tp WITH (NOLOCK)
								ON pt.ClaveTipoProducto = tp.ClaveTipoProducto
							INNER JOIN CodigoProceso cp WITH (NOLOCK)
								ON pt.ID_CodigoProceso = cp.ID_CodigoProceso
							INNER JOIN TipoMensajes tm WITH (NOLOCK)
								ON cp.ID_TipoMensaje = tm.ID_TipoMensaje
							LEFT JOIN POSEntryMode pem WITH (NOLOCK)
								ON pt.ID_POSEntryMode = pem.ID_POSEntryMode
						WHERE
							tppt.ID_TipoProducto = @ID_TipoProducto
							--AND p.ID_Producto = @IdNuevoProducto
		
		--SELECT 
		--						ClaveAfiliacion, 
		--						CodigoProceso, 
		--						IdColectivaEmisor, 
		--						IdGrupoCuenta, 
		--						IdGrupoMA, 
		--						POSEM, 
		--						TipoMensaje, 
		--						IdEstatusOperacion, 
		--						IdEstatusPostOperacion, 
		--						COUNT(*)
		--					FROM 
		--						@PERTENENCIA_TIPO_DESPUES
		--					GROUP BY 
		--						ClaveAfiliacion, 
		--						CodigoProceso, 
		--						IdColectivaEmisor, 
		--						IdGrupoCuenta, 
		--						IdGrupoMA,
		--						POSEM, 
		--						TipoMensaje, 
		--						IdEstatusOperacion, 
		--						IdEstatusPostOperacion
		--					HAVING 
		--						COUNT(*) > 1 

	IF @commit = 1
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN