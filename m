Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8849C4816BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhL2Uvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhL2Uv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2ECC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso12316109wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWfe+fd1pFg0rJXxOlhfNuf5flL85Nw1aH666wlhm0A=;
        b=DHnHojituA6x2QBxecpqmmATd4kUYb6scW0ndFOp+9jNQJfi3aivwqDf4skXWd4w78
         S5ZI7Q0JryWlNK30z36DrlSLLmGEVZOdHQBzLQ+Tor3AP0BEeggpqNxSbz1lGeFw5RL6
         csofTV1CsacQe83pEF+S9+g5d6qa/wQiKKE6czXMIdtHCvGHg8j0QsYEuCeUpH9zl2it
         23ZPBIraptXCqiiNaMEhznJQUD5ftmGEy5bzJGxby3AKJNHSgEslvqSToIwdVP6kwMyc
         o/VmkLKFUXbyOeWHooR8HCB4JBV64ezjDNgqAY49gw4vf/j2/VZ18Q3/6R9BEZ4hp/Og
         HGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWfe+fd1pFg0rJXxOlhfNuf5flL85Nw1aH666wlhm0A=;
        b=cmwUTzjFrCxpZ6jEk6E3h+0k5oyHPuvogDoAhFNlRkbZLtHCQOVGhJynSWfE65meed
         k8blVChGVGid8wtdJRwbfmAkFzOGnyM8+zj5nZOvWP+b7rNEToCb+sWnX3XQOgrMzD7J
         f4uoobEYsvWNGYjFNYGCrObOiI+Kl3ZxDCtK37NUzyg8k7fj3suTgYTuRoQ2vAtvw8DI
         hhyOS0cs9uLTj9wooCU6vIENY6ZNO549+EnnGfaNPgHRM2u1klwHLQwr5wwgm4zpRCgK
         AcfEqFZzuzlNAXbLNmBos4k6WLL7n+l4zLm6qbjG3BYEvzwcyQioeIt+lnK73Lb9KdUj
         yRzg==
X-Gm-Message-State: AOAM5314YlIjio8LUVt0e6h8gXywFyG5sRzw+o82+wrbUoc7+OvImhqP
        YBnV3MeU1j99x50MZI1P0/A=
X-Google-Smtp-Source: ABdhPJykGrcFehIaavwB8EouurLvsJDPoUHbxYDx8aohejXEA9xaXDa0mVDuA16UXzqGSxDTkIm8sg==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr22787142wma.170.1640811087064;
        Wed, 29 Dec 2021 12:51:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/32] staging: r8188eu: remove ODM_SetMACReg()
Date:   Wed, 29 Dec 2021 21:50:37 +0100
Message-Id: <20211229205108.26373-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_SetMACReg() is just a wrapper around rtl8188e_PHY_SetBBReg().
Remove ODM_SetMACReg() and call rtl8188e_PHY_SetBBReg() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c     | 18 +++++++++++-------
 drivers/staging/r8188eu/hal/odm_interface.c    |  6 ------
 .../staging/r8188eu/include/odm_interface.h    |  3 ---
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index eefa448d2002..2fd7dee2d4b5 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -5,11 +5,12 @@
 
 static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 {
+	struct adapter *adapter = dm_odm->Adapter;
 	u32	value32;
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
-	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
 	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
 	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
@@ -26,11 +27,12 @@ static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 
 static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 {
+	struct adapter *adapter = dm_odm->Adapter;
 	u32	value32;
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
-	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
 	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
 	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
@@ -56,17 +58,18 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 
 static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 {
+	struct adapter *adapter = dm_odm->Adapter;
 	u32	value32;
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, 0x4c, bMaskDWord);
-	ODM_SetMACReg(dm_odm, 0x4c, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	rtl8188e_PHY_SetBBReg(adapter, 0x4c, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	value32 = ODM_GetMACReg(dm_odm,  0x7B4, bMaskDWord);
-	ODM_SetMACReg(dm_odm, 0x7b4, bMaskDWord, value32 | (BIT(16) | BIT(17))); /* Reg7B4[16]=1 enable antenna training, Reg7B4[17]=1 enable A2 match */
+	rtl8188e_PHY_SetBBReg(adapter, 0x7b4, bMaskDWord, value32 | (BIT(16) | BIT(17))); /* Reg7B4[16]=1 enable antenna training, Reg7B4[17]=1 enable A2 match */
 
 	/* Match MAC ADDR */
-	ODM_SetMACReg(dm_odm, 0x7b4, 0xFFFF, 0);
-	ODM_SetMACReg(dm_odm, 0x7b0, bMaskDWord, 0);
+	rtl8188e_PHY_SetBBReg(adapter, 0x7b4, 0xFFFF, 0);
+	rtl8188e_PHY_SetBBReg(adapter, 0x7b0, bMaskDWord, 0);
 
 	ODM_SetBBReg(dm_odm, 0x870, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
 	ODM_SetBBReg(dm_odm, 0x864, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
@@ -105,6 +108,7 @@ void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *dm_odm)
 void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant)
 {
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+	struct adapter *adapter = dm_odm->Adapter;
 	u32	DefaultAnt, OptionalAnt;
 
 	if (dm_fat_tbl->RxIdleAnt != Ant) {
@@ -120,7 +124,7 @@ void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant)
 			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), DefaultAnt);	/* Default RX */
 			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8) | BIT(7) | BIT(6), OptionalAnt);		/* Optional RX */
 			ODM_SetBBReg(dm_odm, ODM_REG_ANTSEL_CTRL_11N, BIT(14) | BIT(13) | BIT(12), DefaultAnt);	/* Default TX */
-			ODM_SetMACReg(dm_odm, ODM_REG_RESP_TX_11N, BIT(6) | BIT(7), DefaultAnt);	/* Resp Tx */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RESP_TX_11N, BIT(6) | BIT(7), DefaultAnt);	/* Resp Tx */
 		} else if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV) {
 			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), DefaultAnt);	/* Default RX */
 			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8) | BIT(7) | BIT(6), OptionalAnt);		/* Optional RX */
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 075e7a3307f7..f40adfff7ab6 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -4,12 +4,6 @@
 #include "../include/odm_precomp.h"
 /*  ODM IO Relative API. */
 
-void ODM_SetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 Data)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	rtl8188e_PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
-}
-
 u32 ODM_GetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index e27ba77577a7..ab7f263f3f79 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -12,9 +12,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 /*  =========== EXtern Function Prototype */
 
-void ODM_SetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
-		   u32 BitMask, u32 Data);
-
 u32 ODM_GetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask);
 
 void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
-- 
2.34.1

