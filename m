Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFB5A7F56
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiHaNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiHaNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:54:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9787D5E84;
        Wed, 31 Aug 2022 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661954066; x=1693490066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KY6bpmQ3eJvu6vH+Ew2QhhCbPYbB0XbDG0reDpNS9rg=;
  b=c4eXZwk9Zr6iFua9RD05QYNSfj5wxzAL5AHBZZ6GMh/3X+AQz6MiFAZe
   xJtv0jvsjlhE6rPrzR+GWVQvOVjPGy+X4o3ZaQGzU4jnmh1dJTz11h13z
   hyKUxRLIQ4xj+yYvR7omVzo5liPXobH+TVpJqMC3hX9iDXYXHtgXKqjN3
   LUnhQk0f0PI2WXbtCR+o0mqC/9tFyoFaqTZgJHfpRh09ulqbzzHIb+9BP
   6YOjTtFARBg09Qem48Y2xGgNGXiVZ3pGMM3cGE2VhzP3cBvYcteiqQsjj
   /FTqO0aO3efoqcsNX9Qa24gDCJfjotGMXjv4qt01Gs8RVv6ANsdk81Vcl
   A==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="111574440"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 06:54:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 06:54:24 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 06:54:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] pinctrl: at91: use kernel-doc style for documentation of at91_gpio_chip
Date:   Wed, 31 Aug 2022 16:56:34 +0300
Message-ID: <20220831135636.3176406-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
References: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kernel-doc style for documentation of struct at91_gpio_chip.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5634fa063ebf..0b78fd48fd02 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -33,16 +33,28 @@
 
 struct at91_pinctrl_mux_ops;
 
+/**
+ * struct at91_gpio_chip: at91 gpio chip
+ * @chip: gpio chip
+ * @range: gpio range
+ * @next: bank sharing same clock
+ * @pioc_hwirq: PIO bank interrupt identifier on AIC
+ * @pioc_virq: PIO bank Linux virtual interrupt
+ * @pioc_idx: PIO bank index
+ * @regbase: PIO bank virtual address
+ * @clock: associated clock
+ * @ops: at91 pinctrl mux ops
+ */
 struct at91_gpio_chip {
 	struct gpio_chip	chip;
 	struct pinctrl_gpio_range range;
-	struct at91_gpio_chip	*next;		/* Bank sharing same clock */
-	int			pioc_hwirq;	/* PIO bank interrupt identifier on AIC */
-	int			pioc_virq;	/* PIO bank Linux virtual interrupt */
-	int			pioc_idx;	/* PIO bank index */
-	void __iomem		*regbase;	/* PIO bank virtual address */
-	struct clk		*clock;		/* associated clock */
-	const struct at91_pinctrl_mux_ops *ops;	/* ops */
+	struct at91_gpio_chip	*next;
+	int			pioc_hwirq;
+	int			pioc_virq;
+	int			pioc_idx;
+	void __iomem		*regbase;
+	struct clk		*clock;
+	const struct at91_pinctrl_mux_ops *ops;
 };
 
 static struct at91_gpio_chip *gpio_chips[MAX_GPIO_BANKS];
-- 
2.34.1

