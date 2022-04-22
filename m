Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95F050B7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447729AbiDVNKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiDVNKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:10:12 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5886B22B3E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:07:19 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id p10-20020a056e02104a00b002caa828f7b1so4420613ilj.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Pdzb3i5KyQeTk+zvHZ+u9HIYBMcZ66XsdCqWjq0KVso=;
        b=y54AeXRhwy8uSp5t1uGUk9u82+czGzaTVfYpCVR0+HbgucDgzSeGo9/NwY7ZUX5mFZ
         p8jKHlPpB13GfoBPM1J8QRIORVpH+jjZPvdNkHtXDw87PCCixjWHL0Wu+ABEmC8UP/uP
         a/qChzmMkoGwFFKdMwiHhtUb16cKfV1AdlqaokkeCzAI9kxoyJ+OP2HfJ6fovR1fJ33F
         ULduLnKGrjEDuYOGKJMlAxx8ipCf8FQbbqTuWPu8/pdNkSiw1t3qKnKMIlZnjMC03Ep4
         0NfcjTcnR+oL1fml/p9nqJXZKzWIOyNSh4d02FZrSWK6W5P8Z0YXT70q+f+5NE3sbuDe
         woIA==
X-Gm-Message-State: AOAM533AzVPUXGMHd60Wpt5j9eDygjABCKWQ7uZTT9Q0bNUpqtxaMsTD
        Rzl/Ypkdn4nJwuJyeFJu+wFdYKk70TVM8gOqsIbITJgpB3E3
X-Google-Smtp-Source: ABdhPJx3jeyD1SzEsNko6rMOpkq/4qmVE9zBCiLOxqBdtZJtQ9YLaimz+/B1Rvfi9C38fbtiOLWZYEEhmGML2gXl2OwK4VfZB9Ql
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2510:b0:323:dcd9:91dd with SMTP id
 v16-20020a056638251000b00323dcd991ddmr2078306jat.168.1650632838694; Fri, 22
 Apr 2022 06:07:18 -0700 (PDT)
Date:   Fri, 22 Apr 2022 06:07:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000149eb05dd3de8cc@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_iget5
From:   syzbot <syzbot+b4084c18420f9fad0b4f@syzkaller.appspotmail.com>
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

HEAD commit:    d569e86915b7 Merge tag 'drm-fixes-2022-04-22' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13285ddcf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71bf5c8488a4e33a
dashboard link: https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4084c18420f9fad0b4f@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 8185
ntfs3: loop2: Different NTFS' sector size (2048) and media sector size (512)
==================================================================
BUG: KASAN: slab-out-of-bounds in ntfs_iget5+0x2b93/0x3240 fs/ntfs3/inode.c:501
Read of size 8 at addr ffff888073687f28 by task syz-executor.2/9904

CPU: 1 PID: 9904 Comm: syz-executor.2 Not tainted 5.18.0-rc3-syzkaller-00080-gd569e86915b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 ntfs_iget5+0x2b93/0x3240 fs/ntfs3/inode.c:501
 ntfs_fill_super+0x2529/0x37b0 fs/ntfs3/super.c:1083
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
RIP: 0033:0x7f6e8f88a61a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e90903f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f6e8f88a61a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f6e90903fe0
RBP: 00007f6e90904020 R08: 00007f6e90904020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f6e90903fe0 R15: 000000002007a980
 </TASK>

Allocated by task 3611:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:749 [inline]
 slab_alloc_node mm/slub.c:3217 [inline]
 slab_alloc mm/slub.c:3225 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3232 [inline]
 kmem_cache_alloc_lru+0x255/0x720 mm/slub.c:3249
 alloc_inode_sb include/linux/fs.h:2966 [inline]
 sock_alloc_inode+0x23/0x1d0 net/socket.c:304
 alloc_inode+0x61/0x230 fs/inode.c:260
 new_inode_pseudo+0x14/0xe0 fs/inode.c:1018
 sock_alloc+0x3c/0x260 net/socket.c:627
 __sock_create+0xb9/0x790 net/socket.c:1432
 sock_create net/socket.c:1519 [inline]
 __sys_socket+0xef/0x200 net/socket.c:1561
 __do_sys_socket net/socket.c:1570 [inline]
 __se_sys_socket net/socket.c:1568 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:3074
 destroy_inode+0x129/0x1b0 fs/inode.c:315
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x806/0xdb0 fs/dcache.c:913
 __fput+0x39c/0x9d0 fs/file_table.c:330
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:3074
 destroy_inode+0x129/0x1b0 fs/inode.c:315
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x806/0xdb0 fs/dcache.c:913
 __fput+0x39c/0x9d0 fs/file_table.c:330
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888073687800
 which belongs to the cache sock_inode_cache of size 1408
The buggy address is located 424 bytes to the right of
 1408-byte region [ffff888073687800, ffff888073687d80)

The buggy address belongs to the physical page:
page:ffffea0001cda000 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888073680600 pfn:0x73680
head:ffffea0001cda000 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff888079fa8401
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888140795500
raw: ffff888073680600 000000008015000b 00000001ffffffff ffff888079fa8401
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 3171, tgid 3171 (dhcpcd), ts 33789392393, free_ts 10721584612
 prep_new_page mm/page_alloc.c:2441 [inline]
 get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4182
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5408
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x8df/0xf20 mm/slub.c:3005
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3092
 slab_alloc_node mm/slub.c:3183 [inline]
 slab_alloc mm/slub.c:3225 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3232 [inline]
 kmem_cache_alloc_lru+0x504/0x720 mm/slub.c:3249
 alloc_inode_sb include/linux/fs.h:2966 [inline]
 sock_alloc_inode+0x23/0x1d0 net/socket.c:304
 alloc_inode+0x61/0x230 fs/inode.c:260
 new_inode_pseudo+0x14/0xe0 fs/inode.c:1018
 sock_alloc+0x3c/0x260 net/socket.c:627
 __sock_create+0xb9/0x790 net/socket.c:1432
 sock_create net/socket.c:1519 [inline]
 __sys_socket+0xef/0x200 net/socket.c:1561
 __do_sys_socket net/socket.c:1570 [inline]
 __se_sys_socket net/socket.c:1568 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1356 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3328 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3423
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9418
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1018
 debug_vm_pgtable+0x2a51/0x2ae3 mm/debug_vm_pgtable.c:1332
 do_one_initcall+0x103/0x650 init/main.c:1298
 do_initcall_level init/main.c:1371 [inline]
 do_initcalls init/main.c:1387 [inline]
 do_basic_setup init/main.c:1406 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1613
 kernel_init+0x1a/0x1d0 init/main.c:1502
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

Memory state around the buggy address:
 ffff888073687e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888073687e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888073687f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff888073687f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888073688000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
