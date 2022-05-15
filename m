Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0D527534
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 05:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiEODhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 23:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiEODha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 23:37:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF5E563C4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 20:37:26 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxYNppdYBiOpUWAA--.12697S3;
        Sun, 15 May 2022 11:37:21 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC 01/10] irqchip: Adjust Kconfig for Loongson
Date:   Sun, 15 May 2022 11:37:04 +0800
Message-Id: <1652585833-22526-2-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652585833-22526-1-git-send-email-lvjianmin@loongson.cn>
References: <1652585833-22526-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9BxYNppdYBiOpUWAA--.12697S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrArWUuFW3XFyruFy8Krg_yoW8urW7pF
        s3Za1fGr12yFs3Aws8Zr4xCrWUAr93JayDAa97Jw1DWr9rC340k39rJFn2qrWUArW3J34x
        CFW8CF48Ca17W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUCVW8JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOtC7UUUUU
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

