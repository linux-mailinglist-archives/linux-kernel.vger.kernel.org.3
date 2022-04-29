Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55FA5155D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381078AbiD2Ulx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380988AbiD2UlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334B48302E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f83cc145edso84229907b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=CBFSOSCWmXZdYTn8wlTZ3Rj5NSKYEySXgB9hFZpDWcQ=;
        b=ZMe9V/MSuwf8udmciH8lqoba83OKO8v0g4K1vzIlxr2talii7K7Ys0ordrrMAHe+pp
         DaqLObTTros84C3FoilHwVOlv/STu0KhGjugyeK349pAgMRnv4wFfKGXK66cTNEK/E/2
         9CS4D6qXyibLUANPFQftw9xg5fy6QMtOA2/GCKenixGS3WyJxUkAAE2Fomn5XE4N6+Fu
         MH4isN9/BTjRcs0gsnSNZkRVTC/M1BBUGL5BQ+8ljr9lJua+F/PodDy+y3v9FvpxQypS
         cIBtMTLJxrS2yefnyXe+cpHCAo5gcyjEL1MfDZsZasLEWiGX5qs2r02D/2wLWwBVNFNQ
         E5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=CBFSOSCWmXZdYTn8wlTZ3Rj5NSKYEySXgB9hFZpDWcQ=;
        b=qTbOcLwTplclexPcQwXJwfDXtwXuCMNyyfrNu0AEYajtL05XR/3baDmySB/BWRm/Tn
         gfhhE4GWD7An0SdYA6qbvpzcmhKDMZUis8TTsF/vP4UBqhnmhiuFmFN55Ya65surdPDr
         Z9QKRmCAZzdkgil3yxGNma8xClMohNXnqdRIa4ulRmn3tUlfk2Z3+0fDz/W2jI2fq+OD
         fJu/ZHiOeTfstHBfStFFE/4MZW6T33gcqfYB4s6xRIj9OptP4Tps+aW8cJIwrmd4yCe4
         Zan6qqCs+H9rlSXkB7sN9EGL8M1jje99WRxGYx3M01M+LZT3So5BDYrvqFTcFzYHl3A+
         AQNA==
X-Gm-Message-State: AOAM532MaqcNN/0d77N5AS8OGp5uQin8bjdjxyUJ4wqmYXnOhE6DIGLA
        eoXpyl1JnCWekZHvUeumzGMYmKux2OgzJ6Hc6jCOMtOpRzUx6wzqQMVTI/duYB7iG9ZxHbhDeyH
        0mVZCuSN4MoP5hoomIKJRyWIx7d+rOaR6WHdQQ0yuzk6kOUWHvDqjIhImS7exPzowtl/dlshoV0
        Fcp2F4eBPAEg==
X-Google-Smtp-Source: ABdhPJz3PRZnRDaYveY8PEOrWLh5TwRRZFIgz/hxn66OLDYa/VrKRiT3aho8JsA1WKfUtkL1urGOjyBFCiYVRzF+Yvc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:e0d3:0:b0:645:77c9:4e31 with SMTP
 id x202-20020a25e0d3000000b0064577c94e31mr1243653ybg.97.1651264657838; Fri,
 29 Apr 2022 13:37:37 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:44 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169; h=from:subject;
 bh=uFL18k3KC4iCKF4AXgGD1Mq4jj5gai1wigbzvC9PP/o=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExY2LifXNevk1TsxQ0IeoobF4r0E0uMXfS+2IhA
 yLd8T56JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMWAAKCRBMtfaEi7xW7ou7DA
 CVtuVd3sKEK3z2ChoeiIcGcU8iukBN8OM/HXmzh3pZq6yVg67wrrJiJ5oCCKPR2sRaYP0t6MSn772K
 l5U4p82O/prDh9AK0kKeyaSy4kvxVMyegTBCTiWzEC3tN48aXVcmI3dMp98RL7LGQzu9v4CLIEVaAa
 ZyLplEa810jUrIxOZER6sZfDmqUN7V/0ZKKzwsynPVXj76wvte6NCWe3NJ/ZxHTKwz2evdYtezNBOs
 w5UmruzJ3X4BM+NXqEmVZVfauFH9okVc4aHyl3C0tSJ4hQddWslVlW6jiD7FczG0DVtfhYaktcY3yZ
 335Ly2E9sGHsooiWLotHkG2PgPaJ+Jhfa2cw8T3990e55MXFQKaNXNTCRXA+Qq5C7qXBuPFrmbgIz1
 isZNNgIYvj+7LUjbO4NBInJYbyLkQMpgNLLqoZq/7hfv1xoJcIZg4CS+1iAmr+3dOxn1GAj/d/7CTi
 jKj9QZzAlA88rYhDAQ3LbORG2j6VAUCtSo+oWCun3pPF8=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 21/21] x86: Add support for CONFIG_CFI_CLANG
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

Add CONFIG_CFI_CLANG error handling and allow the config to be selected
on x86_64.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/linkage.h |  7 ++++++
 arch/x86/kernel/traps.c        | 39 +++++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..01db5c5c4dde 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -108,6 +108,7 @@ config X86
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <=3D 4096
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.=
h
index 85865f1645bd..d20acf5ebae3 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -25,6 +25,13 @@
 #define RET	ret
 #endif
=20
+#ifdef CONFIG_CFI_CLANG
+#define __CFI_TYPE(name)			\
+	.fill 10, 1, 0x90 ASM_NL		\
+	.4byte __kcfi_typeid_##name ASM_NL	\
+	.fill 2, 1, 0xcc
+#endif
+
 #else /* __ASSEMBLY__ */
=20
 #ifdef CONFIG_SLS
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1563fb995005..b9e46e6ed83b 100644
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
@@ -295,6 +296,41 @@ static inline void handle_invalid_op(struct pt_regs *r=
egs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
=20
+#ifdef CONFIG_CFI_CLANG
+void *arch_get_cfi_target(unsigned long addr, struct pt_regs *regs)
+{
+	char buffer[MAX_INSN_SIZE];
+	int offset;
+	struct insn insn;
+	unsigned long *target;
+
+	/*
+	 * The expected CFI check instruction sequence:
+	 * =C2=A0 cmpl=C2=A0 =C2=A0 <id>, -6(%reg)	; 7 bytes
+	 *   je      .Ltmp1		; 2 bytes
+	 *   ud2			; <- addr
+	 *   .Ltmp1:
+	 *
+	 * Therefore, the target address is in a register that we can
+	 * decode from the cmpl instruction.
+	 */
+	if (copy_from_kernel_nofault(buffer, (void *)addr - 9, MAX_INSN_SIZE))
+		return NULL;
+	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
+		return NULL;
+	if (insn.opcode.value !=3D 0x81)
+		return NULL;
+
+	offset =3D insn_get_modrm_rm_off(&insn, regs);
+	if (offset < 0)
+		return NULL;
+
+	target =3D (void *)regs + offset;
+
+	return (void *)*target;
+}
+#endif
+
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled =3D false;
@@ -312,7 +348,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN) {
+	if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN ||
+	    report_cfi(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN) {
 		regs->ip +=3D LEN_UD2;
 		handled =3D true;
 	}
--=20
2.36.0.464.gb9c8b46e94-goog

