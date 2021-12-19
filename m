Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EED479ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 03:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhLSCaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 21:30:19 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:47071 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhLSCaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 21:30:18 -0500
Received: by mail-io1-f70.google.com with SMTP id z21-20020a5e8615000000b005e22e531c8aso4566963ioj.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 18:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BLkRm7JsPMHKNccauegvl3TjeKbqqckUlnVJerrVAaE=;
        b=3n7ekjpzIYN8+k29h2C9Vr1uou7fPlT+dRLb1xy8ai3m5qj+Bq7jnrm+F7A5fnXefF
         CrXMUazyPJS9/S45J0/MJeVYBBIdPQdtbQPtp2x4kBAGjIDdAfWc3SJHFCfo4Il4C824
         Ewl3XUVNI7b9VcWXakqoC6wQE08gyaZnDjWA+BvjJ1a6MMZ2OhfgoJmdJw/rvSE0xqeb
         FZIeBK/tLIVU1jxlUj2LmD4ID7+Ttblmo6bJc2Z6vswzBqbu4Yc4PhrAha+NhBmcJ0sb
         RDB/PxL+bvWpxC6LbXkJRfGyVOBLhcZhG5+2opqn+snnAm5iJ9DNFkBcrQQ8eU2nsjlF
         pYNA==
X-Gm-Message-State: AOAM533dSWs3PKMWtn/pfJKKlqjTArySKzbZzF8SpbYo5KPK8AHtRKZU
        ea7J1IO6sLSUkDEnk6KQiQzlGFd2vZH+OtDXe2KKCa4GxLDe
X-Google-Smtp-Source: ABdhPJwn+n0SEm9zR5fIq2s4KSyHy97fwcNSVSi9YT9Ii2VYixshGIpi2xAGyA6jskAXr+jI9ZG6ZJXeByQnmaoqR1fptFBC+xOA
MIME-Version: 1.0
X-Received: by 2002:a6b:2bc3:: with SMTP id r186mr5266946ior.167.1639881017964;
 Sat, 18 Dec 2021 18:30:17 -0800 (PST)
Date:   Sat, 18 Dec 2021 18:30:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cbe1705d3768d0a@google.com>
Subject: [syzbot] WARNING in truncate_inode_pages_range
From:   syzbot <syzbot+9a47934438c88cc4dbd3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5472f14a3742 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e62bb1b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10f3f669b8093e95
dashboard link: https://syzkaller.appspot.com/bug?extid=9a47934438c88cc4dbd3
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a47934438c88cc4dbd3@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 2688
------------[ cut here ]------------
WARNING: CPU: 0 PID: 22601 at mm/truncate.c:405 truncate_inode_pages_range+0xe5e/0x1310 mm/truncate.c:405
Modules linked in:
CPU: 0 PID: 22601 Comm: syz-executor.1 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:truncate_inode_pages_range+0xe5e/0x1310 mm/truncate.c:405
Code: 48 9d 1d 00 49 8b 5f 20 48 c1 e3 06 4c 01 f3 4c 29 fb 48 c1 fb 06 4c 8b 7c 24 18 4c 8b 6c 24 08 e9 77 fe ff ff e8 82 c9 d1 ff <0f> 0b e9 84 fe ff ff 48 8d 8c 24 80 00 00 00 80 e1 07 38 c1 0f 8c
RSP: 0018:ffffc900119c76a0 EFLAGS: 00010287
RAX: ffffffff81b2cfee RBX: 0000000000000080 RCX: 0000000000040000
RDX: ffffc90003061000 RSI: 000000000000270b RDI: 000000000000270c
RBP: ffffc900119c78b8 R08: ffffffff81b2ce6b R09: fffff94000398a51
R10: fffff94000398a51 R11: 0000000000000000 R12: 1ffffd4000398a51
R13: ffffea0001cc5288 R14: ffffea0001cc5280 R15: 0000000000000040
FS:  00007fd7d8bb1700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00f1ae3000 CR3: 000000001a9d1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kill_bdev block/bdev.c:78 [inline]
 set_blocksize+0x2ec/0x360 block/bdev.c:158
 sb_set_blocksize+0x45/0xe0 block/bdev.c:167
 udf_load_vrs+0xcb/0x770 fs/udf/super.c:1980
 udf_fill_super+0x90c/0x1b20 fs/udf/super.c:2184
 mount_bdev+0x26c/0x3a0 fs/super.c:1370
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x86/0x270 fs/super.c:1500
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1986/0x2c30 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount+0x308/0x3c0 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fd7da23d3ca
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd7d8bb0f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fd7da23d3ca
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fd7d8bb0fe0
RBP: 00007fd7d8bb1020 R08: 00007fd7d8bb1020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fd7d8bb0fe0 R15: 0000000020000380
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
