Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1C4816BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhL2Uvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhL2Uvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:31 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so46504114wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7OxXY+ZqgjLpika47wdXhBbBZdzHjTmR8etjcUZ564g=;
        b=IVWUIHhGJ3Yib/m1T8Kwt+phY1UuZ/649FJHklnxj/BSw53f0UCuu50rKNCcx6MsL/
         90chKN3wIr8eMYrFFUrX5QW9Vh1z+OK9kDvYzkIooSP4jJgNLukxnKMHws68m2Pq4vbE
         XLIH7sDI+ZfuMYQr8UKXWc7zpXREYaEAKI4jbDRRhuYI1Ns8ggs4CaDD8H8KeYyDPMfg
         otHPdQjTSQwcgr1NIO3HH65u7q4cYaMxigwRfrlgtdxGsH7vh3jlfN3XqmCniCGOWjyE
         bZzCKEqZmLNYdpj2xOeK4AGa5jMNhkXb49giiqkphEScf4AmsLjWcOTDKhYfsmGyMHZm
         kCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7OxXY+ZqgjLpika47wdXhBbBZdzHjTmR8etjcUZ564g=;
        b=0D8SUSsy1bYOcjCEA723yuQaBCTLKrTyQz7zT25E1iDhAJ/Hf9izKT123q8UIAWTjz
         qdFvPfTT1y7vmzOL7WX35EAmo3bSfEfpz55aspSi9RaPKbjqkikkxuomfty1zi66Sd9O
         ulbLpDFPC3Iyit1HmSc9LJGS84TmWQBmjwkG1Oe0qag4Tc4jA8vkLBfV1k4HZx/NpIkt
         geyAK443jXDF4qvVZFbmLxrpmva1YHyiRRdKVy96rKZQgo1vFIW4D0fwX0uT1/nh5iSw
         uSvRdJDTrXOlq/Q8Antze1F67mgt6vNNT3SlDrsbNIkbgSbS05DBsW9vTAvUE7XJdX+S
         ujHg==
X-Gm-Message-State: AOAM530rzJaEI8Nv+tZOyviEVKu6dbyUy38h/4RBFYYJbz5x8S/HsCgT
        GCywrXbi3JYxlnUxXP8Z9P0KV6DrnhU=
X-Google-Smtp-Source: ABdhPJw30pvdWAGAclxqwM6knVSs12phm4xW+nJx6KUjns5q/EyoH5fuM15QO5ia0cZESa7ThhNpHQ==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr22269008wrs.219.1640811089274;
        Wed, 29 Dec 2021 12:51:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:28 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/32] staging: r8188eu: remove ODM_SetRFReg()
Date:   Wed, 29 Dec 2021 21:50:40 +0100
Message-Id: <20211229205108.26373-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_SetRFReg() is just a wrapper around rtl8188e_PHY_SetRFReg().
Remove ODM_SetRFReg() and call rtl8188e_PHY_SetRFReg() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 34 +++++++++----------
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  2 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |  6 ----
 .../staging/r8188eu/include/odm_interface.h   |  3 --
 4 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index f6f99b2acc01..8eec8ea95162 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -409,14 +409,14 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	/* 1 Get TXIMR setting */
 	/* modify RXIQK mode table */
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf117B);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf117B);
 
 	/* PA,PAD off */
-	ODM_SetRFReg(dm_odm, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x980);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, 0x56, bRFRegOffsetMask, 0x51000);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x980);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0x56, bRFRegOffsetMask, 0x51000);
 
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
 
@@ -458,10 +458,10 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	/* 1 RX IQK */
 	/* modify RXIQK mode table */
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7ffa);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7ffa);
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
 
 	/* IQK setting */
@@ -492,7 +492,7 @@ phy_PathA_RxIQK(struct adapter *adapt)
 
 	/* reload RF 0xdf */
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
-	ODM_SetRFReg(dm_odm, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x180);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x180);
 
 	if (!(regeac & BIT(27)) &&		/* if Tx is OK, check whether Rx is OK */
 	    (((regEA4 & 0x03FF0000) >> 16) != 0x132) &&
@@ -839,8 +839,6 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 {
 	u8 tmpreg;
 	u32 RF_Amode = 0, RF_Bmode = 0, LC_Cal;
-	struct hal_data_8188e *pHalData = &adapt->haldata;
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	/* Check continuous TX and Packet TX */
 	tmpreg = rtw_read8(adapt, 0xd03);
@@ -861,18 +859,18 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
-		ODM_SetRFReg(dm_odm, RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode & 0x8FFFF) | 0x10000);
+		rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode & 0x8FFFF) | 0x10000);
 
 		/* Path-B */
 		if (is2t)
-			ODM_SetRFReg(dm_odm, RF_PATH_B, RF_AC, bMask12Bits, (RF_Bmode & 0x8FFFF) | 0x10000);
+			rtl8188e_PHY_SetRFReg(adapt, RF_PATH_B, RF_AC, bMask12Bits, (RF_Bmode & 0x8FFFF) | 0x10000);
 	}
 
 	/* 3. Read RF reg18 */
 	LC_Cal = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits);
 
 	/* 4. Set LC calibration begin	bit15 */
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal | 0x08000);
+	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal | 0x08000);
 
 	ODM_sleep_ms(100);
 
@@ -881,11 +879,11 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 		/* Deal with continuous TX case */
 		/* Path-A */
 		rtw_write8(adapt, 0xd03, tmpreg);
-		ODM_SetRFReg(dm_odm, RF_PATH_A, RF_AC, bMask12Bits, RF_Amode);
+		rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits, RF_Amode);
 
 		/* Path-B */
 		if (is2t)
-			ODM_SetRFReg(dm_odm, RF_PATH_B, RF_AC, bMask12Bits, RF_Bmode);
+			rtl8188e_PHY_SetRFReg(adapt, RF_PATH_B, RF_AC, bMask12Bits, RF_Bmode);
 	} else {
 		/*  Deal with Packet TX case */
 		rtw_write8(adapt, REG_TXPAUSE, 0x00);
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index f75086d7c569..c5f424c89e36 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -20,7 +20,7 @@ void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 	} else if (Addr == 0xf9) {
 		ODM_delay_us(1);
 	} else {
-		ODM_SetRFReg(pDM_Odm, RF_PATH, RegAddr, bRFRegOffsetMask, Data);
+		rtl8188e_PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH, RegAddr, bRFRegOffsetMask, Data);
 		/*  Add 1us delay between BB/RF register setting. */
 		ODM_delay_us(1);
 	}
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index bf82f40cca24..42d6485758c0 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -16,12 +16,6 @@ u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
 	return rtl8188e_PHY_QueryBBReg(Adapter, RegAddr, BitMask);
 }
 
-void ODM_SetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32 RegAddr, u32 BitMask, u32 Data)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	rtl8188e_PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask, Data);
-}
-
 /*  ODM Memory relative API. */
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
 {
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index aabc33927a30..29bf5ae468da 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -17,9 +17,6 @@ void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
 
 u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask);
 
-void ODM_SetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path eRFPath,
-		  u32 RegAddr, u32 BitMask, u32 Data);
-
 /*  Memory Relative Function. */
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
-- 
2.34.1

