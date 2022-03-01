Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5034C92CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiCASUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiCASUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:20:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E04667C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:19:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c18-20020a7bc852000000b003806ce86c6dso1742370wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UtPrVb0f53YYX2b6RFlODaq1yL/aXGcjZzyo6JeDgY8=;
        b=g95HB/jmWuwfM/wFu7blazFMp1er0UHfAATqb0J38vUtYvYMCDKjgMWv1FT0vwJWYf
         /GWaxy8Duco6mA8a0KGNJdOuS98FO2c013FObEhtlIfUD2yLuOd9jZ5u+o73D72zlecb
         SKEcdDEpQ8U4vRL6t9/YfRtn8Ss58R7+roDU6DtAXyK37ww3R8kOVPyro/dw1ftZfFZZ
         3BR42Jh9cEzwFGXcBx5Ooyl5+Fvl0DC3pGFhxu+hodEWnsQWlJuzz5t0AnilHZf+01tT
         421CpvAN4AkxYWIPbDmAptu04lUEokrWWBY+dIJmQH5UxhTySyWIvQOT2W2v5adCbFYC
         LmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UtPrVb0f53YYX2b6RFlODaq1yL/aXGcjZzyo6JeDgY8=;
        b=7cVg/NDbRMVTaTeyovGOqmLItxDBU+pMnKL2EonzbLuTP8FS+VdgHr0FbtEbH1WzfD
         k+bj98iyUnRx7qHlkK7mr9ve95LE3CDGwi27+HRTZCuoHcgnbQM9Q7LZuLKwk+gnp26H
         4Zwreh4h1E14BNzf/83MalJ01Cf+SqaTeTJJj4OhRkXcp0ZQ3kfJP8HNKzvZ3C7gHF37
         YD6Qb5PVWM9ftSpRzD8CX+JP80D4GPp/YeAoF/tofeemZLcLCNyqQVZjJkU5N2UQ6KiT
         6fMVW20ey724Z1aSnmvrvE86nEI5gNywdlWJ7u6Utbzn81NUQhAyQJiV8rOo7KT7vIIp
         8a6Q==
X-Gm-Message-State: AOAM532d47N0NtxBwUtYouEm3wV1t6jVHQrkXtNqW9evBwrRoCSq6fg9
        f7VMCgb9RDVkP1wwtQ/77to=
X-Google-Smtp-Source: ABdhPJwArUy4EplXDgim3tlE+gfX5EUBMhpOuGajKvWhFwjLZvDTmdPvoA97uyTRj+kWrB2X64JA8g==
X-Received: by 2002:a05:600c:1d08:b0:381:6eda:67d1 with SMTP id l8-20020a05600c1d0800b003816eda67d1mr7557489wms.88.1646158775052;
        Tue, 01 Mar 2022 10:19:35 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm14535256wrl.95.2022.03.01.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:19:34 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:19:33 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: boot flooded with unwind: Index not found
Message-ID: <Yh5jtaSn5cu+ive9@Red>
References: <Yh5ASXVoWoMj7/Rr@Red>
 <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
 <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
 <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Mar 01, 2022 at 05:52:30PM +0100, Ard Biesheuvel a écrit :
> On Tue, 1 Mar 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 1 Mar 2022 at 16:52, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Mar 01, 2022 at 04:48:25PM +0100, Corentin Labbe wrote:
> > > > Hello
> > > >
> > > > I booted today linux-next (20220301) and my boot is flooded with:
> > > > [    0.000000] unwind: Index not found c0f0c440
> > > > [    0.000000] unwind: Index not found 00000000
> > > > [    0.000000] unwind: Index not found c0f0c440
> > > > [    0.000000] unwind: Index not found 00000000
> > > >
> > > > This happen on a sun8i-a83t-bananapi-m3
> > >
> > > Have you enabled vmapped stacks?
> > >
> >
> > This is probably related to
> >
> > 538b9265c063 ARM: unwind: track location of LR value in stack frame
> >
> > which removes a kernel_text_address() check on frame->pc as it is
> > essentially redundant, given that we won't find unwind data otherwise.
> > Unfortunately, I failed to realise that the other check carries a
> > pr_warn(), which may apparently fire spuriously in some cases.
> >
> > The 0x0 value can easily be filtered out, but i would be interesting
> > where the other value originates from. We might be able to solve this
> > with a simple .nounwind directive in a asm routine somewhere.
> >
> > I'll prepare a patch that disregards the 0x0 value - could you check
> > in the mean time what the address 0xcf0c440 coincides with in your
> > build?
> 
> Something like the below should restore the previous behavior, while
> taking the kernel_text_address() check out of the hot path.
> 
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -400,7 +400,8 @@ int unwind_frame(struct stackframe *frame)
> 
>         idx = unwind_find_idx(frame->pc);
>         if (!idx) {
> -               pr_warn("unwind: Index not found %08lx\n", frame->pc);
> +               if (frame->pc && kernel_text_address(frame->pc))
> +                       pr_warn("unwind: Index not found %08lx\n", frame->pc);
>                 return -URC_FAILURE;
>         }

Thanks, message are not shown anymore.
But now I have other errors (perhaps not related):
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Banana Pi BPI-M3
[    0.000000] earlycon: uart0 at MMIO32 0x01c28000 (options '')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 16 MiB at 0xbf000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x000000006fffffff]
[    0.000000]   HighMem  [mem 0x0000000070000000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000] percpu: Embedded 16 pages/cpu s34740 r8192 d22604 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x01c28000 ip=dhcp
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 2016360K/2097152K available (9216K kernel code, 1534K rwdata, 3328K rodata, 1024K init, 7189K bss, 64408K reserved, 16384K cma-reserved, 1294336K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] trace event string verifier disabled
[    0.000000] Running RCU self tests
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU lockdep checking is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] random: get_random_bytes called from start_kernel+0x534/0x6cc with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000003] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.008660] Switching to timer-based delay loop, resolution 41ns
[    0.015599] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.026635] Console: colour dummy device 80x30
[    0.031549] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.039999] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.044452] ... MAX_LOCK_DEPTH:          48
[    0.049004] ... MAX_LOCKDEP_KEYS:        8192
[    0.053774] ... CLASSHASH_SIZE:          4096
[    0.058511] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.063349] ... MAX_LOCKDEP_CHAINS:      65536
[    0.068222] ... CHAINHASH_SIZE:          32768
[    0.073054]  memory used by lock dependency info: 4061 kB
[    0.078950]  memory used for stack traces: 2112 kB
[    0.084155]  per task-struct memory footprint: 1536 bytes
[    0.090209] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.101504] pid_max: default: 32768 minimum: 301
[    0.107656] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.115669] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.127831] CPU: Testing write buffer coherency: ok
[    0.135293] /cpus/cpu@0 missing clock-frequency property
[    0.141394] /cpus/cpu@1 missing clock-frequency property
[    0.147356] /cpus/cpu@2 missing clock-frequency property
[    0.153422] /cpus/cpu@3 missing clock-frequency property
[    0.159447] /cpus/cpu@100 missing clock-frequency property
[    0.165760] /cpus/cpu@101 missing clock-frequency property
[    0.172058] /cpus/cpu@102 missing clock-frequency property
[    0.178452] /cpus/cpu@103 missing clock-frequency property
[    0.184451] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.196487] Setting up static identity map for 0x40100000 - 0x40100060
[    0.206468] ARM CCI driver probed
[    0.211477] sunxi multi cluster SMP support installed
[    0.218724] rcu: Hierarchical SRCU implementation.
[    0.229044] smp: Bringing up secondary CPUs ...
[    0.239387] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.239462] 
[    0.239468] 
[    0.239476] =============================
[    0.239479] WARNING: suspicious RCU usage
[    0.239485] 5.17.0-rc6-next-20220301-00132-gc96ac15508a4-dirty #197 Not tainted
[    0.239493] -----------------------------
[    0.239497] include/trace/events/lock.h:58 suspicious rcu_dereference_check() usage!
[    0.239505] 
[    0.239505] other info that might help us debug this:
[    0.239505] 
[    0.239509] 
[    0.239509] rcu_scheduler_active = 1, debug_locks = 1
[    0.239516] RCU used illegally from extended quiescent state!
[    0.239521] 1 lock held by swapper/0/0:
[    0.239527]  #0: c0f15b4c ((console_sem).lock){-...}-{2:2}, at: down_trylock+0xc/0x2c
[    0.239598] 
[    0.239598] stack backtrace:
[    0.239607] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc6-next-20220301-00132-gc96ac15508a4-dirty #197
[    0.239619] Hardware name: Allwinner A83t board
[    0.239629]  unwind_backtrace from show_stack+0x10/0x14
[    0.239654]  show_stack from init_stack+0x1c54/0x2000
[    0.343881] =============================
[    0.348205] WARNING: suspicious RCU usage
[    0.352529] 5.17.0-rc6-next-20220301-00132-gc96ac15508a4-dirty #197 Not tainted
[    0.360417] -----------------------------
[    0.364741] include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!
[    0.373098] 
[    0.373098] other info that might help us debug this:
[    0.373098] 
[    0.381738] 
[    0.381738] rcu_scheduler_active = 1, debug_locks = 1
[    0.388787] RCU used illegally from extended quiescent state!
[    0.394992] no locks held by swapper/0/0.
[    0.399317] 
[    0.399317] stack backtrace:
[    0.404014] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc6-next-20220301-00132-gc96ac15508a4-dirty #197
[    0.414706] Hardware name: Allwinner A83t board
[    0.419595]  unwind_backtrace from show_stack+0x10/0x14
[    0.425251]  show_stack from init_stack+0x1d5c/0x2000
