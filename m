Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385A3535BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349825AbiE0IhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349760AbiE0IgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:36:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D27FC4E4;
        Fri, 27 May 2022 01:36:05 -0700 (PDT)
Date:   Fri, 27 May 2022 08:36:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOni+2/IoIaXMZb6nIzmEqO27a9XN4/c9d4nbu/NBrQ=;
        b=a0uEXmpuCJS7X+++jWTsevIGwpNcH0W/Z7lZBNG9YIPfsJT6xkSAQX03XRz4gVFhUHbANC
        KJBYn4Rw1xmGZeJUEzqCriKZQKi48QMETyHF1XLjTM6ctE+Yq9kOGKAtB0TxQHXFkkziGZ
        oYdjfL+oVg1FCebtUCoJ2+wc2NBTWcu5BIXd2+/gSd1GwD0x6I8Bl2mUSAm3UcHfCKOtqs
        FYtne073XXYzyEfHqu8VG2ziCH6Rhlz0i6EX+FcdghKkGVtIJ3Wukw08TmS/jAqBNgUD5t
        kg3r8yptZXP3XuJPhDfJza8jYX8G88rpPfGAshLtnakfWEDTAcDAksgM+m69CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOni+2/IoIaXMZb6nIzmEqO27a9XN4/c9d4nbu/NBrQ=;
        b=At1cUkZWcoeOfB0fzj9PbIgR0ARIVHGb8/qrj8kLlDCARZwsV9NpqZTf0WSGxByvhlaOCz
        3gKmvAGwh9UhZVCQ==
From:   "tip-bot2 for Linus Walleij" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ixp4xx: Drop boardfile probe path
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220406205505.2332821-1-linus.walleij@linaro.org>
References: <20220406205505.2332821-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Message-ID: <165364056300.4207.6906932063029611142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     41929c9f628b9990d33a200c54bb0c919e089aa8
Gitweb:        https://git.kernel.org/tip/41929c9f628b9990d33a200c54bb0c919e089aa8
Author:        Linus Walleij <linus.walleij@linaro.org>
AuthorDate:    Wed, 06 Apr 2022 22:55:05 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:52 +02:00

clocksource/drivers/ixp4xx: Drop boardfile probe path

The boardfiles for IXP4xx have been deleted. Delete all the
quirks and code dealing with that boot path and rely solely on
device tree boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220406205505.2332821-1-linus.walleij@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig                |  2 +-
 drivers/clocksource/timer-ixp4xx.c         | 25 +---------------------
 include/linux/platform_data/timer-ixp4xx.h | 11 +---------
 3 files changed, 1 insertion(+), 37 deletions(-)
 delete mode 100644 include/linux/platform_data/timer-ixp4xx.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1589ae7..8182ff2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -80,7 +80,7 @@ config IXP4XX_TIMER
 	bool "Intel XScale IXP4xx timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select CLKSRC_MMIO
-	select TIMER_OF if OF
+	select TIMER_OF
 	help
 	  Enables support for the Intel XScale IXP4xx SoC timer.
 
diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-ixp4xx.c
index cbb1849..720ed70 100644
--- a/drivers/clocksource/timer-ixp4xx.c
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -19,8 +19,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
-/* Goes away with OF conversion */
-#include <linux/platform_data/timer-ixp4xx.h>
 
 /*
  * Constants to make it easy to access Timer Control/Status registers
@@ -263,28 +261,6 @@ static struct platform_driver ixp4xx_timer_driver = {
 };
 builtin_platform_driver(ixp4xx_timer_driver);
 
-/**
- * ixp4xx_timer_setup() - Timer setup function to be called from boardfiles
- * @timerbase: physical base of timer block
- * @timer_irq: Linux IRQ number for the timer
- * @timer_freq: Fixed frequency of the timer
- */
-void __init ixp4xx_timer_setup(resource_size_t timerbase,
-			       int timer_irq,
-			       unsigned int timer_freq)
-{
-	void __iomem *base;
-
-	base = ioremap(timerbase, 0x100);
-	if (!base) {
-		pr_crit("IXP4xx: can't remap timer\n");
-		return;
-	}
-	ixp4xx_timer_register(base, timer_irq, timer_freq);
-}
-EXPORT_SYMBOL_GPL(ixp4xx_timer_setup);
-
-#ifdef CONFIG_OF
 static __init int ixp4xx_of_timer_init(struct device_node *np)
 {
 	void __iomem *base;
@@ -315,4 +291,3 @@ out_unmap:
 	return ret;
 }
 TIMER_OF_DECLARE(ixp4xx, "intel,ixp4xx-timer", ixp4xx_of_timer_init);
-#endif
diff --git a/include/linux/platform_data/timer-ixp4xx.h b/include/linux/platform_data/timer-ixp4xx.h
deleted file mode 100644
index ee92ae7..0000000
--- a/include/linux/platform_data/timer-ixp4xx.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TIMER_IXP4XX_H
-#define __TIMER_IXP4XX_H
-
-#include <linux/ioport.h>
-
-void __init ixp4xx_timer_setup(resource_size_t timerbase,
-			       int timer_irq,
-			       unsigned int timer_freq);
-
-#endif
