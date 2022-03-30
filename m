Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA84ECAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349420AbiC3RoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiC3RoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:44:14 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B4F4613
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:42:28 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id f10-20020a056e020c6a00b002c9ef5c9df4so882728ilj.22
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=U40YE8MyDVJ6rCvboVaEPduii3oIujdQd6D7pF2XnG4=;
        b=2WHvJZtndWWo5TZme00Jhi3XPU7dqCl6DkbwUikBr9Yebxnk3M/Gv80r9Skp7QqGAr
         Gx7d4EOgs2+u5osVJPiuwkCMO+blE5FH9epkqysobnMiB/04/CsWjMQNK3FA877eWfvx
         M6TrUwblZA0DAbdJF4gfWvzk78qTFmScHqQRabfvgWBYsUcHpEk0VxsYtuQyZz7ww3vj
         nsY3chNyMKZHDS/eGmSp5jDhvMRhg+5/zq+WoHDWqlBfHEX+Fj/Fg37QTwqipFd46/wD
         S1INnmwkkxSp+EtY3b5P1KUZmnu/dt9qTHIsVPoxh4fu1JGt++Q4R8hcrkw5VWVsHfa8
         yHCg==
X-Gm-Message-State: AOAM530lcyMH12R1pVIVAQcMAp68inC2NwcGojeZDoG4KrgWhag2dEzF
        bSGb49jCpgwgxPBI+r4vmUrAIkROJyLrK4qBi3yvB/gL+0v7
X-Google-Smtp-Source: ABdhPJz0aMYNE/tm9tWFc8+jYPzCR0q1siLpnbYfRae8zUyRaU42AyiRzuKiSJYAxCtwEG2IAQgJq+Q7TK5gcm8BGUcdR69RCB87
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a9:b0:323:600c:e42c with SMTP id
 t41-20020a05663834a900b00323600ce42cmr496343jal.75.1648662148315; Wed, 30 Mar
 2022 10:42:28 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:42:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4802405db731170@google.com>
Subject: [syzbot] BUG: scheduling while atomic: syz-fuzzer/NUM/ADDR
From:   syzbot <syzbot+4631483f85171c561f39@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    f022814633e1 Merge tag 'trace-v5.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1511883d700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f78c0e92b7fea54
dashboard link: https://syzkaller.appspot.com/bug?extid=4631483f85171c561f39
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4631483f85171c561f39@syzkaller.appspotmail.com

BUG: scheduling while atomic: syz-fuzzer/2188/0x00000101
Modules linked in:
CPU: 0 PID: 2188 Comm: syz-fuzzer Not tainted 5.17.0-syzkaller-11138-gf022814633e1 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0xcc/0xe0 arch/arm64/kernel/stacktrace.c:184
 dump_backtrace arch/arm64/kernel/stacktrace.c:190 [inline]
 show_stack+0x18/0x6c arch/arm64/kernel/stacktrace.c:191
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
 dump_stack+0x18/0x34 lib/dump_stack.c:113
 __schedule_bug+0x60/0x80 kernel/sched/core.c:5617
 schedule_debug kernel/sched/core.c:5644 [inline]
 __schedule+0x74c/0x7f0 kernel/sched/core.c:6273
 schedule+0x54/0xd0 kernel/sched/core.c:6454
 rwsem_down_write_slowpath+0x29c/0x5a0 kernel/locking/rwsem.c:1142
 __down_write_common kernel/locking/rwsem.c:1259 [inline]
 __down_write_common kernel/locking/rwsem.c:1256 [inline]
 __down_write kernel/locking/rwsem.c:1268 [inline]
 down_write+0x58/0x64 kernel/locking/rwsem.c:1515
 inode_lock include/linux/fs.h:777 [inline]
 simple_recursive_removal+0x124/0x270 fs/libfs.c:288
 debugfs_remove fs/debugfs/inode.c:732 [inline]
 debugfs_remove+0x5c/0x80 fs/debugfs/inode.c:726
 blk_release_queue+0x7c/0xf0 block/blk-sysfs.c:784
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x98/0x114 lib/kobject.c:753
 blk_put_queue+0x14/0x20 block/blk-core.c:270
 blkg_free.part.0+0x54/0x80 block/blk-cgroup.c:86
 blkg_free block/blk-cgroup.c:78 [inline]
 __blkg_release+0x44/0x70 block/blk-cgroup.c:102
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x324/0x590 kernel/rcu/tree.c:2786
 rcu_core_si+0x10/0x20 kernel/rcu/tree.c:2803
 _stext+0x124/0x2a0
 do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
 invoke_softirq kernel/softirq.c:439 [inline]
 __irq_exit_rcu+0xe4/0x100 kernel/softirq.c:637
 irq_exit_rcu+0x10/0x1c kernel/softirq.c:649
 el0_interrupt+0x6c/0x104 arch/arm64/kernel/entry-common.c:693
 __el0_irq_handler_common+0x18/0x2c arch/arm64/kernel/entry-common.c:700
 el0t_64_irq_handler+0x10/0x20 arch/arm64/kernel/entry-common.c:705
 el0t_64_irq+0x198/0x19c arch/arm64/kernel/entry.S:582
------------[ cut here ]------------
WARNING: CPU: 0 PID: 13 at kernel/rcu/tree.c:2592 rcu_do_batch kernel/rcu/tree.c:2592 [inline]
WARNING: CPU: 0 PID: 13 at kernel/rcu/tree.c:2592 rcu_core+0x4d4/0x590 kernel/rcu/tree.c:2786
Modules linked in:
CPU: 0 PID: 13 Comm: ksoftirqd/0 Tainted: G        W         5.17.0-syzkaller-11138-gf022814633e1 #0
Hardware name: linux,dummy-virt (DT)
pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : rcu_do_batch kernel/rcu/tree.c:2592 [inline]
pc : rcu_core+0x4d4/0x590 kernel/rcu/tree.c:2786
lr : rcu_do_batch kernel/rcu/tree.c:2572 [inline]
lr : rcu_core+0x38c/0x590 kernel/rcu/tree.c:2786
sp : ffff80000a69bd00
x29: ffff80000a69bd00 x28: ffff800008121498 x27: 0000000000000000
x26: 000000000000000a x25: fffffffffffffffd x24: ffff80000a69bd60
x23: ffff80000a36cc00 x22: ffff00007fbc39b8 x21: 0000000000000000
x20: ffff00007fbc3940 x19: 0000000000000000 x18: 0000000000000014
x17: ffff800075981000 x16: ffff800008004000 x15: 000002fbb92ae146
x14: 00000000000000c7 x13: 00000000000000c7 x12: ffff800009e7d710
x11: ffff80000a25fee8 x10: ffff800075981000 x9 : 5759a1e949bd4693
x8 : ffff8000080102a0 x7 : ffff80000a69b9e4 x6 : 00000000002e47d8
x5 : f1ff00002157a500 x4 : ffff00007fbc75a0 x3 : 00000000002e47e0
x2 : 0000000000002710 x1 : ffffffffffffd8f0 x0 : 0000000000000001
Call trace:
 rcu_do_batch kernel/rcu/tree.c:2592 [inline]
 rcu_core+0x4d4/0x590 kernel/rcu/tree.c:2786
 rcu_core_si+0x10/0x20 kernel/rcu/tree.c:2803
 _stext+0x124/0x2a0
 run_ksoftirqd+0x4c/0x60 kernel/softirq.c:921
 smpboot_thread_fn+0x23c/0x270 kernel/smpboot.c:164
 kthread+0x108/0x10c kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:867
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
