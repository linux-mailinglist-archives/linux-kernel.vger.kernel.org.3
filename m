Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDD1547036
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351127AbiFJXhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350818AbiFJXhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:37:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463E29ADFB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:36:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7dbceab08so6025417b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Nj2FcQQ6lEfrPxymLsrkJw1b2S1yl6sNWE/BKYH2KMQ=;
        b=X3EEC5gZJaLGTcVcURSwh1BdZ+KgDOumiR78ltdLn3aAFssMNf8iW95J71NeirdC11
         8HdGKrvGyxavcUSjK0OI2HQgNyrgsl5GcI14p0G290yLj4FEIRti+uctpcOTlW/SmoiF
         l7Lwwu4G+ei/e/wq+eYdd1ghnyQZqIQggugnxesKfPC/V1cS9oozHhBg/slW4JUTUvmJ
         qFJAm5yuQ3fb1A7CwVeKNAdYKH4sHICESyPp4OiVWTYSChzym6Txotzi0hwRY3kQLDMw
         eubwZQTSkfk79U97Rej66mF3K1RLmJ//O3lCjtedvbvqsvOvLxoYlUwCMuu3Ss60+Yvr
         8k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Nj2FcQQ6lEfrPxymLsrkJw1b2S1yl6sNWE/BKYH2KMQ=;
        b=eUpvO87oAn/+NZ3gRQ4NIu/du5rZmH8MZ1o2hBDsOZTHNUmRPRdfuBhXV8VsnBiP8u
         UlLkGkFJ0kZ65JZ5X6Ssof1z2lqk4bGNewgDy45K1urquwJEYf/RXy/f4jVJff9EbQ2f
         Y/LedsLe9SAZcga7QrpD1W3V4NrNblsqzmVmaLPt6OTs0fUlbLgCb66L9KsEkarTW4wU
         eQVSJvYIxGx5T0SDpq9a7tjBSRZvmDwNlu48NLxr1NfkAG7pDHgzmBxtOk/S2JaKjmvh
         5KImKAhBS8cV+dhNpNdjrbmzn7/BzgSvPqGLJolK348NtpzUCm9CzedJOTOih+HTPR5Z
         mrAg==
X-Gm-Message-State: AOAM531+o6FsFiHUfKK5g4L6WpisEGlfvNCf7Kpz7eIcjubmNSiOR2gm
        NBBcE5J3xaWceRG9bBkk26LlOQoHQEHnCEU++/wjIhx1DBS8I/OixBHfA9VZsITNpFX8F7f6RVH
        0eCNr1P2kmaiOx79zkr7ophHTpwGq1vsjTLoiBeFVjEHbdsIMoySLQCmH+DHSWHFwOQAo/v40gC
        Jyz37KwR6OsA==
X-Google-Smtp-Source: ABdhPJxVGYzoLz0dtA1YZ7pQXisvPcdFXe2JAwe7vc6YPzpJezG5CieqmFkfvvw14t5EGlP7YNrTM2k43DQNd0ZuTnI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a25:5d0d:0:b0:633:25c8:380 with SMTP
 id r13-20020a255d0d000000b0063325c80380mr45507038ybb.167.1654904164287; Fri,
 10 Jun 2022 16:36:04 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:13 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=10274; h=from:subject;
 bh=S9UxutCSspfmeIl4qS2cBaxdW+uZNFEa/Fr10jrQR8I=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UvrlNDSxgHrq2W/3CmEYlMjhhC7DgqfXHv7FAJ
 hR1GXSqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLwAKCRBMtfaEi7xW7m5PC/
 9XQVT9GF3M3MS7Z+zuwlzAXErTzPomRmsIk+xwRH+z65arN1z/XUWRNCF82WptGt0tRpduU0obfCi3
 IlwuIW6AtQCVCdkaHLyMoT1n7g5yYyp86HejhCd7nWfl1S1Ewe6x026ymSsXi3Zs4XV63Lqpl+xcbM
 Xf2qbn1UwuQZfkm3M09ugsTLivqBFk50QtEkGn2b1f95IdWMdzjCbixiEe44I1smIAoa6GRveLqbD9
 eViLyOvuH7Ov55Dr8vYUTmGi9jrcF0n2rg68jqXPbuJv1uY4hHaLwlpHRcTqqsI69lW+Om2vROuuG2
 65/bbb3bnWcJ1DInYO0bM5lQKwwguJuFez/Y1iwUsCUsuE5UFhMNI2Ixm1h9V7htpvs+1wqqOyTAUo
 B9/7QAFz312wrUHzpQMLFwaSEuP7Uf0ioPQV1j27Xq9magHCRSRCuKodE1J+pRGgHznFEW8ZLLDl6/
 cOK4cCqbFO7BeIJbLqNdf8tCeB4BeZqIJKiat8CQOOvyg=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 20/20] x86: Add support for CONFIG_CFI_CLANG
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
    int3
    int3
    mov <id>, %eax
    int3
    int3
  function:
    ...
  ; indirect call check
    cmpl=C2=A0 =C2=A0 <id>, -6(%r11)
    je      .Ltmp1
    ud2
  .Ltmp1:
    call    __x86_indirect_thunk_r11

Define the __CFI_TYPE helper macro for manually annotating indirectly
called assembly function with the identical premable, add error handling
code for the ud2 traps emitted for indirect call checks, and allow
CONFIG_CFI_CLANG to be selected on x86_64.

This produces the following oops on CFI failure (generated using lkdtm):

[   15.896503] CFI failure at lkdtm_indirect_call+0x14/0x20 [lkdtm]
(target: lkdtm_increment_int+0x0/0x7 [lkdtm]; expected type: 0x7e0c52a5)
[   15.898565] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   15.898798] CPU: 2 PID: 133 Comm: sh Not tainted
5.19.0-rc1-00020-g524d4b861d15 #1
[   15.898967] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   15.899004] RIP: 0010:lkdtm_indirect_call+0x14/0x20 [lkdtm]
[   15.899004] Code: c7 c2 76 02 40 c0 48 c7 c1 95 00 40 c0 e9 3b cb 3e
e8 0f 1f 40 00 49 89 fb 48 c7 c7 70 64 40 c0 41 81 7b fa a5 52 0c 7f
[   15.899004] RSP: 0018:ffff9d928029fdc0 EFLAGS: 00000283
[   15.899004] RAX: 0000000000000027 RBX: ffffffffc0406320 RCX: 024cef129f4=
58500
[   15.899004] RDX: ffffffffa9251580 RSI: ffffffffa90736c8 RDI: ffffffffc04=
06470
[   15.899004] RBP: 0000000000000006 R08: ffffffffa9251670 R09: 65686374616=
d7369
[   15.899004] R10: 000000002e2e2e20 R11: ffffffffc03fdc69 R12: 00000000000=
00000
[   15.899004] R13: ffff8b2c022ee000 R14: 0000000000000000 R15: 00000000000=
00002
[   15.899004] FS:  00007f0a6e7e86a0(0000) GS:ffff8b2c1f500000(0000)
knlGS:0000000000000000
[   15.899004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.899004] CR2: 00000000010ddfd0 CR3: 0000000001bc8000 CR4: 00000000000=
006e0
[   15.899004] Call Trace:
[   15.899004]  <TASK>
[   15.899004]  lkdtm_CFI_FORWARD_PROTO+0x30/0x57 [lkdtm]
[   15.899004]  direct_entry+0x129/0x137 [lkdtm]
[   15.899004]  full_proxy_write+0x5b/0xa7
[   15.899004]  vfs_write+0x142/0x457
[   15.899004]  ? __x64_sys_wait4+0x5a/0xb7
[   15.899004]  ksys_write+0x69/0xd7
[   15.899004]  do_syscall_64+0x4f/0x97
[   15.899004]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   15.899004] RIP: 0033:0x7f0a6e76dfe1
[   15.899004] Code: be 07 00 00 00 41 89 c0 e8 7e ff ff ff 44 89 c7 89
04 24 e8 91 c6 02 00 8b 04 24 48 83 c4 68 c3 48 63 ff b8 01 00 00 03
[   15.899004] RSP: 002b:00007ffe32e133c8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[   15.899004] RAX: ffffffffffffffda RBX: 00007f0a6e7e8690 RCX: 00007f0a6e7=
6dfe1
[   15.899004] RDX: 0000000000000012 RSI: 0000000001ad5910 RDI: 00000000000=
00001
[   15.899004] RBP: 0000000000000001 R08: fefefefefefefeff R09: fefefeff00a=
bff4e
[   15.899004] R10: 00007f0a6e7e92b0 R11: 0000000000000246 R12: 0000000001a=
d5910
[   15.899004] R13: 0000000000000012 R14: 00007ffe32e13501 R15: 0000000001a=
d2450
[   15.899004]  </TASK>
[   15.899004] Modules linked in: lkdtm
[   15.899004] Dumping ftrace buffer:
[   15.899004]    (ftrace buffer empty)
[   15.925612] ---[ end trace 0000000000000000 ]---
[   15.925661] RIP: 0010:lkdtm_indirect_call+0x14/0x20 [lkdtm]
[   15.925689] Code: c7 c2 76 02 40 c0 48 c7 c1 95 00 40 c0 e9 3b cb 3e
e8 0f 1f 40 00 49 89 fb 48 c7 c7 70 64 40 c0 41 81 7b fa a5 52 0c 7f
[   15.925697] RSP: 0018:ffff9d928029fdc0 EFLAGS: 00000283
[   15.925709] RAX: 0000000000000027 RBX: ffffffffc0406320 RCX: 024cef129f4=
58500
[   15.925716] RDX: ffffffffa9251580 RSI: ffffffffa90736c8 RDI: ffffffffc04=
06470
[   15.925722] RBP: 0000000000000006 R08: ffffffffa9251670 R09: 65686374616=
d7369
[   15.925731] R10: 000000002e2e2e20 R11: ffffffffc03fdc69 R12: 00000000000=
00000
[   15.925739] R13: ffff8b2c022ee000 R14: 0000000000000000 R15: 00000000000=
00002
[   15.925746] FS:  00007f0a6e7e86a0(0000) GS:ffff8b2c1f500000(0000)
knlGS:0000000000000000
[   15.925755] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.925762] CR2: 00000000010ddfd0 CR3: 0000000001bc8000 CR4: 00000000000=
006e0
[   15.925889] Kernel panic - not syncing: Fatal exception

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig               |  2 +
 arch/x86/include/asm/cfi.h     | 22 +++++++++
 arch/x86/include/asm/linkage.h | 12 +++++
 arch/x86/kernel/Makefile       |  2 +
 arch/x86/kernel/cfi.c          | 83 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c        |  4 +-
 6 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/cfi.h
 create mode 100644 arch/x86/kernel/cfi.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df6..8b8c12b223ae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -108,6 +108,8 @@ config X86
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
index 000000000000..86a7b727ed89
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
+#endif /*CONFIG_CFI_CLANG */
+
+#endif /* _ASM_X86_CFI_H */
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.=
h
index 85865f1645bd..0ee4a0af3974 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -25,6 +25,18 @@
 #define RET	ret
 #endif
=20
+#ifdef CONFIG_CFI_CLANG
+#define __CFI_TYPE(name)					\
+	.fill 7, 1, 0xCC ASM_NL					\
+	SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)	\
+	int3 ASM_NL						\
+	int3 ASM_NL						\
+	mov __kcfi_typeid_##name, %eax ASM_NL			\
+	int3 ASM_NL						\
+	int3 ASM_NL						\
+	SYM_FUNC_END(__cfi_##name)
+#endif
+
 #else /* __ASSEMBLY__ */
=20
 #ifdef CONFIG_SLS
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 03364dc40d8d..2a3dc7e3e6ca 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -145,6 +145,8 @@ obj-$(CONFIG_UNWINDER_GUESS)		+=3D unwind_guess.o
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
index 000000000000..7954342b2b3a
--- /dev/null
+++ b/arch/x86/kernel/cfi.c
@@ -0,0 +1,83 @@
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
+	 * =C2=A0 cmpl=C2=A0 =C2=A0 <id>, -6(%reg)	; 7-8 bytes
+	 *   je      .Ltmp1		; 2 bytes
+	 *   ud2			; <- addr
+	 *   .Ltmp1:
+	 *
+	 * Both the type and the target address can be decoded from the
+	 * cmpl instruction.
+	 */
+	if (copy_from_kernel_nofault(buffer, (void *)regs->ip - 10, MAX_INSN_SIZE=
))
+		return false;
+	/*
+	 * The compiler may not use r8-r15 without retpolines. Skip the
+	 * first byte if it's not the expected REX prefix.
+	 */
+	if (buffer[0] !=3D 0x41)
+		++offset;
+	if (insn_decode_kernel(&insn, &buffer[offset]))
+		return false;
+	if (insn.opcode.value !=3D 0x81 || X86_MODRM_REG(insn.modrm.value) !=3D 7=
)
+		return false;
+
+	*type =3D insn.immediate.value;
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
2.36.1.476.g0c4daa206d-goog

