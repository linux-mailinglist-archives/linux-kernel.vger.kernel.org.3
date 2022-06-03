Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2200653C52A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiFCGtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiFCGtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:49:32 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59823EE2E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:49:27 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i18-20020a926d12000000b002d1b13b896cso5004192ilc.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 23:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8qogbCgj6RVyPt/Dmu7l/pBndRLbS67xEo7XWCBFXyU=;
        b=nYWM5q6OD7blQEJlR0+mR3N5Zj6ZDC8kYb8OUaAczAiZueB9Mem70q2BQ9OxqrDluQ
         DwsKwUWF2NGzKTDE6VNZmyf07+oN/1cA7sGm8/cBUKw8GGCF2bmAOAhKTJKVA9WFY6l4
         xUSgzcjh0ODRSarcAwJDTgd8fl71WjemPFgMTC/UaC9FoA/fqPpqFPIgVuKQHCjGFoVt
         H/f76agpna43mVtyiUMBwqyIqV4LxCQPfSEQk1QIltpLLdch/Yi8NPdqkfBDHeSb3rkk
         +LLPNVLdWFCjiLgLVEy1KDb2W7OkDgMbC5CG1rlQiCLjmsicjblQlxrERCg8uR1CUQP2
         Ywng==
X-Gm-Message-State: AOAM530l0pDfH0la/WPeP5ebKDLZRprQFGdOZbutvLkXg1bsyk2+GdPD
        ZRbtiHz/BZT5Pg1GigbY/tVYw+cvG3jbviVRQ7mh4+XqKjXD
X-Google-Smtp-Source: ABdhPJz0cK+SaN0NncnWBbg9/7Cpq2w/hpkMYHmOD5KnOY9+DCvZIrrLKxSiT8i5AMb13rMn1znpcwjr9jApgAEq/Janli0/ntnW
MIME-Version: 1.0
X-Received: by 2002:a92:d10e:0:b0:2d3:a495:d535 with SMTP id
 a14-20020a92d10e000000b002d3a495d535mr4925022ilb.54.1654238966712; Thu, 02
 Jun 2022 23:49:26 -0700 (PDT)
Date:   Thu, 02 Jun 2022 23:49:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc128605e08585c6@google.com>
Subject: [syzbot] INFO: task hung in add_early_randomness (2)
From:   syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mpm@selenic.com, syzkaller-bugs@googlegroups.com,
        yuehaibing@huawei.com
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

HEAD commit:    4b0986a3613c Linux 5.18
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d795e5f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=facb2be252153c68
dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com

INFO: task kworker/0:5:29071 blocked for more than 143 seconds.
      Not tainted 5.18.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:25080 pid:29071 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5073 [inline]
 __schedule+0xa9a/0x4cc0 kernel/sched/core.c:6388
 schedule+0xd2/0x1f0 kernel/sched/core.c:6460
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6519
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
 hwrng_register+0x399/0x510 drivers/char/hw_random/core.c:599
 chaoskey_probe+0x7b5/0xc40 drivers/usb/misc/chaoskey.c:205
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3405
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3405
 usb_new_device.cold+0x641/0x1091 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5363 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5665 [inline]
 hub_event+0x25c6/0x4680 drivers/usb/core/hub.c:5747
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bd820e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6467
1 lock held by hwrng/755:
 #0: ffffffff8c81b268 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x141/0x370 drivers/char/hw_random/core.c:503
2 locks held by getty/3282:
 #0: ffff888148d8a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002ce62e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcea/0x1230 drivers/tty/n_tty.c:2075
3 locks held by udevd/19534:
 #0: ffff88807b230088 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:198 [inline]
 #0: ffff88807b230088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x189/0x6f0 fs/kernfs/file.c:237
 #1: ffff88801cf57da0 (kn->active#86){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:199 [inline]
 #1: ffff88801cf57da0 (kn->active#86){++++}-{0:0}, at: kernfs_fop_read_iter+0x1ac/0x6f0 fs/kernfs/file.c:237
 #2: ffff8880450c0220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:772 [inline]
 #2: ffff8880450c0220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
6 locks held by kworker/0:5/29071:
 #0: ffff8880167d4938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880167d4938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880167d4938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880167d4938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880167d4938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880167d4938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90005507da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88801e5d3220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #2: ffff88801e5d3220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4680 drivers/usb/core/hub.c:5693
 #3: ffff8880450c0220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #3: ffff8880450c0220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:945
 #4: ffff88801b1351a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #4: ffff88801b1351a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:945
 #5: ffffffff8c81b268 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.18.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5271 Comm: kworker/0:6 Not tainted 5.18.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events kfree_rcu_work
RIP: 0010:deref_stack_reg arch/x86/kernel/unwind_orc.c:355 [inline]
RIP: 0010:unwind_next_frame+0xf70/0x1cc0 arch/x86/kernel/unwind_orc.c:600
Code: 8d 78 20 e8 02 ea ff ff 48 89 c5 49 8d 7d 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 c4 0a 00 00 <49> 89 6d 40 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 0f
RSP: 0018:ffffc900142b7730 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 1ffff92002856efc RSI: ffffc900142b7ce8 RDI: ffffc900142b77e0
RBP: ffff8880b9c28118 R08: ffffffff8e39a02a R09: ffffc900142b77d4
R10: fffff52002856eff R11: ffffc900142b7d10 R12: ffffc900142b77d5
R13: ffffc900142b77a0 R14: ffffc900142b7ce8 R15: ffffffff8e39a02e
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f29cddfe718 CR3: 000000007f592000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 000000000000000f DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3510 [inline]
 kmem_cache_free_bulk mm/slub.c:3657 [inline]
 kmem_cache_free_bulk+0x2c0/0xb60 mm/slub.c:3644
 kfree_bulk include/linux/slab.h:437 [inline]
 kfree_rcu_work+0x51c/0xa10 kernel/rcu/tree.c:3318
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
----------------
Code disassembly (best guess):
   0:	8d 78 20             	lea    0x20(%rax),%edi
   3:	e8 02 ea ff ff       	callq  0xffffea0a
   8:	48 89 c5             	mov    %rax,%rbp
   b:	49 8d 7d 40          	lea    0x40(%r13),%rdi
   f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  16:	fc ff df
  19:	48 89 fa             	mov    %rdi,%rdx
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  24:	0f 85 c4 0a 00 00    	jne    0xaee
* 2a:	49 89 6d 40          	mov    %rbp,0x40(%r13) <-- trapping instruction
  2e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  35:	fc ff df
  38:	4c 89 ea             	mov    %r13,%rdx
  3b:	48 c1 ea 03          	shr    $0x3,%rdx
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
