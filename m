Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3961E59090A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiHKXRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiHKXQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802EA0248
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D23E95C015B;
        Thu, 11 Aug 2022 19:16:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 11 Aug 2022 19:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259806; x=
        1660346206; bh=sas7p0h+HfwjUG+446PhmSPx9OM2Xn7AyggPrr0InTg=; b=Z
        WJ7c6F3rCEwzl8XB6AvT4pH8RwpnSXR7cHr4fXPAp/kcccLukz1ckZI6KslaBcXG
        x0Gh2dFcjHVIWDPN1Hjordou1Lm6OHXI4Eci5wyVPKbpOtz/CrMsONlqvfUSc4Nv
        hQHMAajqffh2qLKVXoyZWDa7qbrr4m/lqvZVQbPFjQ2COnX6uOZkULctet8ILUIz
        0FhAW+F45W61DsVRB1+8EchzWh2xsv68KNg31Ta9MYE65jNknfpr8mqifHdk2eI1
        9CRWIf65pRHVkiPrDh0mraczmeo1f/ibrznCU/pFUXSGRnibsRE6K6Y2ULELGya/
        rUUuX9pske0QCyvUeCz+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259806; x=1660346206; bh=s
        as7p0h+HfwjUG+446PhmSPx9OM2Xn7AyggPrr0InTg=; b=bdj5JHpL/TEmTzrW/
        fkzI3pDYzzwrxcsxcDuT9Si4YDluBn6rOSntLrbq6DDJhPwKr+n7BedOBhR/8Q9W
        gPcL9o2buM9fugS8TrUGIgT/1iWLCUbmDfCsQIOz1u4lZvUKopEjkz/uDdjBS3zs
        6/PqbDW6iNTfMMm7TWDxxFsif2i8GQKDxbHyTjSSzAGaQvUQ3/WyWQY+bkyz0ar8
        HwtNhfnH+gfhiTknyFY29mTsP6tuysgeuhPLe9ovM+XPNPUXvUl/KDpF5QQtRxck
        FrvhXnzghj279GFg/Gsforu9/5dflLjt1VWyldVeg00S/SMgp/QJOlYmYmMpvGp/
        N2nCg==
X-ME-Sender: <xms:3o31YjGjJCR77ph9hK73etsToHx7_SfCi8GrYZDrcqyhrPQhsVYzeg>
    <xme:3o31YgWeWYXUeXmlOBWcAr3fB8Xg8VJ94i76Yt5GKg1_bgP5QHZNG7ldz_W2CFbR-
    WK7djpM8z2U4Hp12Q>
X-ME-Received: <xmr:3o31YlIeHUUqdU3QF1SnBbMgFyi_msDY3VLOZQXXdXTWAREfN6FG5BKWAkYix6GMGkZL0e-0iobyIGa74Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:3o31YhEBH-tb1VFg-FH5PrefOW5Pgyhko_lp_nXyUbtnARKU0RM6DA>
    <xmx:3o31YpV-GO2Nv_gHTfqZTaY-ln4I2_VZM2DQANWNbNglA0K7K3XzTw>
    <xmx:3o31YsNfal28x6vHAZlcmqSLw-bBftZytqN0aVICy4t3tAcC2Hls1Q>
    <xmx:3o31YiPgHzDuaEFmKIxcWvU3-2bBtAECJ3kbcBVrCNaNu6Ui2dvOKg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:46 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 02/12] mm: rectify MAX_ORDER semantics to be the largest page order from buddy allocator
Date:   Thu, 11 Aug 2022 19:16:33 -0400
Message-Id: <20220811231643.1012912-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811231643.1012912-1-zi.yan@sent.com>
References: <20220811231643.1012912-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

MAX_ORDER used to denote the largest page order + 1, but that was
confusing and caused several off-by-1 errors in the code. Fix it by
setting MAX_ORDER to the largest page order from buddy allocator like
what its name says.

Add a warning in checkpatch.pl about the semantics change.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          |  4 +-
 .../admin-guide/kernel-parameters.txt         |  4 +-
 arch/arc/Kconfig                              |  4 +-
 arch/arm/Kconfig                              | 12 +++---
 arch/arm/configs/imx_v6_v7_defconfig          |  2 +-
 arch/arm/configs/milbeaut_m10v_defconfig      |  2 +-
 arch/arm/configs/oxnas_v6_defconfig           |  2 +-
 arch/arm/configs/sama7_defconfig              |  2 +-
 arch/arm64/Kconfig                            | 16 ++++----
 arch/arm64/include/asm/sparsemem.h            |  2 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  2 +-
 arch/csky/Kconfig                             |  2 +-
 arch/ia64/Kconfig                             |  8 ++--
 arch/ia64/include/asm/sparsemem.h             |  4 +-
 arch/ia64/mm/hugetlbpage.c                    |  2 +-
 arch/m68k/Kconfig.cpu                         |  8 ++--
 arch/mips/Kconfig                             | 22 +++++-----
 arch/nios2/Kconfig                            | 10 ++---
 arch/powerpc/Kconfig                          | 30 +++++++-------
 arch/powerpc/configs/85xx/ge_imp3a_defconfig  |  2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config     |  2 +-
 arch/powerpc/mm/book3s64/iommu_api.c          |  2 +-
 arch/powerpc/mm/hugetlbpage.c                 |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c     |  2 +-
 arch/sh/configs/ecovec24_defconfig            |  2 +-
 arch/sh/mm/Kconfig                            | 20 +++++-----
 arch/sparc/Kconfig                            |  8 ++--
 arch/sparc/kernel/pci_sun4v.c                 |  2 +-
 arch/sparc/kernel/traps_64.c                  |  2 +-
 arch/xtensa/Kconfig                           |  8 ++--
 drivers/base/regmap/regmap-debugfs.c          |  8 ++--
 drivers/crypto/hisilicon/sgl.c                |  6 +--
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                | 22 +++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 drivers/irqchip/irq-gic-v3-its.c              |  4 +-
 drivers/md/dm-bufio.c                         |  2 +-
 drivers/misc/genwqe/card_utils.c              |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
 drivers/video/fbdev/hyperv_fb.c               |  6 +--
 drivers/virtio/virtio_balloon.c               |  2 +-
 drivers/virtio/virtio_mem.c                   |  8 ++--
 fs/ramfs/file-nommu.c                         |  2 +-
 include/drm/ttm/ttm_pool.h                    |  2 +-
 include/linux/hugetlb.h                       |  2 +-
 include/linux/mmzone.h                        | 10 ++---
 include/linux/pageblock-flags.h               |  4 +-
 include/linux/slab.h                          |  8 ++--
 kernel/crash_core.c                           |  2 +-
 kernel/dma/pool.c                             |  6 +--
 mm/Kconfig                                    |  6 +--
 mm/compaction.c                               |  8 ++--
 mm/debug_vm_pgtable.c                         |  4 +-
 mm/huge_memory.c                              |  2 +-
 mm/hugetlb.c                                  |  4 +-
 mm/memblock.c                                 |  2 +-
 mm/memory_hotplug.c                           |  4 +-
 mm/page_alloc.c                               | 40 +++++++++----------
 mm/page_isolation.c                           | 14 +++----
 mm/page_owner.c                               |  6 +--
 mm/page_reporting.c                           |  4 +-
 mm/shuffle.h                                  |  2 +-
 mm/slab.c                                     |  2 +-
 mm/slub.c                                     |  4 +-
 mm/vmstat.c                                   | 14 +++----
 net/smc/smc_ib.c                              |  2 +-
 scripts/checkpatch.pl                         |  8 ++++
 security/integrity/ima/ima_crypto.c           |  2 +-
 tools/testing/memblock/linux/mmzone.h         |  6 +--
 69 files changed, 208 insertions(+), 218 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation=
/admin-guide/kdump/vmcoreinfo.rst
index 8419019b6a88..c572b5230fe0 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -172,7 +172,7 @@ variables.
 Offset of the free_list's member. This value is used to compute the number
 of free pages.
=20
-Each zone has a free_area structure array called free_area[MAX_ORDER].
+Each zone has a free_area structure array called free_area[MAX_ORDER + 1].
 The free_list represents a linked list of free page blocks.
=20
 (list_head, next|prev)
@@ -189,7 +189,7 @@ Offsets of the vmap_area's members. They carry vmalloc-=
specific
 information. Makedumpfile gets the start address of the vmalloc region
 from this.
=20
-(zone.free_area, MAX_ORDER)
+(zone.free_area, MAX_ORDER + 1)
 ---------------------------
=20
 Free areas descriptor. User-space tools use this value to iterate the
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index db5de5f0b9d3..ff33971e1630 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -928,7 +928,7 @@
 			buddy allocator. Bigger value increase the probability
 			of catching random memory corruption, but reduce the
 			amount of memory for normal system use. The maximum
-			possible value is MAX_ORDER/2.  Setting this parameter
+			possible value is (MAX_ORDER + 1)/2.  Setting this parameter
 			to 1 or 2 should be enough to identify most random
 			memory corruption problems caused by bugs in kernel or
 			driver code when a CPU writes to (or reads from) a
@@ -3899,7 +3899,7 @@
 			[KNL] Minimal page reporting order
 			Format: <integer>
 			Adjust the minimal page reporting order. The page
-			reporting is disabled when it exceeds (MAX_ORDER-1).
+			reporting is disabled when it exceeds MAX_ORDER.
=20
 	panic=3D		[KNL] Kernel behaviour on panic: delay <timeout>
 			timeout > 0: seconds before rebooting
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index d9a13ccf89a3..ab6d701365bb 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -556,7 +556,7 @@ endmenu	 # "ARC Architecture Configuration"
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	default "12" if ARC_HUGEPAGE_16M
-	default "11"
+	default "11" if ARC_HUGEPAGE_16M
+	default "10"
=20
 source "kernel/power/Kconfig"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e6c8ee56ac52..c8f2e46cc8c4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1436,19 +1436,17 @@ config ARM_MODULE_PLTS
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	default "12" if SOC_AM33XX
-	default "9" if SA1111
-	default "11"
+	default "11" if SOC_AM33XX
+	default "8" if SA1111
+	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
=20
 config ALIGNMENT_TRAP
 	def_bool CPU_CP15_MMU
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6=
_v7_defconfig
index fb283059daa0..eeb14499479d 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -31,7 +31,7 @@ CONFIG_SOC_VF610=3Dy
 CONFIG_SMP=3Dy
 CONFIG_ARM_PSCI=3Dy
 CONFIG_HIGHMEM=3Dy
-CONFIG_ARCH_FORCE_MAX_ORDER=3D14
+CONFIG_ARCH_FORCE_MAX_ORDER=3D13
 CONFIG_CMDLINE=3D"noinitrd console=3Dttymxc0,115200"
 CONFIG_KEXEC=3Dy
 CONFIG_CPU_FREQ=3Dy
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/mi=
lbeaut_m10v_defconfig
index 8620061e19a8..22732f19e79b 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -26,7 +26,7 @@ CONFIG_THUMB2_KERNEL=3Dy
 # CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11 is not set
 # CONFIG_ARM_PATCH_IDIV is not set
 CONFIG_HIGHMEM=3Dy
-CONFIG_ARCH_FORCE_MAX_ORDER=3D12
+CONFIG_ARCH_FORCE_MAX_ORDER=3D11
 CONFIG_SECCOMP=3Dy
 CONFIG_KEXEC=3Dy
 CONFIG_EFI=3Dy
diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxnas_v=
6_defconfig
index 5c163a9d1429..7e43aa355467 100644
--- a/arch/arm/configs/oxnas_v6_defconfig
+++ b/arch/arm/configs/oxnas_v6_defconfig
@@ -12,7 +12,7 @@ CONFIG_ARCH_OXNAS=3Dy
 CONFIG_MACH_OX820=3Dy
 CONFIG_SMP=3Dy
 CONFIG_NR_CPUS=3D16
-CONFIG_ARCH_FORCE_MAX_ORDER=3D12
+CONFIG_ARCH_FORCE_MAX_ORDER=3D11
 CONFIG_SECCOMP=3Dy
 CONFIG_ARM_APPENDED_DTB=3Dy
 CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defc=
onfig
index 8b2cf6ddd568..c200de3947e3 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -19,7 +19,7 @@ CONFIG_ATMEL_CLOCKSOURCE_TCB=3Dy
 # CONFIG_CACHE_L2X0 is not set
 # CONFIG_ARM_PATCH_IDIV is not set
 # CONFIG_CPU_SW_DOMAIN_PAN is not set
-CONFIG_ARCH_FORCE_MAX_ORDER=3D15
+CONFIG_ARCH_FORCE_MAX_ORDER=3D14
 CONFIG_UACCESS_WITH_MEMCPY=3Dy
 # CONFIG_ATAGS is not set
 CONFIG_CMDLINE=3D"console=3DttyS0,115200 earlyprintk ignore_loglevel"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c6fcd8746f60..1afcfc9d2dc0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1403,25 +1403,23 @@ config XEN
=20
 config ARCH_FORCE_MAX_ORDER
 	int
-	default "14" if ARM64_64K_PAGES
-	default "12" if ARM64_16K_PAGES
-	default "11"
+	default "13" if ARM64_64K_PAGES
+	default "11" if ARM64_16K_PAGES
+	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
=20
 	  We make sure that we can allocate upto a HugePage size for each configu=
ration.
 	  Hence we have :
-		MAX_ORDER =3D (PMD_SHIFT - PAGE_SHIFT) + 1 =3D> PAGE_SHIFT - 2
+		MAX_ORDER =3D PMD_SHIFT - PAGE_SHIFT =3D PAGE_SHIFT - 3
=20
-	  However for 4K, we choose a higher default value, 11 as opposed to 10, =
giving us
+	  However for 4K, we choose a higher default value, 10 as opposed to 9, g=
iving us
 	  4M allocations matching the default size used by generic code.
=20
 config UNMAP_KERNEL_AT_EL0
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sp=
arsemem.h
index 4b73463423c3..5f5437621029 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -10,7 +10,7 @@
 /*
  * Section size must be at least 512MB for 64K base
  * page size config. Otherwise it will be less than
- * (MAX_ORDER - 1) and the build process will fail.
+ * MAX_ORDER and the build process will fail.
  */
 #ifdef CONFIG_ARM64_64K_PAGES
 #define SECTION_SIZE_BITS 29
diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/inc=
lude/nvhe/gfp.h
index 0a048dc06a7d..fe5472a184a3 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -16,7 +16,7 @@ struct hyp_pool {
 	 * API at EL2.
 	 */
 	hyp_spinlock_t lock;
-	struct list_head free_area[MAX_ORDER];
+	struct list_head free_area[MAX_ORDER + 1];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
 	unsigned short max_order;
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index adee6ab36862..a35fc882e97e 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -334,7 +334,7 @@ config HIGHMEM
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	default "11"
+	default "10"
=20
 config DRAM_BASE
 	hex "DRAM start addr (the same with memory-section in dts)"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index c6e06cdc738f..d85f6fbd0746 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -201,10 +201,10 @@ config IA64_CYCLONE
 	  If you're unsure, answer N.
=20
 config ARCH_FORCE_MAX_ORDER
-	int "MAX_ORDER (11 - 17)"  if !HUGETLB_PAGE
-	range 11 17  if !HUGETLB_PAGE
-	default "17" if HUGETLB_PAGE
-	default "11"
+	int "MAX_ORDER (10 - 16)"  if !HUGETLB_PAGE
+	range 10 16  if !HUGETLB_PAGE
+	default "16" if HUGETLB_PAGE
+	default "10"
=20
 config SMP
 	bool "Symmetric multi-processing support"
diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/spar=
semem.h
index 84e8ce387b69..04f03a56c166 100644
--- a/arch/ia64/include/asm/sparsemem.h
+++ b/arch/ia64/include/asm/sparsemem.h
@@ -12,9 +12,9 @@
 #define SECTION_SIZE_BITS	(30)
 #define MAX_PHYSMEM_BITS	(50)
 #ifdef CONFIG_ARCH_FORCE_MAX_ORDER
-#if ((CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
+#if ((CONFIG_ARCH_FORCE_MAX_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS)
 #undef SECTION_SIZE_BITS
-#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIFT)
+#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER + PAGE_SHIFT)
 #endif
 #endif
=20
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index f993cb36c062..87cc2e8908b4 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -185,7 +185,7 @@ static int __init hugetlb_setup_sz(char *str)
 	size =3D memparse(str, &str);
 	if (*str || !is_power_of_2(size) || !(tr_pages & size) ||
 		size <=3D PAGE_SIZE ||
-		size >=3D (1UL << PAGE_SHIFT << MAX_ORDER)) {
+		size > (1UL << PAGE_SHIFT << MAX_ORDER)) {
 		printk(KERN_WARNING "Invalid huge page size specified\n");
 		return 1;
 	}
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 3b2f39508524..d3832e1ca7df 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -402,22 +402,20 @@ config SINGLE_MEMORY_CHUNK
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order" if ADVANCED
 	depends on !SINGLE_MEMORY_CHUNK
-	default "11"
+	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
=20
 	  For systems that have holes in their physical address space this
 	  value also defines the minimal size of the hole that allows
 	  freeing unused memory map.
=20
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
-
 config 060_WRITETHROUGH
 	bool "Use write-through caching for 68060 supervisor accesses"
 	depends on ADVANCED && M68060
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 70d28976a40d..37116c811e60 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2142,24 +2142,22 @@ endchoice
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	range 14 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
-	default "14" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
-	range 13 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
-	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
-	range 12 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
-	default "12" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
-	range 0 64
-	default "11"
+	range 13 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
+	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
+	range 12 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
+	default "12" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
+	range 11 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
+	default "11" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
+	range 0 63
+	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
=20
 	  The page size is not necessarily 4KB.  Keep this in mind
 	  when choosing a value for this option.
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index a582f72104f3..0cccaf8b7fdf 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -46,18 +46,16 @@ source "kernel/Kconfig.hz"
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	range 9 20
-	default "11"
+	range 8 19
+	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
=20
 endmenu
=20
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 39d71d7701bd..d052cf27883e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -847,28 +847,26 @@ config DATA_SHIFT
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	range 8 9 if PPC64 && PPC_64K_PAGES
-	default "9" if PPC64 && PPC_64K_PAGES
-	range 13 13 if PPC64 && !PPC_64K_PAGES
-	default "13" if PPC64 && !PPC_64K_PAGES
-	range 9 64 if PPC32 && PPC_16K_PAGES
-	default "9" if PPC32 && PPC_16K_PAGES
-	range 7 64 if PPC32 && PPC_64K_PAGES
-	default "7" if PPC32 && PPC_64K_PAGES
-	range 5 64 if PPC32 && PPC_256K_PAGES
-	default "5" if PPC32 && PPC_256K_PAGES
-	range 11 64
-	default "11"
+	range 7 8 if PPC64 && PPC_64K_PAGES
+	default "8" if PPC64 && PPC_64K_PAGES
+	range 12 12 if PPC64 && !PPC_64K_PAGES
+	default "12" if PPC64 && !PPC_64K_PAGES
+	range 8 63 if PPC32 && PPC_16K_PAGES
+	default "8" if PPC32 && PPC_16K_PAGES
+	range 6 63 if PPC32 && PPC_64K_PAGES
+	default "6" if PPC32 && PPC_64K_PAGES
+	range 4 63 if PPC32 && PPC_256K_PAGES
+	default "4" if PPC32 && PPC_256K_PAGES
+	range 10 63
+	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
+	  increase this value. A value of 11 means that the largest free memory
+	  block is 2^10 pages.
=20
 	  The page size is not necessarily 4KB.  For example, on 64-bit
 	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.  Keep
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/co=
nfigs/85xx/ge_imp3a_defconfig
index e7672c186325..b8be8280a200 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -30,7 +30,7 @@ CONFIG_PREEMPT=3Dy
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=3Dm
 CONFIG_MATH_EMULATION=3Dy
-CONFIG_ARCH_FORCE_MAX_ORDER=3D17
+CONFIG_ARCH_FORCE_MAX_ORDER=3D16
 CONFIG_PCI=3Dy
 CONFIG_PCIEPORTBUS=3Dy
 CONFIG_PCI_MSI=3Dy
diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/confi=
gs/fsl-emb-nonhw.config
index ab8a8c4530d9..3009b0efaf34 100644
--- a/arch/powerpc/configs/fsl-emb-nonhw.config
+++ b/arch/powerpc/configs/fsl-emb-nonhw.config
@@ -41,7 +41,7 @@ CONFIG_FIXED_PHY=3Dy
 CONFIG_FONT_8x16=3Dy
 CONFIG_FONT_8x8=3Dy
 CONFIG_FONTS=3Dy
-CONFIG_ARCH_FORCE_MAX_ORDER=3D13
+CONFIG_ARCH_FORCE_MAX_ORDER=3D12
 CONFIG_FRAMEBUFFER_CONSOLE=3Dy
 CONFIG_FRAME_WARN=3D1024
 CONFIG_FTL=3Dy
diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s6=
4/iommu_api.c
index 7fcfba162e0d..81d7185e2ae8 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -97,7 +97,7 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsig=
ned long ua,
 	}
=20
 	mmap_read_lock(mm);
-	chunk =3D (1UL << (PAGE_SHIFT + MAX_ORDER - 1)) /
+	chunk =3D (1UL << (PAGE_SHIFT + MAX_ORDER)) /
 			sizeof(struct vm_area_struct *);
 	chunk =3D min(chunk, entries);
 	for (entry =3D 0; entry < entries; entry +=3D chunk) {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index bc84a594ca62..8d63934783dc 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -652,7 +652,7 @@ void __init gigantic_hugetlb_cma_reserve(void)
 		order =3D mmu_psize_to_shift(MMU_PAGE_16G) - PAGE_SHIFT;
=20
 	if (order) {
-		VM_WARN_ON(order < MAX_ORDER);
+		VM_WARN_ON(order <=3D MAX_ORDER);
 		hugetlb_cma_reserve(order);
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index 9de9b2fb163d..8e29a57924ef 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1740,7 +1740,7 @@ static long pnv_pci_ioda2_setup_default_config(struct=
 pnv_ioda_pe *pe)
 	 * DMA window can be larger than available memory, which will
 	 * cause errors later.
 	 */
-	const u64 maxblock =3D 1UL << (PAGE_SHIFT + MAX_ORDER - 1);
+	const u64 maxblock =3D 1UL << (PAGE_SHIFT + MAX_ORDER);
=20
 	/*
 	 * We create the default window as big as we can. The constraint is
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_=
defconfig
index b52e14ccb450..4d655e8d4d74 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7724=3Dy
-CONFIG_ARCH_FORCE_MAX_ORDER=3D12
+CONFIG_ARCH_FORCE_MAX_ORDER=3D11
 CONFIG_MEMORY_SIZE=3D0x10000000
 CONFIG_FLATMEM_MANUAL=3Dy
 CONFIG_SH_ECOVEC=3Dy
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 411fdc0901f7..e60e77c6edca 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -20,23 +20,21 @@ config PAGE_OFFSET
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	range 9 64 if PAGE_SIZE_16KB
-	default "9" if PAGE_SIZE_16KB
-	range 7 64 if PAGE_SIZE_64KB
-	default "7" if PAGE_SIZE_64KB
-	range 11 64
-	default "14" if !MMU
-	default "11"
+	range 8 63 if PAGE_SIZE_16KB
+	default "8" if PAGE_SIZE_16KB
+	range 6 63 if PAGE_SIZE_64KB
+	default "6" if PAGE_SIZE_64KB
+	range 10 63
+	default "13" if !MMU
+	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
=20
 	  The page size is not necessarily 4KB. Keep this in mind when
 	  choosing a value for this option.
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 4d3d1af90d52..099d0b31ea69 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -271,17 +271,15 @@ config ARCH_SPARSEMEM_DEFAULT
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	default "13"
+	default "12"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 13 means that the largest free memory block is 2^12 pages.
+	  increase this value. A value of 12 means that the largest free memory
+	  block is 2^12 pages.
=20
 if SPARC64
 source "kernel/power/Kconfig"
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 384480971805..7d91ca6aa675 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -193,7 +193,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, =
size_t size,
=20
 	size =3D IO_PAGE_ALIGN(size);
 	order =3D get_order(size);
-	if (unlikely(order >=3D MAX_ORDER))
+	if (unlikely(order > MAX_ORDER))
 		return NULL;
=20
 	npages =3D size >> IO_PAGE_SHIFT;
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 5b4de4a89dec..08ffd17d5ec3 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -897,7 +897,7 @@ void __init cheetah_ecache_flush_init(void)
=20
 	/* Now allocate error trap reporting scoreboard. */
 	sz =3D NR_CPUS * (2 * sizeof(struct cheetah_err_info));
-	for (order =3D 0; order < MAX_ORDER; order++) {
+	for (order =3D 0; order <=3D MAX_ORDER; order++) {
 		if ((PAGE_SIZE << order) >=3D sz)
 			break;
 	}
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index bcb0c5d2abc2..2d1d91718263 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -773,17 +773,15 @@ config HIGHMEM
=20
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	default "11"
+	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
 	  pages.  This option selects the largest power of two that the kernel
 	  keeps in the memory allocator.  If you need to allocate very large
 	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
=20
 endmenu
=20
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/reg=
map-debugfs.c
index 817eda2075aa..c491fabe3617 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -226,8 +226,8 @@ static ssize_t regmap_read_debugfs(struct regmap *map, =
unsigned int from,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
=20
-	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
-		count =3D PAGE_SIZE << (MAX_ORDER - 1);
+	if (count > (PAGE_SIZE << MAX_ORDER))
+		count =3D PAGE_SIZE << MAX_ORDER;
=20
 	buf =3D kmalloc(count, GFP_KERNEL);
 	if (!buf)
@@ -373,8 +373,8 @@ static ssize_t regmap_reg_ranges_read_file(struct file =
*file,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
=20
-	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
-		count =3D PAGE_SIZE << (MAX_ORDER - 1);
+	if (count > (PAGE_SIZE << MAX_ORDER))
+		count =3D PAGE_SIZE << MAX_ORDER;
=20
 	buf =3D kmalloc(count, GFP_KERNEL);
 	if (!buf)
diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 2b6f2281cfd6..f30cf96b0a41 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -70,11 +70,11 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(stru=
ct device *dev,
 			 HISI_ACC_SGL_ALIGN_SIZE);
=20
 	/*
-	 * the pool may allocate a block of memory of size PAGE_SIZE * 2^(MAX_ORD=
ER - 1),
+	 * the pool may allocate a block of memory of size PAGE_SIZE * 2^MAX_ORDE=
R,
 	 * block size may exceed 2^31 on ia64, so the max of block size is 2^31
 	 */
-	block_size =3D 1 << (PAGE_SHIFT + MAX_ORDER <=3D 32 ?
-			   PAGE_SHIFT + MAX_ORDER - 1 : 31);
+	block_size =3D 1 << (PAGE_SHIFT + MAX_ORDER <=3D 31 ?
+			   PAGE_SHIFT + MAX_ORDER : 31);
 	sgl_num_per_block =3D block_size / sgl_size;
 	block_num =3D count / sgl_num_per_block;
 	remain_sgl =3D count % sgl_num_per_block;
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/=
drm/i915/gem/selftests/huge_pages.c
index 72ce2c9f42fd..84498c7f845d 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -111,7 +111,7 @@ static int get_huge_pages(struct drm_i915_gem_object *o=
bj)
 		do {
 			struct page *page;
=20
-			GEM_BUG_ON(order >=3D MAX_ORDER);
+			GEM_BUG_ON(order > MAX_ORDER);
 			page =3D alloc_pages(GFP | __GFP_ZERO, order);
 			if (!page)
 				goto err;
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 21b61631f73a..85d19f425af6 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -64,11 +64,11 @@ module_param(page_pool_size, ulong, 0644);
=20
 static atomic_long_t allocated_pages;
=20
-static struct ttm_pool_type global_write_combined[MAX_ORDER];
-static struct ttm_pool_type global_uncached[MAX_ORDER];
+static struct ttm_pool_type global_write_combined[MAX_ORDER + 1];
+static struct ttm_pool_type global_uncached[MAX_ORDER + 1];
=20
-static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER];
-static struct ttm_pool_type global_dma32_uncached[MAX_ORDER];
+static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER + 1];
+static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
=20
 static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
@@ -382,7 +382,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt=
 *tt,
 	else
 		gfp_flags |=3D GFP_HIGHUSER;
=20
-	for (order =3D min_t(unsigned int, MAX_ORDER - 1, __fls(num_pages));
+	for (order =3D min_t(unsigned int, MAX_ORDER, __fls(num_pages));
 	     num_pages;
 	     order =3D min_t(unsigned int, order, __fls(num_pages))) {
 		bool apply_caching =3D false;
@@ -507,7 +507,7 @@ void ttm_pool_init(struct ttm_pool *pool, struct device=
 *dev,
=20
 	if (use_dma_alloc) {
 		for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i)
-			for (j =3D 0; j < MAX_ORDER; ++j)
+			for (j =3D 0; j <=3D MAX_ORDER; ++j)
 				ttm_pool_type_init(&pool->caching[i].orders[j],
 						   pool, i, j);
 	}
@@ -527,7 +527,7 @@ void ttm_pool_fini(struct ttm_pool *pool)
=20
 	if (pool->use_dma_alloc) {
 		for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i)
-			for (j =3D 0; j < MAX_ORDER; ++j)
+			for (j =3D 0; j <=3D MAX_ORDER; ++j)
 				ttm_pool_type_fini(&pool->caching[i].orders[j]);
 	}
=20
@@ -581,7 +581,7 @@ static void ttm_pool_debugfs_header(struct seq_file *m)
 	unsigned int i;
=20
 	seq_puts(m, "\t ");
-	for (i =3D 0; i < MAX_ORDER; ++i)
+	for (i =3D 0; i <=3D MAX_ORDER; ++i)
 		seq_printf(m, " ---%2u---", i);
 	seq_puts(m, "\n");
 }
@@ -592,7 +592,7 @@ static void ttm_pool_debugfs_orders(struct ttm_pool_typ=
e *pt,
 {
 	unsigned int i;
=20
-	for (i =3D 0; i < MAX_ORDER; ++i)
+	for (i =3D 0; i <=3D MAX_ORDER; ++i)
 		seq_printf(m, " %8u", ttm_pool_type_count(&pt[i]));
 	seq_puts(m, "\n");
 }
@@ -701,7 +701,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
=20
-	for (i =3D 0; i < MAX_ORDER; ++i) {
+	for (i =3D 0; i <=3D MAX_ORDER; ++i) {
 		ttm_pool_type_init(&global_write_combined[i], NULL,
 				   ttm_write_combined, i);
 		ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
@@ -734,7 +734,7 @@ void ttm_pool_mgr_fini(void)
 {
 	unsigned int i;
=20
-	for (i =3D 0; i < MAX_ORDER; ++i) {
+	for (i =3D 0; i <=3D MAX_ORDER; ++i) {
 		ttm_pool_type_fini(&global_write_combined[i]);
 		ttm_pool_type_fini(&global_uncached[i]);
=20
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.h
index cd48590ada30..c5ea361bf757 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -182,7 +182,7 @@
 #ifdef CONFIG_CMA_ALIGNMENT
 #define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
 #else
-#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_ORDER - 1)
+#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_ORDER)
 #endif
=20
 /*
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index 5ff09de6c48f..c867432919d8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2438,8 +2438,8 @@ static bool its_parse_indirect_baser(struct its_node =
*its,
 	 * feature is not supported by hardware.
 	 */
 	new_order =3D max_t(u32, get_order(esz << ids), new_order);
-	if (new_order >=3D MAX_ORDER) {
-		new_order =3D MAX_ORDER - 1;
+	if (new_order > MAX_ORDER) {
+		new_order =3D MAX_ORDER;
 		ids =3D ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
 		pr_warn("ITS@%pa: %s Table too large, reduce ids %llu->%u\n",
 			&its->phys_base, its_base_type_string[type],
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index acd6d6b47434..eee05abbc0be 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -407,7 +407,7 @@ static void __cache_size_refresh(void)
  * If the allocation may fail we use __get_free_pages. Memory fragmentation
  * won't have a fatal effect here, but it just causes flushes of some other
  * buffers and more I/O will be performed. Don't use __get_free_pages if it
- * always fails (i.e. order >=3D MAX_ORDER).
+ * always fails (i.e. order > MAX_ORDER).
  *
  * If the allocation shouldn't fail we use __vmalloc. This is only for the
  * initial reserve allocation, so there's no risk of wasting all vmalloc
diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_ut=
ils.c
index 1167463f26fb..361514cd575c 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -210,7 +210,7 @@ u32 genwqe_crc32(u8 *buff, size_t len, u32 init)
 void *__genwqe_alloc_consistent(struct genwqe_dev *cd, size_t size,
 			       dma_addr_t *dma_handle)
 {
-	if (get_order(size) >=3D MAX_ORDER)
+	if (get_order(size) > MAX_ORDER)
 		return NULL;
=20
 	return dma_alloc_coherent(&cd->pci_dev->dev, size, dma_handle,
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/=
ibmvnic.h
index e5c6ff3d0c47..608f9df67eb8 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -75,7 +75,7 @@
  * pool for the 4MB. Thus the 16 Rx and Tx queues require 32 * 5 =3D 160
  * plus 16 for the TSO pools for a total of 176 LTB mappings per VNIC.
  */
-#define IBMVNIC_ONE_LTB_MAX	((u32)((1 << (MAX_ORDER - 1)) * PAGE_SIZE))
+#define IBMVNIC_ONE_LTB_MAX	((u32)((1 << MAX_ORDER) * PAGE_SIZE))
 #define IBMVNIC_ONE_LTB_SIZE	min((u32)(8 << 20), IBMVNIC_ONE_LTB_MAX)
 #define IBMVNIC_LTB_SET_SIZE	(38 << 20)
=20
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_f=
b.c
index 886c564787f1..a852ab6c1f52 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -944,8 +944,8 @@ static phys_addr_t hvfb_get_phymem(struct hv_device *hd=
ev,
 	if (request_size =3D=3D 0)
 		return -1;
=20
-	if (order < MAX_ORDER) {
-		/* Call alloc_pages if the size is less than 2^MAX_ORDER */
+	if (order <=3D MAX_ORDER) {
+		/* Call alloc_pages if the size is no greater than 2^MAX_ORDER */
 		page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 		if (!page)
 			return -1;
@@ -975,7 +975,7 @@ static void hvfb_release_phymem(struct hv_device *hdev,
 {
 	unsigned int order =3D get_order(size);
=20
-	if (order < MAX_ORDER)
+	if (order <=3D MAX_ORDER)
 		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
 	else
 		dma_free_coherent(&hdev->device,
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 3f78a3a1eb75..5b15936a5214 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -33,7 +33,7 @@
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN =
| \
 					     __GFP_NOMEMALLOC)
 /* The order of free page blocks to report to host */
-#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
+#define VIRTIO_BALLOON_HINT_BLOCK_ORDER MAX_ORDER
 /* The size of a free page block in bytes */
 #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 0c2892ec6817..0e1253e3423a 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1120,13 +1120,13 @@ static void virtio_mem_clear_fake_offline(unsigned =
long pfn,
  */
 static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pag=
es)
 {
-	unsigned long order =3D MAX_ORDER - 1;
+	unsigned long order =3D MAX_ORDER;
 	unsigned long i;
=20
 	/*
 	 * We might get called for ranges that don't cover properly aligned
-	 * MAX_ORDER - 1 pages; however, we can only online properly aligned
-	 * pages with an order of MAX_ORDER - 1 at maximum.
+	 * MAX_ORDER pages; however, we can only online properly aligned
+	 * pages with an order of MAX_ORDER at maximum.
 	 */
 	while (!IS_ALIGNED(pfn | nr_pages, 1 << order))
 		order--;
@@ -1237,7 +1237,7 @@ static void virtio_mem_online_page(struct virtio_mem =
*vm,
 	bool do_online;
=20
 	/*
-	 * We can get called with any order up to MAX_ORDER - 1. If our
+	 * We can get called with any order up to MAX_ORDER. If our
 	 * subblock size is smaller than that and we have a mixture of plugged
 	 * and unplugged subblocks within such a page, we have to process in
 	 * smaller granularity. In that case we'll adjust the order exactly once
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index ba3525ccc27e..b3b7519a6519 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -70,7 +70,7 @@ int ramfs_nommu_expand_for_mapping(struct inode *inode, s=
ize_t newsize)
=20
 	/* make various checks */
 	order =3D get_order(newsize);
-	if (unlikely(order >=3D MAX_ORDER))
+	if (unlikely(order > MAX_ORDER))
 		return -EFBIG;
=20
 	ret =3D inode_newsize_ok(inode, newsize);
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index ef09b23d29e3..8ce14f9d202a 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -72,7 +72,7 @@ struct ttm_pool {
 	bool use_dma32;
=20
 	struct {
-		struct ttm_pool_type orders[MAX_ORDER];
+		struct ttm_pool_type orders[MAX_ORDER + 1];
 	} caching[TTM_NUM_CACHING_TYPES];
 };
=20
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3ec981a0d8b3..68485a264865 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -746,7 +746,7 @@ static inline unsigned huge_page_shift(struct hstate *h)
=20
 static inline bool hstate_is_gigantic(struct hstate *h)
 {
-	return huge_page_order(h) >=3D MAX_ORDER;
+	return huge_page_order(h) > MAX_ORDER;
 }
=20
 static inline unsigned int pages_per_huge_page(const struct hstate *h)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ca285ed3c6e0..e93faa3d7f1d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -25,11 +25,11 @@
=20
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
-#define MAX_ORDER 11
+#define MAX_ORDER 10
 #else
 #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
 #endif
-#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
+#define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
=20
 /*
  * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
@@ -92,7 +92,7 @@ static inline bool migratetype_is_mergeable(int mt)
 }
=20
 #define for_each_migratetype_order(order, type) \
-	for (order =3D 0; order < MAX_ORDER; order++) \
+	for (order =3D 0; order <=3D MAX_ORDER; order++) \
 		for (type =3D 0; type < MIGRATE_TYPES; type++)
=20
 extern int page_group_by_mobility_disabled;
@@ -632,7 +632,7 @@ struct zone {
 	ZONE_PADDING(_pad1_)
=20
 	/* free areas of different sizes */
-	struct free_area	free_area[MAX_ORDER];
+	struct free_area	free_area[MAX_ORDER + 1];
=20
 	/* zone flags, see below */
 	unsigned long		flags;
@@ -1379,7 +1379,7 @@ static inline bool movable_only_nodes(nodemask_t *nod=
es)
 #define SECTION_BLOCKFLAGS_BITS \
 	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
=20
-#if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
+#if (MAX_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
=20
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flag=
s.h
index 83c7248053a1..940efcffd374 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -41,14 +41,14 @@ extern unsigned int pageblock_order;
  * Huge pages are a constant size, but don't exceed the maximum allocation
  * granularity.
  */
-#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_ORDER=
 - 1)
+#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_ORDER)
=20
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
=20
 #else /* CONFIG_HUGETLB_PAGE */
=20
 /* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
-#define pageblock_order		(MAX_ORDER-1)
+#define pageblock_order		MAX_ORDER
=20
 #endif /* CONFIG_HUGETLB_PAGE */
=20
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..568b5dfb3bd9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -251,8 +251,8 @@ static inline unsigned int arch_slab_minalign(void)
  * to do various tricks to work around compiler limitations in order to
  * ensure proper constant folding.
  */
-#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT - 1) <=3D 25 ? \
-				(MAX_ORDER + PAGE_SHIFT - 1) : 25)
+#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT) <=3D 25 ? \
+				(MAX_ORDER + PAGE_SHIFT) : 25)
 #define KMALLOC_SHIFT_MAX	KMALLOC_SHIFT_HIGH
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	5
@@ -265,7 +265,7 @@ static inline unsigned int arch_slab_minalign(void)
  * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
  */
 #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
+#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
@@ -278,7 +278,7 @@ static inline unsigned int arch_slab_minalign(void)
  * be allocated from the same page.
  */
 #define KMALLOC_SHIFT_HIGH	PAGE_SHIFT
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
+#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a0eb4d5cf557..245e2ee20718 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -471,7 +471,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_OFFSET(list_head, prev);
 	VMCOREINFO_OFFSET(vmap_area, va_start);
 	VMCOREINFO_OFFSET(vmap_area, list);
-	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER);
+	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
 	log_buf_vmcoreinfo_setup();
 	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 1bf6de398986..e20f168a34c7 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -84,8 +84,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size=
_t pool_size,
 	void *addr;
 	int ret =3D -ENOMEM;
=20
-	/* Cannot allocate larger than MAX_ORDER-1 */
-	order =3D min(get_order(pool_size), MAX_ORDER-1);
+	/* Cannot allocate larger than MAX_ORDER */
+	order =3D min(get_order(pool_size), MAX_ORDER);
=20
 	do {
 		pool_size =3D 1 << (PAGE_SHIFT + order);
@@ -190,7 +190,7 @@ static int __init dma_atomic_pool_init(void)
=20
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
-	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
+	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER.
 	 */
 	if (!atomic_pool_size) {
 		unsigned long pages =3D totalram_pages() / (SZ_1G / SZ_128K);
diff --git a/mm/Kconfig b/mm/Kconfig
index 0331f1461f81..bbe31e85afee 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -307,7 +307,7 @@ config SHUFFLE_PAGE_ALLOCATOR
 	  the presence of a memory-side-cache. There are also incidental
 	  security benefits as it reduces the predictability of page
 	  allocations to compliment SLAB_FREELIST_RANDOM, but the
-	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
+	  default granularity of shuffling on the "MAX_ORDER" i.e,
 	  10th order of pages is selected based on cache utilization
 	  benefits on x86.
=20
@@ -621,8 +621,8 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 	  HUGETLB_PAGE_ORDER when there are multiple HugeTLB page sizes available
 	  on a platform.
=20
-	  Note that the pageblock_order cannot exceed MAX_ORDER - 1 and will be
-	  clamped down to MAX_ORDER - 1.
+	  Note that the pageblock_order cannot exceed MAX_ORDER and will be
+	  clamped down to MAX_ORDER.
=20
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
diff --git a/mm/compaction.c b/mm/compaction.c
index 640fa76228dd..4a282c658ac4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -586,7 +586,7 @@ static unsigned long isolate_freepages_block(struct com=
pact_control *cc,
 		if (PageCompound(page)) {
 			const unsigned int order =3D compound_order(page);
=20
-			if (likely(order < MAX_ORDER)) {
+			if (likely(order <=3D MAX_ORDER)) {
 				blockpfn +=3D (1UL << order) - 1;
 				cursor +=3D (1UL << order) - 1;
 			}
@@ -941,7 +941,7 @@ isolate_migratepages_block(struct compact_control *cc, =
unsigned long low_pfn,
 			 * a valid page order. Consider only values in the
 			 * valid order range to prevent low_pfn overflow.
 			 */
-			if (freepage_order > 0 && freepage_order < MAX_ORDER)
+			if (freepage_order > 0 && freepage_order <=3D MAX_ORDER)
 				low_pfn +=3D (1UL << freepage_order) - 1;
 			continue;
 		}
@@ -957,7 +957,7 @@ isolate_migratepages_block(struct compact_control *cc, =
unsigned long low_pfn,
 		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order =3D compound_order(page);
=20
-			if (likely(order < MAX_ORDER))
+			if (likely(order <=3D MAX_ORDER))
 				low_pfn +=3D (1UL << order) - 1;
 			goto isolate_fail;
 		}
@@ -2118,7 +2118,7 @@ static enum compact_result __compact_finished(struct =
compact_control *cc)
=20
 	/* Direct compactor: Is a suitable page free? */
 	ret =3D COMPACT_NO_SUITABLE_PAGE;
-	for (order =3D cc->order; order < MAX_ORDER; order++) {
+	for (order =3D cc->order; order <=3D MAX_ORDER; order++) {
 		struct free_area *area =3D &cc->zone->free_area[order];
 		bool can_steal;
=20
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index dc7df1254f0a..7e53c4a42047 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1094,7 +1094,7 @@ debug_vm_pgtable_alloc_huge_page(struct pgtable_debug=
_args *args, int order)
 	struct page *page =3D NULL;
=20
 #ifdef CONFIG_CONTIG_ALLOC
-	if (order >=3D MAX_ORDER) {
+	if (order > MAX_ORDER) {
 		page =3D alloc_contig_pages((1 << order), GFP_KERNEL,
 					  first_online_node, NULL);
 		if (page) {
@@ -1104,7 +1104,7 @@ debug_vm_pgtable_alloc_huge_page(struct pgtable_debug=
_args *args, int order)
 	}
 #endif
=20
-	if (order < MAX_ORDER)
+	if (order <=3D MAX_ORDER)
 		page =3D alloc_pages(GFP_KERNEL, order);
=20
 	return page;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3222b40a0f6d..9b1655950049 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -469,7 +469,7 @@ static int __init hugepage_init(void)
 	/*
 	 * hugepages can't be allocated by the buddy allocator
 	 */
-	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >=3D MAX_ORDER);
+	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER > MAX_ORDER);
 	/*
 	 * we use page->mapping and page->index in second tail page
 	 * as list_head: assuming THP order >=3D 2
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 28516881a1b2..15ff582687a3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1903,7 +1903,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)
 	pgoff_t index =3D page_index(page_head);
 	unsigned long compound_idx;
=20
-	if (compound_order(page_head) >=3D MAX_ORDER)
+	if (compound_order(page_head) > MAX_ORDER)
 		compound_idx =3D page_to_pfn(page) - page_to_pfn(page_head);
 	else
 		compound_idx =3D page - page_head;
@@ -4313,7 +4313,7 @@ static int __init default_hugepagesz_setup(char *s)
 	 * The number of default huge pages (for this size) could have been
 	 * specified as the first hugetlb parameter: hugepages=3DX.  If so,
 	 * then default_hstate_max_huge_pages is set.  If the default huge
-	 * page size is gigantic (>=3D MAX_ORDER), then the pages must be
+	 * page size is gigantic (> MAX_ORDER), then the pages must be
 	 * allocated here from bootmem allocator.
 	 */
 	if (default_hstate_max_huge_pages) {
diff --git a/mm/memblock.c b/mm/memblock.c
index b5d3026979fc..d1525463c05e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2030,7 +2030,7 @@ static void __init __free_pages_memory(unsigned long =
start, unsigned long end)
 	int order;
=20
 	while (start < end) {
-		order =3D min(MAX_ORDER - 1UL, __ffs(start));
+		order =3D min_t(unsigned long, MAX_ORDER, __ffs(start));
=20
 		while (start + (1UL << order) > end)
 			order--;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fad6d1f2262a..5540499007ae 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -596,7 +596,7 @@ static void online_pages_range(unsigned long start_pfn,=
 unsigned long nr_pages)
 	unsigned long pfn;
=20
 	/*
-	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
+	 * Online the pages in MAX_ORDER aligned chunks. The callback might
 	 * decide to not expose all pages to the buddy (e.g., expose them
 	 * later). We account all pages as being online and belonging to this
 	 * zone ("present").
@@ -605,7 +605,7 @@ static void online_pages_range(unsigned long start_pfn,=
 unsigned long nr_pages)
 	 * this and the first chunk to online will be pageblock_nr_pages.
 	 */
 	for (pfn =3D start_pfn; pfn < end_pfn;) {
-		int order =3D min(MAX_ORDER - 1UL, __ffs(pfn));
+		int order =3D min_t(unsigned long, MAX_ORDER, __ffs(pfn));
=20
 		(*online_page_callback)(pfn_to_page(pfn), order);
 		pfn +=3D (1UL << order);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7e030d7cac81..07ad8074950f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -847,7 +847,7 @@ static int __init debug_guardpage_minorder_setup(char *=
buf)
 {
 	unsigned long res;
=20
-	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
+	if (kstrtoul(buf, 10, &res) < 0 ||  res > (MAX_ORDER + 1) / 2) {
 		pr_err("Bad debug_guardpage_minorder value\n");
 		return 0;
 	}
@@ -1065,7 +1065,7 @@ buddy_merge_likely(unsigned long pfn, unsigned long b=
uddy_pfn,
 	unsigned long higher_page_pfn;
 	struct page *higher_page;
=20
-	if (order >=3D MAX_ORDER - 2)
+	if (order >=3D MAX_ORDER - 1)
 		return false;
=20
 	higher_page_pfn =3D buddy_pfn & pfn;
@@ -1120,7 +1120,7 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
=20
-	while (order < MAX_ORDER - 1) {
+	while (order < MAX_ORDER) {
 		if (compaction_capture(capc, page, order, migratetype)) {
 			__mod_zone_freepage_state(zone, -(1 << order),
 								migratetype);
@@ -2559,7 +2559,7 @@ struct page *__rmqueue_smallest(struct zone *zone, un=
signed int order,
 	struct page *page;
=20
 	/* Find a page of the appropriate size in the preferred list */
-	for (current_order =3D order; current_order < MAX_ORDER; ++current_order)=
 {
+	for (current_order =3D order; current_order <=3D MAX_ORDER; ++current_ord=
er) {
 		area =3D &(zone->free_area[current_order]);
 		page =3D get_page_from_free_area(area, migratetype);
 		if (!page)
@@ -2934,7 +2934,7 @@ static bool unreserve_highatomic_pageblock(const stru=
ct alloc_context *ac,
 			continue;
=20
 		spin_lock_irqsave(&zone->lock, flags);
-		for (order =3D 0; order < MAX_ORDER; order++) {
+		for (order =3D 0; order <=3D MAX_ORDER; order++) {
 			struct free_area *area =3D &(zone->free_area[order]);
=20
 			page =3D get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
@@ -3018,7 +3018,7 @@ __rmqueue_fallback(struct zone *zone, int order, int =
start_migratetype,
 	 * approximates finding the pageblock with the most free pages, which
 	 * would be too costly to do exactly.
 	 */
-	for (current_order =3D MAX_ORDER - 1; current_order >=3D min_order;
+	for (current_order =3D MAX_ORDER; current_order >=3D min_order;
 				--current_order) {
 		area =3D &(zone->free_area[current_order]);
 		fallback_mt =3D find_suitable_fallback(area, current_order,
@@ -3044,7 +3044,7 @@ __rmqueue_fallback(struct zone *zone, int order, int =
start_migratetype,
 	return false;
=20
 find_smallest:
-	for (current_order =3D order; current_order < MAX_ORDER;
+	for (current_order =3D order; current_order <=3D MAX_ORDER;
 							current_order++) {
 		area =3D &(zone->free_area[current_order]);
 		fallback_mt =3D find_suitable_fallback(area, current_order,
@@ -3057,7 +3057,7 @@ __rmqueue_fallback(struct zone *zone, int order, int =
start_migratetype,
 	 * This should not happen - we already found a suitable fallback
 	 * when looking for the largest page.
 	 */
-	VM_BUG_ON(current_order =3D=3D MAX_ORDER);
+	VM_BUG_ON(current_order =3D=3D MAX_ORDER + 1);
=20
 do_steal:
 	page =3D get_page_from_free_area(area, fallback_mt);
@@ -4005,7 +4005,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int=
 order, unsigned long mark,
 		return true;
=20
 	/* For a high-order request, check at least one suitable page is free */
-	for (o =3D order; o < MAX_ORDER; o++) {
+	for (o =3D order; o <=3D MAX_ORDER; o++) {
 		struct free_area *area =3D &z->free_area[o];
 		int mt;
=20
@@ -5480,7 +5480,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int or=
der, int preferred_nid,
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.
 	 */
-	if (WARN_ON_ONCE_GFP(order >=3D MAX_ORDER, gfp))
+	if (WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp))
 		return NULL;
=20
 	gfp &=3D gfp_allowed_mask;
@@ -6183,8 +6183,8 @@ void show_free_areas(unsigned int filter, nodemask_t =
*nodemask)
=20
 	for_each_populated_zone(zone) {
 		unsigned int order;
-		unsigned long nr[MAX_ORDER], flags, total =3D 0;
-		unsigned char types[MAX_ORDER];
+		unsigned long nr[MAX_ORDER + 1], flags, total =3D 0;
+		unsigned char types[MAX_ORDER + 1];
=20
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
@@ -6192,7 +6192,7 @@ void show_free_areas(unsigned int filter, nodemask_t =
*nodemask)
 		printk(KERN_CONT "%s: ", zone->name);
=20
 		spin_lock_irqsave(&zone->lock, flags);
-		for (order =3D 0; order < MAX_ORDER; order++) {
+		for (order =3D 0; order <=3D MAX_ORDER; order++) {
 			struct free_area *area =3D &zone->free_area[order];
 			int type;
=20
@@ -6206,7 +6206,7 @@ void show_free_areas(unsigned int filter, nodemask_t =
*nodemask)
 			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
-		for (order =3D 0; order < MAX_ORDER; order++) {
+		for (order =3D 0; order <=3D MAX_ORDER; order++) {
 			printk(KERN_CONT "%lu*%lukB ",
 			       nr[order], K(1UL) << order);
 			if (nr[order])
@@ -7545,7 +7545,7 @@ static inline void setup_usemap(struct zone *zone) {}
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
 void __init set_pageblock_order(void)
 {
-	unsigned int order =3D MAX_ORDER - 1;
+	unsigned int order =3D MAX_ORDER;
=20
 	/* Check that pageblock_nr_pages has not already been setup */
 	if (pageblock_order)
@@ -9051,7 +9051,7 @@ void *__init alloc_large_system_hash(const char *tabl=
ename,
 			else
 				table =3D memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
-		} else if (get_order(size) >=3D MAX_ORDER || hashdist) {
+		} else if (get_order(size) > MAX_ORDER || hashdist) {
 			table =3D vmalloc_huge(size, gfp_flags);
 			virt =3D true;
 			if (table)
@@ -9265,7 +9265,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 	order =3D 0;
 	outer_start =3D start;
 	while (!PageBuddy(pfn_to_page(outer_start))) {
-		if (++order >=3D MAX_ORDER) {
+		if (++order > MAX_ORDER) {
 			outer_start =3D start;
 			break;
 		}
@@ -9524,7 +9524,7 @@ bool is_free_buddy_page(struct page *page)
 	unsigned long pfn =3D page_to_pfn(page);
 	unsigned int order;
=20
-	for (order =3D 0; order < MAX_ORDER; order++) {
+	for (order =3D 0; order <=3D MAX_ORDER; order++) {
 		struct page *page_head =3D page - (pfn & ((1 << order) - 1));
=20
 		if (PageBuddy(page_head) &&
@@ -9532,7 +9532,7 @@ bool is_free_buddy_page(struct page *page)
 			break;
 	}
=20
-	return order < MAX_ORDER;
+	return order <=3D MAX_ORDER;
 }
 EXPORT_SYMBOL(is_free_buddy_page);
=20
@@ -9583,7 +9583,7 @@ bool take_page_off_buddy(struct page *page)
 	bool ret =3D false;
=20
 	spin_lock_irqsave(&zone->lock, flags);
-	for (order =3D 0; order < MAX_ORDER; order++) {
+	for (order =3D 0; order <=3D MAX_ORDER; order++) {
 		struct page *page_head =3D page - (pfn & ((1 << order) - 1));
 		int page_order =3D buddy_order(page_head);
=20
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 9d73dc38e3d7..8d33120a81b2 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -226,7 +226,7 @@ static void unset_migratetype_isolate(struct page *page=
, int migratetype)
 	 */
 	if (PageBuddy(page)) {
 		order =3D buddy_order(page);
-		if (order >=3D pageblock_order && order < MAX_ORDER - 1) {
+		if (order >=3D pageblock_order && order <=3D MAX_ORDER) {
 			buddy =3D find_buddy_page_pfn(page, page_to_pfn(page),
 						    order, NULL);
 			if (buddy && !is_migrate_isolate_page(buddy)) {
@@ -289,11 +289,11 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * @skip_isolation:	the flag to skip the pageblock isolation in second
  *			isolate_single_pageblock()
  *
- * Free and in-use pages can be as big as MAX_ORDER-1 and contain more tha=
n one
+ * Free and in-use pages can be as big as MAX_ORDER and contain more than =
one
  * pageblock. When not all pageblocks within a page are isolated at the sa=
me
  * time, free page accounting can go wrong. For example, in the case of
- * MAX_ORDER-1 =3D pageblock_order + 1, a MAX_ORDER-1 page has two pagelbo=
cks.
- * [         MAX_ORDER-1         ]
+ * MAX_ORDER =3D pageblock_order + 1, a MAX_ORDER page has two pagelbocks.
+ * [         MAX_ORDER           ]
  * [  pageblock0  |  pageblock1  ]
  * When either pageblock is isolated, if it is a free page, the page is not
  * split into separate migratetype lists, which is supposed to; if it is an
@@ -450,7 +450,7 @@ static int isolate_single_pageblock(unsigned long bound=
ary_pfn, int flags,
 				 * the free page to the right migratetype list.
 				 *
 				 * head_pfn is not used here as a hugetlb page order
-				 * can be bigger than MAX_ORDER-1, but after it is
+				 * can be bigger than MAX_ORDER, but after it is
 				 * freed, the free page order is not. Use pfn within
 				 * the range to find the head of the free page.
 				 */
@@ -458,7 +458,7 @@ static int isolate_single_pageblock(unsigned long bound=
ary_pfn, int flags,
 				outer_pfn =3D pfn;
 				while (!PageBuddy(pfn_to_page(outer_pfn))) {
 					/* stop if we cannot find the free page */
-					if (++order >=3D MAX_ORDER)
+					if (++order > MAX_ORDER)
 						goto failed;
 					outer_pfn &=3D ~0UL << order;
 				}
@@ -639,7 +639,7 @@ int test_pages_isolated(unsigned long start_pfn, unsign=
ed long end_pfn,
 	int ret;
=20
 	/*
-	 * Note: pageblock_nr_pages !=3D MAX_ORDER. Then, chunks of free pages
+	 * Note: pageblock_order !=3D MAX_ORDER. Then, chunks of free pages
 	 * are not aligned to pageblock_nr_pages.
 	 * Then we just check migratetype first.
 	 */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 223bbf8674ec..80cf367362c3 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -318,7 +318,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file =
*m,
 				unsigned long freepage_order;
=20
 				freepage_order =3D buddy_order_unsafe(page);
-				if (freepage_order < MAX_ORDER)
+				if (freepage_order <=3D MAX_ORDER)
 					pfn +=3D (1UL << freepage_order) - 1;
 				continue;
 			}
@@ -552,7 +552,7 @@ read_page_owner(struct file *file, char __user *buf, si=
ze_t count, loff_t *ppos)
 		if (PageBuddy(page)) {
 			unsigned long freepage_order =3D buddy_order_unsafe(page);
=20
-			if (freepage_order < MAX_ORDER)
+			if (freepage_order <=3D MAX_ORDER)
 				pfn +=3D (1UL << freepage_order) - 1;
 			continue;
 		}
@@ -645,7 +645,7 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct=
 zone *zone)
 			if (PageBuddy(page)) {
 				unsigned long order =3D buddy_order_unsafe(page);
=20
-				if (order > 0 && order < MAX_ORDER)
+				if (order > 0 && order <=3D MAX_ORDER)
 					pfn +=3D (1UL << order) - 1;
 				continue;
 			}
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 382958eef8a9..d52a55bca6d5 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -11,7 +11,7 @@
 #include "page_reporting.h"
 #include "internal.h"
=20
-unsigned int page_reporting_order =3D MAX_ORDER;
+unsigned int page_reporting_order =3D MAX_ORDER + 1;
 module_param(page_reporting_order, uint, 0644);
 MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
=20
@@ -244,7 +244,7 @@ page_reporting_process_zone(struct page_reporting_dev_i=
nfo *prdev,
 		return err;
=20
 	/* Process each free list starting from lowest order/mt */
-	for (order =3D page_reporting_order; order < MAX_ORDER; order++) {
+	for (order =3D page_reporting_order; order <=3D MAX_ORDER; order++) {
 		for (mt =3D 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
diff --git a/mm/shuffle.h b/mm/shuffle.h
index cec62984f7d3..a6bdf54f96f1 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -4,7 +4,7 @@
 #define _MM_SHUFFLE_H
 #include <linux/jump_label.h>
=20
-#define SHUFFLE_ORDER (MAX_ORDER-1)
+#define SHUFFLE_ORDER MAX_ORDER
=20
 #ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
 DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
diff --git a/mm/slab.c b/mm/slab.c
index 10e96137b44f..530f418a4930 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -466,7 +466,7 @@ static int __init slab_max_order_setup(char *str)
 {
 	get_option(&str, &slab_max_order);
 	slab_max_order =3D slab_max_order < 0 ? 0 :
-				min(slab_max_order, MAX_ORDER - 1);
+				min(slab_max_order, MAX_ORDER);
 	slab_max_order_set =3D true;
=20
 	return 1;
diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..5acf5407cbc6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3877,7 +3877,7 @@ static inline int calculate_order(unsigned int size)
 	 * Doh this slab cannot be placed using slub_max_order.
 	 */
 	order =3D calc_slab_order(size, 1, MAX_ORDER, 1);
-	if (order < MAX_ORDER)
+	if (order <=3D MAX_ORDER)
 		return order;
 	return -ENOSYS;
 }
@@ -4388,7 +4388,7 @@ __setup("slub_min_order=3D", setup_slub_min_order);
 static int __init setup_slub_max_order(char *str)
 {
 	get_option(&str, (int *)&slub_max_order);
-	slub_max_order =3D min(slub_max_order, (unsigned int)MAX_ORDER - 1);
+	slub_max_order =3D min_t(unsigned int, slub_max_order, MAX_ORDER);
=20
 	return 1;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8572f5..9fc206477fb7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1068,7 +1068,7 @@ static void fill_contig_page_info(struct zone *zone,
 	info->free_blocks_total =3D 0;
 	info->free_blocks_suitable =3D 0;
=20
-	for (order =3D 0; order < MAX_ORDER; order++) {
+	for (order =3D 0; order <=3D MAX_ORDER; order++) {
 		unsigned long blocks;
=20
 		/*
@@ -1101,7 +1101,7 @@ static int __fragmentation_index(unsigned int order, =
struct contig_page_info *in
 {
 	unsigned long requested =3D 1UL << order;
=20
-	if (WARN_ON_ONCE(order >=3D MAX_ORDER))
+	if (WARN_ON_ONCE(order > MAX_ORDER))
 		return 0;
=20
 	if (!info->free_blocks_total)
@@ -1474,7 +1474,7 @@ static void frag_show_print(struct seq_file *m, pg_da=
ta_t *pgdat,
 	int order;
=20
 	seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-	for (order =3D 0; order < MAX_ORDER; ++order)
+	for (order =3D 0; order <=3D MAX_ORDER; ++order)
 		/*
 		 * Access to nr_free is lockless as nr_free is used only for
 		 * printing purposes. Use data_race to avoid KCSAN warning.
@@ -1503,7 +1503,7 @@ static void pagetypeinfo_showfree_print(struct seq_fi=
le *m,
 					pgdat->node_id,
 					zone->name,
 					migratetype_names[mtype]);
-		for (order =3D 0; order < MAX_ORDER; ++order) {
+		for (order =3D 0; order <=3D MAX_ORDER; ++order) {
 			unsigned long freecount =3D 0;
 			struct free_area *area;
 			struct list_head *curr;
@@ -1543,7 +1543,7 @@ static void pagetypeinfo_showfree(struct seq_file *m,=
 void *arg)
=20
 	/* Print header */
 	seq_printf(m, "%-43s ", "Free pages count per migrate type at order");
-	for (order =3D 0; order < MAX_ORDER; ++order)
+	for (order =3D 0; order <=3D MAX_ORDER; ++order)
 		seq_printf(m, "%6d ", order);
 	seq_putc(m, '\n');
=20
@@ -2168,7 +2168,7 @@ static void unusable_show_print(struct seq_file *m,
 	seq_printf(m, "Node %d, zone %8s ",
 				pgdat->node_id,
 				zone->name);
-	for (order =3D 0; order < MAX_ORDER; ++order) {
+	for (order =3D 0; order <=3D MAX_ORDER; ++order) {
 		fill_contig_page_info(zone, order, &info);
 		index =3D unusable_free_index(order, &info);
 		seq_printf(m, "%d.%03d ", index / 1000, index % 1000);
@@ -2220,7 +2220,7 @@ static void extfrag_show_print(struct seq_file *m,
 	seq_printf(m, "Node %d, zone %8s ",
 				pgdat->node_id,
 				zone->name);
-	for (order =3D 0; order < MAX_ORDER; ++order) {
+	for (order =3D 0; order <=3D MAX_ORDER; ++order) {
 		fill_contig_page_info(zone, order, &info);
 		index =3D __fragmentation_index(order, &info);
 		seq_printf(m, "%2d.%03d ", index / 1000, index % 1000);
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 854772dd52fd..9b66d6aeeb1a 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -843,7 +843,7 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *smcib=
dev)
 		goto out;
 	/* the calculated number of cq entries fits to mlx5 cq allocation */
 	cqe_size_order =3D cache_line_size() =3D=3D 128 ? 7 : 6;
-	smc_order =3D MAX_ORDER - cqe_size_order - 1;
+	smc_order =3D MAX_ORDER - cqe_size_order;
 	if (SMC_MAX_CQE + 2 > (0x00000001 << smc_order) * PAGE_SIZE)
 		cqattr.cqe =3D (0x00000001 << smc_order) * PAGE_SIZE - 2;
 	smcibdev->roce_cq_send =3D ib_create_cq(smcibdev->ibdev,
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..e736847ef3ac 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7368,6 +7368,14 @@ sub process {
 			}
 		}
=20
+# check for MAX_ORDER uses as its semantics has changed.
+# MAX_ORDER now really means the max order of a page that can come out of
+# kernel buddy allocator
+        if ($line =3D~ /MAX_ORDER/) {
+            WARN("MAX_ORDER",
+                 "MAX_ORDER has changed its semantics. The max order of a =
page that can be allocated from buddy allocator is MAX_ORDER instead of MAX=
_ORDER - 1.")
+        }
+
 # Mode permission misuses where it seems decimal should be octal
 # This uses a shortcut match to avoid unnecessary uses of a slow foreach l=
oop
 # o Ignore module_param*(...) uses with a decimal 0 permission as that has=
 a
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/i=
ma_crypto.c
index 64499056648a..51ad29940f05 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -38,7 +38,7 @@ static int param_set_bufsize(const char *val, const struc=
t kernel_param *kp)
=20
 	size =3D memparse(val, NULL);
 	order =3D get_order(size);
-	if (order >=3D MAX_ORDER)
+	if (order > MAX_ORDER)
 		return -EINVAL;
 	ima_maxorder =3D order;
 	ima_bufsize =3D PAGE_SIZE << order;
diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblock=
/linux/mmzone.h
index 7c2eb5c9bb54..d79748b263e7 100644
--- a/tools/testing/memblock/linux/mmzone.h
+++ b/tools/testing/memblock/linux/mmzone.h
@@ -17,10 +17,10 @@ enum zone_type {
 };
=20
 #define MAX_NR_ZONES __MAX_NR_ZONES
-#define MAX_ORDER 11
-#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
+#define MAX_ORDER 10
+#define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
=20
-#define pageblock_order		(MAX_ORDER - 1)
+#define pageblock_order		MAX_ORDER
 #define pageblock_nr_pages	BIT(pageblock_order)
=20
 struct zone {
--=20
2.35.1

