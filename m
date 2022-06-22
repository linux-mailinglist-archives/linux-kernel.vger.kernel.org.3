Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3B554AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356064AbiFVNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbiFVNXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:23:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947E2FE7E;
        Wed, 22 Jun 2022 06:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0865CB81ED4;
        Wed, 22 Jun 2022 13:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D578DC34114;
        Wed, 22 Jun 2022 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655904181;
        bh=YAWhv6tsVOhUua7hoi1D7YSz6aeM6t1h3vVEfT3bcaY=;
        h=From:To:Cc:Subject:Date:From;
        b=OUlLVgas/kh/MwdRzPV1RmVQOm5PEjRRf5C78ogI6kvbWCmDAUqKQa+Mc93n6VH5X
         yL9/se4Uqa1gp3KndpxXPsshzPmRoS6ngcDlNtXcXodPHdqakO2j2Q4m+zIYnVEnwf
         lNpUo9iF8CRS/Q+rr2cy2/NJU2SKL1JiG8woK8Utn+bYZLLis4MSxAvJ3dj1d/xWS0
         cevnQImTzmzOe+a1DOdSr7xDpkcrIEx00BZrgmHzMPiG43Hq6LSHX75862hIvWQ3gV
         F0Q7R4L0+CYM1A4v08Qw/P43yaoH/AToSdiz44wv/qmpLfNsZnrokkvOa+jJQK3sig
         nLbsViYexwYUg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] docs: rename Documentation/vm to Documentation/mm
Date:   Wed, 22 Jun 2022 08:22:58 -0500
Message-Id: <20220622132258.457734-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

so it will be consistent with code mm directory and with
Documentation/admin-guide/mm and won't be confused with virtual
machines.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-kernel-mm-ksm        |  2 +-
 Documentation/ABI/testing/sysfs-kernel-slab          |  4 ++--
 Documentation/admin-guide/kernel-parameters.txt      | 10 +++++-----
 Documentation/admin-guide/mm/concepts.rst            |  2 +-
 Documentation/admin-guide/mm/damon/index.rst         |  2 +-
 Documentation/admin-guide/mm/damon/reclaim.rst       |  2 +-
 Documentation/admin-guide/mm/damon/usage.rst         |  8 ++++----
 Documentation/admin-guide/sysctl/vm.rst              |  2 +-
 Documentation/core-api/index.rst                     |  2 +-
 Documentation/filesystems/proc.rst                   |  2 +-
 Documentation/index.rst                              |  2 +-
 Documentation/{vm => mm}/active_mm.rst               |  0
 Documentation/{vm => mm}/arch_pgtable_helpers.rst    |  0
 Documentation/{vm => mm}/balance.rst                 |  0
 Documentation/{vm => mm}/bootmem.rst                 |  0
 Documentation/{vm => mm}/damon/api.rst               |  0
 Documentation/{vm => mm}/damon/design.rst            |  0
 Documentation/{vm => mm}/damon/faq.rst               |  0
 Documentation/{vm => mm}/damon/index.rst             |  0
 Documentation/{vm => mm}/free_page_reporting.rst     |  0
 Documentation/{vm => mm}/frontswap.rst               |  0
 Documentation/{vm => mm}/highmem.rst                 |  0
 Documentation/{vm => mm}/hmm.rst                     |  0
 Documentation/{vm => mm}/hugetlbfs_reserv.rst        |  0
 Documentation/{vm => mm}/hwpoison.rst                |  0
 Documentation/{vm => mm}/index.rst                   |  0
 Documentation/{vm => mm}/ksm.rst                     |  0
 Documentation/{vm => mm}/memory-model.rst            |  2 +-
 Documentation/{vm => mm}/mmu_notifier.rst            |  0
 Documentation/{vm => mm}/numa.rst                    |  0
 Documentation/{vm => mm}/oom.rst                     |  0
 Documentation/{vm => mm}/overcommit-accounting.rst   |  0
 Documentation/{vm => mm}/page_allocation.rst         |  0
 Documentation/{vm => mm}/page_cache.rst              |  0
 Documentation/{vm => mm}/page_frags.rst              |  0
 Documentation/{vm => mm}/page_migration.rst          |  0
 Documentation/{vm => mm}/page_owner.rst              |  0
 Documentation/{vm => mm}/page_reclaim.rst            |  0
 Documentation/{vm => mm}/page_table_check.rst        |  0
 Documentation/{vm => mm}/page_tables.rst             |  0
 Documentation/{vm => mm}/physical_memory.rst         |  0
 Documentation/{vm => mm}/process_addrs.rst           |  0
 Documentation/{vm => mm}/remap_file_pages.rst        |  0
 Documentation/{vm => mm}/shmfs.rst                   |  0
 Documentation/{vm => mm}/slab.rst                    |  0
 Documentation/{vm => mm}/slub.rst                    |  0
 Documentation/{vm => mm}/split_page_table_lock.rst   |  0
 Documentation/{vm => mm}/swap.rst                    |  0
 Documentation/{vm => mm}/transhuge.rst               |  0
 Documentation/{vm => mm}/unevictable-lru.rst         |  0
 Documentation/{vm => mm}/vmalloc.rst                 |  0
 Documentation/{vm => mm}/vmalloced-kernel-stacks.rst |  0
 Documentation/{vm => mm}/vmemmap_dedup.rst           |  0
 Documentation/{vm => mm}/z3fold.rst                  |  0
 Documentation/{vm => mm}/zsmalloc.rst                |  0
 .../zh_CN/admin-guide/mm/damon/index.rst             |  2 +-
 .../zh_CN/admin-guide/mm/damon/reclaim.rst           |  2 +-
 .../zh_CN/admin-guide/mm/damon/usage.rst             |  8 ++++----
 Documentation/translations/zh_CN/core-api/index.rst  |  2 +-
 Documentation/translations/zh_CN/index.rst           |  2 +-
 .../translations/zh_CN/{vm => mm}/active_mm.rst      |  2 +-
 .../translations/zh_CN/{vm => mm}/balance.rst        |  2 +-
 .../translations/zh_CN/{vm => mm}/damon/api.rst      |  2 +-
 .../translations/zh_CN/{vm => mm}/damon/design.rst   |  2 +-
 .../translations/zh_CN/{vm => mm}/damon/faq.rst      |  2 +-
 .../translations/zh_CN/{vm => mm}/damon/index.rst    |  5 ++---
 .../zh_CN/{vm => mm}/free_page_reporting.rst         |  2 +-
 .../translations/zh_CN/{vm => mm}/frontswap.rst      |  2 +-
 .../translations/zh_CN/{vm => mm}/highmem.rst        |  2 +-
 Documentation/translations/zh_CN/{vm => mm}/hmm.rst  |  2 +-
 .../zh_CN/{vm => mm}/hugetlbfs_reserv.rst            |  2 +-
 .../translations/zh_CN/{vm => mm}/hwpoison.rst       |  2 +-
 .../translations/zh_CN/{vm => mm}/index.rst          |  2 +-
 Documentation/translations/zh_CN/{vm => mm}/ksm.rst  |  2 +-
 .../translations/zh_CN/{vm => mm}/memory-model.rst   |  2 +-
 .../translations/zh_CN/{vm => mm}/mmu_notifier.rst   |  2 +-
 Documentation/translations/zh_CN/{vm => mm}/numa.rst |  2 +-
 .../zh_CN/{vm => mm}/overcommit-accounting.rst       |  2 +-
 .../translations/zh_CN/{vm => mm}/page_frags.rst     |  2 +-
 .../translations/zh_CN/{vm => mm}/page_owner.rst     |  2 +-
 .../zh_CN/{vm => mm}/page_table_check.rst            |  2 +-
 .../zh_CN/{vm => mm}/remap_file_pages.rst            |  2 +-
 .../zh_CN/{vm => mm}/split_page_table_lock.rst       |  2 +-
 .../translations/zh_CN/{vm => mm}/z3fold.rst         |  2 +-
 .../translations/zh_CN/{vm => mm}/zsmalloc.rst       |  2 +-
 Documentation/translations/zh_TW/index.rst           |  2 +-
 Documentation/vm/.gitignore                          |  3 ---
 MAINTAINERS                                          | 12 ++++++------
 arch/loongarch/Kconfig                               |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h         |  2 +-
 include/linux/hmm.h                                  |  4 ++--
 include/linux/memremap.h                             |  2 +-
 include/linux/mmu_notifier.h                         |  2 +-
 include/linux/sched/mm.h                             |  4 ++--
 include/linux/swap.h                                 |  2 +-
 mm/Kconfig                                           |  2 +-
 mm/debug_vm_pgtable.c                                |  2 +-
 mm/frontswap.c                                       |  2 +-
 mm/huge_memory.c                                     |  2 +-
 mm/hugetlb.c                                         |  6 +++---
 mm/hugetlb_vmemmap.c                                 |  2 +-
 mm/ksm.c                                             |  4 ++--
 mm/mmap.c                                            |  2 +-
 mm/rmap.c                                            |  8 ++++----
 mm/sparse-vmemmap.c                                  |  2 +-
 mm/util.c                                            |  2 +-
 tools/vm/page_owner_sort.c                           |  2 +-
 107 files changed, 88 insertions(+), 92 deletions(-)
 rename Documentation/{vm => mm}/active_mm.rst (100%)
 rename Documentation/{vm => mm}/arch_pgtable_helpers.rst (100%)
 rename Documentation/{vm => mm}/balance.rst (100%)
 rename Documentation/{vm => mm}/bootmem.rst (100%)
 rename Documentation/{vm => mm}/damon/api.rst (100%)
 rename Documentation/{vm => mm}/damon/design.rst (100%)
 rename Documentation/{vm => mm}/damon/faq.rst (100%)
 rename Documentation/{vm => mm}/damon/index.rst (100%)
 rename Documentation/{vm => mm}/free_page_reporting.rst (100%)
 rename Documentation/{vm => mm}/frontswap.rst (100%)
 rename Documentation/{vm => mm}/highmem.rst (100%)
 rename Documentation/{vm => mm}/hmm.rst (100%)
 rename Documentation/{vm => mm}/hugetlbfs_reserv.rst (100%)
 rename Documentation/{vm => mm}/hwpoison.rst (100%)
 rename Documentation/{vm => mm}/index.rst (100%)
 rename Documentation/{vm => mm}/ksm.rst (100%)
 rename Documentation/{vm => mm}/memory-model.rst (99%)
 rename Documentation/{vm => mm}/mmu_notifier.rst (100%)
 rename Documentation/{vm => mm}/numa.rst (100%)
 rename Documentation/{vm => mm}/oom.rst (100%)
 rename Documentation/{vm => mm}/overcommit-accounting.rst (100%)
 rename Documentation/{vm => mm}/page_allocation.rst (100%)
 rename Documentation/{vm => mm}/page_cache.rst (100%)
 rename Documentation/{vm => mm}/page_frags.rst (100%)
 rename Documentation/{vm => mm}/page_migration.rst (100%)
 rename Documentation/{vm => mm}/page_owner.rst (100%)
 rename Documentation/{vm => mm}/page_reclaim.rst (100%)
 rename Documentation/{vm => mm}/page_table_check.rst (100%)
 rename Documentation/{vm => mm}/page_tables.rst (100%)
 rename Documentation/{vm => mm}/physical_memory.rst (100%)
 rename Documentation/{vm => mm}/process_addrs.rst (100%)
 rename Documentation/{vm => mm}/remap_file_pages.rst (100%)
 rename Documentation/{vm => mm}/shmfs.rst (100%)
 rename Documentation/{vm => mm}/slab.rst (100%)
 rename Documentation/{vm => mm}/slub.rst (100%)
 rename Documentation/{vm => mm}/split_page_table_lock.rst (100%)
 rename Documentation/{vm => mm}/swap.rst (100%)
 rename Documentation/{vm => mm}/transhuge.rst (100%)
 rename Documentation/{vm => mm}/unevictable-lru.rst (100%)
 rename Documentation/{vm => mm}/vmalloc.rst (100%)
 rename Documentation/{vm => mm}/vmalloced-kernel-stacks.rst (100%)
 rename Documentation/{vm => mm}/vmemmap_dedup.rst (100%)
 rename Documentation/{vm => mm}/z3fold.rst (100%)
 rename Documentation/{vm => mm}/zsmalloc.rst (100%)
 rename Documentation/translations/zh_CN/{vm => mm}/active_mm.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/balance.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/damon/api.rst (91%)
 rename Documentation/translations/zh_CN/{vm => mm}/damon/design.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/damon/faq.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/damon/index.rst (90%)
 rename Documentation/translations/zh_CN/{vm => mm}/free_page_reporting.rst (97%)
 rename Documentation/translations/zh_CN/{vm => mm}/frontswap.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/highmem.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/hmm.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/hugetlbfs_reserv.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/hwpoison.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/index.rst (96%)
 rename Documentation/translations/zh_CN/{vm => mm}/ksm.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/memory-model.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/mmu_notifier.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/numa.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/overcommit-accounting.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/page_frags.rst (97%)
 rename Documentation/translations/zh_CN/{vm => mm}/page_owner.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/page_table_check.rst (97%)
 rename Documentation/translations/zh_CN/{vm => mm}/remap_file_pages.rst (97%)
 rename Documentation/translations/zh_CN/{vm => mm}/split_page_table_lock.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/z3fold.rst (96%)
 rename Documentation/translations/zh_CN/{vm => mm}/zsmalloc.rst (98%)
 delete mode 100644 Documentation/vm/.gitignore

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
index 1c9bed5595f5..d244674a9480 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
@@ -41,7 +41,7 @@ Description:	Kernel Samepage Merging daemon sysfs interface
 		sleep_millisecs: how many milliseconds ksm should sleep between
 		scans.
 
-		See Documentation/vm/ksm.rst for more information.
+		See Documentation/mm/ksm.rst for more information.
 
 What:		/sys/kernel/mm/ksm/merge_across_nodes
 Date:		January 2013
diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index c440f4946e12..cd5fb8fa3ddf 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -37,7 +37,7 @@ Description:
 		The alloc_calls file is read-only and lists the kernel code
 		locations from which allocations for this cache were performed.
 		The alloc_calls file only contains information if debugging is
-		enabled for that cache (see Documentation/vm/slub.rst).
+		enabled for that cache (see Documentation/mm/slub.rst).
 
 What:		/sys/kernel/slab/<cache>/alloc_fastpath
 Date:		February 2008
@@ -219,7 +219,7 @@ Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
 Description:
 		The free_calls file is read-only and lists the locations of
 		object frees if slab debugging is enabled (see
-		Documentation/vm/slub.rst).
+		Documentation/mm/slub.rst).
 
 What:		/sys/kernel/slab/<cache>/free_fastpath
 Date:		February 2008
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f..8c0ea6b6c6a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5442,7 +5442,7 @@
 			cache (risks via metadata attacks are mostly
 			unchanged). Debug options disable merging on their
 			own.
-			For more information see Documentation/vm/slub.rst.
+			For more information see Documentation/mm/slub.rst.
 
 	slab_max_order=	[MM, SLAB]
 			Determines the maximum allowed order for slabs.
@@ -5456,13 +5456,13 @@
 			slub_debug can create guard zones around objects and
 			may poison objects when not in use. Also tracks the
 			last alloc / free. For more information see
-			Documentation/vm/slub.rst.
+			Documentation/mm/slub.rst.
 
 	slub_max_order= [MM, SLUB]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory
 			fragmentation. For more information see
-			Documentation/vm/slub.rst.
+			Documentation/mm/slub.rst.
 
 	slub_min_objects=	[MM, SLUB]
 			The minimum number of objects per slab. SLUB will
@@ -5471,12 +5471,12 @@
 			the number of objects indicated. The higher the number
 			of objects the smaller the overhead of tracking slabs
 			and the less frequently locks need to be acquired.
-			For more information see Documentation/vm/slub.rst.
+			For more information see Documentation/mm/slub.rst.
 
 	slub_min_order=	[MM, SLUB]
 			Determines the minimum page order for slabs. Must be
 			lower than slub_max_order.
-			For more information see Documentation/vm/slub.rst.
+			For more information see Documentation/mm/slub.rst.
 
 	slub_merge	[MM, SLUB]
 			Same with slab_merge.
diff --git a/Documentation/admin-guide/mm/concepts.rst b/Documentation/admin-guide/mm/concepts.rst
index b966fcff993b..c79f1e336222 100644
--- a/Documentation/admin-guide/mm/concepts.rst
+++ b/Documentation/admin-guide/mm/concepts.rst
@@ -125,7 +125,7 @@ processor. Each bank is referred to as a `node` and for each node Linux
 constructs an independent memory management subsystem. A node has its
 own set of zones, lists of free and used pages and various statistics
 counters. You can find more details about NUMA in
-:ref:`Documentation/vm/numa.rst <numa>` and in
+:ref:`Documentation/mm/numa.rst <numa>` and in
 :ref:`Documentation/admin-guide/mm/numa_memory_policy.rst <numa_memory_policy>`.
 
 Page cache
diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 61aff88347f3..c4681fa69b9c 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -4,7 +4,7 @@
 Monitoring Data Accesses
 ========================
 
-:doc:`DAMON </vm/damon/index>` allows light-weight data access monitoring.
+:doc:`DAMON </mm/damon/index>` allows light-weight data access monitoring.
 Using DAMON, users can analyze the memory access patterns of their systems and
 optimize those.
 
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 46306f1f34b1..a8bd3bd29959 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -268,4 +268,4 @@ granularity reclamation. ::
 
 .. [1] https://research.google/pubs/pub48551/
 .. [2] https://lwn.net/Articles/787611/
-.. [3] https://www.kernel.org/doc/html/latest/vm/free_page_reporting.html
+.. [3] https://www.kernel.org/doc/html/latest/mm/free_page_reporting.html
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 1bb7b72414b2..5540a3a40fc9 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -30,11 +30,11 @@ DAMON provides below interfaces for different users.
   <sysfs_interface>`.  This will be removed after next LTS kernel is released,
   so users should move to the :ref:`sysfs interface <sysfs_interface>`.
 - *Kernel Space Programming Interface.*
-  :doc:`This </vm/damon/api>` is for kernel space programmers.  Using this,
+  :doc:`This </mm/damon/api>` is for kernel space programmers.  Using this,
   users can utilize every feature of DAMON most flexibly and efficiently by
   writing kernel space DAMON application programs for you.  You can even extend
   DAMON for various address spaces.  For detail, please refer to the interface
-  :doc:`document </vm/damon/api>`.
+  :doc:`document </mm/damon/api>`.
 
 .. _sysfs_interface:
 
@@ -185,7 +185,7 @@ controls the monitoring overhead, exist.  You can set and get the values by
 writing to and rading from the files.
 
 For more details about the intervals and monitoring regions range, please refer
-to the Design document (:doc:`/vm/damon/design`).
+to the Design document (:doc:`/mm/damon/design`).
 
 contexts/<N>/targets/
 ---------------------
@@ -402,7 +402,7 @@ Attributes
 Users can get and set the ``sampling interval``, ``aggregation interval``,
 ``update interval``, and min/max number of monitoring target regions by
 reading from and writing to the ``attrs`` file.  To know about the monitoring
-attributes in detail, please refer to the :doc:`/vm/damon/design`.  For
+attributes in detail, please refer to the :doc:`/mm/damon/design`.  For
 example, below commands set those values to 5 ms, 100 ms, 1,000 ms, 10 and
 1000, and then check it again::
 
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 5c9aa171a0d3..4a440a7cfeb0 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -760,7 +760,7 @@ and don't use much of it.
 
 The default value is 0.
 
-See Documentation/vm/overcommit-accounting.rst and
+See Documentation/mm/overcommit-accounting.rst and
 mm/util.c::__vm_enough_memory() for more information.
 
 
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index dedd4d853329..5b1188494bcd 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -87,7 +87,7 @@ Memory management
 =================
 
 How to allocate and use memory in the kernel.  Note that there is a lot
-more memory-management documentation in Documentation/vm/index.rst.
+more memory-management documentation in Documentation/mm/index.rst.
 
 .. toctree::
    :maxdepth: 1
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321..8543a59f288f 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1109,7 +1109,7 @@ CommitLimit
               yield a CommitLimit of 7.3G.
 
               For more details, see the memory overcommit documentation
-              in vm/overcommit-accounting.
+              in mm/overcommit-accounting.
 Committed_AS
               The amount of memory presently allocated on the system.
               The committed memory is a sum of all of the memory which
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 67036a05b771..4737c18c97ff 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -128,7 +128,7 @@ needed).
    sound/index
    crypto/index
    filesystems/index
-   vm/index
+   mm/index
    bpf/index
    usb/index
    PCI/index
diff --git a/Documentation/vm/active_mm.rst b/Documentation/mm/active_mm.rst
similarity index 100%
rename from Documentation/vm/active_mm.rst
rename to Documentation/mm/active_mm.rst
diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
similarity index 100%
rename from Documentation/vm/arch_pgtable_helpers.rst
rename to Documentation/mm/arch_pgtable_helpers.rst
diff --git a/Documentation/vm/balance.rst b/Documentation/mm/balance.rst
similarity index 100%
rename from Documentation/vm/balance.rst
rename to Documentation/mm/balance.rst
diff --git a/Documentation/vm/bootmem.rst b/Documentation/mm/bootmem.rst
similarity index 100%
rename from Documentation/vm/bootmem.rst
rename to Documentation/mm/bootmem.rst
diff --git a/Documentation/vm/damon/api.rst b/Documentation/mm/damon/api.rst
similarity index 100%
rename from Documentation/vm/damon/api.rst
rename to Documentation/mm/damon/api.rst
diff --git a/Documentation/vm/damon/design.rst b/Documentation/mm/damon/design.rst
similarity index 100%
rename from Documentation/vm/damon/design.rst
rename to Documentation/mm/damon/design.rst
diff --git a/Documentation/vm/damon/faq.rst b/Documentation/mm/damon/faq.rst
similarity index 100%
rename from Documentation/vm/damon/faq.rst
rename to Documentation/mm/damon/faq.rst
diff --git a/Documentation/vm/damon/index.rst b/Documentation/mm/damon/index.rst
similarity index 100%
rename from Documentation/vm/damon/index.rst
rename to Documentation/mm/damon/index.rst
diff --git a/Documentation/vm/free_page_reporting.rst b/Documentation/mm/free_page_reporting.rst
similarity index 100%
rename from Documentation/vm/free_page_reporting.rst
rename to Documentation/mm/free_page_reporting.rst
diff --git a/Documentation/vm/frontswap.rst b/Documentation/mm/frontswap.rst
similarity index 100%
rename from Documentation/vm/frontswap.rst
rename to Documentation/mm/frontswap.rst
diff --git a/Documentation/vm/highmem.rst b/Documentation/mm/highmem.rst
similarity index 100%
rename from Documentation/vm/highmem.rst
rename to Documentation/mm/highmem.rst
diff --git a/Documentation/vm/hmm.rst b/Documentation/mm/hmm.rst
similarity index 100%
rename from Documentation/vm/hmm.rst
rename to Documentation/mm/hmm.rst
diff --git a/Documentation/vm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
similarity index 100%
rename from Documentation/vm/hugetlbfs_reserv.rst
rename to Documentation/mm/hugetlbfs_reserv.rst
diff --git a/Documentation/vm/hwpoison.rst b/Documentation/mm/hwpoison.rst
similarity index 100%
rename from Documentation/vm/hwpoison.rst
rename to Documentation/mm/hwpoison.rst
diff --git a/Documentation/vm/index.rst b/Documentation/mm/index.rst
similarity index 100%
rename from Documentation/vm/index.rst
rename to Documentation/mm/index.rst
diff --git a/Documentation/vm/ksm.rst b/Documentation/mm/ksm.rst
similarity index 100%
rename from Documentation/vm/ksm.rst
rename to Documentation/mm/ksm.rst
diff --git a/Documentation/vm/memory-model.rst b/Documentation/mm/memory-model.rst
similarity index 99%
rename from Documentation/vm/memory-model.rst
rename to Documentation/mm/memory-model.rst
index 30e8fbed6914..3779e562dc76 100644
--- a/Documentation/vm/memory-model.rst
+++ b/Documentation/mm/memory-model.rst
@@ -170,7 +170,7 @@ The users of `ZONE_DEVICE` are:
 * hmm: Extend `ZONE_DEVICE` with `->page_fault()` and `->page_free()`
   event callbacks to allow a device-driver to coordinate memory management
   events related to device-memory, typically GPU memory. See
-  Documentation/vm/hmm.rst.
+  Documentation/mm/hmm.rst.
 
 * p2pdma: Create `struct page` objects to allow peer devices in a
   PCI/-E topology to coordinate direct-DMA operations between themselves,
diff --git a/Documentation/vm/mmu_notifier.rst b/Documentation/mm/mmu_notifier.rst
similarity index 100%
rename from Documentation/vm/mmu_notifier.rst
rename to Documentation/mm/mmu_notifier.rst
diff --git a/Documentation/vm/numa.rst b/Documentation/mm/numa.rst
similarity index 100%
rename from Documentation/vm/numa.rst
rename to Documentation/mm/numa.rst
diff --git a/Documentation/vm/oom.rst b/Documentation/mm/oom.rst
similarity index 100%
rename from Documentation/vm/oom.rst
rename to Documentation/mm/oom.rst
diff --git a/Documentation/vm/overcommit-accounting.rst b/Documentation/mm/overcommit-accounting.rst
similarity index 100%
rename from Documentation/vm/overcommit-accounting.rst
rename to Documentation/mm/overcommit-accounting.rst
diff --git a/Documentation/vm/page_allocation.rst b/Documentation/mm/page_allocation.rst
similarity index 100%
rename from Documentation/vm/page_allocation.rst
rename to Documentation/mm/page_allocation.rst
diff --git a/Documentation/vm/page_cache.rst b/Documentation/mm/page_cache.rst
similarity index 100%
rename from Documentation/vm/page_cache.rst
rename to Documentation/mm/page_cache.rst
diff --git a/Documentation/vm/page_frags.rst b/Documentation/mm/page_frags.rst
similarity index 100%
rename from Documentation/vm/page_frags.rst
rename to Documentation/mm/page_frags.rst
diff --git a/Documentation/vm/page_migration.rst b/Documentation/mm/page_migration.rst
similarity index 100%
rename from Documentation/vm/page_migration.rst
rename to Documentation/mm/page_migration.rst
diff --git a/Documentation/vm/page_owner.rst b/Documentation/mm/page_owner.rst
similarity index 100%
rename from Documentation/vm/page_owner.rst
rename to Documentation/mm/page_owner.rst
diff --git a/Documentation/vm/page_reclaim.rst b/Documentation/mm/page_reclaim.rst
similarity index 100%
rename from Documentation/vm/page_reclaim.rst
rename to Documentation/mm/page_reclaim.rst
diff --git a/Documentation/vm/page_table_check.rst b/Documentation/mm/page_table_check.rst
similarity index 100%
rename from Documentation/vm/page_table_check.rst
rename to Documentation/mm/page_table_check.rst
diff --git a/Documentation/vm/page_tables.rst b/Documentation/mm/page_tables.rst
similarity index 100%
rename from Documentation/vm/page_tables.rst
rename to Documentation/mm/page_tables.rst
diff --git a/Documentation/vm/physical_memory.rst b/Documentation/mm/physical_memory.rst
similarity index 100%
rename from Documentation/vm/physical_memory.rst
rename to Documentation/mm/physical_memory.rst
diff --git a/Documentation/vm/process_addrs.rst b/Documentation/mm/process_addrs.rst
similarity index 100%
rename from Documentation/vm/process_addrs.rst
rename to Documentation/mm/process_addrs.rst
diff --git a/Documentation/vm/remap_file_pages.rst b/Documentation/mm/remap_file_pages.rst
similarity index 100%
rename from Documentation/vm/remap_file_pages.rst
rename to Documentation/mm/remap_file_pages.rst
diff --git a/Documentation/vm/shmfs.rst b/Documentation/mm/shmfs.rst
similarity index 100%
rename from Documentation/vm/shmfs.rst
rename to Documentation/mm/shmfs.rst
diff --git a/Documentation/vm/slab.rst b/Documentation/mm/slab.rst
similarity index 100%
rename from Documentation/vm/slab.rst
rename to Documentation/mm/slab.rst
diff --git a/Documentation/vm/slub.rst b/Documentation/mm/slub.rst
similarity index 100%
rename from Documentation/vm/slub.rst
rename to Documentation/mm/slub.rst
diff --git a/Documentation/vm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
similarity index 100%
rename from Documentation/vm/split_page_table_lock.rst
rename to Documentation/mm/split_page_table_lock.rst
diff --git a/Documentation/vm/swap.rst b/Documentation/mm/swap.rst
similarity index 100%
rename from Documentation/vm/swap.rst
rename to Documentation/mm/swap.rst
diff --git a/Documentation/vm/transhuge.rst b/Documentation/mm/transhuge.rst
similarity index 100%
rename from Documentation/vm/transhuge.rst
rename to Documentation/mm/transhuge.rst
diff --git a/Documentation/vm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
similarity index 100%
rename from Documentation/vm/unevictable-lru.rst
rename to Documentation/mm/unevictable-lru.rst
diff --git a/Documentation/vm/vmalloc.rst b/Documentation/mm/vmalloc.rst
similarity index 100%
rename from Documentation/vm/vmalloc.rst
rename to Documentation/mm/vmalloc.rst
diff --git a/Documentation/vm/vmalloced-kernel-stacks.rst b/Documentation/mm/vmalloced-kernel-stacks.rst
similarity index 100%
rename from Documentation/vm/vmalloced-kernel-stacks.rst
rename to Documentation/mm/vmalloced-kernel-stacks.rst
diff --git a/Documentation/vm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
similarity index 100%
rename from Documentation/vm/vmemmap_dedup.rst
rename to Documentation/mm/vmemmap_dedup.rst
diff --git a/Documentation/vm/z3fold.rst b/Documentation/mm/z3fold.rst
similarity index 100%
rename from Documentation/vm/z3fold.rst
rename to Documentation/mm/z3fold.rst
diff --git a/Documentation/vm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
similarity index 100%
rename from Documentation/vm/zsmalloc.rst
rename to Documentation/mm/zsmalloc.rst
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
index 0c8276109fc0..30c69e1f44fe 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
@@ -13,7 +13,7 @@
 监测数据访问
 ============
 
-:doc:`DAMON </vm/damon/index>` 允许轻量级的数据访问监测。使用DAMON，
+:doc:`DAMON </mm/damon/index>` 允许轻量级的数据访问监测。使用DAMON，
 用户可以分析他们系统的内存访问模式，并优化它们。
 
 .. toctree::
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
index 1500bdbf338a..c976f3e33ffd 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
@@ -229,4 +229,4 @@ DAMON_RECLAIM再次什么都不做，这样我们就可以退回到基于LRU列
 
 .. [1] https://research.google/pubs/pub48551/
 .. [2] https://lwn.net/Articles/787611/
-.. [3] https://www.kernel.org/doc/html/latest/vm/free_page_reporting.html
+.. [3] https://www.kernel.org/doc/html/latest/mm/free_page_reporting.html
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
index eee0e8c5c368..cd41ada4fdad 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
@@ -33,9 +33,9 @@ DAMON 为不同的用户提供了下面这些接口。
   口相同。这将在下一个LTS内核发布后被移除，所以用户应该转移到
   :ref:`sysfs interface <sysfs_interface>`。
 - *内核空间编程接口。*
-  :doc:`这 </vm/damon/api>` 这是为内核空间程序员准备的。使用它，用户可以通过为你编写内
+  :doc:`这 </mm/damon/api>` 这是为内核空间程序员准备的。使用它，用户可以通过为你编写内
   核空间的DAMON应用程序，最灵活有效地利用DAMON的每一个功能。你甚至可以为各种地址空间扩展DAMON。
-  详细情况请参考接口 :doc:`文件 </vm/damon/api>`。
+  详细情况请参考接口 :doc:`文件 </mm/damon/api>`。
 
 sysfs接口
 =========
@@ -148,7 +148,7 @@ contexts/<N>/monitoring_attrs/
 在 ``nr_regions`` 目录下，有两个文件分别用于DAMON监测区域的下限和上限（``min`` 和 ``max`` ），
 这两个文件控制着监测的开销。你可以通过向这些文件的写入和读出来设置和获取这些值。
 
-关于间隔和监测区域范围的更多细节，请参考设计文件 (:doc:`/vm/damon/design`)。
+关于间隔和监测区域范围的更多细节，请参考设计文件 (:doc:`/mm/damon/design`)。
 
 contexts/<N>/targets/
 ---------------------
@@ -318,7 +318,7 @@ DAMON导出了八个文件, ``attrs``, ``target_ids``, ``init_regions``,
 ----
 
 用户可以通过读取和写入 ``attrs`` 文件获得和设置 ``采样间隔`` 、 ``聚集间隔`` 、 ``更新间隔``
-以及监测目标区域的最小/最大数量。要详细了解监测属性，请参考 `:doc:/vm/damon/design` 。例如，
+以及监测目标区域的最小/最大数量。要详细了解监测属性，请参考 `:doc:/mm/damon/design` 。例如，
 下面的命令将这些值设置为5ms、100ms、1000ms、10和1000，然后再次检查::
 
     # cd <debugfs>/damon
diff --git a/Documentation/translations/zh_CN/core-api/index.rst b/Documentation/translations/zh_CN/core-api/index.rst
index 26d9913fc8b6..b03020c8b2ab 100644
--- a/Documentation/translations/zh_CN/core-api/index.rst
+++ b/Documentation/translations/zh_CN/core-api/index.rst
@@ -101,7 +101,7 @@ Todolist:
 ========
 
 如何在内核中分配和使用内存。请注意，在
-:doc:`/vm/index` 中有更多的内存管理文档。
+:doc:`/mm/index` 中有更多的内存管理文档。
 
 .. toctree::
    :maxdepth: 1
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index ad7bb8c17562..bf85baca8b3e 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -118,7 +118,7 @@ TODOList:
    sound/index
    filesystems/index
    scheduler/index
-   vm/index
+   mm/index
    peci/index
 
 TODOList:
diff --git a/Documentation/translations/zh_CN/vm/active_mm.rst b/Documentation/translations/zh_CN/mm/active_mm.rst
similarity index 98%
rename from Documentation/translations/zh_CN/vm/active_mm.rst
rename to Documentation/translations/zh_CN/mm/active_mm.rst
index 366609ea4f37..c2816f523bd7 100644
--- a/Documentation/translations/zh_CN/vm/active_mm.rst
+++ b/Documentation/translations/zh_CN/mm/active_mm.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/active_mm.rst
+:Original: Documentation/mm/active_mm.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/balance.rst b/Documentation/translations/zh_CN/mm/balance.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/balance.rst
rename to Documentation/translations/zh_CN/mm/balance.rst
index e98a47ef24a8..6fd79209c307 100644
--- a/Documentation/translations/zh_CN/vm/balance.rst
+++ b/Documentation/translations/zh_CN/mm/balance.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/balance.rst
+:Original: Documentation/mm/balance.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/damon/api.rst b/Documentation/translations/zh_CN/mm/damon/api.rst
similarity index 91%
rename from Documentation/translations/zh_CN/vm/damon/api.rst
rename to Documentation/translations/zh_CN/mm/damon/api.rst
index 21143eea4ebe..5593a83c86bc 100644
--- a/Documentation/translations/zh_CN/vm/damon/api.rst
+++ b/Documentation/translations/zh_CN/mm/damon/api.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-:Original: Documentation/vm/damon/api.rst
+:Original: Documentation/mm/damon/api.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/damon/design.rst b/Documentation/translations/zh_CN/mm/damon/design.rst
similarity index 98%
rename from Documentation/translations/zh_CN/vm/damon/design.rst
rename to Documentation/translations/zh_CN/mm/damon/design.rst
index 46128b77c2b3..16e3db34a7dd 100644
--- a/Documentation/translations/zh_CN/vm/damon/design.rst
+++ b/Documentation/translations/zh_CN/mm/damon/design.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-:Original: Documentation/vm/damon/design.rst
+:Original: Documentation/mm/damon/design.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/damon/faq.rst b/Documentation/translations/zh_CN/mm/damon/faq.rst
similarity index 98%
rename from Documentation/translations/zh_CN/vm/damon/faq.rst
rename to Documentation/translations/zh_CN/mm/damon/faq.rst
index 07b4ac19407d..de4be417494a 100644
--- a/Documentation/translations/zh_CN/vm/damon/faq.rst
+++ b/Documentation/translations/zh_CN/mm/damon/faq.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-:Original: Documentation/vm/damon/faq.rst
+:Original: Documentation/mm/damon/faq.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/damon/index.rst b/Documentation/translations/zh_CN/mm/damon/index.rst
similarity index 90%
rename from Documentation/translations/zh_CN/vm/damon/index.rst
rename to Documentation/translations/zh_CN/mm/damon/index.rst
index 84d36d90c9b0..b03bf307204f 100644
--- a/Documentation/translations/zh_CN/vm/damon/index.rst
+++ b/Documentation/translations/zh_CN/mm/damon/index.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-:Original: Documentation/vm/damon/index.rst
+:Original: Documentation/mm/damon/index.rst
 
 :翻译:
 
@@ -14,7 +14,7 @@ DAMON:数据访问监视器
 ==========================
 
 DAMON是Linux内核的一个数据访问监控框架子系统。DAMON的核心机制使其成为
-（该核心机制详见(Documentation/translations/zh_CN/vm/damon/design.rst)）
+（该核心机制详见(Documentation/translations/zh_CN/mm/damon/design.rst)）
 
  - *准确度* （监测输出对DRAM级别的内存管理足够有用；但可能不适合CPU Cache级别），
  - *轻量级* （监控开销低到可以在线应用），以及
@@ -30,4 +30,3 @@ DAMON是Linux内核的一个数据访问监控框架子系统。DAMON的核心
    faq
    design
    api
-
diff --git a/Documentation/translations/zh_CN/vm/free_page_reporting.rst b/Documentation/translations/zh_CN/mm/free_page_reporting.rst
similarity index 97%
rename from Documentation/translations/zh_CN/vm/free_page_reporting.rst
rename to Documentation/translations/zh_CN/mm/free_page_reporting.rst
index 31d6c34b956b..83b14cce9adf 100644
--- a/Documentation/translations/zh_CN/vm/free_page_reporting.rst
+++ b/Documentation/translations/zh_CN/mm/free_page_reporting.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/_free_page_reporting.rst
+:Original: Documentation/mm/_free_page_reporting.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/frontswap.rst b/Documentation/translations/zh_CN/mm/frontswap.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/frontswap.rst
rename to Documentation/translations/zh_CN/mm/frontswap.rst
index 3eb07870e2ef..5c18ea2be04f 100644
--- a/Documentation/translations/zh_CN/vm/frontswap.rst
+++ b/Documentation/translations/zh_CN/mm/frontswap.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/_free_page_reporting.rst
+:Original: Documentation/mm/_free_page_reporting.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/highmem.rst b/Documentation/translations/zh_CN/mm/highmem.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/highmem.rst
rename to Documentation/translations/zh_CN/mm/highmem.rst
index 018838e58c3e..81202c65e000 100644
--- a/Documentation/translations/zh_CN/vm/highmem.rst
+++ b/Documentation/translations/zh_CN/mm/highmem.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/highmem.rst
+:Original: Documentation/mm/highmem.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/hmm.rst b/Documentation/translations/zh_CN/mm/hmm.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/hmm.rst
rename to Documentation/translations/zh_CN/mm/hmm.rst
index 2379df95aa58..5024a8a15516 100644
--- a/Documentation/translations/zh_CN/vm/hmm.rst
+++ b/Documentation/translations/zh_CN/mm/hmm.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/hmm.rst
+:Original: Documentation/mm/hmm.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/hugetlbfs_reserv.rst b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/hugetlbfs_reserv.rst
rename to Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
index c6d471ce2131..752e5696cd47 100644
--- a/Documentation/translations/zh_CN/vm/hugetlbfs_reserv.rst
+++ b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/hugetlbfs_reserv.rst
+:Original: Documentation/mm/hugetlbfs_reserv.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/hwpoison.rst b/Documentation/translations/zh_CN/mm/hwpoison.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/hwpoison.rst
rename to Documentation/translations/zh_CN/mm/hwpoison.rst
index c6e1e7bdb05b..310862edc937 100644
--- a/Documentation/translations/zh_CN/vm/hwpoison.rst
+++ b/Documentation/translations/zh_CN/mm/hwpoison.rst
@@ -1,5 +1,5 @@
 
-:Original: Documentation/vm/hwpoison.rst
+:Original: Documentation/mm/hwpoison.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
similarity index 96%
rename from Documentation/translations/zh_CN/vm/index.rst
rename to Documentation/translations/zh_CN/mm/index.rst
index a1c6d529b6ff..4c8c6b7b72a3 100644
--- a/Documentation/translations/zh_CN/vm/index.rst
+++ b/Documentation/translations/zh_CN/mm/index.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/index.rst
+:Original: Documentation/mm/index.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/ksm.rst b/Documentation/translations/zh_CN/mm/ksm.rst
similarity index 98%
rename from Documentation/translations/zh_CN/vm/ksm.rst
rename to Documentation/translations/zh_CN/mm/ksm.rst
index 83b0c73984da..d1f82e857ad7 100644
--- a/Documentation/translations/zh_CN/vm/ksm.rst
+++ b/Documentation/translations/zh_CN/mm/ksm.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/ksm.rst
+:Original: Documentation/mm/ksm.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/memory-model.rst b/Documentation/translations/zh_CN/mm/memory-model.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/memory-model.rst
rename to Documentation/translations/zh_CN/mm/memory-model.rst
index 013e30c88d72..73067e864a69 100644
--- a/Documentation/translations/zh_CN/vm/memory-model.rst
+++ b/Documentation/translations/zh_CN/mm/memory-model.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-:Original: Documentation/vm/memory-model.rst
+:Original: Documentation/mm/memory-model.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/mmu_notifier.rst b/Documentation/translations/zh_CN/mm/mmu_notifier.rst
similarity index 98%
rename from Documentation/translations/zh_CN/vm/mmu_notifier.rst
rename to Documentation/translations/zh_CN/mm/mmu_notifier.rst
index b29a37b33628..ce3664d1a410 100644
--- a/Documentation/translations/zh_CN/vm/mmu_notifier.rst
+++ b/Documentation/translations/zh_CN/mm/mmu_notifier.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/mmu_notifier.rst
+:Original: Documentation/mm/mmu_notifier.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/numa.rst b/Documentation/translations/zh_CN/mm/numa.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/numa.rst
rename to Documentation/translations/zh_CN/mm/numa.rst
index 6af412b924ad..b15cfeeb6dfb 100644
--- a/Documentation/translations/zh_CN/vm/numa.rst
+++ b/Documentation/translations/zh_CN/mm/numa.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/numa.rst
+:Original: Documentation/mm/numa.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/overcommit-accounting.rst b/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
similarity index 98%
rename from Documentation/translations/zh_CN/vm/overcommit-accounting.rst
rename to Documentation/translations/zh_CN/mm/overcommit-accounting.rst
index 8765cb118f24..d8452d8b7fbb 100644
--- a/Documentation/translations/zh_CN/vm/overcommit-accounting.rst
+++ b/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/overcommit-accounting.rst
+:Original: Documentation/mm/overcommit-accounting.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/page_frags.rst b/Documentation/translations/zh_CN/mm/page_frags.rst
similarity index 97%
rename from Documentation/translations/zh_CN/vm/page_frags.rst
rename to Documentation/translations/zh_CN/mm/page_frags.rst
index ad27fed33634..320952ca93af 100644
--- a/Documentation/translations/zh_CN/vm/page_frags.rst
+++ b/Documentation/translations/zh_CN/mm/page_frags.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/page_frag.rst
+:Original: Documentation/mm/page_frag.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/page_owner.rst b/Documentation/translations/zh_CN/mm/page_owner.rst
similarity index 99%
rename from Documentation/translations/zh_CN/vm/page_owner.rst
rename to Documentation/translations/zh_CN/mm/page_owner.rst
index 9e951fabba9d..03d9e613094a 100644
--- a/Documentation/translations/zh_CN/vm/page_owner.rst
+++ b/Documentation/translations/zh_CN/mm/page_owner.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/page_owner.rst
+:Original: Documentation/mm/page_owner.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/page_table_check.rst b/Documentation/translations/zh_CN/mm/page_table_check.rst
similarity index 97%
rename from Documentation/translations/zh_CN/vm/page_table_check.rst
rename to Documentation/translations/zh_CN/mm/page_table_check.rst
index a29fc1b360e6..e8077310a76c 100644
--- a/Documentation/translations/zh_CN/vm/page_table_check.rst
+++ b/Documentation/translations/zh_CN/mm/page_table_check.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-:Original: Documentation/vm/page_table_check.rst
+:Original: Documentation/mm/page_table_check.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/remap_file_pages.rst b/Documentation/translations/zh_CN/mm/remap_file_pages.rst
similarity index 97%
rename from Documentation/translations/zh_CN/vm/remap_file_pages.rst
rename to Documentation/translations/zh_CN/mm/remap_file_pages.rst
index af6b7e28af23..31e0c54dc36f 100644
--- a/Documentation/translations/zh_CN/vm/remap_file_pages.rst
+++ b/Documentation/translations/zh_CN/mm/remap_file_pages.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/remap_file_pages.rst
+:Original: Documentation/mm/remap_file_pages.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/split_page_table_lock.rst b/Documentation/translations/zh_CN/mm/split_page_table_lock.rst
similarity index 98%
rename from Documentation/translations/zh_CN/vm/split_page_table_lock.rst
rename to Documentation/translations/zh_CN/mm/split_page_table_lock.rst
index 50694d97c426..4fb7aa666037 100644
--- a/Documentation/translations/zh_CN/vm/split_page_table_lock.rst
+++ b/Documentation/translations/zh_CN/mm/split_page_table_lock.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/split_page_table_lock.rst
+:Original: Documentation/mm/split_page_table_lock.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/z3fold.rst b/Documentation/translations/zh_CN/mm/z3fold.rst
similarity index 96%
rename from Documentation/translations/zh_CN/vm/z3fold.rst
rename to Documentation/translations/zh_CN/mm/z3fold.rst
index 57204aa08caa..9569a6d88270 100644
--- a/Documentation/translations/zh_CN/vm/z3fold.rst
+++ b/Documentation/translations/zh_CN/mm/z3fold.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/z3fold.rst
+:Original: Documentation/mm/z3fold.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/zsmalloc.rst b/Documentation/translations/zh_CN/mm/zsmalloc.rst
similarity index 98%
rename from Documentation/translations/zh_CN/vm/zsmalloc.rst
rename to Documentation/translations/zh_CN/mm/zsmalloc.rst
index 29e9c70a8eb6..b5596ea08ae4 100644
--- a/Documentation/translations/zh_CN/vm/zsmalloc.rst
+++ b/Documentation/translations/zh_CN/mm/zsmalloc.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/zs_malloc.rst
+:Original: Documentation/mm/zs_malloc.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index e1ce9d8c06f8..e97d7d578751 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -128,7 +128,7 @@ TODOList:
 * security/index
 * sound/index
 * crypto/index
-* vm/index
+* mm/index
 * bpf/index
 * usb/index
 * PCI/index
diff --git a/Documentation/vm/.gitignore b/Documentation/vm/.gitignore
deleted file mode 100644
index bc74f5643008..000000000000
--- a/Documentation/vm/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-page-types
-slabinfo
diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..389544a3da69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5509,7 +5509,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-mm-damon
 F:	Documentation/admin-guide/mm/damon/
-F:	Documentation/vm/damon/
+F:	Documentation/mm/damon/
 F:	include/linux/damon.h
 F:	include/trace/events/damon.h
 F:	mm/damon/
@@ -9016,7 +9016,7 @@ HMM - Heterogeneous Memory Management
 M:	Jérôme Glisse <jglisse@redhat.com>
 L:	linux-mm@kvack.org
 S:	Maintained
-F:	Documentation/vm/hmm.rst
+F:	Documentation/mm/hmm.rst
 F:	include/linux/hmm*
 F:	lib/test_hmm*
 F:	mm/hmm*
@@ -9114,8 +9114,8 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-mm-hugepages
 F:	Documentation/admin-guide/mm/hugetlbpage.rst
-F:	Documentation/vm/hugetlbfs_reserv.rst
-F:	Documentation/vm/vmemmap_dedup.rst
+F:	Documentation/mm/hugetlbfs_reserv.rst
+F:	Documentation/mm/vmemmap_dedup.rst
 F:	fs/hugetlbfs/
 F:	include/linux/hugetlb.h
 F:	mm/hugetlb.c
@@ -15025,7 +15025,7 @@ M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 M:	Andrew Morton <akpm@linux-foundation.org>
 L:	linux-mm@kvack.org
 S:	Maintained
-F:	Documentation/vm/page_table_check.rst
+F:	Documentation/mm/page_table_check.rst
 F:	include/linux/page_table_check.h
 F:	mm/page_table_check.c
 
@@ -22107,7 +22107,7 @@ M:	Nitin Gupta <ngupta@vflare.org>
 R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 L:	linux-mm@kvack.org
 S:	Maintained
-F:	Documentation/vm/zsmalloc.rst
+F:	Documentation/mm/zsmalloc.rst
 F:	include/linux/zsmalloc.h
 F:	mm/zsmalloc.c
 
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1920d52653b4..db2838cf8c02 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -410,7 +410,7 @@ config ARCH_SPARSEMEM_ENABLE
 	  Say Y to support efficient handling of sparse physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
 	  or have huge holes in the physical address space for other reasons.
-	  See <file:Documentation/vm/numa.rst> for more.
+	  See <file:Documentation/mm/numa.rst> for more.
 
 config ARCH_ENABLE_THP_MIGRATION
 	def_bool y
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index cb9d5fd39d7f..392ff48f77df 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1273,7 +1273,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
  * should return true.
  * We should not call this on a hugetlb entry. We should check for HugeTLB
  * entry using vma->vm_flags
- * The page table walk rule is explained in Documentation/vm/transhuge.rst
+ * The page table walk rule is explained in Documentation/mm/transhuge.rst
  */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index d5a6f101f843..126a36571667 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -4,7 +4,7 @@
  *
  * Authors: Jérôme Glisse <jglisse@redhat.com>
  *
- * See Documentation/vm/hmm.rst for reasons and overview of what HMM is.
+ * See Documentation/mm/hmm.rst for reasons and overview of what HMM is.
  */
 #ifndef LINUX_HMM_H
 #define LINUX_HMM_H
@@ -100,7 +100,7 @@ struct hmm_range {
 };
 
 /*
- * Please see Documentation/vm/hmm.rst for how to use the range API.
+ * Please see Documentation/mm/hmm.rst for how to use the range API.
  */
 int hmm_range_fault(struct hmm_range *range);
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 8af304f6b504..9f5ee49482de 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -39,7 +39,7 @@ struct vmem_altmap {
  * must be treated as an opaque object, rather than a "normal" struct page.
  *
  * A more complete discussion of unaddressable memory may be found in
- * include/linux/hmm.h and Documentation/vm/hmm.rst.
+ * include/linux/hmm.h and Documentation/mm/hmm.rst.
  *
  * MEMORY_DEVICE_FS_DAX:
  * Host memory that has similar access semantics as System RAM i.e. DMA
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 45fc2c81e370..d6c06e140277 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -198,7 +198,7 @@ struct mmu_notifier_ops {
 	 * invalidate_range_start()/end() notifiers, as
 	 * invalidate_range() already catches the points in time when an
 	 * external TLB range needs to be flushed. For more in depth
-	 * discussion on this see Documentation/vm/mmu_notifier.rst
+	 * discussion on this see Documentation/mm/mmu_notifier.rst
 	 *
 	 * Note that this function might be called with just a sub-range
 	 * of what was passed to invalidate_range_start()/end(), if
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 8cd975a8bfeb..2a243616f222 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -29,7 +29,7 @@ extern struct mm_struct *mm_alloc(void);
  *
  * Use mmdrop() to release the reference acquired by mmgrab().
  *
- * See also <Documentation/vm/active_mm.rst> for an in-depth explanation
+ * See also <Documentation/mm/active_mm.rst> for an in-depth explanation
  * of &mm_struct.mm_count vs &mm_struct.mm_users.
  */
 static inline void mmgrab(struct mm_struct *mm)
@@ -92,7 +92,7 @@ static inline void mmdrop_sched(struct mm_struct *mm)
  *
  * Use mmput() to release the reference acquired by mmget().
  *
- * See also <Documentation/vm/active_mm.rst> for an in-depth explanation
+ * See also <Documentation/mm/active_mm.rst> for an in-depth explanation
  * of &mm_struct.mm_count vs &mm_struct.mm_users.
  */
 static inline void mmget(struct mm_struct *mm)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0c0fed1b348f..95a5b7aa1ae9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -74,7 +74,7 @@ static inline int current_is_kswapd(void)
 
 /*
  * Unaddressable device memory support. See include/linux/hmm.h and
- * Documentation/vm/hmm.rst. Short description is we need struct pages for
+ * Documentation/mm/hmm.rst. Short description is we need struct pages for
  * device memory that is unaddressable (inaccessible) by CPU, so that we can
  * migrate part of a process memory to device memory.
  *
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..c1fa4993a56f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -663,7 +663,7 @@ config KSM
 	  the many instances by a single page with that content, so
 	  saving memory until one or another app needs to modify the content.
 	  Recommended for use with KVM, or with other duplicative applications.
-	  See Documentation/vm/ksm.rst for more information: KSM is inactive
+	  See Documentation/mm/ksm.rst for more information: KSM is inactive
 	  until a program has madvised that an area is MADV_MERGEABLE, and
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1ab091f49fc0..dc7df1254f0a 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -35,7 +35,7 @@
 #include <asm/tlbflush.h>
 
 /*
- * Please refer Documentation/vm/arch_pgtable_helpers.rst for the semantics
+ * Please refer Documentation/mm/arch_pgtable_helpers.rst for the semantics
  * expectations that are being validated here. All future changes in here
  * or the documentation need to be in sync.
  */
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 6f69b044a8cc..1a97610308cb 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -4,7 +4,7 @@
  *
  * This code provides the generic "frontend" layer to call a matching
  * "backend" driver implementation of frontswap.  See
- * Documentation/vm/frontswap.rst for more information.
+ * Documentation/mm/frontswap.rst for more information.
  *
  * Copyright (C) 2009-2012 Oracle Corp.  All rights reserved.
  * Author: Dan Magenheimer
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7248002dad9..b3b5d8cf63ab 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1937,7 +1937,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	 * replacing a zero pmd write protected page with a zero pte write
 	 * protected page.
 	 *
-	 * See Documentation/vm/mmu_notifier.rst
+	 * See Documentation/mm/mmu_notifier.rst
 	 */
 	pmdp_huge_clear_flush(vma, haddr, pmd);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a57e1be41401..b36a4ef87a2e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4875,7 +4875,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				 * table protection not changing it to point
 				 * to a new page.
 				 *
-				 * See Documentation/vm/mmu_notifier.rst
+				 * See Documentation/mm/mmu_notifier.rst
 				 */
 				huge_ptep_set_wrprotect(src, addr, src_pte);
 				entry = huge_pte_wrprotect(entry);
@@ -6403,7 +6403,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * No need to call mmu_notifier_invalidate_range() we are downgrading
 	 * page table protection not changing it to point to a new page.
 	 *
-	 * See Documentation/vm/mmu_notifier.rst
+	 * See Documentation/mm/mmu_notifier.rst
 	 */
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 	mmu_notifier_invalidate_range_end(&range);
@@ -7102,7 +7102,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 	/*
 	 * No need to call mmu_notifier_invalidate_range(), see
-	 * Documentation/vm/mmu_notifier.rst.
+	 * Documentation/mm/mmu_notifier.rst.
 	 */
 	mmu_notifier_invalidate_range_end(&range);
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1089ea8a9c98..ba29c15c53d6 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -6,7 +6,7 @@
  *
  *     Author: Muchun Song <songmuchun@bytedance.com>
  *
- * See Documentation/vm/vmemmap_dedup.rst
+ * See Documentation/mm/vmemmap_dedup.rst
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 54f78c9eecae..8d2dc501c92c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1083,7 +1083,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 		 * No need to notify as we are downgrading page table to read
 		 * only not changing it to point to a new page.
 		 *
-		 * See Documentation/vm/mmu_notifier.rst
+		 * See Documentation/mm/mmu_notifier.rst
 		 */
 		entry = ptep_clear_flush(vma, pvmw.address, pvmw.pte);
 		/*
@@ -1186,7 +1186,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	 * No need to notify as we are replacing a read only page with another
 	 * read only page with the same content.
 	 *
-	 * See Documentation/vm/mmu_notifier.rst
+	 * See Documentation/mm/mmu_notifier.rst
 	 */
 	ptep_clear_flush(vma, addr, ptep);
 	set_pte_at_notify(mm, addr, ptep, newpte);
diff --git a/mm/mmap.c b/mm/mmap.c
index 61e6135c54ef..c14d7286a379 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2944,7 +2944,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	unsigned long ret = -EINVAL;
 	struct file *file;
 
-	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/vm/remap_file_pages.rst.\n",
+	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.\n",
 		     current->comm, current->pid);
 
 	if (prot)
diff --git a/mm/rmap.c b/mm/rmap.c
index 5bcb334cd6f2..65e0a767b837 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -999,7 +999,7 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 		 * downgrading page table protection not changing it to point
 		 * to a new page.
 		 *
-		 * See Documentation/vm/mmu_notifier.rst
+		 * See Documentation/mm/mmu_notifier.rst
 		 */
 		if (ret)
 			cleaned++;
@@ -1765,7 +1765,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * to point at a new folio while a device is
 			 * still using this folio.
 			 *
-			 * See Documentation/vm/mmu_notifier.rst
+			 * See Documentation/mm/mmu_notifier.rst
 			 */
 			dec_mm_counter(mm, mm_counter_file(&folio->page));
 		}
@@ -1775,7 +1775,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 * done above for all cases requiring it to happen under page
 		 * table lock before mmu_notifier_invalidate_range_end()
 		 *
-		 * See Documentation/vm/mmu_notifier.rst
+		 * See Documentation/mm/mmu_notifier.rst
 		 */
 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
 		if (vma->vm_flags & VM_LOCKED)
@@ -2093,7 +2093,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		 * done above for all cases requiring it to happen under page
 		 * table lock before mmu_notifier_invalidate_range_end()
 		 *
-		 * See Documentation/vm/mmu_notifier.rst
+		 * See Documentation/mm/mmu_notifier.rst
 		 */
 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
 		if (vma->vm_flags & VM_LOCKED)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f4fa61dbbee3..49ebd8dc42ef 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -752,7 +752,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
 		/*
 		 * Reuse the previous page for the rest of tail pages
-		 * See layout diagram in Documentation/vm/vmemmap_dedup.rst
+		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
diff --git a/mm/util.c b/mm/util.c
index 0837570c9225..5df8f2db7ca9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1005,7 +1005,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
  * succeed and -ENOMEM implies there is not.
  *
  * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting.rst
+ * vm.overcommit_memory sysctl.  See Documentation/mm/overcommit-accounting.rst
  *
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index c149427eb1c9..74c3dcecf64d 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -8,7 +8,7 @@
  * Or sort by total memory:
  * ./page_owner_sort -m page_owner_full.txt sorted_page_owner.txt
  *
- * See Documentation/vm/page_owner.rst
+ * See Documentation/mm/page_owner.rst
 */
 
 #include <stdio.h>

base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
2.35.3

