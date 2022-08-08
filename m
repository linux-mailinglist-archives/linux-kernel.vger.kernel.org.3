Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AFB58CE97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbiHHTdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiHHTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:33:23 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464DF19031
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:33:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id o23-20020a056602225700b0068002601976so5100098ioo.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 12:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=5rWQ7k1u1Kl93XTfS5D8Eghy8px9Tb+XUmZdCwtceDo=;
        b=URkK63ZWTbDfIFpFxbnAE2fzIJGxykHhRZayW969Ot7nIPDdLJGnlb8bYYvZJ1p6Hh
         Q8kFlWxPW2FKqWU54R/h1+ho+iI+refP04wkovDj12kSTGzG6IDdOg5/A8zqufvvuPME
         1g7qDwK/20SC6RDxit6UvK1610nKBlLBDprEyjJC3tkfXb5sU6bQ4lDNsEqsNR2FQgMp
         6grnXHP34O5oob32tt2fVxhB7SxZyd0htaAHpuV0wk5Uh+9KtuXx0tkTnnclX/BoWK5i
         VpVs+qJVX7yYCbhkh+mW7vEe9mUhUIz6Doz3uXEtpgEZumTwJ18E2xsRAh0HR1L4+8Lw
         mYZA==
X-Gm-Message-State: ACgBeo0TlUUUwF4Jbc2zWI6pI0cV24I6tzow5joRr0NNhyxTVkQSHc8r
        Qxsh5Ft/dnlwrIYK6+JHDjR/K6lobZ6zDYE4vb0Rd2WSImeu
X-Google-Smtp-Source: AA6agR5AP0UlHcBeQha8uTVEe528Ni6CHWfBZn3j6TLvJtJdVyBCkLBJTJn3YqAB7KY0XBaGC1sQJmNx2HlJnLSwWgup4tjpq3Ph
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e6:b0:2e0:ac23:2aba with SMTP id
 l6-20020a056e0212e600b002e0ac232abamr4659257iln.323.1659987201675; Mon, 08
 Aug 2022 12:33:21 -0700 (PDT)
Date:   Mon, 08 Aug 2022 12:33:21 -0700
In-Reply-To: <00000000000085cb1705e5b5d9f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cda2705e5bfe389@google.com>
Subject: Re: [syzbot] WARNING in find_vma
From:   syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14807dfa080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=a7b60a176ec13cafb793
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12999232080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15452c12080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com

binder: 7796:7797 ioctl c0306201 20001480 returned -14
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7797 at include/linux/mmap_lock.h:155 mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
WARNING: CPU: 1 PID: 7797 at include/linux/mmap_lock.h:155 find_vma+0xf8/0x270 mm/mmap.c:2255
Modules linked in:
CPU: 1 PID: 7797 Comm: syz-executor269 Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
RIP: 0010:find_vma+0xf8/0x270 mm/mmap.c:2255
Code: 49 8d bc 24 28 01 00 00 be ff ff ff ff e8 40 2e c8 07 31 ff 89 c3 89 c6 e8 85 e2 c4 ff 85 db 0f 85 61 ff ff ff e8 b8 e5 c4 ff <0f> 0b e9 55 ff ff ff e8 ac e5 c4 ff 4c 89 e7 e8 54 38 fb ff 0f 0b
RSP: 0018:ffffc9000cee7530 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807c278000 RSI: ffffffff81b72058 RDI: 0000000000000005
RBP: 0000000020ffc000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807dda3100
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f5fdf1fb700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007d391000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_lookup include/linux/mm.h:2743 [inline]
 binder_alloc_get_vma drivers/android/binder_alloc.c:340 [inline]
 binder_alloc_new_buf_locked drivers/android/binder_alloc.c:405 [inline]
 binder_alloc_new_buf+0xd6/0x18b0 drivers/android/binder_alloc.c:590
 binder_transaction+0x242e/0x9a80 drivers/android/binder.c:3187
 binder_thread_write+0x8a9/0x3220 drivers/android/binder.c:3963
 binder_ioctl_write_read drivers/android/binder.c:5024 [inline]
 binder_ioctl+0x3470/0x6d00 drivers/android/binder.c:5311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5fdf24ae19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5fdf1fb318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5fdf2d34e8 RCX: 00007f5fdf24ae19
RDX: 0000000020000680 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 00007f5fdf2d34e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5fdf2a02c0
R13: 00007ffc598955af R14: 00007f5fdf1fb400 R15: 0000000000022000
 </TASK>

