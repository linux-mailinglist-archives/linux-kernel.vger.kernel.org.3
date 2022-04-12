Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9734FE4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357070AbiDLPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiDLPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:37:48 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D013298E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:35:30 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso11754139iov.16
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vFB2q3OmWhiQQNudfHfmYzHvPNUtRDLTLchmQKtzzv4=;
        b=yXp2aAbiIw3P611y781QcV8HJ6RgnidxIhXQRXhFi7vasquEAvpKZMs3rmK7kLBVuB
         O4ooXK06AdZ5Sjcfl8hENa/AJqbzQSZLCXWUjxVVc6gB1N1BlFJjOkhg97Qwgx4lDQkH
         TS2iwCbyud/q8Ow1YU5pxTWCRi9lSfDcZFTTzuM1AlvCwUegK82rU5kzOwXShtgO12oX
         GQFR2gtBqwfM2rTBrGXog4w27FZHv/SMTWZzFO3Kynp625r3chHCHlhlY55H0OK4WUts
         biBBzcqnaFmlV2RXA2ocoE5L9TmkRiRE+7a/rJqIC/avPZ6c67mxoWzSTHoccN/8LBNa
         aJsQ==
X-Gm-Message-State: AOAM533hZ+kI/usF5P7Z8MbOFKc2Dm9q1nz0YskuTxk8Ix5inipjZFHO
        DkOsl8FbHCD0GzDUhB+2oCWvZdXCcL7+5JPMLt5a5NUcpxUm
X-Google-Smtp-Source: ABdhPJxiW3T4cPnHUlebhxuzAuoK6vmgqOlQrlLtm0eeW8IteKSrpVvy4ub2bGPOMOpK9x1XQ8PNZlaX6bhBIgul+cBrnmnEFiUc
MIME-Version: 1.0
X-Received: by 2002:a92:6a01:0:b0:2b6:87b7:180b with SMTP id
 f1-20020a926a01000000b002b687b7180bmr16780550ilc.82.1649777730124; Tue, 12
 Apr 2022 08:35:30 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009001e405dc76cfba@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in init_sb (2)
From:   syzbot <syzbot+331b35dba416a8c626ba@syzkaller.appspotmail.com>
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

HEAD commit:    ff511c1c68a5 Add linux-next specific files for 20220408
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17921824f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0168787d544f48e
dashboard link: https://syzkaller.appspot.com/bug?extid=331b35dba416a8c626ba
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+331b35dba416a8c626ba@syzkaller.appspotmail.com

gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
================================================================================
UBSAN: shift-out-of-bounds in fs/gfs2/ops_fstype.c:297:19
shift exponent 50331651 is too large for 64-bit type 'long unsigned int'
CPU: 1 PID: 29651 Comm: syz-executor.0 Not tainted 5.18.0-rc1-next-20220408-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 gfs2_read_sb fs/gfs2/ops_fstype.c:297 [inline]
 init_sb.cold+0x19/0x109 fs/gfs2/ops_fstype.c:488
 gfs2_fill_super+0x18a7/0x28a0 fs/gfs2/ops_fstype.c:1211
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1327
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
RIP: 0033:0x7f445ce8a57a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f445dfacf88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f445ce8a57a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f445dfacfe0
RBP: 00007f445dfad020 R08: 00007f445dfad020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f445dfacfe0 R15: 0000000020047a20
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
