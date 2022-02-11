Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DB84B2B03
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351782AbiBKQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:51:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351725AbiBKQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:51:04 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0ED66
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:51:00 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5D48B580370;
        Fri, 11 Feb 2022 11:41:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 11 Feb 2022 11:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=VmPT36pm2xq5yd
        UOBiaL9nltkdkN6llWorno9T9IDyQ=; b=gjNNte4q1d4v+zBAgXRrePdkoW1H4l
        cp4SLrXaD7/hBHSQU+GTtrSHPrtTpLWBXU0iho6p/fgEzTzkh4Z4iMVfjk16lutA
        5j9Hlazcih/ZKI3nvorGmS6ywhZFxBY3EkTbzvXGHtm35zCqe5MBFxzAOHqdLipC
        kre5T75+9ymWOBNVxEk5uGfafdFEjt9Hri/ZSetb/zQ0a+s5YWqVS21UAPXRo1Dh
        n6wNHhapury/lMghBN1A/cBrBVz4tCvR7cZGEoeLzce9amd9WETozw8EUfUcjdbc
        AkTU2QdV649URYhhIkuycO+oDOFp9Vs7r37uPZSR62NJXuCOPWJNXO/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=VmPT36pm2xq5ydUOBiaL9nltkdkN6llWorno9T9IDyQ=; b=FSsiyz6A
        EPX4XaXrPUTS1uBVvUOpncx1QpHqeEl4ibTl6B2K2plQPADaWCy+rnMKMLzQY41X
        gDNl78Vhk9G9RmlFGDo08XEGRFcNktJYTaPNLTnDzcZx3hViFgd/gt1X1BX9PT2h
        iFc86lsB+ALlm9mCOa5Q9fiPJd4UzIEF9LrANIFJRhhYbok1RdtbdJWi0SeclhXq
        BHaFSKwUYR5bFy1Fxbd08NwTC6sOYGEz5k7UwvBFPnHf4WIPsBUrTePZsNK/Idj+
        I123q92IRISyVAKQEkQ/p3JYwhifNHYBczl8jbI8Gi+TSbJ1K0n+72jm/fJ74uEi
        9nt0DkgT7IIQQA==
X-ME-Sender: <xms:ypEGYvEJgWbr8MXxdG2E9fWVHFlWbWXYK2loF5wmz459dhCWxVLTKQ>
    <xme:ypEGYsXdAQTWzchsYcMgHYo9qE4C3xKjG_TZUd_gQQSi0ofcT4o4XY9MdJw8Z3RsF
    kAwj033twRAqxYSqg>
X-ME-Received: <xmr:ypEGYhLDBqHSXFakRkANNJKKc9xAHw6RKVsnncD6BjQiaDJl0uMcDqWmEde-hqjpVpMHO-pV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:ypEGYtGmnlgqrMYARsAJ2KYQTWPMfLnM2-jPl9BjaAPlYUvhPwa3tw>
    <xmx:ypEGYlWRXIhUU5rrrLaH9OYTdKqqf8shXvjZLy9Bcr-psT7ycGsWLA>
    <xmx:ypEGYoPbPmvvWTcT6iqpGpNgiJmBV6tP297D2B1kPmZ-FOVdxUb05A>
    <xmx:ypEGYmsxmfkU1dw0SUa0tZXfLaKKT1AEYe7j4i6fBnCOBsV9rG82sQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:45 -0500 (EST)
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
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v5 1/6] mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
Date:   Fri, 11 Feb 2022 11:41:30 -0500
Message-Id: <20220211164135.1803616-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211164135.1803616-1-zi.yan@sent.com>
References: <20220211164135.1803616-1-zi.yan@sent.com>
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
index cface1d38093..e2c6a67fc386 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8962,125 +8962,6 @@ void *__init alloc_large_system_hash(const char *ta=
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

