Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65050BBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449430AbiDVP3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379791AbiDVP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:29:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00F037A1C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:26:10 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ef5380669cso88917787b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cendmS9M+hafp0sRCCph1x27cQg8ck+RUugsVgjF93A=;
        b=HPCC0BoCw6ykEbCKdUPsUuhud+Jm8fA9JvYHPoufofQHEikiMGHEce8K5EdVxKgzZM
         22I4Bt6pTXn6zLaqg9gaYYClTALy34p/wVztFYCelOCw30uw4NtEag8FqiiUpAElH6l1
         1ujvUe3ZWLTokxjOloGgNWM5PxXCmn2CEwWbopFOGw90+xIHwPtzL52v5a821eWiCDM5
         zZJYWc6wRTjMEtgoTyLhBsfWA4cLzgxecrH04Ykp93dtLXPoXkxsk56oN0YD7A6U8KPv
         gQGAs8m5+9CmS0//DfKmYoZMAiyYHDkQViB/oKY8Z0q115JRkVfGSueOCuYvhDTuamyY
         bKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cendmS9M+hafp0sRCCph1x27cQg8ck+RUugsVgjF93A=;
        b=1Q3n1ozcFcP7M/GNLIDefUjtPVEa3rsbttd3C6I6HEHzamiLZy4g05+WM6cI+/v2nY
         ku6rkP3HsgCh9IQ7KT7A4dUh2c9V2RGaflUINr7/hLcK733pqfFSzWZXlkZ4NwTtAWG1
         4Y2DxM5O6gSIed7yaNZTY9o4P4QGUZ6BBSCklyxnUBytdFEhpVb9n8qnTcqIHSRTlfwS
         XgX3omH04zVTe1fl99NPe9N0c8rAkZi1Uqjnqpl5Tlb659m8WY4NJFLSl61sy9bhmQPy
         IOJz51QPOOLbEWk7f3u9wNOtbu+xy/eEGvPcLlhkfEKZVDEt/sRndraB2E5Bq4p2M+cw
         vzbw==
X-Gm-Message-State: AOAM531s+/CYZ2EEbLq2rKA0zKgf6XcZBFEXj14bLlNuZF/BJE1oqtcN
        FjmFtD1gPeNKLaA8USh3SgVqJvip2IL5V02xotApNQ==
X-Google-Smtp-Source: ABdhPJxKDFi4fdtFBUxSSp/n3JUrQcugRePBV3YZJvmejB6Lum1ef3U68ixfHRnQTgqBd5TBZs1hBXbnJLh+d8p3vb0=
X-Received: by 2002:a81:9210:0:b0:2f4:d8f7:98e9 with SMTP id
 j16-20020a819210000000b002f4d8f798e9mr5376228ywg.265.1650641169866; Fri, 22
 Apr 2022 08:26:09 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Apr 2022 20:55:58 +0530
Message-ID: <CA+G9fYu8GoJ1-Tf=-LHFGTvuHdjABLWSGH=pfxTojwEXSjxTbw@mail.gmail.com>
Subject: OF: ERROR: Bad of_node_put() on /ocp/interconnect@4a000000/segment@0/target-module@8000/cm_core@0/clock@c00/clock@0
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dev.kurt@vandijck-laurijssen.be,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next-20220412 booting on arm beagle board x15 device found the
following warnings.
This is still happening on today's linux next-20220422.

[    0.000000] Linux version 5.18.0-rc2-next-20220412
(tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP @1649744781
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
[    0.000000] DRA752 ES2.0
[    0.000000] percpu: Embedded 16 pages/cpu s35028 r8192 d22316 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522051
[    0.000000] Kernel command line: console=ttyS2,115200n8
root=PARTUUID=008ff1a4-d1d9-294a-89cd-d80f952045d9 rw rootfstype=ext4
rootwait
[    0.000000] Dentry cache hash table entries: 131072 (order: 7,
524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1812440K/2095100K available (16384K kernel
code, 2662K rwdata, 8720K rodata, 2048K init, 649K bss, 53284K
reserved, 229376K cma-reserved, 1245180K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] ftrace: allocating 59389 entries in 175 pages
[    0.000000] ftrace: allocated 174 pages with 5 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: RCU event tracing is enabled.
[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=2.
[    0.000000] Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] kfence: initialized - using 2097152 bytes for 255
objects at 0x(ptrval)-0x(ptrval)
[    0.000000] random: get_random_bytes called from
start_kernel+0x54c/0x6fc with crng_init=0
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at lib/refcount.c:25 kobject_get+0x9c/0xa0
[    0.000000] refcount_t: addition on 0; use-after-free.
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.18.0-rc2-next-20220412 #1
[    0.000000] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.000000]  unwind_backtrace from show_stack+0x18/0x1c
[    0.000000]  show_stack from dump_stack_lvl+0x58/0x70
[    0.000000]  dump_stack_lvl from __warn+0xd0/0x144
[    0.000000]  __warn from warn_slowpath_fmt+0x98/0xbc
[    0.000000]  warn_slowpath_fmt from kobject_get+0x9c/0xa0
[    0.000000]  kobject_get from of_node_get+0x1c/0x24
[    0.000000]  of_node_get from of_fwnode_get+0x3c/0x48
[    0.000000]  of_fwnode_get from fwnode_get_nth_parent+0x34/0x104
[    0.000000]  fwnode_get_nth_parent from fwnode_full_name_string+0x34/0xa0
[    0.000000]  fwnode_full_name_string from device_node_string+0x5fc/0x6c8
[    0.000000]  device_node_string from pointer+0x3c8/0x670
[    0.000000]  pointer from vsnprintf+0x22c/0x3cc
[    0.000000]  vsnprintf from vprintk_store+0x114/0x43c
[    0.000000]  vprintk_store from vprintk_emit+0x78/0x2bc
[    0.000000]  vprintk_emit from vprintk_default+0x28/0x30
[    0.000000]  vprintk_default from _printk+0x30/0x54
[    0.000000]  _printk from of_node_release+0x124/0x12c
[    0.000000]  of_node_release from kobject_put+0xc4/0x294
[    0.000000]  kobject_put from ti_dt_clocks_register+0x284/0x32c
[    0.000000]  ti_dt_clocks_register from dra7xx_dt_clk_init+0x18/0x11c
[    0.000000]  dra7xx_dt_clk_init from omap5_realtime_timer_init+0x10/0x21c
[    0.000000]  omap5_realtime_timer_init from start_kernel+0x560/0x6fc
[    0.000000]  start_kernel from 0x0
[    0.000000] ---[ end trace 0000000000000000 ]---
login-action: exception
#
[    0.000000] ------------[ cut #
[login-action] Waiting for messages, (timeout 00:14:33)
here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at lib/refcount.c:28
fwnode_get_nth_parent+0x50/0x104
[    0.000000] refcount_t: underflow; use-after-free.
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
  5.18.0-rc2-next-20220412 #1
[    0.000000] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.000000]  unwind_backtrace from show_stack+0x18/0x1c
[    0.000000]  show_stack from dump_stack_lvl+0x58/0x70
[    0.000000]  dump_stack_lvl from __warn+0xd0/0x144
[    0.000000]  __warn from warn_slowpath_fmt+0x98/0xbc
[    0.000000]  warn_slowpath_fmt from fwnode_get_nth_parent+0x50/0x104
[    0.000000]  fwnode_get_nth_parent from fwnode_full_name_string+0x34/0xa0
[    0.000000]  fwnode_full_name_string from device_node_string+0x5fc/0x6c8
[    0.000000]  device_node_string from pointer+0x3c8/0x670
[    0.000000]  pointer from vsnprintf+0x22c/0x3cc
[    0.000000]  vsnprintf from vprintk_store+0x114/0x43c
[    0.000000]  vprintk_store from vprintk_emit+0x78/0x2bc
[    0.000000]  vprintk_emit from vprintk_default+0x28/0x30
[    0.000000]  vprintk_default from _printk+0x30/0x54
[    0.000000]  _printk from of_node_release+0x124/0x12c
[    0.000000]  of_node_release from kobject_put+0xc4/0x294
[    0.000000]  kobject_put from ti_dt_clocks_register+0x284/0x32c
[    0.000000]  ti_dt_clocks_register from dra7xx_dt_clk_init+0x18/0x11c
[    0.000000]  dra7xx_dt_clk_init from omap5_realtime_timer_init+0x10/0x21c
[    0.000000]  omap5_realtime_timer_init from start_kernel+0x560/0x6fc
[    0.000000]  start_kernel from 0x0
[    0.000000] ---[ end trace 0000000000000000 ]---
login-action: exception
#
[    0.000000] ------------[ cut here ]--------#
[login-action] Waiting for messages, (timeout 00:14:33)
----
[    0.000000] WARNING: CPU: 0 PID: 0 at lib/refcount.c:22 kobject_get+0x88/0xa0
[    0.000000] refcount_t: saturated; leaking memory.
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
  5.18.0-rc2-next-20220412 #1
[    0.000000] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.000000]  unwind_backtrace from show_stack+0x18/0x1c
[    0.000000]  show_stack from dump_stack_lvl+0x58/0x70
[    0.000000]  dump_stack_lvl from __warn+0xd0/0x144
[    0.000000]  __warn from warn_slowpath_fmt+0x98/0xbc
[    0.000000]  warn_slowpath_fmt from kobject_get+0x88/0xa0
[    0.000000]  kobject_get from of_node_get+0x1c/0x24
[    0.000000]  of_node_get from of_fwnode_get+0x3c/0x48
[    0.000000]  of_fwnode_get from fwnode_get_nth_parent+0x34/0x104
[    0.000000]  fwnode_get_nth_parent from fwnode_full_name_string+0x34/0xa0
[    0.000000]  fwnode_full_name_string from device_node_string+0x5fc/0x6c8
[    0.000000]  device_node_string from pointer+0x3c8/0x670
[    0.000000]  pointer from vsnprintf+0x22c/0x3cc
[    0.000000]  vsnprintf from vprintk_store+0x114/0x43c
[    0.000000]  vprintk_store from vprintk_emit+0x78/0x2bc
[    0.000000]  vprintk_emit from vprintk_default+0x28/0x30
[    0.000000]  vprintk_default from _printk+0x30/0x54
[    0.000000]  _printk from of_node_release+0x124/0x12c
[    0.000000]  of_node_release from kobject_put+0xc4/0x294
[    0.000000]  kobject_put from ti_dt_clocks_register+0x284/0x32c
[    0.000000]  ti_dt_clocks_register from dra7xx_dt_clk_init+0x18/0x11c
[    0.000000]  dra7xx_dt_clk_init from omap5_realtime_timer_init+0x10/0x21c
[    0.000000]  omap5_realtime_timer_init from start_kernel+0x560/0x6fc
[    0.000000]  start_kernel from 0x0
[    0.000000] ---[ end trace 0000000000000000 ]---
login-action: exception
#
[    0.000000] OF: ERROR: Bad of_node_put() on
/ocp/interconnect@4a000000/segment@0/targe#
[login-action] Waiting for messages, (timeout 00:14:33)
t-module@8000/cm_core@0/clock@c00/clock@0
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
  5.18.0-rc2-next-20220412 #1
[    0.000000] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.000000]  unwind_backtrace from show_stack+0x18/0x1c
[    0.000000]  show_stack from dump_stack_lvl+0x58/0x70
[    0.000000]  dump_stack_lvl from kobject_put+0xc4/0x294
[    0.000000]  kobject_put from ti_dt_clocks_register+0x284/0x32c
[    0.000000]  ti_dt_clocks_register from dra7xx_dt_clk_init+0x18/0x11c
[    0.000000]  dra7xx_dt_clk_init from omap5_realtime_timer_init+0x10/0x21c
[    0.000000]  omap5_realtime_timer_init from start_kernel+0x560/0x6fc
[    0.000000]  start_kernel from 0x0
[    0.000000] OF: ERROR: Bad of_node_put() on
/ocp/interconnect@4a000000/segment@0/target-module@8000/cm_core@0/clock@1100/clock@20
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
  5.18.0-rc2-next-20220412 #1
[    0.000000] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.000000]  unwind_backtrace from show_stack+0x18/0x1c
[    0.000000]  show_stack from dump_stack_lvl+0x58/0x70
[    0.000000]  dump_stack_lvl from kobject_put+0xc4/0x294
[    0.000000]  kobject_put from ti_dt_clocks_register+0x284/0x32c
[    0.000000]  ti_dt_clocks_register from dra7xx_dt_clk_init+0x18/0x11c
[    0.000000]  dra7xx_dt_clk_init from omap5_realtime_timer_init+0x10/0x21c
[    0.000000]  omap5_realtime_timer_init from start_kernel+0x560/0x6fc
[    0.000000]  start_kernel from 0x0
[    0.000000] OF: ERROR: Bad of_node_put() on
/ocp/interconnect@4ae00000/segment@0/target-module@6000/prm@0/clock@1800/clock@20
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
  5.18.0-rc2-next-20220412 #1
[    0.000000] Hardware name: Generic DRA74X (Flattened Device Tree)


link:
https://lkft.validation.linaro.org/scheduler/job/4882391#L2104

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: d0c745e7b2d6ce8bcc768b32361ab8ef520821ee
  git_describe: next-20220412
  kernel_version: 5.18.0-rc2
  kernel-config: https://builds.tuxbuild.com/27gbKLQxkCjWcdfqbhpWsh5Ocq0/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/514668403
  artifact-location: https://builds.tuxbuild.com/27gbKLQxkCjWcdfqbhpWsh5Ocq0
  toolchain: gcc-10


--
Linaro LKFT
https://lkft.linaro.org
