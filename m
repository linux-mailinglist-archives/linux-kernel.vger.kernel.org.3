Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6658B5A71D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiH3XcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiH3Xbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:31:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3250B73925
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v8-20020a258488000000b00695847496a4so878294ybk.19
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=/z26CVzacxgEbflnpwOBeepGVQn0w/gPmhmQRvMvTvE=;
        b=knXPOMHFktRNITAj1a01OM3CJ8e080e27LpFBRrOUFH3xJW3DsuXf6xNsydCnmB7ss
         AOh27n5brdxOhb6MZN2qlgFyihfVdcbNjyg5emybKIIcdNOuntMurwAcuaFfXbR3L9bv
         9DwrEdiR0CiGt84G4ctQarxm0QKj1TN2/3DZsZ1dvaMGufwXfijsnUsyuePYsuDfuSdr
         nWR2GylNKGrU4/i/3+h+g4lPtcFh4/V24KBOlUBEvUEh6MUjaU9jMf5RzsEbmTiMF792
         G5IJn04mXeVvZ3RB9AxIdg/lWK0lQfcwanF2WvHCF2W2txXqma4tQkArIqQ+WAnOSJnF
         k8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=/z26CVzacxgEbflnpwOBeepGVQn0w/gPmhmQRvMvTvE=;
        b=j9FlPNo8LTYfLnSmjACrDWJY5BBVWBIoqDwdudugPNrB9I2axDfxWQggWKzo4TgFWB
         STWQihJSgXbKb8GqsOSbQU5NUIELkRoqgVPs4xD3GlZIJVE6rvxfM7V1dXH3o65hHbV3
         q96uQfjJKp5QS9Tqyw1WPZEMFWLTJpEzRzh11tOxNfMgnXS1cAtlRFUeCDj2/iUqu6Tw
         pc38PTlpkfOV+xA9DajwrxCap1AU12cZtZN1+NxKwDP5nmUp90fUpckpsDdT/5Cf1eOS
         KxsHQZNa2ugwP0OwHMwqxXdNh71LFJHZ2RdSL80GtwxRekW+ncJLI3+5e/LuJiWWK5i5
         iuqA==
X-Gm-Message-State: ACgBeo1AEBSnAzwHmE0k5bWJo/zszJRO48aVJB7WlppOzkZhOmPD1rU1
        3CPhLI/226PVYIwaCBoR7s7vkFv5b+CroSUz4BZws0HmCMfa0ei+dKtpW1mn/jUtULXiKrpnMTW
        cD30HSqobZBjHhuVvPlCYEDcd37vkWyBVullbnD86PafaME1Y58IBLbuU2RHwpwWgfCB74iHJ0J
        0yBvxxrEz24Q==
X-Google-Smtp-Source: AA6agR5u73nBkZGLCCJrxKVIxsdPurnsP+Dh6NdNvLDKDTDc+Wb6ui93/5J5kTR2k/07hiqeUqnIxXfN67ICpkbgGmQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a25:2f4c:0:b0:695:883c:a21 with SMTP
 id v73-20020a252f4c000000b00695883c0a21mr12959138ybv.182.1661902303887; Tue,
 30 Aug 2022 16:31:43 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:12 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3262; i=samitolvanen@google.com;
 h=from:subject; bh=VjK0Sj77LlbGadkKbzH2JR2bzhTohKLFixpVfbAKe08=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3Mb+sUdWdFlgchvPUHgAyRneqSjmCj25aHmsBM
 jScZ3peJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzAAKCRBMtfaEi7xW7mDLC/
 0UATdRz/gMs/ofqpTV6ZzQe61nJSI8tXBsohzK+rQh17bBxgZpm+JdkGThkxMQapEabJvzCh3aiusP
 Zc7GPY61BxhGWQUB/TiSG+tUInkEMWJ/Z1gwO9oNMZpi+jJowEOHdgoOCj/EBf9L+ULovJmAJ6OZ6X
 1TDy6idxAVdZKenhUg8JRONtj7YZBxAL+9jJjPhiKTyXYUctKZDb2aXPRGp710z/QD3KxUYKF9PhYK
 yjTUv+cKDm+pUf/V0KqsF8Jm7/ZirqdOWyFGqd/4SemaULIAdFSMw9yXrNfolk5Cbhg3KxMwLPDn9E
 yKSMXSgdd1+oaSgoexRHZGcRtqxTrQDmxaaL4LgapATU6El8k9CJaRdPGff4ELA2nLMkKANGOtj2hQ
 ++Bhomzi3O3fRj7FgRfkhQ+ed61qFLbgROUC0hC781JKdmGCCIhwBHs32PHLVjigICiiKp0vHzHBEz
 R4RV29cc8a0ne1G6NRKlw8CfwQM+oeXsaxESL6fGfIHVg=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 04/21] cfi: Drop __CFI_ADDRESSABLE
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
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index 7713d7bcdaea..7bfafc69172a 100644
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
index 518296ea7f73..8937b020ec04 100644
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
2.37.2.672.g94769d06f0-goog

