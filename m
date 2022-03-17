Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E54DCA28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiCQPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiCQPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:39:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7420C19B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:37:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 348455C052D;
        Thu, 17 Mar 2022 11:37:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 17 Mar 2022 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=Lu9+y7/OA8vzrI
        JEVfxTWNNqIdwqiBgzFUZF7HyFHFY=; b=XzktQ4tZtw18zEeLhiz7oSkDCQPDGK
        igvDN1je/cmJpvXg30XSkcaJ+6svK413TDPhoh3LMWZwzbVav+zRp6hFEmh9nCXM
        47RVGneDW3SqlUuZnIH92vUAYriBCWFKaKw7T9miJXx4jmH1dkRqc5xT4zfz0F8w
        bmojXl3BtbA15rCdo7JoJp8QOyY+jVHu9bZl3Jw4hiJqQa8FGccg28pyEJXRygBW
        Zuh/1guSqr5uc4vYWvc5o0CI8GAOEQmz5aUYuAxTD1Di07n6d8ctoNCB3Jgg75xl
        RrZAmpnksNcsboK8CPi39DnodDMKfBRkR8PFFGNTMC5Rdgw1Kqe9YoyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Lu9+y7/OA8vzrIJEVfxTWNNqIdwqiBgzFUZF7HyFHFY=; b=D3idXo6y
        aerXmlNSHN3Sr1Q2H8kbglxcflI9iDOb3fDful4M0MqIJrrcrqufnl0T0pXCpjFL
        uOy5bReqQ6bT/cCTIz88AXrYcVWhVLim1uIWlGI3cFJt+xlMyXpWkYkqjC7rj5/w
        TzDTF1thsvJ0X78apxnwyvE6vREENEpZfi2SYSJv36PP5oCNbJyOoXBjbkhBJJfY
        3XnaWJUwrHcSeHGBtIXKqYXaWvggDbOSNAlc8ay5/GsP/SpILMAtPfqlGPASEYCu
        EQkEXkIbU/vlmQO3ovVandpQkiAkMx0bZtKM4oqWYwT1EFzEQV5qky2jEx5oES4e
        3skPUsAEw/LtfA==
X-ME-Sender: <xms:y1UzYoNx2H2fcH9c5WduRy8BMrKfEWZCms3pSG5gRjbL0ZpsKXyo2g>
    <xme:y1UzYu8i3pFTUkTj5eh_570xHILyQphEOSHQZoPJGBwuSbydFneLB5hygNRl_iy7r
    W9IZcQ7fmxX7art4w>
X-ME-Received: <xmr:y1UzYvTxqxwdax17SkfzXDU6npC4javbKin29_0ABxU7C6x7khjK--3znbmdBMHbcSxeU8VwzEREVPHZ-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:y1UzYgupappmJTLqjz4EWdLxLa6IAUw8b5X-763hqXPdnJSgsimBcw>
    <xmx:y1UzYgegsS9TYtJvEbQRUgPu9LeY0c8Y_FbC2ebXX45xLViLJARCwg>
    <xmx:y1UzYk0Jwv2HzIAu_2o_bojp9YtTfA0n03XgQOPK6IN-jSMdug4p8A>
    <xmx:y1UzYhVC7DIS7OatRaHal8FKUEW47wKWWaCeojjyGOkx62_lyng1IA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 11:37:46 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v8 1/5] mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
Date:   Thu, 17 Mar 2022 11:37:29 -0400
Message-Id: <20220317153733.2171277-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317153733.2171277-1-zi.yan@sent.com>
References: <20220317153733.2171277-1-zi.yan@sent.com>
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

has_unmovable_pages() is only used in mm/page_isolation.c. Move it from
mm/page_alloc.c and make it static.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-isolation.h |   2 -
 mm/page_alloc.c                | 119 ---------------------------------
 mm/page_isolation.c            | 119 +++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 121 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 572458016331..e14eddf6741a 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -33,8 +33,6 @@ static inline bool is_migrate_isolate(int migratetype)
 #define MEMORY_OFFLINE	0x1
 #define REPORT_FAILURE	0x2
=20
-struct page *has_unmovable_pages(struct zone *zone, struct page *page,
-				 int migratetype, int flags);
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f648decfe39d..6de57d058d3d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8936,125 +8936,6 @@ void *__init alloc_large_system_hash(const char *ta=
blename,
 	return table;
 }
=20
-/*
- * This function checks whether pageblock includes unmovable pages or not.
- *
- * PageLRU check without isolation or lru_lock could race so that
- * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
- * check without lock_page also may miss some movable non-lru pages at
- * race condition. So you can't expect this function should be exact.
- *
- * Returns a page without holding a reference. If the caller wants to
- * dereference that page (e.g., dumping), it has to make sure that it
- * cannot get removed (e.g., via memory unplug) concurrently.
- *
- */
-struct page *has_unmovable_pages(struct zone *zone, struct page *page,
-				 int migratetype, int flags)
-{
-	unsigned long iter =3D 0;
-	unsigned long pfn =3D page_to_pfn(page);
-	unsigned long offset =3D pfn % pageblock_nr_pages;
-
-	if (is_migrate_cma_page(page)) {
-		/*
-		 * CMA allocations (alloc_contig_range) really need to mark
-		 * isolate CMA pageblocks even when they are not movable in fact
-		 * so consider them movable here.
-		 */
-		if (is_migrate_cma(migratetype))
-			return NULL;
-
-		return page;
-	}
-
-	for (; iter < pageblock_nr_pages - offset; iter++) {
-		page =3D pfn_to_page(pfn + iter);
-
-		/*
-		 * Both, bootmem allocations and memory holes are marked
-		 * PG_reserved and are unmovable. We can even have unmovable
-		 * allocations inside ZONE_MOVABLE, for example when
-		 * specifying "movablecore".
-		 */
-		if (PageReserved(page))
-			return page;
-
-		/*
-		 * If the zone is movable and we have ruled out all reserved
-		 * pages then it should be reasonably safe to assume the rest
-		 * is movable.
-		 */
-		if (zone_idx(zone) =3D=3D ZONE_MOVABLE)
-			continue;
-
-		/*
-		 * Hugepages are not in LRU lists, but they're movable.
-		 * THPs are on the LRU, but need to be counted as #small pages.
-		 * We need not scan over tail pages because we don't
-		 * handle each tail page individually in migration.
-		 */
-		if (PageHuge(page) || PageTransCompound(page)) {
-			struct page *head =3D compound_head(page);
-			unsigned int skip_pages;
-
-			if (PageHuge(page)) {
-				if (!hugepage_migration_supported(page_hstate(head)))
-					return page;
-			} else if (!PageLRU(head) && !__PageMovable(head)) {
-				return page;
-			}
-
-			skip_pages =3D compound_nr(head) - (page - head);
-			iter +=3D skip_pages - 1;
-			continue;
-		}
-
-		/*
-		 * We can't use page_count without pin a page
-		 * because another CPU can free compound page.
-		 * This check already skips compound tails of THP
-		 * because their page->_refcount is zero at all time.
-		 */
-		if (!page_ref_count(page)) {
-			if (PageBuddy(page))
-				iter +=3D (1 << buddy_order(page)) - 1;
-			continue;
-		}
-
-		/*
-		 * The HWPoisoned page may be not in buddy system, and
-		 * page_count() is not 0.
-		 */
-		if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
-			continue;
-
-		/*
-		 * We treat all PageOffline() pages as movable when offlining
-		 * to give drivers a chance to decrement their reference count
-		 * in MEM_GOING_OFFLINE in order to indicate that these pages
-		 * can be offlined as there are no direct references anymore.
-		 * For actually unmovable PageOffline() where the driver does
-		 * not support this, we will fail later when trying to actually
-		 * move these pages that still have a reference count > 0.
-		 * (false negatives in this function only)
-		 */
-		if ((flags & MEMORY_OFFLINE) && PageOffline(page))
-			continue;
-
-		if (__PageMovable(page) || PageLRU(page))
-			continue;
-
-		/*
-		 * If there are RECLAIMABLE pages, we need to check
-		 * it.  But now, memory offline itself doesn't call
-		 * shrink_node_slabs() and it still to be fixed.
-		 */
-		return page;
-	}
-	return NULL;
-}
-
 #ifdef CONFIG_CONTIG_ALLOC
 static unsigned long pfn_max_align_down(unsigned long pfn)
 {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f67c4c70f17f..b34f1310aeaa 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -15,6 +15,125 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
=20
+/*
+ * This function checks whether pageblock includes unmovable pages or not.
+ *
+ * PageLRU check without isolation or lru_lock could race so that
+ * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
+ * check without lock_page also may miss some movable non-lru pages at
+ * race condition. So you can't expect this function should be exact.
+ *
+ * Returns a page without holding a reference. If the caller wants to
+ * dereference that page (e.g., dumping), it has to make sure that it
+ * cannot get removed (e.g., via memory unplug) concurrently.
+ *
+ */
+static struct page *has_unmovable_pages(struct zone *zone, struct page *pa=
ge,
+				 int migratetype, int flags)
+{
+	unsigned long iter =3D 0;
+	unsigned long pfn =3D page_to_pfn(page);
+	unsigned long offset =3D pfn % pageblock_nr_pages;
+
+	if (is_migrate_cma_page(page)) {
+		/*
+		 * CMA allocations (alloc_contig_range) really need to mark
+		 * isolate CMA pageblocks even when they are not movable in fact
+		 * so consider them movable here.
+		 */
+		if (is_migrate_cma(migratetype))
+			return NULL;
+
+		return page;
+	}
+
+	for (; iter < pageblock_nr_pages - offset; iter++) {
+		page =3D pfn_to_page(pfn + iter);
+
+		/*
+		 * Both, bootmem allocations and memory holes are marked
+		 * PG_reserved and are unmovable. We can even have unmovable
+		 * allocations inside ZONE_MOVABLE, for example when
+		 * specifying "movablecore".
+		 */
+		if (PageReserved(page))
+			return page;
+
+		/*
+		 * If the zone is movable and we have ruled out all reserved
+		 * pages then it should be reasonably safe to assume the rest
+		 * is movable.
+		 */
+		if (zone_idx(zone) =3D=3D ZONE_MOVABLE)
+			continue;
+
+		/*
+		 * Hugepages are not in LRU lists, but they're movable.
+		 * THPs are on the LRU, but need to be counted as #small pages.
+		 * We need not scan over tail pages because we don't
+		 * handle each tail page individually in migration.
+		 */
+		if (PageHuge(page) || PageTransCompound(page)) {
+			struct page *head =3D compound_head(page);
+			unsigned int skip_pages;
+
+			if (PageHuge(page)) {
+				if (!hugepage_migration_supported(page_hstate(head)))
+					return page;
+			} else if (!PageLRU(head) && !__PageMovable(head)) {
+				return page;
+			}
+
+			skip_pages =3D compound_nr(head) - (page - head);
+			iter +=3D skip_pages - 1;
+			continue;
+		}
+
+		/*
+		 * We can't use page_count without pin a page
+		 * because another CPU can free compound page.
+		 * This check already skips compound tails of THP
+		 * because their page->_refcount is zero at all time.
+		 */
+		if (!page_ref_count(page)) {
+			if (PageBuddy(page))
+				iter +=3D (1 << buddy_order(page)) - 1;
+			continue;
+		}
+
+		/*
+		 * The HWPoisoned page may be not in buddy system, and
+		 * page_count() is not 0.
+		 */
+		if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
+			continue;
+
+		/*
+		 * We treat all PageOffline() pages as movable when offlining
+		 * to give drivers a chance to decrement their reference count
+		 * in MEM_GOING_OFFLINE in order to indicate that these pages
+		 * can be offlined as there are no direct references anymore.
+		 * For actually unmovable PageOffline() where the driver does
+		 * not support this, we will fail later when trying to actually
+		 * move these pages that still have a reference count > 0.
+		 * (false negatives in this function only)
+		 */
+		if ((flags & MEMORY_OFFLINE) && PageOffline(page))
+			continue;
+
+		if (__PageMovable(page) || PageLRU(page))
+			continue;
+
+		/*
+		 * If there are RECLAIMABLE pages, we need to check
+		 * it.  But now, memory offline itself doesn't call
+		 * shrink_node_slabs() and it still to be fixed.
+		 */
+		return page;
+	}
+	return NULL;
+}
+
 static int set_migratetype_isolate(struct page *page, int migratetype, int=
 isol_flags)
 {
 	struct zone *zone =3D page_zone(page);
--=20
2.35.1

