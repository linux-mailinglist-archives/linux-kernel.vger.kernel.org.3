Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89BC59CA01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiHVUbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHVUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:31:33 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DEB52811
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:31:32 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z4-20020a6b0a04000000b006887f66dcf3so6256107ioi.18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=L6rHlb+QVkpCy3JjjTuB9q/wSvRkx3+nKR7iFrZendk=;
        b=0bR6ccklv8OXaBrImKmPCtMe8Tvy1A0nNPiXD7ekm5lmXKewj8Mi+TSPXXDQZWO20a
         JGweWcZn/MclEEvYK1rftBSDPibBFztiW00sCuIlxaRvjOlARM7Zphu3JiYVtopNmZnl
         FTanTBqDtfUXbtI0DAbe/FccvUzjmCJ/JoDHn529cxBfJmtglm9rfMH3bOR1+v7Bw9M6
         KzgwfrWFfzZ2nrQ+Grrn/y4K77JBExATuu6uVEBhN7g/nXt0oJMBd7cwr0bt0pkmAlk0
         XP2iKCb/o5G5dyciuu+CMRpSbf5lrpEM6P0ModsYRS54XKvigoNuRp2mgwTRlCn6nzqB
         PCaw==
X-Gm-Message-State: ACgBeo0p8iXncX2n7he+yvUSZ8uBeMRYqxsmEhEB+NJZTaUEfUzE6b4G
        cvcjzWLnZW2zLsW5arR7ZZ51o2+uulEx2bo3veN5Kpq9MbNv
X-Google-Smtp-Source: AA6agR49izOrgMlPsJuGLN8uZ3HnpLFPJ7ln25fBjB8Ggo5U1zxw1lxSSKfdBDW85tiE3l1YHK+0RTzMGU3C3tmPMZBAmrm07+OG
MIME-Version: 1.0
X-Received: by 2002:a02:bb85:0:b0:349:defb:da42 with SMTP id
 g5-20020a02bb85000000b00349defbda42mr2729099jan.209.1661200292047; Mon, 22
 Aug 2022 13:31:32 -0700 (PDT)
Date:   Mon, 22 Aug 2022 13:31:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ef49705e6da5557@google.com>
Subject: [syzbot] usb-testing boot error: BUG: unable to handle kernel paging
 request in put_prev_entity
From:   syzbot <syzbot+27fb2fab2e8cd029d352@syzkaller.appspotmail.com>
To:     brauner@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oleg@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    ad57410d231d usb: gadget: rndis: use %u instead of %d to p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15f8653d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=27fb2fab2e8cd029d352
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27fb2fab2e8cd029d352@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffdc0000000001
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 100026067 P4D 100026067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 251 Comm: kworker/u4:2 Not tainted 6.0.0-rc1-syzkaller-00005-gad57410d231d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
RIP: 0010:rb_insert_color+0x6d/0x7a0 lib/rbtree.c:436
Code: 48 89 d8 48 c1 e8 03 42 80 3c 28 00 0f 85 48 05 00 00 48 8b 2b 40 f6 c5 01 0f 85 81 01 00 00 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 01 05 00 00 4c 8b 75 08 49 39 de 0f 84 6d 01
RSP: 0000:ffffc9000157fc10 EFLAGS: 00010802
RAX: 1fffe00000000001 RBX: ffff88810e6e0090 RCX: 1ffff11021cb53a4
RDX: 1ffff11021cb53a2 RSI: ffff8881f6937bf0 RDI: ffff000000000008
RBP: ffff000000000000 R08: ffff88810e5a9d10 R09: ffff8881f6937bc0
R10: ffffffff89ca5057 R11: 0000000000000001 R12: ffff88810e5a9d10
R13: dffffc0000000000 R14: dffffc0000000000 R15: 000000003aefdc00
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000001 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rb_insert_color_cached include/linux/rbtree.h:114 [inline]
 rb_add_cached include/linux/rbtree.h:183 [inline]
 __enqueue_entity kernel/sched/fair.c:629 [inline]
 put_prev_entity+0x1d4/0x4c0 kernel/sched/fair.c:4722
 pick_next_task_fair+0xa42/0xf80 kernel/sched/fair.c:7443
 __pick_next_task kernel/sched/core.c:5804 [inline]
 pick_next_task kernel/sched/core.c:6313 [inline]
 __schedule+0x3a3/0x26f0 kernel/sched/core.c:6458
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6663
 __cond_resched+0x13/0x20 kernel/sched/core.c:8299
 might_resched include/linux/kernel.h:110 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:49 [inline]
 cgroup_threadgroup_change_begin include/linux/cgroup-defs.h:740 [inline]
 exit_signals+0x26/0x8b0 kernel/signal.c:2949
 do_exit+0x50d/0x2930 kernel/exit.c:751
 call_usermodehelper_exec_async+0x418/0x580 kernel/umh.c:125
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc0000000001
---[ end trace 0000000000000000 ]---
RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
RIP: 0010:rb_insert_color+0x6d/0x7a0 lib/rbtree.c:436
Code: 48 89 d8 48 c1 e8 03 42 80 3c 28 00 0f 85 48 05 00 00 48 8b 2b 40 f6 c5 01 0f 85 81 01 00 00 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 01 05 00 00 4c 8b 75 08 49 39 de 0f 84 6d 01
RSP: 0000:ffffc9000157fc10 EFLAGS: 00010802
RAX: 1fffe00000000001 RBX: ffff88810e6e0090 RCX: 1ffff11021cb53a4
RDX: 1ffff11021cb53a2 RSI: ffff8881f6937bf0 RDI: ffff000000000008
RBP: ffff000000000000 R08: ffff88810e5a9d10 R09: ffff8881f6937bc0
R10: ffffffff89ca5057 R11: 0000000000000001 R12: ffff88810e5a9d10
R13: dffffc0000000000 R14: dffffc0000000000 R15: 000000003aefdc00
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000001 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 d8             	mov    %rbx,%rax
   3:	48 c1 e8 03          	shr    $0x3,%rax
   7:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   c:	0f 85 48 05 00 00    	jne    0x55a
  12:	48 8b 2b             	mov    (%rbx),%rbp
  15:	40 f6 c5 01          	test   $0x1,%bpl
  19:	0f 85 81 01 00 00    	jne    0x1a0
  1f:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	0f 85 01 05 00 00    	jne    0x536
  35:	4c 8b 75 08          	mov    0x8(%rbp),%r14
  39:	49 39 de             	cmp    %rbx,%r14
  3c:	0f                   	.byte 0xf
  3d:	84 6d 01             	test   %ch,0x1(%rbp)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
