Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76A3468C57
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhLERSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbhLERSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D88C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l25so33340042eda.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlfMnn529gdTTfsm/ZIC7TevJS6AMZNOLnNzWGrVZ4c=;
        b=YLgiOby/5MgJNmOzid37jJXmnArUbjipDyNhwWmbd3428NoND89Stt8wRyv+BONoUq
         Jl/ReNfgBEEOQNliIqaGlwE7BX95a7L+qEQvFLyVb3zCaFWz7mCW+GBZ48MLPEl610ZF
         2Pm4EepmUfvj9REDsD0qwHBJ99OjVtVUV7KxJCHfSiNMslXtCbIlbJA2HFcptQijscvn
         IgCzG3BOxl15/LV0sYMhi7WOBwQhHjreauEtoT4NGP0i/DArTSVDLCkdvz/83PX3YrPg
         TO3xExTPNVaDL3AUZz+4DyFpKqkL48pB7NMydsdTbm1lRFQYF0jhK2Aqfu9W0Gh+L4ot
         LYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlfMnn529gdTTfsm/ZIC7TevJS6AMZNOLnNzWGrVZ4c=;
        b=BxyeweoVVDMT4GuFc70fOLpLC5xaL+KqZ9GcK7pSvOaCM2g67/Z/Ipm5NLqXd/GHgw
         2PtjxjE64QBkOu/FNxqT7DEQ7cRfvgn8pNkXv4HYHtfXxScXLKMnmNOf4xhGSKlkd43v
         WATNX8M3JW6q3JWZqH5srBl7PqiXP+lXy7J8zOIeiaX75OPgWvhPH9Kwjxp6qYQfROTT
         BXP+ooQE/nQmwmTa4wKZ8BtibwGPmN7rU0KteYk3S8RPw2owEyjwFYSxZgMDDlMUTUVr
         1C1qYgN4aPkMVLIK7y/88dLDa1mxByhTsWAz0ffwnsv+plp2n0ZX3xolSxKCXC15ajoA
         sQaw==
X-Gm-Message-State: AOAM5314Xeut/+GsYgTVjpVIBxJoIDwH7RxAwpkDXuoFNJFOAqg3E34B
        2SIo975jRnHXKn5W/cdqx6U=
X-Google-Smtp-Source: ABdhPJxlCX/7YcQDvjK+/dp259k7gbmMgQQjYZUAo/R/byCJFDkpFdFehriERhb4dt5HIFRsaEbkNQ==
X-Received: by 2002:a50:955c:: with SMTP id v28mr47195232eda.293.1638724474063;
        Sun, 05 Dec 2021 09:14:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:33 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 01/10] staging: r8188eu: remove RF_PATH_{C,D}
Date:   Sun,  5 Dec 2021 18:13:33 +0100
Message-Id: <20211205171342.20551-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205171342.20551-1-straube.linux@gmail.com>
References: <20211205171342.20551-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pHalData->PHYRegDef[RF_PATH_C] and pHalData->PHYRegDef[RF_PATH_D]
are initialized but not used. Remove them and remove RF_PATH_C and
RF_PATH_D from the rf_radio_path enum.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 24 -------------------
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  2 --
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 3 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 73d5eb53a927..3d921767db91 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -392,14 +392,10 @@ phy_InitBBRFRegisterDefinition(
 	/*  RF Interface Sowrtware Control */
 	pHalData->PHYRegDef[RF_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 LSBs if read 32-bit from 0x870 */
 	pHalData->PHYRegDef[RF_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 MSBs if read 32-bit from 0x870 (16-bit for 0x872) */
-	pHalData->PHYRegDef[RF_PATH_C].rfintfs = rFPGA0_XCD_RFInterfaceSW;/*  16 LSBs if read 32-bit from 0x874 */
-	pHalData->PHYRegDef[RF_PATH_D].rfintfs = rFPGA0_XCD_RFInterfaceSW;/*  16 MSBs if read 32-bit from 0x874 (16-bit for 0x876) */
 
 	/*  RF Interface Readback Value */
 	pHalData->PHYRegDef[RF_PATH_A].rfintfi = rFPGA0_XAB_RFInterfaceRB; /*  16 LSBs if read 32-bit from 0x8E0 */
 	pHalData->PHYRegDef[RF_PATH_B].rfintfi = rFPGA0_XAB_RFInterfaceRB;/*  16 MSBs if read 32-bit from 0x8E0 (16-bit for 0x8E2) */
-	pHalData->PHYRegDef[RF_PATH_C].rfintfi = rFPGA0_XCD_RFInterfaceRB;/*  16 LSBs if read 32-bit from 0x8E4 */
-	pHalData->PHYRegDef[RF_PATH_D].rfintfi = rFPGA0_XCD_RFInterfaceRB;/*  16 MSBs if read 32-bit from 0x8E4 (16-bit for 0x8E6) */
 
 	/*  RF Interface Output (and Enable) */
 	pHalData->PHYRegDef[RF_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x860 */
@@ -416,14 +412,10 @@ phy_InitBBRFRegisterDefinition(
 	/*  RF parameter */
 	pHalData->PHYRegDef[RF_PATH_A].rfLSSI_Select = rFPGA0_XAB_RFParameter;  /* BB Band Select */
 	pHalData->PHYRegDef[RF_PATH_B].rfLSSI_Select = rFPGA0_XAB_RFParameter;
-	pHalData->PHYRegDef[RF_PATH_C].rfLSSI_Select = rFPGA0_XCD_RFParameter;
-	pHalData->PHYRegDef[RF_PATH_D].rfLSSI_Select = rFPGA0_XCD_RFParameter;
 
 	/*  Tx AGC Gain Stage (same for all path. Should we remove this?) */
 	pHalData->PHYRegDef[RF_PATH_A].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
 	pHalData->PHYRegDef[RF_PATH_B].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
-	pHalData->PHYRegDef[RF_PATH_C].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
-	pHalData->PHYRegDef[RF_PATH_D].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
 
 	/*  Tranceiver A~D HSSI Parameter-1 */
 	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;  /* wire control parameter1 */
@@ -436,50 +428,34 @@ phy_InitBBRFRegisterDefinition(
 	/*  RF switch Control */
 	pHalData->PHYRegDef[RF_PATH_A].rfSwitchControl = rFPGA0_XAB_SwitchControl; /* TR/Ant switch control */
 	pHalData->PHYRegDef[RF_PATH_B].rfSwitchControl = rFPGA0_XAB_SwitchControl;
-	pHalData->PHYRegDef[RF_PATH_C].rfSwitchControl = rFPGA0_XCD_SwitchControl;
-	pHalData->PHYRegDef[RF_PATH_D].rfSwitchControl = rFPGA0_XCD_SwitchControl;
 
 	/*  AGC control 1 */
 	pHalData->PHYRegDef[RF_PATH_A].rfAGCControl1 = rOFDM0_XAAGCCore1;
 	pHalData->PHYRegDef[RF_PATH_B].rfAGCControl1 = rOFDM0_XBAGCCore1;
-	pHalData->PHYRegDef[RF_PATH_C].rfAGCControl1 = rOFDM0_XCAGCCore1;
-	pHalData->PHYRegDef[RF_PATH_D].rfAGCControl1 = rOFDM0_XDAGCCore1;
 
 	/*  AGC control 2 */
 	pHalData->PHYRegDef[RF_PATH_A].rfAGCControl2 = rOFDM0_XAAGCCore2;
 	pHalData->PHYRegDef[RF_PATH_B].rfAGCControl2 = rOFDM0_XBAGCCore2;
-	pHalData->PHYRegDef[RF_PATH_C].rfAGCControl2 = rOFDM0_XCAGCCore2;
-	pHalData->PHYRegDef[RF_PATH_D].rfAGCControl2 = rOFDM0_XDAGCCore2;
 
 	/*  RX AFE control 1 */
 	pHalData->PHYRegDef[RF_PATH_A].rfRxIQImbalance = rOFDM0_XARxIQImbalance;
 	pHalData->PHYRegDef[RF_PATH_B].rfRxIQImbalance = rOFDM0_XBRxIQImbalance;
-	pHalData->PHYRegDef[RF_PATH_C].rfRxIQImbalance = rOFDM0_XCRxIQImbalance;
-	pHalData->PHYRegDef[RF_PATH_D].rfRxIQImbalance = rOFDM0_XDRxIQImbalance;
 
 	/*  RX AFE control 1 */
 	pHalData->PHYRegDef[RF_PATH_A].rfRxAFE = rOFDM0_XARxAFE;
 	pHalData->PHYRegDef[RF_PATH_B].rfRxAFE = rOFDM0_XBRxAFE;
-	pHalData->PHYRegDef[RF_PATH_C].rfRxAFE = rOFDM0_XCRxAFE;
-	pHalData->PHYRegDef[RF_PATH_D].rfRxAFE = rOFDM0_XDRxAFE;
 
 	/*  Tx AFE control 1 */
 	pHalData->PHYRegDef[RF_PATH_A].rfTxIQImbalance = rOFDM0_XATxIQImbalance;
 	pHalData->PHYRegDef[RF_PATH_B].rfTxIQImbalance = rOFDM0_XBTxIQImbalance;
-	pHalData->PHYRegDef[RF_PATH_C].rfTxIQImbalance = rOFDM0_XCTxIQImbalance;
-	pHalData->PHYRegDef[RF_PATH_D].rfTxIQImbalance = rOFDM0_XDTxIQImbalance;
 
 	/*  Tx AFE control 2 */
 	pHalData->PHYRegDef[RF_PATH_A].rfTxAFE = rOFDM0_XATxAFE;
 	pHalData->PHYRegDef[RF_PATH_B].rfTxAFE = rOFDM0_XBTxAFE;
-	pHalData->PHYRegDef[RF_PATH_C].rfTxAFE = rOFDM0_XCTxAFE;
-	pHalData->PHYRegDef[RF_PATH_D].rfTxAFE = rOFDM0_XDTxAFE;
 
 	/*  Tranceiver LSSI Readback SI mode */
 	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
 	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
-	pHalData->PHYRegDef[RF_PATH_C].rfLSSIReadBack = rFPGA0_XC_LSSIReadBack;
-	pHalData->PHYRegDef[RF_PATH_D].rfLSSIReadBack = rFPGA0_XD_LSSIReadBack;
 
 	/*  Tranceiver LSSI Readback PI mode */
 	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index b1ba7acb454c..6b108800d8d2 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -33,8 +33,6 @@ enum hw90_block {
 enum rf_radio_path {
 	RF_PATH_A = 0,			/* Radio Path A */
 	RF_PATH_B = 1,			/* Radio Path B */
-	RF_PATH_C = 2,			/* Radio Path C */
-	RF_PATH_D = 3,			/* Radio Path D */
 };
 
 #define MAX_PG_GROUP 13
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 0ebfcb732032..eaa4b24055d8 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -227,7 +227,7 @@ struct hal_data_8188e {
 
 	u32	AcParam_BE; /* Original parameter for BE, use for EDCA turbo. */
 
-	struct bb_reg_def PHYRegDef[4];	/* Radio A/B/C/D */
+	struct bb_reg_def PHYRegDef[2];	/* Radio A/B */
 
 	u32	RfRegChnlVal[2];
 
-- 
2.34.1

