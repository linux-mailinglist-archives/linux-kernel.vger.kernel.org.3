Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0003F4F7719
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiDGHST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiDGHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E851480F4;
        Thu,  7 Apr 2022 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315716; x=1680851716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JTDMVVeRAftI6o86ZjLgMdKfDtLtM/8TSv3TYrBRguw=;
  b=ukR3b7DYTqPAMZBrMoUhyTycA9Sw6aEzq9OJ9vrxndBtvhuj/HwMWyQt
   Aj+6MzTTpRBOORzpAlw2TyKbQYU6QAn7YtV4lKwBLVWm9rn68yjIuPfvh
   mPHrBLEKvdi4wa2Y9uP5shLbZhhZiQBaaL9tTRQ+FbQP8horu07lFXrmi
   StgeFTLkSSoUGLPCK+mA9wOBxsoCtFVih95/4qZkd1MpDV1kEfhnZTrPK
   Ft0MX/+jYn1aD7OnMy6pvK5VQJYtsQktG1cM5XC8UfyFI4qrTIu4Hq97G
   zZLlIzZ+4irGg+ME7U9ky7tELgcIISqloPo8uY4jhUTr94+/0QVnaGaGR
   w==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="159679140"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 05/10] power: reset: at91-reset: document structures and enums
Date:   Thu, 7 Apr 2022 10:17:03 +0300
Message-ID: <20220407071708.3848812-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document structures and enums.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 64def79d557a..e62798750b6b 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -39,6 +39,17 @@
 #define AT91_RSTC_URSTIEN	BIT(4)		/* User Reset Interrupt Enable */
 #define AT91_RSTC_ERSTL		GENMASK(11, 8)	/* External Reset Length */
 
+/**
+ * enum reset_type - reset types
+ * @RESET_TYPE_GENERAL:		first power-up reset
+ * @RESET_TYPE_WAKEUP:		return from backup mode
+ * @RESET_TYPE_WATCHDOG:	watchdog fault
+ * @RESET_TYPE_SOFTWARE:	processor reset required by software
+ * @RESET_TYPE_USER:		NRST pin detected low
+ * @RESET_TYPE_CPU_FAIL:	CPU clock failure detection
+ * @RESET_TYPE_XTAL_FAIL:	32KHz crystal failure dectection fault
+ * @RESET_TYPE_ULP2:		ULP2 reset
+ */
 enum reset_type {
 	RESET_TYPE_GENERAL	= 0,
 	RESET_TYPE_WAKEUP	= 1,
@@ -50,6 +61,15 @@ enum reset_type {
 	RESET_TYPE_ULP2		= 8,
 };
 
+/**
+ * struct at91_reset - AT91 reset specific data structure
+ * @rstc_base:		base address for system reset
+ * @ramc_base:		array with base addresses of RAM controllers
+ * @sclk:		slow clock
+ * @nb:			reset notifier block
+ * @args:		SoC specific system reset arguments
+ * @ramc_lpr:		SDRAM Controller Low Power Register
+ */
 struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
-- 
2.32.0

