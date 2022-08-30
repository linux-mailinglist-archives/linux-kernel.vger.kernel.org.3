Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45D5A71E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiH3XeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiH3Xdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:33:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09591A2ABE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k126-20020a253d84000000b0068bb342010dso872255yba.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=muitaXVvYj1YXYeJfyrYZvippOQN3ekQHC+LkfXxbLc=;
        b=qZpclqQ6MsBQZUyMbRHl5nEFHLKVNuncCaq+7Pxg2KT6XNS9xA08pBlGHG3JYut1v1
         TRvpdM8IY5fuCJoqsdbv+sWXvtCe0pTC8mj6QL8JS54ZIaAga8BWb6ikSMZwyF8wo1Mp
         1IzskPITy3h8+PbYnC19RDCtSEjS9+naLaqxPL38hvyOcW+Wjjnkp5Vu6l4DRpZa2MVw
         /qLkeHfR5fxAiGbQ3ASQz7tXDU/Ojm5437GZxvJMzZGw2uZgFS6bO7kXNuCOzB8SUj8u
         ve7L7kOPTIzBNV8TWMg8uLMQMD4aJ+E2OFqj7Rzu0cUj+dVwgYL7lld5b1V4BmU78331
         S9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=muitaXVvYj1YXYeJfyrYZvippOQN3ekQHC+LkfXxbLc=;
        b=0n5/IroqiDPoerO0zzjFiiQMAPkkYfOuZJOjTkjdhlY1q6pMJxEBXLpDhuB/0zcUR6
         /P6jT4JRobCYZEdwbflbPL243gu8DHFZdajDBPQRpJVPKyWo5PI+r5yD+yupKD0dwIjb
         FKKvQACVD6oJds9Mm+ZmhyLnnKtlIZMpqP73ba56uub4njxkrUOEpwlnyZYDdRZFdSC4
         jqu3Ho1/gFNYWU5Rl4P6BtXnoYxwG/ybKHmDiHX9+93klKc9XnuTxGollzAHfMQmz0MK
         V8xAaGcZhbGrX0arGADWJRJC7ZO5DFF/0eyG9X2X55jL3q76Rf27Bu2r5YZ0zfbhPbY2
         5HhA==
X-Gm-Message-State: ACgBeo1W/1OmhdV2UMmVRoqzztgEVQQ1oGxJOKhdxZF9X279AUN93F7W
        xVVpgFN2M07TjDfW4/yJblTB5KAJiqp0sZUed1hTizVAUfOdD9oMTImSKEKPRJyGaobr80SojmL
        YnduyDA4Nmzf8KB2r6l8eJiY9xftd/5kfJy08t8mEaW3gUBMTZ2Ro2OoeZXDmUdF3Kh+vXKOpjr
        02i7svZRRj8g==
X-Google-Smtp-Source: AA6agR5mmw1lyTMjEbXO+bj0XMfoKQXjrA7x+3+LfFFUJRrRakcxIdBjBJC8pQKjP8yP5Cacc+4B59TMcKFo3CTBMQ8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a25:2c8:0:b0:695:feaa:871f with SMTP
 id 191-20020a2502c8000000b00695feaa871fmr14222519ybc.471.1661902350818; Tue,
 30 Aug 2022 16:32:30 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:29 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=10374; i=samitolvanen@google.com;
 h=from:subject; bh=xx8wjcYE8Du0racyo2HoO5M6w+PYgPKqDWnfLGl3DjU=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3PPFzSBxPnL1McANFd1sNHrlLrdWSxt2cbevI6
 OTWO0UqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzwAKCRBMtfaEi7xW7uukC/
 9uM+7HvXyQ67VflXgAsC/YncRdBoq4yhl8rYfT2i05OWqPjoWHJG8Ya/UI5iY6oAeiaG49tfhTVdrJ
 pUyR3viQo7OIVPeVuzfeHP0eguun9EReYSQcKQGYAV4XfwQ4hFEKT254SvMUfU/M/3EWaS7HN4mNz4
 QJK4XkW4SPhA7RBnDLN3EQJPwljXDQ7+t5wNksrguQOfmbffYUJPcP/HC8oNr1lIRstWm3BrwbIJaD
 MAsUDvpax1bIHiYl6DHoiFijKWm88sHuPFQFFnxGE0U4g/pm+dzy+wirAFnCNNK/RGdmP3fdBqzLSI
 Ul3ndBsIwZACrYvIZ37KXR82etUCnuTGSvqwWPAnY4rizeCV8SEBvqmVV2EWIAClYLSj6ICZQJRyeX
 rzdvbADWzQdLSvLP7rGWgi5MQSYwwYbc15tpgtuhFe0HwpsWbo8jxfrJUVzM4T5CXHBy3OqY/UZZrp
 0/EHk1+pMYKAO0vzlUhH3g28B4J9GI5syiuW13VGIgv/E=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 21/21] x86: Add support for CONFIG_CFI_CLANG
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler injects a type preamble immediately
before each function and a check to validate the target function type
before indirect calls:

  ; type preamble
  __cfi_function:
    mov <id>, %eax
  function:
    ...
  ; indirect call check
    mov     -<id>,%r10d
    add     -0x4(%r11),%r10d
    je      .Ltmp1
    ud2
  .Ltmp1:
    call    __x86_indirect_thunk_r11

Define the __CFI_TYPE helper macro for manually annotating indirectly
called assembly function with the identical premable, add error handling
code for the ud2 traps emitted for indirect call checks, and allow
CONFIG_CFI_CLANG to be selected on x86_64.

This produces the following oops on CFI failure (generated using lkdtm):

[   21.441706] CFI failure at lkdtm_indirect_call+0x16/0x20 [lkdtm]
(target: lkdtm_increment_int+0x0/0x10 [lkdtm]; expected type: 0x7e0c52a)
[   21.444579] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   21.445296] CPU: 0 PID: 132 Comm: sh Not tainted
5.19.0-rc8-00020-g9f27360e674c #1
[   21.445296] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   21.445296] RIP: 0010:lkdtm_indirect_call+0x16/0x20 [lkdtm]
[   21.445296] Code: 52 1c c0 48 c7 c1 c5 50 1c c0 e9 25 48 2a cc 0f 1f
44 00 00 49 89 fb 48 c7 c7 50 b4 1c c0 41 ba 5b ad f3 81 45 03 53 f8
[   21.445296] RSP: 0018:ffffa9f9c02ffdc0 EFLAGS: 00000292
[   21.445296] RAX: 0000000000000027 RBX: ffffffffc01cb300 RCX: 385cbbd2e07=
0a700
[   21.445296] RDX: 0000000000000000 RSI: c0000000ffffdfff RDI: ffffffffc01=
cb450
[   21.445296] RBP: 0000000000000006 R08: 0000000000000000 R09: ffffffff8d0=
81610
[   21.445296] R10: 00000000bcc90825 R11: ffffffffc01c2fc0 R12: 00000000000=
00000
[   21.445296] R13: ffffa31b827a6000 R14: 0000000000000000 R15: 00000000000=
00002
[   21.445296] FS:  00007f08b42216a0(0000) GS:ffffa31b9f400000(0000)
knlGS:0000000000000000
[   21.445296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.445296] CR2: 0000000000c76678 CR3: 0000000001940000 CR4: 00000000000=
006f0
[   21.445296] Call Trace:
[   21.445296]  <TASK>
[   21.445296]  lkdtm_CFI_FORWARD_PROTO+0x30/0x50 [lkdtm]
[   21.445296]  direct_entry+0x12d/0x140 [lkdtm]
[   21.445296]  full_proxy_write+0x5d/0xb0
[   21.445296]  vfs_write+0x144/0x460
[   21.445296]  ? __x64_sys_wait4+0x5a/0xc0
[   21.445296]  ksys_write+0x69/0xd0
[   21.445296]  do_syscall_64+0x51/0xa0
[   21.445296]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   21.445296] RIP: 0033:0x7f08b41a6fe1
[   21.445296] Code: be 07 00 00 00 41 89 c0 e8 7e ff ff ff 44 89 c7 89
04 24 e8 91 c6 02 00 8b 04 24 48 83 c4 68 c3 48 63 ff b8 01 00 00 03
[   21.445296] RSP: 002b:00007ffcdf65c2e8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[   21.445296] RAX: ffffffffffffffda RBX: 00007f08b4221690 RCX: 00007f08b41=
a6fe1
[   21.445296] RDX: 0000000000000012 RSI: 0000000000c738f0 RDI: 00000000000=
00001
[   21.445296] RBP: 0000000000000001 R08: fefefefefefefeff R09: fefefefeffc=
5ff4e
[   21.445296] R10: 00007f08b42222b0 R11: 0000000000000246 R12: 0000000000c=
738f0
[   21.445296] R13: 0000000000000012 R14: 00007ffcdf65c401 R15: 0000000000c=
70450
[   21.445296]  </TASK>
[   21.445296] Modules linked in: lkdtm
[   21.445296] Dumping ftrace buffer:
[   21.445296]    (ftrace buffer empty)
[   21.471442] ---[ end trace 0000000000000000 ]---
[   21.471811] RIP: 0010:lkdtm_indirect_call+0x16/0x20 [lkdtm]
[   21.472467] Code: 52 1c c0 48 c7 c1 c5 50 1c c0 e9 25 48 2a cc 0f 1f
44 00 00 49 89 fb 48 c7 c7 50 b4 1c c0 41 ba 5b ad f3 81 45 03 53 f8
[   21.474400] RSP: 0018:ffffa9f9c02ffdc0 EFLAGS: 00000292
[   21.474735] RAX: 0000000000000027 RBX: ffffffffc01cb300 RCX: 385cbbd2e07=
0a700
[   21.475664] RDX: 0000000000000000 RSI: c0000000ffffdfff RDI: ffffffffc01=
cb450
[   21.476471] RBP: 0000000000000006 R08: 0000000000000000 R09: ffffffff8d0=
81610
[   21.477127] R10: 00000000bcc90825 R11: ffffffffc01c2fc0 R12: 00000000000=
00000
[   21.477959] R13: ffffa31b827a6000 R14: 0000000000000000 R15: 00000000000=
00002
[   21.478657] FS:  00007f08b42216a0(0000) GS:ffffa31b9f400000(0000)
knlGS:0000000000000000
[   21.479577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.480307] CR2: 0000000000c76678 CR3: 0000000001940000 CR4: 00000000000=
006f0
[   21.481460] Kernel panic - not syncing: Fatal exception

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig               |  2 +
 arch/x86/include/asm/cfi.h     | 22 +++++++++
 arch/x86/include/asm/linkage.h |  9 ++++
 arch/x86/kernel/Makefile       |  2 +
 arch/x86/kernel/cfi.c          | 85 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c        |  4 +-
 6 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/cfi.h
 create mode 100644 arch/x86/kernel/cfi.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..1fe6a83dac05 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,8 @@ config X86
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <=3D 4096
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64
+	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
new file mode 100644
index 000000000000..58dacd90daef
--- /dev/null
+++ b/arch/x86/include/asm/cfi.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CFI_H
+#define _ASM_X86_CFI_H
+
+/*
+ * Clang Control Flow Integrity (CFI) support.
+ *
+ * Copyright (C) 2022 Google LLC
+ */
+
+#include <linux/cfi.h>
+
+#ifdef CONFIG_CFI_CLANG
+enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
+#else
+static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	return BUG_TRAP_TYPE_NONE;
+}
+#endif /* CONFIG_CFI_CLANG */
+
+#endif /* _ASM_X86_CFI_H */
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.=
h
index 73ca20049835..ebfa05973312 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -29,6 +29,15 @@
 #endif
 #endif /* CONFIG_RETPOLINE */
=20
+#ifdef CONFIG_CFI_CLANG
+#define __CFI_TYPE(name)					\
+	SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)	\
+	.fill 11, 1, 0x90 ASM_NL				\
+	.byte 0xb8 ASM_NL					\
+	.long __kcfi_typeid_##name ASM_NL			\
+	SYM_FUNC_END(__cfi_##name)
+#endif
+
 #else /* __ASSEMBLY__ */
=20
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUI=
LD_VDSO)
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index a20a5ebfacd7..1286a73ebdbc 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,6 +139,8 @@ obj-$(CONFIG_UNWINDER_GUESS)		+=3D unwind_guess.o
=20
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+=3D sev.o
=20
+obj-$(CONFIG_CFI_CLANG)			+=3D cfi.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
new file mode 100644
index 000000000000..e642c1af2678
--- /dev/null
+++ b/arch/x86/kernel/cfi.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clang Control Flow Integrity (CFI) support.
+ *
+ * Copyright (C) 2022 Google LLC
+ */
+#include <asm/cfi.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
+
+/*
+ * Returns the target address and the expected type when regs->ip points
+ * to a compiler-generated CFI trap.
+ */
+static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
+			    u32 *type)
+{
+	char buffer[MAX_INSN_SIZE];
+	struct insn insn;
+	int offset =3D 0;
+
+	*target =3D *type =3D 0;
+
+	/*
+	 * The compiler generates the following instruction sequence
+	 * for indirect call checks:
+	 *
+	 * =C2=A0 movl    -<id>, %r10d       ; 6 bytes
+	 *   addl    -4(%reg), %r10d    ; 4 bytes
+	 *   je      .Ltmp1             ; 2 bytes
+	 *   ud2                        ; <- regs->ip
+	 *   .Ltmp1:
+	 *
+	 * We can decode the expected type and the target address from the
+	 * movl/addl instructions.
+	 */
+	if (copy_from_kernel_nofault(buffer, (void *)regs->ip - 12, MAX_INSN_SIZE=
))
+		return false;
+	if (insn_decode_kernel(&insn, &buffer[offset]))
+		return false;
+	if (insn.opcode.value !=3D 0xBA)
+		return false;
+
+	*type =3D -(u32)insn.immediate.value;
+
+	if (copy_from_kernel_nofault(buffer, (void *)regs->ip - 6, MAX_INSN_SIZE)=
)
+		return false;
+	if (insn_decode_kernel(&insn, &buffer[offset]))
+		return false;
+	if (insn.opcode.value !=3D 0x3)
+		return false;
+
+	/* Read the target address from the register. */
+	offset =3D insn_get_modrm_rm_off(&insn, regs);
+	if (offset < 0)
+		return false;
+
+	*target =3D *(unsigned long *)((void *)regs + offset);
+
+	return true;
+}
+
+/*
+ * Checks if a ud2 trap is because of a CFI failure, and handles the trap
+ * if needed. Returns a bug_trap_type value similarly to report_bug.
+ */
+enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	unsigned long target;
+	u32 type;
+
+	if (!is_cfi_trap(regs->ip))
+		return BUG_TRAP_TYPE_NONE;
+
+	if (!decode_cfi_insn(regs, &target, &type))
+		return report_cfi_failure_noaddr(regs, regs->ip);
+
+	return report_cfi_failure(regs, regs->ip, &target, type);
+}
+
+/*
+ * Ensure that __kcfi_typeid_ symbols are emitted for functions that may
+ * not be indirectly called with all configurations.
+ */
+__ADDRESSABLE(memcpy)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d62b2cb85cea..178015a820f0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -63,6 +63,7 @@
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
 #include <asm/tdx.h>
+#include <asm/cfi.h>
=20
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -313,7 +314,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN) {
+	if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN ||
+	    handle_cfi_failure(regs) =3D=3D BUG_TRAP_TYPE_WARN) {
 		regs->ip +=3D LEN_UD2;
 		handled =3D true;
 	}
--=20
2.37.2.672.g94769d06f0-goog

