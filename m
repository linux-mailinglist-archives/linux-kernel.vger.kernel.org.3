Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538344717E0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 03:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhLLCrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 21:47:21 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41497 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhLLCrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 21:47:20 -0500
Received: by mail-il1-f200.google.com with SMTP id r1-20020a92cd81000000b002a3ae5f6ad9so12998098ilb.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 18:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BmfeDR4NNTHJATBkbvOcz0xOIzdx+CJE+pTlwo+v15A=;
        b=Thbwk6lfkUafHPcVq52p01pkzPw4WIKZUss2pWlp7Ab9d2ONmMLy+/gEC37TOYyH+0
         nAMO8diHfqflnP9XWWTIYXZmlhunZw5TOhaZ/L8cdF0l8eAOAzKRunyb6hNgzZTK2z8Y
         cUzrAiZOZoywiWk6HTz2++Oa8N7F3SuzFNv1fQgnFSjdmRHF+sEM6nNAhGsOrZNGF1Md
         0aiuji2I5ZErKFF8b1OnbJGLdcbqS8al15h9QUybVl1S8MWpKe/ssm+vM/dox42yMcvL
         7ImQgOqBJ1IaPSZfyCJGggno26G14VIGh0q4cW7kOXHPMTdGwXYe73Sk77i3/V19iIMz
         fmYQ==
X-Gm-Message-State: AOAM531mPxRfkOkuTQrLo7br+JGk4VDDuXRjW1uU/gxGUw2T2EUjkyKo
        coCzWShYz9XzhU5Chx9dYZnOCGYWnQ4ZxrLHzYoE9nLApqy9
X-Google-Smtp-Source: ABdhPJxyt3i5Ad6vNq6W+YrjSOX+hua1xkCEdXMmxxkhOg/ZSmq7sc+ELR/w4Te0pCbQIrHCpIXy2B6GNPhDhrcMu5r+sSd+Xpr2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:: with SMTP id ay11mr26343673jab.120.1639277240018;
 Sat, 11 Dec 2021 18:47:20 -0800 (PST)
Date:   Sat, 11 Dec 2021 18:47:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094729c05d2e9f9ee@google.com>
Subject: [syzbot] WARNING in bpf_xdp_adjust_tail (3)
From:   syzbot <syzbot+a81d16c14cce8b3be73f@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cd8c917a56f2 Makefile: Do not quote value for CONFIG_CC_IM..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10251d89b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=a81d16c14cce8b3be73f
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a81d16c14cce8b3be73f@syzkaller.appspotmail.com

------------[ cut here ]------------
Too BIG xdp->frame_sz = 16384
WARNING: CPU: 0 PID: 24551 at net/core/filter.c:3832 ____bpf_xdp_adjust_tail net/core/filter.c:3832 [inline]
WARNING: CPU: 0 PID: 24551 at net/core/filter.c:3832 bpf_xdp_adjust_tail+0x19c/0x1b0 net/core/filter.c:3821
Modules linked in:

CPU: 0 PID: 24551 Comm: syz-executor.3 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:____bpf_xdp_adjust_tail net/core/filter.c:3832 [inline]
RIP: 0010:bpf_xdp_adjust_tail+0x19c/0x1b0 net/core/filter.c:3821
Code: e0 fe ff ff e8 a5 08 a6 f9 e9 d6 fe ff ff e8 eb 34 5a f9 c6 05 0c e7 c0 05 01 48 c7 c7 a0 35 9a 8b 89 ee 31 c0 e8 94 0e 24 f9 <0f> 0b 48 c7 c0 ea ff ff ff e9 7a ff ff ff 66 0f 1f 44 00 00 55 41
RSP: 0018:ffffc90004937740 EFLAGS: 00010246

RAX: 9ec6b2c38dd06900 RBX: ffffc90004937900 RCX: 0000000000040000
RDX: ffffc9000ac42000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 0000000000004000 R08: ffffffff816a1d52 R09: ffffed10173467b1
R10: ffffed10173467b1 R11: 0000000000000000 R12: ffff888035b18f81
R13: ffff888035b18f81 R14: ffffc90004937908 R15: 1ffff92000926f21
FS:  00007f4f6f09a700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f70238020 CR3: 00000000341e3000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_812643e682ac10e2+0x1a/0x9c8
 __bpf_prog_run include/linux/filter.h:626 [inline]
 bpf_prog_run_xdp include/linux/filter.h:804 [inline]
 bpf_prog_run_generic_xdp+0x4d5/0xfc0 net/core/dev.c:4737
 netif_receive_generic_xdp net/core/dev.c:4823 [inline]
 do_xdp_generic+0x480/0x6a0 net/core/dev.c:4878
 tun_get_user+0x1e42/0x39e0 drivers/net/tun.c:1847
 tun_chr_write_iter+0x10a/0x1e0 drivers/net/tun.c:1942
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write fs/read_write.c:503 [inline]
 vfs_write+0xb11/0xe90 fs/read_write.c:590
 ksys_write+0x18f/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4f700d760f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 99 fd ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 cc fd ff ff 48
RSP: 002b:00007f4f6f09a150 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4f70237f60 RCX: 00007f4f700d760f
RDX: 0000000000000e81 RSI: 00000000200000c0 RDI: 00000000000000c8
RBP: 00007f4f7017eff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffcf1595d4f R14: 00007f4f6f09a300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
