Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308CC5312B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbiEWPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiEWPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:44:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0709C278;
        Mon, 23 May 2022 08:44:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 83D2B60A;
        Mon, 23 May 2022 15:44:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 83D2B60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1653320675; bh=Pezguya57mcluySYXOgTZYvFTKZlX9uOeM5VmJ/iztk=;
        h=From:To:Cc:Subject:Date:From;
        b=M2ArEgZ4r4e0rcTazppVqrncIalsA3VzxkSqBxesemPQvlnHs08q60GqpVa5Se9uY
         yywBg+NZJ0rehPTS1fVmM8C57SrzNEcZFXpUJyfDLZHo0B47EWD7n0HuWxAsIIppaG
         vRJf90RyrutQr4eJI1R9LPvC1StQQA7NdxY2bDwUydF4MSvHb/jcV08prMPV2lLIfH
         dJrkBodP5reNRQ8csuoZg14I5L3uVSfoSYtfTci+K+SRWWX9PVuVLHHtY1pAMxnX1E
         V036gobK80JXCbyeL3tOleSm18TiAUrSclTYQb4fp3nJqxLrpCcWBiXS0PZwa7tuxK
         VCNmPn0EbHo+A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.19
Date:   Mon, 23 May 2022 09:44:34 -0600
Message-ID: <87wnecgsnx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.19

for you to fetch changes up to b86f46d5ce3e7497930be931a9a9e57480f0baff:

  docs: pdfdocs: Add space for chapter counts >= 100 in TOC (2022-05-17 13:41:26 -0600)

----------------------------------------------------------------
It was a moderately busy cycle for documentation; highlights include:

 - After a long period of inactivity, the Japanese translations are seeing
   some much-needed maintenance and updating.

 - Reworked IOMMU documentation

 - Some new documentation for static-analysis tools

 - A new overall structure for the memory-management documentation.  This
   is an LSFMM outcome that, it is hoped, will help encourage developers to
   fill in the many gaps.  Optimism is eternal...but hopefully it will
   work.

 - More Chinese translations.

Plus the usual typo fixes, updates, etc.

Expect a conflict in Documentation/process/embargoed-hardware-issues.rst; 
Greg added a patch I had accepted as well, but did so differently; just
drop the duplicate line for Catalin.  There will also be a small
conflict with the tip tree in kernel-parameters.txt; the linux-next
resolution is good.

----------------------------------------------------------------
Akihiko Odaki (1):
      x86/efi: Remove references of EFI earlyprintk from documentation

Akira Yokosawa (9):
      docs: driver-api/thermal/intel_dptf: Use copyright symbol
      docs: submitting-patches: Fix crossref to 'The canonical patch format'
      docs/ja_JP/SubmittingPatches: Update GregKH links
      docs/ja_JP/SubmittingPatches: Suggest the use of scripts/get_maintainer.pl
      docs/ja_JP/SubmittingPatches: Randy has moved
      docs/ja_JP/SubmittingPatches: Add Suggested-by as a standard signature
      docs/ja_JP/SubmittingPatches: Request summaries for commit references
      MAINTAINERS: Add entry for DOCUMENTATION/JAPANESE
      docs: pdfdocs: Add space for chapter counts >= 100 in TOC

Alex Deucher (1):
      Documentation: x86: rework IOMMU documentation

Andreas-Christian Hagau (1):
      Documentation: kunit: change complete_and_exit to kthread_complete_and_exit

Bagas Sanjaya (3):
      Documentation: kernel-doc: Promote two chapter headings to page title
      Documentation: sphinx: replace "Introduction" chapter heading with page title
      Documentation: arch_pgtable_helpers: demote pgtable list headings

Bruno Moreira-Guedes (2):
      Docs: Add cpio requirement to changes.rst
      Docs: Replace version by 'current' in changes.rst

Catalin Marinas (1):
      Documentation/process: Update ARM contact for embargoed hardware issues

Chin En Lin (1):
      Documentation: x86: Fix obsolete name of page fault handler

Chunguang Xu (1):
      docs/scheduler: Change unit of cpu_time and rq_time to nanoseconds

Dylan Yudaken (1):
      docs: fault-injection: fix defaults

Frank Rowand (1):
      Documentation: dev-tools: use literal block instead of code-block

Huilong Deng (1):
      docs/zh_CN: fix devicetree usage-model translation

Joel Savitz (2):
      Documentation: add missing angle bracket in cgroup-v2 doc
      Documentation/sysctl: document max_rcu_stall_to_panic

Johan Hovold (1):
      Documentation: devres: fix typo in interface list

Jui-Tse Huang (1):
      docs/scheduler: fix unit error

Konstantin Ryabitsev (1):
      Documentation: kernel-hacking: minor edits for style

Kosuke Fujimoto (2):
      docs/ja_JP/index: update section title in Japanese
      docs/trans/ja_JP/howto: Don't mention specific kernel versions

Krzysztof Kozlowski (2):
      Documentation/process: mention patch changelog in review process
      Documentation/process: use scripts/get_maintainer.pl on patches

Marcelo Schmitt (2):
      Documentation: dev-tools: Add a section for static analysis tools
      Documentation: dev-tools: Enhance static analysis section with discussion

Markus Reichl (1):
      w1: w1_therm: Document Maxim MAX31850 thermoelement IF.

Matthew Wilcox (Oracle) (1):
      mm,doc: Add new documentation structure

Randy Dunlap (9):
      Docs: admin/kernel-parameters: edit a few boot options
      Docs/admin: alphabetize some kernel-parameters (part 1)
      docs/admin: alphabetize parts of kernel-parameters.txt (part 2)
      Drop Documentation/ide/
      rtla: Documentation: fix email addresses
      Documentation: move watch_queue to core-api
      Documentation: drop more IDE boot options and ide-cd.rst
      input: Docs: correct atarikbd.rst typos
      input: Docs: correct ntrig.rst typo

Tang Yizhou (4):
      docs/zh_CN: Add sched-debug Chinese translation
      docs/zh_CN: Add schedutil Chinese translation
      docs/zh_CN: Add locking/index Chinese translation
      docs/zh_CN: Add spinlocks Chinese translation

Yanteng Si (19):
      docs/zh_CN/damon: update outdated term 'regions update interval'
      docs/zh_CN/damon: add sysfs interface
      docs/zh_CN/damon: typo fix
      docs/zh_CN: add vm frontswap translation
      docs/zh_CN: add vm hwpoison translation
      docs/zh_CN: add vm memory-model translation
      docs/zh_CN: add vm mmu_notifier translation
      docs/zh_CN: add vm overcommit-accounting translation
      docs/zh_CN: add vm page_frags translation
      docs/zh_CN: add vm page_owner translation
      docs/zh_CN: add vm page_table_check translation
      docs/zh_CN: add vm remap_file_pages translation
      docs/zh_CN: add vm split_page_table_lock translation
      docs/zh_CN: add vm z3fold translation
      docs/zh_CN: add vm zsmalloc translation
      docs/zh_CN: add vm hugetlbfs_reserv translation
      docs/zh_CN: add vm hmm translation
      docs/zh_CN: add vm numa translation
      MAINTAINERS: Become the docs/zh_CN maintainer

Zhou Yuheng (1):
      docs/zh_CN: Fix typo in process/howto.rst

gaochao (1):
      docs/zh_CN: Add dev-tools/gdb-kernel-debugging.rst Chinese translation

 Documentation/admin-guide/cgroup-v2.rst            |   2 +-
 Documentation/admin-guide/kernel-parameters.rst    |  11 +-
 Documentation/admin-guide/kernel-parameters.txt    | 338 ++++++-------
 Documentation/admin-guide/sysctl/kernel.rst        |   7 +
 Documentation/cdrom/ide-cd.rst                     | 538 ---------------------
 Documentation/cdrom/index.rst                      |   1 -
 Documentation/core-api/index.rst                   |   1 +
 Documentation/{ => core-api}/watch_queue.rst       |   0
 Documentation/dev-tools/ktap.rst                   |  18 +-
 Documentation/dev-tools/kunit/architecture.rst     |   2 +-
 Documentation/dev-tools/testing-overview.rst       |  63 +++
 Documentation/doc-guide/contributing.rst           |   5 +-
 Documentation/doc-guide/kernel-doc.rst             |   2 +
 Documentation/doc-guide/sphinx.rst                 |   5 +-
 Documentation/driver-api/driver-model/devres.rst   |   2 +-
 Documentation/driver-api/thermal/intel_dptf.rst    |   2 +-
 Documentation/fault-injection/fault-injection.rst  |  14 +-
 Documentation/ide/ChangeLog.ide-cd.1994-2004       | 268 ----------
 Documentation/ide/ChangeLog.ide-floppy.1996-2002   |  63 ---
 Documentation/ide/ChangeLog.ide-tape.1995-2002     | 257 ----------
 Documentation/ide/changelogs.rst                   |  17 -
 Documentation/ide/ide-tape.rst                     |  68 ---
 Documentation/ide/ide.rst                          | 265 ----------
 Documentation/ide/index.rst                        |  21 -
 Documentation/ide/warm-plug-howto.rst              |  18 -
 Documentation/index.rst                            |   2 -
 Documentation/input/devices/atarikbd.rst           |   4 +-
 Documentation/input/devices/ntrig.rst              |   2 +-
 Documentation/kernel-hacking/hacking.rst           |  36 +-
 Documentation/kernel-hacking/locking.rst           |   5 +-
 Documentation/process/3.Early-stage.rst            |   9 +-
 Documentation/process/changes.rst                  |   8 +-
 .../process/embargoed-hardware-issues.rst          |   2 +-
 Documentation/process/submitting-patches.rst       |  14 +-
 Documentation/scheduler/sched-stats.rst            |   8 +-
 Documentation/sphinx/kerneldoc-preamble.sty        |  14 +-
 Documentation/tools/rtla/common_appendix.rst       |   3 +-
 Documentation/translations/ja_JP/SubmittingPatches |  36 +-
 Documentation/translations/ja_JP/howto.rst         |  44 +-
 Documentation/translations/ja_JP/index.rst         |   2 +-
 .../zh_CN/admin-guide/mm/damon/reclaim.rst         |   4 +-
 .../zh_CN/admin-guide/mm/damon/usage.rst           | 291 ++++++++++-
 .../zh_CN/dev-tools/gdb-kernel-debugging.rst       | 167 +++++++
 .../translations/zh_CN/dev-tools/index.rst         |   2 +-
 .../translations/zh_CN/devicetree/usage-model.rst  |   8 +-
 Documentation/translations/zh_CN/index.rst         |   2 +-
 Documentation/translations/zh_CN/locking/index.rst |  42 ++
 .../translations/zh_CN/locking/spinlocks.rst       | 149 ++++++
 Documentation/translations/zh_CN/process/howto.rst |   2 +-
 .../translations/zh_CN/scheduler/index.rst         |   2 +
 .../translations/zh_CN/scheduler/sched-debug.rst   |  51 ++
 .../translations/zh_CN/scheduler/schedutil.rst     | 165 +++++++
 .../translations/zh_CN/vm/damon/design.rst         |   7 +-
 Documentation/translations/zh_CN/vm/frontswap.rst  | 196 ++++++++
 Documentation/translations/zh_CN/vm/hmm.rst        | 361 ++++++++++++++
 .../translations/zh_CN/vm/hugetlbfs_reserv.rst     | 436 +++++++++++++++++
 Documentation/translations/zh_CN/vm/hwpoison.rst   | 166 +++++++
 Documentation/translations/zh_CN/vm/index.rst      |  29 +-
 .../translations/zh_CN/vm/memory-model.rst         | 135 ++++++
 .../translations/zh_CN/vm/mmu_notifier.rst         |  97 ++++
 Documentation/translations/zh_CN/vm/numa.rst       | 101 ++++
 .../zh_CN/vm/overcommit-accounting.rst             |  86 ++++
 Documentation/translations/zh_CN/vm/page_frags.rst |  38 ++
 Documentation/translations/zh_CN/vm/page_owner.rst | 116 +++++
 .../translations/zh_CN/vm/page_table_check.rst     |  56 +++
 .../translations/zh_CN/vm/remap_file_pages.rst     |  32 ++
 .../zh_CN/vm/split_page_table_lock.rst             |  96 ++++
 Documentation/translations/zh_CN/vm/z3fold.rst     |  31 ++
 Documentation/translations/zh_CN/vm/zsmalloc.rst   |  78 +++
 Documentation/vm/arch_pgtable_helpers.rst          |  10 +-
 Documentation/vm/bootmem.rst                       |   5 +
 Documentation/vm/index.rst                         |  40 +-
 Documentation/vm/oom.rst                           |   5 +
 Documentation/vm/page_allocation.rst               |   5 +
 Documentation/vm/page_cache.rst                    |   5 +
 Documentation/vm/page_reclaim.rst                  |   5 +
 Documentation/vm/page_tables.rst                   |   5 +
 Documentation/vm/physical_memory.rst               |   5 +
 Documentation/vm/process_addrs.rst                 |   5 +
 Documentation/vm/shmfs.rst                         |   5 +
 Documentation/vm/slab.rst                          |   5 +
 Documentation/vm/swap.rst                          |   5 +
 Documentation/vm/vmalloc.rst                       |   5 +
 Documentation/w1/slaves/w1_therm.rst               |   9 +-
 Documentation/x86/exception-tables.rst             |  23 +-
 Documentation/x86/index.rst                        |   2 +-
 Documentation/x86/intel-iommu.rst                  | 115 -----
 Documentation/x86/iommu.rst                        | 151 ++++++
 MAINTAINERS                                        |   7 +
 89 files changed, 3567 insertions(+), 1973 deletions(-)
 delete mode 100644 Documentation/cdrom/ide-cd.rst
 rename Documentation/{ => core-api}/watch_queue.rst (100%)
 delete mode 100644 Documentation/ide/ChangeLog.ide-cd.1994-2004
 delete mode 100644 Documentation/ide/ChangeLog.ide-floppy.1996-2002
 delete mode 100644 Documentation/ide/ChangeLog.ide-tape.1995-2002
 delete mode 100644 Documentation/ide/changelogs.rst
 delete mode 100644 Documentation/ide/ide-tape.rst
 delete mode 100644 Documentation/ide/ide.rst
 delete mode 100644 Documentation/ide/index.rst
 delete mode 100644 Documentation/ide/warm-plug-howto.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
 create mode 100644 Documentation/translations/zh_CN/locking/index.rst
 create mode 100644 Documentation/translations/zh_CN/locking/spinlocks.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-debug.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/schedutil.rst
 create mode 100644 Documentation/translations/zh_CN/vm/frontswap.rst
 create mode 100644 Documentation/translations/zh_CN/vm/hmm.rst
 create mode 100644 Documentation/translations/zh_CN/vm/hugetlbfs_reserv.rst
 create mode 100644 Documentation/translations/zh_CN/vm/hwpoison.rst
 create mode 100644 Documentation/translations/zh_CN/vm/memory-model.rst
 create mode 100644 Documentation/translations/zh_CN/vm/mmu_notifier.rst
 create mode 100644 Documentation/translations/zh_CN/vm/numa.rst
 create mode 100644 Documentation/translations/zh_CN/vm/overcommit-accounting.rst
 create mode 100644 Documentation/translations/zh_CN/vm/page_frags.rst
 create mode 100644 Documentation/translations/zh_CN/vm/page_owner.rst
 create mode 100644 Documentation/translations/zh_CN/vm/page_table_check.rst
 create mode 100644 Documentation/translations/zh_CN/vm/remap_file_pages.rst
 create mode 100644 Documentation/translations/zh_CN/vm/split_page_table_lock.rst
 create mode 100644 Documentation/translations/zh_CN/vm/z3fold.rst
 create mode 100644 Documentation/translations/zh_CN/vm/zsmalloc.rst
 create mode 100644 Documentation/vm/bootmem.rst
 create mode 100644 Documentation/vm/oom.rst
 create mode 100644 Documentation/vm/page_allocation.rst
 create mode 100644 Documentation/vm/page_cache.rst
 create mode 100644 Documentation/vm/page_reclaim.rst
 create mode 100644 Documentation/vm/page_tables.rst
 create mode 100644 Documentation/vm/physical_memory.rst
 create mode 100644 Documentation/vm/process_addrs.rst
 create mode 100644 Documentation/vm/shmfs.rst
 create mode 100644 Documentation/vm/slab.rst
 create mode 100644 Documentation/vm/swap.rst
 create mode 100644 Documentation/vm/vmalloc.rst
 delete mode 100644 Documentation/x86/intel-iommu.rst
 create mode 100644 Documentation/x86/iommu.rst
