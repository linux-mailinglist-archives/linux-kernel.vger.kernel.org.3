Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E53588F71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbiHCPdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbiHCPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:32:40 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2CF6476
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:32:33 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id u10-20020a6be30a000000b0067bcbb8a637so7038661ioc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=NCQwecGn3xAsWnvGAu1P1ORQUutISsgOm6rWC9dfUm8=;
        b=FKzZ8I6A8X6RWWDxe7umY8CulXX0XmaDUGyJplGC3gXhvj8KuS7e1xHfYXYtIVGZxo
         zlwvXcAKk3gPWPMIMkCfNSllBccVraVX8kH8Hm0egXXAqBNrTAKA00qozLFl0KynhVxQ
         PcMkP2cNfMntbbl4UvMHQGnTkEZVCnpF9DGs/k3eek5P7aqbjjSkFibn0VAd86vK3Wgt
         tDTEZglbk4YaU/TrhKC4T5jg2Bf66i4UQ13b8GFl/ufWoBah7q+wCDWawuaECEl20KmZ
         uWSnZ/Jb7CpiitFckJ3yWODnwBT6MrZR4mcf3b58Cg913pgAt7TZ+y6queatGsJWwzjh
         3ydQ==
X-Gm-Message-State: AJIora9+twtkgT1d3cTCNzr8UuwtjzNwbc8hEIDkA0JITGT9cQBQAxzK
        DmeJaxTCv9mFjO0vVvbUt9hGrQ9zvJhI/S/PIjMS1gL0bWwf
X-Google-Smtp-Source: AGRyM1uylfr03iRWB0jV8Nrfpln7ZEQVnt1BA/lf+cJEAg1cpaxl0KOXF3mAEz66+BbFugtwWpcctxRcrj1S4NShoRABnrdGXwCm
MIME-Version: 1.0
X-Received: by 2002:a92:6504:0:b0:2dd:8201:fdeb with SMTP id
 z4-20020a926504000000b002dd8201fdebmr10369595ilb.98.1659540752401; Wed, 03
 Aug 2022 08:32:32 -0700 (PDT)
Date:   Wed, 03 Aug 2022 08:32:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000098a0105e557f130@google.com>
Subject: [syzbot] WARNING in hugetlb_change_protection
From:   syzbot <syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

HEAD commit:    e65c6a46df94 Merge tag 'drm-fixes-2022-07-30' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139cc282080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26034e6fe0075dad
dashboard link: https://syzkaller.appspot.com/bug?extid=824e71311e757a9689ff
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker_entry include/linux/swapops.h:319 [inline]
WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker include/linux/swapops.h:342 [inline]
WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 hugetlb_change_protection+0xf85/0x1610 mm/hugetlb.c:6392
Modules linked in:
CPU: 1 PID: 28745 Comm: syz-executor.3 Not tainted 5.19.0-rc8-syzkaller-00146-ge65c6a46df94 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:make_pte_marker_entry include/linux/swapops.h:319 [inline]
RIP: 0010:make_pte_marker include/linux/swapops.h:342 [inline]
RIP: 0010:hugetlb_change_protection+0xf85/0x1610 mm/hugetlb.c:6392
Code: e8 d0 5a b7 ff 0f b6 94 24 80 00 00 00 48 8b 84 24 98 00 00 00 84 d2 0f 84 ef 02 00 00 49 89 c4 e9 48 fb ff ff e8 ab 5e b7 ff <0f> 0b 48 b9 00 00 00 00 00 fc ff df 48 89 d8 48 c1 e8 03 80 3c 08
RSP: 0018:ffffc90014cc7780 EFLAGS: 00010212
RAX: 000000000000082a RBX: ffff88807750e820 RCX: ffffc90006723000
RDX: 0000000000040000 RSI: ffffffff81c30c25 RDI: 0000000000000007
RBP: ffff888074de5ea0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000004 R15: ffff88801fcc8e00
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0063) knlGS:00000000f7f06b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000001b84c000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 change_protection+0x96b/0x3ad0 mm/mprotect.c:463
 mwriteprotect_range+0x387/0x5c0 mm/userfaultfd.c:759
 userfaultfd_writeprotect fs/userfaultfd.c:1823 [inline]
 userfaultfd_ioctl+0x438/0x4340 fs/userfaultfd.c:1997
 compat_ptr_ioctl+0x67/0x90 fs/ioctl.c:906
 __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:968
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f0b549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f065cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c018aa06
RDX: 00000000200000c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
