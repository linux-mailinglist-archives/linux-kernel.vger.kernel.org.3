Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550F4BC185
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiBRVF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:05:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbiBRVFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:05:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC22528B62B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eAq41CbrMkcQnROsQjt7CUO6ANNFYk+q4WR8WhAKO5c=; b=eCsEWcTshrcntcB2nUMxJOzgdF
        ILJSspSSVoDZFOONURt0rzitRuDVQqkMLjqmO4xkGeWTWGdijZ9uAXL1f5moHph1jGrm4fjyuqmpa
        MSP2yMZ6yfDyCeiAOpgLCKl8KdVkXpwbrx8sd6gEc5qDfjJPpB5dyIvGO+tBLZkcprvlguP30OC87
        Hm5ez6TOzGQ8OHLw0sxEO5WP1/u6qYKbAApHPDuAnLPqZ1bPrDs+MiUFEQjmSQFd8YvsGn0vGXzfh
        4gKLGFgiPap77pQUZxqsWGcJszBglm6/4qpztlbxRR9xwcONd5MEmqIv2m+BmRXTq4DfnKWW06uc4
        8iUQKXsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLARE-00AucW-2N; Fri, 18 Feb 2022 21:05:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3543A300296;
        Fri, 18 Feb 2022 22:05:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E32162BCA7EB4; Fri, 18 Feb 2022 22:05:10 +0100 (CET)
Date:   Fri, 18 Feb 2022 22:05:10 +0100
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
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 19/29] x86/ibt,xen: Annotate away warnings
Message-ID: <YhAKBrTiQwFkocez@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.696743603@infradead.org>
 <e5b93f0a-a28c-8c63-0193-4b4d0db509ab@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5b93f0a-a28c-8c63-0193-4b4d0db509ab@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 08:24:41PM +0000, Andrew Cooper wrote:
> On 18/02/2022 16:49, Peter Zijlstra wrote:
> > The xen_iret ENDBR is needed for pre-alternative code calling the
> > pv_ops using indirect calls.
> >
> > The rest look like hypervisor entry points which will be IRET like
> > transfers and as such don't need ENDBR.
> 
> That's up for debate.  Mechanically, yes - they're IRET or SYSERET.
> 
> Logically however, they're entrypoints registered with Xen, so following
> the spec, Xen ought to force WAIT-FOR-ENDBR.

Cute..

> I'd be tempted to leave the ENDBR's in.  It feels like a safer default
> until we figure out how to paravirt IBT properly.

Fair enough, done.

> at a minimum, and possibly also:
> 
> diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
> index 444d824775f6..96db5c50a6e7 100644
> --- a/arch/x86/xen/xen-asm.S
> +++ b/arch/x86/xen/xen-asm.S
> @@ -124,7 +124,7 @@ SYM_CODE_START(xen_\name)
>         UNWIND_HINT_EMPTY
>         pop %rcx
>         pop %r11
> -       jmp  \name
> +       jmp  \name + 4 * IS_ENABLED(CONFIG_X86_IBT)
>  SYM_CODE_END(xen_\name)
>  _ASM_NOKPROBE(xen_\name)
>  .endm

objtool will do that for you, it will rewrite all direct jmp/call to
endbr.


Something like so then?

---
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -818,6 +818,7 @@ SYM_CODE_END(exc_xen_hypervisor_callback
  */
 SYM_CODE_START(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	movl	%ds, %ecx
 	cmpw	%cx, 0x10(%rsp)
 	jne	1f
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -392,6 +392,7 @@ SYM_CODE_START(early_idt_handler_array)
 	.endr
 	UNWIND_HINT_IRET_REGS offset=16 entry=0
 SYM_CODE_END(early_idt_handler_array)
+	ANNOTATE_NOENDBR // early_idt_handler_array[NUM_EXCEPTION_VECTORS]
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -624,6 +624,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	TRAP_ENTRY(exc_alignment_check,			false ),
 	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
+	TRAP_ENTRY(exc_control_protection,		false ),
 };
 
 static bool __ref get_trap_addr(void **addr, unsigned int ist)
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -122,6 +122,7 @@ SYM_FUNC_END(xen_read_cr2_direct);
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	pop %rcx
 	pop %r11
 	jmp  \name
@@ -147,6 +148,7 @@ xen_pv_trap asm_exc_page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
+xen_pv_trap_asm_exc_control_protection
 #ifdef CONFIG_X86_MCE
 xen_pv_trap asm_xenpv_exc_machine_check
 #endif /* CONFIG_X86_MCE */
@@ -162,6 +164,7 @@ SYM_CODE_START(xen_early_idt_handler_arr
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	UNWIND_HINT_EMPTY
+	ENDBR
 	pop %rcx
 	pop %r11
 	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
@@ -169,6 +172,7 @@ SYM_CODE_START(xen_early_idt_handler_arr
 	.fill xen_early_idt_handler_array + i*XEN_EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
 SYM_CODE_END(xen_early_idt_handler_array)
+	ANNOTATE_NOENDBR
 	__FINIT
 
 hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
@@ -189,6 +193,7 @@ hypercall_iret = hypercall_page + __HYPE
  */
 SYM_CODE_START(xen_iret)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	pushq $0
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
@@ -230,6 +235,7 @@ SYM_CODE_END(xenpv_restore_regs_and_retu
 /* Normal 64-bit system call target */
 SYM_CODE_START(xen_syscall_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	popq %rcx
 	popq %r11
 
@@ -249,6 +255,7 @@ SYM_CODE_END(xen_syscall_target)
 /* 32-bit compat syscall target */
 SYM_CODE_START(xen_syscall32_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	popq %rcx
 	popq %r11
 
@@ -266,6 +273,7 @@ SYM_CODE_END(xen_syscall32_target)
 /* 32-bit compat sysenter target */
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	/*
 	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
 	 * that we don't need to guard against single step exceptions here.
@@ -289,6 +297,7 @@ SYM_CODE_END(xen_sysenter_target)
 SYM_CODE_START(xen_syscall32_target)
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -25,8 +25,11 @@
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_FUNC
-		.skip 31, 0x90
-		RET
+		ANNOTATE_NOENDBR
+		/*
+		 * Xen will write the hypercall page, and sort out ENDBR.
+		 */
+		.skip 32, 0xcc
 	.endr
 
 #define HYPERCALL(n) \
@@ -74,6 +77,7 @@ SYM_CODE_END(startup_xen)
 .pushsection .text
 SYM_CODE_START(asm_cpu_bringup_and_idle)
 	UNWIND_HINT_EMPTY
+	ENDBR
 
 	call cpu_bringup_and_idle
 SYM_CODE_END(asm_cpu_bringup_and_idle)
