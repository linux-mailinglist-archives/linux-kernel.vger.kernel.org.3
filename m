Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1624DBAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiCPWyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCPWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:54:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAEE1DA40
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:52:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d10so7153541eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9gCTWlc9p2G4Mf4tEdAge9wxpXHZ7B8VpsEVH/T2so=;
        b=UMwAkeqZVJIh/5hKCUjeTsWOPqTAbH/K7YrpyWna1gutUilxrY2/7iduvI7svjw8PP
         uLzxGFyRck4+jsBNIbE589EtFtC5PT19VJduymJcJDsVz6r9BLL1oQ+hTXRpc6jpCzAf
         0crOO0KIgM840B9UOSVTkzcWTkod8nnEK/0VCI2OErworV2TUrPE0npOsGEIH2C+pdJF
         oYjKaNtKYR9HGResMUM0wIoz+HxZAxhcDWBIzxuqSjveOmMF1F1LeoHFeCcAI7lC6L29
         abZTlQa048L6nNZeql2wBr6dsYd58Y2nsY6uWQtGFXk9KQ73fKf/ExrmuUiczuSRJl0k
         ivaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9gCTWlc9p2G4Mf4tEdAge9wxpXHZ7B8VpsEVH/T2so=;
        b=ovXgvuBLW3EPkgxilLsQFor0Gw72u/MhMqo4L1OopkBkOu+gBUyo7hFl0PlYM6PqAI
         LI8TIkTCnE4G137TA6OHxbFyw8QIJw7Y7AmS4JgaA8+vK6pq1VruTuCTWTpsTVr7JfVN
         nWIAmmBqr/L1uOL68gkAHljt3Jiwd/pdYLBY8A+fO/Vrn2INc5wuY0XwhAsPXkhYgAK4
         ME5oJtQWr4h9ti25S0oSYQBZ5xxBpEtUz7abqsPn8ayz+unocRNQw9jWa5TpcxkqZFPG
         y5eK4a9TIKRgbgeptUG/t4XHbc0a5CkldSZSgCGIOMjyq/HXVjngnNyunmIsWtvs3xZ1
         PUFg==
X-Gm-Message-State: AOAM531iKWoYGhv3sfge0Rf7RuNvlRoe78ovaPSBMPh04oVo0G8Q5FB2
        FvTiIJfVCgNY9L67VmDropM=
X-Google-Smtp-Source: ABdhPJwG8k2AQakxj1x52lpQ78SDqvtYBPscQ5njb53RQX3s5Z4nQSiDJF1p+E6Uk+IMMI9LQ6HewQ==
X-Received: by 2002:a17:906:7954:b0:6da:9ee0:2e54 with SMTP id l20-20020a170906795400b006da9ee02e54mr1914401ejo.630.1647471163128;
        Wed, 16 Mar 2022 15:52:43 -0700 (PDT)
Received: from linux-kernel-dev (159.137.141.34.bc.googleusercontent.com. [34.141.137.159])
        by smtp.gmail.com with ESMTPSA id bk1-20020a170906b0c100b006d47308d84dsm1494452ejb.33.2022.03.16.15.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:52:42 -0700 (PDT)
From:   Nam Cao <cvn249@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <cvn249@gmail.com>
Subject: [PATCH v2] staging: sm750fb: fix naming style
Date:   Wed, 16 Mar 2022 22:49:41 +0000
Message-Id: <20220316224940.70107-1-cvn249@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316202335.GB7346@nam-dell>
References: <20220316202335.GB7346@nam-dell>
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
reported by checkpatch.pl. Remove name suffixes such as pfn_ and g_.

Signed-off-by: Nam Cao <cvn249@gmail.com>
---
Changes in v2:
  - Remove name suffixes including pfn_, g_ and p_.
  - Typo: deskew_eetting -> deskew_setting

 drivers/staging/sm750fb/ddk750_dvi.c | 68 ++++++++++++++--------------
 drivers/staging/sm750fb/ddk750_dvi.h | 64 +++++++++++++-------------
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index cd564ea40779..029d9acec47d 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -11,50 +11,50 @@
  * function API. Please set the function pointer to NULL whenever the function
  * is not supported.
  */
-static struct dvi_ctrl_device g_dcftSupportedDviController[] = {
+static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #ifdef DVI_CTRL_SII164
 	{
-		.pfnInit = sii164InitChip,
-		.pfnGetVendorId = sii164GetVendorID,
-		.pfnGetDeviceId = sii164GetDeviceID,
+		.init = sii164InitChip,
+		.get_vendor_id = sii164GetVendorID,
+		.get_device_id = sii164GetDeviceID,
 #ifdef SII164_FULL_FUNCTIONS
-		.pfnResetChip = sii164ResetChip,
-		.pfnGetChipString = sii164GetChipString,
-		.pfnSetPower = sii164SetPower,
-		.pfnEnableHotPlugDetection = sii164EnableHotPlugDetection,
-		.pfnIsConnected = sii164IsConnected,
-		.pfnCheckInterrupt = sii164CheckInterrupt,
-		.pfnClearInterrupt = sii164ClearInterrupt,
+		.reset_chip = sii164ResetChip,
+		.get_chip_string = sii164GetChipString,
+		.set_power = sii164SetPower,
+		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
+		.is_connected = sii164IsConnected,
+		.check_interrupt = sii164CheckInterrupt,
+		.clear_interrupt = sii164ClearInterrupt,
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
+	struct dvi_ctrl_device *current_dvi_ctrl;
 
-	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if (pCurrentDviCtrl->pfnInit) {
-		return pCurrentDviCtrl->pfnInit(edge_select,
-						bus_select,
-						dual_edge_clk_select,
-						hsync_enable,
-						vsync_enable,
-						deskew_enable,
-						deskew_setting,
-						continuous_sync_enable,
-						pll_filter_enable,
-						pll_filter_value);
+	current_dvi_ctrl = dcft_supported_dvi_controller;
+	if (current_dvi_ctrl->init) {
+		return current_dvi_ctrl->init(edge_select,
+					      bus_select,
+					      dual_edge_clk_select,
+					      hsync_enable,
+					      vsync_enable,
+					      deskew_enable,
+					      deskew_setting,
+					      continuous_sync_enable,
+					      pll_filter_enable,
+					      pll_filter_value);
 	}
 	return -1; /* error */
 }
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 1c7a565b617a..c2518b73bdbd 100644
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
+				 unsigned char deskew_setting,
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
+	PFN_DVICTRL_INIT		init;
+	PFN_DVICTRL_RESETCHIP		reset_chip;
+	PFN_DVICTRL_GETCHIPSTRING	get_chip_string;
+	PFN_DVICTRL_GETVENDORID		get_vendor_id;
+	PFN_DVICTRL_GETDEVICEID		get_device_id;
+	PFN_DVICTRL_SETPOWER		set_power;
+	PFN_DVICTRL_HOTPLUGDETECTION	enable_hot_plug_detection;
+	PFN_DVICTRL_ISCONNECTED		is_connected;
+	PFN_DVICTRL_CHECKINTERRUPT	check_interrupt;
+	PFN_DVICTRL_CLEARINTERRUPT	clear_interrupt;
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

