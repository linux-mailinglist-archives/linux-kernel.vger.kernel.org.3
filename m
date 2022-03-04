Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D54CD9A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiCDRFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiCDRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:05:12 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C97C199D47
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:04:24 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K9DjH2NmCz9sT5;
        Fri,  4 Mar 2022 18:04:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id drbbp6ipNEto; Fri,  4 Mar 2022 18:04:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K9DjG2bwRz9sTB;
        Fri,  4 Mar 2022 18:04:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 344CD8B77D;
        Fri,  4 Mar 2022 18:04:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id v1RuLU4X3cAP; Fri,  4 Mar 2022 18:04:18 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.129])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD9548B77A;
        Fri,  4 Mar 2022 18:04:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 224H47an1979756
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Mar 2022 18:04:07 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 224H460u1979755;
        Fri, 4 Mar 2022 18:04:06 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 1/4] powerpc: Cleanup asm-prototypes.c
Date:   Fri,  4 Mar 2022 18:04:02 +0100
Message-Id: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646413443; l=1963; s=20211009; h=from:subject:message-id; bh=4aqL/Gg0z6WdVeb96pIaD6+eKVywW/RKZ9djzpf8ZKo=; b=SCWCVkNLc550xUQsKjTGdRrJsWYfHn7MH2h9P7z9dzCr02kXqtGzKjplWpp4m9zaHm8kl1KvIYfb 8avfXsWzDPLm1Y3ng1umHvdNTTBKxHFJLS4zjLfaUdGLaLhfd0VM
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last call to sys_swapcontext() from ASM was removed by
commit fbcee2ebe8ed ("powerpc/32: Always save non volatile GPRs at
syscall entry")

sys_debug_setcontext() prototype not needed anymore since
commit f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch
to SYSCALL_DEFINE")

sys_switch_endian() prototype not needed anymore since
commit 81dac8177862 ("powerpc/64: Make sys_switch_endian() traceable")

_mount() prototype is already in asm/ftrace.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/asm-prototypes.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 41b8a1e1144a..4fd79207fd41 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -57,12 +57,7 @@ int enter_vmx_ops(void);
 void *exit_vmx_ops(void *dest);
 
 /* signals, syscalls and interrupts */
-long sys_swapcontext(struct ucontext __user *old_ctx,
-		    struct ucontext __user *new_ctx,
-		    long ctx_size);
 #ifdef CONFIG_PPC32
-long sys_debug_setcontext(struct ucontext __user *ctx,
-			  int ndbg, struct sig_dbg_op __user *dbg);
 int
 ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp,
 	   struct __kernel_old_timeval __user *tvp);
@@ -81,7 +76,6 @@ unsigned long interrupt_exit_kernel_restart(struct pt_regs *regs);
 
 long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
 		      u32 len_high, u32 len_low);
-long sys_switch_endian(void);
 
 /* prom_init (OpenFirmware) */
 unsigned long __init prom_init(unsigned long r3, unsigned long r4,
@@ -102,7 +96,6 @@ extern int __cmpdi2(s64, s64);
 extern int __ucmpdi2(u64, u64);
 
 /* tracing */
-void _mcount(void);
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
 						unsigned long sp);
 
-- 
2.34.1

