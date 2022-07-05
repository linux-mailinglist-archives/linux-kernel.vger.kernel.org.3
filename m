Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF55661DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiGEDa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiGEDaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:30:24 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64D11A1E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 20:30:23 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s7-20020a056e021a0700b002dc1d76b2easo1097951ild.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 20:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ynRC0sSNdaIF1+UHlgNLr18vUL3idRfXFywroLUCYAo=;
        b=hvZPEftOVpzTAmGc6tSNJtmiDxKbqZQyJfw7npdFRbS4xKmemBXrz/kiI0OSkqsWHh
         yK30Pv0BE9AzQuZT1p8SnzvgXJ/sSbQhomJmXF/tJi6Mm9P/D9h8IZAxkEwXZ3RFVPaz
         CvF32oQKy4D/WBqAELmCcHXAOdC8fMY1o9cp77TG0uah+39Kqg1/llKCqQIPcRJLoo+v
         Wo+tIAM03IMHR0mMw4RqD2ajvHfmi6aA1gnH6XFLsknYrH01V/hLeYIWcpYSsO37hRcP
         93iDwEG9hdsM+BjjJvmBeFUQzXNzMSm92pRORzoOCDfrgybWQIu1vk0mu6b9QNnN5ubw
         hPvw==
X-Gm-Message-State: AJIora9AEVwjw8AqEL1C1Z9SbDKiqOQBdgcObvqrEVz4gyhLtLREGLQK
        NVpvXQqhgo2fagBsySxJxlGjDtciXbUhT8ogaS+oGBTSd8Yp
X-Google-Smtp-Source: AGRyM1sKbP4p8bAEF6c10sUWkv/ZtZLd7fLBs/X+LiBlTtKuDiwuh/oKzvAQ9qKg5/iPJotKU0K4qEgvEPrAdjWmyjR+SYdt92wb
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144d:b0:2da:b8f7:402a with SMTP id
 p13-20020a056e02144d00b002dab8f7402amr18234924ilo.178.1656991822474; Mon, 04
 Jul 2022 20:30:22 -0700 (PDT)
Date:   Mon, 04 Jul 2022 20:30:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f978d305e3067837@google.com>
Subject: [syzbot] WARNING in send_packet/usb_submit_urb
From:   syzbot <syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, sean@mess.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1a0e93df1e10 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14135814080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=0c3cb6dc05fbbdc3ad66
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d12414080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1231e6f0080000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10febf98080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12febf98080000
console output: https://syzkaller.appspot.com/x/log.txt?x=14febf98080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com

------------[ cut here ]------------
URB ffff888016985200 submitted while active
WARNING: CPU: 0 PID: 3621 at drivers/usb/core/urb.c:378 usb_submit_urb+0x14e2/0x18a0 drivers/usb/core/urb.c:378
Modules linked in:
CPU: 0 PID: 3621 Comm: syz-executor844 Not tainted 5.19.0-rc4-syzkaller-00044-g1a0e93df1e10 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/18/2022
RIP: 0010:usb_submit_urb+0x14e2/0x18a0 drivers/usb/core/urb.c:378
Code: 89 de e8 01 bf ee fb 84 db 0f 85 a9 f3 ff ff e8 f4 c2 ee fb 4c 89 fe 48 c7 c7 80 ef 6e 8a c6 05 d1 14 1b 08 01 e8 1d 8b a6 03 <0f> 0b e9 87 f3 ff ff 41 be ed ff ff ff e9 7c f3 ff ff e8 c7 c2 ee
RSP: 0018:ffffc90002f8fd40 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801dd08000 RSI: ffffffff8160cfb8 RDI: fffff520005f1f9a
RBP: ffff8880214eba00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888016985200
R13: ffff88801722a128 R14: 00000000fffffff0 R15: ffff888016985200
FS:  00007f5133ccc700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5133ccc718 CR3: 0000000070f6b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 send_packet+0x422/0xbc0 drivers/media/rc/imon.c:642
 vfd_write+0x2d9/0x550 drivers/media/rc/imon.c:991
 vfs_write+0x269/0xac0 fs/read_write.c:589
 ksys_write+0x127/0x250 fs/read_write.c:644
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f5133d400b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5133ccc318 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5133dc44d8 RCX: 00007f5133d400b9
RDX: 0000000000000001 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007f5133dc44d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007f5133ccc700 R11: 0000000000000246 R12: ab0847687fc4f2a2
R13: 00007ffe90898ecf R14: 00007f5133ccc400 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
