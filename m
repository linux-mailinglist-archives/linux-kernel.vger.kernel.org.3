Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40426526B25
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384228AbiEMUWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384129AbiEMUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84787158D7D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f84aeb403fso80739497b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WU3889iAo2cV03hsiSf5x6zZ/LJ50Xw+92L/EGbhqXo=;
        b=pZmQDolJvtI0oNoMjFNSs3O4PlnuoIjxWCSUTvNrtCNsWJ/IOfR8nWwmexM+XOZ6VX
         OBRVl1lCMhpAir8Qb7vKRhjqFO/0FzS9EVJ3+fXOBepXFdP/5tbt6Qv8F2FqZSU9iKzE
         atW4/BeR2eJaG9x3o1pDimccoqSy9pLSqz1jExrKsvRGU9cfglLErk9kp4JuLSKg0iXS
         p7fMRI12tbpyBZuSMGUPY12uCE6PP8eUbAqRAoWl+/m1mgK57/DCD4cUyoxzFnUaZNSf
         aHJ6m/fhSPutclhWYUwr7oDegK72KoFH6Dh5q/VvXM8pxI4DquPJOfYPsJN9ew1qZ1WE
         ADnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WU3889iAo2cV03hsiSf5x6zZ/LJ50Xw+92L/EGbhqXo=;
        b=1Bq5cAmrQKpDEZK2cYQyI5wCsdwh9Adhitr2hTiPJ+NSK9E56qYX6hkG8VqPQBGORX
         /7uuk31s+BTAHcVmna+zDpyPYNbFgKV5DFH+9DAYkFSh47KPOkGPf0wMC2LLGC76ZXgt
         iju+Pxnuil77cf66FAsSkXdz6/yl6GtB6H85846gXdOLy7bQn4bM+rxhlCWULkBnLcxB
         2s/EXfAaxtuyPDEmu73orYNQe0valkz9Fz/yK1PULbJjM9ZVd9gYe6RpiUkJWg0HnQOM
         ZQaBhKvrT6kSCz/ruuUBJO/+CczVWdWRhU8KZk6nQuM1WXaB66eZ2C+JO05GKXblAZXm
         yrdQ==
X-Gm-Message-State: AOAM533zyNMwnWI3bSf3NHIj4H/L7zOu1xuemsEQL012r0A5TIJ8UxS0
        2s/qmezoWqkO0nI98tSuLrjOnYhkK61znnpiT7S1h6XvRMYCeMHjfu9OGFjnmcR2Nz0leyEJ/KK
        ktI9AP0Bu9YBvmIUpkBzBycI5atC4FzaAmYnIBO9TnxwkYw7n/WdU1h09GUQgdgugVjenjfNvr9
        zLw4qeZisgbw==
X-Google-Smtp-Source: ABdhPJwxuELEVPnOQKDtqsVDrkvVAVIRZ1hdHAD2MT+Q+cgbmxzoKXzbrC/MSqHsHIXSfCC9M9j87P/P+HCKcQRnswM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:83d1:0:b0:648:725c:6a05 with SMTP
 id v17-20020a2583d1000000b00648725c6a05mr6581691ybm.218.1652473333130; Fri,
 13 May 2022 13:22:13 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:43 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; h=from:subject;
 bh=NEJlZMdKjd8Zr3EJq4f2U/eOaR2VOw8ZJNPjD2WS5Pg=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3jsP84AqoF0iPnb8FMjL+St7Zjb6XNSfFd8CUa
 8toyEnOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694wAKCRBMtfaEi7xW7tzdC/
 9mHIFZ0j3RnJTawg3pYHmudgAx+YsmdirdE8TFxUnZEf8oHYhTkUlg7HOO3hmf5f63KPJpAii3HWfP
 x9V4qiLz1iAjZ0nt29HurNVlJJwPrPHCAzqmcDL1HncXMzkbJCseEu7h4oldZ0nXQ7G3T9XRplwELO
 IavmbB2Eijy2MIkwJHs2c3dCXg0Cara5MVl2GeFuFSmIZT4Jfdu6GT1fM4vEYPmHgtRZg4pcRK945G
 ub5OI9K19suVmpGxkPlg11HeNJe+o1hoAN0OzNEWwfEVNOULVaVwV8SCEq/g+cRVB3Jm4A7GIlI1Ai
 jgefyruG8c3xYc+hsnDXmBQE99RIclVfn5GRqT/+Z79fNQc5HgKRvjxaAYVxs4BN+XC8VSPP6q0WCL
 csImxtt33P9GdjW7kYGIYq2IF+1wiH5U4iUzV8w7ibhTmTsyza3JW86J49V7i7sEKr99x0QPmP0u2e
 AbGrPE5JTOJt2ddxl3S8VQALAnKF+pj9AN9XiaFcxAkWU=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 05/21] cfi: Drop __CFI_ADDRESSABLE
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __CFI_ADDRESSABLE macro is used for init_module and cleanup_module
to ensure we have the address of the CFI jump table, and with
CONFIG_X86_KERNEL_IBT to ensure LTO won't optimize away the symbols.
As __CFI_ADDRESSABLE is no longer necessary with -fsanitize=kcfi, add
a more flexible version of the __ADDRESSABLE macro and always ensure
these symbols won't be dropped.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/cfi.h      | 20 --------------------
 include/linux/compiler.h |  6 ++++--
 include/linux/module.h   |  4 ++--
 3 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 4ab51c067007..2cdbc0fbd0ab 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -13,26 +13,6 @@ typedef void (*cfi_check_fn)(uint64_t id, void *ptr, void *diag);
 /* Compiler-generated function in each module, and the kernel */
 extern void __cfi_check(uint64_t id, void *ptr, void *diag);
 
-/*
- * Force the compiler to generate a CFI jump table entry for a function
- * and store the jump table address to __cfi_jt_<function>.
- */
-#define __CFI_ADDRESSABLE(fn, __attr) \
-	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
-
-#else /* !CONFIG_CFI_CLANG */
-
-#ifdef CONFIG_X86_KERNEL_IBT
-
-#define __CFI_ADDRESSABLE(fn, __attr) \
-	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
-
-#endif /* CONFIG_X86_KERNEL_IBT */
-
 #endif /* CONFIG_CFI_CLANG */
 
-#ifndef __CFI_ADDRESSABLE
-#define __CFI_ADDRESSABLE(fn, __attr)
-#endif
-
 #endif /* _LINUX_CFI_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 219aa5ddbc73..9303f5fe5d89 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -221,9 +221,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * otherwise, or eliminated entirely due to lack of references that are
  * visible to the compiler.
  */
-#define __ADDRESSABLE(sym) \
-	static void * __section(".discard.addressable") __used \
+#define ___ADDRESSABLE(sym, __attrs) \
+	static void * __used __attrs \
 		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
+#define __ADDRESSABLE(sym) \
+	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer
diff --git a/include/linux/module.h b/include/linux/module.h
index 1e135fd5c076..87857275c047 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -132,7 +132,7 @@ extern void cleanup_module(void);
 	{ return initfn; }					\
 	int init_module(void) __copy(initfn)			\
 		__attribute__((alias(#initfn)));		\
-	__CFI_ADDRESSABLE(init_module, __initdata);
+	___ADDRESSABLE(init_module, __initdata);
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
@@ -140,7 +140,7 @@ extern void cleanup_module(void);
 	{ return exitfn; }					\
 	void cleanup_module(void) __copy(exitfn)		\
 		__attribute__((alias(#exitfn)));		\
-	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
+	___ADDRESSABLE(cleanup_module, __exitdata);
 
 #endif
 
-- 
2.36.0.550.gb090851708-goog

