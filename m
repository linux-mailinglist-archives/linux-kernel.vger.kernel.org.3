Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522485B28CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIHVza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIHVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE227C74B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 62-20020a250341000000b006a93b57e2daso30513ybd.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=NnVV6DTSn3h1DOdTYpHix9zNDIsBWjDQwEgm7WMNa8o=;
        b=BNenGge5SUwNwtXbkTCyPNFwIVsej/BpXEqBSFZ1Ao8D6PzUX4mQhT2QaqSn+Ty5wx
         YMcyOidGuKnAMzQ82jKYgDsguo7KcngWE6V/iAuV3riYpmBFEmzHNW7C6slUHiBbfpKl
         VnUVxF5BQMJ1kqgFN/WEFrDKE6L7XhNKOIxthP3j4JvAwN0Inx7djsdcm8DFcDKKWCxU
         GzQk1iYQF2OQlyccrX/o7wddl4mG3js6SPOReZ0GrU/xhmdCd983nI0hYJCd/QHr2CXd
         cb7okIcKhksT5NJhfzCVs3YQFb9RdbYMILHQdDEego3+nBq2lRTsk7e5b7LH/xTRExxZ
         STOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=NnVV6DTSn3h1DOdTYpHix9zNDIsBWjDQwEgm7WMNa8o=;
        b=sz9pH9tCFiG4slU/JidZbLGIKx7jshbrZhEP4xA25TuZh6Ds4xCaTdErfT9u0akGav
         +6tr8bz1NigN7/f7wvvOlrFrRCx81jw1tMDayosByzJjYZq+Pb7jghUky2VSFKckPbIS
         1/5dQbv2LSOIPnBluq7NkwUS9fHtuldkaf3B5aqufVEQ4g4kpdJcQ+LMlvdmkcrPSeBl
         IDU1NQw/MvZyDQdKx8BIfDhiWtd984yfLUjPoDmJ7GCRnfWGtOtzlX9Z8CjMws2lElpl
         1pS+ZsjO5nXvgPb+7eYRGXcUZbpWB6aJAbey4Y5zzQBmS9MQMDvEl0vy9Prrd69uriFP
         XKJw==
X-Gm-Message-State: ACgBeo1sXFfMojh8z3kh8eNFo5uYXptm4pMTF/G4KqZ3pRxsDbQYV9Ei
        Gng5W9G/zc3IuF25eMAQzQvMnf7qAV53IaP2d/+5BDiziZILh6i36Dr0uQ+2BEucQJGTgsdpzzu
        0qzvfWVL6flubR4g6f96sBC2LyT4fVEKuvngLdBFoehSCAw1DuAOqVcLXdh8ypvUBz37uREVQZQ
        yfX1LgmfYvqA==
X-Google-Smtp-Source: AA6agR6TYyAH85tqugJj1yijMu0EJeXMe93YNQ3Lr1PF7LS9QEk/o3QyLGJ5l5d325CYnFU1XVX1099eHj8op/mP7ls=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a0d:fa41:0:b0:348:7dc3:760a with SMTP
 id k62-20020a0dfa41000000b003487dc3760amr7026978ywf.106.1662674114778; Thu,
 08 Sep 2022 14:55:14 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:45 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=10481; i=samitolvanen@google.com;
 h=from:subject; bh=UTZgCNN6nFOYuwWv/8NsOLwF8a+iUTF7XgJLM/G80Do=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmSzGK9zjlWkYVC46zGoyD+9vaO2YMOksqto1BHN
 17EXxXCJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpkswAKCRBMtfaEi7xW7milC/
 922p3yw6iPjuTLhIFuvSMD/7TKtaxymIETTN2upWH0OYR7sjdbZ0H7S3qDxTpLMjy89i3QABNZ4CSN
 yEHDjoH19M/ifH+cM+SyIj0NmGqUfoyUCLUy5yoP1UE2SWQsIPRdYCgwxyremRzggnBen+6tTPyONd
 bo+CGaQZqWuku9R5zQ6VZM4liTpGAO8pqd923H9aj9OF1NUv55QSvfrf1LwHs8eGdJ1nhbGmxmuJEp
 V55Oi9wAAlBKUpr2TU5/iW8ly8oAAHBrWTCLMaLJp4cFHGdW9CAnP0DwCbyVSoh15bHFZAQm2A33UJ
 PH2C3H/MHRoSQAzo6aozbuGwi/eEZXtK+yBkl0woIaKvsR7QG8ry/Ju+duizFlI6n7mSSHHMtz8NgG
 Vlrng9Yf/AwIYnC5f4P3opmwQu3fU2vRRMmYVsrx7XGGXHCWNq5tz4cwslycnJ7nXTSMZglszL1w3J
 5mYNzLsVs7JPE6fuprWVxJpDDXZZorCI3hYDwEnmmHhaQ=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 03/22] cfi: Remove CONFIG_CFI_CLANG_SHADOW
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

In preparation to switching to -fsanitize=kcfi, remove support for the
CFI module shadow that will no longer be needed.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/Kconfig         |  10 --
 include/linux/cfi.h  |  12 ---
 kernel/cfi.c         | 236 +------------------------------------------
 kernel/module/main.c |  15 ---
 4 files changed, 1 insertion(+), 272 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5dbf11a5ba4e..5fd875e18c99 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -754,16 +754,6 @@ config CFI_CLANG
 
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
index 2046276ee234..e8bc1b370edc 100644
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
@@ -298,10 +67,7 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
 		ct_irq_enter();
 	}
 
-	if (IS_ENABLED(CONFIG_CFI_CLANG_SHADOW))
-		fn = find_shadow_check_fn(ptr);
-	if (!fn)
-		fn = find_module_check_fn(ptr);
+	fn = find_module_check_fn(ptr);
 
 	if (rcu_idle) {
 		ct_irq_exit();
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a4e4d84b6f4e..0228f44b58e5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1144,8 +1144,6 @@ void __weak module_arch_freeing_init(struct module *mod)
 {
 }
 
-static void cfi_cleanup(struct module *mod);
-
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
@@ -1190,9 +1188,6 @@ static void free_module(struct module *mod)
 		       mod->name);
 	mutex_unlock(&module_mutex);
 
-	/* Clean up CFI for the module. */
-	cfi_cleanup(mod);
-
 	/* This may be empty, but that's OK */
 	module_arch_freeing_init(mod);
 	module_memfree(mod->init_layout.base);
@@ -2875,7 +2870,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	synchronize_rcu();
 	kfree(mod->args);
  free_arch_cleanup:
-	cfi_cleanup(mod);
 	module_arch_cleanup(mod);
  free_modinfo:
 	free_modinfo(mod);
@@ -2984,15 +2978,6 @@ static void cfi_init(struct module *mod)
 		mod->exit = *exit;
 #endif
 	rcu_read_unlock_sched();
-
-	cfi_module_add(mod, mod_tree.addr_min);
-#endif
-}
-
-static void cfi_cleanup(struct module *mod)
-{
-#ifdef CONFIG_CFI_CLANG
-	cfi_module_remove(mod, mod_tree.addr_min);
 #endif
 }
 
-- 
2.37.2.789.g6183377224-goog

