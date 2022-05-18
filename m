Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5882552B276
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiERGbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiERGb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:31:29 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE0465DF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:31:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="51998555"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="51998555"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 15:31:26 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A865C68B0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:24 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1AFF7E663D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:24 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 9E7E3400C1DE7;
        Wed, 18 May 2022 15:31:23 +0900 (JST)
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
Subject: [PATCH v4 2/8] drivers: base: Add Kconfig/Makefile to build hardware prefetch control core driver
Date:   Wed, 18 May 2022 15:30:26 +0900
Message-Id: <20220518063032.2377351-3-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Kconfig/Makefile to build hardware prefetch control core driver,
and also adds a MAINTAINERS entry.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS           | 6 ++++++
 drivers/base/Kconfig  | 9 +++++++++
 drivers/base/Makefile | 1 +
 3 files changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6d879cb0afd..f188403bc2e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8620,6 +8620,12 @@ F:	include/linux/hwmon*.h
 F:	include/trace/events/hwmon*.h
 K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
 
+HARDWARE PREFETCH CONTROL DRIVERS
+M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
+S:	Maintained
+F:	drivers/base/pfctl.c
+F:	include/linux/pfctl.h
+
 HARDWARE RANDOM NUMBER GENERATOR CORE
 M:	Matt Mackall <mpm@selenic.com>
 M:	Herbert Xu <herbert@gondor.apana.org.au>
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 6f04b831a5c0..8f8a69e7f645 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -230,4 +230,13 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config HWPF_CONTROL
+	bool "Hardware Prefetch Control driver"
+	help
+	  This driver allows user to control CPU's Hardware Prefetch behavior.
+	  If the machine supports this behavior, it provides a sysfs interface.
+
+	  See Documentation/ABI/testing/sysfs-devices-system-cpu for more
+	  information.
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 02f7f1358e86..13f3a0ddf3d1 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
+obj-$(CONFIG_HWPF_CONTROL)	+= pfctl.o
 
 obj-y			+= test/
 
-- 
2.27.0

