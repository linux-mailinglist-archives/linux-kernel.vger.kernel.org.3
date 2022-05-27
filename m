Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A0535814
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbiE0Dj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiE0DjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:39:22 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6316557
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:39:20 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id b13-20020a92c56d000000b002d125a2ab95so2321712ilj.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CbgmDYSLsmbeCmm9RIC3R+sTBJbYG3oF2mSfvudPXkE=;
        b=d1NL74GixMAZ3TW4j9nganYHgkxtrzeLUCAoY552lltfwuobEvuNTzkSq+4Bh1cNGo
         LHTWcZt2yqjeh/xQerc5lC9BQHfLzDDEU5b0boGj72KWhCNPQArGh/bAQARlioh+fAJS
         mTdrt8CSrXjv9IPCzLvGjpA9Ya+FOQc4wp5Xmm3dGGPOSuypLDvy1jDPmHkDTFhvwqDZ
         9M0HgDOgd23ATVoXsrVldX9/33Kv1BNakyAkZ43ZNaynqYxre6fQUzpTWb9LQfLMhQJX
         z3c9t4nJo5GAfCjrXMVYpZgepPKsPTN7SgdlO9k/El/uA9eJICTxjDQM7mIBUDwRkTvV
         p24w==
X-Gm-Message-State: AOAM532FQkuKoTvtQFIsWUw8T59VHhvMFPkWf/JL7lNyLCJ77op8MOyV
        CfdixFDOd1X9ovr+xx5wysCwR1JVmv4fSQWs/d5zqiKt9ilD
X-Google-Smtp-Source: ABdhPJzllylfqbbGCo/rixmvjSkzNOiB6i7ltnRRWPdVDCjGUbR47zRA75sLjX+/qxGBprHzlT+rW/gNO07B2+HJU7f868kUklL2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:2d3:789a:58a with SMTP id
 v6-20020a056e02164600b002d3789a058amr352292ilu.197.1653622760339; Thu, 26 May
 2022 20:39:20 -0700 (PDT)
Date:   Thu, 26 May 2022 20:39:20 -0700
In-Reply-To: <00000000000085bef105dd398c3d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039009305dff60da4@google.com>
Subject: Re: [syzbot] WARNING in __floppy_read_block_0
From:   syzbot <syzbot+bac6723617710898abd3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    babf0bb978e3 Merge tag 'xfs-5.19-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1256f1d3f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb7a468cb4ea251
dashboard link: https://syzkaller.appspot.com/bug?extid=bac6723617710898abd3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1107de15f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1104a36df00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bac6723617710898abd3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3673 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 1 PID: 3673 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 1 PID: 3673 at drivers/block/floppy.c:999 __floppy_read_block_0.isra.0+0x292/0x330 drivers/block/floppy.c:4160
Modules linked in:
CPU: 1 PID: 3673 Comm: syz-executor234 Not tainted 5.18.0-syzkaller-07857-gbabf0bb978e3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:__floppy_read_block_0.isra.0+0x292/0x330 drivers/block/floppy.c:4160
Code: 84 24 b8 01 00 00 65 48 2b 04 25 28 00 00 00 0f 85 a0 00 00 00 48 81 c4 c0 01 00 00 5b 5d 41 5c 41 5d 41 5e c3 e8 9e 76 e1 fc <0f> 0b e9 5a ff ff ff e8 62 bc 2d fd e9 7c fe ff ff e8 88 76 e1 fc
RSP: 0018:ffffc90002b3f6a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff92000567ed4 RCX: 0000000000000000
RDX: ffff888015c3bb00 RSI: ffffffff849851d2 RDI: 0000000000000003
RBP: ffffea000068d3c0 R08: 0000000000000000 R09: ffffffff8c8e8b47
R10: ffffffff8498512a R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802cb00000(0063) knlGS:00000000570f32c0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7f88ca8 CR3: 0000000018139000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_revalidate.isra.0+0x801/0xae0 drivers/block/floppy.c:4206
 floppy_open+0xac5/0xd70 drivers/block/floppy.c:4058
 blkdev_get_whole+0x99/0x2d0 block/bdev.c:673
 blkdev_get_by_dev.part.0+0x5ec/0xb90 block/bdev.c:823
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:857
 blkdev_open+0x13c/0x2c0 block/fops.c:481
 do_dentry_open+0x4a1/0x11e0 fs/open.c:824
 do_open fs/namei.c:3477 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3610
 do_filp_open+0x1aa/0x400 fs/namei.c:3637
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1213
 do_sys_open fs/open.c:1229 [inline]
 __do_compat_sys_openat fs/open.c:1289 [inline]
 __se_compat_sys_openat fs/open.c:1287 [inline]
 __ia32_compat_sys_openat+0x13f/0x1f0 fs/open.c:1287
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x53/0x62
RIP: 0023:0xf7f15549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffb136c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000ffb13710
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000f7fbe000
RBP: 0000000066666667 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

