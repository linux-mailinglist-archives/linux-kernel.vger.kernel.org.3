Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0178563EAD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 07:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiGBFc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 01:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiGBFc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 01:32:27 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E8D2FFE3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 22:32:26 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e4-20020a92de44000000b002dab11299d9so2106236ilr.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 22:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lNfctuzbaH4yiM4WXjJvx40+Yprk80Qv0BnTbS1ErRs=;
        b=yJ6cx4/dTSgwG7z2SdSRrdCnIldSwym2pKWhmDqXI/HlYuc9lsmo7Fvt/QqgozGDK5
         MXXymrvpgRCdAxW8oaq2T+1/oV8cp00N8shsunnEOKwcsfeEjrL1Pr7bGiK7irGydxok
         nElFHjy7C8KAcWQrqazFc9Xe4C5OV3KgyGe702pq3jLg6WDcDMTwZ2SAMy66s6wCRJU6
         XwI7J6/rvV1+wQwYwv4oc26qGxnPpWxNBSWbdHxRJzRG4fpPsr4RomJSc/ztzrvknYtF
         OXEselUOq2pD29HNi9EwCjDbfRspNZbBgtg6mo/Aomreo0nelfEbodBGo6eFlRyoGVX4
         1+iQ==
X-Gm-Message-State: AJIora/cjI5KxTfZt6itUpY2kUogpYXDUDXYXquruLKXOCzNlTG6b1tL
        EfPOxLH+gkWATpO848OUMhAG5ZNYWJmOwiGMe8iVtuPTqFp9
X-Google-Smtp-Source: AGRyM1tsNw/adLnzxZUiotw4LHmsQtO9enGP0wwVw0EEIz+UyC/bN9LYa1oBYh+19rznKrutW8A32KFwihZ0sb/EKZd0BP/fxsRU
MIME-Version: 1.0
X-Received: by 2002:a05:6638:380e:b0:33c:bbf7:56c0 with SMTP id
 i14-20020a056638380e00b0033cbbf756c0mr11359570jav.71.1656739945333; Fri, 01
 Jul 2022 22:32:25 -0700 (PDT)
Date:   Fri, 01 Jul 2022 22:32:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed47a705e2cbd347@google.com>
Subject: [syzbot] INFO: task hung in __input_unregister_device (4)
From:   syzbot <syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    a175eca0f3d7 Merge tag 'drm-fixes-2022-07-01' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17141c97f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a010dbf6a7af480
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com

INFO: task kworker/0:7:3758 blocked for more than 145 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:22944 pid: 3758 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 input_disconnect_device drivers/input/input.c:784 [inline]
 __input_unregister_device+0x24/0x470 drivers/input/input.c:2234
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2429
 iforce_usb_disconnect+0x5e/0xf0 drivers/input/joystick/iforce/iforce-usb.c:261
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:545 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:537
 __device_release_driver drivers/base/dd.c:1222 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1248
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3604
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x278/0x6ec drivers/usb/core/hub.c:2228
 hub_port_connect drivers/usb/core/hub.c:5207 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5663 [inline]
 hub_event+0x1e83/0x4690 drivers/usb/core/hub.c:5745
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/28:
 #0: ffffffff8bd83b60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by acpid/2961:
 #0: ffff8880739bc158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_close_device drivers/input/joydev.c:220 [inline]
 #0: ffff8880739bc158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_release+0x187/0x290 drivers/input/joydev.c:252
 #1: ffff88807c9c02c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x42/0x1f0 drivers/input/input.c:726
2 locks held by getty/3294:
 #0: ffff88814ab20098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90001c282e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
3 locks held by kworker/0:3/3682:
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003897da8 (fqdir_free_work){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffffffff8bd8dd28 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x44/0x630 kernel/rcu/tree.c:4105
3 locks held by kworker/1:9/3733:
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f2fda8 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffffffff8bd8de60 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:322 [inline]
 #2: ffffffff8bd8de60 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x2d3/0x610 kernel/rcu/tree_exp.h:927
6 locks held by kworker/0:7/3758:
 #0: ffff8881457afd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881457afd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881457afd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8881457afd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8881457afd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8881457afd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003fd7da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888021e32190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff888021e32190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff888042b67190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff888042b67190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
 #4: ffff888072997118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff888072997118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
 #4: ffff888072997118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
 #5: ffff88807c9c02c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_disconnect_device drivers/input/input.c:784 [inline]
 #5: ffff88807c9c02c0 (&dev->mutex#2){+.+.}-{3:3}, at: __input_unregister_device+0x24/0x470 drivers/input/input.c:2234
3 locks held by kworker/u4:11/4030:
 #0: ffff8881400a3138 ((wq_completion)netns){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881400a3138 ((wq_completion)netns){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881400a3138 ((wq_completion)netns){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8881400a3138 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8881400a3138 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8881400a3138 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004517da8 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffffffff8d572f10 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x9b/0xb00 net/core/net_namespace.c:556
2 locks held by udevd/6583:
 #0: ffff888022137110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open_device drivers/input/evdev.c:393 [inline]
 #0: ffff888022137110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open+0x2f3/0x6a0 drivers/input/evdev.c:487
 #1: ffff88807c9c02c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_open_device+0x4a/0x320 drivers/input/input.c:656
3 locks held by kworker/1:11/6796:
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000407fda8 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffffffff8bd8dd28 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x44/0x630 kernel/rcu/tree.c:4105
1 lock held by syz-executor.5/10484:
 #0: ffffffff8bd8dd28 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x44/0x630 kernel/rcu/tree.c:4105
1 lock held by syz-executor.4/10494:
 #0: ffffffff8bdc8b50 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: do_exit+0x50d/0x2a00 kernel/exit.c:751
1 lock held by syz-executor.4/10498:
 #0: ffffffff8bdc8b50 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: do_exit+0x50d/0x2a00 kernel/exit.c:751
1 lock held by syz-executor.4/10503:
 #0: ffffffff8bdc8b50 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: copy_process+0x43c1/0x7020 kernel/fork.c:2344
1 lock held by syz-executor.4/10506:
 #0: ffffffff8bdc8b50 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: do_exit+0x50d/0x2a00 kernel/exit.c:751
1 lock held by syz-executor.2/10495:
 #0: ffffffff8bd8dd28 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x44/0x630 kernel/rcu/tree.c:4105
1 lock held by syz-executor.3/10500:
 #0: ffffffff8bd8dd28 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x44/0x630 kernel/rcu/tree.c:4105
1 lock held by syz-executor.1/10508:
 #0: ffffffff8bdc8b50 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: copy_process+0x43c1/0x7020 kernel/fork.c:2344
4 locks held by kvm-nx-lpage-re/10511:
 #0: ffffffff8bdc8d88 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_attach_task_all+0x21/0x140 kernel/cgroup/cgroup-v1.c:61
 #1: ffffffff8bdc8b50 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_task_all+0x2d/0x140 kernel/cgroup/cgroup-v1.c:62
 #2: ffffffff8bdd7050 (&cpuset_rwsem){++++}-{0:0}, at: cpuset_can_attach+0xe8/0x440 kernel/cgroup/cpuset.c:2233
 #3: ffffffff8bd8de60 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
 #3: ffffffff8bd8de60 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x4f8/0x610 kernel/rcu/tree_exp.h:927

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/18/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 6986 Comm: kworker/u4:21 Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/18/2022
Workqueue: bat_events batadv_nc_worker
RIP: 0010:lock_release+0x28/0x780 kernel/locking/lockdep.c:5673
Code: 00 00 48 b8 00 00 00 00 00 fc ff df 41 57 41 56 41 55 41 54 49 89 fc 55 53 48 81 ec 90 00 00 00 48 8d 6c 24 10 48 89 74 24 08 <48> c7 44 24 10 b3 8a b5 41 48 c1 ed 03 48 c7 44 24 18 48 f6 5f 8b
RSP: 0018:ffffc9000430fbc0 EFLAGS: 00000286
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880497d01c0 RSI: ffffffff8910b8d9 RDI: ffffffff8bd83b60
RBP: ffffc9000430fbd0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8bd83b60
R13: 0000000000000000 R14: dffffc0000000000 R15: 000000000000019f
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f29883691b8 CR3: 000000000ba8e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rcu_lock_release include/linux/rcupdate.h:274 [inline]
 rcu_read_unlock include/linux/rcupdate.h:728 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
 batadv_nc_worker+0x86b/0xfa0 net/batman-adv/network-coding.c:719
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df
   c:	41 57                	push   %r15
   e:	41 56                	push   %r14
  10:	41 55                	push   %r13
  12:	41 54                	push   %r12
  14:	49 89 fc             	mov    %rdi,%r12
  17:	55                   	push   %rbp
  18:	53                   	push   %rbx
  19:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
  20:	48 8d 6c 24 10       	lea    0x10(%rsp),%rbp
  25:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
* 2a:	48 c7 44 24 10 b3 8a 	movq   $0x41b58ab3,0x10(%rsp) <-- trapping instruction
  31:	b5 41
  33:	48 c1 ed 03          	shr    $0x3,%rbp
  37:	48 c7 44 24 18 48 f6 	movq   $0xffffffff8b5ff648,0x18(%rsp)
  3e:	5f 8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
