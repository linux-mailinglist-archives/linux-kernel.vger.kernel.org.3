Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B7E49AC17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiAYF4j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 00:56:39 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:37737 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbiAYFxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:53:30 -0500
Received: by mail-il1-f200.google.com with SMTP id 20-20020a056e020cb400b002b93016fbccso11194018ilg.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=YnPINOM1amYfIANn8VMtbF+2lfN7hx/91F1ilinavvA=;
        b=Uj1q8N5kYPJTqt93JoF0OdF9a2yWQVcNcE9Vf9/NuB9E8BJm3umc/Js/gH9qvcBq7V
         m/Hyr4zCm2/4tY8JoeN+XP4GHD3nPIWznBH+TxjOCyjZ8VvNZWrxaH3mGqGR0j+7cRXU
         2pFcsNU6qywy5+v2iYYPNgLK87TJrKOFF2L4HrhbZwTHNeAX/5Wvatlo5qn1AEN+FHmP
         AjJvhmIhkM7GhqEOGJpSSEfqb/n2wPO4nCTJNW/4reL/iyfOcvCOgvnQ884ZU5D5AyUm
         5odE+jj2JACQBBUG/9TMnqULXeNSK5IB2Hn5w+ljp4xju0IthJTgcOEfw6FV4NW5MlC0
         /ESw==
X-Gm-Message-State: AOAM531UG5sVRPwkVAisWCIIaP0mf7nUfN9zgYqnhW5MH93kxugWQ3rV
        6CyPBRe1LoMbwKKIz6Xg+OuvH2/VaLj/DicMPIjxu2aFSw6u
X-Google-Smtp-Source: ABdhPJyqkxV2fmhs0t/VEgAx1yiCBRbAf7kZkcQud7agrvYWIiL9H/hPuO9K4fhArqVmkH6lD4wLRXkVsMkOttv5MSH+/Xzh/wfS
MIME-Version: 1.0
X-Received: by 2002:a05:6638:18a:: with SMTP id a10mr3587310jaq.67.1643090004286;
 Mon, 24 Jan 2022 21:53:24 -0800 (PST)
Date:   Mon, 24 Jan 2022 21:53:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a23c405d661b424@google.com>
Subject: [syzbot] linux-next boot error: WARNING in trace_event_raw_init
From:   syzbot <syzbot+1d26fcb1fe004a77c13b@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        mingo@redhat.com, rostedt@goodmis.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d25ee8853025 Add linux-next specific files for 20220125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=119946e0700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=498f66b8e27b8823
dashboard link: https://syzkaller.appspot.com/bug?extid=1d26fcb1fe004a77c13b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d26fcb1fe004a77c13b@syzkaller.appspotmail.com

On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
On node 0, zone Normal: 3 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0xb008
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
ACPI: Using ACPI (MADT) for SMP configuration information
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xbfffd000-0xbfffffff]
PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
PM: hibernation: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
[mem 0xc0000000-0xfffbbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:2
percpu: Embedded 69 pages/cpu s242952 r8192 d31480 u1048576
kvm-guest: PV spinlocks enabled
PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Fallback order for Node 0: 0 1 
Fallback order for Node 1: 1 0 
Built 2 zonelists, mobility grouping on.  Total pages: 2064125
Policy zone: Normal
Kernel command line: earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 root=/dev/sda console=ttyS0 vsyscall=native numa=fake=2 kvm-intel.nested=1 spec_store_bypass_disable=prctl nopcid vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=16 rose.rose_ndevs=16 dummy_hcd.num=8 watchdog_thresh=55 workqueue.watchdog_thresh=140 sysctl.net.core.netdev_unregister_timeout_secs=140 panic_on_warn=1 BOOT_IMAGE=/boot/bzImage root=/dev/sda1 console=ttyS0
Unknown kernel command line parameters "spec_store_bypass_disable=prctl BOOT_IMAGE=/boot/bzImage", will be passed to user space.
mem auto-init: stack:off, heap alloc:on, heap free:off
Stack Depot allocating hash table with memblock_alloc
Memory: 6842036K/8388204K available (139293K kernel code, 34308K rwdata, 29800K rodata, 4580K init, 24828K bss, 1545912K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=2
Dynamic Preempt: full
Running RCU self tests
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
rcu: 	RCU callback double-/use-after-free debug is enabled.
rcu: 	RCU debug extended QS entry/exit.
	All grace periods are expedited (rcu_expedited).
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:417 test_event_printk kernel/trace/trace_events.c:417 [inline]
WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:417 trace_event_raw_init+0x1aa/0xfe0 kernel/trace/trace_events.c:437
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc1-next-20220125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:test_event_printk kernel/trace/trace_events.c:417 [inline]
RIP: 0010:trace_event_raw_init+0x1aa/0xfe0 kernel/trace/trace_events.c:437
Code: 58 f8 ff 40 84 ed 75 87 e8 33 54 f8 ff 48 8b 5c 24 18 31 ff 48 89 de e8 b4 56 f8 ff 48 85 db 0f 84 c2 fe ff ff e8 16 54 f8 ff <0f> 0b 4c 8b 74 24 18 31 ff 41 bc 01 00 00 00 4c 89 f3 83 e3 01 48
RSP: 0000:ffffffff8b807e38 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffffffff8b8bc6c0 RSI: ffffffff8180166a RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8180165c R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff8beda8a0 R14: 00000000000000cb R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000b88e000 CR4: 00000000000406b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 event_init+0x112/0x1b0 kernel/trace/trace_events.c:2512
 event_trace_enable kernel/trace/trace_events.c:3629 [inline]
 trace_event_init+0xc6/0x3cc kernel/trace/trace_events.c:3724
 start_kernel+0x1fd/0x49b init/main.c:1023
 secondary_startup_64_no_verify+0xc3/0xcb
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
