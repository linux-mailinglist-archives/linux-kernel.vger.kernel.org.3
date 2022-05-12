Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7F52469E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiELHOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350809AbiELHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:14:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4706D4F6;
        Thu, 12 May 2022 00:14:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j25so4886728wrc.9;
        Thu, 12 May 2022 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJ3Xj5lGXvl+4KOAcBBgnH2tPCO84YLTSN3mD1uxeP0=;
        b=VHAAhkrM/8ODZpf8O/vCwz2St10UkOR9tmSW2ZFRfhnOasgqe3zrN05a30FSt15svI
         8avbDnFtOP7a/3JWAFTA0BuBZErzab1J/smAntKIE40n2Y9WWvLFNFR2tidTtH1mTCqQ
         oKKyNVU7NxoItgsBKjwDtKP7ZrA1t61aP20L8ZZBZpg/DtUstZPohRwUb0XGO/i0wGo6
         4t522vjlAh5qDJsOLjAD0BGHVmEzbQT57xRn/kGnHfmKn6NWeBavWD4cQtYbhfZOUT8R
         qafU0NqG6rc6OM4DNPHtLuUQXG/HRv+9GInzKX1xjIV0QZDvOZy7BxccHCoeM2u3Q5fk
         tGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJ3Xj5lGXvl+4KOAcBBgnH2tPCO84YLTSN3mD1uxeP0=;
        b=GReKRDMM++OCh4c2Ms6BwSlZTpWWvtPzLilDi/OXygmxSB7EfI/6XtPIfCbS7pVCxS
         lxkl6DoAtRlK1rI2FeijCo8QmcJVZG3BA2/y3F3rAzUYXuNO0L/wFWGHwYki9FM4SoQA
         LXHNLnHlShzeMtTC12lmRofes1LVYRlct4uytohtrKg7O8JswFK5yI+fueET+bf0Cq4j
         5TBEmfeLpzytGVks1iv4/8kv8ScjF4qjTWu16uXFD/PLD3CReG1TGQtfUMxttS5geBaD
         0+qkaC0OUK859e3Jhxs00lWSPdlSC8iJhBWTxakqZGOu+0jQupccB5BD6DiAlF2bEg+9
         kJlg==
X-Gm-Message-State: AOAM530rot6o6uuu+0co5CbpaPyBLPPYp2Nz1eZpCe6vtGyR6FSRouSY
        eyF5rkjCi/lwfKF5v2rYMSY=
X-Google-Smtp-Source: ABdhPJy4KIopMXde/ivo/ZcM7TdmP/zsZyxsZXMzrP7+d27FNJuqQDmoCchQe3kMjJkQ4FNRFPgxKg==
X-Received: by 2002:adf:e310:0:b0:20c:7894:99ad with SMTP id b16-20020adfe310000000b0020c789499admr26728306wrj.73.1652339662413;
        Thu, 12 May 2022 00:14:22 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5308000000b0020c5253d8c2sm3341446wrv.14.2022.05.12.00.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:14:22 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     andy.shevchenko@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH v3] drivers: gpio: zevio: drop of_gpio.h header
Date:   Thu, 12 May 2022 09:14:15 +0200
Message-Id: <20220512071415.2786-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511205959.10514-1-mosescb.dev@gmail.com>
References: <20220511205959.10514-1-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove of_gpio.h header file, replace of_* functions and structs
with appropriate alternatives.

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 V2 -> V3: Add missing return in front of dev_error_probe
 V1 -> V2: Move gpio_chip member to top of the struct
           Use dev_error_probe instead of dev_err
           Minor style fixes

 drivers/gpio/gpio-zevio.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index f6f8a541348f..ce9d1282165c 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -11,7 +11,6 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/gpio/driver.h>
 
@@ -53,22 +52,23 @@
 #define ZEVIO_GPIO_BIT(gpio) (gpio&7)
 
 struct zevio_gpio {
+	struct gpio_chip        chip;
 	spinlock_t		lock;
-	struct of_mm_gpio_chip	chip;
+	void __iomem		*regs;
 };
 
 static inline u32 zevio_gpio_port_get(struct zevio_gpio *c, unsigned pin,
 					unsigned port_offset)
 {
 	unsigned section_offset = ((pin >> 3) & 3)*ZEVIO_GPIO_SECTION_SIZE;
-	return readl(IOMEM(c->chip.regs + section_offset + port_offset));
+	return readl(IOMEM(c->regs + section_offset + port_offset));
 }
 
 static inline void zevio_gpio_port_set(struct zevio_gpio *c, unsigned pin,
 					unsigned port_offset, u32 val)
 {
 	unsigned section_offset = ((pin >> 3) & 3)*ZEVIO_GPIO_SECTION_SIZE;
-	writel(val, IOMEM(c->chip.regs + section_offset + port_offset));
+	writel(val, IOMEM(c->regs + section_offset + port_offset));
 }
 
 /* Functions for struct gpio_chip */
@@ -178,12 +178,15 @@ static int zevio_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, controller);
 
 	/* Copy our reference */
-	controller->chip.gc = zevio_gpio_chip;
-	controller->chip.gc.parent = &pdev->dev;
+	controller->chip = zevio_gpio_chip;
+	controller->chip.parent = &pdev->dev;
 
-	status = of_mm_gpiochip_add_data(pdev->dev.of_node,
-					 &(controller->chip),
-					 controller);
+	controller->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(controller->regs))
+		return dev_err_probe(&pdev->dev, PTR_ERR(controller->regs),
+				     "failed to ioremap memory resource\n");
+
+	status = devm_gpiochip_add_data(&pdev->dev, &controller->chip, controller);
 	if (status) {
 		dev_err(&pdev->dev, "failed to add gpiochip: %d\n", status);
 		return status;
@@ -192,10 +195,10 @@ static int zevio_gpio_probe(struct platform_device *pdev)
 	spin_lock_init(&controller->lock);
 
 	/* Disable interrupts, they only cause errors */
-	for (i = 0; i < controller->chip.gc.ngpio; i += 8)
+	for (i = 0; i < controller->chip.ngpio; i += 8)
 		zevio_gpio_port_set(controller, i, ZEVIO_GPIO_INT_MASK, 0xFF);
 
-	dev_dbg(controller->chip.gc.parent, "ZEVIO GPIO controller set up!\n");
+	dev_dbg(controller->chip.parent, "ZEVIO GPIO controller set up!\n");
 
 	return 0;
 }
-- 
2.30.2

