Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598BF550387
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 10:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiFRIjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 04:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiFRIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 04:39:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3174522522
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 01:39:14 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx398wj61iX35KAA--.15929S2;
        Sat, 18 Jun 2022 16:39:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Make compute_return_era() return void
Date:   Sat, 18 Jun 2022 16:39:11 +0800
Message-Id: <1655541551-3997-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx398wj61iX35KAA--.15929S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kuFWxCr15GrykWFyfJFb_yoW8GryfpF
        nrAFyDJrWrWF95CFyDtr4kurW3Jrs3G3y293ZFgas5CF42qr1UXr10gr9FvF18t3yFgr4F
        qFWrtw1Yva15XwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjxR65UUUU
        U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compute_return_era() always returns 0, make it return void,
and then no need to check its return value for its callers.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/branch.h | 3 +--
 arch/loongarch/kernel/traps.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/branch.h b/arch/loongarch/include/asm/branch.h
index 3f33c89..9a133e4 100644
--- a/arch/loongarch/include/asm/branch.h
+++ b/arch/loongarch/include/asm/branch.h
@@ -12,10 +12,9 @@ static inline unsigned long exception_era(struct pt_regs *regs)
 	return regs->csr_era;
 }
 
-static inline int compute_return_era(struct pt_regs *regs)
+static inline void compute_return_era(struct pt_regs *regs)
 {
 	regs->csr_era += 4;
-	return 0;
 }
 
 #endif /* _ASM_BRANCH_H */
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index e4060f8..1bf58c6 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -475,8 +475,7 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
 
 	die_if_kernel("Reserved instruction in kernel code", regs);
 
-	if (unlikely(compute_return_era(regs) < 0))
-		goto out;
+	compute_return_era(regs);
 
 	if (unlikely(get_user(opcode, era) < 0)) {
 		status = SIGSEGV;
-- 
2.1.0

