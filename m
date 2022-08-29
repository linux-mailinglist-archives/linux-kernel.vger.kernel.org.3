Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4203C5A4176
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiH2D2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2D2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:28:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795AE3FA1C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:28:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id jm11so6703456plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=UhyggaG7taAFDPw7xBAluEG3IsgQZUaAOmAYEemxwEQ=;
        b=Shm2/M816Hf9W5O/Nv1enL7FuCKNYkXj2n2IpVAsYmXjoqCbzCSHr0fhQk1EsTD6ab
         lbstbdi0W0vkBXBLBXDuTZy5LL5jJfrQXCDxqJSv9VWJchtqq664cR6iGYJ0IUh9aC1C
         rcN3fdF7olf2XlCUrUIj8wa90afi9QNYVdcCr5af50xQIez9XUzagDYelA6fuisKdwUR
         f8RzJ38Sifn1udVP990IAJbYSKKSQbCbNFQu5ddT5knbvGP13djltW44hn5Cq4zkhZ1M
         +sg0oGccl0egX9BdmRSIgfp/6apZIIlD/Dafzqs0U7B41ZKzgfPAyvNInxiYTHlTrbaN
         d6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=UhyggaG7taAFDPw7xBAluEG3IsgQZUaAOmAYEemxwEQ=;
        b=y9W7Qs916um4S9Y4DCRj8uhkkJnzRzvhTJ20CpPfsTnV1bYXcvyQ+gWqOuh2siSf+F
         KAWJXSjx3az0zktTR22pFNjhqE2AOre+n8dvbhpCnJmosN6YcYDoiBPFgf7SKV8q6C46
         3CBE9QUewQK4VaKFoCCEEEMzAMdG/XbcUJko33g2xMdw8z22xwLsA5xlRwLAf391PBfg
         gHXkhAvYyWzzzEokx4Q91jC3kl3stLN3MA1UMjD6Zusfl/m68I0oUdZx91O3NUAZBir7
         OwRtoJeKAsnz7zG+SO+6vq9YOL/v6CANuNfGBRUuY8B75j3GswMDHO4/gR4fOxOgFzfm
         V+Rg==
X-Gm-Message-State: ACgBeo0/MomaHk5rxk3+YZEM9LHcZ24jfD0PW/519/oShAitMNCDddAG
        w9Gwg6fkyZ+/7XC7qOmkMM9Mh31RTQXjPQ==
X-Google-Smtp-Source: AA6agR5ONlZKm2n1KpP/6FImmlsTy8fPdajwquuGgarpMe/5C7g0JyJdK73wkh3/XwH+QtXXxnh6pQ==
X-Received: by 2002:a17:90b:1a88:b0:1fd:6a42:3eb9 with SMTP id ng8-20020a17090b1a8800b001fd6a423eb9mr14364108pjb.154.1661743696915;
        Sun, 28 Aug 2022 20:28:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r19-20020a63a553000000b00429ffc18e5csm5183522pgu.59.2022.08.28.20.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 20:28:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 28 Aug 2022 20:28:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.0-rc3
Message-ID: <20220829032814.GA3188398@roeck-us.net>
References: <CAHk-=whaiqzB6a_daUpvGyDg-cvkXKwwfjwPKV4HQRcci+8BeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whaiqzB6a_daUpvGyDg-cvkXKwwfjwPKV4HQRcci+8BeA@mail.gmail.com>
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

On Sun, Aug 28, 2022 at 03:34:55PM -0700, Linus Torvalds wrote:
> So as some people already noticed, last week was an anniversary week -
> 31 years since the original Linux development announcement. How time
> flies.
> 
> But this is not that kind of historic email - it's just the regular
> weekly RC release announcement, and things look pretty normal. We've
> got various fixes all over the tree, in all the usual places: drivers
> (networking, fbdev, drm), architectures (a bit of everythinig: x86,
> loongarch, arm64, parisc, s390 and RISC-V), filesystems (mostly btrfs
> and cifs, minor things elsewhere), and core kernel code (networking,
> vm, vfs and cgroup).
> 
> And some tooling support (perf and selftests).
> 
> We've got a few known issues brewing, but nothing that looks all that
> scary. Knock wood.
> 
> Please give it a go,
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 489 pass: 463 fail: 26
Failed tests:
	<various arm>
	mcf5208evb:m5208:m5208evb_defconfig:initrd

===========
Crashes:

Various arm boot test crash in pl011_probe() due to commit f2d3b9a46e0e
("ARM: 9220/1: amba: Remove deferred device addition").

The fix is at
https://lore.kernel.org/all/20220819112832.GA3106213@roeck-us.net/T/

--------

Various imx emulations hang in scsi_remove_host() during reboot. 
Bisect points to the patch series at
https://lore.kernel.org/all/20220712221936.1199196-1-bvanassche@acm.org/

---------
Crash in qemu's m68k:mcf5208evb emulation.

*** ILLEGAL INSTRUCTION ***   FORMAT=4
Current process id is 1
BAD KERNEL TRAP: 00000000
PC: [<00000000>] 0x0
SR: 2714  SP: (ptrval)  a2: 40829634
d0: 00002710    d1: 00002010    d2: 40829442    d3: 00002010
d4: 00000000    d5: 402e818a    a0: 00000000    a1: 40824000
Process swapper (pid: 1, task=(ptrval))
Frame format=4 eff addr=400681c2 pc=00000000
Stack from 40831cec:
        40829442 00002010 40831e0c 402e818a 40b9e000 00000008 408295a4 40829000
        401b0cea 40829634 40829420 00000000 40829420 40829000 00000200 401dcd1a
        40884a50 401b13b6 408295a4 40829702 40347ee0 401ad0ce 40829420 40347eea
        00000000 40831e0c 402e818a 40b9e000 00000008 40347ee0 40829000 fffffff8
        4082945a 40829000 408294c7 00000002 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
 [<401b0cea>] fec_ptp_gettime+0x3a/0x8c
 [<401dcd1a>] __alloc_skb+0xb0/0x24c
 [<401b13b6>] fec_ptp_save_state+0x12/0x3e
 [<401ad0ce>] fec_restart+0x5a/0x770
 [<401ae2fe>] fec_probe+0x74a/0xd06
 [<402c1144>] strcpy+0x0/0x18
 [<402d3a1c>] mutex_unlock+0x0/0x40
 [<402d39dc>] mutex_lock+0x0/0x40
 [<401840b9>] uart_carrier_raised+0x45/0xe6
 [<4019391e>] platform_probe+0x22/0x60
...

Bisect points to commit f79959220fa5fbd ("fec: Restart PPS after link state
change"). Reverting this commit fixes the problem. Also see below for
warnings caused by this commit.

---------
Warnings:

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

---
Various arm emulations report the following warning. Just like the m68k
crash, the problem is caused by commit f79959220fa5fbd ("fec: Restart PPS
after link state change"), and reverting it fixes the problem. Reported at
https://lore.kernel.org/netdev/20220827160922.642zlcd5foopozru@pengutronix.de/

[   32.433987] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
[   32.434757] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5, name: kworker/0:0
[   32.435779] preempt_count: 201, expected: 0
[   32.436125] 4 locks held by kworker/0:0/5:
[   32.436375]  #0: c40132a8 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1a0/0x6fc
[   32.437459]  #1: d0845f28 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}, at: process_one_work+0x1a0/0x6fc
[   32.438129]  #2: c45dcc78 (&dev->lock){+.+.}-{3:3}, at: phy_state_machine+0x12c/0x260
[   32.438675]  #3: cbc002a4 (&dev->tx_global_lock){+...}-{2:2}, at: netif_tx_lock+0x10/0x1c
[   32.444232] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G                 N 6.0.0-rc3 #1
[   32.444747] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   32.451684] Workqueue: events_power_efficient phy_state_machine
[   32.452395]  unwind_backtrace from show_stack+0x10/0x14
[   32.452769]  show_stack from dump_stack_lvl+0x68/0x90
[   32.453081]  dump_stack_lvl from __might_resched+0x17c/0x284
[   32.453415]  __might_resched from __mutex_lock+0x38/0x93c
[   32.453730]  __mutex_lock from mutex_lock_nested+0x1c/0x24
[   32.454011]  mutex_lock_nested from fec_ptp_gettime+0x30/0xc8
[   32.454324]  fec_ptp_gettime from fec_ptp_save_state+0x14/0x50
[   32.454650]  fec_ptp_save_state from fec_restart+0x44/0x8b8
[   32.454955]  fec_restart from fec_enet_adjust_link+0xa8/0x184
[   32.455285]  fec_enet_adjust_link from phy_link_change+0x28/0x54
[   32.455623]  phy_link_change from phy_check_link_status+0x94/0x108
[   32.455962]  phy_check_link_status from phy_state_machine+0x134/0x260
[   32.456297]  phy_state_machine from process_one_work+0x240/0x6fc
[   32.456629]  process_one_work from worker_thread+0x2c/0x480
[   32.456947]  worker_thread from kthread+0xec/0x110
[   32.457230]  kthread from ret_from_fork+0x14/0x28
[   32.457621] Exception stack(0xd0845fb0 to 0xd0845ff8)
[   32.458027] 5fa0:                                     00000000 00000000 00000000 00000000
[   32.458442] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   32.458827] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   32.471787]
[   32.472032] =============================
[   32.472218] [ BUG: Invalid wait context ]
[   32.472439] 6.0.0-rc3 #1 Tainted: G        W        N
[   32.472678] -----------------------------
[   32.472867] kworker/0:0/5 is trying to lock:
[   32.473063] cbc0071c (&fep->ptp_clk_mutex){+.+.}-{3:3}, at: fec_ptp_gettime+0x30/0xc8
[   32.473518] other info that might help us debug this:
[   32.473762] context-{4:4}
[   32.473900] 4 locks held by kworker/0:0/5:
[   32.474083]  #0: c40132a8 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1a0/0x6fc
[   32.474557]  #1: d0845f28 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}, at: process_one_work+0x1a0/0x6fc
[   32.478974]  #2: c45dcc78 (&dev->lock){+.+.}-{3:3}, at: phy_state_machine+0x12c/0x260
[   32.479476]  #3: cbc002a4 (&dev->tx_global_lock){+...}-{2:2}, at: netif_tx_lock+0x10/0x1c
[   32.479937] stack backtrace:
[   32.480090] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        W        N 6.0.0-rc3 #1
[   32.480377] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   32.480648] Workqueue: events_power_efficient phy_state_machine
[   32.480924]  unwind_backtrace from show_stack+0x10/0x14
[   32.481157]  show_stack from dump_stack_lvl+0x68/0x90
[   32.481397]  dump_stack_lvl from __lock_acquire+0x82c/0x28b8
[   32.481645]  __lock_acquire from lock_acquire.part.0+0xc0/0x26c
[   32.481897]  lock_acquire.part.0 from __mutex_lock+0x94/0x93c
[   32.482138]  __mutex_lock from mutex_lock_nested+0x1c/0x24
[   32.482372]  mutex_lock_nested from fec_ptp_gettime+0x30/0xc8
[   32.482638]  fec_ptp_gettime from fec_ptp_save_state+0x14/0x50
[   32.482873]  fec_ptp_save_state from fec_restart+0x44/0x8b8
[   32.483115]  fec_restart from fec_enet_adjust_link+0xa8/0x184
[   32.483363]  fec_enet_adjust_link from phy_link_change+0x28/0x54

