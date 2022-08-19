Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD3599637
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346953AbiHSHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346839AbiHSHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:38:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01C7CCD6C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:38:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so7332742ejp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XRZ4oMqk1JqBQKORZWtFm+zRqfCL6cTJrTdg54hfY08=;
        b=gX3832kauCmUfEhHP1DytlP9Sy4wLU5tdJXnNoekkUvsiTYX18cFnfoMpTdeiPcP/l
         HF0Jf0FxQ9+cfnDWpfG0jOFgEu/p2G2tdgaNsIOvk0v/vVyDjKpJ/mXBQ2b4tAyG9oET
         NzlcGfV1mmBrpouTUkHNJTuX1TVM8Qu+v/VZnqHyTzW6y+ppLxbUR6Du9awwb0BolR32
         hLt0tbdnWveSXBlzx0xSAThukSckHaK9Y2Wv3GRSZAYwCatGxtnyFPhw5IQ8iF5WX5pP
         X0PndCF92seLurQ0OEk7GHjGxTAr/jGmRtxpW6AsPDTRo3w+N0iH8Xdzkl5itJmjHytb
         BH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XRZ4oMqk1JqBQKORZWtFm+zRqfCL6cTJrTdg54hfY08=;
        b=q3FHDToB0h28bt0QADxhTmxo98g5jItYR61otWp4ytfE5yT4EP5MBj5YKjzD9jOAB+
         l8po/XLHa5uDlcraltKTS/3qisJZK0SdIrPEvl7iH1rs1MKh7wBvc7I4Luc2LDg16QhE
         kVMg6W03fc4bh2+UUd8iF58XpShGUKz92IhbAhg5s2VgHwJCBdBeLxa4xHYz8/z/JOfY
         lWCZv4pq18s9331zG3CaxfknMLCY8PZBy18P1zEaQH7XnfNOG9xQ/Dsi/QIM130UkA0f
         rhU/FjcFKCDrSgBrwcSULcrpNyuhicsiYnNDsmSQcaiHUFfdj/cP0Byvix/94v0csAtn
         VJxg==
X-Gm-Message-State: ACgBeo2pHijZno7yGHyO2bTiiLr64eaEbBUUGeQ4fkdgTf1tTpEqfL54
        +xg6ES/YXJDKrhuXqkgakzlaD78owqxM5A==
X-Google-Smtp-Source: AA6agR7dO6T0U/EDqcrzhETMlHzHOYjf9yfOH52ZPUrJcykI31nLRFNVavZUXlSqsWzLZWDnEKYDKw==
X-Received: by 2002:a17:906:dc89:b0:731:67eb:b60b with SMTP id cs9-20020a170906dc8900b0073167ebb60bmr3977587ejc.614.1660894680291;
        Fri, 19 Aug 2022 00:38:00 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906604200b0072b1cb2818csm1927299ejj.158.2022.08.19.00.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 00:37:59 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, phil@philpotter.co.uk,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com
Subject: [PATCH] staging: r8188eu: remove unused function declarations
Date:   Fri, 19 Aug 2022 09:37:26 +0200
Message-Id: <20220819073725.8263-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some function declarations because they are neither used nor
have definitions.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 .../staging/r8188eu/include/HalPhyRf_8188e.h  |  3 --
 drivers/staging/r8188eu/include/hal_intf.h    |  3 --
 drivers/staging/r8188eu/include/ieee80211.h   |  1 -
 drivers/staging/r8188eu/include/recv_osdep.h  |  1 -
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  2 -
 drivers/staging/r8188eu/include/rtw_ap.h      |  1 -
 drivers/staging/r8188eu/include/rtw_cmd.h     |  7 ----
 drivers/staging/r8188eu/include/rtw_io.h      | 37 -------------------
 drivers/staging/r8188eu/include/rtw_iol.h     |  3 --
 drivers/staging/r8188eu/include/rtw_mlme.h    |  5 ---
 .../staging/r8188eu/include/rtw_mlme_ext.h    | 10 -----
 drivers/staging/r8188eu/include/rtw_p2p.h     |  1 -
 drivers/staging/r8188eu/include/rtw_xmit.h    |  1 -
 13 files changed, 75 deletions(-)

diff --git a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
index b75a5d869c56..ba38f83eabb9 100644
--- a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
+++ b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
@@ -24,9 +24,6 @@ void PHY_IQCalibrate_8188E(struct adapter *Adapter, bool ReCovery);
 /*  LC calibrate */
 void PHY_LCCalibrate_8188E(struct adapter *pAdapter);
 
-/*  AP calibrate */
-void PHY_DigitalPredistortion_8188E(struct adapter *pAdapter);
-
 void _PHY_SaveADDARegisters(struct adapter *pAdapter, u32 *ADDAReg,
 			    u32 *ADDABackup, u32 RegisterNum);
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fd8e792958ce..3d03615bd3cd 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -30,14 +30,11 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
-void rtw_hal_stop(struct adapter *padapter);
 
 u32 rtl8188eu_hal_init(struct adapter *Adapter);
 u32 rtl8188eu_hal_deinit(struct adapter *Adapter);
 
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
-void	rtw_hal_clone_data(struct adapter *dst_adapt,
-			   struct adapter *src_adapt);
 
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index e7a4f8af497a..8e3c39090b53 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -760,7 +760,6 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit);
 unsigned char *rtw_get_wpa2_ie(unsigned char *pie, int *rsn_ie_len, int limit);
 int rtw_get_wpa_cipher_suite(u8 *s);
 int rtw_get_wpa2_cipher_suite(u8 *s);
-int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len);
 int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher,
 		     int *pairwise_cipher, int *is_8021x);
 int rtw_parse_wpa2_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher,
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index d88fd6058a62..c51e8633c61b 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -11,7 +11,6 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void _rtw_free_recv_priv(struct recv_priv *precvpriv);
 
 s32  rtw_recv_entry(struct recv_frame *precv_frame);
-void rtw_recv_returnpacket(struct  net_device *cnxt, struct sk_buff *retpkt);
 
 int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index c69fed23ded9..275b901f0208 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -140,8 +140,6 @@ void rtl8188e_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc,
 s32 rtl8188eu_init_xmit_priv(struct adapter *padapter);
 s32 rtl8188eu_hal_xmit(struct adapter *padapter, struct xmit_frame *frame);
 s32 rtl8188eu_mgnt_xmit(struct adapter *padapter, struct xmit_frame *frame);
-s32 rtl8188eu_xmit_buf_handler(struct adapter *padapter);
-#define hal_xmit_handler rtl8188eu_xmit_buf_handler
 void rtl8188eu_xmit_tasklet(unsigned long priv);
 bool rtl8188eu_xmitframe_complete(struct adapter *padapter,
 				 struct xmit_priv *pxmitpriv,
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index 724229fe84aa..84adf58f2fef 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -20,7 +20,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta,
 	       u8 rssi_level);
 void expire_timeout_chk(struct adapter *padapter);
 void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta);
-void rtw_ap_restore_network(struct adapter *padapter);
 
 void associated_clients_update(struct adapter *padapter, u8 updated);
 void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta);
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 6b6d560d7143..07c7ca20506f 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -87,7 +87,6 @@ void rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
 
 u32 rtw_init_evt_priv(struct evt_priv *pevtpriv);
 void rtw_free_evt_priv(struct evt_priv *pevtpriv);
-void rtw_evt_notify_isr(struct evt_priv *pevtpriv);
 u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType);
 
 enum rtw_drvextra_cmd_id {
@@ -740,11 +739,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network* pnetwork);
 u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue);
 u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra networktype);
 u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
-u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);
-
-u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset,u8 *pval);
-u8 rtw_setfwdig_cmd(struct adapter*padapter, u8 type);
-u8 rtw_setfwra_cmd(struct adapter*padapter, u8 type);
 
 u8 rtw_addbareq_cmd(struct adapter*padapter, u8 tid, u8 *addr);
 
@@ -772,7 +766,6 @@ void rtw_getbbrfreg_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cmd);
 
 void rtw_setstaKey_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cmd);
 void rtw_setassocsta_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cm);
-void rtw_getrttbl_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cmd);
 
 struct _cmd_callback {
 	u32	cmd_code;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 925c7967ac04..81961e598597 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -208,22 +208,9 @@ struct io_priv {
 	struct intf_hdl intf;
 };
 
-uint ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
-void sync_ioreq_enqueue(struct io_req *preq,struct io_queue *ioqueue);
-uint sync_ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
-uint free_ioreq(struct io_req *preq, struct io_queue *pio_queue);
-struct io_req *alloc_ioreq(struct io_queue *pio_q);
-
-uint register_intf_hdl(u8 *dev, struct intf_hdl *pintfhdl);
-void unregister_intf_hdl(struct intf_hdl *pintfhdl);
-
-void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-
 int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
 int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data);
 int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data);
-void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 rtw_read_port(struct adapter *adapter, u8 *pmem);
 void rtw_read_port_cancel(struct adapter *adapter);
 
@@ -232,20 +219,9 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val);
 int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
 
-void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void rtw_write_port_cancel(struct adapter *adapter);
 
-void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);
-
-/* ioreq */
-void ioreq_read8(struct adapter *adapter, u32 addr, u8 *pval);
-void ioreq_read16(struct adapter *adapter, u32 addr, u16 *pval);
-void ioreq_read32(struct adapter *adapter, u32 addr, u32 *pval);
-void ioreq_write8(struct adapter *adapter, u32 addr, u8 val);
-void ioreq_write16(struct adapter *adapter, u32 addr, u16 val);
-void ioreq_write32(struct adapter *adapter, u32 addr, u32 val);
-
 uint async_read8(struct adapter *adapter, u32 addr, u8 *pbuff,
 		 void (*_async_io_callback)(struct adapter *padater,
 					    struct io_req *pio_req,
@@ -259,9 +235,6 @@ uint async_read32(struct adapter *adapter, u32 addr,  u8 *pbuff,
 					     struct io_req *pio_req,
 					     u8 *cnxt), u8 *cnxt);
 
-void async_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-void async_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-
 void async_write8(struct adapter *adapter, u32 addr, u8 val,
 		  void (*_async_io_callback)(struct adapter *padater,
 					     struct io_req *pio_req,
@@ -275,16 +248,6 @@ void async_write32(struct adapter *adapter, u32 addr, u32 val,
 					      struct io_req *pio_req,
 					      u8 *cnxt), u8 *cnxt);
 
-void async_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-void async_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-
-uint alloc_io_queue(struct adapter *adapter);
-void free_io_queue(struct adapter *adapter);
-void async_bus_io(struct io_queue *pio_q);
-void bus_sync_io(struct io_queue *pio_q);
-u32 _ioreq2rwmem(struct io_queue *pio_q);
-void dev_power_down(struct adapter *Adapter, u8 bpwrup);
-
 #define PlatformEFIOWrite1Byte(_a,_b,_c)		\
 	rtw_write8(_a,_b,_c)
 #define PlatformEFIOWrite2Byte(_a,_b,_c)		\
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index 099f5a075274..2ad5245a42a9 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -38,9 +38,6 @@ int rtw_IOL_append_DELAY_US_cmd(struct xmit_frame *xmit_frame, u16 us);
 int rtw_IOL_append_DELAY_MS_cmd(struct xmit_frame *xmit_frame, u16 ms);
 int rtw_IOL_append_END_cmd(struct xmit_frame *xmit_frame);
 
-void read_efuse_from_txpktbuf(struct adapter *adapter, int bcnhead,
-			      u8 *content, u16 *size);
-
 int rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			  u8 value, u8 mask);
 int rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr,
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index d81668498e46..4c8c02c6b9d6 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -414,9 +414,6 @@ struct mlme_priv {
 	u8		update_bcn;
 };
 
-int hostapd_mode_init(struct adapter *padapter);
-void hostapd_mode_unload(struct adapter *padapter);
-
 extern unsigned char WPA_TKIP_CIPHER[4];
 extern unsigned char RSN_TKIP_CIPHER[4];
 extern unsigned char REALTEK_96B_IE[];
@@ -528,8 +525,6 @@ static inline void set_scanned_network_val(struct mlme_priv *pmlmepriv, int val)
 u16 rtw_get_capability(struct wlan_bssid_ex *bss);
 void rtw_update_scanned_network(struct adapter *adapter,
 				struct wlan_bssid_ex *target);
-void rtw_disconnect_hdl_under_linked(struct adapter *adapter,
-				     struct sta_info *psta, u8 free_assoc);
 void rtw_generate_random_ibss(u8 *pibss);
 struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr);
 struct wlan_network *rtw_get_oldest_wlan_network(struct __queue *scanned_queue);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 343ce1ce4b3d..7b328848af84 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -488,8 +488,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char* addr,
 
 void beacon_timing_control(struct adapter *padapter);
 extern u8 set_tx_beacon_cmd(struct adapter*padapter);
-unsigned int setup_beacon_frame(struct adapter *padapter,
-				unsigned char *beacon_frame);
 void update_mgnt_tx_rate(struct adapter *padapter, u8 rate);
 void update_mgntframe_attrib(struct adapter *padapter,
 			     struct pkt_attrib *pattrib);
@@ -597,12 +595,6 @@ struct cmd_hdl {
 	u8 (*h2cfuns)(struct adapter  *padapter, u8 *pbuf);
 };
 
-u8 read_macreg_hdl(struct adapter *padapter, u8 *pbuf);
-u8 write_macreg_hdl(struct adapter *padapter, u8 *pbuf);
-u8 read_bbreg_hdl(struct adapter *padapter, u8 *pbuf);
-u8 write_bbreg_hdl(struct adapter *padapter, u8 *pbuf);
-u8 read_rfreg_hdl(struct adapter *padapter, u8 *pbuf);
-u8 write_rfreg_hdl(struct adapter *padapter, u8 *pbuf);
 u8 NULL_hdl(struct adapter *padapter, u8 *pbuf);
 u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf);
 u8 disconnect_hdl(struct adapter *padapter, u8 *pbuf);
@@ -612,8 +604,6 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf);
 u8 setauth_hdl(struct adapter *padapter, u8 *pbuf);
 u8 setkey_hdl(struct adapter *padapter, u8 *pbuf);
 u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf);
-u8 set_assocsta_hdl(struct adapter *padapter, u8 *pbuf);
-u8 del_assocsta_hdl(struct adapter *padapter, u8 *pbuf);
 u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf);
 
 u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf);
diff --git a/drivers/staging/r8188eu/include/rtw_p2p.h b/drivers/staging/r8188eu/include/rtw_p2p.h
index b91322a1fe10..c921e90c305d 100644
--- a/drivers/staging/r8188eu/include/rtw_p2p.h
+++ b/drivers/staging/r8188eu/include/rtw_p2p.h
@@ -37,7 +37,6 @@ void process_p2p_ps_ie(struct adapter *padapter, u8 *ies, u32 ielength);
 void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state);
 u8 p2p_ps_wk_cmd(struct adapter *padapter, u8 p2p_ps_state, u8 enqueue);
 void reset_global_wifidirect_info(struct adapter *padapter);
-int rtw_init_wifi_display_info(struct adapter *padapter);
 void rtw_init_wifidirect_timers(struct adapter *padapter);
 void rtw_init_wifidirect_addrs(struct adapter *padapter, u8 *dev_addr,
 			       u8 *iface_addr);
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 034a9f8f51c9..5c186e8137c5 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -333,7 +333,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter,
 			struct xmit_frame *pxmitframe);
 s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt,
 			   struct xmit_frame *pxmitframe);
-s32 _rtw_init_hw_txqueue(struct hw_txqueue *phw_txqueue, u8 ac_tag);
 void _rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv);
 s32 rtw_txframes_pending(struct adapter *padapter);
 s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
-- 
2.25.1

