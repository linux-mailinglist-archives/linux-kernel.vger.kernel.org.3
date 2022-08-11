Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4844659090C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiHKXRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiHKXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEE5A1A43
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8266E5C0159;
        Thu, 11 Aug 2022 19:16:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Aug 2022 19:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259807; x=
        1660346207; bh=F4b6XOChwbbk0OQUqouspJ2OncV1W77wbWPpJfolhW8=; b=R
        ax/+SLx/5j0yVaVVzeq4qdsZ9YVPYkfsUtBya8pPZB8tMczKeHa51Bh0gqndh/Dx
        OiloKGcYDd8T6rgWZA1d+K1XqdSl8z2WKAfPcHDsYAjDYzhNBIJI1xt1r0rCTnfj
        48gYZ2ped0DjQPdBUegeNo2+SeqrKYsrGoE3IU0VBiKdbbXQ9Si4Wfi45tyRaczi
        cYeTtxfHFFxyYJV+M95Gd1/ZolnsZrODhlQdano1PugnXJvhX1pG/bvf6LYfEWnY
        qhBxsvo6kmNP3avp/hurzNwf/LcMNT7SCS9SyUMz3UZkUqh4Ml2X4zAP9aU2GYoz
        nMCPMvj0lmwkMHg/tJH/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259807; x=1660346207; bh=F
        4b6XOChwbbk0OQUqouspJ2OncV1W77wbWPpJfolhW8=; b=uuc2ktM7EJN+rdOHv
        QyLhN0lOHI2Q5rBH2peroXIbn3yIaXMt0Bj8hfXnUF1hIXlQmjp8vVLWQ06yY4rp
        VMr71I1vGgRIEiizgpzlYwsvpU1+BVTQMOdNrJKOK8bWkjxZXmn/FaucGjWNSTiF
        xzeF2VBk3C0WLto7frJkNI3GQDoTOvYn5vueJmWxwnAlRa09mzZ8LtwYdMnfp6V+
        75LkEvtId5OgHaHhqih69uruO3mdjj/AAWZuB0xMB+C/mV9SeCnJG3bHLZZJTv/3
        bzLKpqWslAqiv0qKMqeV8Ql2TakLXHyBtnYNYDAYKhTkniyNeTLjxehbyRao+dbK
        LNuOQ==
X-ME-Sender: <xms:3431Ymz9zqvFkYc5fgJbmOqWUsPndYUOMZZslx3C0h7mU1pubosuFg>
    <xme:3431YiQLV67F1BVpAhpRqySA3togaD9Kiz4ejEhJIDk-QCg_KD-jd-sY5fmOTs3C_
    C02IzueC6coYbi3fw>
X-ME-Received: <xmr:3431YoVuouMmrAbnPp_5KMdLASSbny2Ghs4QIxhQUDyuW0CMUBSqLMysAo5yeM3mCG6HBz-6vQY-wMP57g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:3431Ysj481j0gqyCmkAfhMT2RNw_9fYld3LCxSDclMmRC7umQVYSeA>
    <xmx:3431YoBhCBa0_rKV11kxvmDKMmsnKFtCNdKFtMv2dDDQ7qnqkObUbg>
    <xmx:3431YtIfEUzvqJWLJJ5GLr1I60t8m-jdr6ROGBRgJFTLeKeseU6WZA>
    <xmx:3431Ys5TSmcEsatQz7yErKLC0KxlyPdWZy1iacCs3FosOplSjzWOgA>
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
Subject: [RFC PATCH v2 03/12] mm: replace MAX_ORDER when it is used to indicate max physical contiguity.
Date:   Thu, 11 Aug 2022 19:16:34 -0400
Message-Id: <20220811231643.1012912-4-zi.yan@sent.com>
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

MAX_ORDER is limited at a memory section size, thus widely used as
a variable to indicate maximum physically contiguous page size. But this
limitation is no longer necessary as kernel only supports sparse memory
model. Add a new variable MAX_PHYS_CONTIG_ORDER to replace such uses of
MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/sparc/mm/tsb.c                             |  4 ++--
 arch/um/kernel/um_arch.c                        |  4 ++--
 include/linux/pageblock-flags.h                 | 12 ++++++++++++
 kernel/dma/pool.c                               |  8 ++++----
 mm/hugetlb.c                                    |  2 +-
 mm/internal.h                                   |  8 ++++----
 mm/memory.c                                     |  4 ++--
 mm/memory_hotplug.c                             |  6 +++---
 mm/page_isolation.c                             |  2 +-
 mm/page_reporting.c                             |  4 ++--
 11 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index ff33971e1630..ec519225b671 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3899,7 +3899,7 @@
 			[KNL] Minimal page reporting order
 			Format: <integer>
 			Adjust the minimal page reporting order. The page
-			reporting is disabled when it exceeds MAX_ORDER.
+			reporting is disabled when it exceeds MAX_PHYS_CONTIG_ORDER.
=20
 	panic=3D		[KNL] Kernel behaviour on panic: delay <timeout>
 			timeout > 0: seconds before rebooting
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 912205787161..15c31d050dab 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -402,8 +402,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_i=
ndex, unsigned long rss)
 	unsigned long new_rss_limit;
 	gfp_t gfp_flags;
=20
-	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
-		max_tsb_size =3D (PAGE_SIZE << MAX_ORDER);
+	if (max_tsb_size > (PAGE_SIZE << MAX_PHYS_CONTIG_ORDER))
+		max_tsb_size =3D (PAGE_SIZE << MAX_PHYS_CONTIG_ORDER);
=20
 	new_cache_index =3D 0;
 	for (new_size =3D 8192; new_size < max_tsb_size; new_size <<=3D 1UL) {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e0de60e503b9..52a474f4f1c7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -368,10 +368,10 @@ int __init linux_main(int argc, char **argv)
 	max_physmem =3D TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
=20
 	/*
-	 * Zones have to begin on a 1 << MAX_ORDER page boundary,
+	 * Zones have to begin on a 1 << MAX_PHYS_CONTIG_ORDER page boundary,
 	 * so this makes sure that's true for highmem
 	 */
-	max_physmem &=3D ~((1 << (PAGE_SHIFT + MAX_ORDER)) - 1);
+	max_physmem &=3D ~((1 << (PAGE_SHIFT + MAX_PHYS_CONTIG_ORDER)) - 1);
 	if (physmem_size + iomem_size > max_physmem) {
 		highmem =3D physmem_size + iomem_size - max_physmem;
 		physmem_size -=3D highmem;
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flag=
s.h
index 940efcffd374..358b871b07ca 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -54,6 +54,18 @@ extern unsigned int pageblock_order;
=20
 #define pageblock_nr_pages	(1UL << pageblock_order)
=20
+/*
+ * memory section is only defined in sparsemem and in flatmem, pages are a=
lways
+ * physically contiguous, but we use MAX_ORDER since all users assume so.
+ */
+#ifdef CONFIG_FLATMEM
+#define MAX_PHYS_CONTIG_ORDER	MAX_ORDER
+#else /* SPARSEMEM */
+#define MAX_PHYS_CONTIG_ORDER	(min(PFN_SECTION_SHIFT, MAX_ORDER))
+#endif /* CONFIG_FLATMEM */
+
+#define MAX_PHYS_CONTIG_NR_PAGES	(1UL << MAX_PHYS_CONTIG_ORDER)
+
 /* Forward declaration */
 struct page;
=20
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index e20f168a34c7..b10f1dd52871 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -84,8 +84,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size=
_t pool_size,
 	void *addr;
 	int ret =3D -ENOMEM;
=20
-	/* Cannot allocate larger than MAX_ORDER */
-	order =3D min(get_order(pool_size), MAX_ORDER);
+	/* Cannot allocate larger than MAX_PHYS_CONTIG_ORDER */
+	order =3D min(get_order(pool_size), MAX_PHYS_CONTIG_ORDER);
=20
 	do {
 		pool_size =3D 1 << (PAGE_SHIFT + order);
@@ -190,11 +190,11 @@ static int __init dma_atomic_pool_init(void)
=20
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
-	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER.
+	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_PHYS_CONTIG_ORDER.
 	 */
 	if (!atomic_pool_size) {
 		unsigned long pages =3D totalram_pages() / (SZ_1G / SZ_128K);
-		pages =3D min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
+		pages =3D min_t(unsigned long, pages, MAX_PHYS_CONTIG_NR_PAGES);
 		atomic_pool_size =3D max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
 	}
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 15ff582687a3..36eedeed1b22 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1903,7 +1903,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)
 	pgoff_t index =3D page_index(page_head);
 	unsigned long compound_idx;
=20
-	if (compound_order(page_head) > MAX_ORDER)
+	if (compound_order(page_head) > MAX_PHYS_CONTIG_ORDER)
 		compound_idx =3D page_to_pfn(page) - page_to_pfn(page_head);
 	else
 		compound_idx =3D page - page_head;
diff --git a/mm/internal.h b/mm/internal.h
index 4df67b6b8cce..1433e3a6fdd0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -302,7 +302,7 @@ static inline bool page_is_buddy(struct page *page, str=
uct page *buddy,
  * satisfies the following equation:
  *     P =3D B & ~(1 << O)
  *
- * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
+ * Assumption: *_mem_map is contiguous at least up to MAX_PHYS_CONTIG_ORDER
  */
 static inline unsigned long
 __find_buddy_pfn(unsigned long page_pfn, unsigned int order)
@@ -642,11 +642,11 @@ static inline void vunmap_range_noflush(unsigned long=
 start, unsigned long end)
 /*
  * Return the mem_map entry representing the 'offset' subpage within
  * the maximally aligned gigantic page 'base'.  Handle any discontiguity
- * in the mem_map at MAX_ORDER_NR_PAGES boundaries.
+ * in the mem_map at MAX_PHYS_CONTIG_NR_PAGES boundaries.
  */
 static inline struct page *mem_map_offset(struct page *base, int offset)
 {
-	if (unlikely(offset >=3D MAX_ORDER_NR_PAGES))
+	if (unlikely(offset >=3D MAX_PHYS_CONTIG_NR_PAGES))
 		return nth_page(base, offset);
 	return base + offset;
 }
@@ -658,7 +658,7 @@ static inline struct page *mem_map_offset(struct page *=
base, int offset)
 static inline struct page *mem_map_next(struct page *iter,
 						struct page *base, int offset)
 {
-	if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) =3D=3D 0)) {
+	if (unlikely((offset & (MAX_PHYS_CONTIG_NR_PAGES - 1)) =3D=3D 0)) {
 		unsigned long pfn =3D page_to_pfn(base) + offset;
 		if (!pfn_valid(pfn))
 			return NULL;
diff --git a/mm/memory.c b/mm/memory.c
index bd8e7e79be99..3b82945aaa3d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5660,7 +5660,7 @@ void clear_huge_page(struct page *page,
 	unsigned long addr =3D addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
=20
-	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
+	if (unlikely(pages_per_huge_page > MAX_PHYS_CONTIG_NR_PAGES)) {
 		clear_gigantic_page(page, addr, pages_per_huge_page);
 		return;
 	}
@@ -5713,7 +5713,7 @@ void copy_user_huge_page(struct page *dst, struct pag=
e *src,
 		.vma =3D vma,
 	};
=20
-	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
+	if (unlikely(pages_per_huge_page > MAX_PHYS_CONTIG_NR_PAGES)) {
 		copy_user_gigantic_page(dst, src, addr, vma,
 					pages_per_huge_page);
 		return;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5540499007ae..8930823e5067 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -596,16 +596,16 @@ static void online_pages_range(unsigned long start_pf=
n, unsigned long nr_pages)
 	unsigned long pfn;
=20
 	/*
-	 * Online the pages in MAX_ORDER aligned chunks. The callback might
+	 * Online the pages in MAX_PHYS_CONTIG_ORDER aligned chunks. The callback=
 might
 	 * decide to not expose all pages to the buddy (e.g., expose them
 	 * later). We account all pages as being online and belonging to this
 	 * zone ("present").
 	 * When using memmap_on_memory, the range might not be aligned to
-	 * MAX_ORDER_NR_PAGES - 1, but pageblock aligned. __ffs() will detect
+	 * MAX_PHYS_CONTIG_NR_PAGES - 1, but pageblock aligned. __ffs() will dete=
ct
 	 * this and the first chunk to online will be pageblock_nr_pages.
 	 */
 	for (pfn =3D start_pfn; pfn < end_pfn;) {
-		int order =3D min_t(unsigned long, MAX_ORDER, __ffs(pfn));
+		int order =3D min_t(unsigned long, MAX_PHYS_CONTIG_ORDER, __ffs(pfn));
=20
 		(*online_page_callback)(pfn_to_page(pfn), order);
 		pfn +=3D (1UL << order);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 8d33120a81b2..801835f91c44 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -226,7 +226,7 @@ static void unset_migratetype_isolate(struct page *page=
, int migratetype)
 	 */
 	if (PageBuddy(page)) {
 		order =3D buddy_order(page);
-		if (order >=3D pageblock_order && order <=3D MAX_ORDER) {
+		if (order >=3D pageblock_order && order <=3D MAX_PHYS_CONTIG_ORDER) {
 			buddy =3D find_buddy_page_pfn(page, page_to_pfn(page),
 						    order, NULL);
 			if (buddy && !is_migrate_isolate_page(buddy)) {
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index d52a55bca6d5..b48d6ad82998 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -11,7 +11,7 @@
 #include "page_reporting.h"
 #include "internal.h"
=20
-unsigned int page_reporting_order =3D MAX_ORDER + 1;
+unsigned int page_reporting_order =3D MAX_PHYS_CONTIG_ORDER + 1;
 module_param(page_reporting_order, uint, 0644);
 MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
=20
@@ -244,7 +244,7 @@ page_reporting_process_zone(struct page_reporting_dev_i=
nfo *prdev,
 		return err;
=20
 	/* Process each free list starting from lowest order/mt */
-	for (order =3D page_reporting_order; order <=3D MAX_ORDER; order++) {
+	for (order =3D page_reporting_order; order <=3D MAX_PHYS_CONTIG_ORDER; or=
der++) {
 		for (mt =3D 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
--=20
2.35.1

