Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF324EFF4A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiDBHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:22:17 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9A14B85E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:20:23 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id h14-20020a05660208ce00b00645c339411bso3087571ioz.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 00:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=N5ecihr8JaNbOUQUJfuH7WKvjENxjj3jis6Z5I+J7K8=;
        b=fABaaduLBxMa/C9ho02JCouOz3I2rWno09ba6yGnWehQNK0kkZHHvwnAQTkRwje5BT
         FlSuR+aoplgu1dORK185xEOFLgbuIi4tqzucRXfT5i4GEwglp3VglUaFNsyL4W9Cbg+A
         db+6Y0aZMp2nNLgSCMPWfmFEo7CPO9J/Mp6Mh7NpiBGlZO+pBsVdxaIf3a2K+WJeQ4/+
         qeKf7qADJqxHNzKs8W6rooqg15BeDScgAgdRI76WIHhOeUnKohT3T7fKHb7HqUSEnnkq
         nPI/5NTCLDumgAhvBKCeGuQs67qZWP99j0GEk12Cv8CC05jTqvAC17kak6nCjemVcbr6
         gC3g==
X-Gm-Message-State: AOAM532qORUH3K4921eermiCBAxoyMDT9uhaitccMTCdpCWSRcvwd3nf
        BL6PmNRRKPl8UNYKrnLqJmfTSk/Qk2tXd4NTKaPu6XYczYfj
X-Google-Smtp-Source: ABdhPJxM3+yCjz1ZJB25tHvErYEMg2TDx2iKeUwYDqPo3qPXlMxioIFd+cQYd7uMiOv173b+//1vSmz/mElMvPuWTfpUoghnLmEF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14d1:b0:323:bb58:17e6 with SMTP id
 l17-20020a05663814d100b00323bb5817e6mr3228991jak.170.1648884023181; Sat, 02
 Apr 2022 00:20:23 -0700 (PDT)
Date:   Sat, 02 Apr 2022 00:20:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a4a2d05dba6baa6@google.com>
Subject: [syzbot] INFO: task can't die in blkdev_common_ioctl
From:   syzbot <syzbot+4f1a237abaf14719db49@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
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

Hello,

syzbot found the following issue on:

HEAD commit:    f81e94e91878 Add linux-next specific files for 20211125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168d578db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
dashboard link: https://syzkaller.appspot.com/bug?extid=4f1a237abaf14719db49
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f1a237abaf14719db49@syzkaller.appspotmail.com

INFO: task syz-executor.1:32540 can't die for more than 143 seconds.
task:syz-executor.1  state:D stack:27192 pid:32540 ppid: 14712 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4983 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6293
 schedule+0xd2/0x260 kernel/sched/core.c:6366
 rwsem_down_write_slowpath+0x761/0x1130 kernel/locking/rwsem.c:1117
 __down_write_common kernel/locking/rwsem.c:1272 [inline]
 __down_write_common kernel/locking/rwsem.c:1269 [inline]
 __down_write kernel/locking/rwsem.c:1281 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blk_ioctl_zeroout block/ioctl.c:155 [inline]
 blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459
 blkdev_ioctl+0x2ca/0x800 block/ioctl.c:582
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f040b032ae9
RSP: 002b:00007f0409fa8188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f040b145f60 RCX: 00007f040b032ae9
RDX: 0000000020000080 RSI: 000000000000127f RDI: 0000000000000004
RBP: 00007f040b08cff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe1ed4671f R14: 00007f0409fa8300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.1:32540 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc2-next-20211125-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:27192 pid:32540 ppid: 14712 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4983 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6293
 schedule+0xd2/0x260 kernel/sched/core.c:6366
 rwsem_down_write_slowpath+0x761/0x1130 kernel/locking/rwsem.c:1117
 __down_write_common kernel/locking/rwsem.c:1272 [inline]
 __down_write_common kernel/locking/rwsem.c:1269 [inline]
 __down_write kernel/locking/rwsem.c:1281 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blk_ioctl_zeroout block/ioctl.c:155 [inline]
 blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459
 blkdev_ioctl+0x2ca/0x800 block/ioctl.c:582
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f040b032ae9
RSP: 002b:00007f0409fa8188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f040b145f60 RCX: 00007f040b032ae9
RDX: 0000000020000080 RSI: 000000000000127f RDI: 0000000000000004
RBP: 00007f040b08cff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe1ed4671f R14: 00007f0409fa8300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.3:32562 can't die for more than 144 seconds.
task:syz-executor.3  state:R  running task     stack:24976 pid:32562 ppid: 12533 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4983 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6293
 </TASK>
INFO: task syz-executor.3:32564 can't die for more than 145 seconds.
task:syz-executor.3  state:R  running task     stack:25248 pid:32564 ppid: 12533 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4983 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6293
 </TASK>
INFO: task syz-executor.2:32582 can't die for more than 146 seconds.
task:syz-executor.2  state:D stack:27192 pid:32582 ppid: 14575 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4983 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6293
 schedule+0xd2/0x260 kernel/sched/core.c:6366
 rwsem_down_write_slowpath+0x761/0x1130 kernel/locking/rwsem.c:1117
 __down_write_common kernel/locking/rwsem.c:1272 [inline]
 __down_write_common kernel/locking/rwsem.c:1269 [inline]
 __down_write kernel/locking/rwsem.c:1281 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blk_ioctl_zeroout block/ioctl.c:155 [inline]
 blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459
 blkdev_ioctl+0x2ca/0x800 block/ioctl.c:582
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9254295ae9
RSP: 002b:00007f925320b188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f92543a8f60 RCX: 00007f9254295ae9
RDX: 0000000020000080 RSI: 000000000000127f RDI: 0000000000000004
RBP: 00007f92542efff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe50e9b58f R14: 00007f925320b300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.2:32582 blocked for more than 147 seconds.
      Not tainted 5.16.0-rc2-next-20211125-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:27192 pid:32582 ppid: 14575 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4983 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6293
 schedule+0xd2/0x260 kernel/sched/core.c:6366
 rwsem_down_write_slowpath+0x761/0x1130 kernel/locking/rwsem.c:1117
 __down_write_common kernel/locking/rwsem.c:1272 [inline]
 __down_write_common kernel/locking/rwsem.c:1269 [inline]
 __down_write kernel/locking/rwsem.c:1281 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blk_ioctl_zeroout block/ioctl.c:155 [inline]
 blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459
 blkdev_ioctl+0x2ca/0x800 block/ioctl.c:582
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9254295ae9
RSP: 002b:00007f925320b188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f92543a8f60 RCX: 00007f9254295ae9
RDX: 0000000020000080 RSI: 000000000000127f RDI: 0000000000000004
RBP: 00007f92542efff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe50e9b58f R14: 00007f925320b300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.5:32584 can't die for more than 147 seconds.
task:syz-executor.5  state:D stack:28496 pid:32584 ppid: 10070 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4983 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6293
 schedule+0xd2/0x260 kernel/sched/core.c:6366
 rwsem_down_write_slowpath+0x761/0x1130 kernel/locking/rwsem.c:1117
 __down_write_common kernel/locking/rwsem.c:1272 [inline]
 __down_write_common kernel/locking/rwsem.c:1269 [inline]
 __down_write kernel/locking/rwsem.c:1281 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blk_ioctl_zeroout block/ioctl.c:155 [inline]
 blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459
 blkdev_ioctl+0x2ca/0x800 block/ioctl.c:582
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb7df573ae9
RSP: 002b:00007fb7de4e9188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb7df686f60 RCX: 00007fb7df573ae9
RDX: 0000000020000080 RSI: 000000000000127f RDI: 0000000000000004
RBP: 00007fb7df5cdff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd0303ab7f R14: 00007fb7de4e9300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.5:32584 blocked for more than 148 seconds.
      Not tainted 5.16.0-rc2-next-20211125-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:28496 pid:32584 ppid: 10070 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4983 [inline]
 __schedule+0xab2/0x4d90 kernel/sched/core.c:6293
 schedule+0xd2/0x260 kernel/sched/core.c:6366
 rwsem_down_write_slowpath+0x761/0x1130 kernel/locking/rwsem.c:1117
 __down_write_common kernel/locking/rwsem.c:1272 [inline]
 __down_write_common kernel/locking/rwsem.c:1269 [inline]
 __down_write kernel/locking/rwsem.c:1281 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blk_ioctl_zeroout block/ioctl.c:155 [inline]
 blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459
 blkdev_ioctl+0x2ca/0x800 block/ioctl.c:582
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb7df573ae9
RSP: 002b:00007fb7de4e9188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb7df686f60 RCX: 00007fb7df573ae9
RDX: 0000000020000080 RSI: 000000000000127f RDI: 0000000000000004
RBP: 00007fb7df5cdff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd0303ab7f R14: 00007fb7de4e9300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bb83220 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
2 locks held by kswapd0/98:
1 lock held by kswapd1/99:
2 locks held by kworker/u4:4/302:
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2270
 #1: ffff8880b9d279c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3e7/0x4e0 kernel/sched/psi.c:891
1 lock held by in:imklog/6219:
 #0: ffff888077cd0d70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
2 locks held by agetty/6483:
 #0: ffff888078937098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc90001a5c2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2113
2 locks held by kworker/u4:7/9062:
1 lock held by syz-executor.1/32540:
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: blk_ioctl_zeroout block/ioctl.c:155 [inline]
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459
1 lock held by syz-executor.3/32562:
1 lock held by syz-executor.3/32564:
1 lock held by syz-executor.2/32582:
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: blk_ioctl_zeroout block/ioctl.c:155 [inline]
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459
1 lock held by syz-executor.5/32584:
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: blk_ioctl_zeroout block/ioctl.c:155 [inline]
 #0: ffff88814087f348 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_common_ioctl+0xcae/0x1790 block/ioctl.c:459

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.16.0-rc2-next-20211125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:256 [inline]
 watchdog+0xcb7/0xed0 kernel/hung_task.c:413
 kthread+0x405/0x4f0 kernel/kthread.c:345
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 2958 Comm: systemd-journal Not tainted 5.16.0-rc2-next-20211125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:check_kcov_mode kernel/kcov.c:166 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x7/0x60 kernel/kcov.c:200
Code: 49 00 5d be 03 00 00 00 e9 06 e8 6a 02 66 0f 1f 44 00 00 48 8b be b0 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 65 8b 05 19 8b 8a 7e <89> c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 40 70 02 00 a9
RSP: 0018:ffffc90001aafdc8 EFLAGS: 00000293
RAX: 0000000080000000 RBX: ffff88802ca65a00 RCX: ffff88807b17ba80
RDX: 0000000000000000 RSI: ffff88807b17ba80 RDI: 0000000000000003
RBP: ffff8880aca65a00 R08: ffff8880aca65a00 R09: 000000000000002e
R10: ffffffff8134ed58 R11: 000000000000003f R12: 000000002ca65a00
R13: 000000000000002e R14: ffffea0000000000 R15: ffff88802ca65a00
FS:  00007f26fa2bd8c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f26f7c09000 CR3: 000000007f7df000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 phys_addr_valid arch/x86/mm/physaddr.h:7 [inline]
 __phys_addr+0xa7/0x140 arch/x86/mm/physaddr.c:28
 virt_to_head_page include/linux/mm.h:861 [inline]
 qlink_to_cache mm/kasan/quarantine.c:120 [inline]
 qlist_free_all+0x76/0xf0 mm/kasan/quarantine.c:162
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3234 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3247
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags include/linux/audit.h:323 [inline]
 getname fs/namei.c:217 [inline]
 __do_sys_mkdir fs/namei.c:3929 [inline]
 __se_sys_mkdir fs/namei.c:3927 [inline]
 __x64_sys_mkdir+0xda/0x140 fs/namei.c:3927
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f26f9578687
Code: 00 b8 ff ff ff ff c3 0f 1f 40 00 48 8b 05 09 d8 2b 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 d7 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe28596978 EFLAGS: 00000293 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffe28599890 RCX: 00007f26f9578687
RDX: 00007f26f9fe9a00 RSI: 00000000000001ed RDI: 0000564b999038a0
RBP: 00007ffe285969b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffe28599890 R15: 00007ffe28596ea0
 </TASK>
----------------
Code disassembly (best guess):
   0:	49 00 5d be          	rex.WB add %bl,-0x42(%r13)
   4:	03 00                	add    (%rax),%eax
   6:	00 00                	add    %al,(%rax)
   8:	e9 06 e8 6a 02       	jmpq   0x26ae813
   d:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  13:	48 8b be b0 01 00 00 	mov    0x1b0(%rsi),%rdi
  1a:	e8 b4 ff ff ff       	callq  0xffffffd3
  1f:	31 c0                	xor    %eax,%eax
  21:	c3                   	retq
  22:	90                   	nop
  23:	65 8b 05 19 8b 8a 7e 	mov    %gs:0x7e8a8b19(%rip),%eax        # 0x7e8a8b43
* 2a:	89 c1                	mov    %eax,%ecx <-- trapping instruction
  2c:	48 8b 34 24          	mov    (%rsp),%rsi
  30:	81 e1 00 01 00 00    	and    $0x100,%ecx
  36:	65 48 8b 14 25 40 70 	mov    %gs:0x27040,%rdx
  3d:	02 00
  3f:	a9                   	.byte 0xa9


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
