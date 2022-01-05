Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50474485AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiAEVs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:48:28 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:54785 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234117AbiAEVsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:48:24 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0152D580510;
        Wed,  5 Jan 2022 16:48:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jan 2022 16:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=ssIavQd0t027n
        j+SJdZ+R89EjFohei8nsJIZDjq+gAc=; b=S0iFzugiHfWc3pkd+CZdBT6nLqkU1
        O293WHqzAfo4z2NG7KeyjrOwbHMOOslgSqp/nzgDYhgtHbQy1TP5B107IQwfKrV8
        sEDHbFP1mzRmf/bsMkZZ7+2pcaq0OjVwXSzmeIevlmdj0dGB74IDIhFKz9IeN+9N
        iEOV2a9f3zb+Q4MA+mVXYAU6GfHusjfsdpI8K78PATIFGaq7Y/d6Mq7pnJoAcUYA
        9t/UBNDiCl8irKYbP4TG3sHTQN1b3IZRkuFRYdHXRZtYVMgM7MLwU70CNVDKvBw8
        beX2PYbUiLK11zp70mQu+GnKdoHILPBnmmksVpxTSZHVqyVMG6Jdp07+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ssIavQd0t027nj+SJdZ+R89EjFohei8nsJIZDjq+gAc=; b=LJN2Ozob
        Zz3Qf1m9F8UnBOu76cytEY9asp+rvN52Rrd3ey/iblpRlyPSEJP8LwIE09PVGXL1
        HkPLjcnDoTYkde2g6ZdmiTjinrkRQchiWLtI0g86iG7g0bP3QS7t+ridmDGtdgrE
        C7k2cvCS03Lqd4KYR9k5z9ysNwlR1BFEwFeJoN4uFz3/XQ4C+/mXMtj2J/4nnRf3
        CGhK7Gqw5TiVw9sJW5LYNs2M+hd4v/dIjr9UmUd8Ofc85jh8ZMgWmMcJkeUwA361
        Mn8Zye4hve17YR89Pg0yBCRGikTbApdB58nmr7svo5XlODiH2tKtbvrz4pIM/xsp
        IfqqtAyzNHJAVA==
X-ME-Sender: <xms:JxLWYQbSKxIAWusdsMHZ_FG7eUghRU7XstJa5q08AhFFerrLgd8Qlw>
    <xme:JxLWYbbs1zTwsLBVFMzjzpz5WF_1SWSgdznOBsmDlbr7O_1OXQOQiENWTIPGdkq9n
    jqFaAUIMp0VjdNJWg>
X-ME-Received: <xmr:JxLWYa-lw4Fscui_UDsGBqRlOEPYosssifWw6MrwXLlh2eZGvWhYeIudyIyo2hzgJZjIafL_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkeeiue
    elvddtteeujeehtdegheejledvtdetgfeileejfeeghfeftdeuffefleevnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:JxLWYaoxYMvHsnXvpCaSL6KCABKiPtcGC1kCBtdgxQgM3hzbR9jG7A>
    <xmx:JxLWYbqlj3U3CRNn5_WhRG2yMjTJb1o4-qqFZ9Urr1coJUQeftfZYw>
    <xmx:JxLWYYRIbbG3nX84nApj3SGpItWPXibdLmG3XC4lE8WrdzYsVtc6GQ>
    <xmx:JxLWYZjsBQVwxOhfZolauoyF-SNlABtDCxJxm36gSI62B8WDkomczg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:23 -0500 (EST)
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
Subject: [RFC PATCH v3 1/8] mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
Date:   Wed,  5 Jan 2022 16:47:49 -0500
Message-Id: <20220105214756.91065-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105214756.91065-1-zi.yan@sent.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
It prepares for the upcoming removal of the MAX_ORDER-1 alignment
requirement for CMA and alloc_contig_range().

MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.

[1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.=
net/

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mmzone.h |  6 ++++++
 mm/page_alloc.c        | 28 ++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..0aa549653e4e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -83,6 +83,12 @@ static inline bool is_migrate_movable(int mt)
 	return is_migrate_cma(mt) || mt =3D=3D MIGRATE_MOVABLE;
 }
=20
+/* See fallbacks[MIGRATE_TYPES][3] in page_alloc.c */
+static inline bool migratetype_has_fallback(int mt)
+{
+	return mt < MIGRATE_PCPTYPES;
+}
+
 #define for_each_migratetype_order(order, type) \
 	for (order =3D 0; order < MAX_ORDER; order++) \
 		for (type =3D 0; type < MIGRATE_TYPES; type++)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8dd6399bafb5..5193c953dbf8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1042,6 +1042,12 @@ buddy_merge_likely(unsigned long pfn, unsigned long =
buddy_pfn,
 	return page_is_buddy(higher_page, higher_buddy, order + 1);
 }
=20
+static inline bool has_non_fallback_pageblock(struct zone *zone)
+{
+	return has_isolate_pageblock(zone) || zone_cma_pages(zone) !=3D 0 ||
+		zone->nr_reserved_highatomic !=3D 0;
+}
+
 /*
  * Freeing function for a buddy system allocator.
  *
@@ -1117,14 +1123,15 @@ static inline void __free_one_page(struct page *pag=
e,
 	}
 	if (order < MAX_ORDER - 1) {
 		/* If we are here, it means order is >=3D pageblock_order.
-		 * We want to prevent merge between freepages on isolate
-		 * pageblock and normal pageblock. Without this, pageblock
-		 * isolation could cause incorrect freepage or CMA accounting.
+		 * We want to prevent merge between freepages on pageblock
+		 * without fallbacks and normal pageblock. Without this,
+		 * pageblock isolation could cause incorrect freepage or CMA
+		 * accounting or HIGHATOMIC accounting.
 		 *
 		 * We don't want to hit this code for the more frequent
 		 * low-order merging.
 		 */
-		if (unlikely(has_isolate_pageblock(zone))) {
+		if (unlikely(has_non_fallback_pageblock(zone))) {
 			int buddy_mt;
=20
 			buddy_pfn =3D __find_buddy_pfn(pfn, order);
@@ -1132,8 +1139,8 @@ static inline void __free_one_page(struct page *page,
 			buddy_mt =3D get_pageblock_migratetype(buddy);
=20
 			if (migratetype !=3D buddy_mt
-					&& (is_migrate_isolate(migratetype) ||
-						is_migrate_isolate(buddy_mt)))
+					&& (!migratetype_has_fallback(migratetype) ||
+						!migratetype_has_fallback(buddy_mt)))
 				goto done_merging;
 		}
 		max_order =3D order + 1;
@@ -2484,6 +2491,7 @@ static int fallbacks[MIGRATE_TYPES][3] =3D {
 	[MIGRATE_UNMOVABLE]   =3D { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRA=
TE_TYPES },
 	[MIGRATE_MOVABLE]     =3D { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRA=
TE_TYPES },
 	[MIGRATE_RECLAIMABLE] =3D { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRA=
TE_TYPES },
+	[MIGRATE_HIGHATOMIC] =3D { MIGRATE_TYPES }, /* Never used */
 #ifdef CONFIG_CMA
 	[MIGRATE_CMA]         =3D { MIGRATE_TYPES }, /* Never used */
 #endif
@@ -2795,8 +2803,8 @@ static void reserve_highatomic_pageblock(struct page =
*page, struct zone *zone,
=20
 	/* Yoink! */
 	mt =3D get_pageblock_migratetype(page);
-	if (!is_migrate_highatomic(mt) && !is_migrate_isolate(mt)
-	    && !is_migrate_cma(mt)) {
+	/* Only reserve normal pageblock */
+	if (migratetype_has_fallback(mt)) {
 		zone->nr_reserved_highatomic +=3D pageblock_nr_pages;
 		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
 		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
@@ -3545,8 +3553,8 @@ int __isolate_free_page(struct page *page, unsigned i=
nt order)
 		struct page *endpage =3D page + (1 << order) - 1;
 		for (; page < endpage; page +=3D pageblock_nr_pages) {
 			int mt =3D get_pageblock_migratetype(page);
-			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
-			    && !is_migrate_highatomic(mt))
+			/* Only change normal pageblock */
+			if (migratetype_has_fallback(mt))
 				set_pageblock_migratetype(page,
 							  MIGRATE_MOVABLE);
 		}
--=20
2.34.1

