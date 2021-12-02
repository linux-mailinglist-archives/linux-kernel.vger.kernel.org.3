Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38060465CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355180AbhLBD3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:29:44 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54915 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355130AbhLBD3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:29:43 -0500
Received: by mail-io1-f69.google.com with SMTP id s8-20020a056602168800b005e96bba1363so31519906iow.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 19:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=z0T2efZxmSLpyv4FIy8crz8WKCsBt1Kgoxfig+xCZf4=;
        b=b5AclxKE8oZkTg8LIDk1MMVnX4/Y5km28wewp8wBk5Mpw/DdpUEjqb8LrCnW6Cmawv
         ghWKe8KiGk1k6fR+eWBCp1Oz5za1Wh8H9ZCInfBAELUQWMqRubiZQGpilVTrQSf8N1hM
         BGgi+OMsAVkc2bCjagn4wWtLXfswXCZaH+hzZqaO/5wkEa3vC/2wYQPzR7Yyso1i3kp2
         fSn+us4OEZC7frwAAVfPraBigEOts6GVR0VTPuNv3/vmfmpvZXYfIJPryr3/Qpwdu+BO
         rN61dW0hv0iS2XVkfBQy5dF2RVen7HHpKv8+oLrnR3hWs4l/w00zroPTB8C2DXTyrk1A
         mIJw==
X-Gm-Message-State: AOAM531lZU2PhZhWEgJ77cgAA3WTFaEvD3U4L0w7+ERYSQRt5IXVdO++
        aW0K0wgSZpXHfTH+woPKlN6W5ih/YUDsArVdkSOx4IhHYlxe
X-Google-Smtp-Source: ABdhPJwOTBRVQBHoaYEJc0GVAZKHjoOO9xlvFFxcbCy60kBtu1YlEjtsemKxLJSHgVh+fYCOLr/iaiBbMJjQEEbM9mSOikhGvR/2
MIME-Version: 1.0
X-Received: by 2002:a05:6602:25d4:: with SMTP id d20mr14588466iop.72.1638415581676;
 Wed, 01 Dec 2021 19:26:21 -0800 (PST)
Date:   Wed, 01 Dec 2021 19:26:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd87fc05d2215a71@google.com>
Subject: [syzbot] WARNING in kernfs_get (3)
From:   syzbot <syzbot+07fe64297eacba9c7550@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f81e94e91878 Add linux-next specific files for 20211125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129e9f26b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
dashboard link: https://syzkaller.appspot.com/bug?extid=07fe64297eacba9c7550
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07fe64297eacba9c7550@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 27468 at fs/kernfs/dir.c:496 kernfs_get.part.0+0x69/0x80 fs/kernfs/dir.c:496
Modules linked in:
CPU: 0 PID: 27468 Comm: kworker/u4:12 Not tainted 5.16.0-rc2-next-20211125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:kernfs_get.part.0+0x69/0x80 fs/kernfs/dir.c:496
Code: 31 ff 89 ee e8 c8 a4 7d ff 85 ed 74 18 e8 9f a2 7d ff be 04 00 00 00 48 89 df e8 02 35 c8 ff f0 ff 03 5b 5d c3 e8 87 a2 7d ff <0f> 0b eb df 48 89 df e8 6b 31 c8 ff eb c6 66 0f 1f 84 00 00 00 00
RSP: 0018:ffffc900065af918 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88800011a1d0 RCX: 0000000000000000
RDX: ffff888087c6ba80 RSI: ffffffff81fa4259 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88800011a1d3
R10: ffffffff81fa4238 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88800011a1d0
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78c720a718 CR3: 0000000039c76000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kernfs_get fs/kernfs/dir.c:495 [inline]
 __kernfs_remove+0x2a8/0xab0 fs/kernfs/dir.c:1342
 kernfs_remove_by_name_ns+0x4f/0xa0 fs/kernfs/dir.c:1544
 kernfs_remove_by_name include/linux/kernfs.h:570 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:288
 sysfs_remove_groups fs/sysfs/group.c:312 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:304
 destroy_port drivers/infiniband/core/sysfs.c:1284 [inline]
 ib_free_port_attrs+0x162/0x460 drivers/infiniband/core/sysfs.c:1409
 remove_one_compat_dev drivers/infiniband/core/device.c:1001 [inline]
 rdma_dev_exit_net+0x2b2/0x550 drivers/infiniband/core/device.c:1139
 ops_exit_list+0xb0/0x160 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:593
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2299
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2446
 kthread+0x405/0x4f0 kernel/kthread.c:345
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
