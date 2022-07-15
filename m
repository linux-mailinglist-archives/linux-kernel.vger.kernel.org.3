Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702B6575B91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiGOG3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiGOG3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:29:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DAA140C5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:29:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf4so7280119ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xl+9oCMh/oqt2tTlhq3WUAuzJWvvAJxxxxNs123bVL0=;
        b=WNJrl8Yb7jU5xqrl9zVMUpjWvPC+5VA+DCLSr1nXlR10FFd1a0ZtA95scWQL370jtH
         CtPJlpqRqJx44KmaKeQuYtunaDhyBZsa2BsT8YqPXbruY4JcTGjUTInh3a3LlSR80QTX
         R5V6NUvNwTw8klIqvxLaZ/MV1SKwzWVcGQ/T7nNSwHrhYADv6srARp9PiVBEcPzXsqMe
         TCz5Dm4iZyK9uhonK313EnztTE0MTGtp4eD2RYsMdwk6bqnPsUceY9OEqvpvF0tL8qaA
         p1AhBQV3kOx1zA5W1cLd4KB0qAqJUlV0Dt4MB04xVnyP6jVprwwrbAFtAIDbT4PqFz58
         nKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xl+9oCMh/oqt2tTlhq3WUAuzJWvvAJxxxxNs123bVL0=;
        b=7LAok8KpmZTcTKD1WPLHq0NCnjPspraUvfH2wg49oi744kvYhh3TIygGjdgQPakASo
         WSiXEsJh8O7IpJ+aDo83Bgp9phtm1Fay+CXz36a3MbTpd3NCDkS0/ufOeLkTLo3mgbDQ
         sYKvkQSGOhjItcwR7GmB9wGvB8CC86uwMkrw/tk5jkcvHj5QgU1doGX49f34jboerVzL
         zaLso9/pzP0cr1TiMaAjfkNDhcPHR/Ya/+h8L2MrQWbBQm2Z9za5+Eizq/ea6xYPNrlj
         JLISxLz+TWUC3zkVvbDoQRmBl+v10pIvv7wLmsGmJMQvB+huBAFz4OJ8o2Bcx/o1gWRC
         4ZNQ==
X-Gm-Message-State: AJIora/B/i5mAKwmYjeWV151kZkdNtAoXhIsCA55Jf4thUcKRk31ebwl
        1zg3n1i5VwKA+3f4MgaIvf9dGxIME/4=
X-Google-Smtp-Source: AGRyM1tAwn7SmZWIPPGC/IQhUsjZiFUtaEwVj4JJtrNLpkmBdf+W7GbVfeZPOpFQrg5dY23KrQnUGQ==
X-Received: by 2002:a17:907:2be9:b0:72b:50b8:82d6 with SMTP id gv41-20020a1709072be900b0072b50b882d6mr2608093ejc.677.1657866558549;
        Thu, 14 Jul 2022 23:29:18 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb91.dynamic.kabel-deutschland.de. [95.90.187.145])
        by smtp.gmail.com with ESMTPSA id ku5-20020a170907788500b007262a5e2204sm1614515ejc.153.2022.07.14.23.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 23:29:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove SetHwReg8188EU()
Date:   Fri, 15 Jul 2022 08:29:08 +0200
Message-Id: <20220715062908.8547-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715062908.8547-1-straube.linux@gmail.com>
References: <20220715062908.8547-1-straube.linux@gmail.com>
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

Remove the case HW_VAR_CORRECT_TSF from SetHwReg8188EU() and move the
functionality to the function that calls SetHwReg8188EU() with
HW_VAR_CORRECT_TSF. SetHwReg8188EU() is empty now and we can finally
remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 34 +++++++++++++++-
 drivers/staging/r8188eu/hal/usb_halinit.c   | 45 ---------------------
 drivers/staging/r8188eu/include/hal_intf.h  |  6 ---
 3 files changed, 33 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 7b69d9ad75e9..32d0e101d0c2 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -445,7 +445,39 @@ static void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe)
 
 static void correct_TSF(struct adapter *padapter)
 {
-	SetHwReg8188EU(padapter, HW_VAR_CORRECT_TSF, NULL);
+	u8 reg;
+	int res;
+	u64 tsf;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+
+	tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue,
+					  pmlmeinfo->bcn_interval * 1024) - 1024; /* us */
+
+	if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) ||
+	    ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
+		rtw_stop_tx_beacon(padapter);
+
+	/* disable related TSF function */
+	res = rtw_read8(padapter, REG_BCN_CTRL, &reg);
+	if (res)
+		return;
+
+	rtw_write8(padapter, REG_BCN_CTRL, reg & (~BIT(3)));
+
+	rtw_write32(padapter, REG_TSFTR, tsf);
+	rtw_write32(padapter, REG_TSFTR + 4, tsf >> 32);
+
+	/* enable related TSF function */
+	res = rtw_read8(padapter, REG_BCN_CTRL, &reg);
+	if (res)
+		return;
+
+	rtw_write8(padapter, REG_BCN_CTRL, reg | BIT(3));
+
+	if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) ||
+	    ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
+		rtw_resume_tx_beacon(padapter);
 }
 
 /****************************************************************************
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b8fd73ac8f7c..ff074d246dab 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -963,51 +963,6 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	kfree(efuse_buf);
 }
 
-void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
-{
-	u8 reg;
-	int res;
-
-	switch (variable) {
-	case HW_VAR_CORRECT_TSF:
-		{
-			u64	tsf;
-			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-
-			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue,
-							  pmlmeinfo->bcn_interval * 1024) - 1024; /* us */
-
-			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
-				rtw_stop_tx_beacon(Adapter);
-
-			/* disable related TSF function */
-			res = rtw_read8(Adapter, REG_BCN_CTRL, &reg);
-			if (res)
-				return;
-
-			rtw_write8(Adapter, REG_BCN_CTRL, reg & (~BIT(3)));
-
-			rtw_write32(Adapter, REG_TSFTR, tsf);
-			rtw_write32(Adapter, REG_TSFTR + 4, tsf >> 32);
-
-			/* enable related TSF function */
-			res = rtw_read8(Adapter, REG_BCN_CTRL, &reg);
-			if (res)
-				return;
-
-			rtw_write8(Adapter, REG_BCN_CTRL, reg | BIT(3));
-
-			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
-				rtw_resume_tx_beacon(Adapter);
-		}
-		break;
-	default:
-		break;
-	}
-
-}
-
 void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
 	u8 init_rate = 0;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e1dfd621a5cb..ab6856d8a090 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -8,10 +8,6 @@
 #include "drv_types.h"
 #include "Hal8188EPhyCfg.h"
 
-enum hw_variables {
-	HW_VAR_CORRECT_TSF,
-};
-
 typedef s32 (*c2h_id_filter)(u8 id);
 
 void rtl8188eu_interface_configure(struct adapter *adapt);
@@ -32,8 +28,6 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
-void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val);
-
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
-- 
2.37.0

