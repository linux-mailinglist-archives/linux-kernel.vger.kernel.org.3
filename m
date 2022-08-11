Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D919D59090E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiHKXQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHKXQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:48 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A9A024C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E5035C004F;
        Thu, 11 Aug 2022 19:16:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 11 Aug 2022 19:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259806; x=
        1660346206; bh=1iLo5zKcUaFVcj26pwobGK4S6KcUcul00ec8KXKkfvE=; b=I
        LfFZ7EK8wNAD6rgcb9Em1maoqbdivA0EFJX6GFXH667iTwmNcK2WjlYTLlUYKpWt
        RbAeVk//2Aj2ANVrzYwNyJz48qklTFNZBQ7RnxGQow6Ei724RZtAoI8sjlJ1wSDc
        FzIKJ8kGKjn0rHBfipvWrxo6xi5B/03CbsxdaNJfwS3saBum+K9IWcjyC2RM5UvB
        TVo6lPuuMfYRBavwMi2LQPvnYNArwCLSmR7PUp9qhHVtN1wzmND/rFFrcXH0tkaO
        1s0oqWtrh2LduSgaoqEoEK1WEmcXaEP7zoALmh0x6r4HrrTAunjRMP9BgBeSYNTN
        FU4SoetDn+E/5iYfA079Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259806; x=1660346206; bh=1
        iLo5zKcUaFVcj26pwobGK4S6KcUcul00ec8KXKkfvE=; b=rDnRDXgdmH2ZrihjB
        9dIuR8vN0BEwvcUHNcMXNGIvK8MfPbkqen4fsiZDCKPqHG4hnMrTp42Ht9/Dl/yu
        ClEAh0aiDLxMBYGdJ7Sqfzjd3SuUf58uFJ0qP1CFcaH9e1AQNDxBW29blXOit5X8
        w5WY6K02A709cr9geAUK/o7zOdhElJfOhkgzp+3FC+sNyiRxKjahFgfM2OY61O45
        yRRxaMbnbV6+qOs0Ic6cwIIcQFW+vdfboyPVjJKMZQQfs58UisFyIEI5PT2o78Cq
        jRYg79eNZ45jaqkR+So9spFeUCqLpDkvMI0rycAZ1dsjqQOSTic/7lp5KrKVN9Qn
        KLULg==
X-ME-Sender: <xms:3Y31Yj2zvAGY4SC8CjJL60O5K30qgMSNACNE2VHvWMYeVG8uQF6BfA>
    <xme:3Y31YiE7k7A2luJ_TuCVrRZMZ_CwXPrPtOXg-WRln-cVEoeNd9kwMCPGnBY_Q9xhH
    aTMQZXWiV7wpayZCA>
X-ME-Received: <xmr:3Y31Yj4rnI2CK6Km75Ybcw6axTpe5lEX7HjYDM92QW0liAuivtntvYiz2tTc7sbSNPcNhUDdZqsBPzn9og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:3Y31Yo2JY4BilY8xvNNO6fIPoZQ5ReZl--dBSJFnTiP1wGEOz6wf-g>
    <xmx:3Y31YmEDNmikJoBCMHCEthXWu4-yUVQUMg2omlNBySoFMj8F3fAoOw>
    <xmx:3Y31Yp8yW6KNfN72OmPflgwanG6clDNVYKTAUDOuOd45xVp_FaZfnQ>
    <xmx:3o31Yu8vGFpyQNNsn8b4NLEw5zLlCVa8uFUglUQq--iLqQynsmnblQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:45 -0400 (EDT)
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
Subject: [RFC PATCH v2 01/12] arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
Date:   Thu, 11 Aug 2022 19:16:32 -0400
Message-Id: <20220811231643.1012912-2-zi.yan@sent.com>
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

This Kconfig option is used by individual arch to set its desired
MAX_ORDER. Rename it to reflect its actual use.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-oxnas@groups.io
Cc: linux-csky@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arc/Kconfig                             | 2 +-
 arch/arm/Kconfig                             | 2 +-
 arch/arm/configs/imx_v6_v7_defconfig         | 2 +-
 arch/arm/configs/milbeaut_m10v_defconfig     | 2 +-
 arch/arm/configs/oxnas_v6_defconfig          | 2 +-
 arch/arm/configs/sama7_defconfig             | 2 +-
 arch/arm64/Kconfig                           | 2 +-
 arch/csky/Kconfig                            | 2 +-
 arch/ia64/Kconfig                            | 2 +-
 arch/ia64/include/asm/sparsemem.h            | 6 +++---
 arch/m68k/Kconfig.cpu                        | 2 +-
 arch/mips/Kconfig                            | 2 +-
 arch/nios2/Kconfig                           | 2 +-
 arch/powerpc/Kconfig                         | 2 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig | 2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config    | 2 +-
 arch/sh/configs/ecovec24_defconfig           | 2 +-
 arch/sh/mm/Kconfig                           | 2 +-
 arch/sparc/Kconfig                           | 2 +-
 arch/xtensa/Kconfig                          | 2 +-
 include/linux/mmzone.h                       | 4 ++--
 21 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 9e3653253ef2..d9a13ccf89a3 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -554,7 +554,7 @@ config ARC_BUILTIN_DTB_NAME
=20
 endmenu	 # "ARC Architecture Configuration"
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	default "12" if ARC_HUGEPAGE_16M
 	default "11"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..e6c8ee56ac52 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1434,7 +1434,7 @@ config ARM_MODULE_PLTS
 	  Disabling this is usually safe for small single-platform
 	  configurations. If unsure, say y.
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	default "12" if SOC_AM33XX
 	default "9" if SA1111
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6=
_v7_defconfig
index 01012537a9b9..fb283059daa0 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -31,7 +31,7 @@ CONFIG_SOC_VF610=3Dy
 CONFIG_SMP=3Dy
 CONFIG_ARM_PSCI=3Dy
 CONFIG_HIGHMEM=3Dy
-CONFIG_FORCE_MAX_ZONEORDER=3D14
+CONFIG_ARCH_FORCE_MAX_ORDER=3D14
 CONFIG_CMDLINE=3D"noinitrd console=3Dttymxc0,115200"
 CONFIG_KEXEC=3Dy
 CONFIG_CPU_FREQ=3Dy
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/mi=
lbeaut_m10v_defconfig
index 58810e98de3d..8620061e19a8 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -26,7 +26,7 @@ CONFIG_THUMB2_KERNEL=3Dy
 # CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11 is not set
 # CONFIG_ARM_PATCH_IDIV is not set
 CONFIG_HIGHMEM=3Dy
-CONFIG_FORCE_MAX_ZONEORDER=3D12
+CONFIG_ARCH_FORCE_MAX_ORDER=3D12
 CONFIG_SECCOMP=3Dy
 CONFIG_KEXEC=3Dy
 CONFIG_EFI=3Dy
diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxnas_v=
6_defconfig
index 600f78b363dd..5c163a9d1429 100644
--- a/arch/arm/configs/oxnas_v6_defconfig
+++ b/arch/arm/configs/oxnas_v6_defconfig
@@ -12,7 +12,7 @@ CONFIG_ARCH_OXNAS=3Dy
 CONFIG_MACH_OX820=3Dy
 CONFIG_SMP=3Dy
 CONFIG_NR_CPUS=3D16
-CONFIG_FORCE_MAX_ZONEORDER=3D12
+CONFIG_ARCH_FORCE_MAX_ORDER=3D12
 CONFIG_SECCOMP=3Dy
 CONFIG_ARM_APPENDED_DTB=3Dy
 CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defc=
onfig
index 0384030d8b25..8b2cf6ddd568 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -19,7 +19,7 @@ CONFIG_ATMEL_CLOCKSOURCE_TCB=3Dy
 # CONFIG_CACHE_L2X0 is not set
 # CONFIG_ARM_PATCH_IDIV is not set
 # CONFIG_CPU_SW_DOMAIN_PAN is not set
-CONFIG_FORCE_MAX_ZONEORDER=3D15
+CONFIG_ARCH_FORCE_MAX_ORDER=3D15
 CONFIG_UACCESS_WITH_MEMCPY=3Dy
 # CONFIG_ATAGS is not set
 CONFIG_CMDLINE=3D"console=3DttyS0,115200 earlyprintk ignore_loglevel"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 571cc234d0b3..c6fcd8746f60 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1401,7 +1401,7 @@ config XEN
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int
 	default "14" if ARM64_64K_PAGES
 	default "12" if ARM64_16K_PAGES
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3cbc2dc62baf..adee6ab36862 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -332,7 +332,7 @@ config HIGHMEM
 	select KMAP_LOCAL
 	default y
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	default "11"
=20
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 26ac8ea15a9e..c6e06cdc738f 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -200,7 +200,7 @@ config IA64_CYCLONE
 	  Say Y here to enable support for IBM EXA Cyclone time source.
 	  If you're unsure, answer N.
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "MAX_ORDER (11 - 17)"  if !HUGETLB_PAGE
 	range 11 17  if !HUGETLB_PAGE
 	default "17" if HUGETLB_PAGE
diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/spar=
semem.h
index 42ed5248fae9..84e8ce387b69 100644
--- a/arch/ia64/include/asm/sparsemem.h
+++ b/arch/ia64/include/asm/sparsemem.h
@@ -11,10 +11,10 @@
=20
 #define SECTION_SIZE_BITS	(30)
 #define MAX_PHYSMEM_BITS	(50)
-#ifdef CONFIG_FORCE_MAX_ZONEORDER
-#if ((CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
+#ifdef CONFIG_ARCH_FORCE_MAX_ORDER
+#if ((CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
 #undef SECTION_SIZE_BITS
-#define SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
+#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIFT)
 #endif
 #endif
=20
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index e0e9e31339c1..3b2f39508524 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -399,7 +399,7 @@ config SINGLE_MEMORY_CHUNK
 	  order" to save memory that could be wasted for unused memory map.
 	  Say N if not sure.
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order" if ADVANCED
 	depends on !SINGLE_MEMORY_CHUNK
 	default "11"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ec21f8999249..70d28976a40d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2140,7 +2140,7 @@ config PAGE_SIZE_64KB
=20
 endchoice
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	range 14 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
 	default "14" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 4167f1eb4cd8..a582f72104f3 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -44,7 +44,7 @@ menu "Kernel features"
=20
 source "kernel/Kconfig.hz"
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	range 9 20
 	default "11"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4c466acdc70d..39d71d7701bd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -845,7 +845,7 @@ config DATA_SHIFT
 	  in that case. If PIN_TLB is selected, it must be aligned to 8M as
 	  8M pages will be pinned.
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	range 8 9 if PPC64 && PPC_64K_PAGES
 	default "9" if PPC64 && PPC_64K_PAGES
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/co=
nfigs/85xx/ge_imp3a_defconfig
index f29c166998af..e7672c186325 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -30,7 +30,7 @@ CONFIG_PREEMPT=3Dy
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=3Dm
 CONFIG_MATH_EMULATION=3Dy
-CONFIG_FORCE_MAX_ZONEORDER=3D17
+CONFIG_ARCH_FORCE_MAX_ORDER=3D17
 CONFIG_PCI=3Dy
 CONFIG_PCIEPORTBUS=3Dy
 CONFIG_PCI_MSI=3Dy
diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/confi=
gs/fsl-emb-nonhw.config
index f14c6dbd7346..ab8a8c4530d9 100644
--- a/arch/powerpc/configs/fsl-emb-nonhw.config
+++ b/arch/powerpc/configs/fsl-emb-nonhw.config
@@ -41,7 +41,7 @@ CONFIG_FIXED_PHY=3Dy
 CONFIG_FONT_8x16=3Dy
 CONFIG_FONT_8x8=3Dy
 CONFIG_FONTS=3Dy
-CONFIG_FORCE_MAX_ZONEORDER=3D13
+CONFIG_ARCH_FORCE_MAX_ORDER=3D13
 CONFIG_FRAMEBUFFER_CONSOLE=3Dy
 CONFIG_FRAME_WARN=3D1024
 CONFIG_FTL=3Dy
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_=
defconfig
index e699e2e04128..b52e14ccb450 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7724=3Dy
-CONFIG_FORCE_MAX_ZONEORDER=3D12
+CONFIG_ARCH_FORCE_MAX_ORDER=3D12
 CONFIG_MEMORY_SIZE=3D0x10000000
 CONFIG_FLATMEM_MANUAL=3Dy
 CONFIG_SH_ECOVEC=3Dy
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index ba569cfb4368..411fdc0901f7 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -18,7 +18,7 @@ config PAGE_OFFSET
 	default "0x80000000" if MMU
 	default "0x00000000"
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	range 9 64 if PAGE_SIZE_16KB
 	default "9" if PAGE_SIZE_16KB
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 1c852bb530ec..4d3d1af90d52 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -269,7 +269,7 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y if SPARC64
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	default "13"
 	help
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 12ac277282ba..bcb0c5d2abc2 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -771,7 +771,7 @@ config HIGHMEM
=20
 	  If unsure, say Y.
=20
-config FORCE_MAX_ZONEORDER
+config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	default "11"
 	help
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8f571dc7c524..ca285ed3c6e0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -24,10 +24,10 @@
 #include <asm/page.h>
=20
 /* Free memory management - zoned buddy allocator.  */
-#ifndef CONFIG_FORCE_MAX_ZONEORDER
+#ifndef CONFIG_ARCH_FORCE_MAX_ORDER
 #define MAX_ORDER 11
 #else
-#define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
+#define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
 #endif
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
=20
--=20
2.35.1

