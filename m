Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20F479B74
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhLROt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:49:27 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:38795 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhLROt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:49:26 -0500
Received: by mail-il1-f199.google.com with SMTP id l2-20020a922802000000b002b22557922dso3045909ilf.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 06:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CCB2+CwPHLZXNn5uVd01Z+g1j3FhQas/E0xmleSi3V8=;
        b=NrgD6bvY6nO23CFspyxMh4kzodCePy4LxSvkr4E4+PC5aunS3ehpo9t7HL2ygsmaJa
         MsYjpeuwYH/n/O/6lexrgWEGBNkaqQ/hYes1ofoyPEHgempbKWHqBG2RHbaoFICT9bk/
         EpKgd75Psjmc1BRwK9bmxUsi2lZV8aNZMXft0IZSzvzWJGQusvHwyP8ctoQz6Tz9wwS4
         zL42M6KZI1S+i2Q4zpDqieijUI2vzIW/XGwuxopSA0wgtLAkm5nI5WYBHn9kFNkMmntT
         /IsfTltvfgMsvKVscXyAIRByet2JGicM3dsjm6XVZK6MAz3rYK6EBz+7fllgJd3dh5cV
         rX/g==
X-Gm-Message-State: AOAM532w1hZjfnFSxCtGlaRkyUenbPaT0Stnhdd9DqLTECom4twejNg/
        d/K9ttrCLdMj74xjHRM6e/QCtYexgLF0JVQ86/54tI2JdVaa
X-Google-Smtp-Source: ABdhPJzPuv69a1suGn4XCoRRflURLIMdP8U3oOYJP3iEx6KGztFl6DXKswLeXrOgfu9OTFJutu6DoXVpPTmbnueC/Qvppn0WiWn2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3823:: with SMTP id i35mr4734747jav.213.1639838965953;
 Sat, 18 Dec 2021 06:49:25 -0800 (PST)
Date:   Sat, 18 Dec 2021 06:49:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dfd4605d36cc33b@google.com>
Subject: [syzbot] WARNING in console_unlock
From:   syzbot <syzbot+c81440130f8669eb86d8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        swboyd@chromium.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ea922272cbe5 Add linux-next specific files for 20211210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12517ef5b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b5499ad0143759
dashboard link: https://syzkaller.appspot.com/bug?extid=c81440130f8669eb86d8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c81440130f8669eb86d8@syzkaller.appspotmail.com

DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Modules linked in:
------------[ cut here ]------------
WARNING: CPU: 1 PID: 9308 at include/trace/events/printk.h:10 trace_console_rcuidle include/trace/events/printk.h:10 [inline]
WARNING: CPU: 1 PID: 9308 at include/trace/events/printk.h:10 call_console_drivers kernel/printk/printk.c:1905 [inline]
WARNING: CPU: 1 PID: 9308 at include/trace/events/printk.h:10 console_unlock+0xabd/0xb70 kernel/printk/printk.c:2714
Modules linked in:
CPU: 1 PID: 9308 Comm: syz-executor.2 Not tainted 5.16.0-rc4-next-20211210-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:trace_console_rcuidle include/trace/events/printk.h:10 [inline]
RIP: 0010:call_console_drivers kernel/printk/printk.c:1905 [inline]
RIP: 0010:console_unlock+0xabd/0xb70 kernel/printk/printk.c:2714
Code: e3 ef 0e 00 00 00 00 48 8b bc 24 68 01 00 00 e8 69 c7 ff ff e9 35 ff ff ff e8 1f e7 18 00 0f 0b e9 17 fd ff ff e8 13 e7 18 00 <0f> 0b e9 6a fd ff ff 48 89 ef e8 24 df 63 00 e9 34 f7 ff ff e8 ea
RSP: 0018:fffffe0000053d40 EFLAGS: 00010046
RAX: 0000000080110000 RBX: 0000000000100000 RCX: 0000000000000000
RDX: ffff88801b238000 RSI: ffffffff815f146d RDI: 0000000000000003
RBP: fffffe0000053dd8 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815f11d6 R11: 0000000000000000 R12: 000000000000000f
R13: 0000000000000000 R14: fffffe0000053d98 R15: dffffc0000000000
FS:  00007f83f79b2700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff8 CR3: 000000004313c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 console_unblank+0xfc/0x130 kernel/printk/printk.c:2779
 bust_spinlocks+0x60/0xe0 lib/bust_spinlocks.c:28
 oops_end+0x2b/0xf0 arch/x86/kernel/dumpstack.c:361
 exc_double_fault+0x16d/0x180 arch/x86/kernel/traps.c:466
 asm_exc_double_fault+0x1e/0x40 arch/x86/include/asm/idtentry.h:613
RIP: 0010:entry_SYSENTER_compat+0x3/0x17 arch/x86/entry/entry_64_compat.S:54
Code: 41 5c 5d 5b 41 5b 41 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4 30 fd 48 c7 44 24 28 00 00 00 00 48 cf cc cc cc cc cc cc 0f 01 f8 <50> 58 65 48 8b 24 25 10 70 02 00 6a 2b 6a 00 9c 6a 23 6a 00 89 c0
RSP: 0018:0000000000000000 EFLAGS: 00010046
RAX: 00000000000000d0 RBX: 0000000000018ff5 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000200193c0 R08: 0000000000000000 R09: 0000000020000280
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </#DF>
----------------
Code disassembly (best guess):
   0:	41 5c                	pop    %r12
   2:	5d                   	pop    %rbp
   3:	5b                   	pop    %rbx
   4:	41 5b                	pop    %r11
   6:	41 5a                	pop    %r10
   8:	41 59                	pop    %r9
   a:	41 58                	pop    %r8
   c:	58                   	pop    %rax
   d:	59                   	pop    %rcx
   e:	5a                   	pop    %rdx
   f:	5e                   	pop    %rsi
  10:	5f                   	pop    %rdi
  11:	48 83 c4 30          	add    $0x30,%rsp
  15:	fd                   	std
  16:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
  1d:	00 00
  1f:	48 cf                	iretq
  21:	cc                   	int3
  22:	cc                   	int3
  23:	cc                   	int3
  24:	cc                   	int3
  25:	cc                   	int3
  26:	cc                   	int3
  27:	0f 01 f8             	swapgs
* 2a:	50                   	push   %rax <-- trapping instruction
  2b:	58                   	pop    %rax
  2c:	65 48 8b 24 25 10 70 	mov    %gs:0x27010,%rsp
  33:	02 00
  35:	6a 2b                	pushq  $0x2b
  37:	6a 00                	pushq  $0x0
  39:	9c                   	pushfq
  3a:	6a 23                	pushq  $0x23
  3c:	6a 00                	pushq  $0x0
  3e:	89 c0                	mov    %eax,%eax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
