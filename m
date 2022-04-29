Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278E65155DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380899AbiD2UlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380854AbiD2Uk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448A83B24
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a5b0b46000000b006457d921729so8367601ybr.23
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=5hCa0Th+W5/EJvbV2Mxb+ItoW5xxwAS7kF6LUvID5mc=;
        b=S0N+CrTDZPvcK92q2enU+oVhR8rVjO0uZ5+G+H/+XSr0HLDhtVQlnf3XdP2RpmbQTB
         qxib2RNe+lgYyVAC/K4UeXT5QGc0R00zizFDHp3tWHZqzalRZrtj6xsSrA36fRYOAmHY
         RnJyYZqHEruYZOOBGjwd/Go7AWOCMlZ5QMLRILy3Ev8qGB/6Y0qYjhU14rV+0nU/g/sH
         M3hWk+95HJeec8dFyf5hxRyv7r+cCx02MHG30C9DdAWXmaBjn4GAy2+GpXeVpkmkD2hV
         Yi/dbME+Gg3iSIXmapnP/Ol0jDRfngnUdvKw1FSR5l6MFtv3fNCo0nEc7aXEBh0Hu06o
         3vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=5hCa0Th+W5/EJvbV2Mxb+ItoW5xxwAS7kF6LUvID5mc=;
        b=uGvSGOTS2bnNcLn2glA5O3Qm59noIOWTTJy52HPchqx9V7hDZFs736P1Fy5M4/sKbm
         hpRPsvR0pBm5GfiDYXry3sBKbSS/q9SkohVGKT2SEInBwKIAPIHfrp327yq4gRvoXSEr
         lYvyfXfJbnS+ezNO7fDvuXaK/ur/mcXFwAFVfbGcW8dcJLHt3zLLfFbiVPD3ROc02Ug/
         xChAeNIt+jDbd1+NcwR1zGf3boOZyoS6L9PVS55jRdVIk1a8aVRazsd/Lu8a6qVTWkw7
         xbelCnzH8jwmOGg2TvzfMvDgDdHp8ye3Af9nwxwFRQIJEXjw0r1/7Y3SsgZmuDEUKrGR
         CyhA==
X-Gm-Message-State: AOAM533NoqLIdObqomij+FFfJqGrbR/7UQGFclspkfJoyKC+rHl2WZGy
        sy/VABfiDaCJudXKzU0BQDHksqpo9nJ6JCxpxv3jRZadqsVI1L4rxhaauStlyWfPXz44Tj0CaVi
        1hG3lbtMQmFd9CR18gs+XgZiTXcj8IXu1GxpvO8DBaxYKhDLpQXmPS5ElvirWhuZki3fVNfqLLx
        +kvW0X9XsIWg==
X-Google-Smtp-Source: ABdhPJz+eDKnS2W33vUCyhR6WhYeLBeYAFhDRUfMiHJY50CUszLf61iMmFxt93d2j2RTvlyfCCPtlhqeWBFFGoC3YyE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:9d12:0:b0:63e:5463:9161 with SMTP
 id i18-20020a259d12000000b0063e54639161mr1245278ybp.520.1651264629191; Fri,
 29 Apr 2022 13:37:09 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:32 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4436; h=from:subject;
 bh=NE+VmE0GV2F5TAg2wjWn2y0FVE5ul0MCwcRd3JvOCxM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExWtMuY47WbpGwUnz3/EYOP7dO1dD9ixSIlsYG3
 x8Cd/pyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVgAKCRBMtfaEi7xW7rmmC/
 9YbnECwIsbp/HZ5mIfeFER1Ea+SidGBDwevjph92DWZRHHBk+vWKzcN4tx2RqzfmU/WvZ50K3w9BCw
 qwWWAs9udhv1ocs1hOPeO12RlgvSuSTw8kYQIJIrepC1qXFD3lUUl8yDxipO/T4mSTysgs5AReakBS
 Yt32fnxwnduGRpVjea7S6gSqDnZtoVDV7jrcJgyIG1SlDlZPKsIpn9+nE4fpaDVKsDQq5NGKa8UJKk
 3qfqREIt7aV262NXiQxLF1qGmNffIZgOSyxdY6tQWT9vrXbBCub2HgKUx+u2DEQHrveMTyg8Y8YT7+
 8Pms4AMGpH2I11QDsLNutbwe5QI70n3ytnK5J+apZiYU0Cv3lKxDt2Odxl623Ly+CVShBd2zIsafj2
 j14rVS/5d6DaDtTs5ckt62TAIZzmhvcZkyF+MULQnjhDQGhteaK9K5BCp74kSh0K92dYKMf4D44gK9
 4J75YA3echFB0WWw7aq3WXfsP+NT7W6VM6M20yqGC2sIA=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 09/21] arm64: Add CFI error handling
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -fsanitize=3Dkcfi, CFI always traps. Add arm64 support for handling
CFI failures and determining the target address.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/brk-imm.h |  2 ++
 arch/arm64/include/asm/insn.h    |  1 +
 arch/arm64/kernel/traps.c        | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-=
imm.h
index ec7720dbe2c8..3a50b70b4404 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -16,6 +16,7 @@
  * 0x400: for dynamic BRK instruction
  * 0x401: for compile time BRK instruction
  * 0x800: kernel-mode BUG() and WARN() traps
+ * 0x801: Control-Flow Integrity traps
  * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)
  */
 #define KPROBES_BRK_IMM			0x004
@@ -25,6 +26,7 @@
 #define KGDB_DYN_DBG_BRK_IMM		0x400
 #define KGDB_COMPILED_DBG_BRK_IMM	0x401
 #define BUG_BRK_IMM			0x800
+#define CFI_BRK_IMM			0x801
 #define KASAN_BRK_IMM			0x900
 #define KASAN_BRK_MASK			0x0ff
=20
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 1e5760d567ae..12225bdfa776 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -334,6 +334,7 @@ __AARCH64_INSN_FUNCS(store_pre,	0x3FE00C00, 0x38000C00)
 __AARCH64_INSN_FUNCS(load_pre,	0x3FE00C00, 0x38400C00)
 __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
 __AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
+__AARCH64_INSN_FUNCS(ldur,	0x3FE00C00, 0x38400000)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0529fd57567e..b524411ba663 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/mm_types.h>
 #include <linux/kasan.h>
+#include <linux/cfi.h>
=20
 #include <asm/atomic.h>
 #include <asm/bug.h>
@@ -990,6 +991,55 @@ static struct break_hook bug_break_hook =3D {
 	.imm =3D BUG_BRK_IMM,
 };
=20
+#ifdef CONFIG_CFI_CLANG
+void *arch_get_cfi_target(unsigned long addr, struct pt_regs *regs)
+{
+	/* The expected CFI check instruction sequence:
+	 *   ldur=C2=A0 =C2=A0 wA, [xN, #-4]
+	 *   movk=C2=A0 =C2=A0 wB, #nnnnn
+	 *   movk=C2=A0 =C2=A0 wB, #nnnnn, lsl #16
+	 *   cmp =C2=A0 =C2=A0 wA, wB
+	 *   b.eq=C2=A0 =C2=A0 .Ltmp1
+	 *   brk =C2=A0 =C2=A0 #0x801		; <- addr
+	 *   .Ltmp1:
+	 *
+	 * Therefore, the target address is in the xN register, which we can
+	 * decode from the ldur instruction.
+	 */
+	u32 insn, rn;
+	void *p =3D (void *)(addr - 5 * AARCH64_INSN_SIZE);
+
+	if (aarch64_insn_read(p, &insn) || !aarch64_insn_is_ldur(insn))
+		return NULL;
+
+	rn =3D aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn);
+	return (void *)regs->regs[rn];
+}
+
+static int cfi_handler(struct pt_regs *regs, unsigned int esr)
+{
+	switch (report_cfi(regs->pc, regs)) {
+	case BUG_TRAP_TYPE_BUG:
+		die("Oops - CFI", regs, 0);
+		break;
+
+	case BUG_TRAP_TYPE_WARN:
+		break;
+
+	default:
+		return DBG_HOOK_ERROR;
+	}
+
+	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	return DBG_HOOK_HANDLED;
+}
+
+static struct break_hook cfi_break_hook =3D {
+	.fn =3D cfi_handler,
+	.imm =3D CFI_BRK_IMM,
+};
+#endif /* CONFIG_CFI_CLANG */
+
 static int reserved_fault_handler(struct pt_regs *regs, unsigned int esr)
 {
 	pr_err("%s generated an invalid instruction at %pS!\n",
@@ -1063,6 +1113,10 @@ int __init early_brk64(unsigned long addr, unsigned =
int esr,
=20
 	if ((comment & ~KASAN_BRK_MASK) =3D=3D KASAN_BRK_IMM)
 		return kasan_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
+#endif
+#ifdef CONFIG_CFI_CLANG
+	if ((esr & ESR_ELx_BRK64_ISS_COMMENT_MASK) =3D=3D CFI_BRK_IMM)
+		return cfi_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 #endif
 	return bug_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 }
@@ -1070,6 +1124,9 @@ int __init early_brk64(unsigned long addr, unsigned i=
nt esr,
 void __init trap_init(void)
 {
 	register_kernel_break_hook(&bug_break_hook);
+#ifdef CONFIG_CFI_CLANG
+	register_kernel_break_hook(&cfi_break_hook);
+#endif
 	register_kernel_break_hook(&fault_break_hook);
 #ifdef CONFIG_KASAN_SW_TAGS
 	register_kernel_break_hook(&kasan_break_hook);
--=20
2.36.0.464.gb9c8b46e94-goog

