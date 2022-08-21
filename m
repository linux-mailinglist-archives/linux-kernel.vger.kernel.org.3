Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375559B1C1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 06:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiHUEo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 00:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHUEo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 00:44:26 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053F21408D
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:44:25 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i13-20020a056e02152d00b002e97839ff00so1725864ilu.15
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=VHKZiUFvVveW+ZNFOk9sw/xMqdpjBk9d4cmaGhKiFD0=;
        b=WhsXD8DX13FKUOki7DOWRmAFhl85mkLrjXFSpmYapL7tBjLGSSlEPb7GsJ0UMlMh9j
         e2rX4QojGHrQnphDQaZfk4KFwjJyuvCIG5wGgSFqj//MSr3VjdIn9rY0X2gFr8cae772
         EiQ8Qp9KFmpvYH9WX0zNXCLlH86ipOeG3S+1A1JumclIUwWNh5anM5r/2gF1SRMFCr2Z
         8qGe4zUYi0Y+j3nYUnzeNC91OU5JRZlUQbpwla4aJNPcDbrhmTIwzQQNWCozv7/qn9Bq
         Yvhxv9bdh6NP7cBbqfnacTCx7jPYRWVkKqlnj/rtBxjB7zGHVaOjynzhXSTYKmBTIjGh
         dsqg==
X-Gm-Message-State: ACgBeo1cs6kAjIPUUp5zKx+DJdhZPk0OnOpI3ooFzr171+HyBR45iIwv
        fUXqYJPV/zJQ6W+1gnb2QIva7vetgAvuUStVsBWGPUxCHSru
X-Google-Smtp-Source: AA6agR6dtEaFlYT6hOdJ6l253kXiqOh9Y5K9TDV9VYT4WbwC/St+hwLWPADxZUftmTjdsI80CXfylLzcqqPH/T0KhVbSzgBS3nxk
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c9:b0:2df:1c38:94c3 with SMTP id
 i9-20020a056e0212c900b002df1c3894c3mr6813987ilm.62.1661057064372; Sat, 20 Aug
 2022 21:44:24 -0700 (PDT)
Date:   Sat, 20 Aug 2022 21:44:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046101a05e6b8fc53@google.com>
Subject: [syzbot] upstream boot error: general protection fault in usb_set_configuration
From:   syzbot <syzbot+86cb6a0f6d50dbe4ff23@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3cc40a443a04 Merge tag 'nios2_fixes_v6.0' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130a0067080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=86cb6a0f6d50dbe4ff23
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+86cb6a0f6d50dbe4ff23@syzkaller.appspotmail.com

hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
dummy_hcd dummy_hcd.1: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.1: Dummy host controller
dummy_hcd dummy_hcd.1: new USB bus registered, assigned bus number 2
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Dummy host controller
usb usb2: Manufacturer: Linux 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 dummy_hcd
usb usb2: SerialNumber: dummy_hcd.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
dummy_hcd dummy_hcd.2: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.2: Dummy host controller
dummy_hcd dummy_hcd.2: new USB bus registered, assigned bus number 3
usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: Dummy host controller
usb usb3: Manufacturer: Linux 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 dummy_hcd
usb usb3: SerialNumber: dummy_hcd.2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
dummy_hcd dummy_hcd.3: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.3: Dummy host controller
dummy_hcd dummy_hcd.3: new USB bus registered, assigned bus number 4
usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: Dummy host controller
usb usb4: Manufacturer: Linux 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 dummy_hcd
usb usb4: SerialNumber: dummy_hcd.3
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
dummy_hcd dummy_hcd.4: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.4: Dummy host controller
dummy_hcd dummy_hcd.4: new USB bus registered, assigned bus number 5
usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: Dummy host controller
usb usb5: Manufacturer: Linux 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 dummy_hcd
usb usb5: SerialNumber: dummy_hcd.4
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 1 port detected
dummy_hcd dummy_hcd.5: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.5: Dummy host controller
dummy_hcd dummy_hcd.5: new USB bus registered, assigned bus number 6
usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: Dummy host controller
usb usb6: Manufacturer: Linux 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 dummy_hcd
usb usb6: SerialNumber: dummy_hcd.5
general protection fault, probably for non-canonical address 0xffff000000000800: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000004000-0xfff8200000004007]
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x164/0x3e0 mm/slub.c:3282
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 bf 01 00 00 48 85 c0 0f 84 b6 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 c2 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc90000067008 EFLAGS: 00010246
RAX: ffff000000000000 RBX: 0000000000000000 RCX: 0000000000000800
RDX: 0000000000006649 RSI: 0000000000000dc0 RDI: 000000000003dce0
RBP: ffff888011842140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000dc0 R14: 0000000000000a20 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000bc8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kobject_uevent_env+0x230/0x1640 lib/kobject_uevent.c:524
 device_add+0xb72/0x1e90 drivers/base/core.c:3498
 usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd4/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:609
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:748
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
 __device_attach_driver+0x206/0x2e0 drivers/base/dd.c:901
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:973
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
 register_root_hub+0x421/0x573 drivers/usb/core/hcd.c:1017
 usb_add_hcd.cold+0x100c/0x13a1 drivers/usb/core/hcd.c:2998
 dummy_hcd_probe+0x19f/0x310 drivers/usb/gadget/udc/dummy_hcd.c:2676
 platform_probe+0xfc/0x1f0 drivers/base/platform.c:1400
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:609
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:748
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
 __device_attach_driver+0x206/0x2e0 drivers/base/dd.c:901
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:973
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 platform_device_add+0x35e/0x820 drivers/base/platform.c:717
 dummy_hcd_init+0x5d5/0xba7 drivers/usb/gadget/udc/dummy_hcd.c:2829
 do_one_initcall+0xfe/0x650 init/main.c:1296
 do_initcall_level init/main.c:1369 [inline]
 do_initcalls init/main.c:1385 [inline]
 do_basic_setup init/main.c:1404 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1611
 kernel_init+0x1a/0x1d0 init/main.c:1500
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x164/0x3e0 mm/slub.c:3282
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 bf 01 00 00 48 85 c0 0f 84 b6 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 c2 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc90000067008 EFLAGS: 00010246
RAX: ffff000000000000 RBX: 0000000000000000 RCX: 0000000000000800
RDX: 0000000000006649 RSI: 0000000000000dc0 RDI: 000000000003dce0
RBP: ffff888011842140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000dc0 R14: 0000000000000a20 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 51 08             	mov    0x8(%rcx),%edx
   3:	48 8b 01             	mov    (%rcx),%rax
   6:	48 83 79 10 00       	cmpq   $0x0,0x10(%rcx)
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	0f 84 bf 01 00 00    	je     0x1d5
  16:	48 85 c0             	test   %rax,%rax
  19:	0f 84 b6 01 00 00    	je     0x1d5
  1f:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
  23:	8b 4d 28             	mov    0x28(%rbp),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 c2 01 00 00    	jne    0x1f6
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
