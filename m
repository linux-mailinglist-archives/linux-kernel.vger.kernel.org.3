Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124B54D7DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiCNIr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCNIr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:47:27 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB23A5F8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:46:18 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y3-20020a056602178300b00645d25c30c1so11802102iox.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iDERiaxOeM52K2KOtaDNsxpyia3UF8paSxXwnZxS/hk=;
        b=CXCsm8Ngmagbae4TNWhfrATcLpTh0rS2fMOTSTlzeYSWvnqgc2iKTxEncnKupYJ1Up
         h2FFOmr/oii2nNXoo9NjAMqmf45a+1bD+jRgHQqw9v8bCAjwaKdXQy6S3EBggb28L5Q+
         f0ZaKYRjZmaCl5Nw3ER2RUEeKQYhW1vEInDDTtFYoR/RZg95qR2ekqn9vKZ7aymffDa/
         WXU6N0kOixu3wU/pjONmlDk6PYQ+TYBELCQaSn/s+miQVbtfm8RxhOnQprHBgg1Ut18s
         PBn2hj+FGH0qHqmgGQzoAlL8NVTYmaZN0i8MdqCWx6MZcH5CzWpojeeOvxRdPJ+RxZsT
         5jkQ==
X-Gm-Message-State: AOAM5323w87hV7yHuNIF7FJ52iQeIkGVmRjucGoZmLV/5hqMyh1v8HTE
        UXfgs4ZKCgObPTX9LzPZ8h1QQ/EpgW3kkOzt+TsnkY0fQPnL
X-Google-Smtp-Source: ABdhPJylKLuaVwo+1DCS35SUR4T4Ev9NJOnv8dUEnUY9HmDSzvz9EHVijKk7r0ecyfXjqdGagYF7kRl7cHrua+Vzw2NNVVBZ//6Q
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2686:b0:319:acb4:46e6 with SMTP id
 o6-20020a056638268600b00319acb446e6mr19121883jat.231.1647247577807; Mon, 14
 Mar 2022 01:46:17 -0700 (PDT)
Date:   Mon, 14 Mar 2022 01:46:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb7f1c05da29b601@google.com>
Subject: [syzbot] general protection fault in __device_attach
From:   syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e7e19defa575 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ea76f6700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3c97de244683533381
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd3c97de244683533381@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 1 PID: 14569 Comm: syz-executor.4 Not tainted 5.17.0-rc7-syzkaller-00068-ge7e19defa575 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__device_attach+0xad/0x4a0 drivers/base/dd.c:949
Code: e8 03 42 80 3c 20 00 0f 85 a3 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 48 49 8d bc 24 08 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 6e 03 00 00 45 0f b6 b4 24 08 01 00
RSP: 0018:ffffc90010a87b98 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 1ffff92002150f74 RCX: 0000000000000000
RDX: 0000000000000021 RSI: 0000000000000008 RDI: 0000000000000108
RBP: ffff88807829d030 R08: 0000000000000000 R09: ffffc90010a87ad7
R10: fffff52002150f5a R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000fffffff0 R15: ffff88807829d140
FS:  00007f7048b3e700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f704a2dd090 CR3: 0000000074ae3000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 proc_ioctl.part.0+0x48e/0x560 drivers/usb/core/devio.c:2340
 proc_ioctl drivers/usb/core/devio.c:170 [inline]
 proc_ioctl_compat drivers/usb/core/devio.c:2389 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2705 [inline]
 usbdev_ioctl+0xc01/0x36c0 drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f704a1c9049
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7048b3e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f704a2dbf60 RCX: 00007f704a1c9049
RDX: 0000000020000000 RSI: 00000000c00c5512 RDI: 0000000000000003
RBP: 00007f704a22308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc683ba24f R14: 00007f7048b3e300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__device_attach+0xad/0x4a0 drivers/base/dd.c:949
Code: e8 03 42 80 3c 20 00 0f 85 a3 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 48 49 8d bc 24 08 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 6e 03 00 00 45 0f b6 b4 24 08 01 00
RSP: 0018:ffffc90010a87b98 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 1ffff92002150f74 RCX: 0000000000000000
RDX: 0000000000000021 RSI: 0000000000000008 RDI: 0000000000000108
RBP: ffff88807829d030 R08: 0000000000000000 R09: ffffc90010a87ad7
R10: fffff52002150f5a R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000fffffff0 R15: ffff88807829d140
FS:  00007f7048b3e700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0b074ee1b8 CR3: 0000000074ae3000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	e8 03 42 80 3c       	callq  0x3c804208
   5:	20 00                	and    %al,(%rax)
   7:	0f 85 a3 03 00 00    	jne    0x3b0
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	4c 8b 65 48          	mov    0x48(%rbp),%r12
  1b:	49 8d bc 24 08 01 00 	lea    0x108(%r12),%rdi
  22:	00
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 06                	je     0x38
  32:	0f 8e 6e 03 00 00    	jle    0x3a6
  38:	45                   	rex.RB
  39:	0f                   	.byte 0xf
  3a:	b6 b4                	mov    $0xb4,%dh
  3c:	24 08                	and    $0x8,%al
  3e:	01 00                	add    %eax,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
