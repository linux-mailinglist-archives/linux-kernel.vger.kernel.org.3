Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB6571649
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiGLJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:57:23 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A978AA836
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:57:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 190so7339444iou.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cNAJUGKJtp9Xxs9Q5O13ajIt7zZOY8L8wnW82WBcQ48=;
        b=NZafq4q3cF/JZ/8aT1FZ2V7ucHu/y/37KXqjEuyP1gMUIx8CHUWJSJujcH068QLwve
         hkmQywT/W+Lt0O4WDY2GPA9SJ/C1Twqv85XpLwwLmZLGwPKIj2aheKfD2YutvN416R9P
         fAOVBhCesTWBkgxCKJzL6SSbTmMOn4z5uei95Fh1AvTdU52Tj6nnK1dKQsnAT9WD2kbK
         U9mmGsN+Hbfk8YkaVGKN8uDFj60fQtAYIlhMbLRN6oBTBmESCzXSWuK+7Elt4tHeteEc
         EXZ2xzQHBqjiMCC2UxQXPpKrdry3O7xqcMavADJEDn3UHhZab9N6d5koGAgxVka/QcFt
         En1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cNAJUGKJtp9Xxs9Q5O13ajIt7zZOY8L8wnW82WBcQ48=;
        b=PSDHPZhTMR3DBA6bQVcFkpHzeBgv81d/jWjgS4ZvmlpwhRa5/tvuSEbcVFUu+Lz5XP
         JIe9MrWb6L7Lct4RiJDs5JHxdLcE73Ey8RYHzNm+pKTUY6eaaUxIhcIOerQ8fM1usFjl
         n65Bf8mwmA4+aYKymdqvid5Nb/MZMnTJbZWnKRPvq6v1l674xhw2p3+0OogDH51hIbGf
         W+SBU2yK1XHOY1EDzpcuwayGlqCLdmqwAWiQXdr0cOndGfVhq8/SshSre5Bb0LnuXOwC
         6p7/E3ZeqH/wERP7krXT5BqOgoJHZ2eyeSub2xJpXS/1tMpP8JlLhtkOQSfun9bXeivW
         iNpg==
X-Gm-Message-State: AJIora8CYRzl56Ja47gOX/gK6gADcPKdj5l82lqNQ30zfP7PTDzD14Wr
        kDK8p46YYDS6GmpKx3ul2Kk4WlGBjiNygafmS78jPhJVBTNq3g==
X-Google-Smtp-Source: AGRyM1u24gHKgy47tV7rwETEJuASF/uTM9GdFRZRAooCtZJDXn1aJmGc1G01o9tzc5K+WwHaqs7mNVYe8216oIxT3Uc=
X-Received: by 2002:a05:6638:272c:b0:33f:6fe4:b76f with SMTP id
 m44-20020a056638272c00b0033f6fe4b76fmr1344444jav.284.1657619840126; Tue, 12
 Jul 2022 02:57:20 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Jul 2022 15:27:09 +0530
Message-ID: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
Subject: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal error:
 Oops - BUG: 0
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FVP boot failed with linux next 20220712.

Reported-by:  Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Boot log:
Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
[    0.000000] Linux version 5.19.0-rc6-next-20220711
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU
ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT @1657539508
[    0.000000] Machine model: FVP Base RevC
[    0.000000] earlycon: pl11 at MMIO 0x000000001c090000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at
0x0000000018000000, size 8 MiB
[    0.000000] OF: reserved mem: initialized node vram@18000000,
compatible id shared-dma-pool
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000080000000-0x00000008ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x8ff7f6b40-0x8ff7f8fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000feffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000008ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000008ffffffff]
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fd000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 30 pages/cpu s82856 r8192 d31832 u122880
[    0.000000] pcpu-alloc: s82856 r8192 d31832 u122880 alloc=30*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Branch Target Identification
[    0.000000] CPU features: detected: Address authentication (IMP DEF
algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] alternatives: patching kernel code
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1028096
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyAMA0
earlycon=pl011,0x1c090000 root=/dev/vda rw ip=dhcp debug user_debug=31
loglevel=9
[    0.000000] Unknown kernel command line parameters
\"user_debug=31\", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem
0x00000000f9000000-0x00000000fd000000] (64MB)
[    0.000000] Memory: 3947088K/4177920K available (20288K kernel
code, 4902K rwdata, 11308K rodata, 11136K init, 955K bss, 198064K
reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 65660 entries in 257 pages
[    0.000000] ------------[ ftrace bug ]------------
[    0.000000] ftrace failed to modify
[    0.000000] [<ffff800009f80030>] udpv6_init+0x8/0x74
[    0.000000]  actual:   00:00:00:00
[    0.000000] Initializing ftrace call sites
[    0.000000] ftrace record flags: 0
[    0.000000]  (0)
[    0.000000]  expected tramp: ffff80000802f3a8
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:2084
ftrace_bug+0x280/0x2b0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
5.19.0-rc6-next-20220711 #1
[    0.000000] Hardware name: FVP Base RevC (DT)
[    0.000000] pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : ftrace_bug+0x280/0x2b0
[    0.000000] lr : ftrace_bug+0x280/0x2b0
[    0.000000] sp : ffff80000a9e3d50
[    0.000000] x29: ffff80000a9e3d50 x28: 0000000000000000 x27: ffff80000a9eed28
[    0.000000] x26: 0000000000000052 x25: ffff80000a118008 x24: ffff80000aee3000
[    0.000000] x23: 00000000ffffffea x22: ffff800009befc30 x21: ffff80000a9eed28
[    0.000000] x20: ffff000800005510 x19: ffff80000a9ee000 x18: ffffffffffffffff
[    0.000000] x17: 000000000000003f x16: 0000000000000008 x15: ffff80008a9e3a47
[    0.000000] x14: 0000000000000000 x13: 3861336632303830 x12: 3030303866666666
[    0.000000] x11: 203a706d61727420 x10: ffff80000aa6a960 x9 : ffff800008121910
[    0.000000] x8 : 00000000ffffefff x7 : ffff80000aa6a960 x6 : 0000000000000000
[    0.000000] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    0.000000] x2 : 0000000000000000 x1 : ffff80000a9f9e40 x0 : 0000000000000022
[    0.000000] Call trace:
[    0.000000]  ftrace_bug+0x280/0x2b0
[    0.000000]  ftrace_process_locs+0x310/0x400
[    0.000000]  ftrace_init+0xa0/0x16c
[    0.000000]  start_kernel+0x45c/0x738
[    0.000000]  __primary_switched+0xb8/0xc0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] ftrace: allocated 257 pages with 2 groups
[    0.0#
00000] trace event string verifier disabled
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: RCU event tracing is enabled.
[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000] Trampoline variant of Tasks RCU enabled.
[    0.000000] Rude variant of Tasks RCU enabled.
[    0.000000] Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 224 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000002f100000
[    0.000000] ITS [mem 0x2f020000-0x2f03ffff]
[    0.000000] ITS@0x000000002f020000: allocated 8192 Devices
@8800f0000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000002f020000: allocated 8192 Virtual CPUs
@880200000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000002f020000: allocated 8192 Interrupt
Collections @880210000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000880220000
[    0.000000] GICv3: CPU0: using allocated LPI pending table
@0x0000000880230000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] kfence: initialized - using 2097152 bytes for 255
objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.000000] timer_sp804: timer clock not found: -517
[    0.000000] timer_sp804: arm,sp804 clock not found: -2
[    0.000000] Failed to initialize
'/bus@8000000/motherboard-bus/iofpga-bus@300000000/timer@110000': -22
[    0.000000] timer_sp804: timer clock not found: -517
[    0.000000] timer_sp804: arm,sp804 clock not found: -2
[    0.000000] Failed to initialize
'/bus@8000000/motherboard-bus/iofpga-bus@300000000/timer@120000': -22
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1ffffffffffffff
max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000009] sched_clock: 57 bits at 100MHz, resolution 10ns, wraps
every 4398046511100ns
[    0.001009] random: crng init done
[    0.002015] Console: colour dummy device 80x25
[    0.002709] Calibrating delay loop (skipped), value calculated
using timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.002949] pid_max: default: 32768 minimum: 301
[    0.003909] LSM: Security Framework initializing
[    0.004751] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    0.004915] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
[    0.012948] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.013122] Early cacheinfo failed, ret = -2
[    0.023187] cblist_init_generic: Setting adjustable number of
callback queues.
[    0.023309] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.024609] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.025809] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.028426] rcu: Hierarchical SRCU implementation.
[    0.028590] rcu: Max phase no-delay instances is 1000.
[    0.042209] Platform MSI: msi-controller@2f020000 domain created
[    0.043171] PCI/MSI:
/interrupt-controller@2f000000/msi-controller@2f020000 domain created
[    0.044359] fsl-mc MSI: msi-controller@2f020000 domain created
[    0.052019] EFI services will not be available.
[    0.057426] smp: Bringing up secondary CPUs ...
[    0.064109] Detected PIPT I-cache on CPU1
[    0.064230] GICv3: CPU1: found redistributor 100 region 0:0x000000002f120000
[    0.064316] GICv3: CPU1: using allocated LPI pending table
@0x0000000880240000
[    0.064509] CPU1: Booted secondary processor 0x0000000100 [0x410fd0f0]
[    0.072609] Detected PIPT I-cache on CPU2
[    0.072809] GICv3: CPU2: found redistributor 200 region 0:0x000000002f140000
[    0.072809] GICv3: CPU2: using allocated LPI pending table
@0x0000000880250000
[    0.073009] CPU2: Booted secondary processor 0x0000000200 [0x410fd0f0]
[    0.081109] Detected PIPT I-cache on CPU3
[    0.081209] GICv3: CPU3: found redistributor 300 region 0:0x000000002f160000
[    0.081346] GICv3: CPU3: using allocated LPI pending table
@0x0000000880260000
[    0.081510] CPU3: Booted secondary processor 0x0000000300 [0x410fd0f0]
[    0.089809] Detected PIPT I-cache on CPU4
[    0.090009] GICv3: CPU4: found redistributor 10000 region
0:0x000000002f180000
[    0.090030] GICv3: CPU4: using allocated LPI pending table
@0x0000000880270000
[    0.090261] CPU4: Booted secondary processor 0x0000010000 [0x410fd0f0]
[    0.098509] Detected PIPT I-cache on CPU5
[    0.098678] GICv3: CPU5: found redistributor 10100 region
0:0x000000002f1a0000
[    0.098713] GICv3: CPU5: using allocated LPI pending table
@0x0000000880280000
[    0.098909] CPU5: Booted secondary processor 0x0000010100 [0x410fd0f0]
[    0.107010] Detected PIPT I-cache on CPU6
[    0.107233] GICv3: CPU6: found redistributor 10200 region
0:0x000000002f1c0000
[    0.107315] GICv3: CPU6: using allocated LPI pending table
@0x0000000880290000
[    0.107441] CPU6: Booted secondary processor 0x0000010200 [0x410fd0f0]
[    0.115909] Detected PIPT I-cache on CPU7
[    0.116119] GICv3: CPU7: found redistributor 10300 region
0:0x000000002f1e0000
[    0.116119] GICv3: CPU7: using allocated LPI pending table
@0x00000008802a0000
[    0.116326] CPU7: Booted secondary processor 0x0000010300 [0x410fd0f0]
[    0.117909] smp: Brought up 1 node, 8 CPUs
[    0.119709] SMP: Total of 8 processors activated.
[    0.119909] CPU features: detected: 32-bit EL0 Support
[    0.120023] CPU features: detected: 32-bit EL1 Support
[    0.120176] CPU features: detected: ARMv8.4 Translation Table Level
[    0.120326] CPU features: detected: Data cache clean to the PoU not
required for I/D coherence
[    0.120457] CPU features: detected: Common not Private translations
[    0.120609] CPU features: detected: CRC32 instructions
[    0.120717] CPU features: detected: E0PD
[    0.120832] CPU features: detected: Enhanced Counter Virtualization
[    0.121009] CPU features: detected: Generic authentication (IMP DEF
algorithm)
[    0.121151] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.121323] CPU features: detected: LSE atomic instructions
[    0.121809] CPU features: detected: Privileged Access Never
[    0.121932] CPU features: detected: RAS Extension Support
[    0.122060] CPU features: detected: Random Number Generator
[    0.122209] CPU features: detected: Speculation barrier (SB)
[    0.122309] CPU features: detected: Stage-2 Force Write-Back
[    0.122470] CPU features: detected: TLB range maintenance instructions
[    0.122634] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.122716] CPU features: detected: Scalable Vector Extension
[    0.413916] SVE: maximum available vector length 64 bytes per vector
[    0.414109] SVE: default vector length 64 bytes per vector
[    0.430509] CPU features: No Cache Writeback Granule information,
assuming 128
[    0.430655] CPU: All CPU(s) started at EL2
[    0.449009] devtmpfs: initialized
[    0.476391] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.476610] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.484509] pinctrl core: initialized pinctrl subsystem
[    0.499875] DMI not present or invalid.
[    0.500613] ------------[ cut here ]------------
[    0.500709] kernel BUG at arch/arm64/kernel/traps.c:497!
[    0.500777] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    0.500860] Modules linked in:
[    0.500947] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
   5.19.0-rc6-next-20220711 #1
[    0.501034] Hardware name: FVP Base RevC (DT)
[    0.501109] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.501209] pc : do_undefinstr+0x284/0x2b4
[    0.501381] lr : do_undefinstr+0x150/0x2b4
[    0.501509] sp : ffff80000affbbc0
[    0.501509] x29: ffff80000affbbc0 x28: ffff000800330000 x27: ffff800009f00444
[    0.501759] x26: ffff800009fe6038 x25: 0000000000000001 x24: ffff80000a115968
[    0.501923] x23: 0000000040400009 x22: ffff800009f80de0 x21: ffff80000affbd90
[    0.502109] x20: 0000000001000000 x19: ffff80000affbc40 x18: ffffffffffffffff
[    0.502309] x17: 000000000000003f x16: 000000000000000a x15: ffff0008002b1a1c
[    0.502422] x14: ffffffffffffffff x13: ffff0008002b1268 x12: 20726f20746e6573
[    0.502683] x11: ffff80000aa12950 x10: 0000000000000073 x9 : ffff8000093bcd6c
[    0.502856] x8 : 000000003d4d554e x7 : ffff80000affbce0 x6 : 0000000000000001
[    0.503030] x5 : ffff80000a9ef000 x4 : ffff80000a9ef2e0 x3 : 0000000000000000
[    0.503234] x2 : ffff000800330000 x1 : ffff000800330000 x0 : 0000000040400009
[    0.503409] Call trace:
[    0.503480]  do_undefinstr+0x284/0x2b4
[    0.503562]  el1_undef+0x30/0x60
[    0.503709]  el1h_64_sync_handler+0x84/0xd0
[    0.503811]  el1h_64_sync+0x64/0x68
[    0.503909]  net_sysctl_init+0x8/0x7c
[    0.504053]  do_one_initcall+0x50/0x2b0
[    0.504158]  kernel_init_freeable+0x24c/0x2d4
[    0.504245]  kernel_init+0x30/0x140
[    0.504381]  ret_from_fork+0x10/0x20
[    0.504509] Code: 17ffff98 a9425bf5 17ffffbb a9025bf5 (d4210000)
[    0.504627] ---[ end trace 0000000000000000 ]---
[    0.504678] note: sw#
apper/0[1] exited with preempt_count 1
[    0.504852] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    0.504939] SMP: stopping secondary CPUs
[    0.505209] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

Build:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220711/testrun/10743317/suite/log-parser-test/tests/

https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/

Best regards
Naresh Kamboju


--
Linaro LKFT
https://lkft.linaro.org
