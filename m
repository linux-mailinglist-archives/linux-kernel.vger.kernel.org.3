Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71EA573663
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiGMM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiGMM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:29:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681EECB46B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JH791TW76klmRBesh5KjjW8tQhY5Q9TfC3bF5rUIXOs=; b=JTkDLoch66fdbTS/mB1AA4oU+3
        +bqc+aKbSyHLdLzscPQBfzwmA+pZDjbMAzDGHWUr1cs3Ynyltk6eM9hTdNg06cpGmG+XoCSHlLo5e
        a6Wlz8eptkUvmMN8aX81unuZoRisHqq8OGBu1k7YXoqzWQD+LdjDbt0K3gK93oY+yrDkDuByF2xWU
        3aEJxsUYzNgO37kG91KBqyq0IGNQ/RM0uLpD4SYk+sIALo2VXmf0JBZWrrhzO8ME13Pw8APhId/jy
        B0GBbjbHq6uOTX8MTte0iNIQ6PrOs/PI4vT9Ed8sOt7ACaDz0F9F2EECR5xlvN8BFYkyR7jKiGP+D
        QigtQnEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBbU9-008BXJ-OA; Wed, 13 Jul 2022 12:28:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C732300252;
        Wed, 13 Jul 2022 14:28:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46946201C6D24; Wed, 13 Jul 2022 14:28:55 +0200 (CEST)
Date:   Wed, 13 Jul 2022 14:28:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, keescook@chromium.org
Subject: Re: [x86,static_call]  ee88d363d1:
 WARNING:at_arch/x86/kernel/alternative.c:#apply_returns
Message-ID: <Ys66hwtFcGbYmoiZ@hirez.programming.kicks-ass.net>
References: <Ys58BxHxoDZ7rfpr@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys58BxHxoDZ7rfpr@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 04:02:15PM +0800, kernel test robot wrote:

> [   22.065014][    T0] ------------[ cut here ]------------
> [ 22.066738][ T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:557 apply_returns (arch/x86/kernel/alternative.c:557 (discriminator 1)) 
> [   22.069534][    T0] Modules linked in:
> [   22.070738][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc4-00008-gee88d363d156 #1
> [   22.072739][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [ 22.074741][ T0] RIP: 0010:apply_returns (arch/x86/kernel/alternative.c:557 (discriminator 1)) 
> [ 22.076739][ T0] Code: ff ff 74 cb 48 83 c5 04 49 39 ee 0f 87 81 fe ff ff e9 22 ff ff ff 0f 0b 48 83 c5 04 49 39 ee 0f 87 6d fe ff ff e9 0e ff ff ff <0f> 0b 48 83 c5 04 49 39 ee 0f 87 59 fe ff ff e9 fa fe ff ff 48 89
> All code
> ========
>    0:	ff                   	(bad)  
>    1:	ff 74 cb 48          	pushq  0x48(%rbx,%rcx,8)
>    5:	83 c5 04             	add    $0x4,%ebp
>    8:	49 39 ee             	cmp    %rbp,%r14
>    b:	0f 87 81 fe ff ff    	ja     0xfffffffffffffe92
>   11:	e9 22 ff ff ff       	jmpq   0xffffffffffffff38
>   16:	0f 0b                	ud2    
>   18:	48 83 c5 04          	add    $0x4,%rbp
>   1c:	49 39 ee             	cmp    %rbp,%r14
>   1f:	0f 87 6d fe ff ff    	ja     0xfffffffffffffe92
>   25:	e9 0e ff ff ff       	jmpq   0xffffffffffffff38
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	48 83 c5 04          	add    $0x4,%rbp
>   30:	49 39 ee             	cmp    %rbp,%r14
>   33:	0f 87 59 fe ff ff    	ja     0xfffffffffffffe92
>   39:	e9 fa fe ff ff       	jmpq   0xffffffffffffff38
>   3e:	48                   	rex.W
>   3f:	89                   	.byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	48 83 c5 04          	add    $0x4,%rbp
>    6:	49 39 ee             	cmp    %rbp,%r14
>    9:	0f 87 59 fe ff ff    	ja     0xfffffffffffffe68
>    f:	e9 fa fe ff ff       	jmpq   0xffffffffffffff0e
>   14:	48                   	rex.W
>   15:	89                   	.byte 0x89
> [   22.078738][    T0] RSP: 0000:ffffffffa2807dc0 EFLAGS: 00010202
> [   22.080737][    T0] RAX: 0000000000000000 RBX: ffffffffa1b8fe05 RCX: 0000000000000000
> [   22.082546][    T0] RDX: 000000000000000f RSI: ffffffffa184a3e0 RDI: ffffffffa1b8fe05
> [   22.083738][    T0] RBP: ffffffffa42851e8 R08: 0000000000000001 R09: ffffffffa1b8fe05
> [   22.086491][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa1b8fe00
> [   22.087738][    T0] R13: dffffc0000000000 R14: ffffffffa4299890 R15: 1ffffffff4500fbb
> [   22.089739][    T0] FS:  0000000000000000(0000) GS:ffff888396600000(0000) knlGS:0000000000000000
> [   22.091743][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.093738][    T0] CR2: ffff88843ffff000 CR3: 00000003a562a000 CR4: 00000000000006f0
> [   22.095753][    T0] Call Trace:
> [   22.097742][    T0]  <TASK>
> [ 22.098765][ T0] ? rwlock_bug+0xc0/0xc0 
> [ 22.100230][ T0] ? apply_retpolines (arch/x86/kernel/alternative.c:538) 
> [ 22.101791][ T0] ? int3_exception_notify (arch/x86/kernel/alternative.c:849) 
> [ 22.103261][ T0] ? check_bugs (arch/x86/kernel/cpu/bugs.c:149) 
> [ 22.104751][ T0] alternative_instructions (arch/x86/kernel/alternative.c:932) 
> [ 22.106766][ T0] check_bugs (arch/x86/kernel/cpu/bugs.c:159) 
> [ 22.108244][ T0] start_kernel (init/main.c:1132) 
> [ 22.109747][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
> [   22.111300][    T0]  </TASK>
> [   22.112742][    T0] irq event stamp: 87769
> [ 22.113741][ T0] hardirqs last enabled at (87781): __up_console_sem (arch/x86/include/asm/irqflags.h:45 (discriminator 1) arch/x86/include/asm/irqflags.h:80 (discriminator 1) arch/x86/include/asm/irqflags.h:138 (discriminator 1) kernel/printk/printk.c:264 (discriminator 1)) 
> [ 22.115740][ T0] hardirqs last disabled at (87794): __up_console_sem (kernel/printk/printk.c:262 (discriminator 1)) 
> [ 22.117739][ T0] softirqs last enabled at (2774): cgroup_idr_alloc+0x5b/0x1c0 
> [ 22.119739][ T0] softirqs last disabled at (2772): cgroup_idr_alloc+0x2e/0x1c0 
> [   22.121741][    T0] ---[ end trace 0000000000000000 ]---


diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d6858533e6e5..ff309e829192 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -555,8 +555,10 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 			dest = addr + insn.length + insn.immediate.value;
 
 		if (__static_call_fixup(addr, op, dest) ||
-		    WARN_ON_ONCE(dest != &__x86_return_thunk))
+		    WARN_ON_ONCE(dest != &__x86_return_thunk)) {
+			printk("XXX: %pS %pS : %*ph", addr, dest, 5, addr);
 			continue;
+		}
 
 		DPRINTK("return thunk at: %pS (%px) len: %d to: %pS",
 			addr, addr, insn.length,

Gets me:

[    2.559091][    T0] ---[ end trace 0000000000000000 ]---
[    2.561092][    T0] XXX: lkdtm_rodata_do_nothing+0x0/0x1240 lkdtm_rodata_do_nothing+0x5/0x1240 : e9 00 00 00 00

which is a result of:

drivers/misc/lkdtm/Makefile:OBJCOPYFLAGS_rodata_objcopy.o   := \
drivers/misc/lkdtm/Makefile:                        --rename-section .noinstr.text=.rodata,alloc,readonly,load,contents

which makes that:

0000000000000000 <lkdtm_rodata_do_nothing>:
   0:   e9 00 00 00 00          jmp    5 <lkdtm_rodata_do_nothing+0x5>  1: R_X86_64_PLT32       __x86_return_thunk-0x4

remains unresolved.

Kees, what's up with that thing, this is 'weird' at best.
