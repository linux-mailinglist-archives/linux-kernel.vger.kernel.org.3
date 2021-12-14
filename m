Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC4473D58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhLNGwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:52:30 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:47657 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhLNGw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:52:29 -0500
Received: by mail-il1-f198.google.com with SMTP id g14-20020a056e021e0e00b002a26cb56bd4so16961426ila.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 22:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zqi/FO5r7GNQNPah8D8A7KOY+OPRZ9fAaTtANP54CBE=;
        b=XlIXBfa+NbR3pjaLq1x8fWlmTD9N3ttVLlvQEEFvsf75NeKrtmwoDytnKesrdPEyzD
         /6RYQihqmMZWHMUA9dAqs/5Ixp2wV8C0QH+8V+70Y1dFJfrSak4sqFJBM89R8yRHhkcZ
         8U1u3RVsInefmAI470HO1zRJ/hl8dfxGS233CrJt2WdehHGMfcH84w/C0DwgpKydLvBa
         i0FR7l6aHX7OlUYhy+9Zy1Uv0pJNpgqgEA8lXYsn1nmNTeERdejOII2KA0XgJF5SGFGI
         IVytbWUDvc/z3IoDtzkSgs/9QYi66DchSWeXh1RqVeqi2GufqOIUgzYURpfdINrBuGym
         M+Fg==
X-Gm-Message-State: AOAM531hj4suh8x7tnwnHJ/6f9IWuVGBEjjiLVyMJnEVBffPYYeHIWpG
        rARDLBfT8fdWHuQPfHF26k2rzOD0xK7RZoVnE8EGH+Z+nTWL
X-Google-Smtp-Source: ABdhPJwXnzUNMW2t1yxo46VXOWeXLA4pNCkK5lhrQGd8LCu5hAGp27ydmT/le+4Po8xk8dTP/OECltf0cTTQ8adetdiWtAk6RbaO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130f:: with SMTP id r15mr1796763jad.19.1639464749134;
 Mon, 13 Dec 2021 22:52:29 -0800 (PST)
Date:   Mon, 13 Dec 2021 22:52:29 -0800
In-Reply-To: <0000000000000ee20205c9e14847@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe769905d315a1b7@google.com>
Subject: Re: [syzbot] INFO: task hung in paste_selection (2)
From:   syzbot <syzbot+275e275bd3f536725dd8@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    5472f14a3742 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b56099b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44af4fa322f7642f
dashboard link: https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1557c0c1b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c3bc25b00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1224480e300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1124480e300000
console output: https://syzkaller.appspot.com/x/log.txt?x=1624480e300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+275e275bd3f536725dd8@syzkaller.appspotmail.com

INFO: task syz-executor843:3809 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28280 pid: 3809 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3812 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28280 pid: 3812 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3815 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28280 pid: 3815 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3818 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28616 pid: 3818 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3823 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:29256 pid: 3823 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3826 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28560 pid: 3826 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3827 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28616 pid: 3827 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3830 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28280 pid: 3830 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3833 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28616 pid: 3833 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor843:3836 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor843 state:D stack:28616 pid: 3836 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f25bdb16c39
RSP: 002b:00007f25bdac8318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f25bdb9f4a8 RCX: 00007f25bdb16c39
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f25bdb9f4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25bdb9f4ac
R13: 00007ffdf5d932af R14: 00007f25bdac8400 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
2 locks held by getty/3278:
 #0: ffff88802324d098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002b962e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2113
2 locks held by syz-executor843/3806:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3809:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3812:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3815:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3818:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3823:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3826:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3827:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3830:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3833:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3836:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3839:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3844:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3845:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3848:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3851:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3854:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3857:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3860:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3863:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3866:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3869:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3872:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3875:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3878:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3881:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3884:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3887:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3890:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3893:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3896:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3899:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3902:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3905:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3908:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3911:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3914:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3917:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3920:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3923:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3926:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3929:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3932:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3935:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3938:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3941:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3944:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3947:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3950:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3953:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3956:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3959:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3962:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3965:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3968:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3971:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3974:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3977:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3980:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3983:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3986:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3989:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3992:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3995:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/3998:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4001:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4004:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4007:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4010:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4013:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4016:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4019:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4022:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4025:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4028:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4031:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4034:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4037:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4040:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4043:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4046:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4049:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4052:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4055:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4058:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4061:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4064:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4067:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4070:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4073:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4076:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4079:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4082:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4085:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4088:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4091:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4094:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4097:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4100:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4103:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4106:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4109:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4112:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4115:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4118:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4121:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4124:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4127:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4130:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4133:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4136:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4139:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4142:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4145:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4148:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4151:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4154:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4157:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4160:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4163:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4166:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4169:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4172:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4175:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4178:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4181:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4184:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4187:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4190:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4193:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4196:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4199:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4202:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4205:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4208:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4211:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4214:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4217:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4220:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4223:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4226:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4229:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4232:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4235:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4238:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4241:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4244:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4247:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4250:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4253:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4256:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4259:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4262:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4265:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4268:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4271:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4274:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4277:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4280:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4283:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4286:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4289:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4292:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4295:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4298:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4301:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4304:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4307:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4310:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4313:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4316:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4319:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4322:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4325:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4328:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4331:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4334:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4337:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4340:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4343:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4346:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4350:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4353:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4356:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4359:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4362:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4366:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4369:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888010c790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor843/4372:
 #0: ffff888079897098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drive
