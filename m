Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598DD5649A6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiGCT7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:59:29 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF72638
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 12:59:26 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id bw12-20020a056602398c00b00675895c2e24so4624678iob.19
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 12:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fxd2zYEs/HK7g0AzqmEBakp3jQ09ZVxB2p2F7iSzL+s=;
        b=3tDOkk290NCgZ8gTrrfqBAsFXiCUThACGjeno/rNvJas0wQnWIfvtqafveOnvwnfZ5
         UhNgWUuwCAUz9WdgG7BoM0fN7pdUAID4XxeOBgyHOYHLvY3+B4fwTuajuTUSKI/fclnT
         IMYk/kjhbkq1L1cJzsnbZMuFpSm/k4gAxNHepBXdaJNc41bu1mYPlwUx4TjR975hoFwB
         FlDK1KVEdfnKdTWCPYrLupSB/XfoIixmeUWrnD/UjOU6WkzNgnjpzZDI/Xv9j+SpjcjT
         zUDECmNk5n0fsS29HERemOK0XfC9Nm0W0Npi2I4AKqEAi8MtrmZ0B5CiQT+faX45Orn3
         xrZQ==
X-Gm-Message-State: AJIora/NHelOeTn05BSc2z6L/UMp9CkKXuOS5VXAnt3a5/QPLaoSpPVz
        wIvbXM86vUIdok+E25+3aqSpL1JprhrKlJG7BTPVXRlsv1k2
X-Google-Smtp-Source: AGRyM1tQk5sWerO2mo6W6rwl1EvrlyrkR4zkU87anpM25YNSfUyem4FZeDgdMzjusVOPnonkVHsazMgBXF9Q2sgJxwR7g63wJ7oa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d96:b0:2da:6dfd:7f8c with SMTP id
 h22-20020a056e021d9600b002da6dfd7f8cmr13906179ila.322.1656878365466; Sun, 03
 Jul 2022 12:59:25 -0700 (PDT)
Date:   Sun, 03 Jul 2022 12:59:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068e76205e2ec0e6b@google.com>
Subject: [syzbot] WARNING in match_held_lock
From:   syzbot <syzbot+6c67d4224af196c99976@syzkaller.appspotmail.com>
To:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

HEAD commit:    849f35422319 Merge tag 'thunderbolt-for-v5.20-rc1' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12f9d498080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33f1eaa5b20a699
dashboard link: https://syzkaller.appspot.com/bug?extid=6c67d4224af196c99976
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c67d4224af196c99976@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!hlock->nest_lock)
WARNING: CPU: 0 PID: 4591 at kernel/locking/lockdep.c:5135 match_held_lock+0xad/0xc0 kernel/locking/lockdep.c:5135
Modules linked in:
CPU: 0 PID: 4591 Comm: syz-executor.0 Not tainted 5.19.0-rc4-syzkaller-00090-g849f35422319 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:match_held_lock+0xad/0xc0 kernel/locking/lockdep.c:5135
Code: e8 f8 2d 24 fc 85 c0 74 e4 8b 05 a6 16 ef 02 85 c0 75 da 48 c7 c6 a0 95 47 86 48 c7 c7 20 92 47 86 89 44 24 04 e8 03 9a d1 ff <0f> 0b 8b 44 24 04 eb bd 66 66 2e 0f 1f 84 00 00 00 00 00 41 57 41
RSP: 0018:ffffc9000c997d50 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff88811600cb68 RCX: 0000000000000000
RDX: ffff88811600b900 RSI: ffffffff812c0fe8 RDI: fffff52001932f9c
RBP: ffffffff87a94640 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000003 R11: 776172206373696d R12: ffff88811600b900
R13: ffff88811600c2f8 R14: 00000000ffffffff R15: ffff88811600cb68
FS:  00007f684e67c700(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f684e639fc0 CR3: 00000001376c9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __lock_is_held kernel/locking/lockdep.c:5406 [inline]
 lock_is_held_type+0xa7/0x140 kernel/locking/lockdep.c:5708
 lock_is_held include/linux/lockdep.h:279 [inline]
 rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0x480/0x570 kernel/locking/lockdep.c:5636
 do_write_seqcount_begin_nested include/linux/seqlock.h:516 [inline]
 do_write_seqcount_begin include/linux/seqlock.h:541 [inline]
 vtime_task_switch_generic+0xb5/0x5a0 kernel/sched/cputime.c:768
 vtime_task_switch include/linux/vtime.h:95 [inline]
 finish_task_switch.isra.0+0x4e3/0xa10 kernel/sched/core.c:5020
 schedule_tail+0x7/0xd0 kernel/sched/core.c:5082
 ret_from_fork+0x8/0x30 arch/x86/entry/entry_64.S:287
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
