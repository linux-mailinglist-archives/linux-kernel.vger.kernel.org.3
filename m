Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97368542B44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiFHJS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiFHJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A77D11099F;
        Wed,  8 Jun 2022 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654677473; x=1686213473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SxzqUFLbDjsgliBmUQUwC7ztm+S2UVv9h6KqdGI813I=;
  b=VpVZJ0s3EK7cux8Hphg6viwkAaZJ1b2gwE08cts0JPe6M4x7zoWWqoZk
   c+304LxXSr+Zvyq1QslYsfG7nfMdgOLQDnbZDSXhAGp+lUaQP7QOrdNxB
   WrkDT1vsueUR0V4lXb9VATA21kezoEZWbHFZPWWn+VJEVO7rfr9v/v/YB
   kBLPrrkZFDwNshc01YnQZPUxNvvDnWy1n6tr0DC7NeLZYQClYWdB4pWo/
   DClSwIJXYLz8t3Zx+aAj93/+sBcNzXqnkvZYi2Gtlry9ljX2F6jCutxY1
   eseRwiu9v4D3eM5TtA/G1eAQn+HOG2p9jbIACxszWnmpg0dZRWSznmlfr
   A==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="99077620"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 01:37:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 01:37:50 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 01:37:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 5/9] power: reset: at91-reset: document structures and enums
Date:   Wed, 8 Jun 2022 11:39:38 +0300
Message-ID: <20220608083942.1584087-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
References: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.33.0

