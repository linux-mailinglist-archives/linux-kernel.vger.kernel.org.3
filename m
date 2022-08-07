Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FA58B967
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 06:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiHGEl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 00:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiHGEly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 00:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E281054E;
        Sat,  6 Aug 2022 21:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2E9C60DC0;
        Sun,  7 Aug 2022 04:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66A0C433D6;
        Sun,  7 Aug 2022 04:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659847311;
        bh=OqORF+gHxF36tqoG4hqDTAHhgFXoksThcYI1hN30+zU=;
        h=Date:From:To:Cc:Subject:From;
        b=h9l1ObwIaXlOiR8r1iVkqL3/RIAxZ78FXCZqfAzzxcvcAwzoBmUbLOTay7mf8LRyf
         rlUj+QjcuaO+bkr79UQKDaVj/JfTjeNhvKnbvc5EQuKMTZ+1HTdBlza9HGp1Ujb0Xd
         lX0rHNmOuUGdOaI097oTendpctCljg0xKJxzg/no=
Date:   Sat, 6 Aug 2022 21:41:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] non-MM updates for 5.20-rc1
Message-Id: <20220806214150.9a96339c1d343b003a48a3a0@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Good evening.  A relatively small amount of material this time.


The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-08-06-2

for you to fetch changes up to b99695580bfc1f91364023c673681ddb88e375dc:

  scripts/gdb: ensure the absolute path is generated on initial source (2022-07-29 18:12:37 -0700)

----------------------------------------------------------------
Updates to various subsystems which I help look after.  lib, ocfs2,
fatfs, autofs, squashfs, procfs, etc.

----------------------------------------------------------------
Aaron Tomlin (1):
      scripts/gdb: ensure the absolute path is generated on initial source

Alexey Dobriyan (3):
      proc: delete unused <linux/uaccess.h> includes
      proc: fix test for "vsyscall=xonly" boot option
      proc: add some (hopefully) insightful comments

Andrew Morton (1):
      Merge branch 'master' into mm-nonmm-stable

Andy Shevchenko (1):
      include/linux/rbtree.h: replace kernel.h with the necessary inclusions

Antonio Borneo (1):
      checkpatch: fix incorrect camelcase detection on numeric constant

Ben Dooks (2):
      kernel/hung_task: fix address space of proc_dohung_task_timeout_secs
      profile: setup_profiling_timer() is moslty not implemented

Benjamin Segall (1):
      epoll: autoremove wakers even more aggressively

Brendan Higgins (2):
      mailmap: add linux.dev alias for Brendan Higgins
      MAINTAINERS: kunit: add David Gow as a maintainer of KUnit

Chen Zhongjin (1):
      profiling: fix shift too large makes kernel panic

Christophe JAILLET (3):
      ocfs2: remove some useless functions
      ocfs2: use the bitmap API to simplify code
      ocfs2: fix a typo in a comment

Colin Ian King (1):
      lib/ts_bm.c: remove redundant store to variable consumed after addition

Dan Carpenter (1):
      kfifo: fix kfifo_to_user() return type

Dan Moulding (1):
      init: add "hostname" kernel parameter

Guenter Roeck (1):
      lib/list_debug.c: Detect uninitialized lists

Hsin-Yi Wang (2):
      Revert "squashfs: provide backing_dev_info in order to disable read-ahead"
      squashfs: implement readahead

Ian Kent (5):
      autofs: use inode permission method for write access
      autofs: make dentry info count consistent
      autofs: use dentry info count instead of simple_empty()
      autofs: add comment about autofs_mountpoint_changed()
      autofs: remove unused ino field inode

Javier Martinez Canillas (3):
      fat: add a vfat_rename2() and make existing .rename callback a helper
      fat: add renameat2 RENAME_EXCHANGE flag support
      selftests/filesystems: add a vfat RENAME_EXCHANGE test

Jiangshan Yi (2):
      fs/ocfs2: Fix spelling typo in comment
      lib/lzo/lzo1x_compress.c: replace ternary operator with min() and min_t()

Joe Perches (1):
      checkpatch: add XA_STATE and XA_STATE_ORDER to the macro declaration list

Junxiao Bi (1):
      ocfs2: kill EBUSY from dlmfs_evict_inode

Justin Stitt (1):
      include/uapi/linux/swab.h: move explicit cast outside ternary

Kirill Tkhai (1):
      mailmap: update Kirill's email

Luc Van Oostenryck (1):
      ia64: fix sparse warnings with cmpxchg() & xchg()

Mark-PK Tsai (1):
      lib: devres: use numa aware allocation

Nikolay Borisov (2):
      scripts/bloat-o-meter: switch argument parsing to using argparse
      scripts/bloat-o-meter: add -p argument

OGAWA Hirofumi (1):
      fat: factor out reusable code in vfat_rename() as helper functions

Pasha Tatashin (2):
      fs/kernel_read_file: allow to read files up-to ssize_t
      kexec_file: increase maximum file size to 4G

Phillip Lougher (4):
      squashfs: extend "page actor" to handle missing pages
      squashfs: don't use intermediate buffer if pages missing
      squashfs: always build "file direct" version of page actor
      squashfs: support reading fragments in readahead call

Sander Vanheule (5):
      x86/cacheinfo: move shared cache map definitions
      cpumask: add UP optimised for_each_*_cpu versions
      cpumask: Fix invalid uniprocessor mask assumption
      lib/test: introduce cpumask KUnit test suite
      cpumask: update cpumask_next_wrap() signature

Slark Xiao (1):
      lib/mpi: fix typo 'the the' in comment

Souptick Joarder (HPE) (1):
      ia64: old_rr4 added under CONFIG_HUGETLB_PAGE

Stephen Brennan (2):
      kallsyms: move declarations to internal header
      vmcoreinfo: include kallsyms symbols

Tao Liu (1):
      kdump: round up the total memory size to 128M for crashkernel reservation

Tetsuo Handa (1):
      lib/smp_processor_id: fix imbalanced instrumentation_end() call

Tiezhu Yang (1):
      lib: make LZ4_decompress_safe_forceExtDict() static

Uros Bizjak (1):
      compiler-gcc.h: remove ancient workaround for gcc PR 58670

Vlastimil Babka (1):
      lib/stackdepot: replace CONFIG_STACK_HASH_ORDER with automatic sizing

Xiu Jianfeng (1):
      bdi: remove enum wb_congested_state

Yu Zhe (1):
      ipc/mqueue: remove unnecessary (void*) conversion

Zhihao Cheng (1):
      proc: fix a dentry lock race between release_task and lookup

cxbing (1):
      delayacct: remove some unused variables

wuchi (8):
      lib/flex_proportions.c: remove local_irq_ops in fprop_new_period()
      lib/btree: simplify btree_{lookup|update}
      lib/error-inject: convert to DEFINE_SEQ_ATTRIBUTE
      lib/lru_cache: fix error free handing in lc_create
      net, lib/once: remove {net_}get_random_once_wait macro
      lib/error-inject: traverse list with mutex
      lib/radix-tree: remove unused argument of insert_entries
      lib/scatterlist: use matched parameter type when calling __sg_free_table()

 .mailmap                                           |   3 +-
 Documentation/admin-guide/kernel-parameters.txt    |  13 ++
 MAINTAINERS                                        |   2 +
 arch/alpha/kernel/smp.c                            |   6 -
 arch/arc/kernel/smp.c                              |   8 -
 arch/arm/kernel/smp.c                              |   8 -
 arch/arm64/kernel/smp.c                            |   8 -
 arch/csky/kernel/smp.c                             |   5 -
 arch/hexagon/kernel/smp.c                          |   5 -
 arch/ia64/include/asm/mmu_context.h                |   5 +-
 arch/ia64/include/uapi/asm/cmpxchg.h               |  28 +--
 arch/ia64/kernel/smp.c                             |   6 -
 arch/openrisc/kernel/smp.c                         |   6 -
 arch/parisc/kernel/smp.c                           |   7 -
 arch/powerpc/kernel/smp.c                          |   7 -
 arch/riscv/kernel/smp.c                            |   6 -
 arch/sparc/kernel/smp_32.c                         |   5 -
 arch/sparc/kernel/smp_64.c                         |   6 -
 arch/x86/include/asm/apic.h                        |   2 -
 arch/x86/kernel/apic/apic.c                        |   5 -
 arch/x86/kernel/cpu/cacheinfo.c                    |   6 +
 arch/x86/kernel/smpboot.c                          |   4 -
 fs/autofs/autofs_i.h                               |   7 +-
 fs/autofs/expire.c                                 |   2 +-
 fs/autofs/inode.c                                  |   1 +
 fs/autofs/root.c                                   | 108 +++++-----
 fs/eventpoll.c                                     |  22 ++
 fs/fat/namei_vfat.c                                | 231 +++++++++++++++++----
 fs/kernel_read_file.c                              |  38 ++--
 fs/ocfs2/dlmfs/dlmfs.c                             |  14 +-
 fs/ocfs2/heartbeat.c                               |  27 +--
 fs/ocfs2/quota_global.c                            |   2 +-
 fs/proc/array.c                                    |   5 +-
 fs/proc/base.c                                     |  46 +++-
 fs/proc/inode.c                                    |  19 +-
 fs/proc/kmsg.c                                     |   1 -
 fs/proc/nommu.c                                    |   1 -
 fs/proc/proc_net.c                                 |   9 +-
 fs/proc/proc_tty.c                                 |   2 -
 fs/proc/root.c                                     |   8 +-
 fs/proc/vmcore.c                                   |   1 -
 fs/squashfs/Makefile                               |   4 +-
 fs/squashfs/block.c                                |  10 +-
 fs/squashfs/decompressor.h                         |   1 +
 fs/squashfs/file.c                                 | 133 +++++++++++-
 fs/squashfs/file_direct.c                          |  90 ++------
 fs/squashfs/lz4_wrapper.c                          |   7 +-
 fs/squashfs/lzo_wrapper.c                          |   7 +-
 fs/squashfs/page_actor.c                           |  55 ++++-
 fs/squashfs/page_actor.h                           |  57 ++---
 fs/squashfs/super.c                                |  33 ---
 fs/squashfs/xz_wrapper.c                           |  11 +-
 fs/squashfs/zlib_wrapper.c                         |  12 +-
 fs/squashfs/zstd_wrapper.c                         |  12 +-
 include/linux/backing-dev-defs.h                   |   7 -
 include/linux/compiler-gcc.h                       |  11 -
 include/linux/cpumask.h                            | 108 +++-------
 include/linux/kernel_read_file.h                   |  32 +--
 include/linux/kfifo.h                              |   2 +-
 include/linux/limits.h                             |   1 +
 include/linux/net.h                                |   2 -
 include/linux/once.h                               |   2 -
 include/linux/rbtree.h                             |   2 +-
 include/uapi/linux/swab.h                          |   6 +-
 init/version.c                                     |  17 ++
 ipc/mqueue.c                                       |   2 +-
 kernel/crash_core.c                                |  28 ++-
 kernel/hung_task.c                                 |   2 +-
 kernel/kallsyms.c                                  |  23 +-
 kernel/kallsyms_internal.h                         |  30 +++
 kernel/kexec_file.c                                |  10 +-
 kernel/profile.c                                   |  15 +-
 lib/Kconfig                                        |   9 -
 lib/Kconfig.debug                                  |   9 +
 lib/Makefile                                       |   4 +-
 lib/btree.c                                        |  30 ++-
 lib/cpumask.c                                      |   2 +
 lib/devres.c                                       |  15 +-
 lib/error-inject.c                                 |  28 ++-
 lib/flex_proportions.c                             |  10 +-
 lib/list_debug.c                                   |  12 +-
 lib/lru_cache.c                                    |   4 +-
 lib/lz4/lz4_decompress.c                           |   6 +-
 lib/lzo/lzo1x_compress.c                           |   6 +-
 lib/mpi/mpiutil.c                                  |   2 +-
 lib/radix-tree.c                                   |   4 +-
 lib/scatterlist.c                                  |   4 +-
 lib/smp_processor_id.c                             |   2 +-
 lib/stackdepot.c                                   |  59 +++++-
 lib/test_cpumask.c                                 | 138 ++++++++++++
 lib/ts_bm.c                                        |   2 +-
 scripts/bloat-o-meter                              |  47 +++--
 scripts/checkpatch.pl                              |   5 +-
 scripts/gdb/vmlinux-gdb.py                         |   2 +-
 tools/accounting/getdelays.c                       |   4 -
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/filesystems/fat/.gitignore |   2 +
 tools/testing/selftests/filesystems/fat/Makefile   |   7 +
 tools/testing/selftests/filesystems/fat/config     |   2 +
 .../selftests/filesystems/fat/rename_exchange.c    |  37 ++++
 .../selftests/filesystems/fat/run_fat_tests.sh     |  82 ++++++++
 tools/testing/selftests/proc/proc-pid-vm.c         |  75 ++++++-
 102 files changed, 1313 insertions(+), 724 deletions(-)
 create mode 100644 kernel/kallsyms_internal.h
 create mode 100644 lib/test_cpumask.c
 create mode 100644 tools/testing/selftests/filesystems/fat/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100644 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

