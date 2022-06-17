Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047B154F63A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382346AbiFQLCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382340AbiFQLCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:02:33 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CAE6CAA6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:02:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n19-20020a056602341300b0066850b49e09so2334361ioz.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HyXFehABl+7QL2Y6QnW1Ir7miTXNYNj//hof0DssKgc=;
        b=B8B0SlwSboWaoBzV8azn2zn3NJYrLz6WgwDNNBNqw0nLyagPpb2YmMa0I+dRqoFrA6
         wskc6wot//xbOmhlyZ3h7NiAzXK3YXQlHs2HQcwQLewRhW9/BdJ3WZD+Ut6HNB/MaSPj
         42AzdyqGperlFxTeR63Wk6gjdSbgwXt/TYXEw3lkKkfukk7Bfp9G5fi9Dz7geDvXhEJE
         8i4Zdw0uElM0vQ8GTlO9tadvWTrHAa/nGSNzEfPNPuf3RrIKgr+OBy7zX+xxqwMFVXVw
         BDBwj8BEzQHZqxxjCaQr9fEU6Dv+AiIQ90xc6gelgpscAyYQiPKFG/8oG2HzuhT983k7
         ruCQ==
X-Gm-Message-State: AJIora8yHYnPz7vof/sAAG3/nyNA+rxcZqYIpK0MbW5Dix9ImE2YVgtf
        tBnFNGd8ouN3AxnGoIScXHciPjggiV/y7JyNQPp0B1ZAYpeQ
X-Google-Smtp-Source: AGRyM1vmjQ/bdkFysu6pU9/R0IHadGHtw/gJjL+ft0AGU24U1K5gbZQuj2kwv9f0nfg5JE15VCTBiOMJk7qHSYD4e8Kwf2HgYcR0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:2d5:ef3:999e with SMTP id
 x13-20020a056e02194d00b002d50ef3999emr5557271ilu.192.1655463742291; Fri, 17
 Jun 2022 04:02:22 -0700 (PDT)
Date:   Fri, 17 Jun 2022 04:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c477d05e1a2b0e4@google.com>
Subject: [syzbot] linux-next boot error: WARNING in ct_idle_exit
From:   syzbot <syzbot+4d413df7954a713bc5c4@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
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

HEAD commit:    07dc787be231 Add linux-next specific files for 20220617
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1409b090080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2512136c9b01d87
dashboard link: https://syzkaller.appspot.com/bug?extid=4d413df7954a713bc5c4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d413df7954a713bc5c4@syzkaller.appspotmail.com

kfence: initialized - using 2097152 bytes for 255 objects at 0xffff88823bc00000-0xffff88823be00000
random: crng init done
Console: colour VGA+ 80x25
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     131072
... MAX_LOCKDEP_CHAINS:      262144
... CHAINHASH_SIZE:          131072
 memory used by lock dependency info: 20657 kB
 memory used for stack traces: 8320 kB
 per task-struct memory footprint: 1920 bytes
mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
ACPI: Core revision 20220331
APIC: Switch to symmetric I/O mode setup
..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fb63109b96, max_idle_ns: 440795265316 ns
Calibrating delay loop (skipped) preset value.. 4399.99 BogoMIPS (lpj=21999980)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
landlock: Up and running.
Yama: becoming mindful.
TOMOYO Linux initialized
AppArmor: AppArmor initialized
LSM support for eBPF active
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, vmalloc hugepage)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc hugepage)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
Spectre V2 : Vulnerable
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Enabling Restricted Speculation for firmware calls
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Spectre V2 : User space: Mitigation: STIBP via prctl
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
MDS: Mitigation: Clear CPU buffers
TAA: Mitigation: Clear CPU buffers
MMIO Stale Data: Vulnerable: Clear CPU buffers attempted, no microcode
Freeing SMP alternatives memory: 108K
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:335 ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335

=============================
WARNING: suspicious RCU usage
5.19.0-rc2-next-20220617-syzkaller #0 Not tainted
-----------------------------
include/trace/events/lock.h:24 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2-next-20220617-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire.cold+0x1f/0x40 kernel/locking/lockdep.c:5636
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 down_trylock+0xe/0x60 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0xfb/0x120 kernel/printk/printk.c:276
 console_trylock+0x13/0xd0 kernel/printk/printk.c:2731
 console_trylock_spinning kernel/printk/printk.c:2003 [inline]
 vprintk_emit+0x127/0x680 kernel/printk/printk.c:2403
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
 _printk+0xba/0xed kernel/printk/printk.c:2425
 __warn+0x91/0x190 kernel/panic.c:611
 report_bug+0x1bc/0x210 lib/bug.c:198
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
 asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0000:ffffffff8ba07d90 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffffffff8babc980 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7c0200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 rest_init+0x169/0x270 init/main.c:729
 arch_call_rest_init+0xf/0x14 init/main.c:886
 start_kernel+0x473/0x494 init/main.c:1142
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>

=============================
WARNING: suspicious RCU usage
5.19.0-rc2-next-20220617-syzkaller #0 Not tainted
-----------------------------
include/trace/events/lock.h:69 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: ffffffff8bd75ed8 ((console_sem).lock){....}-{2:2}, at: down_trylock+0xe/0x60 kernel/locking/semaphore.c:139

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2-next-20220617-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release.cold+0x1f/0x4e kernel/locking/lockdep.c:5676
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
 _raw_spin_unlock_irqrestore+0x16/0x70 kernel/locking/spinlock.c:194
 down_trylock+0x45/0x60 kernel/locking/semaphore.c:143
 __down_trylock_console_sem+0xfb/0x120 kernel/printk/printk.c:276
 console_trylock+0x13/0xd0 kernel/printk/printk.c:2731
 console_trylock_spinning kernel/printk/printk.c:2003 [inline]
 vprintk_emit+0x127/0x680 kernel/printk/printk.c:2403
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
 _printk+0xba/0xed kernel/printk/printk.c:2425
 __warn+0x91/0x190 kernel/panic.c:611
 report_bug+0x1bc/0x210 lib/bug.c:198
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
 asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0000:ffffffff8ba07d90 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffffffff8babc980 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7c0200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 rest_init+0x169/0x270 init/main.c:729
 arch_call_rest_init+0xf/0x14 init/main.c:886
 start_kernel+0x473/0x494 init/main.c:1142
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2-next-20220617-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0000:ffffffff8ba07d90 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffffffff8babc980 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7c0200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 rest_init+0x169/0x270 init/main.c:729
 arch_call_rest_init+0xf/0x14 init/main.c:886
 start_kernel+0x473/0x494 init/main.c:1142
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
