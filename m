Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259AA585BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiG3Ta1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiG3TaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:30:25 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A086B1055D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:30:22 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id z2-20020a056e02088200b002dc4022c15fso4232790ils.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=ueOooyTmwBgM5EH2k2wYdam4b+rWYWnuwM2QtecUSsA=;
        b=GmYV4+d8INt9XT/sWttcISI+agGkklmWYrjzMQb2UlcEUxPOHQJLMTeZsr6GP/uCCT
         f9Ff+9QhSdbSPLplZv2OrG8BWbUEJ1P7cZu2fb9v3QHU7IXfSygW1IxuIbPNBz6MRnJX
         uRxSi/QIWiahaPhHDcFiXyW0ihH7wRtujm6bVPJQ/vHA1bxVrdfuMV6ToONWoP4lMxRU
         dBUE387OvtxBqXlNIg9kjDqodGqQl5TZfv5oqy4D/22ZOlJ4EKrQ8bcRNT4ZFszvBgfa
         5xkAh3rK08qv162lgcejBRxdtQJKOz+1Y7hvZCtHOLjDzi+LilUSrICeVZFHT19Wxk7t
         Mubw==
X-Gm-Message-State: AJIora+/kQj09egbgW79A0Ax32zOR2W0WB8ciZAZFGY0kznqwavjXT/U
        vLn9dPXOTmY/zvPV7XcJfIi+pdhvp3qs2xDO7z6fIzMYjlCN
X-Google-Smtp-Source: AGRyM1vEziy/cad5uzPGDgOcPTHsBa7x1UrxabGAGUu2BUcfWBV5Zoa6Apf4H0VaqgutRFLgIoVQwRVgKP3x7ok9kodl98AdPKuf
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2216:b0:67c:70d6:5fcf with SMTP id
 n22-20020a056602221600b0067c70d65fcfmr2898969ion.61.1659209421996; Sat, 30
 Jul 2022 12:30:21 -0700 (PDT)
Date:   Sat, 30 Jul 2022 12:30:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034d16305e50acc8d@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Read in do_journal_end (2)
From:   syzbot <syzbot+845cd8e5c47f2a125683@syzkaller.appspotmail.com>
To:     damien.lemoal@opensource.wdc.com, jack@suse.cz, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, neilb@suse.de,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
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

HEAD commit:    620725263f42 Merge tag 'mm-hotfixes-stable-2022-07-29' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ee9c82080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26034e6fe0075dad
dashboard link: https://syzkaller.appspot.com/bug?extid=845cd8e5c47f2a125683
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+845cd8e5c47f2a125683@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: null-ptr-deref in set_buffer_uptodate include/linux/buffer_head.h:120 [inline]
BUG: KASAN: null-ptr-deref in do_journal_end+0x135f/0x4b00 fs/reiserfs/journal.c:4080
Read of size 8 at addr 0000000000000000 by task syz-executor.4/7438

CPU: 0 PID: 7438 Comm: syz-executor.4 Not tainted 5.19.0-rc8-syzkaller-00152-g620725263f42 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_report mm/kasan/report.c:432 [inline]
 kasan_report.cold+0x61/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 set_buffer_uptodate include/linux/buffer_head.h:120 [inline]
 do_journal_end+0x135f/0x4b00 fs/reiserfs/journal.c:4080
 reiserfs_sync_fs+0xf8/0x120 fs/reiserfs/super.c:78
 sync_filesystem.part.0+0x75/0x1d0 fs/sync.c:56
 sync_filesystem+0x8b/0xc0 fs/sync.c:43
 generic_shutdown_super+0x70/0x400 fs/super.c:445
 kill_block_super+0x97/0xf0 fs/super.c:1394
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x3a2/0x540 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f3988a677
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcab38a818 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f5f3988a677
RDX: 00007ffcab38a8eb RSI: 000000000000000a RDI: 00007ffcab38a8e0
RBP: 00007ffcab38a8e0 R08: 00000000ffffffff R09: 00007ffcab38a6b0
R10: 000055555635d8b3 R11: 0000000000000246 R12: 00007f5f398e22a6
R13: 00007ffcab38b9a0 R14: 000055555635d810 R15: 00007ffcab38b9e0
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
