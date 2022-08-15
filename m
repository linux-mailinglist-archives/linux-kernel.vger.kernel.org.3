Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A8D5937D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiHOTVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbiHOTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:16:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF352FD9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:38:07 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27FIbvIV008803
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:38:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=9dFynMf7CCU9gLS+bI91K7F1XyRUDeI2AxG3iT8WJa4=;
 b=O9hNtnKEf2MoY7HbKZwziFN1WlsvLcLc7himUvQvZaKmyx1XXXZ3O3HVUElFbeQGnlBp
 Cdk+ZuxfTthCuK3pl5wo7POY+1kHXuL4djS3P/kvYqAtUaR/cSc6b+tkuzAUIlyD5nnI
 SGi7OcKXXWUemjycVF+jJd7ZOVpx+ED7PkI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hysv2gufx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:38:03 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 15 Aug 2022 11:37:20 -0700
Received: by devvm301.eag0.facebook.com (Postfix, from userid 352741)
        id 22D3830D9F7C; Mon, 15 Aug 2022 11:37:08 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <corbet@lwn.net>, <bobwxc@email.cn>, <rppt@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>
CC:     Alexander Zhu <alexlzhu@fb.com>
Subject: [PATCH] docs: admin-guide/mm:
Date:   Mon, 15 Aug 2022 11:37:06 -0700
Message-ID: <20220815183706.2508116-1-alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BR6rO_rZcH3I_eE4Hc8_t0bSMdem4ZWU
X-Proofpoint-ORIG-GUID: BR6rO_rZcH3I_eE4Hc8_t0bSMdem4ZWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Zhu <alexlzhu@fb.com>

This commit fixes typos and grammar errors in
Documentation/admin-guide/mm/concepts.rst.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
---
 Documentation/admin-guide/mm/concepts.rst | 138 +++++++++++-----------
 1 file changed, 68 insertions(+), 70 deletions(-)

diff --git a/Documentation/admin-guide/mm/concepts.rst b/Documentation/ad=
min-guide/mm/concepts.rst
index c79f1e336222..c471f80b7a38 100644
--- a/Documentation/admin-guide/mm/concepts.rst
+++ b/Documentation/admin-guide/mm/concepts.rst
@@ -4,14 +4,13 @@
 Concepts overview
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-The memory management in Linux is a complex system that evolved over the
-years and included more and more functionality to support a variety of
-systems from MMU-less microcontrollers to supercomputers. The memory
-management for systems without an MMU is called ``nommu`` and it
-definitely deserves a dedicated document, which hopefully will be
-eventually written. Yet, although some of the concepts are the same,
-here we assume that an MMU is available and a CPU can translate a virtua=
l
-address to a physical address.
+The memory management subsystem is a complex codebase that evolved over =
the
+years to support a variety of systems from MMU-less microcontrollers to
+supercomputers. The memory management subsystem for systems without an
+MMU is called ``nommu`` and it deserves a dedicated document, which
+hopefully will be written at some point. Although some of the concepts
+are the same, here we assume that an MMU is available and a CPU can
+translate a virtual address to a physical address.
=20
 .. contents:: :local:
=20
@@ -29,8 +28,8 @@ of how these address ranges are defined.
 All this makes dealing directly with physical memory quite complex and
 to avoid this complexity a concept of virtual memory was developed.
=20
-The virtual memory abstracts the details of physical memory from the
-application software, allows to keep only needed information in the
+Virtual memory abstracts the details of physical memory from the
+application software, allows for keeping only needed information in
 physical memory (demand paging) and provides a mechanism for the
 protection and controlled sharing of data between processes.
=20
@@ -42,76 +41,75 @@ memory controller can understand.
=20
 The physical system memory is divided into page frames, or pages. The
 size of each page is architecture specific. Some architectures allow
-selection of the page size from several supported values; this
-selection is performed at the kernel build time by setting an
+selection of page size from several supported values; this
+selection is performed at kernel build time by setting an
 appropriate kernel configuration option.
=20
-Each physical memory page can be mapped as one or more virtual
+Each page in physical memory can be mapped as one or more virtual
 pages. These mappings are described by page tables that allow
 translation from a virtual address used by programs to the physical
-memory address. The page tables are organized hierarchically.
+address. The page tables are organized hierarchically.
=20
 The tables at the lowest level of the hierarchy contain physical
 addresses of actual pages used by the software. The tables at higher
-levels contain physical addresses of the pages belonging to the lower
+levels contain physical addresses of pages belonging to lower
 levels. The pointer to the top level page table resides in a
-register. When the CPU performs the address translation, it uses this
+register. When the CPU performs address translation, it uses this
 register to access the top level page table. The high bits of the
 virtual address are used to index an entry in the top level page
 table. That entry is then used to access the next level in the
-hierarchy with the next bits of the virtual address as the index to
-that level page table. The lowest bits in the virtual address define
+hierarchy with the next bits of the virtual address as the index into
+the page table at that level. The lowest bits in the virtual address def=
ine
 the offset inside the actual page.
=20
 Huge Pages
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-The address translation requires several memory accesses and memory
-accesses are slow relatively to CPU speed. To avoid spending precious
-processor cycles on the address translation, CPUs maintain a cache of
-such translations called Translation Lookaside Buffer (or
-TLB). Usually TLB is pretty scarce resource and applications with
-large memory working set will experience performance hit because of
-TLB misses.
+Address translation requires several memory accesses and memory
+accesses are slow relative to CPU speed. To avoid spending precious
+processor cycles on address translation, CPUs maintain a cache of
+such translations called the Translation Lookaside Buffer (or
+TLB). Usually TLB is a scarce resource and applications with a
+large in-memory working set will experience performance hit due to
+TLB miss.
=20
 Many modern CPU architectures allow mapping of the memory pages
 directly by the higher levels in the page table. For instance, on x86,
 it is possible to map 2M and even 1G pages using entries in the second
 and the third level page tables. In Linux such pages are called
-`huge`. Usage of huge pages significantly reduces pressure on TLB,
+`huge`. Usage of huge pages significantly reduces pressure on the TLB,
 improves TLB hit-rate and thus improves overall system performance.
=20
-There are two mechanisms in Linux that enable mapping of the physical
-memory with the huge pages. The first one is `HugeTLB filesystem`, or
+There are two mechanisms in Linux that enable mapping of physical
+memory with huge pages. The first one is `HugeTLB filesystem`, or
 hugetlbfs. It is a pseudo filesystem that uses RAM as its backing
-store. For the files created in this filesystem the data resides in
-the memory and mapped using huge pages. The hugetlbfs is described at
+store. For files created in this filesystem the data resides in
+memory and is mapped with huge pages. hugetlbfs is described at
 :ref:`Documentation/admin-guide/mm/hugetlbpage.rst <hugetlbpage>`.
=20
-Another, more recent, mechanism that enables use of the huge pages is
-called `Transparent HugePages`, or THP. Unlike the hugetlbfs that
-requires users and/or system administrators to configure what parts of
-the system memory should and can be mapped by the huge pages, THP
-manages such mappings transparently to the user and hence the
-name. See
+Another mechanism that enables use of huge pages is called
+`Transparent HugePages`, or THP. Unlike hugetlbfs that requires
+users and/or system administrators to configure what parts of
+system memory can and should be mapped by huge pages, THP
+manages such mappings transparently to the user, hence the name. See
 :ref:`Documentation/admin-guide/mm/transhuge.rst <admin_guide_transhuge>=
`
-for more details about THP.
+for more details on THP.
=20
 Zones
 =3D=3D=3D=3D=3D
=20
 Often hardware poses restrictions on how different physical memory
 ranges can be accessed. In some cases, devices cannot perform DMA to
-all the addressable memory. In other cases, the size of the physical
+all the addressable memory. In other cases, the size of physical
 memory exceeds the maximal addressable size of virtual memory and
-special actions are required to access portions of the memory. Linux
+special actions are required to access portions of memory. Linux
 groups memory pages into `zones` according to their possible
 usage. For example, ZONE_DMA will contain memory that can be used by
 devices for DMA, ZONE_HIGHMEM will contain memory that is not
 permanently mapped into kernel's address space and ZONE_NORMAL will
 contain normally addressed pages.
=20
-The actual layout of the memory zones is hardware dependent as not all
+The actual layout of memory zones is hardware dependent as not all
 architectures define all zones, and requirements for DMA are different
 for different platforms.
=20
@@ -131,10 +129,10 @@ counters. You can find more details about NUMA in
 Page cache
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-The physical memory is volatile and the common case for getting data
-into the memory is to read it from files. Whenever a file is read, the
+Physical memory is volatile and the common case for getting data
+into memory is to read it from files. Whenever a file is read, the
 data is put into the `page cache` to avoid expensive disk access on
-the subsequent reads. Similarly, when one writes to a file, the data
+subsequent reads. Similarly, when one writes to a file, the data
 is placed in the page cache and eventually gets into the backing
 storage device. The written pages are marked as `dirty` and when Linux
 decides to reuse them for other purposes, it makes sure to synchronize
@@ -145,10 +143,10 @@ Anonymous Memory
=20
 The `anonymous memory` or `anonymous mappings` represent memory that
 is not backed by a filesystem. Such mappings are implicitly created
-for program's stack and heap or by explicit calls to mmap(2) system
-call. Usually, the anonymous mappings only define virtual memory areas
+for the program's stack and heap or by explicit calls to the mmap(2) sys=
tem
+call. Usually, anonymous mappings only define virtual memory areas
 that the program is allowed to access. The read accesses will result
-in creation of a page table entry that references a special physical
+in the creation of a page table entry that references a special physical
 page filled with zeroes. When the program performs a write, a regular
 physical page will be allocated to hold the written data. The page
 will be marked dirty and if the kernel decides to repurpose it,
@@ -159,46 +157,46 @@ Reclaim
=20
 Throughout the system lifetime, a physical page can be used for storing
 different types of data. It can be kernel internal data structures,
-DMA'able buffers for device drivers use, data read from a filesystem,
+DMA'able buffers for device drivers to use, data read from a filesystem,
 memory allocated by user space processes etc.
=20
-Depending on the page usage it is treated differently by the Linux
-memory management. The pages that can be freed at any time, either
-because they cache the data available elsewhere, for instance, on a
-hard disk, or because they can be swapped out, again, to the hard
+Depending on page usage it is treated differently by the Linux
+memory management subsystem. Pages that can be freed at any time,
+either because they cache the data available elsewhere
+(ie on a hard disk) or because they can be swapped out to the hard
 disk, are called `reclaimable`. The most notable categories of the
 reclaimable pages are page cache and anonymous memory.
=20
 In most cases, the pages holding internal kernel data and used as DMA
 buffers cannot be repurposed, and they remain pinned until freed by
 their user. Such pages are called `unreclaimable`. However, in certain
-circumstances, even pages occupied with kernel data structures can be
+circumstances, even pages occupied by kernel data structures can be
 reclaimed. For instance, in-memory caches of filesystem metadata can
-be re-read from the storage device and therefore it is possible to
-discard them from the main memory when system is under memory
+be re-read from the storage device and thus it is possible to
+discard them from main memory when the system is under memory
 pressure.
=20
-The process of freeing the reclaimable physical memory pages and
-repurposing them is called (surprise!) `reclaim`. Linux can reclaim
-pages either asynchronously or synchronously, depending on the state
-of the system. When the system is not loaded, most of the memory is free
+The process of freeing and repurposing reclaimable physical pages
+is called (surprise!) `reclaim`. Linux can reclaim pages either
+synchronously or asynchronously, depending on the state of the
+system. When system load is light, most of the memory is free
 and allocation requests will be satisfied immediately from the free
-pages supply. As the load increases, the amount of the free pages goes
+page supply. As the load increases, the number of the free pages goes
 down and when it reaches a certain threshold (low watermark), an
 allocation request will awaken the ``kswapd`` daemon. It will
-asynchronously scan memory pages and either just free them if the data
-they contain is available elsewhere, or evict to the backing storage
-device (remember those dirty pages?). As memory usage increases even
-more and reaches another threshold - min watermark - an allocation
-will trigger `direct reclaim`. In this case allocation is stalled
-until enough memory pages are reclaimed to satisfy the request.
+asynchronously scan memory pages and either free them if the data
+they contain is available elsewhere, or evict them to the backing
+storage device (remember those dirty pages?). As memory usage
+increases even more and reaches another threshold - min watermark - an
+allocation will trigger `direct reclaim`. In this case allocation is
+stalled until enough memory pages are reclaimed to satisfy the request.
=20
 Compaction
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-As the system runs, tasks allocate and free the memory and it becomes
+As the system runs, tasks will allocate and free memory. Memory thus bec=
omes
 fragmented. Although with virtual memory it is possible to present
-scattered physical pages as virtually contiguous range, sometimes it is
+scattered physical pages as a virtually contiguous range, sometimes it i=
s
 necessary to allocate large physically contiguous memory areas. Such
 need may arise, for instance, when a device driver requires a large
 buffer for DMA, or when THP allocates a huge page. Memory `compaction`
@@ -214,10 +212,10 @@ daemon or synchronously as a result of a memory all=
ocation request.
 OOM killer
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-It is possible that on a loaded machine memory will be exhausted and the
+It is possible that under heavy load memory will be exhausted and the
 kernel will be unable to reclaim enough memory to continue to operate. I=
n
 order to save the rest of the system, it invokes the `OOM killer`.
=20
-The `OOM killer` selects a task to sacrifice for the sake of the overall
-system health. The selected task is killed in a hope that after it exits
+The `OOM killer` selects a task to sacrifice for the sake of overall
+system health. The selected task is killed in the hope that after it exi=
ts
 enough memory will be freed to continue normal operation.
--=20
2.30.2

