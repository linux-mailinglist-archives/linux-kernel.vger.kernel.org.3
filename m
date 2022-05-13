Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB44526B29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbiEMUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384128AbiEMUWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0C15C1AC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d134-20020a25e68c000000b006483b1adcc3so8189090ybh.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=JmUcB71UJsapD3GVrO4eUWV0XUj+8/03004nVnvcXak=;
        b=q+waAbIPDqPXiH8Wgpa93Fc43zirFgzfaoRzu0Q5jNfW74oP0t5HWD2wC1p1VHbruB
         7qYzcZ894qexmN06FGKvFmNxzmoZjlpErpk9CisCKJylmj/NZCW/7c+4QXNZUzkOyqY5
         ZmrN+OotCHK0Zxe6n6widKeoxY6e4P6cB5hh8ACBmzF3WPinJVT7094cUhFIg4g9rOgH
         HrYQk4QQjb3Yg8txeGH/fxa1z+bPXdFTIoOUn6STFBkAo5+racs7j7HLOp+WR7/u5i9Z
         fbE+JWGAc+uThCpOJoTMigL5puZSpV0KB0FiT9EKn/mSiY0cT9VjwEJD/StPJlOU0Cev
         8cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=JmUcB71UJsapD3GVrO4eUWV0XUj+8/03004nVnvcXak=;
        b=yPcr73N6ETTNB7aM1PAVICtCfii0o9bXAuwhbD+LMR4hhxJQEQVmZJ22tDOX8oFu07
         y/P4qfjh4AlXdwPohQvbtttEYSR0fojOS9o6YKsQ/pOSeFXi/dmD78AeQF4l9bdCzAKn
         CxVY3UFCrgxAFAxMCEvyklvZQFX3VFqczzCyOAlRa4dmRAP2vxoFIMiVtJJF/0OdlEk5
         EEU9G67kHhTY+18EWtksgttLr+QaW//WZVt9CaSHOtWe3ootTwylY8VbkA4gRDg+cos1
         gyxGk6NZ+G0A7rfZVOLtRzh5MYgozwKjtO90KNmZ6xOJ4htUfEMGpXsp2CQb/5dnmsOI
         DsKg==
X-Gm-Message-State: AOAM530Wbg9sO6ksWF6J84wUDxRN1ZGBYAsV5rZDhrI5tGxB1l37iynW
        kZE/vy68nuYWN/QhXVYMmvHhtIjl4FkDC/YdvTdoD18Dr+jn62hrydK8MSy2vcA30fgqtOoXGKD
        Ou/7KwwBjibIN9ElsHIGQ/foxsNeEURf6PfoD1JP0x5dTsWkg0xZHJwT4Vp/a1f/lbwKz0m55pi
        nf1iiMRwqBrw==
X-Google-Smtp-Source: ABdhPJxGXIqwfLWWVdQxKuBrR4ghlUD/U84TY8XUBMGdfyRVGJlvO7KK85ebE9nSek/CneTaJ2zwEZeCATeLZcT7B6g=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:ca0b:0:b0:648:3e2d:3f1e with SMTP
 id a11-20020a25ca0b000000b006483e2d3f1emr6403961ybg.362.1652473367748; Fri,
 13 May 2022 13:22:47 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:58 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; h=from:subject;
 bh=bn6mttx/+N79EqzqH4lUGVrrHJpkhXhGEyYfvAshG7g=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3miAgPARrfh1jZo/AMj9afOxuevNvNz1zEXoxO
 T5E2BAmJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695gAKCRBMtfaEi7xW7uTzC/
 9b9JUjgkRS+vIpbCBv2wAQzLNRFHZegpFnvMQoIRaCvqoY5boY6o0Xuz4QszhTRn1+ascJMVcRMW6Z
 oHJDJPwlebdNS6OMzh83h9gqPCPvFqtHxuUILPy4WV3SidB7tv86rJaDoTIajuK3Ea40avqwWsmfOF
 aRuH7ecXZnSmH7uiY0mhXR/DbiXrBK5xh4ZTiuCx307rT3EhXyn6Ct4FnxDH9pCtH73EbaXflqQkBa
 ryRG4iDZf5TcRVeSDnJr+U81TkzvdCCXZmcWq4wo7r3BL3GeMZOZurN5sSNndagsAYijRCnfD5cj5o
 e4gPm+t6uteLjf2G920Xk43zl0MKhtuWtH2aeRse7fvHufNm5LLJjPTbMjQcA9/IvOaIMWixIS/bpw
 s2jg8SjAkgt4uypGp881cRfUjnY6/ujb0NCeb7C8YoA+20X4sdEJgSLx5vdf1D6AhEjOF5QG/7NyUa
 KNnOpBF6vXJPl0DlF3Ic+IY/CA2aDA/bukfnAaBt3CIeg=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
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

With CONFIG_CFI_CLANG, the compiler injects a type preamble
immediately before each function and a check to validate the target
function type before indirect calls:

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

Define the __CFI_TYPE helper macro for manual type annotations in
assembly code, add error handling for the CFI ud2 traps, and allow
CONFIG_CFI_CLANG to be selected on x86_64.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig               |  2 ++
 arch/x86/include/asm/linkage.h | 12 +++++++
 arch/x86/kernel/traps.c        | 60 +++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3abf444d..2e73d0792d48 100644
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
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1563fb995005..320e257eb4be 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -40,6 +40,7 @@
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
 #include <linux/ioasid.h>
+#include <linux/cfi.h>
=20
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -295,6 +296,62 @@ static inline void handle_invalid_op(struct pt_regs *r=
egs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
=20
+#ifdef CONFIG_CFI_CLANG
+static void decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
+			    unsigned long *type)
+{
+	char buffer[MAX_INSN_SIZE];
+	struct insn insn;
+	int offset;
+
+	*target =3D *type =3D 0;
+
+	/*
+	 * The compiler generates the following instruction sequence
+	 * for indirect call checks:
+	 *
+	 * =C2=A0 cmpl=C2=A0 =C2=A0 <id>, -6(%reg)	; 7 bytes
+	 *   je      .Ltmp1		; 2 bytes
+	 *   ud2			; <- addr
+	 *   .Ltmp1:
+	 *
+	 * Both the type and the target address can be decoded from the
+	 * cmpl instruction.
+	 */
+	if (copy_from_kernel_nofault(buffer, (void *)regs->ip - 9, MAX_INSN_SIZE)=
)
+		return;
+	if (insn_decode_kernel(&insn, buffer))
+		return;
+	if (insn.opcode.value !=3D 0x81 || X86_MODRM_REG(insn.modrm.value) !=3D 7=
)
+		return;
+
+	*type =3D insn.immediate.value;
+
+	offset =3D insn_get_modrm_rm_off(&insn, regs);
+	if (offset < 0)
+		return;
+
+	*target =3D *(unsigned long *)((void *)regs + offset);
+}
+
+static enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	if (is_cfi_trap(regs->ip)) {
+		unsigned long target, type;
+
+		decode_cfi_insn(regs, &target, &type);
+		return report_cfi_failure(regs, regs->ip, target, type);
+	}
+
+	return BUG_TRAP_TYPE_NONE;
+}
+#else
+static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	return BUG_TRAP_TYPE_NONE;
+}
+#endif /* CONFIG_CFI_CLANG */
+
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled =3D false;
@@ -312,7 +369,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
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
2.36.0.550.gb090851708-goog

