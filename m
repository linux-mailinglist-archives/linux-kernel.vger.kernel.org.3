Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7184D415C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiCJGve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbiCJGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:51:22 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46B9711AA26;
        Wed,  9 Mar 2022 22:50:21 -0800 (PST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxsM6lnyliK0MGAA--.27068S4;
        Thu, 10 Mar 2022 14:50:14 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MIPS: Remove redundant definitions of device_tree_init()
Date:   Thu, 10 Mar 2022 14:50:11 +0800
Message-Id: <1646895012-3143-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1646895012-3143-1-git-send-email-yangtiezhu@loongson.cn>
References: <1646895012-3143-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxsM6lnyliK0MGAA--.27068S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4xAFy8ZF47GF43Cw4fuFg_yoWrAF1fp3
        y2yas7GrW5Wr1UGFWfArykZr1YqFnY934avayjk3y8uasIvryrWr4fCry5AryDJrWUX3Wr
        WFySqrWxXF48Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUndgADUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exists many same definitions of device_tree_init() for various
platforms, add a weak function in arch/mips/kernel/prom.c to clean
up the related code.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/ath79/setup.c          |  5 -----
 arch/mips/kernel/prom.c          |  5 +++++
 arch/mips/lantiq/prom.c          |  5 -----
 arch/mips/loongson64/setup.c     |  5 -----
 arch/mips/mti-malta/Makefile     |  1 -
 arch/mips/mti-malta/malta-dt.c   | 15 ---------------
 arch/mips/pic32/pic32mzda/init.c |  5 -----
 arch/mips/ralink/of.c            |  5 -----
 8 files changed, 5 insertions(+), 41 deletions(-)
 delete mode 100644 arch/mips/mti-malta/malta-dt.c

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 45d4d71..4e18cdc 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -269,8 +269,3 @@ void __init arch_init_irq(void)
 {
 	irqchip_init();
 }
-
-void __init device_tree_init(void)
-{
-	unflatten_and_copy_device_tree();
-}
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 6abebd5..7db6ff9 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -64,4 +64,9 @@ int __init __dt_register_buses(const char *bus0, const char *bus1)
 	return 0;
 }
 
+void __weak __init device_tree_init(void)
+{
+	unflatten_and_copy_device_tree();
+}
+
 #endif
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index bc9f58f..c731082a 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -84,11 +84,6 @@ void __init plat_mem_setup(void)
 	__dt_setup_arch(dtb);
 }
 
-void __init device_tree_init(void)
-{
-	unflatten_and_copy_device_tree();
-}
-
 void __init prom_init(void)
 {
 	/* call the soc specific detetcion code and get it to fill soc_info */
diff --git a/arch/mips/loongson64/setup.c b/arch/mips/loongson64/setup.c
index 1973eb0..3cd11c2 100644
--- a/arch/mips/loongson64/setup.c
+++ b/arch/mips/loongson64/setup.c
@@ -36,8 +36,3 @@ void __init plat_mem_setup(void)
 	if (loongson_fdt_blob)
 		__dt_setup_arch(loongson_fdt_blob);
 }
-
-void __init device_tree_init(void)
-{
-	unflatten_and_copy_device_tree();
-}
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 94c11f5..13bbd12 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -6,7 +6,6 @@
 # Copyright (C) 2008 Wind River Systems, Inc.
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
-obj-y				+= malta-dt.o
 obj-y				+= malta-dtshim.o
 obj-y				+= malta-init.o
 obj-y				+= malta-int.o
diff --git a/arch/mips/mti-malta/malta-dt.c b/arch/mips/mti-malta/malta-dt.c
deleted file mode 100644
index d045c91..0000000
--- a/arch/mips/mti-malta/malta-dt.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2015 Imagination Technologies
- * Author: Paul Burton <paul.burton@mips.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/init.h>
-#include <linux/of_fdt.h>
-#include <linux/of_platform.h>
-
-void __init device_tree_init(void)
-{
-	unflatten_and_copy_device_tree();
-}
diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index a1860f2..1299156 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -78,11 +78,6 @@ void __init prom_init(void)
 	pic32_init_cmdline((int)fw_arg0, (char **)fw_arg1);
 }
 
-void __init device_tree_init(void)
-{
-	unflatten_and_copy_device_tree();
-}
-
 static struct pic32_sdhci_platform_data sdhci_data = {
 	.setup_dma = pic32_set_sdhci_adma_fifo_threshold,
 };
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 35a87a2..587c7b9 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -48,11 +48,6 @@ __iomem void *plat_of_remap_node(const char *node)
 	return ioremap(res.start, resource_size(&res));
 }
 
-void __init device_tree_init(void)
-{
-	unflatten_and_copy_device_tree();
-}
-
 void __init plat_mem_setup(void)
 {
 	void *dtb;
-- 
2.1.0

