Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D365E5525D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbiFTUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiFTUch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:32:37 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A76183A5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:32:34 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g8-20020a92cda8000000b002d15f63967eso7968949ild.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3ml99mZhJ0I2jClELE5maZ4iojISOaF0nhZnt18THYY=;
        b=kGclfN87/tQ9aC6fyfgTZXm2O6IwurzPHBJKVAD+iaTWZR3ppagR1sZZueE3SB6yWN
         G5VyI+QeWyQ2fuDTvVkTpoNjsXO0QQznV5vC+Iz5teV9rKXyD8THr0RbWfH5NXv+cVkX
         21Fx+BWczKJ9IwFAT/O81LIXfQ0h+RBLemywwnoooAOgg7K1Flrmr0zqwyK6UznEjxMf
         WHzoSgh7VLsQFUnBcMkKs8hI9lRFDXwL0/YPsmlFNu5N/dcnu9YMx3l4zYMyrkAS4BvB
         VTRjEwlHsBNGJ/A1dgPxROgG6FWgVuoXGsBi2TfUPKCHlUxDb4RQHgCZ+m3p1bJB/Luo
         kRaA==
X-Gm-Message-State: AJIora8apx2TAMWqEe5j5DsJavLD7+4jNBKP1WwQO9lPAWVSYJRt6Mam
        tNInTqwYpCL2aPMUPCf10woqfhYRWvR+CUnXUMm/FUOHssNj
X-Google-Smtp-Source: AGRyM1upGG3HYHjST/ghrso84riaCab6+4QfvKcziGLZcWY7ke6IlkrGR+QbOYnJGqsTgivjdRWeMOt1aqfHExSl1t74OvN49GT4
MIME-Version: 1.0
X-Received: by 2002:a6b:ba43:0:b0:669:a9b2:48fb with SMTP id
 k64-20020a6bba43000000b00669a9b248fbmr12841289iof.125.1655757154206; Mon, 20
 Jun 2022 13:32:34 -0700 (PDT)
Date:   Mon, 20 Jun 2022 13:32:34 -0700
In-Reply-To: <000000000000f5181405dff90d7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002cd4005e1e70131@google.com>
Subject: Re: [syzbot] WARNING in floppy_queue_rq
From:   syzbot <syzbot+334c1c7dfb084b11520e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    a111daf0c53a Linux 5.19-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c2fe60080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25cca39874d6b55f
dashboard link: https://syzkaller.appspot.com/bug?extid=334c1c7dfb084b11520e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153429f8080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+334c1c7dfb084b11520e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 793 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 2 PID: 793 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 2 PID: 793 at drivers/block/floppy.c:999 floppy_queue_rq+0x32b/0x390 drivers/block/floppy.c:2879
Modules linked in:
CPU: 2 PID: 793 Comm: kworker/2:1H Not tainted 5.19.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:floppy_queue_rq+0x32b/0x390 drivers/block/floppy.c:2879
Code: ea 03 80 3c 02 00 75 67 48 8b 56 30 48 c7 c7 e0 9d 42 8a e8 40 f3 97 04 0f 0b 41 bc 0a 00 00 00 e9 36 ff ff ff e8 b5 69 e0 fc <0f> 0b e9 ec fe ff ff 48 89 df e8 46 2e 2d fd e9 ee fc ff ff 48 89
RSP: 0018:ffffc900042a7928 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801bce0000 RSI: ffffffff849a0bcb RDI: 0000000000000007
RBP: ffffffff8c8f2a20 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88801c30c188
R13: ffff88801c30c140 R14: ffffc900042a7b68 R15: ffff88801c30c188
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f6f5b024 CR3: 000000001c2ba000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_mq_dispatch_rq_list+0x6ea/0x2350 block/blk-mq.c:1896
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
 blk_mq_do_dispatch_sched+0x96d/0xc30 block/blk-mq-sched.c:187
 __blk_mq_sched_dispatch_requests+0x26d/0x3e0 block/blk-mq-sched.c:313
 blk_mq_sched_dispatch_requests+0x101/0x180 block/blk-mq-sched.c:339
 __blk_mq_run_hw_queue+0xff/0x350 block/blk-mq.c:2013
 blk_mq_run_work_fn+0x55/0x70 block/blk-mq.c:2336
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

