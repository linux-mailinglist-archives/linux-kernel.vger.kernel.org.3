Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997B4525E87
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378865AbiEMJEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378963AbiEMJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:03:57 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7F3158D6A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:03:34 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id i66-20020a6bb845000000b00657bac76fb4so4465063iof.15
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2GlMZnYxijH94fTbKUpN79sdxDswAdSkrn/du52tVoY=;
        b=e9U5v80BsQYdvQJLlOUtm2xz51SnIzBZsalYbSzyfYYhWoq9pOwP/Z8ciA1a23Z0cc
         2ezYBuyMThw8nXeifg7oimq+KsCZNfjKfjsQ1YA9MW/di+AYN+oN/GHos6DKVagaCtd0
         FZ2wAraazKfcFnfdbP2aX8c/Z0hs///txi2wt8QlWiHszh5Irty8gaCIH4Juhn7qFBN8
         S8JcxPHtsild/BZrVjB/3d5B6l/Im0nNsKMUyfVQIsQLZOPAUE8ahNE8Lh3hVa6Y8EII
         A+7ff0lAHcA50HE8BkRHM/rzbZnzIxlxvUYigpUwRMmOGTNGU7FNvtRaFlclnL1FsCRr
         8lmw==
X-Gm-Message-State: AOAM532wdApA3RAhyIAnJZj5sgiSI4ah9Hlp9AduBPFlhqy21L3SdAmk
        B1tiYtVm2f9G/s/JMv9zQtL4xGisk3k7Iwap7h16cmQWMonV
X-Google-Smtp-Source: ABdhPJynGTL8/5Q/8NR1hAOJFB7G1fSxlpFxF6og5RTxW++PwV8gnaWdtb5mLP1F56DeNg7PMy6/LpagdSU3E7R2Vd2Vn2euD1qB
MIME-Version: 1.0
X-Received: by 2002:a05:6638:204c:b0:32b:688f:e05e with SMTP id
 t12-20020a056638204c00b0032b688fe05emr2036381jaj.106.1652432613358; Fri, 13
 May 2022 02:03:33 -0700 (PDT)
Date:   Fri, 13 May 2022 02:03:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef451a05dee0f2b1@google.com>
Subject: [syzbot] WARNING in follow_hugetlb_page
From:   syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1480e611f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
dashboard link: https://syzkaller.appspot.com/bug?extid=acf65ca584991f3cc447
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6653 at mm/hugetlb.c:6250 follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250
Modules linked in:
CPU: 1 PID: 6653 Comm: syz-executor.1 Not tainted 5.18.0-rc6-next-20220513-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250
Code: 89 44 24 70 e8 2b 1d b7 ff 48 8b 44 24 70 48 85 c0 0f 84 f1 07 00 00 e8 88 1a b7 ff 48 83 ed 01 e9 09 fb ff ff e8 7a 1a b7 ff <0f> 0b 48 8b 7c 24 30 bb f4 ff ff ff e8 69 74 b8 07 4c 8b a4 24 b8
RSP: 0018:ffffc9000d04f7e0 EFLAGS: 00010212
RAX: 00000000000030f2 RBX: ffff88807eb336c0 RCX: ffffc90003331000
RDX: 0000000000040000 RSI: ffffffff81c38f76 RDI: 0000000000000003
RBP: ffffea0001fd8080 R08: 0000000000000000 R09: 0000000000000003
R10: ffffffff81b128fb R11: 0000000000000057 R12: 0000000000000002
R13: ffff88807eb336c0 R14: ffff88807eb33d80 R15: 0000000000000001
FS:  00007f59bc2a1700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f59bb0d6720 CR3: 000000001eaf8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __get_user_pages+0x27a/0xfa0 mm/gup.c:1146
 __get_user_pages_locked mm/gup.c:1365 [inline]
 __gup_longterm_locked+0x1d5/0xfe0 mm/gup.c:1985
 pin_user_pages+0x8e/0xe0 mm/gup.c:3118
 io_sqe_buffer_register+0x254/0x1710 fs/io_uring.c:10537
 io_sqe_buffers_register.cold+0x28e/0x443 fs/io_uring.c:10664
 __io_uring_register fs/io_uring.c:12682 [inline]
 __do_sys_io_uring_register+0xd21/0x1930 fs/io_uring.c:12816
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f59bb0890e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f59bc2a1168 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 00007f59bb19bf60 RCX: 00007f59bb0890e9
RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f59bb0e308d R08: 0000000000000000 R09: 0000000000000000
R10: 1000000000000239 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd53b6ab6f R14: 00007f59bc2a1300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
