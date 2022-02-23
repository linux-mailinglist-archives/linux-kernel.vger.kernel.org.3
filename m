Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9004C0B17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiBWEbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiBWEbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:31:14 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC973191A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:30:47 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9DF55580113;
        Tue, 22 Feb 2022 23:30:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Feb 2022 23:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=ScaHljs36KhhiK
        6PzqhhwR0BIonYDvtJP+MyRb43DFE=; b=qtmg2sm/u2imcdgR7BJ1R+zq14C3X6
        M0AJ/vLlvw3/OC+S9TsOEuRsda/vfEJ3TWEp5T79TTG/c1yiHT9nt6E6lSTtqPLw
        IOQ/QJt4pS/PznXT8BzmOWVXccYX8tRmTKr444aHi97+kc8IqvMZFlblUSjJnoug
        cO6hqs8UedYZdlVT6WAiciAk4ymaKAnqTeorHuqMOe06rK1VLwsXg3OgT5nhKFYr
        dLZ83urqPJ6C5s1dvEQnoWyNwv9kVem05KQi+9rbEPf0ZmLU/bs4MxbPzFk2fnbs
        7UDpI4ureCqggEUiBHeCr+ZfBQ6EJePHWkdy0unHaLX+808K5+4GYu4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ScaHljs36KhhiK6PzqhhwR0BIonYDvtJP+MyRb43DFE=; b=J1z7OFHu
        BsaRe3/7KohNi2RRiUGxXE6s5RoefkDRM6FWPYgOu0n8Aljwz5g2IvIqp5vLM/7w
        rjDTZF6h0gW3dpQKypFN04gx/wdEMmJI+ldphszSQg63yljJ2ioE8H2S0zT1kwAA
        0u2tqJM/r2duo4TCe44FjJ69Lxo+MsgNtRnzPN4OtExWh+3DQla4onSToQ1sNMLX
        LLQWFAHFSfwrgU4BYJgQ1+kXYZ9NW0d6IjPBRSE/yEbeESIWhGNvILqrzZve+X99
        PYdlgo74o+4RO0a5yoxQdvUlyX5GumKe9u2S4sZHckod9KqekW1/tF8W2PEI4Ar1
        FJwk2nfkSRhhGg==
X-ME-Sender: <xms:dbgVYnixGveUuR5D-elI4i5LwdoahQZAMpSQ9BY93OKzB8pSeDlGNw>
    <xme:dbgVYkB8ZSTT51637n2aLq_aF5GoSquhpDCWLQ3UnZ5TBJHbP12ds_kBhCkdjAV1Z
    C4HX9nXZSY5I92DsQ>
X-ME-Received: <xmr:dbgVYnG_N6-r-EqTWwzomkRz5lxwi444FFd8WFop1zJ1tioNCI0gmp7iRsUmqANW2E3AUQpO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:dbgVYkR1y2_uYjSQ-qvYeQBOAM_jlA92VqIowGE0hq-aRH3BVCjuUQ>
    <xmx:dbgVYkzK77MYwBF1iovbzLI4MjclB3aIeF-97nEJ9kFb69oLQYbe3Q>
    <xmx:dbgVYq4G0PMHMVe0ezzbcJt3Pdrr7lRMOJXCWm-4d64YF5N6L1h4DQ>
    <xmx:drgVYpj-Fpo8VbhaEnDlsGg_-Mbh92SljxUpc0-5VF3JUKheXDRrhg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 23:30:45 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v6 1/5] mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
Date:   Tue, 22 Feb 2022 23:30:33 -0500
Message-Id: <20220223043037.715205-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223043037.715205-1-zi.yan@sent.com>
References: <20220223043037.715205-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 7ff1efc84205..228751019fd8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8948,125 +8948,6 @@ void *__init alloc_large_system_hash(const char *ta=
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
2.34.1

