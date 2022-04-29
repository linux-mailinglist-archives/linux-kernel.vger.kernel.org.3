Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA11B5155D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380933AbiD2Ukt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380891AbiD2UkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CA584A22
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e642be1a51so83725977b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=vvdIaJf57HGaDpMnbrJ8giqLRUU+BTS8OjFrmaz2vTE=;
        b=pp5ZuqtMoctSU0CirU7eAqTG/TJOM0spnINt8Gjn3TLZaHntxQdntxMbG6AC9Ytn1A
         YbobImxlpkDKOtCc7p+HUcjkX6xeFPx/DEbzlgXaBCLyH85pOtUO5AjwtRLJ5v32iDgF
         GOxVmU9+KLnarIhguwlaAcJMXLCHb/CIIQn5HllZfWoEDWIMA9Dkq2G1E64CEeOFgP/U
         8lRGqsLZUoDl9j6+7EG0KVET8D+nRVZ9/GAPoDTb0VvTkSklhvkSLnv3DwQ3HD+kRcY5
         VrykuvxxspP2ULayXxAZ1mjo3k7ttqlSFX+HHy88dA/a3EhnXPGJv5NH9Tm80twX9v1Q
         sg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=vvdIaJf57HGaDpMnbrJ8giqLRUU+BTS8OjFrmaz2vTE=;
        b=1ClX8G5DZ7vx4FmAmibvcvj7aQ9US/0ZIk70joOWXrMdlQAPdVlhqoVRXgRLXVdHoS
         t0JYU+2WYxEXItI+SWPX67thk830fUlRkqze3tbFJcp+mx+tFyYW1iFiCVeDyTqR3YBG
         t/FUWt2m1+AdvQZNWL3MXxOYUEjOug2OcXo4zFH3bJPQJhZa03xPNRAcjl+Qy65hylsK
         hSE3Aoey1BhiEafFRx3o9ouM1zM0LxCfrFAuKVxaNVSIVQXEQ4H6G4tFLnMrzF9JqjC7
         pilXPdC//sZZVXomuP1VVLavrggp1cZJWHROdYZ63e8y5Mb1xsrB7Qu8xf3e1ygZp1H2
         E7pQ==
X-Gm-Message-State: AOAM530v7H6bXyzAyehVQJSz5k/+EJvaTF43IsoOpbmH019/PfSMdRCT
        M7nITPplu4jUmIgtkKAyBinAoeKDyDvPlK0NXhr5PRA3x9TnyGTDfWPk7wMX76rU8hU/p4kkNgI
        5FUqecT03kVBv14zTQPPhcbODdNR/OlP93zUGP66a688U/JQ2sIJC1tQHbqxkQfZZWkVsFaUQbG
        WpYRcJBqSo/w==
X-Google-Smtp-Source: ABdhPJzK+TM3mWgJX5Du5pYGBn42fe+Iz5sXydBvEX3gH6bzFZSppJYXAmv+vNiXUVCsvdPo/kBBgKk9tLQAOWDp42s=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:390:b0:645:7d46:f1db with
 SMTP id f16-20020a056902039000b006457d46f1dbmr1280096ybs.85.1651264622333;
 Fri, 29 Apr 2022 13:37:02 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:29 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=15228; h=from:subject;
 bh=0g7XP1LgryML35bYmY5P55DUledGJO075lwf/wPq5XY=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExVzS6QJPpNhwgvz4rLUMgG/eseoiNocaoGE0+w
 tX5LFGCJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVQAKCRBMtfaEi7xW7hkYC/
 4ubQXAmms/iLy/3p508tt7PKf5jjRHk61JliAxBIHRWk2AJ+/ApG33RlrxlUW3l1l97z84CdogaqSa
 jdo5kzTr5mVE8BojuUFoGj3o6JKuqeuKDXPluSgQkK9/n0l6BGyNpH5iMrTqjmTS5+qKjA7Z8yCk6N
 h2uNUbPmBJ5gerAmb+taQVdcEAcfdLsOmPIoRxKuuFj8hqFU8wwW7mbcQAQZNJ5U//BpPEbO0Ad299
 aRh5GtCHpvSxLRL9t1egoSBtslKOt86N19OjWNXXnJybdVSRx5Mo8+RUbX33VIUz4hXbuUH7FJuyL9
 JlZlvDFZwT5JKvRgZWVGKqKMEyyQuQfM5pn1P6Zx/CT5vuWlWZY3EUuVGjUZ/9wHZFNgzPJgCbRBoh
 ng2kyfVoFHuWLCYRgUx6LAoxF3YPUvGXy+ZGeUgSSYjaZyl2o+S9T4Gt8+YCoSNHiXDy5yGH3hYtX5
 TMqHSVc2S30OxsckAvhcZzkLCdIj8XoQ0tfMFRpbJIeMU=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 06/21] cfi: Switch to -fsanitize=kcfi
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

Switch from Clang's original forward-edge control-flow integrity
implementation to -fsanitize=3Dkcfi, which is better suited for the
kernel, as it doesn't require LTO, doesn't use a jump table that
requires altering function references, and won't break cross-module
function address equality.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile                          |  13 +--
 arch/Kconfig                      |   8 +-
 include/asm-generic/vmlinux.lds.h |  38 ++++-----
 include/linux/cfi.h               |  24 +++++-
 include/linux/compiler-clang.h    |   8 +-
 include/linux/module.h            |   4 +-
 kernel/cfi.c                      | 129 ++++++++++++++++--------------
 kernel/module.c                   |  34 +-------
 scripts/module.lds.S              |  24 ++----
 9 files changed, 126 insertions(+), 156 deletions(-)

diff --git a/Makefile b/Makefile
index c3ec1ea42379..22a5d48f5fb4 100644
--- a/Makefile
+++ b/Makefile
@@ -915,18 +915,7 @@ export CC_FLAGS_LTO
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
+CC_FLAGS_CFI	:=3D -fsanitize=3Dkcfi -fno-sanitize-blacklist
 KBUILD_CFLAGS	+=3D $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 625db6376726..601379a6173d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -722,12 +722,8 @@ config ARCH_SUPPORTS_CFI_CLANG
=20
 config CFI_CLANG
 	bool "Use Clang's Control Flow Integrity (CFI)"
-	depends on LTO_CLANG && ARCH_SUPPORTS_CFI_CLANG
-	# Clang >=3D 12:
-	# - https://bugs.llvm.org/show_bug.cgi?id=3D46258
-	# - https://bugs.llvm.org/show_bug.cgi?id=3D47479
-	depends on CLANG_VERSION >=3D 120000
-	select KALLSYMS
+	depends on ARCH_SUPPORTS_CFI_CLANG
+	depends on $(cc-option,-fsanitize=3Dkcfi)
 	help
 	  This option enables Clang=E2=80=99s forward-edge Control Flow Integrity
 	  (CFI) checking, where the compiler injects a runtime check to each
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index 69138e9db787..20bfd2f01d6f 100644
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
+#ifdef CONFIG_CFI_CLANG
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
@@ -1027,6 +1028,7 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	*(.kcfi_types)							\
 	/* ld.bfd warns about .gnu.version* even when not emitted */	\
 	*(.gnu.version*)						\
=20
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 2cdbc0fbd0ab..9cbadfca7e01 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -2,17 +2,33 @@
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
=20
-/* Compiler-generated function in each module, and the kernel */
-extern void __cfi_check(uint64_t id, void *ptr, void *diag);
+#ifdef CONFIG_MODULES
+void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, str=
uct module *mod);
+#endif
+
+void *arch_get_cfi_target(unsigned long addr, struct pt_regs *regs);
+enum bug_trap_type report_cfi(unsigned long addr, struct pt_regs *regs);
+#else
+
+#ifdef CONFIG_MODULES
+static inline void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr=
 *sechdrs,
+				       struct module *mod) {}
+#endif
=20
+static inline enum bug_trap_type report_cfi(unsigned long addr, struct pt_=
regs *regs)
+{
+	return BUG_TRAP_TYPE_NONE;
+}
 #endif /* CONFIG_CFI_CLANG */
=20
 #endif /* _LINUX_CFI_H */
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.=
h
index babb1347148c..c4ff42859077 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -66,9 +66,6 @@
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
=20
-#define __nocfi		__attribute__((__no_sanitize__("cfi")))
-#define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
-
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
@@ -93,3 +90,8 @@
=20
 #define __diag_ignore_all(option, comment) \
 	__diag_clang(11, ignore, option)
+
+#if CONFIG_CFI_CLANG
+/* Disable CFI checking inside a function. */
+#define __nocfi		__attribute__((__no_sanitize__("kcfi")))
+#endif
diff --git a/include/linux/module.h b/include/linux/module.h
index 87857275c047..430ea19f14f6 100644
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
@@ -389,7 +388,8 @@ struct module {
 	unsigned int num_syms;
=20
 #ifdef CONFIG_CFI_CLANG
-	cfi_check_fn cfi_check;
+	unsigned long *kcfi_traps;
+	unsigned long *kcfi_traps_end;
 #endif
=20
 	/* Kernel parameters. */
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 2cc0d01ea980..d9907df6576e 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -1,94 +1,101 @@
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
+/* Returns the target of the indirect call that follows the trap in `addr`=
. */
+void * __weak arch_get_cfi_target(unsigned long addr, struct pt_regs *regs=
)
 {
-	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE))
-		WARN_RATELIMIT(1, "CFI failure (target: %pS):\n", ptr);
-	else
-		panic("CFI failure (target: %pS)\n", ptr);
+	return NULL;
 }
=20
 #ifdef CONFIG_MODULES
+/* Populates `kcfi_trap(_end)?` fields in `struct module`. */
+void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+			 struct module *mod)
+{
+	char *secstrings;
+	unsigned int i;
+
+	mod->kcfi_traps =3D NULL;
+	mod->kcfi_traps_end =3D NULL;
+
+	secstrings =3D (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (i =3D 1; i < hdr->e_shnum; i++) {
+		if (strcmp(secstrings+sechdrs[i].sh_name, "__kcfi_traps"))
+			continue;
=20
-static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
+		mod->kcfi_traps =3D (unsigned long *)sechdrs[i].sh_addr;
+		mod->kcfi_traps_end =3D (unsigned long *)(sechdrs[i].sh_addr + sechdrs[i=
].sh_size);
+		break;
+	}
+}
+
+static bool is_module_cfi_trap(unsigned long addr)
 {
-	cfi_check_fn fn =3D NULL;
+	bool found =3D false;
 	struct module *mod;
+	unsigned long *p;
=20
 	rcu_read_lock_sched_notrace();
-	mod =3D __module_address(ptr);
+
+	mod =3D __module_address(addr);
 	if (mod)
-		fn =3D mod->cfi_check;
+		for (p =3D mod->kcfi_traps; !found && p < mod->kcfi_traps_end; ++p)
+			found =3D (*p =3D=3D addr);
+
 	rcu_read_unlock_sched_notrace();
=20
-	return fn;
+	return found;
 }
=20
-static inline cfi_check_fn find_check_fn(unsigned long ptr)
-{
-	cfi_check_fn fn =3D NULL;
+#else /* CONFIG_MODULES */
=20
-	if (is_kernel_text(ptr))
-		return __cfi_check;
+static inline bool is_module_cfi_trap(unsigned long addr)
+{
+	return false;
+}
=20
-	/*
-	 * Indirect call checks can happen when RCU is not watching. Both
-	 * the shadow and __module_address use RCU, so we need to wake it
-	 * up if necessary.
-	 */
-	RCU_NONIDLE({
-		fn =3D find_module_check_fn(ptr);
-	});
+#endif /* CONFIG_MODULES */
=20
-	return fn;
-}
+extern unsigned long __start___kcfi_traps[];
+extern unsigned long __stop___kcfi_traps[];
=20
-void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+static bool is_cfi_trap(unsigned long addr)
 {
-	cfi_check_fn fn =3D find_check_fn((unsigned long)ptr);
+	unsigned long *p;
=20
-	if (likely(fn))
-		fn(id, ptr, diag);
-	else /* Don't allow unchecked modules */
-		handle_cfi_failure(ptr);
+	for (p =3D __start___kcfi_traps; p < __stop___kcfi_traps; ++p)
+		if (*p =3D=3D addr)
+			return true;
+
+	return is_module_cfi_trap(addr);
 }
-EXPORT_SYMBOL(__cfi_slowpath_diag);
=20
-#else /* !CONFIG_MODULES */
+#define __CFI_ERROR_FMT "CFI failure at %pS (target: %pS)\n"
=20
-void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+static enum bug_trap_type __report_cfi(void *addr, void *target, struct pt=
_regs *regs)
 {
-	handle_cfi_failure(ptr); /* No modules */
+	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE)) {
+		pr_warn(__CFI_ERROR_FMT, addr, target);
+		__warn(NULL, 0, addr, 0, regs, NULL);
+
+		return BUG_TRAP_TYPE_WARN;
+	} else {
+		pr_crit(__CFI_ERROR_FMT, addr, target);
+		return BUG_TRAP_TYPE_BUG;
+	}
 }
-EXPORT_SYMBOL(__cfi_slowpath_diag);
-
-#endif /* CONFIG_MODULES */
=20
-void cfi_failure_handler(void *data, void *ptr, void *vtable)
+enum bug_trap_type report_cfi(unsigned long addr, struct pt_regs *regs)
 {
-	handle_cfi_failure(ptr);
+	if (!is_cfi_trap(addr))
+		return BUG_TRAP_TYPE_NONE;
+
+	return __report_cfi((void *)addr, arch_get_cfi_target(addr, regs), regs);
 }
-EXPORT_SYMBOL(cfi_failure_handler);
diff --git a/kernel/module.c b/kernel/module.c
index 296fe02323e9..411ae8c358e6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -57,6 +57,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/cfi.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
=20
@@ -3871,8 +3872,9 @@ static int complete_formation(struct module *mod, str=
uct load_info *info)
 	if (err < 0)
 		goto out;
=20
-	/* This relies on module_mutex for list integrity. */
+	/* These rely on module_mutex for list integrity. */
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
+	module_cfi_finalize(info->hdr, info->sechdrs, mod);
=20
 	module_enable_ro(mod, false);
 	module_enable_nx(mod);
@@ -3928,8 +3930,6 @@ static int unknown_module_param_cb(char *param, char =
*val, const char *modname,
 	return 0;
 }
=20
-static void cfi_init(struct module *mod);
-
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -4059,9 +4059,6 @@ static int load_module(struct load_info *info, const =
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
@@ -4502,31 +4499,6 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *,=
 const char *,
 #endif /* CONFIG_LIVEPATCH */
 #endif /* CONFIG_KALLSYMS */
=20
-static void cfi_init(struct module *mod)
-{
-#ifdef CONFIG_CFI_CLANG
-	initcall_t *init;
-	exitcall_t *exit;
-
-	rcu_read_lock_sched();
-	mod->cfi_check =3D (cfi_check_fn)
-		find_kallsyms_symbol_value(mod, "__cfi_check");
-	init =3D (initcall_t *)
-		find_kallsyms_symbol_value(mod, "__cfi_jt_init_module");
-	exit =3D (exitcall_t *)
-		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
-	rcu_read_unlock_sched();
-
-	/* Fix init/exit functions to point to the CFI jump table */
-	if (init)
-		mod->init =3D *init;
-#ifdef CONFIG_MODULE_UNLOAD
-	if (exit)
-		mod->exit =3D *exit;
-#endif
-#endif
-}
-
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
=20
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 1d0e1e4dc3d2..ccd75d283840 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,20 +3,11 @@
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
+		*(.kcfi_types)
 	}
=20
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -31,6 +22,10 @@ SECTIONS {
=20
 	__patchable_function_entries : { *(__patchable_function_entries) }
=20
+#ifdef CONFIG_CFI_CLANG
+	__kcfi_traps 		: { KEEP(*(.kcfi_traps)) }
+#endif
+
 #ifdef CONFIG_LTO_CLANG
 	/*
 	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
@@ -51,15 +46,6 @@ SECTIONS {
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
2.36.0.464.gb9c8b46e94-goog

