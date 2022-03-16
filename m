Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B138E4DAEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355352AbiCPLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355347AbiCPLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:33:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFC22B12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:32:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so2300152edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z7CaZbPZq6SD/rCd0CoB4w0F/gmxReGr5y5LNnIrfJA=;
        b=ciG/P8FospDjh7j/kzW33HVBu4cdpoi0wvIjT/4H374Tly3GU4LxHEb58blRweP47u
         t/WUDBcYcEMl7U7KPueulvfrKxlGe+DOd4UiXb1tkqF1LTIxjbz2mThfzO9ZNAx3385p
         4qgS2oWiS3jkopukEFIkhyDxk/K0yWQPMbE8mMdpIdiblvXAIk0DSlHdj7MvPQcbMBp8
         jEtnf7flN1V6TrtDiCKrWB+G8ci2woWrmdNtn/R9zoSAe/aEwzgELtb5OtihwmNHJFXA
         JW+5lAvNwNH9yMjea2urhM8B5eGxwn1lwD1Nnao+CNh1ortit3secADqp+u9M67cPbuq
         b24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z7CaZbPZq6SD/rCd0CoB4w0F/gmxReGr5y5LNnIrfJA=;
        b=bSGhHollhq2VXCkHv7Ejy+36GxxDYZ+IpIydzLMqjyGHCP5VEB0lo0cwgbHXFakxAE
         JeMA5ZcJkMW3DjAAVe/w0+BSuF52fyNGSc++5UerG6mZUvxPPOSDDRTeF7j4uxF6GULY
         oECpnCmOUoo9q6cnFxhvWahLkjEQHRbPLbZr0zzeOzNVW0Iz5DIQacgJL/8igRjh96kl
         9+e69BmbN45HWndj/TKemNCT0uQldoreWr96Ef6svhmT11hpeN6273w3/YzqgAm+xr3p
         FRfbuJ3d9n/LykBa2oPsmbjaykKko4yhbtgfHrbZus12EcBt5DD3loW2WE8fgdePtCy0
         m7Vw==
X-Gm-Message-State: AOAM533ukYVfhRB9KUWO8yPibGp8wmOSjqYy4DL0s2YoVJX3KsFRdMiK
        2q/q8yATTsElpjVnTF/GOY8=
X-Google-Smtp-Source: ABdhPJw96HMi7nbtr37WQFoY5q2QudPxkplZro/AHEMYSj96fUpHMgZu6m9RBss4WHj432Jc24D5hQ==
X-Received: by 2002:a05:6402:909:b0:416:6f3c:5c1d with SMTP id g9-20020a056402090900b004166f3c5c1dmr29251163edz.108.1647430350270;
        Wed, 16 Mar 2022 04:32:30 -0700 (PDT)
Received: from linux-kernel-dev (159.137.141.34.bc.googleusercontent.com. [34.141.137.159])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm841209edb.47.2022.03.16.04.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 04:32:29 -0700 (PDT)
From:   Nam Cao <cvn249@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <cvn249@gmail.com>
Subject: [PATCH] staging: sm750fb: fix CamelCase naming style
Date:   Wed, 16 Mar 2022 11:32:28 +0000
Message-Id: <20220316113228.21243-1-cvn249@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CamelCase names defined in ddk750_dvi.c and ddk750_dvi.h, as
reported by checkpatch.pl.

Signed-off-by: Nam Cao <cvn249@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c | 50 +++++++++++-----------
 drivers/staging/sm750fb/ddk750_dvi.h | 64 ++++++++++++++--------------
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index cd564ea40779..48f40dcc5ffd 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -11,41 +11,41 @@
  * function API. Please set the function pointer to NULL whenever the function
  * is not supported.
  */
-static struct dvi_ctrl_device g_dcftSupportedDviController[] = {
+static struct dvi_ctrl_device g_dcft_supported_dvi_controller[] = {
 #ifdef DVI_CTRL_SII164
 	{
-		.pfnInit = sii164InitChip,
-		.pfnGetVendorId = sii164GetVendorID,
-		.pfnGetDeviceId = sii164GetDeviceID,
+		.pfn_init = sii164InitChip,
+		.pfn_get_vendor_id = sii164GetVendorID,
+		.pfn_get_device_id = sii164GetDeviceID,
 #ifdef SII164_FULL_FUNCTIONS
-		.pfnResetChip = sii164ResetChip,
-		.pfnGetChipString = sii164GetChipString,
-		.pfnSetPower = sii164SetPower,
-		.pfnEnableHotPlugDetection = sii164EnableHotPlugDetection,
-		.pfnIsConnected = sii164IsConnected,
-		.pfnCheckInterrupt = sii164CheckInterrupt,
-		.pfnClearInterrupt = sii164ClearInterrupt,
+		.pfn_reset_chip = sii164ResetChip,
+		.pfn_get_chip_string = sii164GetChipString,
+		.pfn_set_power = sii164SetPower,
+		.pfn_enable_hot_plug_detection = sii164EnableHotPlugDetection,
+		.pfn_is_connected = sii164IsConnected,
+		.pfn_check_interrupt = sii164CheckInterrupt,
+		.pfn_clear_interrupt = sii164ClearInterrupt,
 #endif
 	},
 #endif
 };
 
-int dviInit(unsigned char edge_select,
-	    unsigned char bus_select,
-	    unsigned char dual_edge_clk_select,
-	    unsigned char hsync_enable,
-	    unsigned char vsync_enable,
-	    unsigned char deskew_enable,
-	    unsigned char deskew_setting,
-	    unsigned char continuous_sync_enable,
-	    unsigned char pll_filter_enable,
-	    unsigned char pll_filter_value)
+int dvi_init(unsigned char edge_select,
+	     unsigned char bus_select,
+	     unsigned char dual_edge_clk_select,
+	     unsigned char hsync_enable,
+	     unsigned char vsync_enable,
+	     unsigned char deskew_enable,
+	     unsigned char deskew_setting,
+	     unsigned char continuous_sync_enable,
+	     unsigned char pll_filter_enable,
+	     unsigned char pll_filter_value)
 {
-	struct dvi_ctrl_device *pCurrentDviCtrl;
+	struct dvi_ctrl_device *p_current_dvi_ctrl;
 
-	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if (pCurrentDviCtrl->pfnInit) {
-		return pCurrentDviCtrl->pfnInit(edge_select,
+	p_current_dvi_ctrl = g_dcft_supported_dvi_controller;
+	if (p_current_dvi_ctrl->pfn_init) {
+		return p_current_dvi_ctrl->pfn_init(edge_select,
 						bus_select,
 						dual_edge_clk_select,
 						hsync_enable,
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 1c7a565b617a..ab00f8621375 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -4,54 +4,54 @@
 
 /* dvi chip stuffs structros */
 
-typedef long (*PFN_DVICTRL_INIT)(unsigned char edgeSelect,
-				 unsigned char busSelect,
-				 unsigned char dualEdgeClkSelect,
-				 unsigned char hsyncEnable,
-				 unsigned char vsyncEnable,
-				 unsigned char deskewEnable,
-				 unsigned char deskewSetting,
-				 unsigned char continuousSyncEnable,
-				 unsigned char pllFilterEnable,
-				 unsigned char pllFilterValue);
+typedef long (*PFN_DVICTRL_INIT)(unsigned char edge_select,
+				 unsigned char bus_select,
+				 unsigned char dual_edge_clk_select,
+				 unsigned char hsync_enable,
+				 unsigned char vsync_enable,
+				 unsigned char deskew_enable,
+				 unsigned char deskew_eetting,
+				 unsigned char continuous_sync_enable,
+				 unsigned char pll_filter_enable,
+				 unsigned char pll_filter_value);
 
 typedef void (*PFN_DVICTRL_RESETCHIP)(void);
 typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
 typedef unsigned short (*PFN_DVICTRL_GETVENDORID)(void);
 typedef unsigned short (*PFN_DVICTRL_GETDEVICEID)(void);
-typedef void (*PFN_DVICTRL_SETPOWER)(unsigned char powerUp);
-typedef void (*PFN_DVICTRL_HOTPLUGDETECTION)(unsigned char enableHotPlug);
+typedef void (*PFN_DVICTRL_SETPOWER)(unsigned char power_up);
+typedef void (*PFN_DVICTRL_HOTPLUGDETECTION)(unsigned char enable_hot_plug);
 typedef unsigned char (*PFN_DVICTRL_ISCONNECTED)(void);
 typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
 typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
 
 /* Structure to hold all the function pointer to the DVI Controller. */
 struct dvi_ctrl_device {
-	PFN_DVICTRL_INIT		pfnInit;
-	PFN_DVICTRL_RESETCHIP		pfnResetChip;
-	PFN_DVICTRL_GETCHIPSTRING	pfnGetChipString;
-	PFN_DVICTRL_GETVENDORID		pfnGetVendorId;
-	PFN_DVICTRL_GETDEVICEID		pfnGetDeviceId;
-	PFN_DVICTRL_SETPOWER		pfnSetPower;
-	PFN_DVICTRL_HOTPLUGDETECTION	pfnEnableHotPlugDetection;
-	PFN_DVICTRL_ISCONNECTED		pfnIsConnected;
-	PFN_DVICTRL_CHECKINTERRUPT	pfnCheckInterrupt;
-	PFN_DVICTRL_CLEARINTERRUPT	pfnClearInterrupt;
+	PFN_DVICTRL_INIT		pfn_init;
+	PFN_DVICTRL_RESETCHIP		pfn_reset_chip;
+	PFN_DVICTRL_GETCHIPSTRING	pfn_get_chip_string;
+	PFN_DVICTRL_GETVENDORID		pfn_get_vendor_id;
+	PFN_DVICTRL_GETDEVICEID		pfn_get_device_id;
+	PFN_DVICTRL_SETPOWER		pfn_set_power;
+	PFN_DVICTRL_HOTPLUGDETECTION	pfn_enable_hot_plug_detection;
+	PFN_DVICTRL_ISCONNECTED		pfn_is_connected;
+	PFN_DVICTRL_CHECKINTERRUPT	pfn_check_interrupt;
+	PFN_DVICTRL_CLEARINTERRUPT	pfn_clear_interrupt;
 };
 
 #define DVI_CTRL_SII164
 
 /* dvi functions prototype */
-int dviInit(unsigned char edgeSelect,
-	    unsigned char busSelect,
-	    unsigned char dualEdgeClkSelect,
-	    unsigned char hsyncEnable,
-	    unsigned char vsyncEnable,
-	    unsigned char deskewEnable,
-	    unsigned char deskewSetting,
-	    unsigned char continuousSyncEnable,
-	    unsigned char pllFilterEnable,
-	    unsigned char pllFilterValue);
+int dvi_init(unsigned char edge_select,
+	     unsigned char bus_select,
+	     unsigned char dual_edge_clk_select,
+	     unsigned char hsync_enable,
+	     unsigned char vsync_enable,
+	     unsigned char deskew_enable,
+	     unsigned char deskew_setting,
+	     unsigned char continuous_sync_enable,
+	     unsigned char pll_filter_enable,
+	     unsigned char pll_filter_value);
 
 #endif
 
-- 
2.32.0

