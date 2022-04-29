Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA955155C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380920AbiD2Ukg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380881AbiD2UkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F483B37
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 7-20020a250c07000000b0064137917a4eso8372970ybm.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=svE7kVFxuPlWWXguE8ak9oGVScd1Q4Hw38uYtQTvTB0=;
        b=FUoFYj7nrytyx4SQGCiHW92ijRaq67I39GZlpyGeR8NTM7JBhSVqrSH5XEo6AC3s33
         6YkKHAE2q9oeFmrTKUs1tSYTJjtAN96i5EtiDUrkHTNJ7F9pNyevX/fqtpTVyhzDlRbo
         ygW8w7mnl/f/ac4KYXkyTVBJCPUQ7uLY5KreI2pr7rOjr0HziZOezs6YJb+DRgvxqmvU
         2Ojm1ZLAjlxdV9gK1KqwV4JtQZcjNXSEYjw35XVQqvPjpeqRn7S3FLFze1rSeIrqplFC
         BTe4KL/fuc79sjwROMSFVnl3eKltBCdAdu+AkyhU0liNzqOkDRw1+i7197CedoqcHGSp
         XPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=svE7kVFxuPlWWXguE8ak9oGVScd1Q4Hw38uYtQTvTB0=;
        b=KECVbA/bcxjUUO+o5cYO7cOj2VR1Mc4Zq2IWbJcsXNKyGQhN7IrgkNiNehHEYy57/K
         b4ioPMcIe/i5h0+d817m5Yx6su+OntsCwUCb6mzCtyzKQjy8BxRbsseUfnVcgwBA4IDU
         2aVXpSkFAAAc3Gj9cLpJEe0tPBoWjKZAUoJ2R4cDY0FDsKFjkGvyV86YXICBCYwUlVRz
         zmML8h0hdJQq6wLFWfnhCMaGWJS5Ux3ACpqttutXIzRkctvmNQWwKL6hcd4eD+zu0/jH
         TlIxmm5gYNjlHEm2DfAV2LL1YVsvoefFb7DY3LKtcgKk8n4zB2CV8nBA6QSt1+QlutYp
         bw4A==
X-Gm-Message-State: AOAM532iP5BTWap1v0h1iRMXvkqfJhHatQOCLc6GJkT1KcByNCU6MwMJ
        gJbPwccElpkblZCj0bWicqGS9bgFBj8S+ek6OVYdFQ0dRV5aSfkw9f+Ar4wq5/E3bulBd8lqDhD
        TTqQcitMTm/Wgr83Fu+tgfTBGAWd4TWNnHP5nh5sm2MpChUl1rstj8PjBB+9S74VJRgt2SRAAIp
        aRTxPgRCoAnw==
X-Google-Smtp-Source: ABdhPJxy36VnWpTDmVaEj1n6wpH9g3bLRxJK7JnambFm4dQ2hqamT1j8SUFu5O05FMrvWlAjIaN1GHbxJVVSP4ly7Ts=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1ca:b0:648:b241:65be with
 SMTP id u10-20020a05690201ca00b00648b24165bemr1292760ybh.196.1651264620101;
 Fri, 29 Apr 2022 13:37:00 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:28 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; h=from:subject;
 bh=3j3iVyBHsh++mvfP+DxD8j3SrYI24EpoK/VyI7QxUVI=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExVHq3nlFPfzRWE27X7yYpyk4ANovqw9jbo7ZSD
 aCfwoPWJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVQAKCRBMtfaEi7xW7j1FC/
 9mpAG9wikAu1bkYBp0Lg/jv7Wm7fpH2DwKXLlccEeCa1pxSjoSVgx6wZkzGBqugwmN/O7ovT3GkjhQ
 eQ6wRcszZQ7fTIEvFK+vcaeg6XDDudg6DpaxZRR1dAMmt2yUCErrCLOe5tN/ft1R5yKnKLwGRHsYvV
 vUDHffcDPPv60LVfD+5wLq688gEgzU48LyD440gez0N1kY/vqObQpuQlHQTtBE/7qD2ulPR5JdMQu8
 st9Dh0JD/ATz/I1VA+tl38E7FpTEG0fkqECvMS++yK/JtdB1p+lWaUybht6V838s5BbAzbCBuCuG2h
 rAddbV72f5KNjs7b0k+EaHJ0fuNY9jPdM4AFqmgjTDBRmzBmkOUQ0U3lCDBj9dXLor5ywcTq2Iqk1G
 iUekvxJzPaoYKy4o2dQvYBH7YPC2qnSBfn+37GO62vDWM2ayd+N4wwOAQBmy23ARN3CsD5TKITf17Y
 OIawNg6pfn2v1zDPmU2ZUQnd5lwz6WXpEe195D//G1qwQ=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 05/21] cfi: Drop __CFI_ADDRESSABLE
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.36.0.464.gb9c8b46e94-goog

