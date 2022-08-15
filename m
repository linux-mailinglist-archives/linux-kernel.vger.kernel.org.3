Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14EA594F02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 05:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiHPDSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 23:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiHPDST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 23:18:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BFA2F8B09
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:48:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x10so7725276plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=9QTKQd998GxMAmy+1mFtmlvmJVz0Pfh0SE8X2Lm8eEU=;
        b=D/fRGw2RAsz7u0TYFa5gJ3SEXFNDOSuGX1fBNbuLqMnJIGTNPmRyJ+AYdDH1DmtmJj
         xNRI5qcFeSG4DBDpKFBQtYzdONfaCISsXo5Rry6xZ9KELiPFDl9xbIsLQRsh0upPp/Py
         cGN2ADTIad/ROXQERyKZCwzaR9ui+Xhregszc1TIvmb6SxlDJRaW3HAnXlnqFketa64i
         4DrjJMZMpyZtwQBLu/+/tp1Bbnu/fxmkQ9glpNXuPafhq+Yqtq2TiPYV7nmusL8BXNTd
         59Wh2A1yrHeut5DQgWWbgQdvXYnKBFQAefDAFtp9BSej4rdZpnUm2x12ovRgC7odWyaD
         TFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=9QTKQd998GxMAmy+1mFtmlvmJVz0Pfh0SE8X2Lm8eEU=;
        b=kKDggBxOi8r19zy8jeJ1gfJ4Wlz+JrbgCKu26DnBnRT0rS6V1AOZ65E5cd0Yw21vO5
         wqkopIqQvKqXX1JEzTh+9+p88UtVZuB1jafNXHavFqEhG6/BlV+AEmK3WrRy1j0bzEtD
         heVQym4gHtUthsdzg8qE//PaFql0T+66EiWaSzLjXio7tkckBWOIaUjte8D/5wxZMPp5
         77t0Ag2Kh8glomFM6GVeB1GNuhxfQfIvyHAjU6jrxRk/zyLOTzyfASGqRG5YN8YiWVm1
         euBJ2bsQw0xscnAH2yX7Ofiu3xKBgFbX9/WPcmjGlTeC52/F5B0AQi6ZotG1BPtyjr3O
         zC1g==
X-Gm-Message-State: ACgBeo09kNpdFvDWTKPvPWoC1I1TGmUTSAmfjV53XWIpfbUyROPQt4cx
        Mgdmb5H2YM7/4jTGMlFsfBPyMEhScGc=
X-Google-Smtp-Source: AA6agR5WGE+ZhoRVbDkAwFPDohEDzVJbXoUDpqcnPQXD00Rt9cZUATTgBEqls2yWj0ayuNS/KVcOFQ==
X-Received: by 2002:a17:90b:1d8e:b0:1f5:525d:4d90 with SMTP id pf14-20020a17090b1d8e00b001f5525d4d90mr29711735pjb.126.1660607322433;
        Mon, 15 Aug 2022 16:48:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w19-20020aa79553000000b0052516db7123sm7040112pfq.35.2022.08.15.16.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:48:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Aug 2022 16:48:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.0-rc1
Message-ID: <20220815234840.GA654054@roeck-us.net>
References: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 04:41:33PM -0700, Linus Torvalds wrote:
> So here we are, two weeks later, and the merge window has closed.
> 
[ ... ]
> 
> But whatever you call it, please help test this, so that we can get it
> all in shape for the final release (hopefully early October).
> 

Build results:
	total: 149 pass: 147 fail: 2
Failed builds:
	powerpc:allmodconfig
	powerpc:ppc32_allmodconfig
Qemu test results:
	total: 483 pass: 458 fail: 25
Failed tests:
	<various arm>

Details below.

Guenter

---
Build:

powerpc:allmodconfig
powerpc:ppc32_allmodconfig

include/linux/random.h: In function 'add_latent_entropy':
include/linux/random.h:25:46: error: 'latent_entropy' undeclared

Caused by commit 36d4b36b6959 ("lib/nodemask: inline next_node_in() and
node_random()"). Fix is at:

https://www.spinics.net/lists/kernel/msg4468633.html

===========
qemu tests:

Crashes:

Various crashes in pl011_probe() due to commit f2d3b9a46e0e ("ARM: 9220/1:
amba: Remove deferred device addition"). The suggested fix is at
https://lore.kernel.org/lkml/20220811190747.797081-1-isaacmanjarres@google.com/T/
and mostly works but exposes or introduces another crash. The suggested fix for
that crash introduces yet another crash. See
https://lore.kernel.org/lkml/20220811195234.GA4018948@roeck-us.net/T/#m2192446c13d46612a00c4d499da7896d692db75c
for details.

Note: I just saw v2 of the proposed fix. I'll need to retest. 

--------

Warnings:

Seen in various ppc boot tests:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by swapper/1:
 #0: c157efb0 (hose_spinlock){+.+.}-{2:2}, at: pcibios_alloc_controller+0x64/0x220
Preemption disabled at:
[<00000000>] 0x0
CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0-yocto-standard+ #1
Call Trace:
[d101dc90] [c073b264] dump_stack_lvl+0x50/0x8c (unreliable)
[d101dcb0] [c0093b70] __might_resched+0x258/0x2a8
[d101dcd0] [c0d3e634] __mutex_lock+0x6c/0x6ec
[d101dd50] [c0a84174] of_alias_get_id+0x50/0xf4
[d101dd80] [c002ec78] pcibios_alloc_controller+0x1b8/0x220
[d101ddd0] [c140c9dc] pmac_pci_init+0x198/0x784
[d101de50] [c140852c] discover_phbs+0x30/0x4c
[d101de60] [c0007fd4] do_one_initcall+0x94/0x344
[d101ded0] [c1403b40] kernel_init_freeable+0x1a8/0x22c
[d101df10] [c00086e0] kernel_init+0x34/0x160
[d101df30] [c001b334] ret_from_kernel_thread+0x5c/0x64

=============================
[ BUG: Invalid wait context ]
5.19.0-yocto-standard+ #1 Tainted: G        W
-----------------------------
swapper/1 is trying to lock:
c16a9dd8 (of_mutex){+.+.}-{3:3}, at: of_alias_get_id+0x50/0xf4
other info that might help us debug this:
context-{4:4}
1 lock held by swapper/1:
 #0: c157efb0 (hose_spinlock){+.+.}-{2:2}, at: pcibios_alloc_controller+0x64/0x220
stack backtrace:
CPU: 0 PID: 1 Comm: swapper Tainted: G        W          5.19.0-yocto-standard+ #1
Call Trace:
[d101dbc0] [c073b264] dump_stack_lvl+0x50/0x8c (unreliable)
[d101dbe0] [c00bb8e8] __lock_acquire+0x8c4/0x2278
[d101dc60] [c00ba4b8] lock_acquire+0x148/0x3b4
[d101dcd0] [c0d3e688] __mutex_lock+0xc0/0x6ec
[d101dd50] [c0a84174] of_alias_get_id+0x50/0xf4
[d101dd80] [c002ec78] pcibios_alloc_controller+0x1b8/0x220
[d101ddd0] [c140c9dc] pmac_pci_init+0x198/0x784
[d101de50] [c140852c] discover_phbs+0x30/0x4c
[d101de60] [c0007fd4] do_one_initcall+0x94/0x344
[d101ded0] [c1403b40] kernel_init_freeable+0x1a8/0x22c
[d101df10] [c00086e0] kernel_init+0x34/0x160
[d101df30] [c001b334] ret_from_kernel_thread+0x5c/0x64

Bisect points to commit 0fe1e96fef0a ("powerpc/pci: Prefer PCI domain
assignment via DT 'linux,pci-domain' and alias").

Fix is at:

https://lore.kernel.org/all/20220815065550.1303620-1-mpe@ellerman.id.au/

---
riscv32/riscv64:

[   15.272080] DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
[   15.272421] WARNING: CPU: 0 PID: 140 at kernel/locking/lockdep.c:5510 check_flags+0xe2/0x1c2
[   15.272813] Modules linked in:
[   15.273132] CPU: 0 PID: 140 Comm: S01syslogd Tainted: G                 N 5.19.0-14184-g69dac8e431af #1
[   15.273428] Hardware name: riscv-virtio,qemu (DT)
[   15.273701] epc : check_flags+0xe2/0x1c2
[   15.273893]  ra : check_flags+0xe2/0x1c2
[   15.274040] epc : ffffffff80a8ea50 ra : ffffffff80a8ea50 sp : ff200000107cbcb0
[   15.274228]  gp : ffffffff819fec50 tp : ff6000000494d640 t0 : ffffffff81833628
[   15.274416]  t1 : 0000000000000001 t2 : 2d2d2d2d2d2d2d2d s0 : ff200000107cbcd0
[   15.274608]  s1 : ffffffff81a00130 a0 : 0000000000000030 a1 : ffffffff818925e8
[   15.274801]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
[   15.274997]  a5 : 0000000000000000 a6 : ffffffff80066d80 a7 : 0000000000000038
[   15.275179]  s2 : ffffffff81a024e0 s3 : ffffffff818935b0 s4 : ff200000107cbe28
[   15.275365]  s5 : ffffffff80e27708 s6 : 0000000200000022 s7 : ffffffffffffffff
[   15.275558]  s8 : ffffffff8249da18 s9 : 0000000000001000 s10: 0000000000000001
[   15.275745]  s11: 0000000000000001 t3 : ffffffff824740af t4 : ffffffff824740af
[   15.275926]  t5 : ffffffff824740b0 t6 : ff200000107cbaa8
[   15.276079] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[   15.276355] [<ffffffff80a8eba8>] lock_is_held_type+0x78/0x14a
[   15.276565] [<ffffffff8003d648>] __might_resched+0x26/0x232
[   15.276717] [<ffffffff8003d892>] __might_sleep+0x3e/0x66
[   15.276861] [<ffffffff8002262c>] get_signal+0xa6/0x8f6
[   15.277007] [<ffffffff800051da>] do_notify_resume+0x68/0x418
[   15.277160] [<ffffffff80003af4>] ret_from_exception+0x0/0x10
[   15.277365] irq event stamp: 2974
[   15.277474] hardirqs last  enabled at (2973): [<ffffffff80a9761c>] _raw_spin_unlock_irqrestore+0x54/0x62
[   15.277705] hardirqs last disabled at (2974): [<ffffffff8000812c>] __trace_hardirqs_off+0xc/0x14
[   15.277933] softirqs last  enabled at (1650): [<ffffffff80a98092>] __do_softirq+0x3e2/0x51c
[   15.278168] softirqs last disabled at (1633): [<ffffffff80016fc8>] __irq_exit_rcu+0xb4/0xdc
[   15.278399] ---[ end trace 0000000000000000 ]---
[   15.278699] possible reason: unannotated irqs-on.
[   15.278838] irq event stamp: 2974
[   15.278929] hardirqs last  enabled at (2973): [<ffffffff80a9761c>] _raw_spin_unlock_irqrestore+0x54/0x62
[   15.279141] hardirqs last disabled at (2974): [<ffffffff8000812c>] __trace_hardirqs_off+0xc/0x14
[   15.279339] softirqs last  enabled at (1650): [<ffffffff80a98092>] __do_softirq+0x3e2/0x51c
[   15.279534] softirqs last disabled at (1633): [<ffffffff80016fc8>] __irq_exit_rcu+0xb4/0xdc

Caused or exposed by commit ba6cfef057e1 ("riscv: enable Docker requirements
in defconfig").
