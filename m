Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB754F0538
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiDBRkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 13:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiDBRkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 13:40:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9AEBCB9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 10:38:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y10so6417945edv.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/HOImi9ShJxRDSviaqXL5UfScuEqhfA9DqIDa3cDdY=;
        b=AvGo9CR8DUEJG/SPlPv3JWOEu39Uits9NFrFOuY5QeSmr4ZzX53j3c3et6pEDMuRW+
         98LXoqn5jJyIHcjsLs44dHum040nneEAaqfni4o9uSbYD2N3b+1OJEVyb79tifuOWKLD
         UV8Y7wIBkdjd3O6sttGbYKxQVfG4Z3coIZyaMa5Sh7/QpjL6zvRbdFQCKLUxmlNHgFDO
         pnsBe2bpKOVAm70nUqN8yEjGG4/FCXX4ChdvRbuXVIw2kgsuT3lhRlqGgHMNwNeo+n61
         idggfat4H197bUkfGLma2vf1jkE3Qd7DZ5CzqMDYGTK0K0MVKF7WmCE8nnnHtY5gNsxx
         1lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/HOImi9ShJxRDSviaqXL5UfScuEqhfA9DqIDa3cDdY=;
        b=rYTj+Hn3nViWDb5zqRhkMrFctMh3JdV7KxmE7QMNHKRPp77UMRxiGfXZd4mk1mi5Mi
         7wh9H8GtEVjMNCADDVagCs1vOhm5dd7xjvzK036YHxXLb/QPAaqLr4QXkwLtXN67yyHo
         sJZslgrDDSoqCh4LO65E23eosuSZMpUG1PzbNXmR6QEnXt1BZDTu5HqurvjeN0xtNGOB
         RTQ3LN551RSdRg2RhDDw5PYoPwfxpnxeVbpG+QoKSwWUbpvoLnYp0Y2gOsYe/UjwO52p
         wIFQWpW/3oh6QpsQNETPySvFFxBceTNZE68t241YecugcY9jvnY00UKq9y/+/P8QROYk
         w9zA==
X-Gm-Message-State: AOAM531MDX8o0rfcFG3ONscmPhDV9nM/Z6rQOnJlPsSd9cpk+neFZTtS
        hajOyQIhVnHDmDv/99SRR7E=
X-Google-Smtp-Source: ABdhPJyNdqjR9aQDmMI+eVGPJuEv9mY5QG6DCwIzEFWgz11PKEtjXA/b3UxDX7ybDZ+G0N/4UpRtzw==
X-Received: by 2002:a05:6402:2812:b0:418:fc32:be18 with SMTP id h18-20020a056402281200b00418fc32be18mr26118861ede.357.1648921121121;
        Sat, 02 Apr 2022 10:38:41 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id gb3-20020a170907960300b006dfafbb4ba4sm2329901ejc.83.2022.04.02.10.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 10:38:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unncessary ternary operator
Date:   Sat,  2 Apr 2022 19:38:35 +0200
Message-Id: <20220402173835.7560-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Using the ternary operator to assign true or false is redundant.
There are many places in the driver code where this is done. Remove
the unnecessary operator to improve readbility.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Tested on x86_64 with Inter-Tech DMG-02.

 drivers/staging/r8188eu/core/rtw_p2p.c          | 2 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 4 ++--
 drivers/staging/r8188eu/core/rtw_sta_mgt.c      | 4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c    | 2 +-
 drivers/staging/r8188eu/hal/hal_com.c           | 2 +-
 drivers/staging/r8188eu/hal/odm_HWConfig.c      | 4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c      | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 drivers/staging/r8188eu/include/HalVerDef.h     | 4 ++--
 drivers/staging/r8188eu/include/ieee80211.h     | 8 ++++----
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 1e728a03e0ac..80305d128ccd 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -951,7 +951,7 @@ u32 process_p2p_devdisc_req(struct wifidirect_info *pwdinfo, u8 *pframe, uint le
 	/* issue Device Discoverability Response */
 	issue_p2p_devdisc_resp(pwdinfo, GetAddr2Ptr(pframe), status, dialogToken);
 
-	return (status == P2P_STATUS_SUCCESS) ? true : false;
+	return status == P2P_STATUS_SUCCESS;
 }
 
 u32 process_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *pframe, uint len)
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 0141de7ab08c..39fbefd4858d 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -348,7 +348,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 
 	pwrctrlpriv->LpsIdleCount = 0;
 	pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
-	pwrctrlpriv->bLeisurePs = (PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt) ? true : false;
+	pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
 
 	pwrctrlpriv->bFwCurrentInPSMode = false;
 
@@ -426,7 +426,7 @@ int rtw_pm_set_lps(struct adapter *padapter, u8 mode)
 			else
 				pwrctrlpriv->LpsIdleCount = 2;
 			pwrctrlpriv->power_mgnt = mode;
-			pwrctrlpriv->bLeisurePs = (PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt) ? true : false;
+			pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
 		}
 	} else {
 		ret = -EINVAL;
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 91ff82f24f1f..357f98e22d8a 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -470,9 +470,9 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 	spin_unlock_bh(&pacl_node_q->lock);
 
 	if (pacl_list->mode == 1)/* accept unless in deny list */
-		res = (match) ? false : true;
+		res = !match;
 	else if (pacl_list->mode == 2)/* deny unless in accept list */
-		res = (match) ? true : false;
+		res = match;
 	else
 		res = true;
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index b526715a70bc..84ced6a86df9 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1482,7 +1482,7 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 		tid = (param >> 2) & 0x0f;
 		preorder_ctrl = &psta->recvreorder_ctrl[tid];
 		preorder_ctrl->indicate_seq = 0xffff;
-		preorder_ctrl->enable = (pmlmeinfo->bAcceptAddbaReq) ? true : false;
+		preorder_ctrl->enable = pmlmeinfo->bAcceptAddbaReq;
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 06f2a9083056..7649f9919f67 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -267,7 +267,7 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
 {
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
-	bool  wifi_cfg = (pregistrypriv->wifi_spec) ? true : false;
+	bool wifi_cfg = pregistrypriv->wifi_spec;
 	bool result = true;
 
 	switch (numoutpipe) {
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 87e9a5270be0..3c09d9d459b1 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -65,7 +65,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 	struct phy_status_rpt *pPhyStaRpt = (struct phy_status_rpt *)pPhyStatus;
 
-	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+	isCCKrate = pPktinfo->Rate >= DESC92C_RATE1M && pPktinfo->Rate <= DESC92C_RATE11M;
 
 	if (isCCKrate) {
 		u8 cck_agc_rpt;
@@ -234,7 +234,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	if ((!pPktinfo->bPacketMatchBSSID))
 		return;
 
-	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+	isCCKrate = pPktinfo->Rate >= DESC92C_RATE1M && pPktinfo->Rate <= DESC92C_RATE11M;
 
 	/* Smart Antenna Debug Message------------------  */
 	if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 45b788212628..18650cd96f09 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -137,7 +137,7 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 
 	bitmap |= ((raid << 28) & 0xf0000000);
 
-	short_gi_rate = (arg & BIT(5)) ? true : false;
+	short_gi_rate = arg & BIT(5);
 
 	raid = (bitmap >> 28) & 0x0f;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 6811be95da9a..ffc82d17ddbe 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -747,7 +747,7 @@ void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
 
 		/*  decide hw if support remote wakeup function */
 		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
-		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1)) ? true : false;
+		padapter->pwrctrlpriv.bSupportRemoteWakeup = hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1);
 }
 
 void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool AutoLoadFail)
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 2bc18eabb55d..56dadadb1a0f 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -34,10 +34,10 @@ struct HAL_VERSION {
 
 /* HAL_CHIP_TYPE_E */
 #define IS_NORMAL_CHIP(version)				\
-	((GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP) ? true : false)
+	(GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP)
 
 /* HAL_VENDOR_E */
 #define IS_CHIP_VENDOR_TSMC(version)			\
-	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC) ? true : false)
+	(GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC)
 
 #endif
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 8c20363cdd31..03d63257797a 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -127,7 +127,7 @@ enum NETWORK_TYPE {
 	 (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
 
 #define IsSupported24G(NetType)					\
-	((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
+	((NetType) & SUPPORTED_24G_NETTYPE_MSK)
 
 #define IsEnableHWCCK(NetType)					\
 	IsSupported24G(NetType)
@@ -135,11 +135,11 @@ enum NETWORK_TYPE {
 #define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
 
 #define IsSupportedTxCCK(NetType)				\
-	((NetType) & (WIRELESS_11B) ? true : false)
+	((NetType) & WIRELESS_11B)
 #define IsSupportedTxOFDM(NetType)				\
-	((NetType) & (WIRELESS_11G) ? true : false)
+	((NetType) & WIRELESS_11G)
 #define IsSupportedTxMCS(NetType)				\
-	((NetType) & (WIRELESS_11_24N) ? true : false)
+	((NetType) & WIRELESS_11_24N)
 
 struct ieee_param {
 	u32 cmd;
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 7a6fcc96081a..3a13f166fb21 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -220,7 +220,7 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
  */
 inline bool rtw_cbuf_empty(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read) ? true : false;
+	return cbuf->write == cbuf->read;
 }
 
 /**
-- 
2.35.1

