Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68C453FE6E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbiFGMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243427AbiFGMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:48 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114568FB4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:07:41 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="76072289"
X-IronPort-AV: E=Sophos;i="5.91,283,1647270000"; 
   d="scan'208";a="76072289"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Jun 2022 21:07:40 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C30FD63BA;
        Tue,  7 Jun 2022 21:07:38 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1B52BD99E4;
        Tue,  7 Jun 2022 21:07:37 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id CCE964007FE5D;
        Tue,  7 Jun 2022 21:07:36 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org,
        eugenis@google.com, tony.luck@intel.com, pcc@google.com,
        peterz@infradead.org, marcos@orca.pet, marcan@marcan.st,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        conor.dooley@microchip.com, arnd@arndb.de, ast@kernel.org,
        peter.chen@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v5 2/6] soc: fujitsu: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Tue,  7 Jun 2022 21:05:26 +0900
Message-Id: <20220607120530.2447112-3-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Kconfig/Makefile to build hardware prefetch control driver for
A64FX support, and also adds a MAINTAINERS entry.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS                  |  5 +++++
 drivers/soc/Kconfig          |  1 +
 drivers/soc/Makefile         |  1 +
 drivers/soc/fujitsu/Kconfig  | 26 ++++++++++++++++++++++++++
 drivers/soc/fujitsu/Makefile |  2 ++
 5 files changed, 35 insertions(+)
 create mode 100644 drivers/soc/fujitsu/Kconfig
 create mode 100644 drivers/soc/fujitsu/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index d6d879cb0afd..b3e920a8a044 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8620,6 +8620,11 @@ F:	include/linux/hwmon*.h
 F:	include/trace/events/hwmon*.h
 K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
 
+HARDWARE PREFETCH CONTROL DRIVERS
+M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
+S:	Maintained
+F:	drivers/soc/fujitsu/a64fx-pfctl.c
+
 HARDWARE RANDOM NUMBER GENERATOR CORE
 M:	Matt Mackall <mpm@selenic.com>
 M:	Herbert Xu <herbert@gondor.apana.org.au>
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c5aae42673d3..d87754799d90 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,7 @@ source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
 source "drivers/soc/fsl/Kconfig"
+source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 904eec2a7871..6c8ff1792cda 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SOC_CANAAN)	+= canaan/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
+obj-y				+= fujitsu/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-y				+= imx/
 obj-y				+= ixp4xx/
diff --git a/drivers/soc/fujitsu/Kconfig b/drivers/soc/fujitsu/Kconfig
new file mode 100644
index 000000000000..6c5990b75cc5
--- /dev/null
+++ b/drivers/soc/fujitsu/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Fujitsu SoC drivers"
+
+config ALLOW_INCOMPLETE_CACHE_SYSFS
+	bool
+
+config A64FX_HWPF_CONTROL
+	tristate "A64FX Hardware Prefetch Control driver"
+	depends on ARM64
+	select ALLOW_INCOMPLETE_CACHE_SYSFS
+	help
+	  This provides a sysfs interface to control the Hardware Prefetch
+	  behavior for A64FX.
+
+	  A64FX has IMP_PF_STREAM_DETECT_CTRL_EL0, which can control the
+	  hardware prefech behavior. If the processor supports this, the
+	  module can be loaded with the name a64fx-pfctl.
+
+	  Depending on the characteristics of the application, this register
+	  parameters improve or degrade performance.
+
+	  Please see Documentation/ABI/testing/sysfs-devices-system-cpu for
+	  more information.
+
+endmenu
diff --git a/drivers/soc/fujitsu/Makefile b/drivers/soc/fujitsu/Makefile
new file mode 100644
index 000000000000..35e284a548bb
--- /dev/null
+++ b/drivers/soc/fujitsu/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_A64FX_HWPF_CONTROL)	+= a64fx-pfctl.o
-- 
2.27.0

