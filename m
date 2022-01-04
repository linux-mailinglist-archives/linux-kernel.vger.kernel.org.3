Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E33483E19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiADI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiADI3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:29:09 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257F4C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:29:09 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y130so81523775ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 00:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gel7jFMu2vWjew4s/rp/WsKOrhvf9mE9KqSN85x0lNg=;
        b=FfCKXGdeUYsZr9eURtR9ZufpDFHwp6ZxaAsYNh0j7mTE1Vha0msUKA++kpiKFieXJL
         ch6PAN1N/WukLS+7dtqvtHo6d58Sn6mwFgDRuHqFx8K0bRW+S3lXWwi70EyspHJNpnwu
         RPM9XxuDv6FJWLJl6umCE+MJ9CnhIevQ8911ejriJQQpy0wpnwSdMl46ZDIWax6Y4mq/
         aA1cP3rA8QhLIIQ9RK8kZduWodZiP6xFtpTVUkex3XLi2CIr+Lws6QYEqmRZ9XCy0rEg
         aObcyP8HPoe8dea9Tzirh5lnYPt/bqj/0ocNbOE8Vr/vDLm7Ufl+YE0r38e9tJdLcc0N
         W17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gel7jFMu2vWjew4s/rp/WsKOrhvf9mE9KqSN85x0lNg=;
        b=kyf9g40EPj98Kw7GjFMFKyyS9+wmqLo2E5vsj4fiwsjli9rfTJSESG8JFqFxyXOPQ+
         /NQHvoZEn35bmbLtQ0l9scAD1PeCZgD0nTjemSWvhycypa3EDa5GzrqiT3CCGLqATv7H
         9PSWwEMJ5ul3y9ohMBONd34Hd/Z8AQOMT8T2tcjH9q5IPhNY/JMyZHImj7WViatFzdBf
         FYVhr+Y4D/PxJEo1NPHQ4NJtCrk1krRU4To8yx2gs9jBLqEEK7Fd6Fau5WiPJK8MELs9
         ohYx+STgrvVfEYqPhUEdoB5lGXrVDDUoxulw1dPjeXxXLav3sZN85M7e9NHPuzHvmijG
         P0YQ==
X-Gm-Message-State: AOAM530QzL52VsOJxENsZZAsun7yX7uJyx+VmfqwoOADjqO3H9mgkuXp
        JSGE3hMZr00sPAbDOt0nvv4n5GgrhbLjDOYn4WtFBLHZHseR2M3c
X-Google-Smtp-Source: ABdhPJzqC6rZQU14p2S+YoOSc89BW3ricQxWdOuNOlsHrRE0ZbsmwFwbbbBapbL0mycyB9hWQf1PskJ/u94NQtrFPLo=
X-Received: by 2002:a25:3006:: with SMTP id w6mr65172395ybw.691.1641284948375;
 Tue, 04 Jan 2022 00:29:08 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 16:28:57 +0800
Message-ID: <CAFkrUsjR+yhNCOGomvLL5kowjxX-bbZ6xOi7kFpLLZMhi_4sPA@mail.gmail.com>
Subject: INFO: task hung in process_one_work
To:     tj@kernel.org, jiangshanlai@gmail.com,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://paste.ubuntu.com/p/KK2SGDpm6s/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>

INFO: task kworker/0:0:5 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:24768 pid:    5 ppid:     2 flags:0x00004000
Workqueue: events nsim_dev_trap_report_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 nsim_dev_trap_report_work+0x5d/0xbb0 drivers/net/netdevsim/dev.c:838
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/5:
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc90000687dc8
((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0},
at: process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff8880171a7490 (&nsim_dev->port_list_lock){+.+.}-{3:3}, at:
nsim_dev_trap_report_work+0x5d/0xbb0 drivers/net/netdevsim/dev.c:838
6 locks held by kworker/u8:1/10:
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc900006d7dc8 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0x9b/0xa90 net/core/net_namespace.c:555
 #3: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368
 #4: ffff8880171a65c0
(&nsim_bus_dev->nsim_bus_reload_lock){+.+.}-{3:3}, at:
nsim_dev_reload_down+0x4d/0x180 drivers/net/netdevsim/dev.c:951
 #5: ffff8880171a7490 (&nsim_dev->port_list_lock){+.+.}-{3:3}, at:
nsim_dev_port_del_all+0x28/0xe0 drivers/net/netdevsim/dev.c:1439
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by systemd-journal/3046:
1 lock held by in:imklog/6787:
 #0: ffff8880171e23f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:1034
2 locks held by agetty/6339:
 #0: ffff8881007b3098 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc900025e32e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x8db/0x1250 drivers/tty/n_tty.c:2113
2 locks held by syz-executor.3/383:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368
2 locks held by syz-executor.4/390:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368
2 locks held by syz-executor.1/391:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368
2 locks held by syz-executor.2/392:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368
2 locks held by syz-executor.7/393:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368
2 locks held by syz-executor.5/394:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368
2 locks held by syz-executor.0/397:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368
2 locks held by syz-executor.6/477:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d32e988 (devlink_mutex){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x86/0x390 net/core/devlink.c:11368

=============================================

NMI backtrace for cpu 3
CPU: 3 PID: 39 Comm: khungtaskd Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1a1/0x1e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 3 to CPUs 0-2:
NMI backtrace for cpu 1
CPU: 1 PID: 11392 Comm: kworker/u8:5 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:rcu_is_watching+0x0/0xb0 kernel/rcu/tree.c:1117
Code: 4e 5b 00 e9 2c ff ff ff 66 90 48 c7 c7 80 73 ad 89 e8 44 b8 df
07 65 8a 05 99 d1 a0 7e 0f be c0 c3 66 0f 1f 84 00 00 00 00 00 <55> 53
65 ff 05 07 97 9f 7e e8 02 b8 df 07 48 c7 c3 50 aa 03 00 83
RSP: 0018:ffffc9000d3dfae0 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffc9000d3dfb18 RCX: ffffffff815c80d8
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000d3dfb18
RBP: 0000000000000001 R08: 0000000000000001 R09: fffffbfff1b20a2b
R10: ffffffff8d905157 R11: fffffbfff1b20a2a R12: 0000000000000000
R13: ffff888108581ad8 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0007a57e0 CR3: 000000001f0ad000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 rcu_read_lock_held_common+0x3f/0x90 kernel/rcu/update.c:108
 rcu_read_lock_sched_held+0x5a/0xd0 kernel/rcu/update.c:123
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x452/0x520 kernel/locking/lockdep.c:5608
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:354 [inline]
 batadv_nc_purge_paths+0xdf/0x400 net/batman-adv/network-coding.c:446
 batadv_nc_worker+0x287/0x770 net/batman-adv/network-coding.c:726
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 0
CPU: 0 PID: 3046 Comm: systemd-journal Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:rcu_preempt_read_exit kernel/rcu/tree_plugin.h:380 [inline]
RIP: 0010:__rcu_read_unlock+0x2d/0x570 kernel/rcu/tree_plugin.h:419
Code: 55 41 54 55 65 48 8b 2c 25 40 70 02 00 53 48 8d bd fc 03 00 00
48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 <48> 89
f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 24 02 00 00 65
RSP: 0018:ffffc9000123f9b0 EFLAGS: 00000217
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffff88801953d640
RDX: 0000000000000000 RSI: ffff88801953d640 RDI: ffff88801953da3c
RBP: ffff88801953d640 R08: ffffffff818411dc R09: 0000000000000000
R10: 0000000000000001 R11: fffffbfff1fee128 R12: ffffc9000123fa00
R13: 0000000000000000 R14: ffff88801953d640 R15: ffffc9000123fe08
FS:  00007f4a23d828c0(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4a2118e000 CR3: 0000000019ad7000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 rcu_read_unlock include/linux/rcupdate.h:720 [inline]
 is_bpf_text_address+0x81/0x170 kernel/bpf/core.c:717
 kernel_text_address kernel/extable.c:124 [inline]
 kernel_text_address+0x39/0x80 kernel/extable.c:93
 __kernel_text_address+0x9/0x30 kernel/extable.c:78
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:318 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:313
 arch_stack_walk+0x93/0xe0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook+0x4d/0x4a0 mm/slab.h:519
 slab_alloc_node mm/slub.c:3234 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 kmem_cache_alloc+0x158/0x380 mm/slub.c:3247
 prepare_creds+0x3f/0x7b0 kernel/cred.c:260
 access_override_creds fs/open.c:351 [inline]
 do_faccessat+0x3f4/0x850 fs/open.c:415
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4a2303e9c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8
64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc8e4c5d38 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007ffc8e4c8c50 RCX: 00007f4a2303e9c7
RDX: 00007f4a23aafa00 RSI: 0000000000000000 RDI: 000056380951d9a3
RBP: 00007ffc8e4c5d70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffc8e4c8c50 R15: 00007ffc8e4c6260
 </TASK>
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733
----------------
Code disassembly (best guess), 3 bytes skipped:
   0: e9 2c ff ff ff       jmpq   0xffffff31
   5: 66 90                 xchg   %ax,%ax
   7: 48 c7 c7 80 73 ad 89 mov    $0xffffffff89ad7380,%rdi
   e: e8 44 b8 df 07       callq  0x7dfb857
  13: 65 8a 05 99 d1 a0 7e mov    %gs:0x7ea0d199(%rip),%al        # 0x7ea0d1b3
  1a: 0f be c0             movsbl %al,%eax
  1d: c3                   retq
  1e: 66 0f 1f 84 00 00 00 nopw   0x0(%rax,%rax,1)
  25: 00 00
* 27: 55                   push   %rbp <-- trapping instruction
  28: 53                   push   %rbx
  29: 65 ff 05 07 97 9f 7e incl   %gs:0x7e9f9707(%rip)        # 0x7e9f9737
  30: e8 02 b8 df 07       callq  0x7dfb837
  35: 48 c7 c3 50 aa 03 00 mov    $0x3aa50,%rbx
  3c: 83                   .byte 0x83


Best Regards,
Yiru
