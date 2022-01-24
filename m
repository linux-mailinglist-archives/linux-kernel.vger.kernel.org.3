Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767194987FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbiAXSMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiAXSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:12:44 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB2C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:12:43 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 10-20020a9d030a000000b0059f164f4a86so5906538otv.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2PU7e0hB7QCQwQCgLVGYuQdHRPXKjp8MMj2t/0WuM+w=;
        b=m4yUAa3Y4hrzZRWArTurSFf6ogWB8d7vIlzJ+i5po0YcoVoAE6iyAOxtyN85pahuBw
         MaxY56foRvBa+3MKpttC+10yhWm+bkghIzD7h/Pp4+yaRPMI2fpYOYcuvvNdwvxHYoE3
         3sKXSY2Vl6ZkBLgqqkih3mFiEM7fU1FTggaPhwPJkK6dNiNT+tENcNEm4gMkW86J17Yf
         gKcMAOl63l5z5hlStbfgznzQ/9jC0Nulu5V0DqFatKeqBDPfCCmdEKAQZ/Y8GVvO4B4k
         tJV0X6njeje6D3yKM4PGK/M7kRnNEssj1Y5RdoUrjhUEhigkJfZduXxJp2vxAcQK1x8H
         K8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2PU7e0hB7QCQwQCgLVGYuQdHRPXKjp8MMj2t/0WuM+w=;
        b=26N0Y0HkBvwJWUdvU5JWl+hMimjh9/reO8S3M6fnlWd39gUtjM+0RwWpadNo6gEVUI
         cBy2PorlDRpmjUYqFuX8BbOrzCq6nRU7GlyU2kcN54HvQOtBAVh6OuP1fFqo8q8DCtym
         XeIOQtkfJDzpfoWuRMfWxnW751y/y7yjn6ij+sw5JdFwh/AK9O+JwzLa//tMuTswMyYJ
         0tyMeIjzBE95o4/l2glZCTVMtB9D5DPcvi21NPkhcV1MEp291UX+9E9KH4YSebc16Hzv
         K9Uj+nm1FxQO7/0q7liObB9rkckVuhzFbd5k/PYj6P3yPSdaO68FWbv80dm04I7hAbCY
         aq/g==
X-Gm-Message-State: AOAM531TnnJArFTEaHpkPyk8FZOameRm+8hn1jniSAGpSD1thTLjXfpu
        FLFZ2+0bhsizqLgoQWDy5eSesJPX4LA=
X-Google-Smtp-Source: ABdhPJxKAbnrdLoSTUmERMEykBFC09kTcuE2l4gFOBmm9Tl7bf0a6+HFvX0jxzmvP/QMzYbNtVloFQ==
X-Received: by 2002:a9d:7d9a:: with SMTP id j26mr12701555otn.88.1643047963110;
        Mon, 24 Jan 2022 10:12:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4sm1633276otr.76.2022.01.24.10.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:12:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 24 Jan 2022 10:12:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.17-rc1
Message-ID: <20220124181240.GA3558349@roeck-us.net>
References: <CAHk-=whUYZvNVtNc4Xftd8aDpZzuwswBtHG4fCYQ2AC3twh_5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whUYZvNVtNc4Xftd8aDpZzuwswBtHG4fCYQ2AC3twh_5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:32:51AM +0200, Linus Torvalds wrote:
> I've tagged the rc1 release a couple of hours earlier than usual, and
> in a timezone 10 hours before the usual one, so this merge window was
> technically a bit shorter than usual. But if somebody didn't get their
> pull request in in time, they shouldn't have left it so late - and
> there's always 5.18. Never fear - we'll not run out of numbers.
> 
> I was nervous that this merge window would be more painful than usual
> due to my family-related travels, but I have to give thanks to people:
> a lot of you sent your pull requests early in the merge window, and
> while there were a couple of hiccups I hit early on, that was all
> before switching my main workstation to a laptop. Everything seems to
> have gone fairly smoothly.
> 
> Knock wood.
> 
> 5.17 doesn't seem to be slated to be a huge release, and everything
> looks fairly normal. We've got a bit more activity than usual in a
> couple of corners of the kernel (random number generator and the
> fscache rewrite stand out), but even with those things, the big
> picture view looks very much normal: the bulk is various driver
> updates, with architectures updates, documentation, and tooling being
> the bulk of the rest. Even with a total rewrite, that fscache diff
> looks more like a blip in the big picture.
> 
> And hey, it may not be a huge release, but the full shortlog would
> still be much too big to post - or scan through. So as is traditional,
> I'm just appending my mergelog as a highlevel view of what's been
> going on.
> 
> Please give it all a test,
> 

Test results are for v5.17-rc1-32-gdd81e1c7d5fb.

Build results:
	total: 153 pass: 149 fail: 4
Failed builds:
	arm:allmodconfig
	arm64:allmodconfig
	ia64:tinyconfig
	mips:allmodconfig
Qemu test results:
	total: 485 pass: 470 fail: 15
Failed tests:
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:mem256:net,nic:net,nic:imx6ul-14x14-evk:initrd
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:sd:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb0:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb1:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:mem256:net,nic:imx7d-sdb:initrd
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:usb1:mem256:net,nic:imx7d-sdb:rootfs
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:sd:mem256:net,nic:imx7d-sdb:rootfs
	arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs
	arm:ast2500-evb:aspeed_g5_defconfig:notests:usb:net,nic:aspeed-ast2500-evb:rootfs
	arm:ast2600-evb:aspeed_g5_defconfig:notests:usb:net,nic:aspeed-ast2600-evb:rootfs
	arm:tacoma-bmc:aspeed_g5_defconfig:notests:usb:net,nic:aspeed-bmc-opp-tacoma:rootfs
	arm:rainier-bmc:aspeed_g5_defconfig:notests:usb:net,nic:aspeed-bmc-ibm-rainier:rootfs
	riscv:sifive_u:defconfig:net,default:initrd
	riscv:sifive_u:defconfig:sd:net,default:rootfs
	riscv:sifive_u:defconfig:mtd32:net,default:rootfs

arm:allmodconfig:

drivers/usb/gadget/udc/at91_udc.c: In function 'at91udc_probe':
drivers/usb/gadget/udc/at91_udc.h:174:42: error: format '%d' expects argument of type 'int', but argument 3 has type 'struct gpio_desc *' [-Werror=format=]
  174 | #define DBG(stuff...)           pr_debug("udc: " stuff)

arm64:allmodconfig:

drivers/pinctrl/pinctrl-thunderbay.c: In function 'thunderbay_add_functions':
drivers/pinctrl/pinctrl-thunderbay.c:815:29: error: assignment discards 'const' qualifier from pointer target type
  815 |                         grp = func->group_names;
      |                             ^

ia64:tinyconfig:

ia64-linux-ld: drivers/acpi/scan.o: in function `__acpi_device_add':
scan.c:(.text+0x27e2): undefined reference to `crc32_le'

mips:allmodconfig:

In file included from sound/pci/ca0106/ca0106_main.c:156:
sound/pci/ca0106/ca0106.h:62: error: "PTR" redefined [-Werror]
   62 | #define PTR                     0x00
In file included from arch/mips/include/asm/bitops.h:19,
                 from include/linux/bitops.h:33,
                 from include/linux/log2.h:12,
                 from include/asm-generic/div64.h:55,
                 from arch/mips/include/asm/div64.h:89,
                 from include/linux/math.h:5,
                 from include/linux/delay.h:22,
                 from sound/pci/ca0106/ca0106_main.c:124:
arch/mips/include/asm/asm.h:288: note: this is the location of the previous definition
  288 | #define PTR             .word

Runtime problems:

arm:mcimx6ul-evk and arm:mcimx7d-sabre emulations crash because they are out
of memory with 256MB of memory provided. This is with

Memory: 156260K/262144K available (16384K kernel code, 2139K rwdata, 5860K rodata, 1024K init, 6707K bss, 40348K reserved, 65536K cma-reserved, 0K highmem)

suggesting that something needs a lot of memory.

---

arm:orangepi-pc fails to boot from its second USB interface.

---

riscv64:sifive_u boot tests report a soft lockup during reboot.

[   53.678772] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [init:203]
[   53.679185] Modules linked in:
[   53.679474] irq event stamp: 14778
[   53.679629] hardirqs last  enabled at (14777): [<ffffffff800035b8>] restore_all+0xe/0x66
[   53.679965] hardirqs last disabled at (14778): [<ffffffff800034d2>] _save_context+0x7c/0xde
[   53.680215] softirqs last  enabled at (14766): [<ffffffff80924648>] __do_softirq+0x3e0/0x51a
[   53.680476] softirqs last disabled at (14757): [<ffffffff80013f5c>] __irq_exit_rcu+0xae/0xe4
[   53.680843] CPU: 0 PID: 203 Comm: init Not tainted 5.17.0-rc1-00032-gdd81e1c7d5fb #1
[   53.681169] Hardware name: SiFive HiFive Unleashed A00 (DT)
[   53.681480] epc : machine_halt+0x20/0x26
[   53.681716]  ra : kernel_halt+0x56/0x5e
[   53.681911] epc : ffffffff8000444c ra : ffffffff80032644 sp : ffff8f8004163d70
[   53.682139]  gp : ffffffff815d8750 tp : ffffaf80048d0040 t0 : ffffffff815db3dc
[   53.682373]  t1 : 000000001f3a0e58 t2 : ffffffff815db3e4 s0 : ffff8f8004163d80
[   53.682608]  s1 : 000000004321fedc a0 : 0000000000006000 a1 : 0000000000001fff
[   53.682833]  a2 : ffffffff815eb920 a3 : 0000000000000000 a4 : 0000000000000000
[   53.683064]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 000000001e1f2036
[   53.683308]  s2 : 0000000028121969 s3 : ffffffff8141acd8 s4 : fffffffffee1dead
[   53.683525]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 00000000000000e0
[   53.683747]  s8 : 00007fff9b08dca0 s9 : 00007fff9b088a50 s10: 0000000000000000
[   53.683974]  s11: 0000000000000000 t3 : 000000000000000e t4 : 0000000001b00000
[   53.684188]  t5 : ffffffff8141a360 t6 : 0000000000000006
[   53.684383] status: 0000000000000120 badaddr: 0000000000000000 cause: 8000000000000005
[   53.684679] [<ffffffff8000444c>] machine_halt+0x20/0x26
[   53.684937] [<ffffffff800328fa>] __do_sys_reboot+0x1c0/0x1f0
[   53.685150] [<ffffffff8003293c>] sys_reboot+0x12/0x1a
[   53.685350] [<ffffffff80003578>] ret_from_syscall+0x0/0x2

---

i386:q35:pentium3:defconfig:pae:nosmp:nvme:net,i82562:hd reports a warning backtrace.

[   14.388284] ------------[ cut here ]------------
[   14.388445] WARNING: CPU: 0 PID: 7 at drivers/pci/msi/msi.c:1114 pci_irq_get_affinity+0x80/0x90
[   14.388675] Modules linked in:
[   14.388999] CPU: 0 PID: 7 Comm: kworker/u2:0 Not tainted 5.17.0-rc1-00032-gdd81e1c7d5fb #1
[   14.389230] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[   14.389598] Workqueue: nvme-reset-wq nvme_reset_work
[   14.389934] EIP: pci_irq_get_affinity+0x80/0x90
[   14.390098] Code: e8 05 ae ae ff 85 c0 75 bd 90 0f 0b 31 c0 5b 5e 5d c3 8d b4 26 00 00 00 00 90 5b b8 a4 a7 9f c9 5e 5d c3 8d b4 26 00 00 00 00 <0f> 0b eb e0 8d b4 26 00 00 00 00 8d 74 26 00 90 55 89 e5 57 56 53
[   14.390536] EAX: 00000000 EBX: c18d2000 ECX: 00000000 EDX: c2948810
[   14.390695] ESI: 00000001 EDI: c18d2000 EBP: c1255e1c ESP: c1255e14
[   14.390938] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00000246
[   14.391115] CR0: 80050033 CR2: ffbff000 CR3: 09aca000 CR4: 000006f0
[   14.391324] Call Trace:
[   14.391670]  blk_mq_pci_map_queues+0x26/0x70
[   14.391952]  nvme_pci_map_queues+0x75/0xc0
[   14.392094]  blk_mq_update_queue_map+0x86/0xa0
[   14.392218]  blk_mq_alloc_tag_set+0xf3/0x390
[   14.392330]  ? nvme_wait_freeze+0x3d/0x50
[   14.392452]  nvme_reset_work+0xd32/0x1160
[   14.392616]  ? __this_cpu_preempt_check+0x8/0x10
[   14.392946]  process_one_work+0x1ed/0x490
[   14.393116]  worker_thread+0x15e/0x3c0
[   14.393249]  kthread+0xd3/0x100
[   14.393342]  ? process_one_work+0x490/0x490
[   14.393452]  ? kthread_complete_and_exit+0x20/0x20
[   14.393582]  ret_from_fork+0x1c/0x28

This backtrace is only seen with nosmp configurations; PAE does not
have to be enabled.

I'll bisect the runtime problems and report separately.

Guenter
