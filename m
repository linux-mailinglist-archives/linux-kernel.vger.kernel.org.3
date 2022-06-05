Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B953DB04
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350963AbiFEJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350932AbiFEJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:31:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920304D9C6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:30:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sXNMyeL/sTIayyNuq58IwS7BKMZDzVrYopDXMHiXVfg=;
        b=nU+hMi1AW5x9oUdBKQodQtaTA0lNqs1r9PM3ujWrL3EprqAhCsWuon4MoJfWRLk/EVofty
        1FH2gbhfdspPNHP2b9/49Q1lZJSbGOeGUSvoxK8QSJhtewbrhf0xptlyv3Fwt25Ug7/F0X
        f2q1768kPqMel+u+UYyYj/uk1vZpV7dBiBiQV+pPnS4AXjy0RBAiCFZlvOxzon5qtgRQBo
        R8cnRgw7x+4u+uwEkxMsJsO2hm/lWIFf6shjyobrlYSOz5tYp3syXURrvlmUB5kPpTo3Og
        rvOqPG0Gmeq5Vx4wa3h7s5bsrMT/x+FQ+KcGPxa045vdERTJyeDBE1hbSlE+TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sXNMyeL/sTIayyNuq58IwS7BKMZDzVrYopDXMHiXVfg=;
        b=nzSRO1jp9CVGxSzme8BILYJpSMUT+eB3olLY8rlCsG8PIc30LKkQMiyOKGtV4EEwrbBfqC
        YCp7cnewn/rpUsBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442137546.152751.10369547750282619841.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:30:56 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022=
-06-05

up to:  57963a92a70b: Merge tag 'timers-v5.19-rc1' of https://git.linaro.org/=
people/daniel.lezcano/linux into timers/core


Clockevent/clocksource updates:

   - Device tree bindings for MT8186

   - Tell the kernel that the RISC-V SBI timer stops in deeper power states

   - Make device tree parsing in sp804 more robust

   - Dead code removal and tiny fixes here and there

   - Add the missing SPDX identifiers


Thanks,

	tglx

------------------>
Allen-KH Cheng (1):
      dt-bindings: timer: Add compatible for Mediatek MT8186

Andre Przywara (1):
      clocksource/drivers/sp804: Avoid error on multiple instances

Dan Carpenter (1):
      clocksource/drivers/timer-ti-dm: Remove unnecessary NULL check

Krzysztof Kozlowski (1):
      clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value

Linus Walleij (1):
      clocksource/drivers/ixp4xx: Drop boardfile probe path

Samuel Holland (1):
      clocksource/drivers/riscv: Events are stopped during CPU suspend

Thomas Gleixner (10):
      clocksource/drivers/bcm_kona: Convert to SPDX identifier
      clocksource/drivers/jcore: Convert to SPDX identifier
      clocksource/drivers/mips-gic-timer: Convert to SPDX identifier
      clocksource/drivers/armada-370-xp: Convert to SPDX identifier
      clocksource/drivers/digicolor: Convert to SPDX identifier
      clocksource/drivers/lpc32xx: Convert to SPDX identifier
      clocksource/drivers/orion: Convert to SPDX identifier
      clocksource/drivers/pistachio: Convert to SPDX identifier
      clocksource/drivers/timer-sun4i: Convert to SPDX identifier
      clocksource/drivers/timer-sun5i: Convert to SPDX identifier


 .../bindings/timer/mediatek,mtk-timer.txt          |  1 +
 drivers/clocksource/Kconfig                        |  2 +-
 drivers/clocksource/bcm_kona_timer.c               | 14 ++----------
 drivers/clocksource/jcore-pit.c                    |  5 +----
 drivers/clocksource/mips-gic-timer.c               |  9 ++------
 drivers/clocksource/timer-armada-370-xp.c          |  5 +----
 drivers/clocksource/timer-digicolor.c              |  5 +----
 drivers/clocksource/timer-ixp4xx.c                 | 25 --------------------=
--
 drivers/clocksource/timer-lpc32xx.c                |  6 +-----
 drivers/clocksource/timer-orion.c                  |  5 +----
 drivers/clocksource/timer-oxnas-rps.c              |  2 +-
 drivers/clocksource/timer-pistachio.c              |  5 +----
 drivers/clocksource/timer-riscv.c                  |  2 +-
 drivers/clocksource/timer-sp804.c                  | 10 ++++-----
 drivers/clocksource/timer-sun4i.c                  |  5 +----
 drivers/clocksource/timer-sun5i.c                  |  5 +----
 drivers/clocksource/timer-ti-dm.c                  |  3 +--
 include/linux/platform_data/timer-ixp4xx.h         | 11 ----------
 18 files changed, 22 insertions(+), 98 deletions(-)
 delete mode 100644 include/linux/platform_data/timer-ixp4xx.h

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b=
/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index fbd76a8e023b..6f1f9dba6e88 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -23,6 +23,7 @@ Required properties:
=20
 	For those SoCs that use SYST
 	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
+	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
 	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
 	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1589ae7d5abb..8182ff2d12fe 100644
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
=20
diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_k=
ona_timer.c
index a50ab5c2154f..39f172d7e29e 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (C) 2012 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 Broadcom Corporation
=20
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index 5d3d88e0fc8c..a4a991101fa3 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * J-Core SoC PIT/clocksource driver
  *
  * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/kernel.h>
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-=
gic-timer.c
index be4175f415ba..b3ae38f36720 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -1,10 +1,5 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
=20
 #define pr_fmt(fmt) "mips-gic-timer: " fmt
=20
diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/=
timer-armada-370-xp.c
index e3acc3c631b7..6ec565d6939a 100644
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada 370/XP SoC timer handling.
  *
@@ -7,10 +8,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * Timer 0 is used as free-running clocksource, while timer 1 is
  * used as clock_event_device.
  *
diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/time=
r-digicolor.c
index 1e984a4d8ad0..559aa96089c3 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Conexant Digicolor timer driver
  *
@@ -11,10 +12,6 @@
  * Copyright (C) 2013 Maxime Ripard
  *
  * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
=20
 /*
diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-i=
xp4xx.c
index cbb184953510..720ed70a2964 100644
--- a/drivers/clocksource/timer-ixp4xx.c
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -19,8 +19,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
-/* Goes away with OF conversion */
-#include <linux/platform_data/timer-ixp4xx.h>
=20
 /*
  * Constants to make it easy to access Timer Control/Status registers
@@ -263,28 +261,6 @@ static struct platform_driver ixp4xx_timer_driver =3D {
 };
 builtin_platform_driver(ixp4xx_timer_driver);
=20
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
-	base =3D ioremap(timerbase, 0x100);
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
@@ -315,4 +291,3 @@ static __init int ixp4xx_of_timer_init(struct device_node=
 *np)
 	return ret;
 }
 TIMER_OF_DECLARE(ixp4xx, "intel,ixp4xx-timer", ixp4xx_of_timer_init);
-#endif
diff --git a/drivers/clocksource/timer-lpc32xx.c b/drivers/clocksource/timer-=
lpc32xx.c
index d51a62a79ef7..68eae6378bf3 100644
--- a/drivers/clocksource/timer-lpc32xx.c
+++ b/drivers/clocksource/timer-lpc32xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Clocksource driver for NXP LPC32xx/18xx/43xx timer
  *
@@ -6,11 +7,6 @@
  * Based on:
  * time-efm32 Copyright (C) 2013 Pengutronix
  * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  */
=20
 #define pr_fmt(fmt) "%s: " fmt, __func__
diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-or=
ion.c
index 5101e834d78f..49e86cb70a7a 100644
--- a/drivers/clocksource/timer-orion.c
+++ b/drivers/clocksource/timer-orion.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Orion SoC timer handling.
  *
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * Timer 0 is used as free-running clocksource, while timer 1 is
  * used as clock_event_device.
  */
diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/time=
r-oxnas-rps.c
index 56c0cc32d0ac..d514b44e67dd 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -236,7 +236,7 @@ static int __init oxnas_rps_timer_init(struct device_node=
 *np)
 	}
=20
 	rps->irq =3D irq_of_parse_and_map(np, 0);
-	if (rps->irq < 0) {
+	if (!rps->irq) {
 		ret =3D -EINVAL;
 		goto err_iomap;
 	}
diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/time=
r-pistachio.c
index 69c069e6f0a2..57b2197a0b67 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Pistachio clocksource based on general-purpose timers
  *
  * Copyright (C) 2015 Imagination Technologies
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #define pr_fmt(fmt) "%s: " fmt, __func__
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-ri=
scv.c
index 1767f8bf2013..593d5a957b69 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) =3D {
 	.name			=3D "riscv_timer_clockevent",
-	.features		=3D CLOCK_EVT_FEAT_ONESHOT,
+	.features		=3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
 	.rating			=3D 100,
 	.set_next_event		=3D riscv_clock_next_event,
 };
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp=
804.c
index 401d592e85f5..e6a87f4af2b5 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -259,6 +259,11 @@ static int __init sp804_of_init(struct device_node *np, =
struct sp804_timer *time
 	struct clk *clk1, *clk2;
 	const char *name =3D of_get_property(np, "compatible", NULL);
=20
+	if (initialized) {
+		pr_debug("%pOF: skipping further SP804 timer device\n", np);
+		return 0;
+	}
+
 	base =3D of_iomap(np, 0);
 	if (!base)
 		return -ENXIO;
@@ -270,11 +275,6 @@ static int __init sp804_of_init(struct device_node *np, =
struct sp804_timer *time
 	writel(0, timer1_base + timer->ctrl);
 	writel(0, timer2_base + timer->ctrl);
=20
-	if (initialized || !of_device_is_available(np)) {
-		ret =3D -EINVAL;
-		goto err;
-	}
-
 	clk1 =3D of_clk_get(np, 0);
 	if (IS_ERR(clk1))
 		clk1 =3D NULL;
diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-su=
n4i.c
index 0ba8155b8287..bb6ea6c19829 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Allwinner A1X SoCs timer handling.
  *
@@ -8,10 +9,6 @@
  * Based on code from
  * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
  * Benn Huang <benn@allwinnertech.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
=20
 #include <linux/clk.h>
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-su=
n5i.c
index 552c5254390c..85900f7fc69f 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Allwinner SoCs hstimer driver.
  *
  * Copyright (C) 2013 Maxime Ripard
  *
  * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
=20
 #include <linux/clk.h>
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index 3e52c5226c4d..33609be0b304 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -828,8 +828,7 @@ static int omap_dm_timer_probe(struct platform_device *pd=
ev)
 		cpu_pm_register_notifier(&timer->nb);
 	}
=20
-	if (pdata)
-		timer->errata =3D pdata->timer_errata;
+	timer->errata =3D pdata->timer_errata;
=20
 	timer->pdev =3D pdev;
=20
diff --git a/include/linux/platform_data/timer-ixp4xx.h b/include/linux/platf=
orm_data/timer-ixp4xx.h
deleted file mode 100644
index ee92ae7edaed..000000000000
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

