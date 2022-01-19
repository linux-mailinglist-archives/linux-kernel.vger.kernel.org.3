Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5259249405A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357034AbiASTHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:07:02 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50743 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356989AbiASTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:06:37 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id C9E8858071F;
        Wed, 19 Jan 2022 14:06:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 19 Jan 2022 14:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=lM5Ud4VXnPfGE
        4e+o+afQ6u3rvTqVxQH5x8bdxJbj/U=; b=Bcb5wJnlVrRr1fBACKLZM/68ylYyW
        XauW4ZjUGmyFBFRSSAfWApAu7Gm8Mow//QFMWY+BS6xQD73w+ORjT3Bvj8sIoH2F
        ec3MJrdBDthm3kl1Om7YhgBSyfHayTyNGYf6DGlKiGwPlBj/D1p7WDLlFDuMr1Tz
        gaJ239SvQ2Gix740nZS8RFYrvTegf+DcLERjUKgULSG9ph2FjshM86TkU10G40U/
        ZibxH8v5npX7B9T1U9spS8Hqbl6gQ2hxoM++Y4oC3V+Ru6gO5Mgcs9GqZuuB9Sa1
        B2QUjpc+tAHf5221sVAzlI9xXqS+DYdMDOQWfha2R56vvjnwgFzJi+3kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=lM5Ud4VXnPfGE4e+o+afQ6u3rvTqVxQH5x8bdxJbj/U=; b=AqlcQWYg
        MO2piJYNJCv6ZkohbtXxE3nvvwGXpKQ5ngsH4V/nnUksWb/koS9tRBJyJMXa3Wit
        4feKyvzj8DKzlK/rNr9FPLORq0g9O/HgxtAxFsKuN4ONuuGIeaMd44G5yIM94c4b
        zcVYhd0vNTJ9RKxuwoECD2dPrqsOIqvvTnGY9VyO2FdlcbcUn2LRe2wg+pNZtYe9
        JHA3qfYY72Ua2WjAzN9GO4CapZa9waEQ6g6ck02F7cJ70BWscDpKbEVlKZQNwlyD
        ZTNj9ekrFe7H+rMmZLwEA6kYL7FPsg0kF0v4w/+4dDe6DjFZfSo3IsXcqbKtK7dl
        PnfOj0pUnaO3kw==
X-ME-Sender: <xms:PGHoYbLvKdEzLmKVrCJU-585Dx1CZzXWHYKm4MlWiqbcyd2WPlYwZw>
    <xme:PGHoYfIWQ1i0yiVnz0_UVoOiw0PQe2PFOr6d6rWS8L9xYt16e3j3_p-IT16oPkrnT
    8G4rBnFJ3MKoHGoZQ>
X-ME-Received: <xmr:PGHoYTuJptWLgBmxcSS12WKfaJ50afl2Nw0PpXOdnAkCsTDKX0Z5mJRa67__alOv_QUj1xFR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:PGHoYUbceoi1hG7hFjd9paFLam2W2Gts10O2ahpSWy6wXyyZ9XihQA>
    <xmx:PGHoYSZyAn8EzQPczFpW99oG01vfTC2jrhCsmvqkk42ck47gKg9YyQ>
    <xmx:PGHoYYBah_b6SaXXvWiu227uUXlSMW069sg3-IIJz0_h0ZTOudSntA>
    <xmx:PGHoYeSnrCRuPuAS-GJ0u94G0E09oTdUmkR1w833zlMVLQRRIy8SXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 14:06:36 -0500 (EST)
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
        Eric Ren <renzhengeek@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v4 2/7] mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
Date:   Wed, 19 Jan 2022 14:06:18 -0500
Message-Id: <20220119190623.1029355-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119190623.1029355-1-zi.yan@sent.com>
References: <20220119190623.1029355-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

has_unmovable_pages() is only used in mm/page_isolation.c. Move it from
mm/page_alloc.c and make it static.

Signed-off-by: Zi Yan <ziy@nvidia.com>
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
index 15de65215c02..1d812268c2a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8859,125 +8859,6 @@ void *__init alloc_large_system_hash(const char *ta=
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
index 6a0ddda6b3c5..6c841274bf46 100644
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

