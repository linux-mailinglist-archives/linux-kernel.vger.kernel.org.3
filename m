Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459275B28C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIHV4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIHV4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895FA103026
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s15-20020a5b044f000000b00680c4eb89f1so17725ybp.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=nVJuCRZFiOKjcgDzOiON7GnbFw8l3H4+M/UIBuq716A=;
        b=eN/8i1D/vATeIQD65/jlq2ad3UXPIbG0ihZWjcO9a9q5jiHPVwWyOXzBlY6xHvxHUc
         eZ4N+xX0j33G5M/j/q+uG98g0alxX6W1PO10Wf9se5bjs2oEx5Wb0wNV8mQeAhW/smDo
         qnQDqIbmVBcKSlPvgaEbUK2vwWR9wXQ9RTn66iB+VmRMezifht6hj8NRSPjwfi+ChIQG
         3WyPL8VretIWJAvRZY72acfQVMJFnmBwa3s5DSMpFQGUwhEeNueMMaauXKRmhgVuyVdF
         0VYDX1ly/PL3NVda0z+A+IA6UvGQxN83hSrYgwRWNSfehs4FdaXPvYDf+crgjcqYHn4a
         vzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=nVJuCRZFiOKjcgDzOiON7GnbFw8l3H4+M/UIBuq716A=;
        b=QOWYfoDYYtbBRUQAAqsBLKdjgmKE4TXYDk+VLmdsfqNmY/5gI8bb6RXsMGZLmSzXiU
         rSBvCmwtEViE2IDTdMRBiVKczWB45gBSiEKg4920TiuFhKvuiVXd3EDrYpWh0RvKqSUN
         KpfpxXQbCEP9O9g3HOh5xl0nCO6FmVuVOsds8bLbWQhUs7HT1SlSApPOzsKwUu70L8QI
         1tR99zVowJw1nY/FKunMVYWM+w2plsdkFET4kw338GGv5AMzu2Qrb1HW6PmU6lI2IDkS
         R1yCjrbU/fORC2Pz4w4v0pVzyNpGKhCXwG2B9Fuux1G5FrYVwySAr0frobINerJM+llw
         aLRg==
X-Gm-Message-State: ACgBeo2leWAujGTa3kZpMbdWWFdrQSBbO1MD+1xEXT6O0/r+jT0IrNbK
        fjwFyIJlfUZx+/7Go1ABeEJufzNzK0o1B92WsSXxEg31Ss7tKvpVPqzNRsIVHYwYXFg4iGBXQg5
        gZtfCFOC+ICxkp1TMcmX5PIKQO9DgtxKgKt4lCY9aFmD/J8o5CVfzo9k1EydagsDt/rDNzvTQxg
        BK/fmPYrTJIQ==
X-Google-Smtp-Source: AA6agR5DfwfM0XccFEMr3z3JD+l4duBgSQ3NeeMnm3VD+CyqOtYCAf4ZbixIQIy5/0q7kRKjuLgOG8/eeVOSSwQdQYE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:91d:b0:672:e583:9ed9 with
 SMTP id bu29-20020a056902091d00b00672e5839ed9mr9270680ybb.225.1662674141192;
 Thu, 08 Sep 2022 14:55:41 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:55 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7576; i=samitolvanen@google.com;
 h=from:subject; bh=nyEfjFnzWhpm01bBNm0duC3vRmG3jrqNCTbOmyVKuqE=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS1gXCwikEA41+95htM7367G130ucWT6xEF7oVu
 kt7sawqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktQAKCRBMtfaEi7xW7hxRC/
 4wzEk+rM2ywbVvCu2pWG9r92js1+BFxzRzhIY0O7cOVhheCaRfYvpXdTMn8WApj04b7pAAgi0QXmIA
 EeB2omE/XqcrsZOyZfvPREa9IBkCGRsDfk/zc+2obFCroZttP75vW6bXgHf+nOmh0RRsrgp3CAp2lJ
 qFFLrf+ysPi9jpG1McThp9tUF+kq/jagglF5rLd/4x7GFaL5Pb5BRt1L2spk47kNitDjzI6wXjK25K
 t0MSBker0UJQ8pP2ikQyy8oa9UBwfoEnQ+EI/sGgUbvhStIKvcFLfm9cRP2sD9wxudmWCEciS7tkPy
 n1fJfBVW96ZZxwDBLOKsgWszseEGY/Z+c+2J9J4WWMQ66JgKCNs+uBssJap+ShR625jyJBt6jPD8lk
 EkCkmOGLfj8nYiKxW8pTUgsH0YcXXlGh/x2LVsN1y3ym/8I3GCkyMovYOx3wvOu9Rv0gohh0y73l67
 tU+au9puX0b0Azc/TLpAOCNze2FT5GepuPlBoq/s5MVYs=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 13/22] treewide: Drop function_nocfi
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

With -fsanitize=kcfi, we no longer need function_nocfi() as
the compiler won't change function references to point to a
jump table. Remove all implementations and uses of the macro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/include/asm/ftrace.h           |  2 +-
 arch/arm64/include/asm/mmu_context.h      |  2 +-
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/cpufeature.c            |  2 +-
 arch/arm64/kernel/ftrace.c                |  2 +-
 arch/arm64/kernel/machine_kexec.c         |  2 +-
 arch/arm64/kernel/psci.c                  |  2 +-
 arch/arm64/kernel/smp_spin_table.c        |  2 +-
 drivers/firmware/psci/psci.c              |  4 ++--
 drivers/misc/lkdtm/usercopy.c             |  2 +-
 include/linux/compiler.h                  | 10 ----------
 11 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index dbc45a4157fa..329dbbd4d50b 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -26,7 +26,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #else
-#define MCOUNT_ADDR		((unsigned long)function_nocfi(_mcount))
+#define MCOUNT_ADDR		((unsigned long)_mcount)
 #endif
 
 /* The BL at the callsite's adjusted rec->ip */
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index bba0e630c8bc..d3f8b5df0c1f 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -168,7 +168,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
 		ttbr1 |= TTBR_CNP_BIT;
 	}
 
-	replace_phys = (void *)__pa_symbol(function_nocfi(idmap_cpu_replace_ttbr1));
+	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	__cpu_install_idmap(idmap);
 	replace_phys(ttbr1);
diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index bfeeb5319abf..b1990e38aed0 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -99,7 +99,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 	 * that read this address need to convert this address to the
 	 * Boot-Loader's endianness before jumping.
 	 */
-	writeq_relaxed(__pa_symbol(function_nocfi(secondary_entry)),
+	writeq_relaxed(__pa_symbol(secondary_entry),
 		       &mailbox->entry_point);
 	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ca6e5ca7104e..d8361691efeb 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1713,7 +1713,7 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	if (arm64_use_ng_mappings)
 		return;
 
-	remap_fn = (void *)__pa_symbol(function_nocfi(idmap_kpti_install_ng_mappings));
+	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
 	if (!cpu) {
 		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index ea5dc7c90f46..26789865748c 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -56,7 +56,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned long pc;
 	u32 new;
 
-	pc = (unsigned long)function_nocfi(ftrace_call);
+	pc = (unsigned long)ftrace_call;
 	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
 					  AARCH64_INSN_BRANCH_LINK);
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 19c2d487cb08..ce3d40120f72 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -204,7 +204,7 @@ void machine_kexec(struct kimage *kimage)
 		typeof(cpu_soft_restart) *restart;
 
 		cpu_install_idmap();
-		restart = (void *)__pa_symbol(function_nocfi(cpu_soft_restart));
+		restart = (void *)__pa_symbol(cpu_soft_restart);
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index ab7f4c476104..29a8e444db83 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -38,7 +38,7 @@ static int __init cpu_psci_cpu_prepare(unsigned int cpu)
 
 static int cpu_psci_cpu_boot(unsigned int cpu)
 {
-	phys_addr_t pa_secondary_entry = __pa_symbol(function_nocfi(secondary_entry));
+	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
 	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
 	if (err)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7e1624ecab3c..49029eace3ad 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -66,7 +66,7 @@ static int smp_spin_table_cpu_init(unsigned int cpu)
 static int smp_spin_table_cpu_prepare(unsigned int cpu)
 {
 	__le64 __iomem *release_addr;
-	phys_addr_t pa_holding_pen = __pa_symbol(function_nocfi(secondary_holding_pen));
+	phys_addr_t pa_holding_pen = __pa_symbol(secondary_holding_pen);
 
 	if (!cpu_release_addr[cpu])
 		return -ENODEV;
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 75ef784a3789..bc6b5a12bf74 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -334,7 +334,7 @@ static int __init psci_features(u32 psci_func_id)
 static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
-	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+	phys_addr_t pa_cpu_resume = __pa_symbol(cpu_resume);
 
 	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }
@@ -359,7 +359,7 @@ int psci_cpu_suspend_enter(u32 state)
 
 static int psci_system_suspend(unsigned long unused)
 {
-	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+	phys_addr_t pa_cpu_resume = __pa_symbol(cpu_resume);
 
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
 			      pa_cpu_resume, 0, 0);
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 6215ec995cd3..67db57249a34 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -330,7 +330,7 @@ static void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, function_nocfi(vm_mmap),
+	if (copy_to_user((void __user *)user_addr, vm_mmap,
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7bfafc69172a..973a1bfd7ef5 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -203,16 +203,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__v;								\
 })
 
-/*
- * With CONFIG_CFI_CLANG, the compiler replaces function addresses in
- * instrumented C code with jump table addresses. Architectures that
- * support CFI can define this macro to return the actual function address
- * when needed.
- */
-#ifndef function_nocfi
-#define function_nocfi(x) (x)
-#endif
-
 #endif /* __KERNEL__ */
 
 /*
-- 
2.37.2.789.g6183377224-goog

