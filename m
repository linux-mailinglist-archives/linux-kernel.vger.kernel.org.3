Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619104EBAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbiC3G0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbiC3GZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:25:31 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A995522D5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:23:38 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 30 Mar
 2022 14:23:37 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 30 Mar
 2022 14:23:36 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: r8188eu: Fix misspelling in comment
Date:   Wed, 30 Mar 2022 14:23:33 +0800
Message-ID: <1648621413-1263-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typo in error message reported by checkpatch.pl

WARNING: 'cacluated' may be misspelled - perhaps 'calculated'?
WARNING: 'cacluated' may be misspelled - perhaps 'calculated'?
WARNING: 'writting' may be misspelled - perhaps 'writing'?
WARNING: 'defualt' may be misspelled - perhaps 'default'?
WARNING: 'Caculate' may be misspelled - perhaps 'Calculate'?
WARNING: 'accordign' may be misspelled - perhaps 'according'?
WARNING: 'regster' may be misspelled - perhaps 'register'?
WARNING: 'Wirte' may be misspelled - perhaps 'Write'?
WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?
WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?
WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?
WARNING: 'Tranceiver' may be misspelled - perhaps 'Transceiver'?

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c    |  2 +-
 drivers/staging/r8188eu/hal/odm_HWConfig.c      |  4 ++--
 drivers/staging/r8188eu/hal/odm_RTL8188E.c      |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c   | 12 ++++++------
 drivers/staging/r8188eu/hal/usb_halinit.c       |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index b944c80..310b6f5 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -69,7 +69,7 @@ void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM,
 /*-----------------------------------------------------------------------------
  * Function:	odm_TxPwrTrackSetPwr88E()
  *
- * Overview:	88E change all channel tx power accordign to flag.
+ * Overview:	88E change all channel tx power according to flag.
  *				OFDM & CCK are all different.
  *
  * Input:		NONE
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 87e9a52..1183e4a 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -71,7 +71,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		u8 cck_agc_rpt;
 
 		/*  (1)Hardware does not provide RSSI for CCK */
-		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
+		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
 
 		cck_highpwr = dm_odm->bCckHighPower;
 
@@ -170,7 +170,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			/* Get Rx snr value in DB */
 			dm_odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i] / 2);
 		}
-		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
+		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
 		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1) & 0x7f) - 110;
 
 		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index c8a3c52..dd9c829 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -194,7 +194,7 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		pEntry = dm_odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(pEntry)) {
-			/* 2 Caculate RSSI per Antenna */
+			/* 2 Calculate RSSI per Antenna */
 			Main_RSSI = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ? (dm_fat_tbl->MainAnt_Sum[i] / dm_fat_tbl->MainAnt_Cnt[i]) : 0;
 			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i] / dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
 			TargetAnt = (Main_RSSI >= Aux_RSSI) ? MAIN_ANT : AUX_ANT;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 6811be9..2658bac 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -327,7 +327,7 @@ void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState)
 	if (PwrState) {
 		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
 
-		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), defualt valid */
+		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), default valid */
 		tmpV16 = rtw_read16(pAdapter, REG_SYS_ISO_CTRL);
 		if (!(tmpV16 & PWC_EV12V)) {
 			tmpV16 |= PWC_EV12V;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index ea75ff1..3a7437c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -100,7 +100,7 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u3
 /**
 * Function:	phy_RFSerialRead
 *
-* OverView:	Read regster from RF chips
+* OverView:	Read register from RF chips
 *
 * Input:
 *			struct adapter *Adapter,
@@ -369,7 +369,7 @@ phy_InitBBRFRegisterDefinition(
 	/*  RF Interface (Output and)  Enable */
 	pHalData->PHYRegDef.rfintfe = rFPGA0_XA_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
 
-	/* Addr of LSSI. Wirte RF register by driver */
+	/* Addr of LSSI. Write RF register by driver */
 	pHalData->PHYRegDef.rf3wireOffset = rFPGA0_XA_LSSIParameter; /* LSSI Parameter */
 
 	/*  RF parameter */
@@ -378,10 +378,10 @@ phy_InitBBRFRegisterDefinition(
 	/*  Tx AGC Gain Stage (same for all path. Should we remove this?) */
 	pHalData->PHYRegDef.rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
 
-	/*  Tranceiver A~D HSSI Parameter-1 */
+	/*  Transceiver A~D HSSI Parameter-1 */
 	pHalData->PHYRegDef.rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;  /* wire control parameter1 */
 
-	/*  Tranceiver A~D HSSI Parameter-2 */
+	/*  Transceiver A~D HSSI Parameter-2 */
 	pHalData->PHYRegDef.rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
 
 	/*  RF switch Control */
@@ -405,10 +405,10 @@ phy_InitBBRFRegisterDefinition(
 	/*  Tx AFE control 2 */
 	pHalData->PHYRegDef.rfTxAFE = rOFDM0_XATxAFE;
 
-	/*  Tranceiver LSSI Readback SI mode */
+	/*  Transceiver LSSI Readback SI mode */
 	pHalData->PHYRegDef.rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
 
-	/*  Tranceiver LSSI Readback PI mode */
+	/*  Transceiver LSSI Readback PI mode */
 	pHalData->PHYRegDef.rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index a927743..e334c9b 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -123,7 +123,7 @@ static void _InitQueueReservedPage(struct adapter *Adapter)
 		if (haldata->OutEpQueueSel & TX_SELE_LQ)
 			numLQ = 0x1C;
 
-		/*  NOTE: This step shall be proceed before writting REG_RQPN. */
+		/*  NOTE: This step shall be proceed before writing REG_RQPN. */
 		if (haldata->OutEpQueueSel & TX_SELE_NQ)
 			numNQ = 0x1C;
 		value8 = (u8)_NPQ(numNQ);
-- 
2.7.4

