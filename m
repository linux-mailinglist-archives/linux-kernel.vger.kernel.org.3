Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48859583C41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiG1Koc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbiG1KoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277B75F11E;
        Thu, 28 Jul 2022 03:44:09 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEzoD+5TmctMCSrxk9wbDfLlwCS1qw1hOC4O/1ZnS4A=;
        b=C3A+kUdSyDRO4jv8fEw13U1P8vAik/5lBUZJ+0W0stJYLmpeANjMJIMBNND8xBlORgpTUH
        GZWPmJy0JsBG8zbZgUm9KAHSUCEWlnPuEcZsYJn2zq+xOXHiRfqyiqLpGqdF8xMigqf2y6
        qjjU/QnPHHm62pEP7XLA6E9Ps53kpp8RGFA4q45e2wqtQJVmouvckQF7tz3sazGo5OkZeH
        5L0cl/VnmnFCUSRwzum/WnlI6MsPRA5FkNrDjwbgJ2qbT3nwoHOLvIRKjNbaSG6OIXePqL
        De1aLtRd1HXh9cbW6tuoqTXr6BtoYvlNgtbMpYzoOsk0cwbn8inI84MLYYRK9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEzoD+5TmctMCSrxk9wbDfLlwCS1qw1hOC4O/1ZnS4A=;
        b=R+H3kAiEhwZpUNGomZYtL5S2HO+AOMdwIGEpac3LXfRqTqHhVFEKOvER7fSJD3bjTMridA
        afzq1BHpvitso4DQ==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Make timer
 selectable for ARCH_K3
Cc:     Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408101715.43697-3-tony@atomide.com>
References: <20220408101715.43697-3-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <165900504646.15455.3511169122209074781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567
Gitweb:        https://git.kernel.org/tip/ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 08 Apr 2022 13:17:14 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:00:48 +02:00

clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3

Let's make timer-ti-dm selectable for ARCH_K3, and add a separate option
for OMAP_DM_SYSTIMER as there should be no need for it on ARCH_K3.

For older TI SoCs, we are already selecting OMAP_DM_TIMER in
arch/arm/mach-omap*/Kconfig. For mach-omap2, we need to now also select
OMAP_DM_SYSTIMER.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20220408101715.43697-3-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/Kconfig  | 2 ++
 drivers/clocksource/Kconfig  | 8 +++++++-
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 02c253d..21e9928 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -105,6 +105,7 @@ config ARCH_OMAP2PLUS
 	select MACH_OMAP_GENERIC
 	select MEMORY
 	select MFD_SYSCON
+	select OMAP_DM_SYSTIMER
 	select OMAP_DM_TIMER
 	select OMAP_GPMC
 	select PINCTRL
@@ -160,6 +161,7 @@ config SOC_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP2
 	default y
+	select OMAP_DM_SYSTIMER
 	select OMAP_DM_TIMER
 	select SOC_HAS_OMAP2_SDRC
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 2dcdf02..967dcfb 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -22,7 +22,7 @@ config CLKEVT_I8253
 config I8253_LOCK
 	bool
 
-config OMAP_DM_TIMER
+config OMAP_DM_SYSTIMER
 	bool
 	select TIMER_OF
 
@@ -56,6 +56,12 @@ config DIGICOLOR_TIMER
 	help
 	  Enables the support for the digicolor timer driver.
 
+config OMAP_DM_TIMER
+	tristate "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
+	select TIMER_OF
+	help
+	  Enables the support for the TI dual-mode timer driver.
+
 config DW_APB_TIMER
 	bool "DW APB timer driver" if COMPILE_TEST
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 685430d..fadb5a8 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
-obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm-systimer.o
+obj-$(CONFIG_OMAP_DM_SYSTIMER)	+= timer-ti-dm-systimer.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
