Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90F548D57E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiAMKNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiAMKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:13:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D52BC061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:13:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642068801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=08qLIIkMgCg6qoSFt7MYoppIiJXwGMX3IcQ1S5dtnPE=;
        b=SpH7mkR2flPS1j6z0+phDIdGVY4l47oTLjE3VjhepXXKMQ9sy8lmFbsHbzpePJbzU2NVEh
        GrIy5OyKr4FYLBH8tlt2dTt+94f+pHoFkRWRfyw8DDaHZfkzyf1Yx9CdM3wyQzqqpJpkdB
        31XsY6qRz7nFAlE2MrkRBfjEzuaIsNtBRWT9asrZwcqn3c2eLs/yFt4Pk+k6kC6fVcpFt2
        bQebvoQxx8yHi8Q4WhtI7aC16g/DuhN2z+FkOFp05IxVAZshvEuSWy6rz6n04uWR9TMWUm
        uoVHMLtSlhSqVQKJ84Kf67vmVGxYZ5mcUifY6OIFNsNGVp4NaTjapKGv1neyyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642068801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=08qLIIkMgCg6qoSFt7MYoppIiJXwGMX3IcQ1S5dtnPE=;
        b=9Whlo9WqHJuhXd/KekLLc5jqDwY4eXRTVKfgc4ebgffE9l8OF4dUQwMjSNq9DRnH35YuA+
        gYRg8V8TVfBxRBDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v5.17-rc1
References: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
Message-ID: <164206863332.82661.16045492031950918045.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Thu, 13 Jan 2022 11:13:21 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022=
-01-13

up to:  35e13e9da9af: Merge branch 'clocksource' of git://git.kernel.org/pub/=
scm/linux/kernel/git/paulmck/linux-rcu into timers/core


Updates for the time(r) subsystem:

 Core:

  - Make the clocksource watchdog more robust by better validation checks
    of the measurement.

 Drivers:

  - New drivers for MStar and SSD20xd SOCs

  - The usual cleanups and improvements all over the place


Thanks,

	tglx

------------------>
Biju Das (4):
      reset: Add of_reset_control_get_optional_exclusive()
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/G2L OSTM
      clocksource/drivers/renesas-ostm: Add RZ/G2L OSTM support
      clocksource/drivers/renesas,ostm: Make RENESAS_OSTM symbol visible

Drew Fustini (1):
      clocksource/drivers/pistachio: Fix -Wunused-but-set-variable warning

Jacky Bai (1):
      dt-bindings: timer: tpm-timer: Add imx8ulp compatible string

Johan Jonker (1):
      dt-bindings: timer: remove rockchip,rk3066-timer compatible string from=
 rockchip,rk-timer.yaml

Marek Szyprowski (1):
      clocksource/drivers/exynos_mct: Refactor resources allocation

Michal Simek (1):
      dt-bindings: timer: cadence_ttc: Add power-domains

Paul E. McKenney (1):
      rcutorture: Add CONFIG_PREEMPT_DYNAMIC=3Dn to tiny scenarios

Peng Fan (2):
      clocksource/drivers/imx-sysctr: Mark two variable with __ro_after_init
      clocksource/drivers/timer-imx-sysctr: Set cpumask to cpu_possible_mask

Romain Perier (3):
      clocksource/drivers: Add MStar MSC313e timer support
      clocksource/drivers/msc313e: Add support for ssd20xd-based platforms
      dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings documen=
tation

Waiman Long (2):
      clocksource: Avoid accidental unstable marking of clocksources
      clocksource: Reduce the default clocksource_watchdog() retries to 2

Will Deacon (1):
      clocksource/drivers/exynos_mct: Fix silly typo resulting in checkpatch =
warning


 Documentation/admin-guide/kernel-parameters.txt    |   4 +-
 .../devicetree/bindings/timer/cdns,ttc.yaml        |   3 +
 .../bindings/timer/mstar,msc313e-timer.yaml        |  46 ++++
 .../devicetree/bindings/timer/nxp,tpm-timer.yaml   |   6 +-
 .../devicetree/bindings/timer/renesas,ostm.yaml    |  20 +-
 .../bindings/timer/rockchip,rk-timer.yaml          |   1 -
 MAINTAINERS                                        |   1 +
 drivers/clocksource/Kconfig                        |  12 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/exynos_mct.c                   |  52 +++--
 drivers/clocksource/renesas-ostm.c                 |  39 +++-
 drivers/clocksource/timer-imx-sysctr.c             |   6 +-
 drivers/clocksource/timer-msc313e.c                | 253 +++++++++++++++++++=
++
 drivers/clocksource/timer-pistachio.c              |   3 +-
 include/linux/reset.h                              |  20 ++
 kernel/time/clocksource.c                          |  52 ++++-
 .../selftests/rcutorture/configs/rcu/SRCU-T        |   1 +
 .../selftests/rcutorture/configs/rcu/SRCU-U        |   1 +
 .../selftests/rcutorture/configs/rcu/TINY01        |   1 +
 .../selftests/rcutorture/configs/rcu/TINY02        |   1 +
 .../selftests/rcutorture/configs/rcuscale/TINY     |   1 +
 21 files changed, 480 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-tim=
er.yaml
 create mode 100644 drivers/clocksource/timer-msc313e.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 9725c546a0d4..3ea934b034f7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -603,8 +603,8 @@
 	clocksource.max_cswd_read_retries=3D [KNL]
 			Number of clocksource_watchdog() retries due to
 			external delays before the clock will be marked
-			unstable.  Defaults to three retries, that is,
-			four attempts to read the clock under test.
+			unstable.  Defaults to two retries, that is,
+			three attempts to read the clock under test.
=20
 	clocksource.verify_n_cpus=3D [KNL]
 			Limit the number of CPUs checked for clocksources
diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Document=
ation/devicetree/bindings/timer/cdns,ttc.yaml
index 8615353f69b4..c3386076a98c 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -25,6 +25,9 @@ properties:
   clocks:
     maxItems: 1
=20
+  power-domains:
+    maxItems: 1
+
   timer-width:
     $ref: "/schemas/types.yaml#/definitions/uint32"
     description: |
diff --git a/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml=
 b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
new file mode 100644
index 000000000000..03d5dba5d5b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/mstar,msc313e-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mstar MSC313e Timer Device Tree Bindings
+
+maintainers:
+  - Daniel Palmer <daniel@0x0f.com>
+  - Romain Perier <romain.perier@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mstar,msc313e-timer
+      - sstar,ssd20xd-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@6040 {
+        compatible =3D "mstar,msc313e-timer";
+        reg =3D <0x6040 0x40>;
+        clocks =3D <&xtal_div2>;
+        interrupts-extended =3D <&intc_fiq GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml b/Doc=
umentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
index edd9585f6726..f69773a8e4b9 100644
--- a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
@@ -19,7 +19,11 @@ description: |
=20
 properties:
   compatible:
-    const: fsl,imx7ulp-tpm
+    oneOf:
+      - const: fsl,imx7ulp-tpm
+      - items:
+          - const: fsl,imx8ulp-tpm
+          - const: fsl,imx7ulp-tpm
=20
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Docu=
mentation/devicetree/bindings/timer/renesas,ostm.yaml
index 600d47ab7d58..7fa7f977b44c 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -21,9 +21,10 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r7s72100-ostm # RZ/A1H
-          - renesas,r7s9210-ostm  # RZ/A2M
-      - const: renesas,ostm       # Generic
+          - renesas,r7s72100-ostm  # RZ/A1H
+          - renesas,r7s9210-ostm   # RZ/A2M
+          - renesas,r9a07g044-ostm # RZ/G2{L,LC}
+      - const: renesas,ostm        # Generic
=20
   reg:
     maxItems: 1
@@ -37,6 +38,9 @@ properties:
   power-domains:
     maxItems: 1
=20
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -44,6 +48,16 @@ required:
   - clocks
   - power-domains
=20
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,r9a07g044-ostm
+then:
+  required:
+    - resets
+
 additionalProperties: false
=20
 examples:
diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b=
/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index e26ecb5893ae..5d157d87dad5 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -18,7 +18,6 @@ properties:
           - enum:
               - rockchip,rv1108-timer
               - rockchip,rk3036-timer
-              - rockchip,rk3066-timer
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
diff --git a/MAINTAINERS b/MAINTAINERS
index 13f9a84a617e..45c143618ce4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2291,6 +2291,7 @@ F:	Documentation/devicetree/bindings/gpio/mstar,msc313-=
gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
 F:	drivers/clk/mstar/
+F:	drivers/clocksource/timer-msc313e.c
 F:	drivers/gpio/gpio-msc313.c
 F:	drivers/rtc/rtc-msc313.c
 F:	drivers/watchdog/msc313e_wdt.c
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f65e31bab9ae..cfb8ea0df3b1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -510,7 +510,8 @@ config SH_TIMER_MTU2
 	  This hardware comes with 16-bit timer registers.
=20
 config RENESAS_OSTM
-	bool "Renesas OSTM timer driver" if COMPILE_TEST
+	bool "Renesas OSTM timer driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
 	select CLKSRC_MMIO
 	select TIMER_OF
 	help
@@ -671,6 +672,15 @@ config MILBEAUT_TIMER
 	help
 	  Enables the support for Milbeaut timer driver.
=20
+config MSC313E_TIMER
+	bool "MSC313E timer driver" if COMPILE_TEST
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Enables support for the MStar MSC313E timer driver.
+	  This provides access to multiple interrupt generating
+	  programmable 32-bit free running incrementing counters.
+
 config INGENIC_TIMER
 	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
 	default MACH_INGENIC
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index c17ee32a7151..fa5f624eadb6 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+=3D timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+=3D timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+=3D hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+=3D timer-microchip-pit64b.o
+obj-$(CONFIG_MSC313E_TIMER)		+=3D timer-msc313e.o
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index 5e3e96d3d1b9..6db3d5511b0f 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -467,7 +467,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->tick_resume =3D set_state_shutdown;
 	evt->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_PERCPU;
-	evt->rating =3D MCT_CLKEVENTS_RATING,
+	evt->rating =3D MCT_CLKEVENTS_RATING;
=20
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
=20
@@ -504,11 +504,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
=20
-static int __init exynos4_timer_resources(struct device_node *np, void __iom=
em *base)
+static int __init exynos4_timer_resources(struct device_node *np)
 {
-	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
=20
+	reg_base =3D of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: unable to ioremap mct address space\n", __func__);
+
 	tick_clk =3D of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
@@ -519,9 +522,27 @@ static int __init exynos4_timer_resources(struct device_=
node *np, void __iomem *
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
=20
-	reg_base =3D base;
-	if (!reg_base)
-		panic("%s: unable to ioremap mct address space\n", __func__);
+	return 0;
+}
+
+static int __init exynos4_timer_interrupts(struct device_node *np,
+					   unsigned int int_type)
+{
+	int nr_irqs, i, err, cpu;
+
+	mct_int_type =3D int_type;
+
+	/* This driver uses only one global timer interrupt */
+	mct_irqs[MCT_G0_IRQ] =3D irq_of_parse_and_map(np, MCT_G0_IRQ);
+
+	/*
+	 * Find out the number of local irqs specified. The local
+	 * timer irqs are specified after the four global timer
+	 * irqs are specified.
+	 */
+	nr_irqs =3D of_irq_count(np);
+	for (i =3D MCT_L0_IRQ; i < nr_irqs; i++)
+		mct_irqs[i] =3D irq_of_parse_and_map(np, i);
=20
 	if (mct_int_type =3D=3D MCT_INT_PPI) {
=20
@@ -581,24 +602,13 @@ static int __init exynos4_timer_resources(struct device=
_node *np, void __iomem *
=20
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
-	u32 nr_irqs, i;
 	int ret;
=20
-	mct_int_type =3D int_type;
-
-	/* This driver uses only one global timer interrupt */
-	mct_irqs[MCT_G0_IRQ] =3D irq_of_parse_and_map(np, MCT_G0_IRQ);
-
-	/*
-	 * Find out the number of local irqs specified. The local
-	 * timer irqs are specified after the four global timer
-	 * irqs are specified.
-	 */
-	nr_irqs =3D of_irq_count(np);
-	for (i =3D MCT_L0_IRQ; i < nr_irqs; i++)
-		mct_irqs[i] =3D irq_of_parse_and_map(np, i);
+	ret =3D exynos4_timer_resources(np);
+	if (ret)
+		return ret;
=20
-	ret =3D exynos4_timer_resources(np, of_iomap(np, 0));
+	ret =3D exynos4_timer_interrupts(np, int_type);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas=
-ostm.c
index 3d06ba66008c..21d1392637b8 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -9,6 +9,8 @@
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
=20
@@ -159,6 +161,7 @@ static int __init ostm_init_clkevt(struct timer_of *to)
=20
 static int __init ostm_init(struct device_node *np)
 {
+	struct reset_control *rstc;
 	struct timer_of *to;
 	int ret;
=20
@@ -166,6 +169,14 @@ static int __init ostm_init(struct device_node *np)
 	if (!to)
 		return -ENOMEM;
=20
+	rstc =3D of_reset_control_get_optional_exclusive(np, NULL);
+	if (IS_ERR(rstc)) {
+		ret =3D PTR_ERR(rstc);
+		goto err_free;
+	}
+
+	reset_control_deassert(rstc);
+
 	to->flags =3D TIMER_OF_BASE | TIMER_OF_CLOCK;
 	if (system_clock) {
 		/*
@@ -178,7 +189,7 @@ static int __init ostm_init(struct device_node *np)
=20
 	ret =3D timer_of_init(np, to);
 	if (ret)
-		goto err_free;
+		goto err_reset;
=20
 	/*
 	 * First probed device will be used as system clocksource. Any
@@ -203,9 +214,35 @@ static int __init ostm_init(struct device_node *np)
=20
 err_cleanup:
 	timer_of_cleanup(to);
+err_reset:
+	reset_control_assert(rstc);
+	reset_control_put(rstc);
 err_free:
 	kfree(to);
 	return ret;
 }
=20
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
+
+#ifdef CONFIG_ARCH_R9A07G044
+static int __init ostm_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+
+	return ostm_init(dev->of_node);
+}
+
+static const struct of_device_id ostm_of_table[] =3D {
+	{ .compatible =3D "renesas,ostm", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ostm_device_driver =3D {
+	.driver =3D {
+		.name =3D "renesas_ostm",
+		.of_match_table =3D of_match_ptr(ostm_of_table),
+		.suppress_bind_attrs =3D true,
+	},
+};
+builtin_platform_driver_probe(ostm_device_driver, ostm_probe);
+#endif
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/tim=
er-imx-sysctr.c
index 18b90fc56bfc..55a8e198d2a1 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -20,8 +20,8 @@
=20
 #define SYS_CTR_CLK_DIV		0x3
=20
-static void __iomem *sys_ctr_base;
-static u32 cmpcr;
+static void __iomem *sys_ctr_base __ro_after_init;
+static u32 cmpcr __ro_after_init;
=20
 static void sysctr_timer_enable(bool enable)
 {
@@ -119,7 +119,7 @@ static struct timer_of to_sysctr =3D {
=20
 static void __init sysctr_clockevent_init(void)
 {
-	to_sysctr.clkevt.cpumask =3D cpumask_of(0);
+	to_sysctr.clkevt.cpumask =3D cpu_possible_mask;
=20
 	clockevents_config_and_register(&to_sysctr.clkevt,
 					timer_of_rate(&to_sysctr),
diff --git a/drivers/clocksource/timer-msc313e.c b/drivers/clocksource/timer-=
msc313e.c
new file mode 100644
index 000000000000..54c54ca7c786
--- /dev/null
+++ b/drivers/clocksource/timer-msc313e.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MStar timer driver
+ *
+ * Copyright (C) 2021 Daniel Palmer
+ * Copyright (C) 2021 Romain Perier
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#ifdef CONFIG_ARM
+#include <linux/delay.h>
+#endif
+
+#include "timer-of.h"
+
+#define TIMER_NAME "msc313e_timer"
+
+#define MSC313E_REG_CTRL		0x00
+#define MSC313E_REG_CTRL_TIMER_EN	BIT(0)
+#define MSC313E_REG_CTRL_TIMER_TRIG	BIT(1)
+#define MSC313E_REG_CTRL_TIMER_INT_EN	BIT(8)
+#define MSC313E_REG_TIMER_MAX_LOW	0x08
+#define MSC313E_REG_TIMER_MAX_HIGH	0x0c
+#define MSC313E_REG_COUNTER_LOW		0x10
+#define MSC313E_REG_COUNTER_HIGH	0x14
+#define MSC313E_REG_TIMER_DIVIDE	0x18
+
+#define MSC313E_CLK_DIVIDER		9
+#define TIMER_SYNC_TICKS		3
+
+#ifdef CONFIG_ARM
+struct msc313e_delay {
+	void __iomem *base;
+	struct delay_timer delay;
+};
+static struct msc313e_delay msc313e_delay;
+#endif
+
+static void __iomem *msc313e_clksrc;
+
+static void msc313e_timer_stop(void __iomem *base)
+{
+	writew(0, base + MSC313E_REG_CTRL);
+}
+
+static void msc313e_timer_start(void __iomem *base, bool periodic)
+{
+	u16 reg;
+
+	reg =3D readw(base + MSC313E_REG_CTRL);
+	if (periodic)
+		reg |=3D MSC313E_REG_CTRL_TIMER_EN;
+	else
+		reg |=3D MSC313E_REG_CTRL_TIMER_TRIG;
+	writew(reg | MSC313E_REG_CTRL_TIMER_INT_EN, base + MSC313E_REG_CTRL);
+}
+
+static void msc313e_timer_setup(void __iomem *base, unsigned long delay)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	writew(delay >> 16, base + MSC313E_REG_TIMER_MAX_HIGH);
+	writew(delay & 0xffff, base + MSC313E_REG_TIMER_MAX_LOW);
+	local_irq_restore(flags);
+}
+
+static unsigned long msc313e_timer_current_value(void __iomem *base)
+{
+	unsigned long flags;
+	u16 l, h;
+
+	local_irq_save(flags);
+	l =3D readw(base + MSC313E_REG_COUNTER_LOW);
+	h =3D readw(base + MSC313E_REG_COUNTER_HIGH);
+	local_irq_restore(flags);
+
+	return (((u32)h) << 16 | l);
+}
+
+static int msc313e_timer_clkevt_shutdown(struct clock_event_device *evt)
+{
+	struct timer_of *timer =3D to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_set_oneshot(struct clock_event_device *evt)
+{
+	struct timer_of *timer =3D to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_start(timer_of_base(timer), false);
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	struct timer_of *timer =3D to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_setup(timer_of_base(timer), timer_of_period(timer));
+	msc313e_timer_start(timer_of_base(timer), true);
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_next_event(unsigned long evt, struct clock_e=
vent_device *clkevt)
+{
+	struct timer_of *timer =3D to_timer_of(clkevt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_setup(timer_of_base(timer), evt);
+	msc313e_timer_start(timer_of_base(timer), false);
+
+	return 0;
+}
+
+static irqreturn_t msc313e_timer_clkevt_irq(int irq, void *dev_id)
+{
+	struct clock_event_device *evt =3D dev_id;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static u64 msc313e_timer_clksrc_read(struct clocksource *cs)
+{
+	return msc313e_timer_current_value(msc313e_clksrc) & cs->mask;
+}
+
+#ifdef CONFIG_ARM
+static unsigned long msc313e_read_delay_timer_read(void)
+{
+	return msc313e_timer_current_value(msc313e_delay.base);
+}
+#endif
+
+static u64 msc313e_timer_sched_clock_read(void)
+{
+	return msc313e_timer_current_value(msc313e_clksrc);
+}
+
+static struct clock_event_device msc313e_clkevt =3D {
+	.name =3D TIMER_NAME,
+	.rating =3D 300,
+	.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown =3D msc313e_timer_clkevt_shutdown,
+	.set_state_periodic =3D msc313e_timer_clkevt_set_periodic,
+	.set_state_oneshot =3D msc313e_timer_clkevt_set_oneshot,
+	.tick_resume =3D msc313e_timer_clkevt_shutdown,
+	.set_next_event =3D msc313e_timer_clkevt_next_event,
+};
+
+static int __init msc313e_clkevt_init(struct device_node *np)
+{
+	int ret;
+	struct timer_of *to;
+
+	to =3D kzalloc(sizeof(*to), GFP_KERNEL);
+	if (!to)
+		return -ENOMEM;
+
+	to->flags =3D TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
+	to->of_irq.handler =3D msc313e_timer_clkevt_irq;
+	ret =3D timer_of_init(np, to);
+	if (ret)
+		return ret;
+
+	if (of_device_is_compatible(np, "sstar,ssd20xd-timer")) {
+		to->of_clk.rate =3D clk_get_rate(to->of_clk.clk) / MSC313E_CLK_DIVIDER;
+		to->of_clk.period =3D DIV_ROUND_UP(to->of_clk.rate, HZ);
+		writew(MSC313E_CLK_DIVIDER - 1, timer_of_base(to) + MSC313E_REG_TIMER_DIVI=
DE);
+	}
+
+	msc313e_clkevt.cpumask =3D cpu_possible_mask;
+	msc313e_clkevt.irq =3D to->of_irq.irq;
+	to->clkevt =3D msc313e_clkevt;
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+	return 0;
+}
+
+static int __init msc313e_clksrc_init(struct device_node *np)
+{
+	struct timer_of to =3D { 0 };
+	int ret;
+	u16 reg;
+
+	to.flags =3D TIMER_OF_BASE | TIMER_OF_CLOCK;
+	ret =3D timer_of_init(np, &to);
+	if (ret)
+		return ret;
+
+	msc313e_clksrc =3D timer_of_base(&to);
+	reg =3D readw(msc313e_clksrc + MSC313E_REG_CTRL);
+	reg |=3D MSC313E_REG_CTRL_TIMER_EN;
+	writew(reg, msc313e_clksrc + MSC313E_REG_CTRL);
+
+#ifdef CONFIG_ARM
+	msc313e_delay.base =3D timer_of_base(&to);
+	msc313e_delay.delay.read_current_timer =3D msc313e_read_delay_timer_read;
+	msc313e_delay.delay.freq =3D timer_of_rate(&to);
+
+	register_current_timer_delay(&msc313e_delay.delay);
+#endif
+
+	sched_clock_register(msc313e_timer_sched_clock_read, 32, timer_of_rate(&to)=
);
+	return clocksource_mmio_init(timer_of_base(&to), TIMER_NAME, timer_of_rate(=
&to), 300, 32,
+				     msc313e_timer_clksrc_read);
+}
+
+static int __init msc313e_timer_init(struct device_node *np)
+{
+	int ret =3D 0;
+	static int num_called;
+
+	switch (num_called) {
+	case 0:
+		ret =3D msc313e_clksrc_init(np);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		ret =3D msc313e_clkevt_init(np);
+		if (ret)
+			return ret;
+		break;
+	}
+
+	num_called++;
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(msc313, "mstar,msc313e-timer", msc313e_timer_init);
+TIMER_OF_DECLARE(ssd20xd, "sstar,ssd20xd-timer", msc313e_timer_init);
diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/time=
r-pistachio.c
index 6f37181a8c63..69c069e6f0a2 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -71,7 +71,8 @@ static u64 notrace
 pistachio_clocksource_read_cycles(struct clocksource *cs)
 {
 	struct pistachio_clocksource *pcs =3D to_pistachio_clocksource(cs);
-	u32 counter, overflow;
+	__maybe_unused u32 overflow;
+	u32 counter;
 	unsigned long flags;
=20
 	/*
diff --git a/include/linux/reset.h b/include/linux/reset.h
index db0e6115a2f6..8a21b5756c3e 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -454,6 +454,26 @@ static inline struct reset_control *of_reset_control_get=
_exclusive(
 	return __of_reset_control_get(node, id, 0, false, false, true);
 }
=20
+/**
+ * of_reset_control_get_optional_exclusive - Lookup and obtain an optional e=
xclusive
+ *                                           reference to a reset controller.
+ * @node: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Optional variant of of_reset_control_get_exclusive(). If the requested re=
set
+ * is not specified in the device tree, this function returns NULL instead of
+ * an error.
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ *
+ * Use of id names is optional.
+ */
+static inline struct reset_control *of_reset_control_get_optional_exclusive(
+				struct device_node *node, const char *id)
+{
+	return __of_reset_control_get(node, id, 0, false, true, true);
+}
+
 /**
  * of_reset_control_get_shared - Lookup and obtain a shared reference
  *                               to a reset controller.
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b8a14d2fb5ba..b7e52a642948 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -107,7 +107,7 @@ static u64 suspend_start;
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
-#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
+#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
=20
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
@@ -199,23 +199,30 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
=20
-ulong max_cswd_read_retries =3D 3;
+ulong max_cswd_read_retries =3D 2;
 module_param(max_cswd_read_retries, ulong, 0644);
 EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus =3D 8;
 module_param(verify_n_cpus, int, 0644);
=20
-static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
+enum wd_read_status {
+	WD_READ_SUCCESS,
+	WD_READ_UNSTABLE,
+	WD_READ_SKIP
+};
+
+static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csn=
ow, u64 *wdnow)
 {
 	unsigned int nretries;
-	u64 wd_end, wd_delta;
-	int64_t wd_delay;
+	u64 wd_end, wd_end2, wd_delta;
+	int64_t wd_delay, wd_seq_delay;
=20
 	for (nretries =3D 0; nretries <=3D max_cswd_read_retries; nretries++) {
 		local_irq_disable();
 		*wdnow =3D watchdog->read(watchdog);
 		*csnow =3D cs->read(cs);
 		wd_end =3D watchdog->read(watchdog);
+		wd_end2 =3D watchdog->read(watchdog);
 		local_irq_enable();
=20
 		wd_delta =3D clocksource_delta(wd_end, *wdnow, watchdog->mask);
@@ -226,13 +233,34 @@ static bool cs_watchdog_read(struct clocksource *cs, u6=
4 *csnow, u64 *wdnow)
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before succe=
ss\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
-			return true;
+			return WD_READ_SUCCESS;
 		}
+
+		/*
+		 * Now compute delay in consecutive watchdog read to see if
+		 * there is too much external interferences that cause
+		 * significant delay in reading both clocksource and watchdog.
+		 *
+		 * If consecutive WD read-back delay > WATCHDOG_MAX_SKEW/2,
+		 * report system busy, reinit the watchdog and skip the current
+		 * watchdog test.
+		 */
+		wd_delta =3D clocksource_delta(wd_end2, wd_end, watchdog->mask);
+		wd_seq_delay =3D clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->sh=
ift);
+		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
+			goto skip_test;
 	}
=20
 	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attem=
pt %d, marking unstable\n",
 		smp_processor_id(), watchdog->name, wd_delay, nretries);
-	return false;
+	return WD_READ_UNSTABLE;
+
+skip_test:
+	pr_info("timekeeping watchdog on CPU%d: %s wd-wd read-back delay of %lldns\=
n",
+		smp_processor_id(), watchdog->name, wd_seq_delay);
+	pr_info("wd-%s-wd read-back delay of %lldns, clock-skew test skipped!\n",
+		cs->name, wd_delay);
+	return WD_READ_SKIP;
 }
=20
 static u64 csnow_mid;
@@ -356,6 +384,7 @@ static void clocksource_watchdog(struct timer_list *unuse=
d)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	enum wd_read_status read_ret;
 	u32 md;
=20
 	spin_lock(&watchdog_lock);
@@ -373,9 +402,12 @@ static void clocksource_watchdog(struct timer_list *unus=
ed)
 			continue;
 		}
=20
-		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
-			/* Clock readout unreliable, so give it up. */
-			__clocksource_unstable(cs);
+		read_ret =3D cs_watchdog_read(cs, &csnow, &wdnow);
+
+		if (read_ret !=3D WD_READ_SUCCESS) {
+			if (read_ret =3D=3D WD_READ_UNSTABLE)
+				/* Clock readout unreliable, so give it up. */
+				__clocksource_unstable(cs);
 			continue;
 		}
=20
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T b/tools/te=
sting/selftests/rcutorture/configs/rcu/SRCU-T
index d6557c38dfe4..c70cf0405f24 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
@@ -2,6 +2,7 @@ CONFIG_SMP=3Dn
 CONFIG_PREEMPT_NONE=3Dy
 CONFIG_PREEMPT_VOLUNTARY=3Dn
 CONFIG_PREEMPT=3Dn
+CONFIG_PREEMPT_DYNAMIC=3Dn
 #CHECK#CONFIG_TINY_SRCU=3Dy
 CONFIG_RCU_TRACE=3Dn
 CONFIG_DEBUG_LOCK_ALLOC=3Dy
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U b/tools/te=
sting/selftests/rcutorture/configs/rcu/SRCU-U
index 6bc24e99862f..bc9eeabaa1b1 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
@@ -2,6 +2,7 @@ CONFIG_SMP=3Dn
 CONFIG_PREEMPT_NONE=3Dy
 CONFIG_PREEMPT_VOLUNTARY=3Dn
 CONFIG_PREEMPT=3Dn
+CONFIG_PREEMPT_DYNAMIC=3Dn
 #CHECK#CONFIG_TINY_SRCU=3Dy
 CONFIG_RCU_TRACE=3Dn
 CONFIG_DEBUG_LOCK_ALLOC=3Dn
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/te=
sting/selftests/rcutorture/configs/rcu/TINY01
index 6db705e55487..0953c52fcfd7 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -2,6 +2,7 @@ CONFIG_SMP=3Dn
 CONFIG_PREEMPT_NONE=3Dy
 CONFIG_PREEMPT_VOLUNTARY=3Dn
 CONFIG_PREEMPT=3Dn
+CONFIG_PREEMPT_DYNAMIC=3Dn
 #CHECK#CONFIG_TINY_RCU=3Dy
 CONFIG_HZ_PERIODIC=3Dn
 CONFIG_NO_HZ_IDLE=3Dy
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY02 b/tools/te=
sting/selftests/rcutorture/configs/rcu/TINY02
index d8674264318d..30439f6fc20e 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
@@ -2,6 +2,7 @@ CONFIG_SMP=3Dn
 CONFIG_PREEMPT_NONE=3Dy
 CONFIG_PREEMPT_VOLUNTARY=3Dn
 CONFIG_PREEMPT=3Dn
+CONFIG_PREEMPT_DYNAMIC=3Dn
 #CHECK#CONFIG_TINY_RCU=3Dy
 CONFIG_HZ_PERIODIC=3Dy
 CONFIG_NO_HZ_IDLE=3Dn
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY b/tools=
/testing/selftests/rcutorture/configs/rcuscale/TINY
index fb05ef5279b4..64e9490c1f79 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
@@ -2,6 +2,7 @@ CONFIG_SMP=3Dn
 CONFIG_PREEMPT_NONE=3Dy
 CONFIG_PREEMPT_VOLUNTARY=3Dn
 CONFIG_PREEMPT=3Dn
+CONFIG_PREEMPT_DYNAMIC=3Dn
 #CHECK#CONFIG_TINY_RCU=3Dy
 CONFIG_HZ_PERIODIC=3Dn
 CONFIG_NO_HZ_IDLE=3Dy

