Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28228574D26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbiGNMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiGNMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:11:02 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087E361705
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:09:21 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9-20020a056e020b2900b002dc6c27849cso991618ilu.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=t/JWl1auGyP7dRyKdtQPk8LnN5k4DzbxUNSFwRTHcRc=;
        b=J3YN/lywk/V4ZMpbuwTguHNe85TZ0fpL5wbQajX4l7FJ+7gaPXX+5zugfG6i6YJpHD
         aBUczrAR8dve1Z8kXs12sDUg6oaB8l38Tdwc6cw08rn+Vqjw62uejFgGZRRv9NtEqzDJ
         /cGrlZLZbDxh8ZCXKp15SNjVkeRlgCr4CI7sTxP1Lgfl2ydAM20g7+rEtd4AJBt6CtA+
         Ib9BDSzK9WmJ+8PaJP8oyN7nNuwDbxWuk8pYqqn4YZ2guWm84hEZif9ngWPpDtkRbSde
         n64Cqgl6d2FMVTtSIgd03n4Vdjgi/KXznNlrnVjqH/wWNqlclHctOLURHzhK9yLtm31M
         JZWQ==
X-Gm-Message-State: AJIora/vVnjLoafroZLnnPncE9m4brdb3pxRvl3AdySdPpu2xPoGqt7T
        2jGcyMtqlp39nHb8MJ4TDNpWMDZNAFqkaA2mYSTZ4Baudo7z
X-Google-Smtp-Source: AGRyM1sTlC5YxlWad4CIcwPM0BAjCa6kn9Q4apd6Q8FX/P5y4kUB3LiO16/GSg+78SxoJZg3a6S6HaTkduM5iE0i1VJFzRxvXxhf
MIME-Version: 1.0
X-Received: by 2002:a02:940a:0:b0:33c:b3f9:3e7f with SMTP id
 a10-20020a02940a000000b0033cb3f93e7fmr4586868jai.287.1657800561085; Thu, 14
 Jul 2022 05:09:21 -0700 (PDT)
Date:   Thu, 14 Jul 2022 05:09:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d55fe05e3c2c57c@google.com>
Subject: [syzbot] WARNING in r8712_usb_write_mem/usb_submit_urb
From:   syzbot <syzbot+6716435e45f2b68f32fa@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wanngchenng@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8affe37c525d usb: dwc3: gadget: fix high speed multiplier ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14260cac080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebec88088cc2071
dashboard link: https://syzkaller.appspot.com/bug?extid=6716435e45f2b68f32fa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6716435e45f2b68f32fa@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 1217 at drivers/usb/core/urb.c:502 usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
Modules linked in:
CPU: 0 PID: 1217 Comm: dhcpcd Not tainted 5.19.0-rc4-syzkaller-00118-g8affe37c525d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
Code: 7c 24 18 e8 a0 32 8f fd 48 8b 7c 24 18 e8 76 46 18 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 80 1c a9 86 e8 ee d0 09 02 <0f> 0b e9 58 f8 ff ff e8 72 32 8f fd 48 81 c5 b8 05 00 00 e9 84 f7
RSP: 0018:ffffc900010576d0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8881130ed580 RSI: ffffffff812c0fe8 RDI: fffff5200020aecc
RBP: ffff88811d9fd0f0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000003
R13: ffff8881382359b0 R14: 0000000000000003 R15: ffff888110529b00
FS:  00007f9441e74740(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd7323da70 CR3: 0000000118d80000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 r8712_usb_write_mem+0x2e0/0x3e0 drivers/staging/rtl8712/usb_ops_linux.c:177
 rtl8712_dl_fw+0x8b8/0xe20 drivers/staging/rtl8712/hal_init.c:203
 rtl8712_hal_init drivers/staging/rtl8712/hal_init.c:330 [inline]
 rtl871x_hal_init+0xae/0x180 drivers/staging/rtl8712/hal_init.c:394
 netdev_open+0xe6/0x690 drivers/staging/rtl8712/os_intfs.c:379
 __dev_open+0x2c4/0x4d0 net/core/dev.c:1432
 __dev_change_flags+0x583/0x750 net/core/dev.c:8533
 dev_change_flags+0x93/0x170 net/core/dev.c:8604
 devinet_ioctl+0x15d1/0x1ca0 net/ipv4/devinet.c:1146
 inet_ioctl+0x1e6/0x320 net/ipv4/af_inet.c:968
 sock_do_ioctl+0xcc/0x230 net/socket.c:1169
 sock_ioctl+0x2f1/0x640 net/socket.c:1286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9441f620e7
Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 9d 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc7f6121f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9441e746c8 RCX: 00007f9441f620e7
RDX: 00007ffc7f6223e8 RSI: 0000000000008914 RDI: 0000000000000005
RBP: 00007ffc7f632598 R08: 00007ffc7f6223a8 R09: 00007ffc7f622358
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc7f6223e8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
