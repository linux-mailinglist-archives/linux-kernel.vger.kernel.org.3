Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7553F390
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiFGBu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiFGBuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:50:21 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94E368992
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:50:19 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g8-20020a92cda8000000b002d15f63967eso12791317ild.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 18:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vcc3rsXseWxWD8RW7gyYZRvOftqn/pKm1SgNDbde/9E=;
        b=EkFXMLxUvQX9TpklQHfa/6kAXU4PV1eBmOuSuICcl6fObiHgGvhn8huP6Bmr2mAVN3
         8yAlD1kNNeYatLxQjPOUCbGQWjcFDGaXTN3WU9iInUMBIBT9yfIo3VmTeu9jhckDWzpA
         CCTbqKVGk10g3P/3mtlLbqJZ3SAgJZTZZ6M7kNgNizS9oA+9K/xxRz/pcM9HasrQwRl4
         9WGusgHruxZ4BO+ysiLnqR1RhrhKQekMy/NovvdELgRXrzpjGNSJOK8BWfHu48zJ/YIw
         XZuvcXax1ogjQ/E44J6204eaI9bozlyKBy3VG4sQCjTZrCNC5TZjWU2B+s5qP+DIQYL9
         4AsQ==
X-Gm-Message-State: AOAM530XW8Yl8nRxHOAcA+txHJqJSmFqq2nDRTH0J6umfZSSM5Wa9QK/
        WisVGcX0pvvej6p7/hmjAZs3ISXPgqlEkwZTnZvUyrVtSBvU
X-Google-Smtp-Source: ABdhPJxZVFl9fxQ7o7xjxpsHYZt/kXWeqk1kXwIHajH6DWTA2Z7ELbokaG82S6NxnGopGYgp2ka+6AImkoT6y4MPkPkaumKTe8Lq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:2d3:e20f:4959 with SMTP id
 r12-20020a056e0219cc00b002d3e20f4959mr15779069ill.40.1654566619131; Mon, 06
 Jun 2022 18:50:19 -0700 (PDT)
Date:   Mon, 06 Jun 2022 18:50:19 -0700
In-Reply-To: <000000000000fc128605e08585c6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009736b105e0d1cfa1@google.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    f2906aa86338 Linux 5.19-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d62393f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd131cc02ee620e
dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104f4d4ff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d6782df00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com

INFO: task kworker/1:4:2941 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:23968 pid: 2941 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6559
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
 hwrng_register+0x399/0x510 drivers/char/hw_random/core.c:599
 chaoskey_probe+0x7b5/0xc40 drivers/usb/misc/chaoskey.c:205
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:555 [inline]
 really_probe+0x23e/0xb90 drivers/base/dd.c:634
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:989
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbda/0x1ea0 drivers/base/core.c:3417
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:555 [inline]
 really_probe+0x23e/0xb90 drivers/base/dd.c:634
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:989
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbda/0x1ea0 drivers/base/core.c:3417
 usb_new_device.cold+0x641/0x1091 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5363 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5663 [inline]
 hub_event+0x25d5/0x4690 drivers/usb/core/hub.c:5745
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Showing all locks held in the system:
2 locks held by pr/ttyS0/16:
1 lock held by khungtaskd/29:
 #0: ffffffff8bd83be0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
1 lock held by hwrng/755:
 #0: ffffffff8c829c28 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x141/0x370 drivers/char/hw_random/core.c:503
6 locks held by kworker/1:4/2941:
 #0: ffff888017505538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017505538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017505538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017505538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017505538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017505538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000306fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8881476d6190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff8881476d6190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff888017679190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff888017679190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x76/0x530 drivers/base/dd.c:964
 #4: ffff888017670118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff888017670118 (&dev->mutex){....}-{3:3}, at: __device_attach+0x76/0x530 drivers/base/dd.c:964
 #5: ffffffff8c829c28 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
2 locks held by getty/3293:
 #0: ffff88802858a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90001c182e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 5.19.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc22/0xf90 kernel/hung_task.c:378
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 16 Comm: pr/ttyS0 Not tainted 5.19.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:io_serial_in+0x83/0xa0 drivers/tty/serial/8250/8250_port.c:461
Code: 29 1a fd 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 16 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d 41 5c c3 e8 10 4d 66 fd eb a6 e8 39 4d 66 fd eb e3
RSP: 0018:ffffc9000036fb10 EFLAGS: 00000002
RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff845f7e1c RDI: ffffffff91221a80
RBP: ffffffff91221a40 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: fffffbfff224439c R14: fffffbfff2244352 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f845ac6200 CR3: 000000007dccd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:118 [inline]
 wait_for_lsr+0x96/0xf0 drivers/tty/serial/8250/8250_port.c:2085
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3354 [inline]
 serial8250_console_write+0xc87/0xfe0 drivers/tty/serial/8250/8250_port.c:3436
 call_console_driver kernel/printk/printk.c:2075 [inline]
 __console_emit_next_record+0x896/0xa60 kernel/printk/printk.c:2916
 console_emit_next_record kernel/printk/printk.c:3721 [inline]
 printk_kthread_func.cold+0x702/0x73d kernel/printk/printk.c:3837
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	29 1a                	sub    %ebx,(%rdx)
   2:	fd                   	std
   3:	48 8d 7d 40          	lea    0x40(%rbp),%rdi
   7:	44 89 e1             	mov    %r12d,%ecx
   a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  11:	fc ff df
  14:	48 89 fa             	mov    %rdi,%rdx
  17:	d3 e3                	shl    %cl,%ebx
  19:	48 c1 ea 03          	shr    $0x3,%rdx
  1d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  21:	75 16                	jne    0x39
  23:	66 03 5d 40          	add    0x40(%rbp),%bx
  27:	89 da                	mov    %ebx,%edx
  29:	ec                   	in     (%dx),%al
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	0f b6 c0             	movzbl %al,%eax
  2e:	5d                   	pop    %rbp
  2f:	41 5c                	pop    %r12
  31:	c3                   	retq
  32:	e8 10 4d 66 fd       	callq  0xfd664d47
  37:	eb a6                	jmp    0xffffffdf
  39:	e8 39 4d 66 fd       	callq  0xfd664d77
  3e:	eb e3                	jmp    0x23

