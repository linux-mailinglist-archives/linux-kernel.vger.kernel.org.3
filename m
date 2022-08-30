Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE65A71D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiH3XcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiH3Xb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:31:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D172ED6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-335420c7bfeso190442617b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=0HP0uvA43ZQ58UUEba95S/Hbn9bJWLpeKEcRZB7IkXA=;
        b=ghb+rAa5ndgfqqr1NGpj3Hx6OHHlYOvrZzYCRI/I0/miJPOMqpLi/jhEUs2NH2NsEc
         /Ie0pR/+KK0EpPSfo2+MSyuwv9kXWCPQgPpE/IQyplk/uPBLsy0O2n7981PKrvD2qwU/
         /XqQ2YnPcfjDwmCTI/O7ouDWr8I3Z23ZapI5UL1g+VUEUYsYJMoysuPXY0l1ifZp7v71
         kNmzxgiEgj3F/lwbmST95w1f1EQLii1VabTMGgwHmxeB2fmw4s7/zdmFKJmeH3rqia8I
         vAkK8Z3YrqGIBToXA+hfumAn+ch2w6F+Q77YzLz9AqoPncgKoQO8nzqIN12e54mn8fXP
         HJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=0HP0uvA43ZQ58UUEba95S/Hbn9bJWLpeKEcRZB7IkXA=;
        b=dfHGrBNE5yZiWH9k2eL3eGxai8XZxE7iViO/tCFLDC9VwpzIEUtuRjo4U4hexL8IOU
         VewMo1GS0DEg6og1YwkmDBBK+Y6mH1CkbxON+e93SdhS6OAfpVMG4FEeXRI+gb01v5yj
         mtAT3M16yW22hlNPKjjJIheeP7G76csbIev3mwfIAsvTJxrKC8d2cFU1uR2OGdYn1BxG
         lxZ0q/SJH68j/9QZKkrWRhfIRbFZKPggJMVzDntcZ2lFszL8F3dFycM7CEQtgHEReYqY
         UYnQXZj6E6aWVzONXyHog1RqiWcvvq3zvemEYiQFJZ+qkzu07fUaX4QTWkqUbAFChCn/
         ELVA==
X-Gm-Message-State: ACgBeo2LS/K6/1AZomNLemSEg7hEhGoWF7+wQ6ArLxQHPBhF9bvputDz
        0+fsVCUuFtPkzbYc7NsFvQ0JEn4csFNrKFB7pT/9hb5xdQEyg8EQY5nA1L5Y9wxLGYDrMwEtr8F
        jO9rpCXGTglRIuOXpMucBlNO4UVRwMMMBh73QadB5XjAFx6HfatL9p/TASAE9q+iwfW8UTBXzR1
        GtmzO/FBOSBg==
X-Google-Smtp-Source: AA6agR7E6sFZT9PUzkGGP3q3+LDqH6QwHWXnwCTK8ZHH2q+uNYehXvHgWXx3+rlvntWf3vAkts/Bo0e9KvQON7ecMBI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a25:ba51:0:b0:683:c:f71 with SMTP id
 z17-20020a25ba51000000b00683000c0f71mr13158853ybj.51.1661902309437; Tue, 30
 Aug 2022 16:31:49 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:14 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3855; i=samitolvanen@google.com;
 h=from:subject; bh=GpNP7VSNWEHryZQIbE63CWLGUtZrRNNHgFNGIsCcLD4=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3M+D27Vh42dz5Wv1D7BtVLA+c02bXPeMllsUQG
 nbALH5eJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzAAKCRBMtfaEi7xW7oO6C/
 94PkporT0a7ea4yN99Y0UVpECqA2sx1W3i2E3Ta36aou4DLUlkkK11bJAHilB90A47YnMhOyD+xQgt
 qKKB3pKeDH8pGEOLtNrtnEcXa8Crfg92HjaovTQVUu0/EZPE04ME54eNDEPYc3a+V4i5acQbwfayOD
 B0FHeJLg7YmKTXdSQw1OCZqJmfO723qcQ/XI/eRxbqrZQyEVq3N662FBhRI1BZwJyxJGUKVFjALx7E
 W60FTV25BYf9dy7O8xvh++ELkTTfrKeFtMnwnAfkOl9A6vmx9T8d7OAI7sBn0/8K3nzWRQuWYrqV66
 mjnnzUqYPDcgxJBn9EC2aNqti/tAGgC6PtM1uERqT1VdgPrWwYG246O0IZM1z5wznrj1DnlrMmT0+a
 mBAL9oB8jrEBtQ/SRxdAZbh+LkXmAx2XKKBltPHK3GvAUGxPGlOLjFBMbKvbSO3jtAV3m2OqXpjGF0
 td+Ah0KUqN8vnfBbB9WQZO9fsTb6Obx8Mpa2GsG77Z11w=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 06/21] cfi: Add type helper macros
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, assembly functions called indirectly
from C code must be annotated with type identifiers to pass CFI
checking.  In order to make this easier, the compiler emits a
__kcfi_typeid_<function> symbol for each address-taken function
declaration in C, which contains the expected type identifier that
we can refer to in assembly code.

Add typed versions of SYM_FUNC_START and SYM_FUNC_START_ALIAS, which
emit the type identifier before the function. Architectures that
support KCFI can define their own __CFI_TYPE macro to override the
default preamble format.

As an example, for the x86_64 blowfish_dec_blk function, the
compiler emits the following type symbol:

$ readelf -sW vmlinux | grep __kcfi_typeid_blowfish_dec_blk
121794: ffffffffef478db5     0 NOTYPE  WEAK   DEFAULT   ABS
	__kcfi_typeid_blowfish_dec_blk

And SYM_FUNC_START will generate the following preamble based on
the __CFI_TYPE definition for the architecture:

$ objdump -dr arch/x86/crypto/blowfish-x86_64-asm_64.o
     ...
00000000000003f7 <__cfi_blowfish_dec_blk>:
     3f7:       cc                      int3
     3f8:       cc                      int3
     3f9:       8b 04 25 00 00 00 00    mov    0x0,%eax
                        3fc: R_X86_64_32S __kcfi_typeid_blowfish_dec_blk
     400:       cc                      int3
     401:       cc                      int3

0000000000000402 <blowfish_dec_blk>:
     ...

Note that the address of all assembly functions annotated with
SYM_FUNC_START* must be taken in C code that's linked into the
binary or the missing __kcfi_typeid_ symbol will result in a linker
error with CONFIG_CFI_CLANG. If the code that contains the indirect
call is not always compiled in, __ADDRESSABLE(functionname) can be
used to ensure that the __kcfi_typeid_ symbol is emitted.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/cfi_types.h | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 include/linux/cfi_types.h

diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
new file mode 100644
index 000000000000..dd16e755a197
--- /dev/null
+++ b/include/linux/cfi_types.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Clang Control Flow Integrity (CFI) type definitions.
+ */
+#ifndef _LINUX_CFI_TYPES_H
+#define _LINUX_CFI_TYPES_H
+
+#ifdef CONFIG_CFI_CLANG
+#include <linux/linkage.h>
+
+#ifdef __ASSEMBLY__
+/*
+ * Use the __kcfi_typeid_<function> type identifier symbol to
+ * annotate indirectly called assembly functions. The compiler emits
+ * these symbols for all address-taken function declarations in C
+ * code.
+ */
+#ifndef __CFI_TYPE
+#define __CFI_TYPE(name)				\
+	.4byte __kcfi_typeid_##name
+#endif
+
+#define SYM_TYPED_ENTRY(name, fname, linkage, align...)	\
+	linkage(name) ASM_NL				\
+	align ASM_NL					\
+	__CFI_TYPE(fname) ASM_NL			\
+	name:
+
+#define __SYM_TYPED_FUNC_START_ALIAS(name, fname) \
+	SYM_TYPED_ENTRY(name, fname, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#define __SYM_TYPED_FUNC_START(name, fname) \
+	SYM_TYPED_ENTRY(name, fname, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#endif /* __ASSEMBLY__ */
+
+#else /* CONFIG_CFI_CLANG */
+
+#ifdef __ASSEMBLY__
+#define __SYM_TYPED_FUNC_START_ALIAS(name, fname) \
+	SYM_FUNC_START_ALIAS(name)
+
+#define __SYM_TYPED_FUNC_START(name, fname) \
+	SYM_FUNC_START(name)
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_CFI_CLANG */
+
+#ifdef __ASSEMBLY__
+#define SYM_TYPED_FUNC_START_ALIAS(name) \
+	__SYM_TYPED_FUNC_START_ALIAS(name, name)
+
+#define SYM_TYPED_FUNC_START(name) \
+	__SYM_TYPED_FUNC_START(name, name)
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_CFI_TYPES_H */
-- 
2.37.2.672.g94769d06f0-goog

