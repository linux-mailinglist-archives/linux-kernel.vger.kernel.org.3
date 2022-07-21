Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F0D57C998
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiGULKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiGULKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:10:52 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3878C82127
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:10:51 -0700 (PDT)
Received: from 5.5.5 (unknown [10.2.5.5])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb+M5NNlitnAsAA--.488S2;
        Thu, 21 Jul 2022 19:10:49 +0800 (CST)
From:   Jun Yi <yijun@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Remove unused header compiler.h
Date:   Thu, 21 Jul 2022 19:10:49 +0800
Message-Id: <20220721111049.4035186-1-yijun@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxb+M5NNlitnAsAA--.488S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWrXry7Cr4xCF4rAFWfGrg_yoW7uFy8pF
        9rCr4kGFZ5WryrJF9FkFyj9r1UJw4kCr1agFyY9a48AF12qr1UZrykKryDAFyUJan5t340
        gFyfGw1YqF47Xw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVCm-wCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5Ab15UUUUU==
X-CM-SenderInfo: p1lm30o6or00hjvr0hdfq/1tbiAQAOAV3QvP5jAwAIsp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The content of loongarch's compiler.h is trivial, with
some unused anywhere, so inline the definitions and remove
the header.

Signed-off-by: Jun Yi <yijun@loongson.cn>
---
v1->v2: Modify commit message
---
 arch/loongarch/Kconfig                |  1 -
 arch/loongarch/include/asm/atomic.h   |  9 ++++-----
 arch/loongarch/include/asm/compiler.h | 15 ---------------
 arch/loongarch/include/asm/futex.h    |  5 ++---
 arch/loongarch/include/asm/irqflags.h |  1 -
 arch/loongarch/include/asm/local.h    |  1 -
 arch/loongarch/kernel/reset.c         |  1 -
 arch/loongarch/lib/delay.c            |  1 -
 8 files changed, 6 insertions(+), 28 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/compiler.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 53a912befb62..89da3e09084e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -69,7 +69,6 @@ config LOONGARCH
 	select GENERIC_TIME_VSYSCALL
 	select GPIOLIB
 	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
index 979367ad4e2c..b5e2e3201af1 100644
--- a/arch/loongarch/include/asm/atomic.h
+++ b/arch/loongarch/include/asm/atomic.h
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <asm/cmpxchg.h>
-#include <asm/compiler.h>
 
 #if __SIZEOF_LONG__ == 4
 #define __LL		"ll.w	"
@@ -164,7 +163,7 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 		"2:							\n"
 		__WEAK_LLSC_MB
 		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		  "+ZC" (v->counter)
 		: "I" (-i));
 	} else {
 		__asm__ __volatile__(
@@ -177,7 +176,7 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 		"2:							\n"
 		__WEAK_LLSC_MB
 		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		  "+ZC" (v->counter)
 		: "r" (i));
 	}
 
@@ -327,7 +326,7 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 		"2:							\n"
 		__WEAK_LLSC_MB
 		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		  "+ZC" (v->counter)
 		: "I" (-i));
 	} else {
 		__asm__ __volatile__(
@@ -340,7 +339,7 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 		"2:							\n"
 		__WEAK_LLSC_MB
 		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		  "+ZC" (v->counter)
 		: "r" (i));
 	}
 
diff --git a/arch/loongarch/include/asm/compiler.h b/arch/loongarch/include/asm/compiler.h
deleted file mode 100644
index 657cebe70ace..000000000000
--- a/arch/loongarch/include/asm/compiler.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#ifndef _ASM_COMPILER_H
-#define _ASM_COMPILER_H
-
-#define GCC_OFF_SMALL_ASM() "ZC"
-
-#define LOONGARCH_ISA_LEVEL "loongarch"
-#define LOONGARCH_ISA_ARCH_LEVEL "arch=loongarch"
-#define LOONGARCH_ISA_LEVEL_RAW loongarch
-#define LOONGARCH_ISA_ARCH_LEVEL_RAW LOONGARCH_ISA_LEVEL_RAW
-
-#endif /* _ASM_COMPILER_H */
diff --git a/arch/loongarch/include/asm/futex.h b/arch/loongarch/include/asm/futex.h
index 9de8231694ec..e28b65d9c67a 100644
--- a/arch/loongarch/include/asm/futex.h
+++ b/arch/loongarch/include/asm/futex.h
@@ -8,7 +8,6 @@
 #include <linux/futex.h>
 #include <linux/uaccess.h>
 #include <asm/barrier.h>
-#include <asm/compiler.h>
 #include <asm/errno.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
@@ -95,8 +94,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newv
 	"	"__UA_ADDR "\t1b, 4b				\n"
 	"	"__UA_ADDR "\t2b, 4b				\n"
 	"	.previous					\n"
-	: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
-	: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
+	: "+r" (ret), "=&r" (val), "=ZC" (*uaddr)
+	: "ZC" (*uaddr), "Jr" (oldval), "Jr" (newval),
 	  "i" (-EFAULT)
 	: "memory", "t0");
 
diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/include/asm/irqflags.h
index 52121cd791fe..319a8c616f1f 100644
--- a/arch/loongarch/include/asm/irqflags.h
+++ b/arch/loongarch/include/asm/irqflags.h
@@ -9,7 +9,6 @@
 
 #include <linux/compiler.h>
 #include <linux/stringify.h>
-#include <asm/compiler.h>
 #include <asm/loongarch.h>
 
 static inline void arch_local_irq_enable(void)
diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index 2052a2267337..65fbbae9fc4d 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -9,7 +9,6 @@
 #include <linux/bitops.h>
 #include <linux/atomic.h>
 #include <asm/cmpxchg.h>
-#include <asm/compiler.h>
 
 typedef struct {
 	atomic_long_t a;
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index 2b86469e4718..800c965a17ea 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -13,7 +13,6 @@
 #include <linux/console.h>
 
 #include <acpi/reboot.h>
-#include <asm/compiler.h>
 #include <asm/idle.h>
 #include <asm/loongarch.h>
 #include <asm/reboot.h>
diff --git a/arch/loongarch/lib/delay.c b/arch/loongarch/lib/delay.c
index 5d856694fcfe..831d4761f385 100644
--- a/arch/loongarch/lib/delay.c
+++ b/arch/loongarch/lib/delay.c
@@ -7,7 +7,6 @@
 #include <linux/smp.h>
 #include <linux/timex.h>
 
-#include <asm/compiler.h>
 #include <asm/processor.h>
 
 void __delay(unsigned long cycles)
-- 
2.31.1

