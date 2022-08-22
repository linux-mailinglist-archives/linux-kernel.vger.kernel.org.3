Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B965F59C5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiHVSEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiHVSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:03:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C182D27B00
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:03:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v23so5349480plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=PeU7ehe8d8QwR6AreVUNbpGV1ED06tkZ7LJBas7zZtg=;
        b=ML2twp/o0FdxpRb+uhseFGmyDnyfO3Cqc7MTLjD8xSEP+/LNp9Oib3hieCcdjFvBUp
         QziusgIt/05UOz48JpAf2E0h0VxqqRJy+sZWFVwqz+ORtziP9DMu2PirPt/TQXaxxKQX
         9H8M3zpo5kPV8I2umGwWa3qjhntX1gOVaQbm5HQk44ka9J5anAyiGRzDtdWxqkmydfug
         Xo9KBpHkLxLCHluIO2WvkXga2em6wWN7qW4NN0VCb5DZlyPFbN09v+PJicjAJjybAE3+
         O1PDh9irynm5scN4ls3QVhFpmytOiDjR1xVpT6bfL9d7NsyLdRym9AB0Twhf+kWedlvw
         W52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=PeU7ehe8d8QwR6AreVUNbpGV1ED06tkZ7LJBas7zZtg=;
        b=U6GLWheI6s+KYnJ5sDozODy/QGOevxqh7rc6p++e9iHN2d+Q+gjKJMpiczIUdD9kUz
         otjqzxV/q9IaU9NS0RCFofaPIMCN56kp33Nn0i941ovGhE/mmCCtZapHCIeNv/Z0wy6v
         PYzXrc5NL9erts2h3iUOL4IuF5dm25pi7y2cT9HiotjJuKka7rci2/eEFZR2H2/vaoHl
         ydViFkNtyDGEJRfcqHCgTSoMCC+Cds0w8HkjmVEMnAJWO1Ir/6lAgbDJqbjGzPlykauG
         IZb5OB/lQLicowlFYYZac2ztAdaSP6Td3cV//yEoJksCcURehmRhXaCop9eoKYpecb22
         8kPw==
X-Gm-Message-State: ACgBeo3u3KGnRrtd2gs6m5XLwFXfkoPO+vTQLguODspksFqKTDkgR1Rj
        kjk3KqB0AvZ6A5id4TDxlrm4fN4DA4M=
X-Google-Smtp-Source: AA6agR62h7Z4EZn6X8KBrDTEGAHSfuzihO6Ht+hsdF5Y6NSTJY7DF6bypvVJRKKdthVmkK6ZkvkCVw==
X-Received: by 2002:a17:90b:1d08:b0:1fb:5ce5:e644 with SMTP id on8-20020a17090b1d0800b001fb5ce5e644mr445692pjb.215.1661191435172;
        Mon, 22 Aug 2022 11:03:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m22-20020a17090aab1600b001fb438fb772sm1540278pjq.56.2022.08.22.11.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:03:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 11:03:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.0-rc2
Message-ID: <20220822180353.GA4136350@roeck-us.net>
References: <CAHk-=wj_XDfMiVXuo6A98KF4MsXxtyuMP_OtOGw87xnKERcfAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wj_XDfMiVXuo6A98KF4MsXxtyuMP_OtOGw87xnKERcfAg@mail.gmail.com>
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

On Sun, Aug 21, 2022 at 05:54:04PM -0700, Linus Torvalds wrote:
> It's Sunday afternoon (ok,early evening, just randomly doing this a
> bit later than usual), and there's a new rc out.
> 
> Nothing particularly interesting here, rc2 tends to be fairly calm
> with people taking a breather and not yet having found a lot of bugs.
> 
> The most noticeable fix in here is likely the virtio reverts that
> fixed the problem people had with running tests on the google cloud
> VMs, which was the "pending issue" that we had noticed just as the
> merge window was closing. And it's noticeable - and notable - mainly
> because that problem then kept people from running some of the
> automated tests and thus finding other issues.
> 
> But obviously there's a lot of other things in here too, as per the
> appended shortlog. The diffs are somewhat dominated by the amd gpu
> fixes - they missed the "drm fixes" pull during the merge window, so
> there were a bunch of fixes pending on that side.  But there's some
> network driver fixes, some filesystem fixes (btrfs and a late ntfs3
> half-fixes-half-updates pull), and the usual set of architecture fixes
> and other core code (mainly networking).
> 
> And some tooling fixes - a mix of selftests and perf.
> 
> Go forth and test,
> 
Build results:
	total: 149 pass: 147 fail: 2
Failed builds:
	i386:tools/perf
	x86_64:tools/perf
Qemu test results:
	total: 489 pass: 464 fail: 25
Failed tests:
	arm:versatilepb:versatile_defconfig:aeabi:pci:scsi:mem128:net,default:versatile-pb:rootfs
	arm:versatilepb:versatile_defconfig:aeabi:pci:flash64:mem128:net,default:versatile-pb:rootfs
	arm:versatilepb:versatile_defconfig:aeabi:pci:mem128:net,default:versatile-pb:initrd
	arm:versatileab:versatile_defconfig:mem128:net,default:versatile-ab:initrd
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb0:mem128:net,default:imx25-pdk:rootfs
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb1:mem128:net,default:imx25-pdk:rootfs
	arm:realview-pb-a8:realview_defconfig:realview_pb:mem512:net,default:arm-realview-pba8:initrd
	arm:realview-pbx-a9:realview_defconfig:realview_pb:net,default:arm-realview-pbx-a9:initrd
	arm:realview-eb:realview_defconfig:realview_eb:mem512:net,default:arm-realview-eb:initrd
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

Details below.

Guenter

---
Build:

Building i386:tools/perf ... failed
Building x86_64:tools/perf ... failed

--------------
Error log:
In file included from tools/include/asm/../../arch/x86/include/asm/atomic.h:7,
                 from tools/include/asm/atomic.h:6,
                 from tools/include/linux/atomic.h:5,
                 from tools/include/linux/refcount.h:41,
                 from threadmap.c:4:
tools/include/asm/../../arch/x86/include/asm/atomic.h: In function ‘atomic_dec_and_test’:
tools/include/asm/../../arch/x86/include/asm/rmwcc.h:7:2: error: implicit declaration of function ‘asm_volatile_goto’

and many similar errors.

Bisect points to commit a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO").

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

Update: The final patch to fix this problem has been submitted. I'll need
to look it up.

--------

Various imx emulations hang in scsi_remove_host() during reboot when
booting from usb. Bisect points to the patch series at
https://lore.kernel.org/all/20220712221936.1199196-1-bvanassche@acm.org/

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
