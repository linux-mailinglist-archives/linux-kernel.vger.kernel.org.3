Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F205AD352
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiIEM4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiIEM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:56:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED54205ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:56:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso12175830pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=B1ZRrfSxAPxcOQpMQyL+sFtB43gcb/gYylxE47+qH8A=;
        b=g6xXMoA69DQLTEQofbdh+tkt3v17OUGYrgfJa7U5RrC32EBZgumRZpcZ0bc1F/8ZSK
         Bj50hkMOH6U8aSK9sFfRaHvn+EZ2ljr1SOfa1ug4+RRmb0/JSsWytNv0dcqLJBi4s7qR
         pSO5l0WILXpa8NEuGUhGbvDkro1XLwa6nCXY9WEk8NEx8QfxvyMF4VlbM4gNu1Q3OwlI
         qIsEnKgYBbBW1/KNj6bD31ClntHRUNGpVopO6oW/D5q/q5WZzDpGTl7rJqDlWHdQRLWs
         +t2hfL1KoW/VNywwyC3kn8DahKKRTc42bvm7U7JoVfFCNVn60h8DmqLAeuyJK2NGH/Kv
         re7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B1ZRrfSxAPxcOQpMQyL+sFtB43gcb/gYylxE47+qH8A=;
        b=uDtFMtE3HWzlXSvxdZJt6BAq1wHVcxVqZiHbt/PI19G1d772odKhxcLOBH78bNbGHc
         eQzcX/NBTPAB1jNz3okXWEWchpzbOQFlS8DqNPi27Mh0YQNWSoqpNdcWa7ioiGMyY9NM
         FOTmke72/qBCYuq8ODBrJZvWbdqYWumrS43NNaeWqae/kHp2q8cASvoSYvhp/vF8kgSf
         VafoeueG2Xl5wRYMBs2+BJRHE2rsVH2wOkk37nC6oacZSGXPdB1bNMGrpbWcwMv3esDY
         feTpLE6eORPxfqOwqcD564/XyZszdBsq5cQQ1F4MyVX6WXvHFpHjCyOfREfAeiayqt8m
         sMHw==
X-Gm-Message-State: ACgBeo1PY4CtOQKnlthIzSG0j+Av1NZqSaAFfWzGJ8NggE/cb2SPHAu7
        6lL9NGKYtpTpxSKj/BmRomPO23f+paV1BQ==
X-Google-Smtp-Source: AA6agR43ueimBQKy8WFlRq34H6G54rgzkVRaYPpiksW9Bclfu8NmPlXbSK73x9L2KnyAz5g7SfkEXA==
X-Received: by 2002:a17:902:d48a:b0:16f:c31:7005 with SMTP id c10-20020a170902d48a00b0016f0c317005mr49122770plg.173.1662382600761;
        Mon, 05 Sep 2022 05:56:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f70a00b00172fad607b3sm7359778plo.207.2022.09.05.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 05:56:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Sep 2022 05:56:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.0-rc4
Message-ID: <20220905125637.GA2630968@roeck-us.net>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
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

On Sun, Sep 04, 2022 at 01:22:59PM -0700, Linus Torvalds wrote:
> It's Sunday afternoon, which can only mean one thing - another rc
> release. We're up to rc4, and things mostly still look fairly normal.
> 
> Most of the fixes the past week have been drivers (gpu, networking,
> gpio, tty, usb, sound.. a little bit of everything in other words).
> But we have the usual mix of fixes elsewhere too - architecture fixes
> (arm64, loongarch, powerpc, RISC-V, s390 and x86), and various other
> areas - core networking, filesystems, io_uring, LSM, selftests and
> documentation. Some of this is reverts of things that just turned out
> to be wrong or just not quite ready.
> 
> Please do go test,

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 489 pass: 469 fail: 20
Failed tests:
	arm:versatileab:versatile_defconfig:mem128:net,default:versatile-ab:initrd
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb0:mem128:net,default:imx25-pdk:rootfs
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb1:mem128:net,default:imx25-pdk:rootfs
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb0:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb1:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:usb1:mem256:net,nic:imx7d-sdb:rootfs
	arm:vexpress-a9:multi_v7_defconfig:nolocktests:mem128:net,default:vexpress-v2p-ca9:initrd
	arm:vexpress-a9:multi_v7_defconfig:nolocktests:sd:mem128:net,default:vexpress-v2p-ca9:rootfs
	arm:vexpress-a9:multi_v7_defconfig:nolocktests:flash64:mem128:net,default:vexpress-v2p-ca9:rootfs
	arm:vexpress-a9:multi_v7_defconfig:nolocktests:virtio-blk:mem128:net,default:vexpress-v2p-ca9:rootfs
	arm:vexpress-a15:multi_v7_defconfig:nolocktests:sd:mem128:net,default:vexpress-v2p-ca15-tc1:rootfs
	arm:vexpress-a15-a7:multi_v7_defconfig:nolocktests:sd:mem256:net,default:vexpress-v2p-ca15_a7:rootfs
	arm:sabrelite:multi_v7_defconfig:usb0:mem256:net,default:imx6dl-sabrelite:rootfs
	arm:sabrelite:multi_v7_defconfig:usb1:mem256:net,default:imx6dl-sabrelite:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:mem128:net,default:zynq-zc702:initrd
	arm:xilinx-zynq-a9:multi_v7_defconfig:usb0:mem128:net,default:zynq-zc702:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:sd:mem128:net,default:zynq-zc702:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:sd:mem128:net,default:zynq-zc706:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:usb0:mem128:zynq-zed:rootfs
	m68k:mcf5208evb:m5208:m5208evb_defconfig:initrd

---
TL;DR: Patches / reverts needed to fix known regressions

Revert "scsi: core: Make sure that targets outlive devices"
Revert "scsi: core: Make sure that hosts outlive targets"
Revert "scsi: core: Simplify LLD module reference counting"
Revert "scsi: core: Call blk_mq_free_tag_set() earlier"
    revert f323896fe6fa
    revert 1a9283782df2
    revert fe442604199e
    revert 16728aaba62e
    Rationale:
	The series may result in hung tasks on reboot when booting from USB drive.
    Reports:
	https://lore.kernel.org/linux-scsi/000000000000b5187d05e6c08086@google.com/
	https://lore.kernel.org/all/27d0dde8-344c-1dd0-cc26-0e10c4e1f296@acm.org/
	https://syzkaller.appspot.com/bug?extid=bafeb834708b1bb750bc
Revert "fec: Restart PPS after link state change"
    revert f79959220fa5
    Rationale:
	The patch results in various tracebacks and crashes.
    Report:
	https://lore.kernel.org/netdev/20220827160922.642zlcd5foopozru@pengutronix.de/
HACK: Disable CONFIG_CGROUP_FREEZER for riscv
    Rationale: CONFIG_CGROUP_FREEZER results in a backtrace which hampers testing
    and may hide other problems.
    Note: I will make this hack permanent and no longer report the traceback
    going forward.
Apply "amba: Fix use-after-free in amba_read_periphid()"
    Link: https://lore.kernel.org/r/20220818172852.3548-1-isaacmanjarres@google.com

==============================
Details:

Build:

No regressions observed in my build tests.

-----------

qemu tests:

Crashes:

Various UAF reports and related crashes in amba_read_periphid() and/or
in clock handling code.

8<--- cut here ---
Unhandled fault: page domain fault (0x81b) at 0x00000122
[00000122] *pgd=00000000
Internal error: : 81b [#1] ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.0.0-rc3+ #1
Hardware name: ARM-Versatile (Device Tree Support)
PC is at do_alignment_ldrstr+0x7c/0x164
LR is at ai_half+0x0/0x4
pc : [<c001fa00>]    lr : [<c0ca9278>]    psr: 60000113
sp : c8811d68  ip : 00000003  fp : 00000004
r10: c05461f8  r9 : c0ca9278  r8 : 00000801
r7 : 00000122  r6 : 00000000  r5 : e5823000  r4 : c8811df8
r3 : 00000100  r2 : c8811df8  r1 : 00000000  r0 : 00000122
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 00093177  Table: 02340000  DAC: 00000051
Register r0 information: non-paged memory
Register r1 information: NULL pointer
Register r2 information: 2-page vmalloc region starting at 0xc8810000 allocated at kernel_clone+0x70/0x640
Register r3 information: non-paged memory
Register r4 information: 2-page vmalloc region starting at 0xc8810000 allocated at kernel_clone+0x70/0x640
Register r5 information: non-paged memory
Register r6 information: NULL pointer
Register r7 information: non-paged memory
Register r8 information: non-paged memory
Register r9 information: non-slab/vmalloc memory
Register r10 information: non-slab/vmalloc memory
Register r11 information: non-paged memory
Register r12 information: non-paged memory
Process swapper (pid: 1, stack limit = 0x(ptrval))
Stack: (0xc8811d68 to 0xc8812000)
1d60:                   c8811df8 e5823000 00000000 c00201dc 00000000 00000000
1d80: c0bfb0d4 60000013 00000000 c006c558 00000001 00000000 e5823000 c053fbd4
1da0: 00000000 c0bef86c c1496d40 00000801 c0bf4438 c001ffdc c8811df8 00000122
1dc0: c1496d40 c0bcb858 00000000 c001d66c c12b6950 00000001 c0c67e10 c1496d40
1de0: c05461f8 20000013 ffffffff c8811e2c c1496d40 c00095c4 00000001 00000001
1e00: 00000122 00000100 c24e1cc0 c1552c00 00000fff c0c67c90 c1496d40 c24ded58
1e20: c0bcb858 00000000 c1497338 c8811e48 00000001 c05461fc 20000013 ffffffff
1e40: 00000053 c05461e0 ffffffed c1552c00 00000fff c0c67c90 c1496d40 c24ded58
1e60: c0bcb858 c053d598 c1552c00 c0c67cf4 c0c67cf4 c053d61c 00000000 c1552c00
1e80: c0c67cf4 c05dd40c 00000000 c0c67cf4 c05dd3ec c0c67c90 c1496d40 c05dada4
1ea0: 00000000 c1541eac c1550df4 c0bef86c c0c67cf4 c24ded00 00000000 c05dbf9c
1ec0: c0ad3724 c0c9b280 c1496d40 c0c67cf4 c0c9b280 c1496d40 00000000 c1496d40
1ee0: c0ca9000 c05ddfb4 c0bb77f0 c0c9b280 c1496d40 c000a8b0 00000000 00000000
1f00: c14d7e4b c0b66600 000000bf c0047c0c c0b65754 00000000 c0c9b280 c0892b48
1f20: c1496d40 00000007 c0c9b280 c14d7e00 c0bcb874 c0b65754 c0ca9000 c0bcb858
1f40: 00000000 c0bef86c c0be4af8 00000008 c14d7e00 c0bcb878 c0b65754 c0b9a230
1f60: 00000007 00000007 00000000 c0b99400 00000000 000000bf 00000000 00000000
1f80: c0892e14 00000000 00000000 00000000 00000000 00000000 00000000 c0892e24
1fa0: 00000000 c0892e14 00000000 c00084f8 00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
 do_alignment_ldrstr from do_alignment+0x200/0x984
 do_alignment from do_DataAbort+0x38/0xb8
 do_DataAbort from __dabt_svc+0x64/0xa0
Exception stack(0xc8811df8 to 0xc8811e40)
1de0:                                                       00000001 00000001
1e00: 00000122 00000100 c24e1cc0 c1552c00 00000fff c0c67c90 c1496d40 c24ded58
1e20: c0bcb858 00000000 c1497338 c8811e48 00000001 c05461fc 20000013 ffffffff
 __dabt_svc from __clk_put+0x34/0x174
 __clk_put from amba_read_periphid+0xd8/0x120
 amba_read_periphid from amba_match+0x3c/0x84
 amba_match from __driver_attach+0x20/0x114
 __driver_attach from bus_for_each_dev+0x74/0xc0
 bus_for_each_dev from bus_add_driver+0x154/0x1e8
 bus_add_driver from driver_register+0x74/0x10c
 driver_register from do_one_initcall+0x8c/0x2fc

 do_one_initcall from kernel_init_freeable+0x194/0x224
 kernel_init_freeable from kernel_init+0x10/0x108
 kernel_init from ret_from_fork+0x14/0x3c
Exception stack(0xc8811fb0 to 0xc8811ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e3a00002 e782310c e8bd8070 e792310c (e4c03001)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

The fix is at
    Link: https://lore.kernel.org/r/20220818172852.3548-1-isaacmanjarres@google.com

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

--------

Various imx emulations hang in scsi_remove_host() during reboot. 
Bisect points to the patch series at
https://lore.kernel.org/all/20220712221936.1199196-1-bvanassche@acm.org/
Reverting this series fixes the problem.

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

Exposed by commit ba6cfef057e1 ("riscv: enable Docker requirements in
defconfig"). Result of enabling CONFIG_CGROUP_FREEZER. The problem is
no longer seen after removing that configuration option.

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
