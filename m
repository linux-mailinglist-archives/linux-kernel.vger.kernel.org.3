Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ECE52B283
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiERGdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiERGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:31:33 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29E3B878
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:31:31 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="61015781"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="61015781"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 15:31:29 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id EB6CBE07E0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:28 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1CCCCD996D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:28 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 8D5324007E8A3;
        Wed, 18 May 2022 15:31:27 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, mchehab+huawei@kernel.org, eugenis@google.com,
        tony.luck@intel.com, pcc@google.com, peterz@infradead.org,
        marcos@orca.pet, conor.dooley@microchip.com,
        nicolas.ferre@microchip.com, marcan@marcan.st,
        linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v4 4/8] soc: fujitsu: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Wed, 18 May 2022 15:30:28 +0900
Message-Id: <20220518063032.2377351-5-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
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
 MAINTAINERS                  |  1 +
 drivers/soc/Kconfig          |  1 +
 drivers/soc/Makefile         |  1 +
 drivers/soc/fujitsu/Kconfig  | 11 +++++++++++
 drivers/soc/fujitsu/Makefile |  2 ++
 5 files changed, 16 insertions(+)
 create mode 100644 drivers/soc/fujitsu/Kconfig
 create mode 100644 drivers/soc/fujitsu/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index f188403bc2e9..dd1345087881 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8624,6 +8624,7 @@ HARDWARE PREFETCH CONTROL DRIVERS
 M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
 S:	Maintained
 F:	drivers/base/pfctl.c
+F:	drivers/soc/fujitsu/a64fx-pfctl.c
 F:	include/linux/pfctl.h
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
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
index 000000000000..d711e6139840
--- /dev/null
+++ b/drivers/soc/fujitsu/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Fujitsu SoC drivers"
+
+config A64FX_HWPF_CONTROL
+	tristate "A64FX Hardware Prefetch Control driver"
+	depends on ARM64 && HWPF_CONTROL
+	help
+	  This adds Hardware Prefetch driver control support for A64FX.
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

