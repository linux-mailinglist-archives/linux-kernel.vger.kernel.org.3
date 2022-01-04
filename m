Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620B948411B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiADLoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiADLoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:44:22 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E71C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 03:44:21 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j83so88607055ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 03:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9BX9i8x1KnaOKwxvPaFzteUxmUJbwmrN/yeLyWpAkDo=;
        b=oZ66q+CNRdEdE3UytaaeO8TyOFEj7/I7Jq0NP6VpkSeVX7IPjaEYkvwQDDeA4f3Gmn
         T4qzlS1z4iAhb+8RlxZjFgA6vX2kMTf2EwNnAqIRuvqpVuLLM4bR/+Xe+nFSRoPE8hfM
         1N1WeuFIFUndhtCIpShAKlPYsI+hIPPR6fwjxwvtYa6k5HfvXlzjr0WWH021tb6go6bo
         DqCrvAdeXSKABZdWQoAC99cCL6U9hUOK1mcugIqv9M5xSPK0BexLm87DcxW2ZiMse6Ji
         eU+l/U9KSYRdDB5Jlmng3ztn/YgzzzHZxQH8fA95VyMSSoV2JNHAIeXMMUQDML00Ua6B
         Po6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9BX9i8x1KnaOKwxvPaFzteUxmUJbwmrN/yeLyWpAkDo=;
        b=WXvYuAaYuJK7w9tXsYFml8Qu3ylM08j9woee5neSTxayAxFHsXAIp79Ik/puijzhwL
         H30CANYz/KAWy2FUsF73Hxr+o9fpbb0cb9ltBw7JtSHLQjCrmeRNNU4V5/Xh2H6xni6+
         M7pk7cygIm8DGnc5rgjhZODo/zCa6IV98AEV1w8j62KB3a3aiWO665x4B8s0ppj380wW
         ec6VLpDTGhBOTXvbsbvkt66cUsDL32pqkohiy/qGgpMmHOLITTHb0GRbGWzeXYjuw10S
         rn4LPLWdhHzhRzRaDhs9e38v27NeXteSTStO+SB3t+k0wHMiI318C3DUwhMe29cJ/jRJ
         UFFw==
X-Gm-Message-State: AOAM532/1jemJ1qUKQwNqGzKpt36eaCMIEgx53QCdkdeCSY68i2xG00v
        Oag3H9qLHgyiYlA2QkEQQpprmoulry+x9LNfx8v+1J58rNdo7A==
X-Google-Smtp-Source: ABdhPJyz/Or1F5BaXe2bJDdv6MfM+/6NstqaynJ7DQyUSUPP8UqfAr98qDs6wB/QU2hQVjBaQgNZFSkA+/1Ffk0wUpA=
X-Received: by 2002:a25:9c44:: with SMTP id x4mr48308700ybo.84.1641296661054;
 Tue, 04 Jan 2022 03:44:21 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 19:44:10 +0800
Message-ID: <CAFkrUsjD2HSRHdZ9yKANa0pLe8rhwPXKbU+E-A7K+td3jS5ZVA@mail.gmail.com>
Subject: INFO: task hung in __filemap_get_folio
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://paste.ubuntu.com/p/ttm2fNzkvN/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>


INFO: task rs:main Q:Reg:6758 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rs:main Q:Reg   state:D stack:25832 pid: 6758 ppid:     1 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 io_schedule+0xb3/0x120 kernel/sched/core.c:8371
 folio_wait_bit_common+0x524/0xa30 mm/filemap.c:1371
 __folio_lock mm/filemap.c:1649 [inline]
 folio_lock include/linux/pagemap.h:783 [inline]
 __filemap_get_folio+0xdd1/0x1080 mm/filemap.c:1921
 pagecache_get_page+0x2c/0x1a0 mm/folio-compat.c:125
 ext4_da_write_begin+0x3bc/0xad0 fs/ext4/inode.c:2958
 generic_perform_write+0x201/0x510 mm/filemap.c:3754
 ext4_buffered_write_iter+0x170/0x360 fs/ext4/file.c:269
 ext4_file_write_iter+0x42e/0x14a0 fs/ext4/file.c:681
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write+0x432/0x660 fs/read_write.c:503
 vfs_write+0x678/0xae0 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff8402951cd
RSP: 002b:00007ff83d850590 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff834021940 RCX: 00007ff8402951cd
RDX: 0000000000000095 RSI: 00007ff834021940 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 35313620205b203a
R10: 0000000000000000 R11: 0000000000000293 R12: 00007ff8340216c0
R13: 00007ff83d8505b0 R14: 000055f3ac883360 R15: 0000000000000095
 </TASK>

Showing all locks held in the system:
1 lock held by systemd/1:
 #0: ffff8880163dd550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff8880163dd550 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
3 locks held by kswapd0/122:
2 locks held by kswapd1/123:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
try_to_freeze_unsafe include/linux/freezer.h:58 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: try_to_freeze
include/linux/freezer.h:67 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
balance_pgdat+0xc63/0x1190 mm/vmscan.c:4227
 #1: ffff8881104ca430 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8881104ca430 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
1 lock held by systemd-journal/3053:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by systemd-udevd/3061:
 #0: ffff888102e82d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888102e82d70 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by sd-resolve/3126:
 #0: ffff88801bc99980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88801bc99980 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by cron/6288:
 #0: ffff88811bdd35c8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
inode_lock_shared include/linux/fs.h:793 [inline]
 #0: ffff88811bdd35c8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
lookup_slow fs/namei.c:1673 [inline]
 #0: ffff88811bdd35c8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
walk_component+0x400/0x6a0 fs/namei.c:1970
1 lock held by in:imklog/6757:
 #0: ffff88801bca6940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88801bca6940 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
3 locks held by rs:main Q:Reg/6758:
 #0: ffff8880158d14f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:1034
 #1: ffff88810138a460 (sb_writers#5){.+.+}-{0:0}, at:
ksys_write+0x12d/0x250 fs/read_write.c:643
 #2: ffff8881104db5c8 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #2: ffff8881104db5c8 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at:
ext4_buffered_write_iter+0xb8/0x360 fs/ext4/file.c:263
1 lock held by syz-fuzzer/6681:
 #0: ffff8881104c9980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff8881104c9980 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by syz-fuzzer/6705:
 #0: ffff8881104c9980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff8881104c9980 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by syz-fuzzer/6776:
 #0: ffff8881104c9980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff8881104c9980 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by syz-executor.7/6790:
 #0: ffff8881104ca430 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8881104ca430 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
2 locks held by kworker/u8:2/7091:
4 locks held by kworker/u8:6/10810:
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000679fdc8 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0x9b/0xa90 net/core/net_namespace.c:555
 #3: ffffffff8bb89e70 (rcu_state.barrier_mutex){+.+.}-{3:3}, at:
rcu_barrier+0x44/0x430 kernel/rcu/tree.c:3985
1 lock held by syz-executor.1/13578:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.1/13694:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/18956:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/19004:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/19028:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.0/20801:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.0/20838:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/24608:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/24792:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/25080:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/28598:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/28694:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/28793:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.0/30370:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.0/30514:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/2238:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/2357:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/2551:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
2 locks held by kworker/3:67/2705:
1 lock held by syz-executor.0/2885:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
7 locks held by kworker/u10:22/3012:
 #0: ffff888013998138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888013998138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888013998138 ((wq_completion)writeback){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888013998138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888013998138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888013998138 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc900149cfdc8
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff88810138a0e0 (&type->s_umount_key#36){++++}-{3:3}, at:
trylock_super+0x1d/0x100 fs/super.c:418
 #3: ffff88810138cbd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at:
do_writepages+0x19b/0x610 mm/page-writeback.c:2364
 #4: ffff88810138e990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
 #5: ffff8881104db450 (&ei->i_data_sem){++++}-{3:3}, at:
ext4_map_blocks+0x5e1/0x17d0 fs/ext4/inode.c:630
 #6: ffff8881104ca430 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #6: ffff8881104ca430 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
1 lock held by syz-executor.7/3492:
 #0: ffff8880221a2478 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff8880221a2478 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.1/4126:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.1/4151:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.1/4278:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/4358:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.3/4432:
 #0: ffff88810138a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590


Best Regards,
Yiru
