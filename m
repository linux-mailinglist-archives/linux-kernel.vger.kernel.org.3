Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D9A509A71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386558AbiDUITS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355921AbiDUITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:19:16 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395A3889
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:16:27 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h28-20020a056e021d9c00b002cc403e851aso2234705ila.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9ZLz1qP7iL5lnV6y3Ho8XIAP9zuovgE3aj5nUkzse0A=;
        b=tpLl79mk0bQVUnu9rtZkgTgwGx7CLhpqglktiyL4gPCM8C1Ab3sNM28ceN0r8Zra7c
         vCjRCyIslxmlKjduCrsOaGzaLWoN7J3yI4K+ObIk/66iA8NUnawD3ml+bJs9p7jB2Eh8
         kDm0Wx+UcI63mIVhYRUhIAAj2Wjt6VDTK90b+ic+6ytR3RXT45P91uwXhSyX/WjBmpBO
         gUmOp1/HeRjkYtzyNgm6KJwSoIEx2ZzHGvKqoVHYFZreGuPM3azt8LVbVm+/yZSfuO7/
         o7/U7fSXkFxcpSnif+z3L7mTTlxtIXewRsxADC3WhH+97c1xDcPEv2fcjYIbuVbt+qS1
         WuGA==
X-Gm-Message-State: AOAM531iUaNns/fmAf9GAb89bDnpNTJhOaL5NUuS41Te1YCkIZZEh20Z
        wsC82BGHqdGk+4Yh13cJmBMDbJ37xNms7sYiC6Ch2zsBjkt9
X-Google-Smtp-Source: ABdhPJzNLNw4U73UWgBgiCIA28SxHnfBZ+q+vueEGxr/sQELdY/DsyW013UqQq/x5bVFCeRphu0gJBQyS/bTp8+sdjW6DXewI2vO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b81:b0:2ca:c4b1:9687 with SMTP id
 h1-20020a056e021b8100b002cac4b19687mr10598354ili.293.1650528987164; Thu, 21
 Apr 2022 01:16:27 -0700 (PDT)
Date:   Thu, 21 Apr 2022 01:16:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8b5ef05dd25b963@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in ntfs_fill_super
From:   syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    b253435746d9 Merge tag 'xtensa-20220416' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144dd7f4f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff9f8140cbb3af7
dashboard link: https://syzkaller.appspot.com/bug?extid=1631f09646bc214d2e76
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 8189
================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs3/super.c:673:16
shift exponent -192 is negative
CPU: 0 PID: 12945 Comm: syz-executor.3 Not tainted 5.18.0-rc3-syzkaller-00016-gb253435746d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 ntfs_fill_super.cold+0x2bf/0x549 fs/ntfs/bitmap.c:84
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f768c28a61a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f768d3dff88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f768c28a61a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f768d3dffe0
RBP: 00007f768d3e0020 R08: 00007f768d3e0020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f768d3dffe0 R15: 000000002007aa80
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
