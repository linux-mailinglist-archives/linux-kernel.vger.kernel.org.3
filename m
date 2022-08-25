Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190C15A18C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbiHYS0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbiHYS0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:26:37 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D862402DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:26:36 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e2-20020a056e020b2200b002e1a5b67e29so15600331ilu.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=LwKrF6npo1jj2dev0wAXauVC6HK8/d8AvOms03RjONc=;
        b=Hgv/XuttJ9CEcZNbX5PM6DBaH11KJL1PZ1++tX1VxOoXJ9ImmNvFKheIHdt8I8ECWI
         a08g8V519JTQpOv/0FRCial6p870rT0vlfnNskibjfdpsQANfZUchFm98GJbutIf9Zir
         YHw0wf4ODcfGE3y62t842JQR2gpJ7B07PqL7SPtwBxEWfjfuDr8rniRV9y+SGhcvl3SJ
         hrv/Km2QypZMCnxw2YpYu8EET0NV4GLikHY4DZ/T805wnNeBZuG5AOrOSvs42Ds9Qc4g
         N7F69q88SZH1ZtTyh05wp/lwR39UKlF+JrTf/NSHaZtBhn4P/kdyF05XPdUMY5paStwi
         ih1w==
X-Gm-Message-State: ACgBeo2fkB8UUjsvWCBLlhx2r7HqaeaXd3P2nykUBo4huODcY6AKwlnB
        nHJLixL3HdSN/421//tNUUDPTmO+PBDYdAzDS4JUjiSpgf+R
X-Google-Smtp-Source: AA6agR7etSFH8tALkAEHHxQ0SDcRlS2k0t2uBZ3T9sdYR4D90vQOLTzcP8ozLcrFOLJ07bsvwCsre1lOzSi62mrfsBeUCxgsQAxB
MIME-Version: 1.0
X-Received: by 2002:a92:d110:0:b0:2e0:ed70:ea86 with SMTP id
 a16-20020a92d110000000b002e0ed70ea86mr2359562ilb.43.1661451995445; Thu, 25
 Aug 2022 11:26:35 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:26:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000040a05e714f000@google.com>
Subject: [syzbot] WARNING in reiserfs_readdir_inode
From:   syzbot <syzbot+798ffe5fe3e88235db59@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1756ff03080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=798ffe5fe3e88235db59
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+798ffe5fe3e88235db59@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 64
BFS-fs: bfs_fill_super(): loop3 is unclean, continuing
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 6988 at kernel/locking/mutex.c:582 __mutex_lock_common+0x49c/0xc28 kernel/locking/mutex.c:582
Modules linked in:
CPU: 1 PID: 6988 Comm: syz-executor.3 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x49c/0xc28 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x49c/0xc28 kernel/locking/mutex.c:582
sp : ffff8000139aba10
x29: ffff8000139aba80 x28: ffff80000ee9a000 x27: 0000000000000000
x26: 0000000000000000 x25: ffff80000876a864 x24: 0000000000000002
x23: ffff800008794be8 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0000f81c8228 x18: 000000000000031c
x17: ffff80000c04d6bc x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 0000000000001055 x10: ffff80001d0cc000 x9 : c740583a05b0ad00
x8 : c740583a05b0ad00 x7 : 4e5241575f534b43 x6 : ffff800008197c8c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x49c/0xc28 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_readdir_inode+0x9c/0x68c fs/reiserfs/dir.c:79
 reiserfs_readdir+0x28/0x38 fs/reiserfs/dir.c:274
 iterate_dir+0x114/0x28c
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __arm64_sys_getdents64+0x80/0x214 fs/readdir.c:354
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 1339
hardirqs last  enabled at (1339): [<ffff800008038c9c>] local_daif_restore arch/arm64/include/asm/daifflags.h:75 [inline]
hardirqs last  enabled at (1339): [<ffff800008038c9c>] el0_svc_common+0x40/0x220 arch/arm64/kernel/syscall.c:107
hardirqs last disabled at (1338): [<ffff80000bffee18>] el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
softirqs last  enabled at (1334): [<ffff80000801c1f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1332): [<ffff80000801c1c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6988 at fs/reiserfs/lock.c:91 reiserfs_check_lock_depth+0x48/0x50 fs/reiserfs/lock.c:91
Modules linked in:
CPU: 1 PID: 6988 Comm: syz-executor.3 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : reiserfs_check_lock_depth+0x48/0x50 fs/reiserfs/lock.c:91
lr : reiserfs_check_lock_depth+0x48/0x50 fs/reiserfs/lock.c:91
sp : ffff8000139abaf0
x29: ffff8000139abaf0 x28: ffff0000f6cc9a80 x27: 0000000000000000
x26: ffff0000ca4987b8 x25: ffff80000876a864 x24: 0000000000000000
x23: 0000000000000000 x22: 000000000000003d x21: ffff8000139abd80
x20: ffff0000ca4987b8 x19: 00000000f81c82c1 x18: 000000000000031c
x17: ffff80000c04d6bc x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 00000000000115cc x10: ffff80001d0cc000 x9 : ffff800008794da0
x8 : 00000000000115cd x7 : 4e5241575f534b43 x6 : ffff800008794be8
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000f6cc9a87 x1 : 00000000f81c82c1 x0 : 0000000000000000
Call trace:
 reiserfs_check_lock_depth+0x48/0x50 fs/reiserfs/lock.c:91
 reiserfs_readdir_inode+0xac/0x68c fs/reiserfs/dir.c:81
 reiserfs_readdir+0x28/0x38 fs/reiserfs/dir.c:274
 iterate_dir+0x114/0x28c
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __arm64_sys_getdents64+0x80/0x214 fs/readdir.c:354
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 1339
hardirqs last  enabled at (1339): [<ffff800008038c9c>] local_daif_restore arch/arm64/include/asm/daifflags.h:75 [inline]
hardirqs last  enabled at (1339): [<ffff800008038c9c>] el0_svc_common+0x40/0x220 arch/arm64/kernel/syscall.c:107
hardirqs last disabled at (1338): [<ffff80000bffee18>] el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
softirqs last  enabled at (1334): [<ffff80000801c1f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1332): [<ffff80000801c1c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 000000000000003d
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109179000
[000000000000003d] pgd=080000013ca85003, p4d=080000013ca85003, pud=0800000135d37003, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6988 Comm: syz-executor.3 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : search_by_key+0x110/0x19d8 fs/reiserfs/stree.c:648
lr : pathrelse fs/reiserfs/stree.c:384 [inline]
lr : search_by_key+0xf0/0x19d8 fs/reiserfs/stree.c:641
sp : ffff8000139ab920
x29: ffff8000139aba60 x28: ffff8000139abc10 x27: 0000000000000000
x26: ffff0000ca4987b8 x25: ffff80000876a864 x24: 0000000000000000
x23: 0000000000000000 x22: ffff0000f6492000 x21: 0000000000000001
x20: ffff0000f6492000 x19: ffff8000139abb50 x18: 000000000000031c
x17: ffff80000c04d6bc x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 0000000000023422 x10: ffff80001d0cc000 x9 : 0000000000000002
x8 : 0000000000000035 x7 : 4e5241575f534b43 x6 : ffff800008794be8
x5 : 0000000000000000 x4 : 0000000000000003 x3 : 0000000000000008
x2 : ffff8000139abc10 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 search_by_key+0x110/0x19d8 fs/reiserfs/stree.c:648
 search_by_entry_key+0x44/0x370 fs/reiserfs/namei.c:125
 reiserfs_readdir_inode+0x100/0x68c fs/reiserfs/dir.c:98
 reiserfs_readdir+0x28/0x38 fs/reiserfs/dir.c:274
 iterate_dir+0x114/0x28c
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __arm64_sys_getdents64+0x80/0x214 fs/readdir.c:354
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: f9433e88 52800049 52800103 f9400508 (b9400901) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f9433e88 	ldr	x8, [x20, #1656]
   4:	52800049 	mov	w9, #0x2                   	// #2
   8:	52800103 	mov	w3, #0x8                   	// #8
   c:	f9400508 	ldr	x8, [x8, #8]
* 10:	b9400901 	ldr	w1, [x8, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
