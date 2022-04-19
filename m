Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3446B5070F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352452AbiDSOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352405AbiDSOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:51:04 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D53A1B2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:48:21 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id k20-20020a5e9314000000b00649d55ffa67so11887934iom.20
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=c/9tMLsmyW+ec9cdOerK6T4FHULsK2MkJLxhvp9hn/w=;
        b=zOPKQJZwi+FmjM/wy8dZ0cSeqBlO79BEUsWuQMewGGznbT7ksqno4SMqVqP+KvjdFU
         6dGVbOlQ7TS8SETNUDdzVzzAkvv9LAW3cEMt0IlsGzcdit2WqqQn8vWoJSoaut9Vhzdj
         8NNMLjze18J6RMiOokR4HyAq1gRG6yrsWf9GD7JSwjEfH+DBDSVuBLHEKATMVuBSjWUw
         2NZzI1ZrvxRPl3Qsyi0P8IgGahZkbPt/0e9bpYVCj74aKw7IG/fYXDP4Pk5OihLdPn9H
         F8IaGEi3MEgDbemIwj6rMAipgj511xNq6yfT3kSDfp3e3PDDGeKnDYltVCIf0aeL4Hi6
         O9Hw==
X-Gm-Message-State: AOAM530UWLHon5CduZmEgwzH0b6fZetpmaf2I3z1thuJzD/1Z7sBlebm
        qHoiDIC7lPvUpEF4aklWNHQ78mro9miio1KF0hVIgJAp5xck
X-Google-Smtp-Source: ABdhPJzKeYUsExd1iwqXfaLZUp4OcogkgLOYRlalf2CtbL0lZRHLTJ31twmPmGW+9bzVP9CCJvLErKtpeq2Km01VsGEm/DR33j00
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a7:b0:328:9c72:ce4a with SMTP id
 az39-20020a05663841a700b003289c72ce4amr3362674jab.101.1650379700873; Tue, 19
 Apr 2022 07:48:20 -0700 (PDT)
Date:   Tue, 19 Apr 2022 07:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0adc505dd02f79c@google.com>
Subject: [syzbot] general protection fault in lmLogSync
From:   syzbot <syzbot+9f410ed4b81c17d33aea@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    42e7a03d3bad Merge tag 'hyperv-fixes-signed-20220407' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133f5fc4f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=748af9f920dd8cc0
dashboard link: https://syzkaller.appspot.com/bug?extid=9f410ed4b81c17d33aea
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f410ed4b81c17d33aea@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 3620 Comm: syz-executor.0 Not tainted 5.18.0-rc1-syzkaller-00037-g42e7a03d3bad #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:lmLogSync+0x237/0xb10 fs/jfs/jfs_logmgr.c:945
Code: b8 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 77 9e df fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 5a 9e df fe 48 8b 3b e8 d2 8d b8
RSP: 0018:ffffc90003c5fc20 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 489d1fdc36f69100
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003c5fd38 R08: ffffffff81afb023 R09: ffffc90003c5fb88
R10: fffff5200078bf74 R11: 1ffff9200078bf71 R12: dffffc0000000000
R13: ffff888077468000 R14: 0000000000000000 R15: ffff88807ba8f838
FS:  0000555556388400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555559ac848 CR3: 00000000401fa000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_syncpt+0x79/0x90 fs/jfs/jfs_logmgr.c:1049
 jfs_sync_fs+0x86/0xa0 fs/jfs/super.c:689
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x300 fs/super.c:445
 kill_block_super+0x79/0xd0 fs/super.c:1394
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x452/0x500 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x134/0x160 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xad/0x110 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f535d48a4b7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc601d2388 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f535d48a4b7
RDX: 00007ffc601d245b RSI: 000000000000000a RDI: 00007ffc601d2450
RBP: 00007ffc601d2450 R08: 00000000ffffffff R09: 00007ffc601d2220
R10: 00005555563898b3 R11: 0000000000000246 R12: 00007f535d4e21ea
R13: 00007ffc601d3510 R14: 0000555556389810 R15: 00007ffc601d3550
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:lmLogSync+0x237/0xb10 fs/jfs/jfs_logmgr.c:945
Code: b8 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 77 9e df fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 5a 9e df fe 48 8b 3b e8 d2 8d b8
RSP: 0018:ffffc90003c5fc20 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 489d1fdc36f69100
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003c5fd38 R08: ffffffff81afb023 R09: ffffc90003c5fb88
R10: fffff5200078bf74 R11: 1ffff9200078bf71 R12: dffffc0000000000
R13: ffff888077468000 R14: 0000000000000000 R15: ffff88807ba8f838
FS:  0000555556388400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff86d3691b8 CR3: 00000000401fa000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b8 fe 49 8d 5f       	mov    $0x5f8d49fe,%eax
   5:	f0 48 89 d8          	lock mov %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 77 9e df fe       	callq  0xfedf9e93
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 30          	add    $0x30,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 5a 9e df fe       	callq  0xfedf9e93
  39:	48 8b 3b             	mov    (%rbx),%rdi
  3c:	e8                   	.byte 0xe8
  3d:	d2                   	.byte 0xd2
  3e:	8d                   	.byte 0x8d
  3f:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
