Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95AD5B28D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIHVzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIHVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FABB5335
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l12-20020a25ad4c000000b006a8e04c284dso6707ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=nWL0aROoRXaq2aFLsQrBYp1EGs3bODIj6Z2ykx/Ykp8=;
        b=IZ8CvgVBEW+3TNYeXkE5KDChuokHUFERDyR83lR9Hjz13CWKrXH8z4zJBBA5G3U7O7
         T6fGQYVJCsldsK3wbLa4BVDEJC6074bYxyJaues3V0GDIN7a0acDUotqPnCDbZMg8CV5
         lDpWl4Ul+87dWMR8UDrNz+TdCFMne/luwQAE482wyV/kas2QfVQXoHvMd05hnsJFLEX8
         Wg9GHVkjTGHpHedF9ibQjdv6kF+QwdrxS+25ti57Mnlbfu3MEysljO/OGPzF9dZ4VchQ
         p6lP1w9rGcTgVkK4lIB9dTCvMels03oip3JKvFYFBh7g//V+Al2Be1w89q2AUKwSIIed
         X6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=nWL0aROoRXaq2aFLsQrBYp1EGs3bODIj6Z2ykx/Ykp8=;
        b=ek/uYJzHNpxq/AB5Z4YIpcIlJBjBzIl+ZjnBRnSjKXKOFN+F58eexQDRSZuzq+kJ1V
         iCmkWtUiMzkkea9ooG4HLQDysw9AIIBj54BUPYqNX9M2tpfFvNwW98dNjQBWKZ9GtGy6
         lmVSxvYHrfzKOFbPhQtONuJDl6XNvGgD2PQf9I8lnj4YZxV6ufpMw/ASoeygJyyqUU4j
         NQnLZ5taWXaLI0JCtohJKng7f+8IeC1hrUvPJRgjfEeVGSMvwzBqixBJc8jeSwt8073k
         zjMvVLSA9CDEMjo0j5TIH8RXMsvZJLpH7PqIr5+SGPN9kxgaoMIjBWzaFjNp6pqAxsfJ
         28IA==
X-Gm-Message-State: ACgBeo28dXv0OxcNY1DaJwOIBSdwIgwaOPVGpiRbUiu0hvRTsGnSqQ63
        TqgzYgjtLqxalxtVZC702LqfGsyiCzOyEcCCXVz2MGrFgL2smpXO/8/ZQN0QxxV1kQjUyPaY7wN
        EIlDKIt9kef+cL393JMdMCS6SG3X+G05+gjgw7/9RsmQheUvw5WPR8mVwMTzZIL8xjxi6zdEJ6X
        AEOw94zg5JWQ==
X-Google-Smtp-Source: AA6agR50NiPw/l8/JWBOwCU6g5z471+pH699N76zKI30BjIZuHauhlYyr22x4qjjZZwpvi03Zxx0Rd6+TzLHI08C5T0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a25:9e83:0:b0:6a7:b23c:289 with SMTP
 id p3-20020a259e83000000b006a7b23c0289mr8448516ybq.587.1662674120133; Thu, 08
 Sep 2022 14:55:20 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:47 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=15849; i=samitolvanen@google.com;
 h=from:subject; bh=3zlj9uhGgVvdu99S3z0sryv5ljb8kTjyqDYUlzAvVng=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmSzNdnTtM2yogklOpJEkc0SSoM/2VAYCJ7a7iUM
 nL/lD8iJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpkswAKCRBMtfaEi7xW7u3jC/
 9iJNFKoxSu1pxhi5fTXhPW7L1KVmFJCZku5t1XyI0H6ipC1BXjWu/P11U8tDXWEIUtblQfKR6HB+nH
 OjNEYyspSHWNUqQ6OpqfNyx0YFGB1AUGIcM3esBeIUx96DRqYS4qYFLmu342tdgh1mYkyfyPrGKnUj
 34c9aZ8GHSx/KZB6mcr9OKMw7EXeztnSNL1xQGf0kiDAhWEzQCys7GMcGB0AaYKUgGOuC7QB5StYCG
 pvJdqtK7PEdnN+tnhawQtL4cLSAJcYdTyV6JhHsJOWDdwKtJAFyh3+uTjXtLcnTQ3RFiGybkaWciAj
 /+UqTEuy6TXXw0O2DLXlaqN3zSxIvwXp2yGbOzmrIlT40WlJrKIP0FMi4zxCDlmO/oMHMIAvSEWOhh
 6qoi+dms2ZnburZ8O5wncxrQARhO1vXjScKwxU2ubYmWqAS+C2X8v0q5aTjG4IoelgXV9f7V45AjSq
 t3e5DlCLsKjgTv5T/IXBdtFUPmaTdWEuBTUhaaKvnkN28=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 05/22] cfi: Switch to -fsanitize=kcfi
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

Switch from Clang's original forward-edge control-flow integrity
implementation to -fsanitize=3Dkcfi, which is better suited for the
kernel, as it doesn't require LTO, doesn't use a jump table that
requires altering function references, and won't break cross-module
function address equality.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile                          |  13 +--
 arch/Kconfig                      |   8 +-
 include/asm-generic/vmlinux.lds.h |  37 ++++----
 include/linux/cfi.h               |  29 +++++-
 include/linux/compiler-clang.h    |  14 +--
 include/linux/module.h            |   6 +-
 kernel/cfi.c                      | 144 +++++++++++++++---------------
 kernel/module/main.c              |  35 +-------
 scripts/module.lds.S              |  23 +----
 9 files changed, 133 insertions(+), 176 deletions(-)

diff --git a/Makefile b/Makefile
index a4f71076cacb..43e08c9f95e9 100644
--- a/Makefile
+++ b/Makefile
@@ -921,18 +921,7 @@ export CC_FLAGS_LTO
 endif
=20
 ifdef CONFIG_CFI_CLANG
-CC_FLAGS_CFI	:=3D -fsanitize=3Dcfi \
-		   -fsanitize-cfi-cross-dso \
-		   -fno-sanitize-cfi-canonical-jump-tables \
-		   -fno-sanitize-trap=3Dcfi \
-		   -fno-sanitize-blacklist
-
-ifdef CONFIG_CFI_PERMISSIVE
-CC_FLAGS_CFI	+=3D -fsanitize-recover=3Dcfi
-endif
-
-# If LTO flags are filtered out, we must also filter out CFI.
-CC_FLAGS_LTO	+=3D $(CC_FLAGS_CFI)
+CC_FLAGS_CFI	:=3D -fsanitize=3Dkcfi
 KBUILD_CFLAGS	+=3D $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 5fd875e18c99..1c1eca0c0019 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -738,11 +738,13 @@ config ARCH_SUPPORTS_CFI_CLANG
 	  An architecture should select this option if it can support Clang's
 	  Control-Flow Integrity (CFI) checking.
=20
+config ARCH_USES_CFI_TRAPS
+	bool
+
 config CFI_CLANG
 	bool "Use Clang's Control Flow Integrity (CFI)"
-	depends on LTO_CLANG && ARCH_SUPPORTS_CFI_CLANG
-	depends on CLANG_VERSION >=3D 140000
-	select KALLSYMS
+	depends on ARCH_SUPPORTS_CFI_CLANG
+	depends on $(cc-option,-fsanitize=3Dkcfi)
 	help
 	  This option enables Clang=E2=80=99s forward-edge Control Flow Integrity
 	  (CFI) checking, where the compiler injects a runtime check to each
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index 7515a465ec03..7501edfce11e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -421,6 +421,22 @@
 	__end_ro_after_init =3D .;
 #endif
=20
+/*
+ * .kcfi_traps contains a list KCFI trap locations.
+ */
+#ifndef KCFI_TRAPS
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+#define KCFI_TRAPS							\
+	__kcfi_traps : AT(ADDR(__kcfi_traps) - LOAD_OFFSET) {		\
+		__start___kcfi_traps =3D .;				\
+		KEEP(*(.kcfi_traps))					\
+		__stop___kcfi_traps =3D .;				\
+	}
+#else
+#define KCFI_TRAPS
+#endif
+#endif
+
 /*
  * Read only Data
  */
@@ -529,6 +545,8 @@
 		__stop___modver =3D .;					\
 	}								\
 									\
+	KCFI_TRAPS							\
+									\
 	RO_EXCEPTION_TABLE						\
 	NOTES								\
 	BTF								\
@@ -537,21 +555,6 @@
 	__end_rodata =3D .;
=20
=20
-/*
- * .text..L.cfi.jumptable.* contain Control-Flow Integrity (CFI)
- * jump table entries.
- */
-#ifdef CONFIG_CFI_CLANG
-#define TEXT_CFI_JT							\
-		. =3D ALIGN(PMD_SIZE);					\
-		__cfi_jt_start =3D .;					\
-		*(.text..L.cfi.jumptable .text..L.cfi.jumptable.*)	\
-		. =3D ALIGN(PMD_SIZE);					\
-		__cfi_jt_end =3D .;
-#else
-#define TEXT_CFI_JT
-#endif
-
 /*
  * Non-instrumentable text section
  */
@@ -579,7 +582,6 @@
 		*(.text..refcount)					\
 		*(.ref.text)						\
 		*(.text.asan.* .text.tsan.*)				\
-		TEXT_CFI_JT						\
 	MEM_KEEP(init.text*)						\
 	MEM_KEEP(exit.text*)						\
=20
@@ -1008,8 +1010,7 @@
  * keep any .init_array.* sections.
  * https://bugs.llvm.org/show_bug.cgi?id=3D46478
  */
-#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || define=
d(CONFIG_KCSAN) || \
-	defined(CONFIG_CFI_CLANG)
+#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || define=
d(CONFIG_KCSAN)
 # ifdef CONFIG_CONSTRUCTORS
 #  define SANITIZER_DISCARDS						\
 	*(.eh_frame)
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 2cdbc0fbd0ab..5e134f4ce8b7 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -2,17 +2,38 @@
 /*
  * Clang Control Flow Integrity (CFI) support.
  *
- * Copyright (C) 2021 Google LLC
+ * Copyright (C) 2022 Google LLC
  */
 #ifndef _LINUX_CFI_H
 #define _LINUX_CFI_H
=20
+#include <linux/bug.h>
+#include <linux/module.h>
+
 #ifdef CONFIG_CFI_CLANG
-typedef void (*cfi_check_fn)(uint64_t id, void *ptr, void *diag);
+enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long =
addr,
+				      unsigned long *target, u32 type);
=20
-/* Compiler-generated function in each module, and the kernel */
-extern void __cfi_check(uint64_t id, void *ptr, void *diag);
+static inline enum bug_trap_type report_cfi_failure_noaddr(struct pt_regs =
*regs,
+							   unsigned long addr)
+{
+	return report_cfi_failure(regs, addr, NULL, 0);
+}
=20
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+bool is_cfi_trap(unsigned long addr);
+#endif
 #endif /* CONFIG_CFI_CLANG */
=20
+#ifdef CONFIG_MODULES
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+			 struct module *mod);
+#else
+static inline void module_cfi_finalize(const Elf_Ehdr *hdr,
+				       const Elf_Shdr *sechdrs,
+				       struct module *mod) {}
+#endif /* CONFIG_ARCH_USES_CFI_TRAPS */
+#endif /* CONFIG_MODULES */
+
 #endif /* _LINUX_CFI_H */
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.=
h
index c84fec767445..42e55579d649 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -66,17 +66,9 @@
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
=20
-#define __nocfi		__attribute__((__no_sanitize__("cfi")))
-#define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
-
-#if defined(CONFIG_CFI_CLANG)
-/*
- * With CONFIG_CFI_CLANG, the compiler replaces function address
- * references with the address of the function's CFI jump table
- * entry. The function_nocfi macro always returns the address of the
- * actual function instead.
- */
-#define function_nocfi(x)	__builtin_function_start(x)
+#if __has_feature(kcfi)
+/* Disable CFI checking inside a function. */
+#define __nocfi		__attribute__((__no_sanitize__("kcfi")))
 #endif
=20
 /*
diff --git a/include/linux/module.h b/include/linux/module.h
index 8937b020ec04..ec61fb53979a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -27,7 +27,6 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
-#include <linux/cfi.h>
=20
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -387,8 +386,9 @@ struct module {
 	const s32 *crcs;
 	unsigned int num_syms;
=20
-#ifdef CONFIG_CFI_CLANG
-	cfi_check_fn cfi_check;
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+	s32 *kcfi_traps;
+	s32 *kcfi_traps_end;
 #endif
=20
 	/* Kernel parameters. */
diff --git a/kernel/cfi.c b/kernel/cfi.c
index e8bc1b370edc..08caad776717 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -1,105 +1,101 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Clang Control Flow Integrity (CFI) error and slowpath handling.
+ * Clang Control Flow Integrity (CFI) error handling.
  *
- * Copyright (C) 2021 Google LLC
+ * Copyright (C) 2022 Google LLC
  */
=20
-#include <linux/hardirq.h>
-#include <linux/kallsyms.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/printk.h>
-#include <linux/ratelimit.h>
-#include <linux/rcupdate.h>
-#include <linux/vmalloc.h>
-#include <asm/cacheflush.h>
-#include <asm/set_memory.h>
-
-/* Compiler-defined handler names */
-#ifdef CONFIG_CFI_PERMISSIVE
-#define cfi_failure_handler	__ubsan_handle_cfi_check_fail
-#else
-#define cfi_failure_handler	__ubsan_handle_cfi_check_fail_abort
-#endif
-
-static inline void handle_cfi_failure(void *ptr)
+#include <linux/cfi.h>
+
+enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long =
addr,
+				      unsigned long *target, u32 type)
 {
-	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE))
-		WARN_RATELIMIT(1, "CFI failure (target: %pS):\n", ptr);
+	if (target)
+		pr_err("CFI failure at %pS (target: %pS; expected type: 0x%08x)\n",
+		       (void *)addr, (void *)*target, type);
 	else
-		panic("CFI failure (target: %pS)\n", ptr);
+		pr_err("CFI failure at %pS (no target information)\n",
+		       (void *)addr);
+
+	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE)) {
+		__warn(NULL, 0, (void *)addr, 0, regs, NULL);
+		return BUG_TRAP_TYPE_WARN;
+	}
+
+	return BUG_TRAP_TYPE_BUG;
 }
=20
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+static inline unsigned long trap_address(s32 *p)
+{
+	return (unsigned long)((long)p + (long)*p);
+}
=20
-static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
+static bool is_trap(unsigned long addr, s32 *start, s32 *end)
 {
-	cfi_check_fn fn =3D NULL;
-	struct module *mod;
+	s32 *p;
=20
-	rcu_read_lock_sched_notrace();
-	mod =3D __module_address(ptr);
-	if (mod)
-		fn =3D mod->cfi_check;
-	rcu_read_unlock_sched_notrace();
+	for (p =3D start; p < end; ++p) {
+		if (trap_address(p) =3D=3D addr)
+			return true;
+	}
=20
-	return fn;
+	return false;
 }
=20
-static inline cfi_check_fn find_check_fn(unsigned long ptr)
+#ifdef CONFIG_MODULES
+/* Populates `kcfi_trap(_end)?` fields in `struct module`. */
+void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+			 struct module *mod)
 {
-	cfi_check_fn fn =3D NULL;
-	unsigned long flags;
-	bool rcu_idle;
-
-	if (is_kernel_text(ptr))
-		return __cfi_check;
-
-	/*
-	 * Indirect call checks can happen when RCU is not watching. Both
-	 * the shadow and __module_address use RCU, so we need to wake it
-	 * up if necessary.
-	 */
-	rcu_idle =3D !rcu_is_watching();
-	if (rcu_idle) {
-		local_irq_save(flags);
-		ct_irq_enter();
-	}
+	char *secstrings;
+	unsigned int i;
=20
-	fn =3D find_module_check_fn(ptr);
+	mod->kcfi_traps =3D NULL;
+	mod->kcfi_traps_end =3D NULL;
=20
-	if (rcu_idle) {
-		ct_irq_exit();
-		local_irq_restore(flags);
-	}
+	secstrings =3D (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (i =3D 1; i < hdr->e_shnum; i++) {
+		if (strcmp(secstrings + sechdrs[i].sh_name, "__kcfi_traps"))
+			continue;
=20
-	return fn;
+		mod->kcfi_traps =3D (s32 *)sechdrs[i].sh_addr;
+		mod->kcfi_traps_end =3D (s32 *)(sechdrs[i].sh_addr + sechdrs[i].sh_size)=
;
+		break;
+	}
 }
=20
-void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+static bool is_module_cfi_trap(unsigned long addr)
 {
-	cfi_check_fn fn =3D find_check_fn((unsigned long)ptr);
+	struct module *mod;
+	bool found =3D false;
=20
-	if (likely(fn))
-		fn(id, ptr, diag);
-	else /* Don't allow unchecked modules */
-		handle_cfi_failure(ptr);
-}
-EXPORT_SYMBOL(__cfi_slowpath_diag);
+	rcu_read_lock_sched_notrace();
=20
-#else /* !CONFIG_MODULES */
+	mod =3D __module_address(addr);
+	if (mod)
+		found =3D is_trap(addr, mod->kcfi_traps, mod->kcfi_traps_end);
=20
-void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+	rcu_read_unlock_sched_notrace();
+
+	return found;
+}
+#else /* CONFIG_MODULES */
+static inline bool is_module_cfi_trap(unsigned long addr)
 {
-	handle_cfi_failure(ptr); /* No modules */
+	return false;
 }
-EXPORT_SYMBOL(__cfi_slowpath_diag);
-
 #endif /* CONFIG_MODULES */
=20
-void cfi_failure_handler(void *data, void *ptr, void *vtable)
+extern s32 __start___kcfi_traps[];
+extern s32 __stop___kcfi_traps[];
+
+bool is_cfi_trap(unsigned long addr)
 {
-	handle_cfi_failure(ptr);
+	if (is_trap(addr, __start___kcfi_traps, __stop___kcfi_traps))
+		return true;
+
+	return is_module_cfi_trap(addr);
 }
-EXPORT_SYMBOL(cfi_failure_handler);
+#endif /* CONFIG_ARCH_USES_CFI_TRAPS */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 0228f44b58e5..70c0b2c6fef8 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -53,6 +53,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/cfi.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
=20
@@ -2597,8 +2598,9 @@ static int complete_formation(struct module *mod, str=
uct load_info *info)
 	if (err < 0)
 		goto out;
=20
-	/* This relies on module_mutex for list integrity. */
+	/* These rely on module_mutex for list integrity. */
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
+	module_cfi_finalize(info->hdr, info->sechdrs, mod);
=20
 	if (module_check_misalignment(mod))
 		goto out_misaligned;
@@ -2660,8 +2662,6 @@ static int unknown_module_param_cb(char *param, char =
*val, const char *modname,
 	return 0;
 }
=20
-static void cfi_init(struct module *mod);
-
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -2791,9 +2791,6 @@ static int load_module(struct load_info *info, const =
char __user *uargs,
=20
 	flush_module_icache(mod);
=20
-	/* Setup CFI for the module. */
-	cfi_init(mod);
-
 	/* Now copy in args */
 	mod->args =3D strndup_user(uargs, ~0UL >> 1);
 	if (IS_ERR(mod->args)) {
@@ -2955,32 +2952,6 @@ static inline int within(unsigned long addr, void *s=
tart, unsigned long size)
 	return ((void *)addr >=3D start && (void *)addr < start + size);
 }
=20
-static void cfi_init(struct module *mod)
-{
-#ifdef CONFIG_CFI_CLANG
-	initcall_t *init;
-#ifdef CONFIG_MODULE_UNLOAD
-	exitcall_t *exit;
-#endif
-
-	rcu_read_lock_sched();
-	mod->cfi_check =3D (cfi_check_fn)
-		find_kallsyms_symbol_value(mod, "__cfi_check");
-	init =3D (initcall_t *)
-		find_kallsyms_symbol_value(mod, "__cfi_jt_init_module");
-	/* Fix init/exit functions to point to the CFI jump table */
-	if (init)
-		mod->init =3D *init;
-#ifdef CONFIG_MODULE_UNLOAD
-	exit =3D (exitcall_t *)
-		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
-	if (exit)
-		mod->exit =3D *exit;
-#endif
-	rcu_read_unlock_sched();
-#endif
-}
-
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
 char *module_flags(struct module *mod, char *buf, bool show_state)
 {
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 3a3aa2354ed8..da4bddd26171 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,20 +3,10 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
-#ifdef CONFIG_CFI_CLANG
-# include <asm/page.h>
-# define ALIGN_CFI 		ALIGN(PAGE_SIZE)
-# define SANITIZER_DISCARDS	*(.eh_frame)
-#else
-# define ALIGN_CFI
-# define SANITIZER_DISCARDS
-#endif
-
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
-		SANITIZER_DISCARDS
 	}
=20
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -33,6 +23,10 @@ SECTIONS {
=20
 	__patchable_function_entries : { *(__patchable_function_entries) }
=20
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+	__kcfi_traps 		: { KEEP(*(.kcfi_traps)) }
+#endif
+
 #ifdef CONFIG_LTO_CLANG
 	/*
 	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
@@ -53,15 +47,6 @@ SECTIONS {
 		*(.rodata .rodata.[0-9a-zA-Z_]*)
 		*(.rodata..L*)
 	}
-
-	/*
-	 * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
-	 * of the .text section, and is aligned to PAGE_SIZE.
-	 */
-	.text : ALIGN_CFI {
-		*(.text.__cfi_check)
-		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
-	}
 #endif
 }
=20
--=20
2.37.2.789.g6183377224-goog

