Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75341590910
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiHKXRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiHKXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:17:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD11A1A5D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 14A385C017E;
        Thu, 11 Aug 2022 19:16:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Aug 2022 19:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259811; x=
        1660346211; bh=nROMsz3ppqqra2BzZ2pVt6LG8fK1ajXOrNIiQ4woogA=; b=H
        GhqMn6eaMGEs9dwuksbm0QcC3P1rGK72b5S0638UqCuG1FAGndSFzv4qnD4/RbJ/
        lbu/YQ69n7Zx0ar+GDe+0F1raAkVeAf0pPq1tsyjn0t6ZpbN+gFN7QaawTabboLd
        r+6g520P+po+Rg8by3137hkpijb0MIM9NQ5cXMJxfjsxqt1DzLF+tdIFH3GgediS
        gSHViQ0w+6TclsLvjXA9hkATpo8Eij7yul54/KFP1StkA/dLCC2TKkMS9wBLNoGl
        GKStVAtIBRbe9RqfzuZ4aiAMJxxlUoV9A3gmiJPplxI1oMYnrPj1quw0WkHpYhm4
        ilvsLH29cn6MJvcVKozDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259811; x=1660346211; bh=n
        ROMsz3ppqqra2BzZ2pVt6LG8fK1ajXOrNIiQ4woogA=; b=f/gWE8mW8X+chpd90
        Y/rfrDG37b2vNVgdyu5fpeAsXvdMf80MvaxJOJE5T9nhMdZ4kxVewOBntrVyoQKm
        UJHjRyaAcKIYvpsogON+CZf5+4+c+BUavfhMDmp1CMv20uIr735Oi90POIVGv1ia
        JextHr2gCouPaso7Kfis1Rhm+6O0ObpBeIdwpSwiKtjdPkUolSxzNl/lPl41T7np
        1jFP2ffXKLF85ioAGiqMcARR1nwY2EOXmSSlcroFAuAnOY7eOEbtJQW3Gp4i6Gig
        rDLv9/lvPIGfes18MppOBpEfjL0+Kp7ialY7Jx9dd3w9CBLwI/avm8pjF3whh72w
        Yta2A==
X-ME-Sender: <xms:4o31Ygo4yOsQX4y0_0H4N31RGYKlgSQ9FmUjR4gkiSegjIcboDryAw>
    <xme:4o31Ymr0xuPa5A9W7SXoNulPxbZVd7Xd0wiRcpOYfzo1H6ook84gTk6V7vquqvg57
    wLiURnXvNqPVOW3lQ>
X-ME-Received: <xmr:4o31YlOlZfCGIpmXVceTPKPbIgwECXRIw0fy7Ni7d5huXfGkS643aU8XxbqGTbAyzyVZJRDVPaqe6qsGSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:4o31Yn5iN1UnckVRAUDX3eygnMsm9Q1ol00mEk8VGUTGpFJRYNJ37A>
    <xmx:4o31Yv7nfVf2KG6kDnv5xgs3Y19QOIPFFvcXyhSyTiJdLPCWuwVhNQ>
    <xmx:4o31YniXGAIQ3sqZDlAUoMeT7R9jwRUYZ3LIqW5HLG5F4HGtLmSGZQ>
    <xmx:4431Ysx1RiJUOOf8IcE3mwmQvpoGNb-NMvqH6dLn8Ok02r8tiMg4cA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:50 -0400 (EDT)
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
Subject: [RFC PATCH v2 09/12] mm: Make MAX_ORDER of buddy allocator configurable via Kconfig SET_MAX_ORDER.
Date:   Thu, 11 Aug 2022 19:16:40 -0400
Message-Id: <20220811231643.1012912-10-zi.yan@sent.com>
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

With SPARSEMEM_VMEMMAP, all struct page are virtually contigous,
thus kernel can manipulate arbitrarily large pages. By checking
PFN validity during buddy page merging process, all free pages in buddy
allocator's free area have their PFNs contiguous even if the system has
several not physically contiguous memory sections. With these two
conditions, it is OK to remove the restriction of
MAX_ORDER + PAGE_SHIFT < SECTION_SIZE_BITS and change MAX_ORDER freely.

Add SET_MAX_ORDER to allow MAX_ORDER adjustment when arch does not set
its own MAX_ORDER via ARCH_FORCE_MAX_ORDER. Make it depend
on SPARSEMEM_VMEMMAP, when MAX_ORDER is not limited by SECTION_SIZE_BITS.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/Kconfig           |  4 ++++
 include/linux/mmzone.h | 17 ++++++++++++++---
 mm/Kconfig             | 14 ++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f330410da63a..24baee6c3feb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,6 +11,10 @@ source "arch/$(SRCARCH)/Kconfig"
=20
 menu "General architecture-dependent options"
=20
+config ARCH_FORCE_MAX_ORDER
+    int
+    default "0"
+
 config CRASH_CORE
 	bool
=20
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e93faa3d7f1d..b83b481e250b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -24,11 +24,14 @@
 #include <asm/page.h>
=20
 /* Free memory management - zoned buddy allocator.  */
-#ifndef CONFIG_ARCH_FORCE_MAX_ORDER
-#define MAX_ORDER 10
-#else
+#ifdef CONFIG_SET_MAX_ORDER
+#define MAX_ORDER CONFIG_SET_MAX_ORDER
+#elif CONFIG_ARCH_FORCE_MAX_ORDER !=3D 0
 #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
+#else
+#define MAX_ORDER 10
 #endif
+
 #define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
=20
 /*
@@ -1379,9 +1382,17 @@ static inline bool movable_only_nodes(nodemask_t *no=
des)
 #define SECTION_BLOCKFLAGS_BITS \
 	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
=20
+/*
+ * The MAX_ORDER check is not necessary when CONFIG_SET_MAX_ORDER is set, =
since
+ * it depends on CONFIG_SPARSEMEM_VMEMMAP, where all struct page are virtu=
ally
+ * contiguous, thus > section size pages can be allocated and manipulated
+ * without worrying about non-contiguous struct page.
+ */
+#ifndef CONFIG_SET_MAX_ORDER
 #if (MAX_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
+#endif /* CONFIG_SET_MAX_ORDER*/
=20
 static inline unsigned long pfn_to_section_nr(unsigned long pfn)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index bbe31e85afee..e558f5679707 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -441,6 +441,20 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
=20
+config SET_MAX_ORDER
+	int "Set maximum order of buddy allocator"
+    depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER =3D 0)
+	range 10 255
+	default "10"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
+
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
=20
--=20
2.35.1

