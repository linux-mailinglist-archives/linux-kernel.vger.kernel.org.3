Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F464BE9B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377656AbiBUOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:21:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377651AbiBUOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:21:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D86C2250B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oQxKjE+NbScOSvvUVDYhZKgjn3w61p+KEEu/0EN0deE=; b=sNrq/xOO+upjmZadISpbEdfa9W
        EbgYJbzV9+7j87LUbf7cH8lcYO38yg67OSCmWBZtXnkKwKr5OmOhquZ6NJ4WOa06q7eLHFqfvLtQc
        O4sbGpHI/o7wTfGcGUqUarvWyxhZsJT9vF5Gssnzi4qPNpDoB7/v2/x6lU0jbpfMARKScK13gychE
        azgr0aGm/Tu/ELrNqNXE9VY8XqHdS+UmAXMnImDFLb+8v1VQYhjURsPzpyWfZiEycJs9p+FDsAz+B
        kcTKTGCf+jncxnq5Qlwy421wRM9w03Q4mV2EcWscX02y2KjJM+ZUyoI81y9uUSFmu1TE3Au7xsliF
        8gx+Zdjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nM9Xz-001tpU-Uc; Mon, 21 Feb 2022 14:20:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF11C30045A;
        Mon, 21 Feb 2022 15:20:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2CB0203A807F; Mon, 21 Feb 2022 15:20:13 +0100 (CET)
Date:   Mon, 21 Feb 2022 15:20:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 19/29] x86/ibt,xen: Annotate away warnings
Message-ID: <YhOfnTeVGxGvnuE4@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.696743603@infradead.org>
 <e5b93f0a-a28c-8c63-0193-4b4d0db509ab@citrix.com>
 <YhAKBrTiQwFkocez@hirez.programming.kicks-ass.net>
 <47e22369-2ba5-cde6-0f69-5694a517167c@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e22369-2ba5-cde6-0f69-5694a517167c@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 11:07:15PM +0000, Andrew Cooper wrote:
> or so, but my point is that the early Xen code, if it can identify this
> patch point separate to the list of everything, can easily arrange for
> it to be modified before HYPERCALL_set_trap_table (Xen PV's LIDT), and
> then return_to_kernel is in its fully configured state (paravirt or
> otherwise) before interrupts/exceptions can be taken.

I ended up with the below... still bit of a hack, and I wonder if the
asm version you did isn't saner..

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -619,8 +619,8 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
 
 	/* Restore RDI. */
 	popq	%rdi
-	SWAPGS
-	INTERRUPT_RETURN
+	swapgs
+	jmp	.Lnative_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
@@ -637,11 +637,16 @@ SYM_INNER_LABEL(restore_regs_and_return_
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
 	 * when returning from IPI handler.
 	 */
-	INTERRUPT_RETURN
+#ifdef CONFIG_XEN_PV
+SYM_INNER_LABEL(early_xen_iret_patch, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
+	.byte 0xe9
+	.long .Lnative_iret - (. + 4)
+#endif
 
-SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
+.Lnative_iret:
 	UNWIND_HINT_IRET_REGS
-	ENDBR // paravirt_iret
+	ANNOTATE_NOENDBR
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
 	 * 64-bit mode SS:RSP on the exception stack is always valid.
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -141,13 +141,8 @@ static __always_inline void arch_local_i
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
 #define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
-#define INTERRUPT_RETURN						\
-	ANNOTATE_RETPOLINE_SAFE;					\
-	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
-		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 #else
 #define SWAPGS	swapgs
-#define INTERRUPT_RETURN	jmp native_iret
 #endif
 #endif
 #endif /* !__ASSEMBLY__ */
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -272,7 +272,6 @@ struct paravirt_patch_template {
 
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
-extern void (*paravirt_iret)(void);
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -350,7 +350,6 @@ SYM_CODE_START_NOALIGN(vc_boot_ghcb)
 	/* Remove Error Code */
 	addq    $8, %rsp
 
-	/* Pure iret required here - don't use INTERRUPT_RETURN */
 	iretq
 SYM_CODE_END(vc_boot_ghcb)
 #endif
@@ -435,6 +434,8 @@ SYM_CODE_END(early_idt_handler_common)
  * early_idt_handler_array can't be used because it returns via the
  * paravirtualized INTERRUPT_RETURN and pv-ops don't work that early.
  *
+ * XXX it does, fix this.
+ *
  * This handler will end up in the .init.text section and not be
  * available to boot secondary CPUs.
  */
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -151,8 +151,6 @@ void paravirt_set_sched_clock(u64 (*func
 }
 
 /* These are in entry.S */
-extern void native_iret(void);
-
 static struct resource reserve_ioports = {
 	.start = 0,
 	.end = IO_SPACE_LIMIT,
@@ -416,8 +414,6 @@ struct paravirt_patch_template pv_ops =
 
 #ifdef CONFIG_PARAVIRT_XXL
 NOKPROBE_SYMBOL(native_load_idt);
-
-void (*paravirt_iret)(void) = native_iret;
 #endif
 
 EXPORT_SYMBOL(pv_ops);
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1178,9 +1178,13 @@ static void __init xen_domu_set_legacy_f
 	x86_platform.legacy.rtc = 0;
 }
 
+extern void early_xen_iret_patch(void);
+
 /* First C function to be called on Xen boot */
 asmlinkage __visible void __init xen_start_kernel(void)
 {
+	void *early_xen_iret = &early_xen_iret_patch;
+	void *xen_iret_dest = &xen_iret;
 	struct physdev_set_iopl set_iopl;
 	unsigned long initrd_start = 0;
 	int rc;
@@ -1188,6 +1192,13 @@ asmlinkage __visible void __init xen_sta
 	if (!xen_start_info)
 		return;
 
+	OPTIMIZER_HIDE_VAR(early_xen_iret);
+	OPTIMIZER_HIDE_VAR(xen_iret_dest);
+
+	memcpy(early_xen_iret,
+	       text_gen_insn(JMP32_INSN_OPCODE, early_xen_iret, xen_iret_dest),
+	       JMP32_INSN_SIZE);
+
 	xen_domain_type = XEN_PV_DOMAIN;
 	xen_start_flags = xen_start_info->flags;
 
@@ -1196,7 +1207,6 @@ asmlinkage __visible void __init xen_sta
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
 	pv_ops.cpu = xen_cpu_ops.cpu;
-	paravirt_iret = xen_iret;
 	xen_init_irq_ops();
 
 	/*
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -193,7 +193,7 @@ hypercall_iret = hypercall_page + __HYPE
  */
 SYM_CODE_START(xen_iret)
 	UNWIND_HINT_EMPTY
-	ENDBR
+	ANNOTATE_NOENDBR
 	pushq $0
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
