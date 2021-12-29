Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DCC4816C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhL2Uvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhL2Uvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D359C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so46677611wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7MbMMyPr87vEUHPRPtFi8HsJB5tWhgRE5CZBsQSl7Ek=;
        b=l9w3/BCj9mlW04MuglqpKOIeqlFCs9IAd0HeM16Kcsq1DYOM/FHyTLLuYbZOELyy/S
         uDoDh4TOvDjl+QFyLBw2q2WOyAnMLsuM0CR6MtdcNeg8eEwcMrKpB8JAPosijXnQ8UU1
         zO5CyRyZ4R8k7sdrF/NtsThhneCyTqrQmVLtpnoIgFVc5CS4W33xP1c/vVlBHX6SpxHq
         DQ5ZzymojM9SGkf/7yXzp4T64KhHuGvb4cYR4yib0DvLXBnjgUkVXOe+UTp/Nlv4aedL
         mjk1PUGxQMHEV3UEazWQk8MueUuKslVc6hzYug6wkP2GzSoO5NOg9Yu+NV8T8fLlsYbE
         PK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7MbMMyPr87vEUHPRPtFi8HsJB5tWhgRE5CZBsQSl7Ek=;
        b=G5fR0XIoDXXMYnPQ/kGGgX2EQOVdf3R5wCDL7zlv77+nCSaSuaM2HaGViPlymFjMYT
         QxvcLfdcYG5EyFTA7ar8r3ab1mzbfE6808VO6UAZEuAhFFqmJCb9nWYQaugfgcaxcVNn
         NIGmqvU429Eakpo5uNySh5sa4RQ9aHtM7GsSrRl7QCq0bdiz2cZcsxnn42BRcrRESMS9
         qERCz0YLiFzJCFDnvrVblXHOwK2wfXJP82M3TI5XgDb90osoB/PNMsFuzWnT7tpnDA0E
         yM3ORchKMu53CmtCnJVbgqGA8MSA6rwCNOlDe3vYaCBmwTZaEvR/1EA6bz5UxJI7FxwN
         NkmA==
X-Gm-Message-State: AOAM532zJdrKZbtgV6wd8XV+aLctqDVJee+NrvrirkR/VaUYRn3K+v/+
        KM6XDO7ZJJv1PM1URJOfGFnOvRwJpg0=
X-Google-Smtp-Source: ABdhPJxH0vuoISegHLKuP3sL20+eQOmNNkwAQOvtviSX+jmza5j06HEuMH6ppZEKFj1uTLsJzwjlHg==
X-Received: by 2002:a5d:4dcd:: with SMTP id f13mr21684941wru.432.1640811089977;
        Wed, 29 Dec 2021 12:51:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:29 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/32] staging: r8188eu: remove ODM_GetBBReg()
Date:   Wed, 29 Dec 2021 21:50:41 +0100
Message-Id: <20211229205108.26373-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_GetBBReg() is just a wrapper around rtl8188e_PHY_QueryBBReg().
Remove ODM_GetBBReg() and call rtl8188e_PHY_QueryBBReg() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 40 +++++++++----------
 drivers/staging/r8188eu/hal/odm.c             | 35 +++++++++-------
 drivers/staging/r8188eu/hal/odm_interface.c   |  6 ---
 .../staging/r8188eu/include/odm_interface.h   |  2 -
 4 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 8eec8ea95162..5f28ed3b9231 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -146,7 +146,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 	if (ThermalValue) {
 		/* Query OFDM path A default setting */
-		ele_D = ODM_GetBBReg(dm_odm, rOFDM0_XATxIQImbalance, bMaskDWord) & bMaskOFDM_D;
+		ele_D = rtl8188e_PHY_QueryBBReg(Adapter, rOFDM0_XATxIQImbalance, bMaskDWord) & bMaskOFDM_D;
 		for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
 			if (ele_D == (OFDMSwingTable[i] & bMaskOFDM_D)) {
 				OFDM_index_old[0] = (u8)i;
@@ -157,7 +157,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 		/* Query OFDM path B default setting */
 		if (is2t) {
-			ele_D = ODM_GetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord) & bMaskOFDM_D;
+			ele_D = rtl8188e_PHY_QueryBBReg(Adapter, rOFDM0_XBTxIQImbalance, bMaskDWord) & bMaskOFDM_D;
 			for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
 				if (ele_D == (OFDMSwingTable[i] & bMaskOFDM_D)) {
 					OFDM_index_old[1] = (u8)i;
@@ -387,9 +387,9 @@ phy_PathA_IQK_8188E(struct adapter *adapt)
 	ODM_delay_ms(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
-	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
-	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
-	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
+	regeac = rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_After_IQK_A_2, bMaskDWord);
+	regE94 = rtl8188e_PHY_QueryBBReg(adapt, rTx_Power_Before_IQK_A, bMaskDWord);
+	regE9C = rtl8188e_PHY_QueryBBReg(adapt, rTx_Power_After_IQK_A, bMaskDWord);
 
 	if (!(regeac & BIT(28)) &&
 	    (((regE94 & 0x03FF0000) >> 16) != 0x142) &&
@@ -441,9 +441,9 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	ODM_delay_ms(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
-	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
-	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
-	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
+	regeac = rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_After_IQK_A_2, bMaskDWord);
+	regE94 = rtl8188e_PHY_QueryBBReg(adapt, rTx_Power_Before_IQK_A, bMaskDWord);
+	regE9C = rtl8188e_PHY_QueryBBReg(adapt, rTx_Power_After_IQK_A, bMaskDWord);
 
 	if (!(regeac & BIT(28)) &&
 	    (((regE94 & 0x03FF0000) >> 16) != 0x142) &&
@@ -485,10 +485,10 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	ODM_delay_ms(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
-	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
-	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
-	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
-	regEA4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord);
+	regeac = rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_After_IQK_A_2, bMaskDWord);
+	regE94 = rtl8188e_PHY_QueryBBReg(adapt, rTx_Power_Before_IQK_A, bMaskDWord);
+	regE9C = rtl8188e_PHY_QueryBBReg(adapt, rTx_Power_After_IQK_A, bMaskDWord);
+	regEA4 = rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_Before_IQK_A_2, bMaskDWord);
 
 	/* reload RF 0xdf */
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
@@ -512,7 +512,7 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 	if (final_candidate == 0xFF) {
 		return;
 	} else if (iqkok) {
-		Oldval_0 = (ODM_GetBBReg(dm_odm, rOFDM0_XATxIQImbalance, bMaskDWord) >> 22) & 0x3FF;
+		Oldval_0 = (rtl8188e_PHY_QueryBBReg(adapt, rOFDM0_XATxIQImbalance, bMaskDWord) >> 22) & 0x3FF;
 
 		X = result[final_candidate][0];
 		if ((X & 0x00000200) != 0)
@@ -549,11 +549,9 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 void _PHY_SaveADDARegisters(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegisterNum)
 {
 	u32 i;
-	struct hal_data_8188e *pHalData = &adapt->haldata;
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	for (i = 0; i < RegisterNum; i++) {
-		ADDABackup[i] = ODM_GetBBReg(dm_odm, ADDAReg[i], bMaskDWord);
+		ADDABackup[i] = rtl8188e_PHY_QueryBBReg(adapt, ADDAReg[i], bMaskDWord);
 	}
 }
 
@@ -760,7 +758,7 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 
 	_PHY_PathADDAOn(adapt, ADDA_REG);
 	if (t == 0)
-		dm_odm->RFCalibrateInfo.bRfPiEnable = (u8)ODM_GetBBReg(dm_odm, rFPGA0_XA_HSSIParameter1, BIT(8));
+		dm_odm->RFCalibrateInfo.bRfPiEnable = (u8)rtl8188e_PHY_QueryBBReg(adapt, rFPGA0_XA_HSSIParameter1, BIT(8));
 
 	if (!dm_odm->RFCalibrateInfo.bRfPiEnable) {
 		/*  Switch BB to PI mode to do IQ Calibration. */
@@ -794,8 +792,8 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 	for (i = 0; i < retryCount; i++) {
 		PathAOK = phy_PathA_IQK_8188E(adapt);
 		if (PathAOK == 0x01) {
-			result[t][0] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord) & 0x3FF0000) >> 16;
-			result[t][1] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord) & 0x3FF0000) >> 16;
+			result[t][0] = (rtl8188e_PHY_QueryBBReg(adapt, rTx_Power_Before_IQK_A, bMaskDWord) & 0x3FF0000) >> 16;
+			result[t][1] = (rtl8188e_PHY_QueryBBReg(adapt, rTx_Power_After_IQK_A, bMaskDWord) & 0x3FF0000) >> 16;
 			break;
 		}
 	}
@@ -803,8 +801,8 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 	for (i = 0; i < retryCount; i++) {
 		PathAOK = phy_PathA_RxIQK(adapt);
 		if (PathAOK == 0x03) {
-			result[t][2] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord) & 0x3FF0000) >> 16;
-			result[t][3] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord) & 0x3FF0000) >> 16;
+			result[t][2] = (rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_Before_IQK_A_2, bMaskDWord) & 0x3FF0000) >> 16;
+			result[t][3] = (rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_After_IQK_A_2, bMaskDWord) & 0x3FF0000) >> 16;
 			break;
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index b1bb81c97c5c..9329ba9057ac 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -267,8 +267,10 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 
 void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
 {
-	pDM_Odm->bCckHighPower = (bool)ODM_GetBBReg(pDM_Odm, 0x824, BIT(9));
-	pDM_Odm->RFPathRxEnable = (u8)ODM_GetBBReg(pDM_Odm, 0xc04, 0x0F);
+	struct adapter *adapter = pDM_Odm->Adapter;
+
+	pDM_Odm->bCckHighPower = (bool)rtl8188e_PHY_QueryBBReg(adapter, 0x824, BIT(9));
+	pDM_Odm->RFPathRxEnable = (u8)rtl8188e_PHY_QueryBBReg(adapter, 0xc04, 0x0F);
 }
 
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
@@ -310,8 +312,9 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
+	struct adapter *adapter = pDM_Odm->Adapter;
 
-	pDM_DigTable->CurIGValue = (u8)ODM_GetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N);
+	pDM_DigTable->CurIGValue = (u8)rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N);
 	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
 	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
 	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
@@ -475,6 +478,7 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 {
 	u32 ret_value;
 	struct false_alarm_stats *FalseAlmCnt = &pDM_Odm->FalseAlmCnt;
+	struct adapter *adapter = pDM_Odm->Adapter;
 
 	if (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))
 		return;
@@ -483,23 +487,23 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 	ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 1); /* hold page C counter */
 	ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 1); /* hold page D counter */
 
-	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE1_11N, bMaskDWord);
+	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_OFDM_FA_TYPE1_11N, bMaskDWord);
 	FalseAlmCnt->Cnt_Fast_Fsync = (ret_value & 0xffff);
 	FalseAlmCnt->Cnt_SB_Search_fail = ((ret_value & 0xffff0000) >> 16);
-	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE2_11N, bMaskDWord);
+	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_OFDM_FA_TYPE2_11N, bMaskDWord);
 	FalseAlmCnt->Cnt_OFDM_CCA = (ret_value & 0xffff);
 	FalseAlmCnt->Cnt_Parity_Fail = ((ret_value & 0xffff0000) >> 16);
-	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE3_11N, bMaskDWord);
+	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_OFDM_FA_TYPE3_11N, bMaskDWord);
 	FalseAlmCnt->Cnt_Rate_Illegal = (ret_value & 0xffff);
 	FalseAlmCnt->Cnt_Crc8_fail = ((ret_value & 0xffff0000) >> 16);
-	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE4_11N, bMaskDWord);
+	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_OFDM_FA_TYPE4_11N, bMaskDWord);
 	FalseAlmCnt->Cnt_Mcs_fail = (ret_value & 0xffff);
 
 	FalseAlmCnt->Cnt_Ofdm_fail = FalseAlmCnt->Cnt_Parity_Fail + FalseAlmCnt->Cnt_Rate_Illegal +
 				     FalseAlmCnt->Cnt_Crc8_fail + FalseAlmCnt->Cnt_Mcs_fail +
 				     FalseAlmCnt->Cnt_Fast_Fsync + FalseAlmCnt->Cnt_SB_Search_fail;
 
-	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_SC_CNT_11N, bMaskDWord);
+	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_SC_CNT_11N, bMaskDWord);
 	FalseAlmCnt->Cnt_BW_LSC = (ret_value & 0xffff);
 	FalseAlmCnt->Cnt_BW_USC = ((ret_value & 0xffff0000) >> 16);
 
@@ -507,12 +511,12 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 	ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(12), 1);
 	ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(14), 1);
 
-	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_LSB_11N, bMaskByte0);
+	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_CCK_FA_LSB_11N, bMaskByte0);
 	FalseAlmCnt->Cnt_Cck_fail = ret_value;
-	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_MSB_11N, bMaskByte3);
+	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_CCK_FA_MSB_11N, bMaskByte3);
 	FalseAlmCnt->Cnt_Cck_fail +=  (ret_value & 0xff) << 8;
 
-	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_CCA_CNT_11N, bMaskDWord);
+	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_CCK_CCA_CNT_11N, bMaskDWord);
 	FalseAlmCnt->Cnt_CCK_CCA = ((ret_value & 0xFF) << 8) | ((ret_value & 0xFF00) >> 8);
 
 	FalseAlmCnt->Cnt_all = (FalseAlmCnt->Cnt_Fast_Fsync +
@@ -582,14 +586,15 @@ void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm)
 void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 {
 	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
+	struct adapter *adapter = pDM_Odm->Adapter;
 	u8 Rssi_Up_bound = 30;
 	u8 Rssi_Low_bound = 25;
 
 	if (pDM_PSTable->initialize == 0) {
-		pDM_PSTable->reg_874 = (ODM_GetBBReg(pDM_Odm, 0x874, bMaskDWord) & 0x1CC000) >> 14;
-		pDM_PSTable->reg_c70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord) & BIT(3)) >> 3;
-		pDM_PSTable->reg_85c = (ODM_GetBBReg(pDM_Odm, 0x85c, bMaskDWord) & 0xFF000000) >> 24;
-		pDM_PSTable->reg_a74 = (ODM_GetBBReg(pDM_Odm, 0xa74, bMaskDWord) & 0xF000) >> 12;
+		pDM_PSTable->reg_874 = (rtl8188e_PHY_QueryBBReg(adapter, 0x874, bMaskDWord) & 0x1CC000) >> 14;
+		pDM_PSTable->reg_c70 = (rtl8188e_PHY_QueryBBReg(adapter, 0xc70, bMaskDWord) & BIT(3)) >> 3;
+		pDM_PSTable->reg_85c = (rtl8188e_PHY_QueryBBReg(adapter, 0x85c, bMaskDWord) & 0xFF000000) >> 24;
+		pDM_PSTable->reg_a74 = (rtl8188e_PHY_QueryBBReg(adapter, 0xa74, bMaskDWord) & 0xF000) >> 12;
 		pDM_PSTable->initialize = 1;
 	}
 
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 42d6485758c0..90c5f02660d2 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -10,12 +10,6 @@ void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 D
 	rtl8188e_PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
 }
 
-u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtl8188e_PHY_QueryBBReg(Adapter, RegAddr, BitMask);
-}
-
 /*  ODM Memory relative API. */
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
 {
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 29bf5ae468da..a013ef44f3c4 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -15,8 +15,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
 		  u32 BitMask, u32 Data);
 
-u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask);
-
 /*  Memory Relative Function. */
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
-- 
2.34.1

