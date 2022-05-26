Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6312535609
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiEZWOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344977AbiEZWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:14:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47580EAB8F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9465B821A8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837B3C385B8;
        Thu, 26 May 2022 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653603278;
        bh=kILx+LcKJ6k0RK9EMuMaxNSXIY2OsL8JgFOm84PvI7E=;
        h=Date:From:To:Cc:Subject:From;
        b=jMhTuFMCd8jaHhKbbGcNj6pe7yueU7zKsxhJTpVRsZ2t6j5euekqHicxAfzaguGkG
         sTl9i7+/WPDyhvQpBr7R9hP9oiKy61tdsP9Ddor4io048GwGb9Ike82yKrtE4cWTjb
         be/vQhYqNlBfxgxQze1G4HeEb/1L9KA0KZy/pWv4=
Date:   Thu, 26 May 2022 15:14:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] non-MM updates for 5.19-rc1
Message-Id: <20220526151437.f0bad876b435dfe494be9203@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the non-MM patches queue for this merge window.


The following changes since commit 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4:

  Merge tag 'drm-fixes-2022-04-29' of git://anongit.freedesktop.org/drm/drm=
 (2022-04-28 18:00:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stabl=
e-2022-05-26

for you to fetch changes up to 3159d79b56c15068aeb7e4630cd5f6dacd20fda4:

  kcov: update pos before writing pc in trace function (2022-05-25 13:05:42=
 -0700)

----------------------------------------------------------------
Not a lot of material this cycle.  Many singleton patches against various
subsystems.   Most notably some maintenance work in ocfs2 and initramfs.

----------------------------------------------------------------
Alexey Dobriyan (2):
      proc: fix dentry/inode overinstantiating under /proc/${pid}/net
      ELF, uapi: fixup ELF_ST_TYPE definition

Benjamin St=FCrz (1):
      ia64: replace comments with C99 initializers

Christoph Hellwig (1):
      net: unexport csum_and_copy_{from,to}_user

Chung-Chiang Cheng (4):
      fat: split fat_truncate_time() into separate functions
      fat: ignore ctime updates, and keep ctime identical to mtime in memory
      fat: report creation time in statx
      fat: remove time truncations in vfat_create/vfat_mkdir

Colin Ian King (2):
      relay: remove redundant assignment to pointer buf
      fs/ntfs: remove redundant variable idx

Congyu Liu (1):
      kcov: update pos before writing pc in trace function

David Disseldorp (6):
      initramfs: refactor do_header() cpio magic checks
      initramfs: make dir_entry.name a flexible array member
      initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig option
      gen_init_cpio: fix short read file handling
      gen_init_cpio: support file checksum archiving
      initramfs: support cpio extraction with file checksums

Dr. Thomas Orgis (1):
      taskstats: version 12 with thread group and exe info

Haowen Bai (2):
      kernel: pid_namespace: use NULL instead of using plain integer as poi=
nter
      ia64: mca: drop redundant spinlock initialization

Heming Zhao via Ocfs2-devel (5):
      ocfs2: fix mounting crash if journal is not alloced
      ocfs2: change return type of ocfs2_resmap_init
      ocfs2: ocfs2_initialize_super does cleanup job before return error
      ocfs2: ocfs2_mount_volume does cleanup job before return error
      ocfs2: rewrite error handling of ocfs2_fill_super

Jakob Koschel (4):
      ocfs2: replace usage of found with dedicated list iterator variable
      ocfs2: remove usage of list iterator variable after the loop body
      fs/proc/kcore.c: remove check of list iterator against head past the =
loop body
      rapidio: remove unnecessary use of list iterator

Jonathan Lassoff (1):
      fatfs: add FAT messages to printk index

Julia Lawall (2):
      ia64: fix typos in comments
      ia64: ptrace: fix typos in comments

Julius Hemanth Pitti (1):
      proc/sysctl: make protected_* world readable

Junxiao Bi (1):
      ocfs2: dlmfs: don't clear USER_LOCK_ATTACHED when destroying lock

Junxiao Bi via Ocfs2-devel (1):
      ocfs2: dlmfs: fix error handling of user_dlm_destroy_lock

Kees Cook (1):
      init/Kconfig: remove USELIB syscall by default

Kuniyuki Iwashima (2):
      pipe: make poll_usage boolean and annotate its access
      list: fix a data-race around ep->rdllist

Liu Shixin (1):
      fs: sysv: check sbi->s_firstdatazone in complete_read_super

Matthew Wilcox (Oracle) (3):
      vmcore: convert copy_oldmem_page() to take an iov_iter
      vmcore: convert __read_vmcore to use an iov_iter
      vmcore: convert read_from_oldmem() to take an iov_iter

Michal Orzel (2):
      kexec: remove redundant assignments
      ipc/sem: remove redundant assignments

Muchun Song (1):
      MAINTAINERS: add Muchun as a memcg reviewer

OGAWA Hirofumi (1):
      fat: add ratelimit to fat*_ent_bread()

Paul Gortmaker (1):
      scripts/bloat-o-meter: filter out vermagic as it is not relevant

Prakash Sangappa (1):
      ipc: update semtimedop() to use hrtimer

Puyou Lu (1):
      lib/string_helpers: fix not adding strarray to device's resource list

Qi Zheng (1):
      tty: fix deadlock caused by calling printk() under tty_port->lock

Randy Dunlap (1):
      fs/ntfs3: validate BOOT sectors_per_clusters

Rasmus Villemoes (3):
      lib/Kconfig.debug: remove more CONFIG_..._VALUE indirections
      lib/test_string.c: add strspn and strcspn tests
      lib/string.c: simplify str[c]spn

Rob Herring (1):
      get_maintainer: Honor mailmap for in file emails

Schspa Shi (1):
      scripts/decode_stacktrace.sh: support old bash version

Tiezhu Yang (3):
      ptrace: remove redudant check of #ifdef PTRACE_SINGLESTEP
      ptrace: fix wrong comment of PT_DTRACE
      MAINTAINERS: remove redundant file of PTRACE SUPPORT entry

Tom Rix (1):
      lib: remove back_str initialization

Waiman Long (1):
      ipc/mqueue: use get_tree_nodev() in mqueue_get_tree()

Xiaoke Wang (1):
      lib/test_meminit: optimize do_kmem_cache_rcu_persistent() test

Yubo Feng (1):
      fatfs: remove redundant judgment

lizhe (1):
      kernel/crash_core.c: remove redundant check of ck_cmdline

xu xin (1):
      kernel: make taskstats available from all net namespaces

 MAINTAINERS                              |   2 +-
 arch/alpha/lib/csum_partial_copy.c       |   1 -
 arch/arm/kernel/crash_dump.c             |  27 +-
 arch/arm64/kernel/crash_dump.c           |  29 +--
 arch/ia64/kernel/crash_dump.c            |  32 +--
 arch/ia64/kernel/kprobes.c               |  64 ++---
 arch/ia64/kernel/mca.c                   |   1 -
 arch/ia64/kernel/palinfo.c               |   2 +-
 arch/ia64/kernel/ptrace.c                |   2 +-
 arch/ia64/kernel/traps.c                 |   2 +-
 arch/ia64/mm/init.c                      |   2 +-
 arch/ia64/mm/tlb.c                       |   4 +-
 arch/m68k/lib/checksum.c                 |   2 -
 arch/mips/kernel/crash_dump.c            |  27 +-
 arch/powerpc/kernel/crash_dump.c         |  35 +--
 arch/powerpc/lib/checksum_wrappers.c     |   2 -
 arch/riscv/kernel/crash_dump.c           |  26 +-
 arch/s390/kernel/crash_dump.c            |  13 +-
 arch/sh/kernel/crash_dump.c              |  29 +--
 arch/x86/kernel/crash_dump_32.c          |  29 +--
 arch/x86/kernel/crash_dump_64.c          |  48 ++--
 arch/x86/lib/csum-wrappers_64.c          |   2 -
 drivers/rapidio/devices/rio_mport_cdev.c |   4 +-
 drivers/tty/tty_buffer.c                 |   3 +-
 fs/fat/fat.h                             |  14 +-
 fs/fat/fatent.c                          |   7 +-
 fs/fat/file.c                            |  14 +-
 fs/fat/inode.c                           |  19 +-
 fs/fat/misc.c                            |  78 +++---
 fs/fat/namei_vfat.c                      |   4 -
 fs/namei.c                               |   8 +-
 fs/ntfs/file.c                           |   4 +-
 fs/ntfs3/super.c                         |  10 +-
 fs/ocfs2/dlm/dlmdebug.c                  |  12 +-
 fs/ocfs2/dlm/dlmunlock.c                 |  21 +-
 fs/ocfs2/dlmfs/userdlm.c                 |  17 +-
 fs/ocfs2/inode.c                         |   4 +-
 fs/ocfs2/journal.c                       |  33 ++-
 fs/ocfs2/journal.h                       |   2 +
 fs/ocfs2/quota_local.c                   |  10 +-
 fs/ocfs2/reservations.c                  |   4 +-
 fs/ocfs2/reservations.h                  |   9 +-
 fs/ocfs2/super.c                         | 180 ++++++++-----
 fs/pipe.c                                |   2 +-
 fs/proc/generic.c                        |   3 +
 fs/proc/kcore.c                          |  14 +-
 fs/proc/proc_net.c                       |   3 +
 fs/proc/vmcore.c                         | 130 +++++-----
 fs/sysv/super.c                          |   4 +-
 include/linux/crash_dump.h               |  19 +-
 include/linux/list.h                     |   6 +-
 include/linux/pipe_fs_i.h                |   2 +-
 include/linux/ptrace.h                   |   2 +-
 include/uapi/linux/acct.h                |   3 +-
 include/uapi/linux/elf.h                 |   2 +-
 include/uapi/linux/taskstats.h           |  24 +-
 init/Kconfig                             |  14 +-
 init/initramfs.c                         |  76 ++++--
 ipc/mqueue.c                             |  14 ++
 ipc/sem.c                                |  25 +-
 kernel/crash_core.c                      |   3 -
 kernel/hung_task.c                       |   2 +-
 kernel/kcov.c                            |  14 +-
 kernel/kexec_core.c                      |   2 -
 kernel/pid_namespace.c                   |   2 +-
 kernel/ptrace.c                          |   6 -
 kernel/relay.c                           |   2 +-
 kernel/taskstats.c                       |  24 ++
 kernel/tsacct.c                          |  10 +-
 kernel/watchdog.c                        |   4 +-
 lib/Kconfig.debug                        |  21 --
 lib/glob.c                               |   2 +-
 lib/string.c                             |  25 +-
 lib/string_helpers.c                     |   3 +
 lib/test_meminit.c                       |  12 +-
 lib/test_string.c                        |  33 +++
 scripts/bloat-o-meter                    |   1 +
 scripts/decode_stacktrace.sh             |  27 +-
 scripts/get_maintainer.pl                |   1 +
 tools/accounting/.gitignore              |   1 +
 tools/accounting/Makefile                |   2 +-
 tools/accounting/procacct.c              | 417 +++++++++++++++++++++++++++=
++++
 usr/gen_init_cpio.c                      |  92 +++++--
 83 files changed, 1181 insertions(+), 706 deletions(-)
 create mode 100644 tools/accounting/procacct.c

