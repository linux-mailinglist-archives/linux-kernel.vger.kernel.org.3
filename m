Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D915155C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380911AbiD2Ukc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380791AbiD2UkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB5683B27
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 7-20020a250c07000000b0064137917a4eso8372903ybm.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/SID+odwOHhW6fSf1SyMHupf3+2plu1m/MfG1cXg+b0=;
        b=pXDTPirUN5MykkQCbB5q8AmcY3Jq2zcVF3SAcIhszlCK/5FsnWORlQsvYGApnGAxAh
         N4ygHCVO+0tz++iUcvEcAIzqvAX84/Bk0ksbA2mq3JhrrA0dtmX6fExMFYmtmqgRnRge
         57dmSVL1PRWhdkPOFdWHNe0JEgMypLQrindoY00jJsc1acBXPYHF/bcx+WBJSqTkVvUK
         2QWG2Hkwf8YbJv5WpPdTkXsxom7fiaQ5plQrRjALzpQU03C2Q/ENlR7/kBTEnPJLu6tU
         AVip6caQubJWmSCSZeQ/NAIyLrLi6utkSyQ1d7lqpcMm1Nv/4Kk2TwLZqH9FKMgYKM6g
         QA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/SID+odwOHhW6fSf1SyMHupf3+2plu1m/MfG1cXg+b0=;
        b=WufOANFNd1gEpbXICLsTKkiRNyoB052s1DAK23R+Udaw1tfpqpybGabdvoylh0eDBo
         Hk5rBMbvmKiUsQyQOsNE9dgn6zedUaOkA3YHQgcfSbDjpeXnUD2VBt/ncT9S5cntAuBD
         2GOzTYJk1IL2+kZRJM9ToSY637cpue7K0x6IOblZt21QpBO9rDkURVKnNcN/vuUIoY1J
         WQy0mLu+lTKrnit9jljU7+NkE1pR7Kq3U+O++SgFR6U2GnsxjSahIeaLjTPdHZm4upik
         f5iFkE7rUjf3NDFWKfYlCQOF6TpBIcG66Ndai/Xf8Dq86sfS+toGA1AeWyUCGYsJfgCP
         r1/A==
X-Gm-Message-State: AOAM533+4IsGeLvq4TtF1t4z2gCBLkHbIEJx+1/2udtPBtV6X2gYvivJ
        sAcc4CrD2FmyObXUee6PG7086bkdJzdqsOgS2LWWpUwcECGdQEbmZ/kRcuw4ABnkiK5TFkHuEW3
        36qJ2+I+fwSu3wnq6UjdT3Z1ZMQyfOGMiW9VANAPlw9fBzSK5ojecPd1b329MY2USW2A1R+BZub
        w2A4BGCJHYcA==
X-Google-Smtp-Source: ABdhPJyyE/KgNn+KGSWVEO4DlT7y+o1aFloDvMPuRcf58kbzYBHSuDzpw++tVU+X2i3WAOfEyDFH7VO3xUNBm2uS/lI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:d68c:0:b0:648:d3bd:734e with SMTP
 id n134-20020a25d68c000000b00648d3bd734emr1265294ybg.277.1651264617711; Fri,
 29 Apr 2022 13:36:57 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:27 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=10304; h=from:subject;
 bh=R/qPr3A1VbpNtnYdnS8DSefcpakC96p89+rbs5j/O5k=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExVe5jOiLucPBZlfPxt03GQBYZcYZYxotX7Rlbh
 pXb8uw2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVQAKCRBMtfaEi7xW7v0XC/
 46oeqCOaakLm+oj5yYo6EzrAFTs5pV0T/Iu+pYXTl5auQFlm0gA4dW+t6GzPHH4IgUsYSf+lpZPwyi
 ofHwbMrHNfQ5D7ysP1KkA/LJKm7TDhtzpGczUZKgZXgmcnwfH3bnKFH7TFMZGKzFzufC32y9Xw7Gpg
 bjkVAuZtU5WNqNR5aj/UmamsjNWhnU6POOFzQkr8TxSq7Ia3BkFysQ6cV6B4IFFh3ImVZXywtA6bee
 w2Z5YjCyontExD8s0G6yp5ba/58lnC+890RwiOvzcD30wacx3bTk1hz6Uue44DlnxRJ3vLEZyxGbld
 k0A8yc0yresK/+93VLifSu1yuZKlNGiCXcCDApJwyJvKNMeP645FRVN/D1gMmlyRzPDErbvu1c72aV
 QnF9aVPrFtrYZgbQZCfRjHLkrKUP6ZeNk8K4+vRP9oAFBlea19xt3Re16+QsONeGmW2wpXhQBeU0Ug
 Um6X49lF8QenmfoRzqFjg2RmGAM/dtUJUQkRVUOZCalVc=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 04/21] cfi: Remove CONFIG_CFI_CLANG_SHADOW
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

In preparation to switching to -fsanitize=kcfi, remove support for the
CFI module shadow that will no longer be needed.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/Kconfig        |  10 --
 include/linux/cfi.h |  12 ---
 kernel/cfi.c        | 237 +-------------------------------------------
 kernel/module.c     |  15 ---
 4 files changed, 1 insertion(+), 273 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31c4fdc4a4ba..625db6376726 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -739,16 +739,6 @@ config CFI_CLANG
 
 	    https://clang.llvm.org/docs/ControlFlowIntegrity.html
 
-config CFI_CLANG_SHADOW
-	bool "Use CFI shadow to speed up cross-module checks"
-	default y
-	depends on CFI_CLANG && MODULES
-	help
-	  If you select this option, the kernel builds a fast look-up table of
-	  CFI check functions in loaded modules to reduce performance overhead.
-
-	  If unsure, say Y.
-
 config CFI_PERMISSIVE
 	bool "Use CFI in permissive mode"
 	depends on CFI_CLANG
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index c6dfc1ed0626..4ab51c067007 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -20,18 +20,6 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
 #define __CFI_ADDRESSABLE(fn, __attr) \
 	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
 
-#ifdef CONFIG_CFI_CLANG_SHADOW
-
-extern void cfi_module_add(struct module *mod, unsigned long base_addr);
-extern void cfi_module_remove(struct module *mod, unsigned long base_addr);
-
-#else
-
-static inline void cfi_module_add(struct module *mod, unsigned long base_addr) {}
-static inline void cfi_module_remove(struct module *mod, unsigned long base_addr) {}
-
-#endif /* CONFIG_CFI_CLANG_SHADOW */
-
 #else /* !CONFIG_CFI_CLANG */
 
 #ifdef CONFIG_X86_KERNEL_IBT
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 9594cfd1cf2c..2cc0d01ea980 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -32,237 +32,6 @@ static inline void handle_cfi_failure(void *ptr)
 }
 
 #ifdef CONFIG_MODULES
-#ifdef CONFIG_CFI_CLANG_SHADOW
-/*
- * Index type. A 16-bit index can address at most (2^16)-2 pages (taking
- * into account SHADOW_INVALID), i.e. ~256M with 4k pages.
- */
-typedef u16 shadow_t;
-#define SHADOW_INVALID		((shadow_t)~0UL)
-
-struct cfi_shadow {
-	/* Page index for the beginning of the shadow */
-	unsigned long base;
-	/* An array of __cfi_check locations (as indices to the shadow) */
-	shadow_t shadow[1];
-} __packed;
-
-/*
- * The shadow covers ~128M from the beginning of the module region. If
- * the region is larger, we fall back to __module_address for the rest.
- */
-#define __SHADOW_RANGE		(_UL(SZ_128M) >> PAGE_SHIFT)
-
-/* The in-memory size of struct cfi_shadow, always at least one page */
-#define __SHADOW_PAGES		((__SHADOW_RANGE * sizeof(shadow_t)) >> PAGE_SHIFT)
-#define SHADOW_PAGES		max(1UL, __SHADOW_PAGES)
-#define SHADOW_SIZE		(SHADOW_PAGES << PAGE_SHIFT)
-
-/* The actual size of the shadow array, minus metadata */
-#define SHADOW_ARR_SIZE		(SHADOW_SIZE - offsetof(struct cfi_shadow, shadow))
-#define SHADOW_ARR_SLOTS	(SHADOW_ARR_SIZE / sizeof(shadow_t))
-
-static DEFINE_MUTEX(shadow_update_lock);
-static struct cfi_shadow __rcu *cfi_shadow __read_mostly;
-
-/* Returns the index in the shadow for the given address */
-static inline int ptr_to_shadow(const struct cfi_shadow *s, unsigned long ptr)
-{
-	unsigned long index;
-	unsigned long page = ptr >> PAGE_SHIFT;
-
-	if (unlikely(page < s->base))
-		return -1; /* Outside of module area */
-
-	index = page - s->base;
-
-	if (index >= SHADOW_ARR_SLOTS)
-		return -1; /* Cannot be addressed with shadow */
-
-	return (int)index;
-}
-
-/* Returns the page address for an index in the shadow */
-static inline unsigned long shadow_to_ptr(const struct cfi_shadow *s,
-	int index)
-{
-	if (unlikely(index < 0 || index >= SHADOW_ARR_SLOTS))
-		return 0;
-
-	return (s->base + index) << PAGE_SHIFT;
-}
-
-/* Returns the __cfi_check function address for the given shadow location */
-static inline unsigned long shadow_to_check_fn(const struct cfi_shadow *s,
-	int index)
-{
-	if (unlikely(index < 0 || index >= SHADOW_ARR_SLOTS))
-		return 0;
-
-	if (unlikely(s->shadow[index] == SHADOW_INVALID))
-		return 0;
-
-	/* __cfi_check is always page aligned */
-	return (s->base + s->shadow[index]) << PAGE_SHIFT;
-}
-
-static void prepare_next_shadow(const struct cfi_shadow __rcu *prev,
-		struct cfi_shadow *next)
-{
-	int i, index, check;
-
-	/* Mark everything invalid */
-	memset(next->shadow, 0xFF, SHADOW_ARR_SIZE);
-
-	if (!prev)
-		return; /* No previous shadow */
-
-	/* If the base address didn't change, an update is not needed */
-	if (prev->base == next->base) {
-		memcpy(next->shadow, prev->shadow, SHADOW_ARR_SIZE);
-		return;
-	}
-
-	/* Convert the previous shadow to the new address range */
-	for (i = 0; i < SHADOW_ARR_SLOTS; ++i) {
-		if (prev->shadow[i] == SHADOW_INVALID)
-			continue;
-
-		index = ptr_to_shadow(next, shadow_to_ptr(prev, i));
-		if (index < 0)
-			continue;
-
-		check = ptr_to_shadow(next,
-				shadow_to_check_fn(prev, prev->shadow[i]));
-		if (check < 0)
-			continue;
-
-		next->shadow[index] = (shadow_t)check;
-	}
-}
-
-static void add_module_to_shadow(struct cfi_shadow *s, struct module *mod,
-			unsigned long min_addr, unsigned long max_addr)
-{
-	int check_index;
-	unsigned long check = (unsigned long)mod->cfi_check;
-	unsigned long ptr;
-
-	if (unlikely(!PAGE_ALIGNED(check))) {
-		pr_warn("cfi: not using shadow for module %s\n", mod->name);
-		return;
-	}
-
-	check_index = ptr_to_shadow(s, check);
-	if (check_index < 0)
-		return; /* Module not addressable with shadow */
-
-	/* For each page, store the check function index in the shadow */
-	for (ptr = min_addr; ptr <= max_addr; ptr += PAGE_SIZE) {
-		int index = ptr_to_shadow(s, ptr);
-
-		if (index >= 0) {
-			/* Each page must only contain one module */
-			WARN_ON_ONCE(s->shadow[index] != SHADOW_INVALID);
-			s->shadow[index] = (shadow_t)check_index;
-		}
-	}
-}
-
-static void remove_module_from_shadow(struct cfi_shadow *s, struct module *mod,
-		unsigned long min_addr, unsigned long max_addr)
-{
-	unsigned long ptr;
-
-	for (ptr = min_addr; ptr <= max_addr; ptr += PAGE_SIZE) {
-		int index = ptr_to_shadow(s, ptr);
-
-		if (index >= 0)
-			s->shadow[index] = SHADOW_INVALID;
-	}
-}
-
-typedef void (*update_shadow_fn)(struct cfi_shadow *, struct module *,
-			unsigned long min_addr, unsigned long max_addr);
-
-static void update_shadow(struct module *mod, unsigned long base_addr,
-		update_shadow_fn fn)
-{
-	struct cfi_shadow *prev;
-	struct cfi_shadow *next;
-	unsigned long min_addr, max_addr;
-
-	next = vmalloc(SHADOW_SIZE);
-
-	mutex_lock(&shadow_update_lock);
-	prev = rcu_dereference_protected(cfi_shadow,
-					 mutex_is_locked(&shadow_update_lock));
-
-	if (next) {
-		next->base = base_addr >> PAGE_SHIFT;
-		prepare_next_shadow(prev, next);
-
-		min_addr = (unsigned long)mod->core_layout.base;
-		max_addr = min_addr + mod->core_layout.text_size;
-		fn(next, mod, min_addr & PAGE_MASK, max_addr & PAGE_MASK);
-
-		set_memory_ro((unsigned long)next, SHADOW_PAGES);
-	}
-
-	rcu_assign_pointer(cfi_shadow, next);
-	mutex_unlock(&shadow_update_lock);
-	synchronize_rcu();
-
-	if (prev) {
-		set_memory_rw((unsigned long)prev, SHADOW_PAGES);
-		vfree(prev);
-	}
-}
-
-void cfi_module_add(struct module *mod, unsigned long base_addr)
-{
-	update_shadow(mod, base_addr, add_module_to_shadow);
-}
-
-void cfi_module_remove(struct module *mod, unsigned long base_addr)
-{
-	update_shadow(mod, base_addr, remove_module_from_shadow);
-}
-
-static inline cfi_check_fn ptr_to_check_fn(const struct cfi_shadow __rcu *s,
-	unsigned long ptr)
-{
-	int index;
-
-	if (unlikely(!s))
-		return NULL; /* No shadow available */
-
-	index = ptr_to_shadow(s, ptr);
-	if (index < 0)
-		return NULL; /* Cannot be addressed with shadow */
-
-	return (cfi_check_fn)shadow_to_check_fn(s, index);
-}
-
-static inline cfi_check_fn find_shadow_check_fn(unsigned long ptr)
-{
-	cfi_check_fn fn;
-
-	rcu_read_lock_sched_notrace();
-	fn = ptr_to_check_fn(rcu_dereference_sched(cfi_shadow), ptr);
-	rcu_read_unlock_sched_notrace();
-
-	return fn;
-}
-
-#else /* !CONFIG_CFI_CLANG_SHADOW */
-
-static inline cfi_check_fn find_shadow_check_fn(unsigned long ptr)
-{
-	return NULL;
-}
-
-#endif /* CONFIG_CFI_CLANG_SHADOW */
 
 static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
 {
@@ -291,11 +60,7 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
 	 * up if necessary.
 	 */
 	RCU_NONIDLE({
-		if (IS_ENABLED(CONFIG_CFI_CLANG_SHADOW))
-			fn = find_shadow_check_fn(ptr);
-
-		if (!fn)
-			fn = find_module_check_fn(ptr);
+		fn = find_module_check_fn(ptr);
 	});
 
 	return fn;
diff --git a/kernel/module.c b/kernel/module.c
index 6cea788fd965..296fe02323e9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2151,8 +2151,6 @@ void __weak module_arch_freeing_init(struct module *mod)
 {
 }
 
-static void cfi_cleanup(struct module *mod);
-
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
@@ -2194,9 +2192,6 @@ static void free_module(struct module *mod)
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
 
-	/* Clean up CFI for the module. */
-	cfi_cleanup(mod);
-
 	/* This may be empty, but that's OK */
 	module_arch_freeing_init(mod);
 	module_memfree(mod->init_layout.base);
@@ -4141,7 +4136,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	synchronize_rcu();
 	kfree(mod->args);
  free_arch_cleanup:
-	cfi_cleanup(mod);
 	module_arch_cleanup(mod);
  free_modinfo:
 	free_modinfo(mod);
@@ -4530,15 +4524,6 @@ static void cfi_init(struct module *mod)
 	if (exit)
 		mod->exit = *exit;
 #endif
-
-	cfi_module_add(mod, module_addr_min);
-#endif
-}
-
-static void cfi_cleanup(struct module *mod)
-{
-#ifdef CONFIG_CFI_CLANG
-	cfi_module_remove(mod, module_addr_min);
 #endif
 }
 
-- 
2.36.0.464.gb9c8b46e94-goog

