Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614E84A35E1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354663AbiA3LMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbiA3LM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:12:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84675C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:12:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u24so20777043eds.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gko303HZwHZ0Al5RiiTL+rtQndEeK/ZYFqcpqPlMJRA=;
        b=IyGZrmpMOGd136RiRrYvCeLQZXL7ZcP7VVQ/tcxxhFJ1iL1HEpDTBLOURlYr6M9taW
         zBT8mg4w+H0glm+s7WU8Lmur50NHIDYgO35oYgJRwD6lT+rE2GWkiU46NPo61YfhbXDD
         vfx23Ml5uGe2gactxlINTfDqfMEd1yhnWiiVbtxGeOOiuxJ9ygUZ/aOx5B7iuNKPxOz4
         HJ46ftdPw3zZOUW9u2azbe/6JxZg20qbQ87XuaSpn0QVeUxBXGL2j9+EkeXB1GA0YF8v
         /y7/WTDnFF4FP4CF6X4/FOyaTBIr8b3mht0g0uBgmLDXqyfjQzBsgH1y+2sA9IO2le5C
         vkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gko303HZwHZ0Al5RiiTL+rtQndEeK/ZYFqcpqPlMJRA=;
        b=UVnD+UXCNGR94qT6W8nE50nA1o5EqthbEiooCzw6JNGcERxblQjZwPSPE+X+wTUYlv
         6ENNoLd5O+gIjGGGeP61GcCbBbfuu6R90y6q14WFZTmo948k4VxMf6mzzC2aY5BQVMgy
         jfY8xanG2xMt5WU9rh/Gdnka46wcMzCA071WlBI8SgbozUN9y7h71zh/xi9Jw8IXXPza
         7iUk8TgxcnAh4uofUCuXQdn4QcMNcIMAmKjGfLreAlVlncZtJZWYXkpeIlAUircBOos1
         AjDKpAOTrsfOLTiyx3JW50BbHuH+tPbAFjqw32bKi/hCFokzQQyUv5aanyz6ca0bGM/K
         jA1w==
X-Gm-Message-State: AOAM530kFZDssUiqrZbtChcJtegCvPdrzFMJ+MlJMwNqVi6nPPt0r2GA
        IDOaAD8x7I8JdSKgFstaJaoYD3aF2j4=
X-Google-Smtp-Source: ABdhPJxaC2J8BjmMPtMbqolj7fFjGDUA+0KxsUbGVxuhdVq2bgtLJSfLxEZOzZU64HAecBfAy849ng==
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr11378328edz.69.1643541148136;
        Sun, 30 Jan 2022 03:12:28 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id nd9sm12129510ejc.169.2022.01.30.03.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 03:12:27 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: remove hal_init_macaddr()
Date:   Sun, 30 Jan 2022 12:12:19 +0100
Message-Id: <20220130111219.6390-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130111219.6390-1-straube.linux@gmail.com>
References: <20220130111219.6390-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hal_init_macaddr() is just a wrapper around SetHwReg8188EU() which
calls hw_var_set_macaddr(). Remove hal_init_macaddr(), remove the
HW_VAR_MAC_ADDR case from SetHwReg8188EU() and call
hw_var_set_macaddr() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_com.c      |  5 ----
 drivers/staging/r8188eu/hal/usb_halinit.c  | 27 ++++++++++------------
 drivers/staging/r8188eu/include/hal_com.h  |  2 --
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index f83375a389f8..06f2a9083056 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -287,11 +287,6 @@ bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
 	return result;
 }
 
-void hal_init_macaddr(struct adapter *adapter)
-{
-	SetHwReg8188EU(adapter, HW_VAR_MAC_ADDR, adapter->eeprompriv.mac_addr);
-}
-
 /*
 * C2H event format:
 * Field	 TRIGGER		CONTENT	   CMD_SEQ	CMD_LEN		 CMD_ID
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index c5282603a42c..90f545f17710 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -567,6 +567,17 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 	DBG_88E("%s,Cur_ant:(%x)%s\n", __func__, haldata->CurAntenna, (haldata->CurAntenna == Antenna_A) ? "Antenna_A" : "Antenna_B");
 }
 
+static void hw_var_set_macaddr(struct adapter *Adapter, u8 *val)
+{
+	u8 idx = 0;
+	u32 reg_macid;
+
+	reg_macid = REG_MACID;
+
+	for (idx = 0; idx < 6; idx++)
+		rtw_write8(Adapter, (reg_macid + idx), val[idx]);
+}
+
 u32 rtl8188eu_hal_init(struct adapter *Adapter)
 {
 	u8 value8 = 0;
@@ -673,7 +684,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	_InitDriverInfoSize(Adapter, DRVINFO_SZ);
 
 	_InitInterrupt(Adapter);
-	hal_init_macaddr(Adapter);/* set mac_address */
+	hw_var_set_macaddr(Adapter, Adapter->eeprompriv.mac_addr);
 	_InitNetworkType(Adapter);/* set msr */
 	_InitWMACSetting(Adapter);
 	_InitAdaptiveCtrl(Adapter);
@@ -1027,17 +1038,6 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 *val)
 	}
 }
 
-static void hw_var_set_macaddr(struct adapter *Adapter, u8 *val)
-{
-	u8 idx = 0;
-	u32 reg_macid;
-
-	reg_macid = REG_MACID;
-
-	for (idx = 0; idx < 6; idx++)
-		rtw_write8(Adapter, (reg_macid + idx), val[idx]);
-}
-
 static void hw_var_set_bssid(struct adapter *Adapter, u8 *val)
 {
 	u8 idx = 0;
@@ -1080,9 +1080,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_SET_OPMODE:
 		hw_var_set_opmode(Adapter, val);
 		break;
-	case HW_VAR_MAC_ADDR:
-		hw_var_set_macaddr(Adapter, val);
-		break;
 	case HW_VAR_BSSID:
 		hw_var_set_bssid(Adapter, val);
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_com.h b/drivers/staging/r8188eu/include/hal_com.h
index 4417054c0f93..56ba356b5371 100644
--- a/drivers/staging/r8188eu/include/hal_com.h
+++ b/drivers/staging/r8188eu/include/hal_com.h
@@ -148,8 +148,6 @@ void HalSetBrateCfg(struct adapter *Adapter, u8 *mBratesOS, u16 *pBrateCfg);
 
 bool Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
 
-void hal_init_macaddr(struct adapter *adapter);
-
 s32 c2h_evt_read(struct adapter *adapter, u8 *buf);
 
 #endif /* __HAL_COMMON_H__ */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 9b4d1650b4b5..9e66ef68e1e8 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -11,7 +11,6 @@
 enum hw_variables {
 	HW_VAR_MEDIA_STATUS,
 	HW_VAR_SET_OPMODE,
-	HW_VAR_MAC_ADDR,
 	HW_VAR_BSSID,
 	HW_VAR_INIT_RTS_RATE,
 	HW_VAR_BASIC_RATE,
-- 
2.34.1

