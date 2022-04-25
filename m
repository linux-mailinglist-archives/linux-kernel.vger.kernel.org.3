Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B842150E51E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbiDYQHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDYQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:07:23 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8E72E69A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:04:18 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s10-20020a92c5ca000000b002cc45dade1aso6327254ilt.20
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cxlnN+ksu5h7pMysIAQwlQRKgFik8uZOxzt7TfEv7Kk=;
        b=j4oRB8R+midcZpQdzimvaucDebOIb2SS47lK8L2vtW4ZCWHXVrnqcBRFXm+E60tjwV
         1tVABtxgWPSloPVu08kC8PS4i/nBkvrk6j7Jv58WMGKjZFoAvc/yp90MO+u2+UGCJMLm
         2wS5pfuxVRv0CC0yw8fZCF1lotZmHlCWSAkF4d1EqCz7MzVGKNN5TJ777aJtzQvggu4h
         7XQAd4/cHMgpyZCnYMRiyja+8HmVrTTledFZ30cf8j2Ss/Vc+7ChBD3uI1f0NpMbC9cc
         gWPzX2s4rr+92uRXF9eHmQaFI17u6/CBQF3YwWxrZVfnrS4A6Ts9yZIZmE0k67cXXYQw
         PUXA==
X-Gm-Message-State: AOAM5301LD0qirT+nThf+gL9M+f/i/5avE+m+OIg4lU/2jWJV8OkfrkR
        TiQInEa9if3iXOUwnJxJtseJ1vjlxG3ULO903woGDORT6uQO
X-Google-Smtp-Source: ABdhPJxgsj+jAaHKZXf53RXWlbuliICRCohF3/WzATsGar5tzza/NHCwTFgiC3MTR4cVhJxLLCy4LJNuI2tnGxghiKFsLC6RHEyF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a0:b0:32a:90ae:f7a1 with SMTP id
 az32-20020a05663841a000b0032a90aef7a1mr7916547jab.101.1650902658063; Mon, 25
 Apr 2022 09:04:18 -0700 (PDT)
Date:   Mon, 25 Apr 2022 09:04:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e22cb05dd7cbada@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in
 do_page_fault (3)
From:   syzbot <syzbot+2845b2dfa28dec36e215@syzkaller.appspotmail.com>
To:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=121d1d7cf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
dashboard link: https://syzkaller.appspot.com/bug?extid=2845b2dfa28dec36e215
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2845b2dfa28dec36e215@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1460
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2044, name: syz-fuzzer
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
no locks held by syz-fuzzer/2044.
irq event stamp: 17038
hardirqs last  enabled at (17037): [<ffffffff831afca0>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (17037): [<ffffffff831afca0>] _raw_spin_unlock_irq+0x2a/0x76 kernel/locking/spinlock.c:202
hardirqs last disabled at (17038): [<ffffffff8000e866>] __trace_hardirqs_off+0x18/0x20 arch/riscv/kernel/trace_irq.c:25
softirqs last  enabled at (17032): [<ffffffff831b0bd0>] softirq_handle_end kernel/softirq.c:401 [inline]
softirqs last  enabled at (17032): [<ffffffff831b0bd0>] __do_softirq+0x618/0x8fc kernel/softirq.c:587
softirqs last disabled at (17027): [<ffffffff80061288>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (17027): [<ffffffff80061288>] invoke_softirq kernel/softirq.c:439 [inline]
softirqs last disabled at (17027): [<ffffffff80061288>] __irq_exit_rcu+0x142/0x1f8 kernel/softirq.c:637
CPU: 1 PID: 2044 Comm: syz-fuzzer Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff83175742>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
[<ffffffff800baf2a>] __might_resched+0x30a/0x342 kernel/sched/core.c:9583
[<ffffffff800bafc0>] __might_sleep+0x5e/0x8e kernel/sched/core.c:9512
[<ffffffff831ab63e>] down_read+0x24/0x54 kernel/locking/rwsem.c:1460
[<ffffffff800117d4>] mmap_read_lock include/linux/mmap_lock.h:117 [inline]
[<ffffffff800117d4>] do_page_fault+0x24e/0xa3c arch/riscv/mm/fault.c:285
[<ffffffff80005724>] ret_from_exception+0x0/0x10


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
