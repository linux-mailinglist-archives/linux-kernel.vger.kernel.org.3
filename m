Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26851591CA1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 22:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiHMUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiHMUy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 16:54:29 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E560CDEE5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:54:28 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id q10-20020a056e020c2a00b002dedb497c7fso2704772ilg.16
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=YzUPbjeAbNgur1Ht6pBiKHByR3ZFjUXrKG6V3HyvA6E=;
        b=ECQJeOV1OZSwpTIRv1OApbVGBhzyR5P0hDTKlwGPpMLaStH1YOzW6XSKV8Mzv1wQbA
         myFpcwYJxwtiVRnD/+wYshftUxDOux/F8yteV0UB+KSQDvaHPx+TVS0T5HkV0M+eAddc
         K1c0axBBVBQrMVOoknXDGGCMzberFErAmL0MvWRy/eoIfVioqkwN+4WzJrhUET7YpDoP
         4FLNS474tlZmSd88w5pWzuCcmNqdgtVJta0TDh/lU3uvLjMnRFgXX46xRaX0HVY0xaYD
         fVB3UZMzk7CV2I20BjVmeMVWpRlrkKY00+gwpkUtcmmz5Oe9tYFUy+omUZUJw9D/okE2
         dBbA==
X-Gm-Message-State: ACgBeo0n9dfaZqw97TBagy9FZGQfxNywjuxq4t0270Qiuy4im6J1k87F
        DQ4heE1aF7p5OQfIH3QZSn9UHTGxag3OM4YjDXgMBmu5H6Oz
X-Google-Smtp-Source: AA6agR6i7PWOd1+KUtybI2x08boV9aewzwY5gOAOB+dtXuQ3US92YUKhdyacV10qfuvyzlYV1yCsACGIuMohu98igVtNcLlv7AQ5
MIME-Version: 1.0
X-Received: by 2002:a6b:4909:0:b0:66a:e3fc:e7b2 with SMTP id
 u9-20020a6b4909000000b0066ae3fce7b2mr3829670iob.29.1660424068230; Sat, 13 Aug
 2022 13:54:28 -0700 (PDT)
Date:   Sat, 13 Aug 2022 13:54:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c371f705e6259a38@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in init_sb (3)
From:   syzbot <syzbot+dcf33a7aae997956fe06@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150cbda9080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b664fba5e66c4bf
dashboard link: https://syzkaller.appspot.com/bug?extid=dcf33a7aae997956fe06
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcf33a7aae997956fe06@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 37440
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
================================================================================
UBSAN: shift-out-of-bounds in fs/gfs2/ops_fstype.c:297:19
shift exponent 50331651 is too large for 64-bit type 'unsigned long'
CPU: 0 PID: 30381 Comm: syz-executor.1 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3a6/0x420 lib/ubsan.c:322
 gfs2_read_sb fs/gfs2/ops_fstype.c:297 [inline]
 init_sb+0x11d6/0x12c0 fs/gfs2/ops_fstype.c:487
 gfs2_fill_super+0x1a3c/0x2750 fs/gfs2/ops_fstype.c:1209
 get_tree_bdev+0x400/0x620 fs/super.c:1292
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1325
 vfs_get_tree+0x88/0x270 fs/super.c:1497
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc20ac8a7aa
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc20be95f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fc20ac8a7aa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc20be95fe0
RBP: 00007fc20be96020 R08: 00007fc20be96020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fc20be95fe0 R15: 0000000020047a20
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
