Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6BA522490
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347659AbiEJTQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiEJTP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:15:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C025A5A8;
        Tue, 10 May 2022 12:15:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q23so3464wra.1;
        Tue, 10 May 2022 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ICALjRuls1YJWj64GMq9mPFxN7+vbqjUy39n5o5tGc=;
        b=OrqzS6TNg8//lIUxE0r0DVe0hHdXi7HQFETI/GLvn1XA8S4MBD6qQq5VK/YwGv+rdp
         ELOlnp1tPyrbmzORWNqTutolK50Je2TXQ4XcU4yeS5LozVzdjOWKfgDfevsTzF23lxno
         TomNdGdifXQyFtVe38apK700eFtEDz32l4u54BR3QYSvzPI+pGdS4anjbdeY2GBVJio0
         3jAT5AY2n/FWHXErnL0TXAKt4jhp0sCcFUIQMt5sHtoa8Us5aKlojwSWw+mvChxQuDVG
         03tOmHVU+0cMSDSsUItVAWH5VOjGISPkRk+rIXZkwNJ7Ly9wemAeGH+d7nPIxK3y4v8M
         okFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ICALjRuls1YJWj64GMq9mPFxN7+vbqjUy39n5o5tGc=;
        b=IfYK5zDn2Cg9EhKRzUJug7DdjX4YO0OsyUMr3vuD1Z1tVGKXVn6w+ws/o8rhLWTMJT
         2goJ/9M3KTuhKdP93B963C4tOqHasr99TlEFTwmmSzBLkq3/JtAiwjU8qLCNneikY0mN
         gazZHDqumtDN/yuPbb35qJ/+zApYmZTGL1cIdA09o0yecWBOkzFJBARBjorBExE19Pik
         ZVrvmEdPPnYEgJsXr48hpo33zKX55cCOV7xfzXT+XGPydyEFOJym7wBHeqbzl0AaIDY6
         W7DexcVT7o3wWGjgCXIIXv6jJC/nZO6Ie9g6vECzRNd/XUrnHROdiJH1BgnR4/lJsRYn
         eSCw==
X-Gm-Message-State: AOAM530KjOvwJZY+WFpukdD5SsoY/Lv9vADRYbZ/Fd5aVbKK7w8Abzf1
        LtpdFq73BsHl2qsi7wGItt8=
X-Google-Smtp-Source: ABdhPJyo6pgt1kPLanz24n85hX79oTHKCx+Tykgx8nAdERBeN1v9VIBkW+RLqaKn1D8P2ea9Nnm4HQ==
X-Received: by 2002:a5d:584a:0:b0:20c:5a8b:cee7 with SMTP id i10-20020a5d584a000000b0020c5a8bcee7mr19596063wrf.111.1652210156293;
        Tue, 10 May 2022 12:15:56 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc349000000b003942a244ee9sm7212wmj.46.2022.05.10.12.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:15:55 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH] drivers: gpio: zevio: drop of_gpio.h header
Date:   Tue, 10 May 2022 21:15:49 +0200
Message-Id: <20220510191549.76105-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
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

remove of_gpio.h header file, replace of_* functions and structs
with appropriate alternatives

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/gpio/gpio-zevio.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index f6f8a541348f..ec774fefb0ff 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -11,7 +11,6 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/gpio/driver.h>
 
@@ -54,21 +53,22 @@
 
 struct zevio_gpio {
 	spinlock_t		lock;
-	struct of_mm_gpio_chip	chip;
+	struct gpio_chip	chip;
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
@@ -178,12 +178,18 @@ static int zevio_gpio_probe(struct platform_device *pdev)
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
+	if (IS_ERR(controller->regs)) {
+		dev_err(&pdev->dev, "failed to ioremap memory resource\n");
+		return PTR_ERR(controller->regs);
+	}
+
+	status = devm_gpiochip_add_data(&pdev->dev,
+					&(controller->chip),
+					controller);
 	if (status) {
 		dev_err(&pdev->dev, "failed to add gpiochip: %d\n", status);
 		return status;
@@ -192,10 +198,10 @@ static int zevio_gpio_probe(struct platform_device *pdev)
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

