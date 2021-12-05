Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA9E468C60
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhLERST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbhLERSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:06 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61390C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v1so33508569edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83pxdd+2SRBEoVUaxcgazhIK0oxpvNgHcZ02CWSKft4=;
        b=WQlBxnPLj9GFQ+6ZCq9I1ZsjRGuRxolwHL4q5YeZNS5+eUEnW5P1blZFU2PnDPzWuC
         ZdIuTWdoNQxbM2x4+BNpAiVMoZuxwhtwap8hPoVC+Aq17TnCABRNIMEINqG6zU2IaZTb
         hR6gVX4iv0JVZ2iJ94amDrgwpQSa2xC1JxrfZua8td3E4wYpmbDj53RtC59R8fpK5UsB
         Pws05TCKcSf2gVFE5XT2O/UlkNU1IZkduWFxfrcWzTzMw97bRWyn7x/4cgYk4x2KgAqx
         87cG2YRBZgzlXTZ2TnMahjU/zukMeZ6OvQe9NC8xsCZxKwdhphX3dI04vUQPhL8O4ej2
         NKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83pxdd+2SRBEoVUaxcgazhIK0oxpvNgHcZ02CWSKft4=;
        b=ROZvEjy0OrfVuZ0pFX+I8SzJy0C+FT1ArvDIVhyAWdtBc6WGJ532/RD+aJIexlanM/
         co7b8JRfXgYh2Oji579WWmRnF5T094Yh4QEV+aL0zuTVXa3woNJVD9JmNbgQFEqcp3Py
         OYxe1JkJpukL+Mx1/vq2JrmZvjN+o3oTxl0cf+/ckPtR+vdZjQAgVhHHX7CGdOQJTNDD
         exliKrgsHBfMLciUctGTjg8yx8rx/YXvlXoMdUhluxe1ruw3Im/GI8l5ctsH8fTRgWVQ
         Y0EIPV8qXg1VFEe7NA4dMiccMUDLMo2FLWCIQdOsjBrxOWmbRmqZtQhshfqOYYkdoHPP
         epVQ==
X-Gm-Message-State: AOAM531CRDVF7thTsW68v8p8TmQ7bH32NM7gOwQuMFU13nOa+trM2zhE
        KPqOIhOqtam6hXktLLPQ9gk=
X-Google-Smtp-Source: ABdhPJxSlISXD6Z1Xe6mYK3c9dX9hSmRec4G1PgDjLVxeowKdoMljOSfa4enCSWPSJoJ+lzMV+0Mfw==
X-Received: by 2002:aa7:d652:: with SMTP id v18mr45920175edr.68.1638724476990;
        Sun, 05 Dec 2021 09:14:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 05/10] staging: r8188eu: remove macro PHY_SetBBReg
Date:   Sun,  5 Dec 2021 18:13:37 +0100
Message-Id: <20211205171342.20551-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205171342.20551-1-straube.linux@gmail.com>
References: <20211205171342.20551-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro PHY_SetBBReg just re-defines rtl8188e_PHY_SetBBReg().
Call rtl8188e_PHY_SetBBReg() directly and remove the macro.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c   |  4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 22 +++++++++----------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 20 ++++++++---------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  6 ++---
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  2 --
 5 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index df981ca4fb29..04c2dc3a3f32 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -7,7 +7,7 @@
 void ODM_SetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 Data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
+	rtl8188e_PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
 }
 
 u32 ODM_GetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
@@ -19,7 +19,7 @@ u32 ODM_GetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
 void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 Data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
+	rtl8188e_PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
 }
 
 u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 99096a5d3041..bf706e411d49 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -169,10 +169,10 @@ phy_RFSerialRead(
 
 	tmplong2 = (tmplong2 & (~bLSSIReadAddress)) | (NewOffset << 23) | bLSSIReadEdge;	/* T65 RF */
 
-	PHY_SetBBReg(Adapter, rFPGA0_XA_HSSIParameter2, bMaskDWord, tmplong & (~bLSSIReadEdge));
+	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_XA_HSSIParameter2, bMaskDWord, tmplong & (~bLSSIReadEdge));
 	udelay(10);/*  PlatformStallExecution(10); */
 
-	PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, bMaskDWord, tmplong2);
+	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, bMaskDWord, tmplong2);
 	udelay(100);/* PlatformStallExecution(100); */
 
 	udelay(10);/* PlatformStallExecution(10); */
@@ -263,7 +263,7 @@ phy_RFSerialWrite(
 	/*  */
 	/*  Write Operation */
 	/*  */
-	PHY_SetBBReg(Adapter, pPhyReg->rf3wireOffset, bMaskDWord, DataAndAddr);
+	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rf3wireOffset, bMaskDWord, DataAndAddr);
 }
 
 /**
@@ -567,7 +567,7 @@ PHY_BBConfig8188E(
 
 	/*  write 0x24[16:11] = 0x24[22:17] = CrystalCap */
 	CrystalCap = pHalData->CrystalCap & 0x3F;
-	PHY_SetBBReg(Adapter, REG_AFE_XTAL_CTRL, 0x7ff800, (CrystalCap | (CrystalCap << 6)));
+	rtl8188e_PHY_SetBBReg(Adapter, REG_AFE_XTAL_CTRL, 0x7ff800, (CrystalCap | (CrystalCap << 6)));
 
 	return rtStatus;
 }
@@ -704,17 +704,17 @@ _PHY_SetBWMode92C(
 	switch (pHalData->CurrentChannelBW) {
 	/* 20 MHz channel*/
 	case HT_CHANNEL_WIDTH_20:
-		PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bRFMOD, 0x0);
-		PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x0);
+		rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bRFMOD, 0x0);
+		rtl8188e_PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x0);
 		break;
 	/* 40 MHz channel*/
 	case HT_CHANNEL_WIDTH_40:
-		PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bRFMOD, 0x1);
-		PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x1);
+		rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bRFMOD, 0x1);
+		rtl8188e_PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x1);
 		/*  Set Control channel to upper or lower. These settings are required only for 40MHz */
-		PHY_SetBBReg(Adapter, rCCK0_System, bCCKSideBand, (pHalData->nCur40MhzPrimeSC >> 1));
-		PHY_SetBBReg(Adapter, rOFDM1_LSTF, 0xC00, pHalData->nCur40MhzPrimeSC);
-		PHY_SetBBReg(Adapter, 0x818, (BIT(26) | BIT(27)),
+		rtl8188e_PHY_SetBBReg(Adapter, rCCK0_System, bCCKSideBand, (pHalData->nCur40MhzPrimeSC >> 1));
+		rtl8188e_PHY_SetBBReg(Adapter, rOFDM1_LSTF, 0xC00, pHalData->nCur40MhzPrimeSC);
+		rtl8188e_PHY_SetBBReg(Adapter, 0x818, (BIT(26) | BIT(27)),
 			     (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) ? 2 : 1);
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 45ab988e9be7..3d54fd0637ce 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -148,15 +148,15 @@ rtl8188e_PHY_RF6052SetCckTxPower(
 
 	/*  rf-A cck tx power */
 	tmpval = TxAGC[RF_PATH_A] & 0xff;
-	PHY_SetBBReg(Adapter, rTxAGC_A_CCK1_Mcs32, bMaskByte1, tmpval);
+	rtl8188e_PHY_SetBBReg(Adapter, rTxAGC_A_CCK1_Mcs32, bMaskByte1, tmpval);
 	tmpval = TxAGC[RF_PATH_A] >> 8;
-	PHY_SetBBReg(Adapter, rTxAGC_B_CCK11_A_CCK2_11, 0xffffff00, tmpval);
+	rtl8188e_PHY_SetBBReg(Adapter, rTxAGC_B_CCK11_A_CCK2_11, 0xffffff00, tmpval);
 
 	/*  rf-B cck tx power */
 	tmpval = TxAGC[RF_PATH_B] >> 24;
-	PHY_SetBBReg(Adapter, rTxAGC_B_CCK11_A_CCK2_11, bMaskByte0, tmpval);
+	rtl8188e_PHY_SetBBReg(Adapter, rTxAGC_B_CCK11_A_CCK2_11, bMaskByte0, tmpval);
 	tmpval = TxAGC[RF_PATH_B] & 0x00ffffff;
-	PHY_SetBBReg(Adapter, rTxAGC_B_CCK1_55_Mcs32, 0xffffff00, tmpval);
+	rtl8188e_PHY_SetBBReg(Adapter, rTxAGC_B_CCK1_55_Mcs32, 0xffffff00, tmpval);
 }	/* PHY_RF6052SetCckTxPower */
 
 /*  */
@@ -298,7 +298,7 @@ static void writeOFDMPowerReg88E(struct adapter *Adapter, u8 index, u32 *pValue)
 		else
 			regoffset = regoffset_b[index];
 
-		PHY_SetBBReg(Adapter, regoffset, bMaskDWord, writeVal);
+		rtl8188e_PHY_SetBBReg(Adapter, regoffset, bMaskDWord, writeVal);
 
 		/*  201005115 Joseph: Set Tx Power diff for Tx power training mechanism. */
 		if (regoffset == rTxAGC_A_Mcs07_Mcs04 || regoffset == rTxAGC_B_Mcs07_Mcs04) {
@@ -392,18 +392,18 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV);
 
 	/*----Set RF_ENV enable----*/
-	PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV << 16, 0x1);
+	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV << 16, 0x1);
 	udelay(1);/* PlatformStallExecution(1); */
 
 	/*----Set RF_ENV output high----*/
-	PHY_SetBBReg(Adapter, pPhyReg->rfintfo, bRFSI_RFENV, 0x1);
+	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rfintfo, bRFSI_RFENV, 0x1);
 	udelay(1);/* PlatformStallExecution(1); */
 
 	/* Set bit number of Address and Data for RF register */
-	PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireAddressLength, 0x0);	/*  Set 1 to 4 bits for 8255 */
+	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireAddressLength, 0x0);	/*  Set 1 to 4 bits for 8255 */
 	udelay(1);/* PlatformStallExecution(1); */
 
-	PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireDataLength, 0x0);	/*  Set 0 to 12  bits for 8255 */
+	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireDataLength, 0x0);	/*  Set 0 to 12  bits for 8255 */
 	udelay(1);/* PlatformStallExecution(1); */
 
 	/*----Initialize RF fom connfiguration file----*/
@@ -411,7 +411,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 		rtStatus = _FAIL;
 
 	/*----Restore RFENV control type----*/;
-	PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV, u4RegValue);
+	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV, u4RegValue);
 
 	if (rtStatus != _SUCCESS)
 		goto phy_RF6052_Config_ParaFile_Fail;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b53392161f09..f91fb5237a3b 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -558,8 +558,8 @@ static void _BeaconFunctionEnable(struct adapter *Adapter,
 /*  Set CCK and OFDM Block "ON" */
 static void _BBTurnOnBlock(struct adapter *Adapter)
 {
-	PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bCCKEn, 0x1);
-	PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
+	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bCCKEn, 0x1);
+	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
 }
 
 enum {
@@ -576,7 +576,7 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 	DBG_88E("==>  %s ....\n", __func__);
 
 	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0) | BIT(23));
-	PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
+	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
 
 	if (PHY_QueryBBReg(Adapter, rFPGA0_XA_RFInterfaceOE, 0x300) == Antenna_A)
 		haldata->CurAntenna = Antenna_A;
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index a60eb2e39684..30ede081ba47 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -136,7 +136,5 @@ void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
 
 #define PHY_QueryBBReg(adapt, regaddr, mask)			\
 	 rtl8188e_PHY_QueryBBReg((adapt), (regaddr), (mask))
-#define PHY_SetBBReg(adapt, regaddr, bitmask, data)		\
-	 rtl8188e_PHY_SetBBReg((adapt), (regaddr), (bitmask), (data))
 
 #endif	/*  __INC_HAL8192CPHYCFG_H */
-- 
2.34.1

