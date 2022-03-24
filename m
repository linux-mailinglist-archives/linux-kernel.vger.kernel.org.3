Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FE14E6AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355495AbiCXWqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbiCXWqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:46:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C7AB6E44
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:44:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 67FF15C0194;
        Thu, 24 Mar 2022 18:44:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 24 Mar 2022 18:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=Lu9+y7/OA8vzrI
        JEVfxTWNNqIdwqiBgzFUZF7HyFHFY=; b=yyzvg03EkvLu5ylQIGcqrVSHyCKg3m
        l1iF5ykmC1otScAYznKAGrwaS32THrBeFsC76HKFrmX/uDr9FsZIe847jNRZ8bIq
        8ya+ikcW6ckyD45ZamVOfSx+K9+xeKnz2XYXBfAcb7eRE0dFP+npuDZ0x3o0jYwo
        SzoFIGN+peiqH4zuOOnJYtwKH7W2nloLZxsOdp25bqIM75b3SqZdgYA5s3/kHVF9
        +Hu1v9VbfcwgGu+VjH+I02WCaaHy8T3j+tVYmwnG6dNT7ajC5MFvLRyyNNeApRlQ
        QziKWaq3YWwmO2AtBvKkLeO8RgknN3wJ/Xa88X/RNQgS66hc9JiFIEqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Lu9+y7/OA8vzrIJEVfxTWNNqIdwqiBgzFUZF7HyFHFY=; b=MoCGNkIf
        nna3AndZwp2mZeLc1fdv/d/c/lYq5p2Kn1ipQfwdnGNlZBKmOyftfY4my+Dqduve
        pJUsqN7DyOTwDZScDUEKiCthWLC2A/VOeVvnFxJoH7QBf0YXP0rifBKpdh03Sg/b
        KM05FUfVYrkNSymCDILiO9u1JkWg673rjEoV3sZdX0wNuEzC2vZlYw/0rnoA80mo
        rEpS44pJ0iq7OeRJw+PUbAOVbo5+hGlK/ewx0lxInn8IE9gVSlfR9PkkdO7//DxL
        crPghJCqRAM+wDo7FIZgN51E2TmS9QdGvk+VSsJ/+txgV6tuI35Fld1/KjjWQqYL
        anZoGKHztfg9Bg==
X-ME-Sender: <xms:WPQ8YqXuEf2aBl4x08DEabfb8mvTE2ktLZRfQVM13iXw7avHpwZeHQ>
    <xme:WPQ8Ymn2HDvfiJ-Ffpe_vxMoyFvFFW9oBaxayszjoK2c7N7IdLiN6apBU8qQ_i6a2
    uk06i80DrlEM7MbgA>
X-ME-Received: <xmr:WPQ8YuaY415Gq_wO92hIpwfKtclgAv0rStpUlVzGJt-cuupvqrTTPzaDl3TleRYmBZyOLH0kpYMWlQiwBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeije
    euvdeuudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:WPQ8YhUqMo8XHyMU2qjCE-UH3_NgH6KI-XOfQBNvlMHCVgYfFM-ASQ>
    <xmx:WPQ8YkmNykcnv8kasphJiR8Rpqzf7ME4m00IJjb9Dpf4anfXAMHPDA>
    <xmx:WPQ8YmdaYJqPDNLjaJmr-cJshFR2sm7TEReJupkOg8ZLTW61pQGYhg>
    <xmx:WPQ8YtcDA8V4mdTmBM7ky61FBsIlA2zL3vUyduwgTYx7kiSn157s7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 18:44:39 -0400 (EDT)
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
Subject: [PATCH v9 1/5] mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
Date:   Thu, 24 Mar 2022 18:44:31 -0400
Message-Id: <20220324224435.17794-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324224435.17794-1-zi.yan@sent.com>
References: <20220324224435.17794-1-zi.yan@sent.com>
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

