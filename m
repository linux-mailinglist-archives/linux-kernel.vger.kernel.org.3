Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318F35AE584
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbiIFKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiIFKib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:38:31 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278305246C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:38:30 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id m12-20020a056e021c2c00b002ed9189c241so9090095ilh.15
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 03:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=uye+0uA3L0WPBl1M24A1PCgLZiPDl1bpMsz8HwyNdWs=;
        b=dREPPQEkXjCZQZ1+D9snFpZ/G2vmnrxeFlhcoAwSmDAaxrhZZ6bxkpUJkNAXcfcVSi
         hC4Izg3FdxO6E+hJ1ih4RPBUw+QUbWMTr0kH/7fSw725dfWeA1U/r/EKBvg7mjDtBLG9
         NF9gUlsoDmvZKvKichAtlQYrvUAs+jULw/qD2fjufarPVqWvmyV18jWoKNlKmFIqoCzm
         DOYTBCowVCVKFGeTMtrLi9wCD6QaflasK+bzu8E8VufR+5xx5CCjzqOEP5ZJkNr9PZRb
         0YlUzsqXrombNYmHfsKBFs6HAFKrpp32hI0CGIUUr7/4cF5/ETAZe9BnaRZ3AyBGDhUB
         h4Qg==
X-Gm-Message-State: ACgBeo0AAgpG6EwDaS4nk6S4LMDLtO1HXBa1K2OOqTWFWJfpt2YqYOcp
        MSIUqxN/2EhDmE6buqo1wEawPmZOKyEV62q3lZnFBRmkuBs2
X-Google-Smtp-Source: AA6agR5a5aKr7abdGCyQv56kEjKcgoznOlrbDZVOc4HBW2AgH4ABANVgZ0ahSXg958CKzHIO1O6JGh7cX4KbDSGEb7m6c4IrwjIw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1048:b0:2ea:a65c:66e6 with SMTP id
 p8-20020a056e02104800b002eaa65c66e6mr24336405ilj.28.1662460709510; Tue, 06
 Sep 2022 03:38:29 -0700 (PDT)
Date:   Tue, 06 Sep 2022 03:38:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b262905e7ffcc05@google.com>
Subject: [syzbot] INFO: trying to register non-static key in open_xa_dir
From:   syzbot <syzbot+65fa614434c3a3ae70ae@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    85413d1e802e Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13aeb7bd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57b9bfeca947ab90
dashboard link: https://syzkaller.appspot.com/bug?extid=65fa614434c3a3ae70ae
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65fa614434c3a3ae70ae@syzkaller.appspotmail.com

EXT4-fs (loop3): Cannot turn on quotas: error -22
EXT4-fs error (device loop3): ext4_orphan_get:1419: comm syz-executor.3: bad orphan inode 2147483648
EXT4-fs (loop3): mounted filesystem without journal. Quota mode: writeback.
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 12538 Comm: syz-executor.3 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call trace:
 dump_backtrace+0x1b0/0x1dc arch/arm64/kernel/stacktrace.c:182
 show_stack+0x2c/0x64 arch/arm64/kernel/stacktrace.c:189
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 assign_lock_key+0x134/0x140 kernel/locking/lockdep.c:979
 register_lock_class+0xc4/0x2f8 kernel/locking/lockdep.c:1292
 __lock_acquire+0xa8/0x30a4 kernel/locking/lockdep.c:4932
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_write_nested+0x64/0xc4 kernel/locking/rwsem.c:1662
 inode_lock_nested include/linux/fs.h:791 [inline]
 open_xa_root fs/reiserfs/xattr.c:127 [inline]
 open_xa_dir+0x5c/0x2a8 fs/reiserfs/xattr.c:152
 xattr_lookup+0x34/0x198 fs/reiserfs/xattr.c:395
 reiserfs_xattr_get+0x8c/0x680 fs/reiserfs/xattr.c:677
 reiserfs_get_acl+0x84/0x1ac fs/reiserfs/xattr_acl.c:214
 get_acl+0x104/0x330 fs/posix_acl.c:152
 check_acl+0x40/0x168 fs/namei.c:306
 acl_permission_check fs/namei.c:351 [inline]
 generic_permission+0x270/0x32c fs/namei.c:404
 reiserfs_permission+0x4c/0x6c fs/reiserfs/xattr.c:954
 do_inode_permission fs/namei.c:458 [inline]
 inode_permission+0x128/0x244 fs/namei.c:525
 may_open+0x1e4/0x2bc fs/namei.c:3185
 do_open fs/namei.c:3555 [inline]
 path_openat+0xdd0/0x11c4 fs/namei.c:3691
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
Unable to handle kernel paging request at virtual address ffff7fff437161a0
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c5736000
[ffff7fff437161a0] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 12538 Comm: syz-executor.3 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : decode_cpu kernel/locking/osq_lock.c:34 [inline]
pc : osq_lock+0x60/0x1cc kernel/locking/osq_lock.c:111
lr : osq_lock+0x38/0x1cc kernel/locking/osq_lock.c:94
sp : ffff8000134eb6e0
x29: ffff8000134eb6e0 x28: 0000000000000030 x27: ffff0000e96a4270
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000fc36b500
x23: 0000000000000000 x22: ffff80000d2e1a00 x21: ffff80000d37cf28
x20: ffff0001fefefa00 x19: ffff0000f7ce6d50 x18: 0000000000000000
x17: 6e69676e45206574 x16: 0000000000000001 x15: 0000000000000000
x14: 0000000000000000 x13: 205d383335323154 x12: 5b5d313738343532
x11: ff808000095ecd98 x10: 0000000000000000 x9 : 0000000000000002
x8 : 00000000e6c7324f x7 : 545b5d3137383435 x6 : ffff800008197c80
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000ce74037 x0 : 0000000000000001
Call trace:
 decode_cpu kernel/locking/osq_lock.c:32 [inline]
 osq_lock+0x60/0x1cc kernel/locking/osq_lock.c:111
 rwsem_optimistic_spin+0x38/0x1f4 kernel/locking/rwsem.c:827
 rwsem_down_write_slowpath+0xb0/0x520 kernel/locking/rwsem.c:1114
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write_nested+0x90/0xc4 kernel/locking/rwsem.c:1663
 inode_lock_nested include/linux/fs.h:791 [inline]
 open_xa_root fs/reiserfs/xattr.c:127 [inline]
 open_xa_dir+0x5c/0x2a8 fs/reiserfs/xattr.c:152
 xattr_lookup+0x34/0x198 fs/reiserfs/xattr.c:395
 reiserfs_xattr_get+0x8c/0x680 fs/reiserfs/xattr.c:677
 reiserfs_get_acl+0x84/0x1ac fs/reiserfs/xattr_acl.c:214
 get_acl+0x104/0x330 fs/posix_acl.c:152
 check_acl+0x40/0x168 fs/namei.c:306
 acl_permission_check fs/namei.c:351 [inline]
 generic_permission+0x270/0x32c fs/namei.c:404
 reiserfs_permission+0x4c/0x6c fs/reiserfs/xattr.c:954
 do_inode_permission fs/namei.c:458 [inline]
 inode_permission+0x128/0x244 fs/namei.c:525
 may_open+0x1e4/0x2bc fs/namei.c:3185
 do_open fs/namei.c:3555 [inline]
 path_openat+0xdd0/0x11c4 fs/namei.c:3691
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
Code: d503201f d503201f 340005e8 51000508 (f868daa8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d503201f 	nop
   4:	d503201f 	nop
   8:	340005e8 	cbz	w8, 0xc4
   c:	51000508 	sub	w8, w8, #0x1
* 10:	f868daa8 	ldr	x8, [x21, w8, sxtw #3] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
