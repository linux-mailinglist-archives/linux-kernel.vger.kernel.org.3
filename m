Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323AE57E3E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiGVPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiGVPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:44:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCAB33402
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:44:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e15so6362365edj.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RjUGpU3c+pADzet1GtTIQkrVrxGIj5xVIS4Eann247U=;
        b=RGPJAUG6mN3o5dW5UFp3OVzm7TJXOqUCVwuFAyhoI/7B6QqAhaZZyV9mRnR4UJ8Pg6
         dnEM9sBIgkPaHp/uUrQ40wYuvn4AW9MSE+jzEZWznwN08ZME4akJSxg7nZx8FpLVryIN
         Lp2cMgdcMVgBWjYkmVc2hX7NFTGLu+jzvfgBcEBDVFM/GhgYmtLaHT1alSLMdJJ2+qfO
         vIwf0OmJxFyNnvAiHPUav+P56U2xWSmU7OROU3DVA0b+//AbqiRL/XhZ8LuZ/iip8ynr
         wabO5g36Zuf0u5wrmP5bdPxFagjxaVHYECTjj3fe8nhYja3hZjMVjwUPrqMADEsK5P8D
         YyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RjUGpU3c+pADzet1GtTIQkrVrxGIj5xVIS4Eann247U=;
        b=zSofn/Es5oc35+j4mgqrdKss7V1XNP7Yz/Qw3B0uW97fF+S4fFYcvI/ZtqT/BPqcCK
         PK/p+/aGUZ8/cCELDsjv6iPGe472rkxGQPY4omlPyqWmvpKGsoMkLHZsmynIMvZOc/Ay
         BUpX7R3W9/T4kklFCJDD3vM/ZYKTic7U0Y87r9GMMvFwjV2PmqDMgz/kFgkmQKX8d8r1
         GxDvfm7ya7J1zDi8vGTotx1KDEq8hVsT1OQFcGue3xg6tMp+eEelGWbwEP8sks1iVliN
         FcfEjhzfdkIA39F3nHlSFgRQTc4SSbwjqXaYr2xfeCG4XdxNRW0gyTfLAx2qBbzl6qsq
         k24w==
X-Gm-Message-State: AJIora/4AVAJ3TNRFPX3z+7sbKyDCJfQI0TihHzovIEzJlYRSJ+kveVj
        mHAuiSy1UuIcNuvMDcD9X/PSWWBPqvNS0RN4T5M=
X-Google-Smtp-Source: AGRyM1tLYC9ERToZxzO/Q96bXjFEyTqDH+uBR3TkQcd2BZHt3cFPRlerCHV6PHtiWHvOSFyALp+Fw4FQyA5/VQK7JqU=
X-Received: by 2002:a05:6402:753:b0:43b:a416:3963 with SMTP id
 p19-20020a056402075300b0043ba4163963mr461998edy.267.1658504695170; Fri, 22
 Jul 2022 08:44:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Fri, 22 Jul 2022 08:44:43 -0700
Message-ID: <CANX2M5YNDMLj7dr2dAQ5kv4jzE=8JiT=e0GXnW1VzJ1BHKeipw@mail.gmail.com>
Subject: INFO: task hung in __bread_gfp
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: multipart/mixed; boundary="000000000000370d3c05e466b767"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000370d3c05e466b767
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

======================================================
description: INFO: task hung in __bread_gfp
affected file: kernel/sched/core.c
kernel version: 5.19-rc6
kernel commit: 32346491ddf24599decca06190ebca03ff9de7f8
git tree: upstream
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=cd73026ceaed1402
crash reproducer: attached
======================================================
Crash log:
======================================================
INFO: task syz-executor.1:16085 blocked for more than 143 seconds.
      Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:27656 pid:16085 ppid:  6715 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa76/0x5140 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 io_schedule+0x17/0x70 kernel/sched/core.c:8645
 bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x60/0x190 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xd5/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 __wait_on_buffer fs/buffer.c:122 [inline]
 wait_on_buffer include/linux/buffer_head.h:355 [inline]
 __bread_slow fs/buffer.c:1178 [inline]
 __bread_gfp+0x2b8/0x370 fs/buffer.c:1381
 sb_bread include/linux/buffer_head.h:302 [inline]
 befs_fill_super+0x7f4/0x10d0 fs/befs/linuxvfs.c:856
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1228/0x1cb0 fs/namespace.c:3370
 do_mount+0xf3/0x110 fs/namespace.c:3383
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f0ade28d4ed
RSP: 002b:00007f0adf332be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0ade3abf60 RCX: 00007f0ade28d4ed
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 0000000020000140
RBP: 00007f0ade2f92e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffd73a61ff R14: 00007f0ade3abf60 R15: 00007f0adf332d80
 </TASK>
INFO: task syz-executor.0:16102 blocked for more than 143 seconds.
      Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28120 pid:16102 ppid:  6710 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa76/0x5140 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:180
 nbd_add_socket+0x102/0x7c0 drivers/block/nbd.c:1122
 __nbd_ioctl drivers/block/nbd.c:1463 [inline]
 nbd_ioctl+0x392/0x970 drivers/block/nbd.c:1520
 blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fc55a08d4ed
RSP: 002b:00007fc558811be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc55a1abf60 RCX: 00007fc55a08d4ed
RDX: 0000000000000006 RSI: 000000000000ab00 RDI: 0000000000000005
RBP: 00007fc55a0f92e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd96314b6f R14: 00007fc55a1abf60 R15: 00007fc558811d80
 </TASK>
INFO: task syz-executor.0:16105 blocked for more than 143 seconds.
      Tainted: G           OE     5.19.0-rc6-g2eae0556bb9d #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28120 pid:16105 ppid:  6710 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa76/0x5140 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xfa9/0x1f50 kernel/locking/mutex.c:747
 nbd_ioctl+0x155/0x970 drivers/block/nbd.c:1513
 blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fc55a08d4ed
RSP: 002b:00007fc5587cfbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc55a1ac120 RCX: 00007fc55a08d4ed
RDX: ffffffffffffffff RSI: 000000000000ab00 RDI: 0000000000000008
RBP: 00007fc55a0f92e1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd96314b6f R14: 00007fc55a1ac120 R15: 00007fc5587cfd80
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bd83aa0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
1 lock held by in:imklog/6665:
 #0: ffff88810093e368 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe3/0x100 fs/file.c:1036
1 lock held by syz-executor.1/16085:
 #0: ffff88817ae360e0 (&type->s_umount_key#51/1){+.+.}-{3:3}, at:
alloc_super+0x1dd/0xa80 fs/super.c:228
1 lock held by syz-executor.0/16102:
 #0: ffff8881140ff998 (&nbd->config_lock){+.+.}-{3:3}, at:
nbd_ioctl+0x155/0x970 drivers/block/nbd.c:1513
1 lock held by syz-executor.0/16105:
 #0: ffff8881140ff998 (&nbd->config_lock){+.+.}-{3:3}, at:
nbd_ioctl+0x155/0x970 drivers/block/nbd.c:1513

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Tainted: G           OE
5.19.0-rc6-g2eae0556bb9d #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1a1/0x1e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 7802 Comm: systemd-journal Tainted: G           OE
5.19.0-rc6-g2eae0556bb9d #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:check_kcov_mode+0x2e/0x40 kernel/kcov.c:177
Code: 9e 87 7e 89 c2 81 e2 00 01 00 00 a9 00 01 ff 00 74 10 31 c0 85
d2 74 15 8b 96 a4 15 00 00 85 d2 74 0b 8b 86 80 15 00 00 39 f8 <0f> 94
c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 31 c0 65 8b
RSP: 0018:ffffc9001c2c7928 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffc9001c2c7cf0 RCX: ffff8881a7ddbb00
RDX: 0000000000000000 RSI: ffff8881a7ddbb00 RDI: 0000000000000002
RBP: 0000000000000001 R08: ffffffff81dd256c R09: 0000000000000000
R10: 0000000000000007 R11: 000000000008a07a R12: 000000000000000c
R13: ffff888117d73068 R14: ffff888117d70bc0 R15: dffffc0000000000
FS:  00007f1e3485e8c0(0000) GS:ffff8881f5f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e2eb03000 CR3: 0000000134fca000 CR4: 0000000000150ee0
Call Trace:
 <TASK>
 __sanitizer_cov_trace_pc+0x1a/0x40 kernel/kcov.c:200
 __seqprop_spinlock_sequence include/linux/seqlock.h:275 [inline]
 __d_lookup_rcu+0x18c/0x740 fs/dcache.c:2345
 lookup_fast+0xe1/0x6d0 fs/namei.c:1624
 walk_component+0xcf/0x6a0 fs/namei.c:2010
 link_path_walk.part.0+0x787/0xeb0 fs/namei.c:2341
 link_path_walk fs/namei.c:2264 [inline]
 path_lookupat.isra.0+0x99/0x580 fs/namei.c:2492
 filename_lookup+0x1ca/0x410 fs/namei.c:2522
 user_path_at_empty+0x42/0x60 fs/namei.c:2895
 user_path_at include/linux/namei.h:57 [inline]
 do_faccessat+0x127/0x850 fs/open.c:446
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f1e332db9c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8
64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fffb696cbc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007fffb696fae0 RCX: 00007f1e332db9c7
RDX: 00007f1e34360a00 RSI: 0000000000000000 RDI: 000055b8fd7d89a3
RBP: 00007fffb696cc00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fffb696fae0 R15: 00007fffb696d0f0
 </TASK>
----------------
Code disassembly (best guess):
   0: 9e                    sahf
   1: 87 7e 89              xchg   %edi,-0x77(%rsi)
   4: c2 81 e2              retq   $0xe281
   7: 00 01                add    %al,(%rcx)
   9: 00 00                add    %al,(%rax)
   b: a9 00 01 ff 00        test   $0xff0100,%eax
  10: 74 10                je     0x22
  12: 31 c0                xor    %eax,%eax
  14: 85 d2                test   %edx,%edx
  16: 74 15                je     0x2d
  18: 8b 96 a4 15 00 00    mov    0x15a4(%rsi),%edx
  1e: 85 d2                test   %edx,%edx
  20: 74 0b                je     0x2d
  22: 8b 86 80 15 00 00    mov    0x1580(%rsi),%eax
  28: 39 f8                cmp    %edi,%eax
* 2a: 0f 94 c0              sete   %al <-- trapping instruction
  2d: c3                    retq
  2e: 66 66 2e 0f 1f 84 00 data16 nopw %cs:0x0(%rax,%rax,1)
  35: 00 00 00 00
  39: 0f 1f 00              nopl   (%rax)
  3c: 31 c0                xor    %eax,%eax
  3e: 65                    gs
  3f: 8b                    .byte 0x8b

-- 
Thanks and Regards,

Dipanjan

--000000000000370d3c05e466b767
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l5wmscef0>
X-Attachment-Id: f_l5wmscef0

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxzZXRqbXAuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RkYXJnLmg+
CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzdGRkZWYuaD4KI2luY2x1ZGUgPHN0ZGlu
dC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3Ry
aW5nLmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9tb3VudC5oPgojaW5j
bHVkZSA8c3lzL3ByY3RsLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5jbHVkZSA8c3lzL3N5
c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3dhaXQuaD4KI2lu
Y2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2luY2x1ZGUgPGxpbnV4L2xvb3Au
aD4KCiNpZm5kZWYgX19OUl9tZW1mZF9jcmVhdGUKI2RlZmluZSBfX05SX21lbWZkX2NyZWF0ZSAz
MTkKI2VuZGlmCgpzdGF0aWMgdW5zaWduZWQgbG9uZyBsb25nIHByb2NpZDsKCnN0YXRpYyBfX3Ro
cmVhZCBpbnQgY2xvbmVfb25nb2luZzsKc3RhdGljIF9fdGhyZWFkIGludCBza2lwX3NlZ3Y7CnN0
YXRpYyBfX3RocmVhZCBqbXBfYnVmIHNlZ3ZfZW52OwoKc3RhdGljIHZvaWQgc2Vndl9oYW5kbGVy
KGludCBzaWcsIHNpZ2luZm9fdCogaW5mbywgdm9pZCogY3R4KQp7CglpZiAoX19hdG9taWNfbG9h
ZF9uKCZjbG9uZV9vbmdvaW5nLCBfX0FUT01JQ19SRUxBWEVEKSAhPSAwKSB7CgkJZXhpdChzaWcp
OwoJfQoJdWludHB0cl90IGFkZHIgPSAodWludHB0cl90KWluZm8tPnNpX2FkZHI7Cgljb25zdCB1
aW50cHRyX3QgcHJvZ19zdGFydCA9IDEgPDwgMjA7Cgljb25zdCB1aW50cHRyX3QgcHJvZ19lbmQg
PSAxMDAgPDwgMjA7CglpbnQgc2tpcCA9IF9fYXRvbWljX2xvYWRfbigmc2tpcF9zZWd2LCBfX0FU
T01JQ19SRUxBWEVEKSAhPSAwOwoJaW50IHZhbGlkID0gYWRkciA8IHByb2dfc3RhcnQgfHwgYWRk
ciA+IHByb2dfZW5kOwoJaWYgKHNraXAgJiYgdmFsaWQpIHsKCQlfbG9uZ2ptcChzZWd2X2Vudiwg
MSk7Cgl9CglleGl0KHNpZyk7Cn0KCnN0YXRpYyB2b2lkIGluc3RhbGxfc2Vndl9oYW5kbGVyKHZv
aWQpCnsKCXN0cnVjdCBzaWdhY3Rpb24gc2E7CgltZW1zZXQoJnNhLCAwLCBzaXplb2Yoc2EpKTsK
CXNhLnNhX2hhbmRsZXIgPSBTSUdfSUdOOwoJc3lzY2FsbChTWVNfcnRfc2lnYWN0aW9uLCAweDIw
LCAmc2EsIE5VTEwsIDgpOwoJc3lzY2FsbChTWVNfcnRfc2lnYWN0aW9uLCAweDIxLCAmc2EsIE5V
TEwsIDgpOwoJbWVtc2V0KCZzYSwgMCwgc2l6ZW9mKHNhKSk7CglzYS5zYV9zaWdhY3Rpb24gPSBz
ZWd2X2hhbmRsZXI7CglzYS5zYV9mbGFncyA9IFNBX05PREVGRVIgfCBTQV9TSUdJTkZPOwoJc2ln
YWN0aW9uKFNJR1NFR1YsICZzYSwgTlVMTCk7CglzaWdhY3Rpb24oU0lHQlVTLCAmc2EsIE5VTEwp
Owp9CgojZGVmaW5lIE5PTkZBSUxJTkcoLi4uKSAoeyBpbnQgb2sgPSAxOyBfX2F0b21pY19mZXRj
aF9hZGQoJnNraXBfc2VndiwgMSwgX19BVE9NSUNfU0VRX0NTVCk7IGlmIChfc2V0am1wKHNlZ3Zf
ZW52KSA9PSAwKSB7IF9fVkFfQVJHU19fOyB9IGVsc2Ugb2sgPSAwOyBfX2F0b21pY19mZXRjaF9z
dWIoJnNraXBfc2VndiwgMSwgX19BVE9NSUNfU0VRX0NTVCk7IG9rOyB9KQoKc3RhdGljIHZvaWQg
c2xlZXBfbXModWludDY0X3QgbXMpCnsKCXVzbGVlcChtcyAqIDEwMDApOwp9CgpzdGF0aWMgdWlu
dDY0X3QgY3VycmVudF90aW1lX21zKHZvaWQpCnsKCXN0cnVjdCB0aW1lc3BlYyB0czsKCWlmIChj
bG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnRzKSkKCWV4aXQoMSk7CglyZXR1cm4gKHVp
bnQ2NF90KXRzLnR2X3NlYyAqIDEwMDAgKyAodWludDY0X3QpdHMudHZfbnNlYyAvIDEwMDAwMDA7
Cn0KCnN0YXRpYyBib29sIHdyaXRlX2ZpbGUoY29uc3QgY2hhciogZmlsZSwgY29uc3QgY2hhciog
d2hhdCwgLi4uKQp7CgljaGFyIGJ1ZlsxMDI0XTsKCXZhX2xpc3QgYXJnczsKCXZhX3N0YXJ0KGFy
Z3MsIHdoYXQpOwoJdnNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksIHdoYXQsIGFyZ3MpOwoJdmFf
ZW5kKGFyZ3MpOwoJYnVmW3NpemVvZihidWYpIC0gMV0gPSAwOwoJaW50IGxlbiA9IHN0cmxlbihi
dWYpOwoJaW50IGZkID0gb3BlbihmaWxlLCBPX1dST05MWSB8IE9fQ0xPRVhFQyk7CglpZiAoZmQg
PT0gLTEpCgkJcmV0dXJuIGZhbHNlOwoJaWYgKHdyaXRlKGZkLCBidWYsIGxlbikgIT0gbGVuKSB7
CgkJaW50IGVyciA9IGVycm5vOwoJCWNsb3NlKGZkKTsKCQllcnJubyA9IGVycjsKCQlyZXR1cm4g
ZmFsc2U7Cgl9CgljbG9zZShmZCk7CglyZXR1cm4gdHJ1ZTsKfQoKc3RhdGljIGxvbmcgc3l6X29w
ZW5fZGV2KHZvbGF0aWxlIGxvbmcgYTAsIHZvbGF0aWxlIGxvbmcgYTEsIHZvbGF0aWxlIGxvbmcg
YTIpCnsKCWlmIChhMCA9PSAweGMgfHwgYTAgPT0gMHhiKSB7CgkJY2hhciBidWZbMTI4XTsKCQlz
cHJpbnRmKGJ1ZiwgIi9kZXYvJXMvJWQ6JWQiLCBhMCA9PSAweGMgPyAiY2hhciIgOiAiYmxvY2si
LCAodWludDhfdClhMSwgKHVpbnQ4X3QpYTIpOwoJCXJldHVybiBvcGVuKGJ1ZiwgT19SRFdSLCAw
KTsKCX0gZWxzZSB7CgkJY2hhciBidWZbMTAyNF07CgkJY2hhciogaGFzaDsKCQlzdHJuY3B5KGJ1
ZiwgKGNoYXIqKWEwLCBzaXplb2YoYnVmKSAtIDEpOwoJCWJ1ZltzaXplb2YoYnVmKSAtIDFdID0g
MDsKCQl3aGlsZSAoKGhhc2ggPSBzdHJjaHIoYnVmLCAnIycpKSkgewoJCQkqaGFzaCA9ICcwJyAr
IChjaGFyKShhMSAlIDEwKTsKCQkJYTEgLz0gMTA7CgkJfQoJCXJldHVybiBvcGVuKGJ1ZiwgYTIs
IDApOwoJfQp9CgpzdHJ1Y3QgZnNfaW1hZ2Vfc2VnbWVudCB7Cgl2b2lkKiBkYXRhOwoJdWludHB0
cl90IHNpemU7Cgl1aW50cHRyX3Qgb2Zmc2V0Owp9OwoKI2RlZmluZSBJTUFHRV9NQVhfU0VHTUVO
VFMgNDA5NgojZGVmaW5lIElNQUdFX01BWF9TSVpFICgxMjkgPDwgMjApCgpzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBmc19pbWFnZV9zZWdtZW50X2NoZWNrKHVuc2lnbmVkIGxvbmcgc2l6ZSwgdW5zaWdu
ZWQgbG9uZyBuc2Vncywgc3RydWN0IGZzX2ltYWdlX3NlZ21lbnQqIHNlZ3MpCnsKCWlmIChuc2Vn
cyA+IElNQUdFX01BWF9TRUdNRU5UUykKCQluc2VncyA9IElNQUdFX01BWF9TRUdNRU5UUzsKCWZv
ciAoc2l6ZV90IGkgPSAwOyBpIDwgbnNlZ3M7IGkrKykgewoJCWlmIChzZWdzW2ldLnNpemUgPiBJ
TUFHRV9NQVhfU0laRSkKCQkJc2Vnc1tpXS5zaXplID0gSU1BR0VfTUFYX1NJWkU7CgkJc2Vnc1tp
XS5vZmZzZXQgJT0gSU1BR0VfTUFYX1NJWkU7CgkJaWYgKHNlZ3NbaV0ub2Zmc2V0ID4gSU1BR0Vf
TUFYX1NJWkUgLSBzZWdzW2ldLnNpemUpCgkJCXNlZ3NbaV0ub2Zmc2V0ID0gSU1BR0VfTUFYX1NJ
WkUgLSBzZWdzW2ldLnNpemU7CgkJaWYgKHNpemUgPCBzZWdzW2ldLm9mZnNldCArIHNlZ3NbaV0u
b2Zmc2V0KQoJCQlzaXplID0gc2Vnc1tpXS5vZmZzZXQgKyBzZWdzW2ldLm9mZnNldDsKCX0KCWlm
IChzaXplID4gSU1BR0VfTUFYX1NJWkUpCgkJc2l6ZSA9IElNQUdFX01BWF9TSVpFOwoJcmV0dXJu
IHNpemU7Cn0Kc3RhdGljIGludCBzZXR1cF9sb29wX2RldmljZShsb25nIHVuc2lnbmVkIHNpemUs
IGxvbmcgdW5zaWduZWQgbnNlZ3MsIHN0cnVjdCBmc19pbWFnZV9zZWdtZW50KiBzZWdzLCBjb25z
dCBjaGFyKiBsb29wbmFtZSwgaW50KiBtZW1mZF9wLCBpbnQqIGxvb3BmZF9wKQp7CglpbnQgZXJy
ID0gMCwgbG9vcGZkID0gLTE7CglzaXplID0gZnNfaW1hZ2Vfc2VnbWVudF9jaGVjayhzaXplLCBu
c2Vncywgc2Vncyk7CglpbnQgbWVtZmQgPSBzeXNjYWxsKF9fTlJfbWVtZmRfY3JlYXRlLCAic3l6
a2FsbGVyIiwgMCk7CglpZiAobWVtZmQgPT0gLTEpIHsKCQllcnIgPSBlcnJubzsKCQlnb3RvIGVy
cm9yOwoJfQoJaWYgKGZ0cnVuY2F0ZShtZW1mZCwgc2l6ZSkpIHsKCQllcnIgPSBlcnJubzsKCQln
b3RvIGVycm9yX2Nsb3NlX21lbWZkOwoJfQoJZm9yIChzaXplX3QgaSA9IDA7IGkgPCBuc2Vnczsg
aSsrKSB7CgkJaWYgKHB3cml0ZShtZW1mZCwgc2Vnc1tpXS5kYXRhLCBzZWdzW2ldLnNpemUsIHNl
Z3NbaV0ub2Zmc2V0KSA8IDApIHsKCQl9Cgl9Cglsb29wZmQgPSBvcGVuKGxvb3BuYW1lLCBPX1JE
V1IpOwoJaWYgKGxvb3BmZCA9PSAtMSkgewoJCWVyciA9IGVycm5vOwoJCWdvdG8gZXJyb3JfY2xv
c2VfbWVtZmQ7Cgl9CglpZiAoaW9jdGwobG9vcGZkLCBMT09QX1NFVF9GRCwgbWVtZmQpKSB7CgkJ
aWYgKGVycm5vICE9IEVCVVNZKSB7CgkJCWVyciA9IGVycm5vOwoJCQlnb3RvIGVycm9yX2Nsb3Nl
X2xvb3A7CgkJfQoJCWlvY3RsKGxvb3BmZCwgTE9PUF9DTFJfRkQsIDApOwoJCXVzbGVlcCgxMDAw
KTsKCQlpZiAoaW9jdGwobG9vcGZkLCBMT09QX1NFVF9GRCwgbWVtZmQpKSB7CgkJCWVyciA9IGVy
cm5vOwoJCQlnb3RvIGVycm9yX2Nsb3NlX2xvb3A7CgkJfQoJfQoJKm1lbWZkX3AgPSBtZW1mZDsK
CSpsb29wZmRfcCA9IGxvb3BmZDsKCXJldHVybiAwOwoKZXJyb3JfY2xvc2VfbG9vcDoKCWNsb3Nl
KGxvb3BmZCk7CmVycm9yX2Nsb3NlX21lbWZkOgoJY2xvc2UobWVtZmQpOwplcnJvcjoKCWVycm5v
ID0gZXJyOwoJcmV0dXJuIC0xOwp9CgpzdGF0aWMgbG9uZyBzeXpfbW91bnRfaW1hZ2Uodm9sYXRp
bGUgbG9uZyBmc2FyZywgdm9sYXRpbGUgbG9uZyBkaXIsIHZvbGF0aWxlIHVuc2lnbmVkIGxvbmcg
c2l6ZSwgdm9sYXRpbGUgdW5zaWduZWQgbG9uZyBuc2Vncywgdm9sYXRpbGUgbG9uZyBzZWdtZW50
cywgdm9sYXRpbGUgbG9uZyBmbGFncywgdm9sYXRpbGUgbG9uZyBvcHRzYXJnKQp7CglzdHJ1Y3Qg
ZnNfaW1hZ2Vfc2VnbWVudCogc2VncyA9IChzdHJ1Y3QgZnNfaW1hZ2Vfc2VnbWVudCopc2VnbWVu
dHM7CglpbnQgcmVzID0gLTEsIGVyciA9IDAsIGxvb3BmZCA9IC0xLCBtZW1mZCA9IC0xLCBuZWVk
X2xvb3BfZGV2aWNlID0gISFzZWdzOwoJY2hhciogbW91bnRfb3B0cyA9IChjaGFyKilvcHRzYXJn
OwoJY2hhciogdGFyZ2V0ID0gKGNoYXIqKWRpcjsKCWNoYXIqIGZzID0gKGNoYXIqKWZzYXJnOwoJ
Y2hhciogc291cmNlID0gTlVMTDsKCWNoYXIgbG9vcG5hbWVbNjRdOwoJaWYgKG5lZWRfbG9vcF9k
ZXZpY2UpIHsKCQltZW1zZXQobG9vcG5hbWUsIDAsIHNpemVvZihsb29wbmFtZSkpOwoJCXNucHJp
bnRmKGxvb3BuYW1lLCBzaXplb2YobG9vcG5hbWUpLCAiL2Rldi9sb29wJWxsdSIsIHByb2NpZCk7
CgkJaWYgKHNldHVwX2xvb3BfZGV2aWNlKHNpemUsIG5zZWdzLCBzZWdzLCBsb29wbmFtZSwgJm1l
bWZkLCAmbG9vcGZkKSA9PSAtMSkKCQkJcmV0dXJuIC0xOwoJCXNvdXJjZSA9IGxvb3BuYW1lOwoJ
fQoJbWtkaXIodGFyZ2V0LCAwNzc3KTsKCWNoYXIgb3B0c1syNTZdOwoJbWVtc2V0KG9wdHMsIDAs
IHNpemVvZihvcHRzKSk7CglpZiAoc3RybGVuKG1vdW50X29wdHMpID4gKHNpemVvZihvcHRzKSAt
IDMyKSkgewoJfQoJc3RybmNweShvcHRzLCBtb3VudF9vcHRzLCBzaXplb2Yob3B0cykgLSAzMik7
CglpZiAoc3RyY21wKGZzLCAiaXNvOTY2MCIpID09IDApIHsKCQlmbGFncyB8PSBNU19SRE9OTFk7
Cgl9IGVsc2UgaWYgKHN0cm5jbXAoZnMsICJleHQiLCAzKSA9PSAwKSB7CgkJaWYgKHN0cnN0cihv
cHRzLCAiZXJyb3JzPXBhbmljIikgfHwgc3Ryc3RyKG9wdHMsICJlcnJvcnM9cmVtb3VudC1ybyIp
ID09IDApCgkJCXN0cmNhdChvcHRzLCAiLGVycm9ycz1jb250aW51ZSIpOwoJfSBlbHNlIGlmIChz
dHJjbXAoZnMsICJ4ZnMiKSA9PSAwKSB7CgkJc3RyY2F0KG9wdHMsICIsbm91dWlkIik7Cgl9Cgly
ZXMgPSBtb3VudChzb3VyY2UsIHRhcmdldCwgZnMsIGZsYWdzLCBvcHRzKTsKCWlmIChyZXMgPT0g
LTEpIHsKCQllcnIgPSBlcnJubzsKCQlnb3RvIGVycm9yX2NsZWFyX2xvb3A7Cgl9CglyZXMgPSBv
cGVuKHRhcmdldCwgT19SRE9OTFkgfCBPX0RJUkVDVE9SWSk7CglpZiAocmVzID09IC0xKSB7CgkJ
ZXJyID0gZXJybm87Cgl9CgplcnJvcl9jbGVhcl9sb29wOgoJaWYgKG5lZWRfbG9vcF9kZXZpY2Up
IHsKCQlpb2N0bChsb29wZmQsIExPT1BfQ0xSX0ZELCAwKTsKCQljbG9zZShsb29wZmQpOwoJCWNs
b3NlKG1lbWZkKTsKCX0KCWVycm5vID0gZXJyOwoJcmV0dXJuIHJlczsKfQoKc3RhdGljIHZvaWQg
a2lsbF9hbmRfd2FpdChpbnQgcGlkLCBpbnQqIHN0YXR1cykKewoJa2lsbCgtcGlkLCBTSUdLSUxM
KTsKCWtpbGwocGlkLCBTSUdLSUxMKTsKCWZvciAoaW50IGkgPSAwOyBpIDwgMTAwOyBpKyspIHsK
CQlpZiAod2FpdHBpZCgtMSwgc3RhdHVzLCBXTk9IQU5HIHwgX19XQUxMKSA9PSBwaWQpCgkJCXJl
dHVybjsKCQl1c2xlZXAoMTAwMCk7Cgl9CglESVIqIGRpciA9IG9wZW5kaXIoIi9zeXMvZnMvZnVz
ZS9jb25uZWN0aW9ucyIpOwoJaWYgKGRpcikgewoJCWZvciAoOzspIHsKCQkJc3RydWN0IGRpcmVu
dCogZW50ID0gcmVhZGRpcihkaXIpOwoJCQlpZiAoIWVudCkKCQkJCWJyZWFrOwoJCQlpZiAoc3Ry
Y21wKGVudC0+ZF9uYW1lLCAiLiIpID09IDAgfHwgc3RyY21wKGVudC0+ZF9uYW1lLCAiLi4iKSA9
PSAwKQoJCQkJY29udGludWU7CgkJCWNoYXIgYWJvcnRbMzAwXTsKCQkJc25wcmludGYoYWJvcnQs
IHNpemVvZihhYm9ydCksICIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMvJXMvYWJvcnQiLCBlbnQt
PmRfbmFtZSk7CgkJCWludCBmZCA9IG9wZW4oYWJvcnQsIE9fV1JPTkxZKTsKCQkJaWYgKGZkID09
IC0xKSB7CgkJCQljb250aW51ZTsKCQkJfQoJCQlpZiAod3JpdGUoZmQsIGFib3J0LCAxKSA8IDAp
IHsKCQkJfQoJCQljbG9zZShmZCk7CgkJfQoJCWNsb3NlZGlyKGRpcik7Cgl9IGVsc2UgewoJfQoJ
d2hpbGUgKHdhaXRwaWQoLTEsIHN0YXR1cywgX19XQUxMKSAhPSBwaWQpIHsKCX0KfQoKc3RhdGlj
IHZvaWQgcmVzZXRfbG9vcCgpCnsKCWNoYXIgYnVmWzY0XTsKCXNucHJpbnRmKGJ1Ziwgc2l6ZW9m
KGJ1ZiksICIvZGV2L2xvb3AlbGx1IiwgcHJvY2lkKTsKCWludCBsb29wZmQgPSBvcGVuKGJ1Ziwg
T19SRFdSKTsKCWlmIChsb29wZmQgIT0gLTEpIHsKCQlpb2N0bChsb29wZmQsIExPT1BfQ0xSX0ZE
LCAwKTsKCQljbG9zZShsb29wZmQpOwoJfQp9CgpzdGF0aWMgdm9pZCBzZXR1cF90ZXN0KCkKewoJ
cHJjdGwoUFJfU0VUX1BERUFUSFNJRywgU0lHS0lMTCwgMCwgMCwgMCk7CglzZXRwZ3JwKCk7Cgl3
cml0ZV9maWxlKCIvcHJvYy9zZWxmL29vbV9zY29yZV9hZGoiLCAiMTAwMCIpOwp9CgpzdGF0aWMg
dm9pZCBleGVjdXRlX29uZSh2b2lkKTsKCiNkZWZpbmUgV0FJVF9GTEFHUyBfX1dBTEwKCnN0YXRp
YyB2b2lkIGxvb3Aodm9pZCkKewoJaW50IGl0ZXIgPSAwOwoJZm9yICg7OyBpdGVyKyspIHsKCQly
ZXNldF9sb29wKCk7CgkJaW50IHBpZCA9IGZvcmsoKTsKCQlpZiAocGlkIDwgMCkKCWV4aXQoMSk7
CgkJaWYgKHBpZCA9PSAwKSB7CgkJCXNldHVwX3Rlc3QoKTsKCQkJZXhlY3V0ZV9vbmUoKTsKCQkJ
ZXhpdCgwKTsKCQl9CgkJaW50IHN0YXR1cyA9IDA7CgkJdWludDY0X3Qgc3RhcnQgPSBjdXJyZW50
X3RpbWVfbXMoKTsKCQlmb3IgKDs7KSB7CgkJCWlmICh3YWl0cGlkKC0xLCAmc3RhdHVzLCBXTk9I
QU5HIHwgV0FJVF9GTEFHUykgPT0gcGlkKQoJCQkJYnJlYWs7CgkJCXNsZWVwX21zKDEpOwoJCQlp
ZiAoY3VycmVudF90aW1lX21zKCkgLSBzdGFydCA8IDUwMDApCgkJCQljb250aW51ZTsKCQkJa2ls
bF9hbmRfd2FpdChwaWQsICZzdGF0dXMpOwoJCQlicmVhazsKCQl9Cgl9Cn0KCnVpbnQ2NF90IHJb
Ml0gPSB7MHhmZmZmZmZmZmZmZmZmZmZmLCAweGZmZmZmZmZmZmZmZmZmZmZ9OwoKdm9pZCBleGVj
dXRlX29uZSh2b2lkKQp7CgkJaW50cHRyX3QgcmVzID0gMDsKCU5PTkZBSUxJTkcobWVtY3B5KCh2
b2lkKikweDIwMDAwMDgwLCAiL2Rldi9uYmQjXDAwMCIsIDEwKSk7CglyZXMgPSAtMTsKCU5PTkZB
SUxJTkcocmVzID0gc3l6X29wZW5fZGV2KDB4MjAwMDAwODAsIDAsIDApKTsKCWlmIChyZXMgIT0g
LTEpCgkJclswXSA9IHJlczsKCXJlcyA9IHN5c2NhbGwoX19OUl9zb2NrZXRwYWlyLCAxdWwsIDF1
bCwgMCwgMHgyMDAwMDAwMHVsKTsKCWlmIChyZXMgIT0gLTEpCgkJTk9ORkFJTElORyhyWzFdID0g
Kih1aW50MzJfdCopMHgyMDAwMDAwMCk7CglzeXNjYWxsKF9fTlJfaW9jdGwsIHJbMF0sIDB4YWIw
MCwgclsxXSk7CglOT05GQUlMSU5HKG1lbWNweSgodm9pZCopMHgyMDAwMDBjMCwgIi4vZmlsZTBc
MDAwIiwgOCkpOwoJTk9ORkFJTElORyhzeXpfbW91bnRfaW1hZ2UoMCwgMHgyMDAwMDBjMCwgMCwg
MCwgMCwgMCwgMCkpOwoJTk9ORkFJTElORyhtZW1jcHkoKHZvaWQqKTB4MjAwMDAxNDAsICJceDJm
XHg2NFx4NjVceDc2XHgyZlx4NmVceDYyXHg2NFx4MzBceDAwXHhmNVx4MjNceGM1XHg4ZVx4NGZc
eDJhXHgzM1x4MDlceDdjXHhkN1x4MjdceDhhXHhlM1x4NzZceGQxXHg2Nlx4N2JceDc2XHhiZVx4
ODNceDAwXHgxMFx4YmFceDMwXHg1Nlx4MzZceDZjXHg1NFx4ODBceDExXHg3NVx4YmZceDZjXHhj
OFx4OGVceGVlXHhlYVx4NjNceDRjXHgyYVx4MDVceDEzXHg5OFx4OWZceGMzXHhhYVx4MWVceGM4
XHg4NVx4NjVceGI2XHhiNFx4YjRceDE3XHg5Ylx4YzdceGJiXHhmNlx4MWVceDg1XHhmOVx4MzRc
eDBlXHhmN1x4MzZceDBjXHgwMlx4MDBceDkyXHg2NVx4MWRceDk5XHg1Zlx4OGZceDYwXHhmMFx4
MjdceGYxXHhlZFx4NDFceGViXHhjY1x4ODRceGFlXHg0MFx4YWFceDBmXHg1Nlx4NjZceDFlXHhk
M1x4YTlceDgyXHg3N1x4YzRceDllXHhkM1x4MDBceDAwXHgwMFx4NjBceDAwXHgwY1x4OWNceGY3
XHhmZlx4N2ZceDAwXHgwMFx4NTRceGFhXHgwMFx4MDBceDAwXHgwMCIsIDEyNSkpOwoJTk9ORkFJ
TElORyhtZW1jcHkoKHZvaWQqKTB4MjAwMDAwNDAsICIuL2ZpbGUwXDAwMCIsIDgpKTsKCU5PTkZB
SUxJTkcobWVtY3B5KCh2b2lkKikweDIwMDAwMDAwLCAiYmVmc1wwMDAiLCA1KSk7CglzeXNjYWxs
KF9fTlJfbW91bnQsIDB4MjAwMDAxNDB1bCwgMHgyMDAwMDA0MHVsLCAweDIwMDAwMDAwdWwsIDB4
MTB1bCwgMHVsKTsKCn0KaW50IG1haW4odm9pZCkKewoJCXN5c2NhbGwoX19OUl9tbWFwLCAweDFm
ZmZmMDAwdWwsIDB4MTAwMHVsLCAwdWwsIDB4MzJ1bCwgLTEsIDB1bCk7CglzeXNjYWxsKF9fTlJf
bW1hcCwgMHgyMDAwMDAwMHVsLCAweDEwMDAwMDB1bCwgN3VsLCAweDMydWwsIC0xLCAwdWwpOwoJ
c3lzY2FsbChfX05SX21tYXAsIDB4MjEwMDAwMDB1bCwgMHgxMDAwdWwsIDB1bCwgMHgzMnVsLCAt
MSwgMHVsKTsKCWluc3RhbGxfc2Vndl9oYW5kbGVyKCk7CgkJCWxvb3AoKTsKCXJldHVybiAwOwp9
Cg==
--000000000000370d3c05e466b767
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_l5wmscet1>
X-Attachment-Id: f_l5wmscet1

cjAgPSBzeXpfb3Blbl9kZXYkbmRiKCYoMHg3ZjAwMDAwMDAwODApLCAweDAsIDB4MCkKc29ja2V0
cGFpciRuYmQoMHgxLCAweDEsIDB4MCwgJigweDdmMDAwMDAwMDAwMCk9ezxyMT0+MHhmZmZmZmZm
ZmZmZmZmZmZmfSkKaW9jdGwkTkJEX1NFVF9TT0NLKHIwLCAweGFiMDAsIHIxKQpzeXpfbW91bnRf
aW1hZ2UkYmVmcygweDAsICYoMHg3ZjAwMDAwMDAwYzApPScuL2ZpbGUwXHgwMCcsIDB4MCwgMHgw
LCAweDAsIDB4MCwgMHgwKQptb3VudCgmKDB4N2YwMDAwMDAwMTQwKT1BTlk9W0BBTllCTE9CPSIy
ZjY0NjU3NjJmNmU2MjY0MzAwMGY1MjNjNThlNGYyYTMzMDk3Y2Q3Mjc4YWUzNzZkMTY2N2I3NmJl
ODMwMDEwYmEzMDU2MzY2YzU0ODAxMTc1YmY2Y2M4OGVlZWVhNjM0YzJhMDUxMzk4OWZjM2FhMWVj
ODg1NjViNmI0YjQxNzliYzdiYmY2MWU4NWY5MzQwZWY3MzYwYzAyMDA5MjY1MWQ5OTVmOGY2MGYw
MjdmMWVkNDFlYmNjODRhZTQwYWEwZjU2NjYxZWQzYTk4Mjc3YzQ5ZWQzMDAwMDAwNjAwMDBjOWNm
N2ZmN2YwMDAwNTRhYTAwMDAwMDAwIl0sICYoMHg3ZjAwMDAwMDAwNDApPScuL2ZpbGUwXHgwMCcs
ICYoMHg3ZjAwMDAwMDAwMDApPSdiZWZzXHgwMCcsIDB4MTAsIDB4MCkK
--000000000000370d3c05e466b767--
