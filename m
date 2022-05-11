Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ABC523F26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347898AbiEKVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiEKVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:00:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8007620793F;
        Wed, 11 May 2022 14:00:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m62so1891286wme.5;
        Wed, 11 May 2022 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/B/M4tIxRatBEyQAwPt25sEr/ww0FZHY/sBLJQaKxc=;
        b=Y0cIM+hnK2MMKCzepZ+JcunI2/zFpNNJzm2YvUtTVEsxyJx7SmHJ2YZQvuhgAsW0ei
         nZYsZlS8gd7ZgHA1AP1dwOGj43AHF/j0KZYSHqDXXBrxjz5xoQuCq0QQl+PozoXNsSR8
         neP4Qvf6IGTWIUgRnCH+7v5SjVNDBf2ysUXEFDcUUpFhaybeNuWH8xYnwe0wGy9ymNea
         gUyjiO++UHqSgQ0O2ou1YuhM9NsxOupLeE0z3jrhQAZSq03isSUcqHBNtn5DDkhOacw4
         jdrdfkHY+ChmMeuToVpSUue+o3qDD7uBiosUemlvczzc93N28sA3ZnB9E4SFPh9lMS4A
         Xb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/B/M4tIxRatBEyQAwPt25sEr/ww0FZHY/sBLJQaKxc=;
        b=qdEGl/CcPKUKFwOvv9e/CisCigJdm5NEhtNV6gP1SCdUeuLbEG66ge/x+lEa58FQqI
         35Os4hK1jrz17YNB4Hntz+h1g2iWuOde4/enVLslZ4GISpMqRWFC8N0/bF0uPOP6LpR3
         xbf9n8upyrzDBuSQEDYFjHlCOWECqYBXv/MfXodR8oS1Ia5ZE45fh/FsezMMD3YcpIBi
         ASr0eH1z0xjtAqolsnDzTbkEd0hFt4PZs9vUIdnsdGkEji5FEh8FIif9pqMUZonwZ76r
         uovfcxG4y4IOmeWcDhsz8vGtuwHTSVQOcHGuM8p2oTpIWVEHipYG99UuFcgZXOpZKphz
         Bc4Q==
X-Gm-Message-State: AOAM530oRDtFJkIAYwXhzTFW3PDsCKI5U2dbksFwnTwsPiLjOt937Q6b
        GYMBtvZ6OlEWr1388xJ2DT4=
X-Google-Smtp-Source: ABdhPJy5XlTZsj92F5I+X1bRTRlHVEtJ6DlL/QiNImntUEiI5UMyeY/obe3r/hauqWyuJKkX1mf55g==
X-Received: by 2002:a1c:cc16:0:b0:394:61e1:94f with SMTP id h22-20020a1ccc16000000b0039461e1094fmr6691418wmb.38.1652302818946;
        Wed, 11 May 2022 14:00:18 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bc8d0000000b003949dbc3790sm770224wml.18.2022.05.11.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:00:18 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     andy.shevchenko@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH v2] drivers: gpio: zevio: drop of_gpio.h header
Date:   Wed, 11 May 2022 22:59:59 +0200
Message-Id: <20220511205959.10514-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510191549.76105-1-mosescb.dev@gmail.com>
References: <20220510191549.76105-1-mosescb.dev@gmail.com>
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
 V1 -> V2: Move gpio_chip member to top of the struct
           Use dev_error_probe instead of dev_err
           Minor style fixes
 drivers/gpio/gpio-zevio.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index f6f8a541348f..df22f79e8210 100644
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
+		dev_err_probe(&pdev->dev, PTR_ERR(controller->regs),
+			      "failed to ioremap memory resource\n");
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

