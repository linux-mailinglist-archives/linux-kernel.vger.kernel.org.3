Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4425B144D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiIHGBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIHGBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:01:43 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199CDCAC46
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:01:40 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id t18-20020a5d8852000000b0068832d2b28eso10521490ios.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 23:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Bj+Wbx/UmzjK0FY641pqsHmh5/NgL24EGRZkVQlNMNE=;
        b=oDgHA8mCO19Dx8kz/bhw5PSvxCd3iB88hHQmex15RmvjZjYncQjN6k3Nkz6zTiWH2/
         ntEFEMhagT9VRpDLV2npbbkwW70NmR2mXjVhQPkV2/OVmgK5oPGKlZhOWJE06jmYlW7j
         UKxivpc96Ht5P+apyRrq99sUFVQPyheFzGCsmxXyafElQwmGQ8RimKLPV0QP4Bw+uHNP
         19Yh4yiK7kmGOlAJJ6jqLcxGWEWbu6E1QocE+b2i3eyZ1mnbYXvjC6sOuQf0ycqFx0zi
         GtQhcDtt9P4gYvCft9va4tlCyjySI72TfDyk2nphbYnA6YJvfeu2LKtBnpfXHqAvvu7g
         Lv3g==
X-Gm-Message-State: ACgBeo1/jK7Izgdh5emUGGAY61EYXR2XBMwNYyGHvQ4CBl7CBVei2USM
        U8TXOGIdPT7aoDNX0Xxgs5jUf+y4h/tvqOf70CrXoO2l+ah9
X-Google-Smtp-Source: AA6agR5LshaLBEqduvImiX9lJtp75eo3CTNrZuUX6IApzGIhucR/F5y+uF4r8YHhYo1xGeHjPRqMIc8R3dsMFNW+cqj/1TRSMf5b
MIME-Version: 1.0
X-Received: by 2002:a05:6638:272a:b0:349:c1e3:c88c with SMTP id
 m42-20020a056638272a00b00349c1e3c88cmr3842983jav.284.1662616899567; Wed, 07
 Sep 2022 23:01:39 -0700 (PDT)
Date:   Wed, 07 Sep 2022 23:01:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2491b05e8242991@google.com>
Subject: [syzbot] WARNING: locking bug in open_xa_dir
From:   syzbot <syzbot+ca91a9d7f091db185abe@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=128a2817080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57b9bfeca947ab90
dashboard link: https://syzkaller.appspot.com/bug?extid=ca91a9d7f091db185abe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca91a9d7f091db185abe@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 10629 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
WARNING: CPU: 1 PID: 10629 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
Modules linked in:
CPU: 1 PID: 10629 Comm: syz-executor.1 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff800013a3b570
x29: ffff800013a3b650 x28: 0000000000000000 x27: ffff0000ff2ccf80
x26: ffff0000fc51f250 x25: ffff0000ff2cd9b0 x24: 0000000000000080
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: aaaaaaaaaaa78f9e x18: 0000000000000041
x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000ff2ccf80
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d65f8d0
x11: ff808000081c39d0 x10: ffff80000dd7a698 x9 : 2d75630c93b4cc00
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff8000081c0d80
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 check_wait_context kernel/locking/lockdep.c:4727 [inline]
 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x70/0x9c kernel/locking/spinlock.c:170
 rwsem_down_write_slowpath+0xdc/0x520 kernel/locking/rwsem.c:1128
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
irq event stamp: 8960
hardirqs last  enabled at (8959): [<ffff800008163d98>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (8959): [<ffff800008163d98>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (8960): [<ffff80000c01388c>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (8960): [<ffff80000c01388c>] _raw_spin_lock_irq+0x34/0x9c kernel/locking/spinlock.c:170
softirqs last  enabled at (8942): [<ffff80000801c1f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (8940): [<ffff80000801c1c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000013ce6a000
[00000000000000b8] pgd=080000013c54e003, p4d=080000013c54e003, pud=080000013b6f2003, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 10629 Comm: syz-executor.1 Tainted: G        W          6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff800013a3b570
x29: ffff800013a3b650 x28: 0000000000000000 x27: ffff0000ff2ccf80
x26: ffff0000fc51f250 x25: ffff0000ff2cd9b0 x24: 0000000000000080
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: aaaaaaaaaaa78f9e x18: 0000000000000041
x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000ff2ccf80
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d65f8d0
x11: ff808000081c39d0 x10: ffff80000dd7a698 x9 : 00000000000c0f9e
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff8000081c0d80
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4728 [inline]
 __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x70/0x9c kernel/locking/spinlock.c:170
 rwsem_down_write_slowpath+0xdc/0x520 kernel/locking/rwsem.c:1128
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
Code: b002deea 91196210 911a614a b9400329 (3942e114) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b002deea 	adrp	x10, 0x5bdd000
   4:	91196210 	add	x16, x16, #0x658
   8:	911a614a 	add	x10, x10, #0x698
   c:	b9400329 	ldr	w9, [x25]
* 10:	3942e114 	ldrb	w20, [x8, #184] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
