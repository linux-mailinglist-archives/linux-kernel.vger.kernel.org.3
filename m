Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7D7535EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351216AbiE0LDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351181AbiE0LCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:02:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A987E12AE0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:02:33 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cxj+a3r5BiSRAEAA--.20871S3;
        Fri, 27 May 2022 19:02:29 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC V2 01/10] irqchip: Adjust Kconfig for Loongson
Date:   Fri, 27 May 2022 19:02:11 +0800
Message-Id: <1653649335-11998-2-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
References: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Cxj+a3r5BiSRAEAA--.20871S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrArWUuFW3XFyruFy8Krg_yoW8urW7pF
        s3Za1fGr12yFs3Aws8Zr4xCrWUAr93JayDAa97Jw1DWr9rC340k39rJFn2qrWUArW3J34x
        CFW8CF48Ca17W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHyIUUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

We are preparing to add new Loongson (based on LoongArch, not compatible
with old MIPS-based Loongson) support. HTVEC will be shared by both old
and new Loongson processors, so we adjust its description. HTPIC is only
used by MIPS-based Loongson, so we add a MIPS dependency. PCH_PIC and
PCH_MSI will have some arch-specific code, so we remove the COMPILE_TEST
dependency to avoid build warnings.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15edb9a..39d6be2 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -556,7 +556,7 @@ config LOONGSON_LIOINTC
 
 config LOONGSON_HTPIC
 	bool "Loongson3 HyperTransport PIC Controller"
-	depends on MACH_LOONGSON64
+	depends on (MACH_LOONGSON64 && MIPS)
 	default y
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
@@ -564,16 +564,16 @@ config LOONGSON_HTPIC
 	  Support for the Loongson-3 HyperTransport PIC Controller.
 
 config LOONGSON_HTVEC
-	bool "Loongson3 HyperTransport Interrupt Vector Controller"
+	bool "Loongson HyperTransport Interrupt Vector Controller"
 	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	help
-	  Support for the Loongson3 HyperTransport Interrupt Vector Controller.
+	  Support for the Loongson HyperTransport Interrupt Vector Controller.
 
 config LOONGSON_PCH_PIC
 	bool "Loongson PCH PIC Controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
@@ -582,7 +582,7 @@ config LOONGSON_PCH_PIC
 
 config LOONGSON_PCH_MSI
 	bool "Loongson PCH MSI Controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	depends on PCI
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
-- 
1.8.3.1

