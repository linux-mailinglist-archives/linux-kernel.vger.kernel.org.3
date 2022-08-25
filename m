Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A8E5A18BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiHYSZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbiHYSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:25:37 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7120193
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:25:36 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id bh11-20020a056602370b00b00688c8a2b56cso11641182iob.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=8DJQA3NUl/WNUvdLL1qgsBC65nEwws6Bl4q8FsR6s1Q=;
        b=uhjxPyZVYmJeyf40pdVt5OIME+MIYXauLzvjr/qIKYhmCaIAeHQ5HkAwNEQGlPVD70
         new6GV9prxhRazXa6xk45Ood1fFkGS7aR6d5iZRNcRy45/FQ0XppbCOkG41TXvZAlVxo
         ZF3rOEt9q54RBReeRLnvL4jta+udElYtvMkHcbOM128qX9U6qOiWC6TawxdGQ+Q/4q6R
         1OS6vdLx0Vu+1JsUNCkr/K+XviONxaLsLMgRTnhn+oj4/11J9SKkWIASdhfymMxXCiiK
         HBdELYEaYXL3aQCxreCIoBaulaj6+47UYx3qtUZBgLThv8RlBgoXRtA0+IzonBeG8xf5
         iQYQ==
X-Gm-Message-State: ACgBeo3Jdp4UEGZoM5akvGD0m4ERFvHn1qxlhfYFQmgf75+yH8MD3xdk
        lZ3fxudkf5AabjFAGUWuCrvsK3jI2kzv+g8MiTOSpWeky2w3
X-Google-Smtp-Source: AA6agR4EmegXxJDczgxkjZiwTF1Kzrad9adtNkHUcLh1ZvsPLcHpE0XCjA0SODsM65S2yBZIeu6cy9N6x6YrKQkP74+ZCBXAkGKu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13f0:b0:2e9:4be1:b11e with SMTP id
 w16-20020a056e0213f000b002e94be1b11emr2409186ilj.247.1661451935425; Thu, 25
 Aug 2022 11:25:35 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:25:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c2bbc05e714ec79@google.com>
Subject: [syzbot] WARNING in reiserfs_lookup
From:   syzbot <syzbot+392ac209604cc18792e5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1180b113080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+392ac209604cc18792e5@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 13919 at kernel/locking/mutex.c:582 __mutex_lock_common+0x49c/0xc28 kernel/locking/mutex.c:582
Modules linked in:
CPU: 1 PID: 13919 Comm: syz-executor.1 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x49c/0xc28 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x49c/0xc28 kernel/locking/mutex.c:582
sp : ffff80001404b8e0
x29: ffff80001404b950 x28: ffff80000ee9a000 x27: ffff0000e7ff7c30
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000002
x23: ffff800008794be8 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff000100ce2228
 x18: 0000000000000144

x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 0000000000008995 x10: ffff800017d28000 x9 : 8ae7bd2ab6f62200
x8 : 8ae7bd2ab6f62200 x7 : 4e5241575f534b43 x6 : ffff800008197c8c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x49c/0xc28 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_lookup+0xa4/0x1c4 fs/reiserfs/namei.c:364
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x738/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 1381
hardirqs last  enabled at (1381): [<ffff8000085e9378>] seqcount_lockdep_reader_access include/linux/seqlock.h:104 [inline]
hardirqs last  enabled at (1381): [<ffff8000085e9378>] read_seqbegin include/linux/seqlock.h:836 [inline]
hardirqs last  enabled at (1381): [<ffff8000085e9378>] d_alloc_parallel+0x254/0xad0 fs/dcache.c:2657
hardirqs last disabled at (1380): [<ffff8000085e9300>] seqcount_lockdep_reader_access include/linux/seqlock.h:101 [inline]
hardirqs last disabled at (1380): [<ffff8000085e9300>] read_seqbegin include/linux/seqlock.h:836 [inline]
hardirqs last disabled at (1380): [<ffff8000085e9300>] d_alloc_parallel+0x1dc/0xad0 fs/dcache.c:2657
softirqs last  enabled at (1248): [<ffff80000801c1f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1246): [<ffff80000801c1c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000140c5a000
[0000000000000000] pgd=080000012f58f003, p4d=080000012f58f003, pud=080000012f58c003, pmd=0000000000000000
Internal error: Oops: 86000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 13919 Comm: syz-executor.1 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : get_third_component fs/reiserfs/namei.c:196 [inline]
lr : reiserfs_find_entry+0x130/0x298 fs/reiserfs/namei.c:317
sp : ffff80001404b960
x29: ffff80001404b990 x28: 0000000000000000 x27: ffff0000e7ff7c30
x26: ffff0000e7ffc000 x25: ffff0000eea4f000 x24: 0000000010000000
x23: ffff0000e7ffc070 x22: 0000000000000005 x21: ffff80001404b9e0
x20: ffff80001404ba48 x19: ffff0000eb8c0190 x18: 0000000000000144
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000002 x13: 0000000000000002 x12: 0000000000040000
x11: 000000000003ffff x10: ffff800017d28000 x9 : ffff80000875c888
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800008794be8
x5 : 0000000000000000 x4 : ffff80001404b9e0 x3 : ffff80001404ba48
x2 : 0000000000000005 x1 : 0000000000000005 x0 : ffff0000e7ffc070
Call trace:
 0x0
 reiserfs_lookup+0xc4/0x1c4 fs/reiserfs/namei.c:368
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x738/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: bad PC value
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
