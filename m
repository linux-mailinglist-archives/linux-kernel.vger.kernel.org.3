Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08C25352DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbiEZRsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiEZRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:48:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C6A30A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:48:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x2so4049050ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=41pQ1z2N3sdHubFp6I3X9LkIXWQ/02A6bm3jVE79bjc=;
        b=fIS/gyPKd4Xp+zh4AXv82jRT3K54JLANdM0RD8+BA9qQy9+jS7ChEmcH19cX4O1GEO
         x94EtoYdFETjzEVH/7ZVGQf86JIosktgb2kA/KKhQcpss+kkIVW4DtdmvMWR3rTa8RQy
         lL+7jttOyM9jMny2lYAeIvE7FvFKETL1ZklQfM9cbylwRa/ZfOHgTE8dqgebxBAZ45M4
         aSUjUYnz8zJoE070lDpL2H+CtVgVzKQQEh+4mhF5geKYprqs2Fg5ly0e7Zgxe9rKgfVg
         uNb/Aed/afa/730nDXBWvudiB5ShzHGGsjVy50v3x2/X3f9TDnUSmfp04yrKfKK0BVKc
         XVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=41pQ1z2N3sdHubFp6I3X9LkIXWQ/02A6bm3jVE79bjc=;
        b=H8lhZps9G+notioxOEaIezAcqPzGLXV5pK8g6J1Izh/HyKSjutQsaePtkn6O8EWPoX
         lF6rebKL+UDE47S+q8as3UMsyiashYz1WDnSmX7oViZ6g6X6t6df3DKcwm/Ckfxr4C8x
         FaDCbPsz01Co9FC8v7r0gBAFcEyk4CrHzBjIByPnKnxCDsasfo0+XvTa1P0D3xmDY0xP
         VEnGWqH2bY9/VBYdzayDSU9xBMfkI/EC+MNyvRAY8kPlbTS0izLRDpWtruvqRJSRLT7W
         H5/Vhin4OwMDHw3wlAwE2JQHazuUHzb9AP8b6gq8GIEiB+jOOiLLsp+3pDosmxW1zV2P
         61YQ==
X-Gm-Message-State: AOAM5318koJjXKcO5btgRqFUJd5vb2Qg7FuWV3/EghFmh/z8JySoAAm9
        Sdieaqqx35PamUdEKq4WjMGVQEP35RzMyWE1JCwsoflq1nXYfQ==
X-Google-Smtp-Source: ABdhPJzSFsR9UBiaZD5jljWn450FQFGj0T3SXdQdIPQ+sjQz1408umAd5iGVQiYvYztfiAIprWdux1pcwJ0Oc+LfSwE=
X-Received: by 2002:a25:bb83:0:b0:653:ede9:90ae with SMTP id
 y3-20020a25bb83000000b00653ede990aemr12384095ybg.474.1653587293634; Thu, 26
 May 2022 10:48:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 26 May 2022 23:18:02 +0530
Message-ID: <CA+G9fYtNLnFs-RWeSkLDq9imwout7px4O13OqAgGxK1O6fGEBA@mail.gmail.com>
Subject: Internal error: Oops: 5 [#1] SMP ARM: PC is at l3_interrupt_handler+0x148/0x528
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        regressions@lists.linux.dev
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        mathias.nyman@linux.intel.com, Praneeth Bajjuri <praneeth@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, mani@kernel.org,
        Alex Elder <elder@linaro.org>,
        Tony Lindgren <tony@atomide.com>, bbhatt@codeaurora.org,
        Lee Jones <lee.jones@linaro.org>
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

[Please ignore this email if it is already reported]

The kernel crash reported on the architecture arm BeagleBoard-X15 device
running Linux next-20220526 while booting the device.
The kernel warning followed by kernel panic was noticed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


[    0.000000] Linux version 5.18.0-next-20220526 (tuxmake@tuxmake)
(arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld
(GNU Binutils for Debian) 2.35.2) #1 SMP @1653551131
[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: TI AM5728 BeagleBoard-X15
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created CMA memory pool at 0x95800000,
size 56 MiB
[    0.000000] OF: reserved mem: initialized node
ipu2-memory@95800000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x99000000,
size 64 MiB
[    0.000000] OF: reserved mem: initialized node
dsp1-memory@99000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x9d000000,
size 32 MiB
[    0.000000] OF: reserved mem: initialized node
ipu1-memory@9d000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x9f000000,
size 8 MiB
[    0.000000] OF: reserved mem: initialized node
dsp2-memory@9f000000, compatible id shared-dma-pool
[    0.000000] cma: Reserved 64 MiB at 0xfb800000
[    0.000000] OMAP4: Map 0xafe00000 to (ptrval) for dram barrier
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000afdfffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x00000000afe00000-0x00000000ffffefff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000afdfffff]
[    0.000000]   node   0: [mem 0x00000000b0000000-0x00000000ffffefff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffefff]
[    0.000000] On node 0, zone HighMem: 512 pages in unavailable ranges
[    0.000000] kasan: Mapping kernel virtual memory block:
c0000000-efe00000 at shadow: b7000000-bcfc0000
[    0.000000] kasan: Skip highmem block at 0xb0000000-0xffffffff
[    0.000000] kasan: Mapping kernel virtual memory block:
bf000000-c0000000 at shadow: b6e00000-b7000000
[    0.000000] kasan: Kernel address sanitizer initialized
[    0.000000] DRA752 ES2.0
[    0.000000] percpu: Embedded 12 pages/cpu s18388 r8192 d22572 u49152
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522051
[    0.000000] Kernel command line: console=ttyS2,115200n8
root=PARTUUID=e8908a07-cb0f-c342-96ac-dfcc3076e310 rw rootfstype=ext4
rootwait
[    0.000000] Dentry cache hash table entries: 131072 (order: 7,
524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Stack Depot early init allocating hash table with
memblock_alloc, 4194304 bytes
[    0.000000] Memory: 1686992K/2095100K available (22528K kernel
code, 9219K rwdata, 16504K rodata, 2048K init, 850K bss, 178732K
reserved, 229376K cma-reserved, 1245180K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: RCU event tracing is enabled.
[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=2.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] kfence: initialized - using 2097152 bytes for 255
objects at 0x(ptrval)-0x(ptrval)
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at lib/refcount.c:25 kobject_get+0xbc/0xc4
[    0.000000] refcount_t: addition on 0; use-after-free.
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-next-20220526 #1
[    0.000000] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.000000]  unwind_backtrace from show_stack+0x10/0x14
[    0.000000]  show_stack from dump_stack_lvl+0x40/0x4c
[    0.000000]  dump_stack_lvl from __warn+0x104/0x13c
[    0.000000]  __warn from warn_slowpath_fmt+0xdc/0x114
[    0.000000]  warn_slowpath_fmt from kobject_get+0xbc/0xc4
[    0.000000]  kobject_get from of_node_get+0x14/0x1c
[    0.000000]  of_node_get from of_fwnode_get+0x34/0x4c
[    0.000000]  of_fwnode_get from fwnode_full_name_string+0x34/0xa0
[    0.000000]  fwnode_full_name_string from device_node_string+0x74c/0x81c
[    0.000000]  device_node_string from pointer+0x504/0x828
[    0.000000]  pointer from vsnprintf+0x38c/0x6bc
[    0.000000]  vsnprintf from vprintk_store+0x1e0/0x510
[    0.000000]  vprintk_store from vprintk_emit+0x68/0x2cc
[    0.000000]  vprintk_emit from vprintk_default+0x20/0x28
[    0.000000]  vprintk_default from _printk+0x78/0xa8
[    0.000000]  _printk from of_node_release+0x17c/0x190
[    0.000000]  of_node_release from kobject_put+0x134/0x324
[    0.000000]  kobject_put from ti_dt_clocks_register+0x33c/0x42c
[    0.000000]  ti_dt_clocks_register from dra7xx_dt_clk_init+0x10/0xf8
[    0.000000]  dra7xx_dt_clk_init from omap5_realtime_timer_init+0x8/0x20c
[    0.000000]  omap5_realtime_timer_init from start_kernel+0x1b0/0x360
[    0.000000]  start_kernel from 0x0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] ------------[ cut here ]------------

<trim>

[    7.601226] mmc1 bounce up to 128 segments into one, max segment
size 65536 bytes
[    7.683502] mmc1: SDHCI controller on 480b4000.mmc [480b4000.mmc] using DMA
[    7.718688] 8<--- cut here ---
[    7.721771] Unable to handle kernel paging request at virtual
address f880350c
[    7.729034] [f880350c] *pgd=00000000
[    7.732666] Internal error: Oops: 5 [#1] SMP ARM
[    7.737304] Modules linked in:
[    7.740417] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
  5.18.0-next-20220526 #1
[    7.748992] Hardware name: Generic DRA74X (Flattened Device Tree)
[    7.755126] PC is at l3_interrupt_handler+0x148/0x528
[    7.760253] LR is at l3_interrupt_handler+0x13c/0x528
[    7.765350] pc : [<c09e97a8>]    lr : [<c09e979c>]    psr: 60000193
[    7.771667] sp : c381bdd0  ip : c381bf00  fp : c195bba0
[    7.776916] r10: 0000000c  r9 : 00000060  r8 : f8000000
[    7.782196] r7 : 00000000  r6 : c2d7ace4  r5 : c4a47d48  r4 : c2d7b060
[    7.788757] r3 : f880350c  r2 : c2d7b060  r1 : 00000000  r0 : c2d7b060
[    7.795349] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    7.802612] Control: 10c5387d  Table: 8020406a  DAC: 00000051
[    7.808410] Register r0 information: non-slab/vmalloc memory
[    7.814117] Register r1 information: NULL pointer
[    7.818878] Register r2 information: non-slab/vmalloc memory
[    7.824584] Register r3 information: non-paged memory
[    7.829681] Register r4 information: non-slab/vmalloc memory
[    7.835388] Register r5 information: slab kmalloc-128 start
c4a47d00 pointer offset 72 size 128
[    7.844177] Register r6 information: non-slab/vmalloc memory
[    7.849884] Register r7 information: NULL pointer
[    7.854644] Register r8 information: 0-page vmalloc region starting
at 0xf8000000 allocated at iotable_init+0x0/0xec
[    7.865264] Register r9 information: non-paged memory
[    7.870361] Register r10 information: non-paged memory
[    7.875549] Register r11 information: non-slab/vmalloc memory
[    7.881317] Register r12 information: non-slab/vmalloc memory
[    7.887115] Process swapper/0 (pid: 0, stack limit = 0x30bafaed)
[    7.893188] Stack: (0xc381bdd0 to 0xc381c000)
[    7.897583] bdc0:                                     e89359dc
c649fa44 c649fb44 a0000193
[    7.905822] bde0: c649fb48 c6bc83a4 c6bc8380 00000001 c34413a0
00000060 00000003 c381bf00
[    7.914093] be00: c4a47d40 b77037c4 c2c0d880 00000000 c63ccb40
e8936b00 c63c8ac0 e8937118
[    7.922332] be20: 41b58ab3 c27d9494 c09e9660 010f0001 00000000
c381bec0 c6bc84f8 b77037d0
[    7.930572] be40: c2c0d880 c381bf00 c649fc30 c28b650c 0147adf0
00000001 c649fc38 c649fc38
[    7.938812] be60: c63c8ac0 b77037d4 c63ccb40 c350ea80 00000000
e893712c c2ba2b00 c039c7e8
[    7.947052] be80: 41b58ab3 c2891318 c143fcc0 c63c8ac8 c381bf00
00000000 00007736 c0d2833c
[    7.955291] bea0: b77037dc e89353e0 c2ba13e0 8d000000 c0309b48
c2c0d880 25d94000 c0d289e4
[    7.963531] bec0: 00000000 e89353f0 c2c070dc c2c070dc 00000000
ffff8dd0 e8934770 cbf3bdd5
[    7.971771] bee0: 41b58ab3 c284cd7c c0d2884c c0395140 e8936fa4
e8936cec e8936b00 c03a5bfc
[    7.980010] bf00: 00000001 00000000 c69e5c80 c65d1a00 c65d1a84
f30a64dc 00000073 c4b4f380
[    7.988250] bf20: c09e9660 00000000 c392fa00 00000060 c34d3e08
c195bb00 c195bba0 c03e68bc
[    7.996490] bf40: 60000113 f30a64dc c69e5b00 c392fa00 c392fa00
c392fa24 c392fa6c c392fa24
[    8.004730] bf60: c392fa28 25d94000 c381bf88 c03e6a44 c392fa00
c2b9f3e8 c392fa6c c2c2a2a0
[    8.012969] bf80: c392fa24 c03ed464 c03ed36c c392fa00 c2c0d880
c2d6f240 c2ba13d0 c2c07488
[    8.021209] bfa0: fa212000 fa21200c c2c03e80 c03e5f2c 0000002a
0000002a c2d6f240 c09c8e58
[    8.029449] bfc0: e8934a90 00000000 c2c03e80 c2c03e88 00000000
ffffffff c2c03ebc 00000000
[    8.037689] bfe0: c2c0d880 00000000 c2c03e80 c184ad00 c0309b48
60000013 ffffffff c099c9c8
[    8.045898]  l3_interrupt_handler from __handle_irq_event_percpu+0x7c/0x148
[    8.052947]  __handle_irq_event_percpu from handle_irq_event+0x6c/0xd4
[    8.059539]  handle_irq_event from handle_fasteoi_irq+0xf8/0x268
[    8.065643]  handle_fasteoi_irq from generic_handle_domain_irq+0x38/0x48
[    8.072387]  generic_handle_domain_irq from gic_handle_irq+0xb4/0xe4
[    8.078826]  gic_handle_irq from generic_handle_arch_irq+0x2c/0x3c
[    8.085083]  generic_handle_arch_irq from call_with_stack+0x18/0x20
[    8.091400]  call_with_stack from __irq_svc+0x80/0x98
[    8.096496] Exception stack(0xc2c03e88 to 0xc2c03ed0)
[    8.101623] 3e80:                   00001060 e8937458 fe600000
00000000 c2c0d880 c2c06f10
[    8.109832] 3ea0: 00000000 c2c06f70 00000000 c2ba19e8 00000000
b75807e0 bc126e8c c2c03ed8
[    8.118072] 3ec0: c033c988 c0309b48 60000013 ffffffff
[    8.123168]  __irq_svc from arch_cpu_idle+0x20/0x48
[    8.128112]  arch_cpu_idle from do_idle+0x2e4/0x388
[    8.133026]  do_idle from cpu_startup_entry+0x18/0x1c
[    8.138122]  cpu_startup_entry from rest_init+0xd0/0xd4
[    8.143402]  rest_init from arch_post_acpi_subsys_init+0x0/0x8
[    8.149322] Code: ebecd208 e5943000 e08a3003 e0883003 (e593b000)
[    8.155456] ---[ end trace 0000000000000000 ]---
[    8.160125] Kernel panic - not syncing: Fatal exception in interrupt
[    8.166534] CPU1: stopping
[    8.169250] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W
  5.18.0-next-20220526 #1
[    8.177856] Hardware name: Generic DRA74X (Flattened Device Tree)
[    8.183990]  unwind_backtrace from show_stack+0x10/0x14
[    8.189270]  show_stack from dump_stack_lvl+0x40/0x4c
[    8.194396]  dump_stack_lvl from do_handle_IPI+0x150/0x184
[    8.199920]  do_handle_IPI from ipi_handler+0x18/0x20
[    8.205017]  ipi_handler from handle_percpu_devid_irq+0xc8/0x1e8
[    8.211090]  handle_percpu_devid_irq from generic_handle_domain_irq+0x38/0x48
[    8.218292]  generic_handle_domain_irq from gic_handle_irq+0xb4/0xe4
[    8.224731]  gic_handle_irq from generic_handle_arch_irq+0x2c/0x3c
[    8.230957]  generic_handle_arch_irq from call_with_stack+0x18/0x20
[    8.237274]  call_with_stack from __irq_svc+0x80/0x98
[    8.242401] Exception stack(0xc3987ec0 to 0xc3987f08)
[    8.247497] 7ec0: 00000788 e8943458 fe600000 00000000 c3991580
c2c06f10 00000001 c2c06f70
[    8.255737] 7ee0: 00000000 c2ba19e8 00000000 b7730fe8 bc12868c
c3987f10 c033c988 c0309b48
[    8.263946] 7f00: 60000013 ffffffff
[    8.267456]  __irq_svc from arch_cpu_idle+0x20/0x48
[    8.272399]  arch_cpu_idle from do_idle+0x2e4/0x388
[    8.277313]  do_idle from cpu_startup_entry+0x18/0x1c
[    8.282409]  cpu_startup_entry from secondary_start_kernel+0x170/0x198
[    8.289001]  secondary_start_kernel from 0x80301774


URL:
KASAN enabled boot log:
https://lkft.validation.linaro.org/scheduler/job/5103357#L2534

KASAN not enabled boot log:
https://lkft.validation.linaro.org/scheduler/job/5103136#L1970

metadata:
  git_ref: master
  git_repo: https://git.linaro.org/kernel-org/linux-next.git
  git_sha: b1d84fc09a961e0a8be3d3dc6ca1b7cddc3ced87
  git_describe: next-20220526
  kernel_version: 5.18.0
  kernel-config: https://builds.tuxbuild.com/29h2N2T49y1wut2riESfYKAMqHE/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/548575739
  artifact-location: https://builds.tuxbuild.com/29h2N2T49y1wut2riESfYKAMqHE
  toolchain: gcc-10
  vmlinux.xz: https://builds.tuxbuild.com/29h2N2T49y1wut2riESfYKAMqHE/vmlinux.xz
  System.map: https://builds.tuxbuild.com/29h2N2T49y1wut2riESfYKAMqHE/System.map

--
Linaro LKFT
https://lkft.linaro.org
