Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5D466A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376700AbhLBT0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348556AbhLBT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:26:41 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC24C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:23:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so2276677edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4R0ZeKbHjG5MwX8cWjYywXrnBvMxq7qhakF+0r5+cc=;
        b=OSPpg2BAkOm3MdokDgk9fDjSwpR6bvQYhaZK+bDjcYbNLmf+jLlTspABICUfoh4q0Q
         CplNzAneBfr2Pk1F38LRGYmwMwBbyqVtaG5Frz5RnZ+xWxaRWI0AV12wBlJWIh3Ag6Q8
         zo/YmxYgbIq9YOWJaj+//D+Gr7RG3sMhr4Wej42keqzXD4cCllRbD5DVJ89DZ68bDWn4
         OA4YxGJAGCH0EqGnABJpDS6wHsvsj5VzrAvEVdbvgYaZHA7umGDwLH5OMkcjkVTPU+VU
         JQ/QMe7euEkgbUnMlfi5Pr5s5nm+g3/rY7F2uy9Q9cN3ZS4X69RTBikpyqumaqoTDZPX
         Vraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4R0ZeKbHjG5MwX8cWjYywXrnBvMxq7qhakF+0r5+cc=;
        b=QWXRE4Ey8ilDNUSnqZmDkUnSn/foqC0N90RSDeiVQFF8EAJkYC2drMHjB3C+hMStbb
         MeD0W/Z4FdQ4mYs60XuT+wCblvCClJOZH89z6l7tLg8px85ZRnE79u9BqAkgbuJRdNZS
         ks8zqfW4EM+LrKKU3t3MKtFXVbMO0yRhPrDwAF2daeJsrqwYK/EKbzyKIwvYL+02Qp2h
         q6bHy4dIPFLPEQ5bZz2+rxQ/Gi3TdQnX8VprUi1IeG8Dmk7DDrNwmtbYGghmYmbB8/WM
         MgOigRCZTchZaUFS05NRkNkZr4USqTd9u1Lfgx2xA5ApSfsEgAV7ZG5aDYWKkGkLSnRY
         /X/w==
X-Gm-Message-State: AOAM533SPZtars6QRinqfu64zKAZaEs23RJEFj4DR8MS+gCriQT4BR98
        HRXY23f0kLGgJMpOS/uCqqk=
X-Google-Smtp-Source: ABdhPJy4QPlyW6K6b1ZQiK63VH/6B1SQoSuM2XZR18/uFxEG1woY6PVicOaMMRjK1/tm1g0B1WOPvw==
X-Received: by 2002:a05:6402:5208:: with SMTP id s8mr19932523edd.394.1638472997394;
        Thu, 02 Dec 2021 11:23:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id jg36sm432530ejc.44.2021.12.02.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:23:17 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: remove unused variables from odm_dm_struct
Date:   Thu,  2 Dec 2021 20:23:05 +0100
Message-Id: <20211202192309.9362-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202192309.9362-1-straube.linux@gmail.com>
References: <20211202192309.9362-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many unused variables in the odm_dm_struct structure.
Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 63 +--------------------------
 1 file changed, 2 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index f08655208b32..2f99d267d25c 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -4,12 +4,6 @@
 #ifndef	__HALDMOUTSRC_H__
 #define __HALDMOUTSRC_H__
 
-/*  Add for AP/ADSLpseudo DM structuer requirement. */
-/*  We need to remove to other position??? */
-struct rtl8192cd_priv {
-	u8		temp;
-};
-
 struct rtw_dig {
 	u8		Dig_Enable_Flag;
 	u8		Dig_Ext_Port_Stage;
@@ -459,13 +453,7 @@ enum ant_div_type {
 
 /* Copy from SD4 defined structure. We use to support PHY DM integration. */
 struct odm_dm_struct {
-	/* 	Add for different team use temporarily */
 	struct adapter *Adapter;	/*  For CE/NIC team */
-	struct rtl8192cd_priv *priv;	/*  For AP/ADSL team */
-	/*  WHen you use above pointers, they must be initialized. */
-	bool	odm_ready;
-
-	struct rtl8192cd_priv *fake_priv;
 
 /*  ODM HANDLE, DRIVER NEEDS NOT TO HOOK------ */
 	bool	bCckHighPower;
@@ -485,11 +473,6 @@ struct odm_dm_struct {
 
 	/*  Dynamic Value */
 /*  POINTER REFERENCE----------- */
-
-	u8	u8_temp;
-	bool	bool_temp;
-	struct adapter *adapter_temp;
-
 	/* TX Unicast byte count */
 	u64	*pNumTxBytesUnicast;
 	/* RX Unicast byte count */
@@ -504,18 +487,11 @@ struct odm_dm_struct {
 	u8	*pBandWidth;
 	/*  Central channel location Ch1/Ch2/.... */
 	u8	*pChannel;	/* central channel number */
-	/*  Common info for 92D DMSP */
 
-	bool	*pbGetValueFromOtherMac;
-	struct adapter **pBuddyAdapter;
-	bool	*pbMasterOfDMSP; /* MAC0: master, MAC1: slave */
 	/*  Common info for Status */
 	bool	*pbScanInProcess;
 	bool	*pbPowerSaving;
-	/*  CCA Path 2-path/path-A/path-B = 0/1/2; using ODM_CCA_PATH_E. */
-	u8	*pOnePathCCA;
-	/* pMgntInfo->AntennaTest */
-	u8	*pAntennaTest;
+
 	bool	*pbNet_closed;
 /*  POINTER REFERENCE----------- */
 	/*  */
@@ -524,16 +500,8 @@ struct odm_dm_struct {
 	bool	bWIFI_Display;
 	bool	bLinked;
 	u8	RSSI_Min;
-	u8	InterfaceIndex; /*  Add for 92D  dual MAC: 0--Mac0 1--Mac1 */
 	bool	bIsMPChip;
 	bool	bOneEntryOnly;
-	/*  Common info for BTDM */
-	bool	bBtDisabled;	/*  BT is disabled */
-	bool	bBtHsOperation;	/*  BT HS mode is under progress */
-	u8	btHsDigVal;	/*  use BT rssi to decide the DIG value */
-	bool	bBtDisableEdcaTurbo;/* Under some condition, don't enable the
-				     * EDCA Turbo */
-	bool	bBtBusy;			/*  BT is busy. */
 /* CALL BY VALUE------------- */
 
 	/* 2 Define STA info. */
@@ -549,38 +517,18 @@ struct odm_dm_struct {
 	/*  Latest packet phy info (ODM write) */
 	struct odm_phy_dbg_info PhyDbgInfo;
 
-	/*  Latest packet phy info (ODM write) */
-	struct odm_mac_status_info *pMacInfo;
-
-	/*  Different Team independt structure?? */
-
 	/* ODM Structure */
 	struct fast_ant_train DM_FatTable;
 	struct rtw_dig	DM_DigTable;
 	struct rtl_ps	DM_PSTable;
 	struct dyn_primary_cca DM_PriCCA;
-	struct rx_hpc	DM_RXHP_Table;
 	struct false_alarm_stats FalseAlmCnt;
-	struct false_alarm_stats FlaseAlmCntBuddyAdapter;
 	struct sw_ant_switch DM_SWAT_Table;
 	bool		RSSI_test;
 
 	struct edca_turbo DM_EDCA_Table;
-	u32		WMMEDCA_BE;
-	/*  Copy from SD4 structure */
-	/*  */
-	/*  ================================================== */
-	/*  */
-
-	bool	*pbDriverStopped;
-	bool	*pbDriverIsGoingToPnpSetPowerSleep;
-	bool	*pinit_adpt_in_progress;
 
 	/* PSD */
-	bool	bUserAssignLevel;
-	struct timer_list PSDTimer;
-	u8	RSSI_BT;			/* come from BT */
-	bool	bPSDinProcess;
 	bool	bDMInitialGainEnable;
 
 	struct odm_rate_adapt RateAdaptive;
@@ -596,14 +544,7 @@ struct odm_dm_struct {
 	u8	BbSwingIdxCckCurrent;
 	u8	BbSwingIdxCckBase;
 	bool	BbSwingFlagCck;
-	/*  ODM system resource. */
-
-	/*  ODM relative time. */
-	struct timer_list PathDivSwitchTimer;
-	/* 2011.09.27 add for Path Diversity */
-	struct timer_list CCKPathDiversityTimer;
-	struct timer_list FastAntTrainingTimer;
-};		/*  DM_Dynamic_Mechanism_Structure */
+};
 
 enum odm_bb_config_type {
     CONFIG_BB_PHY_REG,
-- 
2.34.0

