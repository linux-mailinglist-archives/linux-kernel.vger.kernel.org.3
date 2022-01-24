Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35A49877A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244808AbiAXSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:00:34 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48995 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244845AbiAXSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:00:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A192D5C0185;
        Mon, 24 Jan 2022 13:00:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Jan 2022 13:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=9BrsfCn9GsbUXkbFEX9irdBIf/KH/bhctKCCvd
        Cg07k=; b=UDVNR59FzCrmekkSFf9nlBqhIeYL5fwLKwYUWcjdA/EzpS5oq6b0GZ
        DnxH7b3zhhwWOhv2bdwRwgHHAqMVOaxiVNcM6TQVtmL2xwyBjHI0Ou7CDC8zbbkh
        Ml0wc9IaYopbl2dgH0wgCche6RQrdiT9BD982pf/MhA7qQ99xKtNhuD1PFgwjVhL
        0s/BmiZE/OZhf1//5cOSSbJHS38IJGcGZOcOsvAPYz+RyCrkapQ5u48lzoKh8i+y
        w3tE+yphSFjUy0lYpeTfkayo3Ja96pOs5VfJQig1tGzQ2XzuAiTa7gEMuRMsnk07
        Eo+utaZ8mwFE2hDU2GqbQuG58H+4HnOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=9BrsfCn9GsbUXkbFEX9irdBIf/KH/
        bhctKCCvdCg07k=; b=d2s/UswaHW+LI5SwBcV6QOLHf+n/f+3vMQSg+VCLQgdbu
        +WbqBeV5IkczRYziH4HY0OqXH1hkXbszcuomvd89hiWjYIPXdr3CsmyqigEMJlSC
        M3cybLBo4F+xM8FQanh9FTSctJLsTpR5YxJW0XAicNTEh2fs7huP9DFlmaLCeQfg
        +6n/gAucDQb+BTqzgXQl+0g4tP8s+zlp/ki/fA7lVKlfep7RUf9VqVhJP8Ep3/66
        GBQWkU0IEghs+NY6mLH6IIxqI+T5yBaq6t1LNNuwvfDZN9lg1XDKRuQyKOn4HyKP
        N0zphFm4Qhow7NIjrO/+tZI+SzVA03g9tKQ4Y9XwQ==
X-ME-Sender: <xms:K-nuYazO8kY3_9pmlwCJz29Pfwl2kdpHmhmDdVWm_3Z4sk65pQm5kA>
    <xme:K-nuYWSjllHIHwPd0sP5CenkLta6_tHe9_7R7UTtrkVVzoxrpgZu7UhNrHu4aS4ee
    JBhV6LUEk_NorIOGA>
X-ME-Received: <xmr:K-nuYcXBf2NhbwuiC03nno0x8tc1BnDbt2-tlnPIlZ6fIANCMFL8s6v3K0BKLCaT2p6O5Dxz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteeiiedtje
    fghfefueekjedvueeftddvudelhfetudffiefgfeetheeghfdvgedunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:K-nuYQjr--EaX431uykRox1POsVQwBfhSuECvp0QK_qOmMHTGXkvTA>
    <xmx:K-nuYcAGEGVJVd0KPQuzj05KkDX0Q5glUGwNvC3R0cD-o9tShh07Pw>
    <xmx:K-nuYRL8yacAaMuqDaV9uAvTVVVpNN4gPBSNWy82NUe2Qqv8lgZbTQ>
    <xmx:K-nuYe02obor-UJ1sd8Fugrl3rYNd9yM8oYWT02sLApgethpDnKWBw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 13:00:10 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
Date:   Mon, 24 Jan 2022 12:59:57 -0500
Message-Id: <20220124175957.1261961-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
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

Remove MIGRARTE_CMA and MIGRATE_ISOLATE from fallbacks list, since they
are never used.

[1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.=
net/

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h | 11 +++++++++++
 mm/page_alloc.c        | 44 ++++++++++++++++++++----------------------
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..71b77aab748d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -83,6 +83,17 @@ static inline bool is_migrate_movable(int mt)
 	return is_migrate_cma(mt) || mt =3D=3D MIGRATE_MOVABLE;
 }
=20
+/*
+ * Check whether a migratetype can be merged with another migratetype.
+ *
+ * It is only mergeable when it can fall back to other migratetypes for
+ * allocation. See fallbacks[MIGRATE_TYPES][3] in page_alloc.c.
+ */
+static inline bool migratetype_is_mergeable(int mt)
+{
+	return mt < MIGRATE_PCPTYPES;
+}
+
 #define for_each_migratetype_order(order, type) \
 	for (order =3D 0; order < MAX_ORDER; order++) \
 		for (type =3D 0; type < MIGRATE_TYPES; type++)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8dd6399bafb5..5a91d4d9279a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1117,25 +1117,24 @@ static inline void __free_one_page(struct page *pag=
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
-			int buddy_mt;
+		int buddy_mt;
=20
-			buddy_pfn =3D __find_buddy_pfn(pfn, order);
-			buddy =3D page + (buddy_pfn - pfn);
-			buddy_mt =3D get_pageblock_migratetype(buddy);
+		buddy_pfn =3D __find_buddy_pfn(pfn, order);
+		buddy =3D page + (buddy_pfn - pfn);
+		buddy_mt =3D get_pageblock_migratetype(buddy);
=20
-			if (migratetype !=3D buddy_mt
-					&& (is_migrate_isolate(migratetype) ||
-						is_migrate_isolate(buddy_mt)))
-				goto done_merging;
-		}
+		if (migratetype !=3D buddy_mt
+				&& (!migratetype_is_mergeable(migratetype) ||
+					!migratetype_is_mergeable(buddy_mt)))
+			goto done_merging;
 		max_order =3D order + 1;
 		goto continue_merging;
 	}
@@ -2479,17 +2478,13 @@ struct page *__rmqueue_smallest(struct zone *zone, =
unsigned int order,
 /*
  * This array describes the order lists are fallen back to when
  * the free lists for the desirable migrate type are depleted
+ *
+ * The other migratetypes do not have fallbacks.
  */
 static int fallbacks[MIGRATE_TYPES][3] =3D {
 	[MIGRATE_UNMOVABLE]   =3D { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRA=
TE_TYPES },
 	[MIGRATE_MOVABLE]     =3D { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRA=
TE_TYPES },
 	[MIGRATE_RECLAIMABLE] =3D { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRA=
TE_TYPES },
-#ifdef CONFIG_CMA
-	[MIGRATE_CMA]         =3D { MIGRATE_TYPES }, /* Never used */
-#endif
-#ifdef CONFIG_MEMORY_ISOLATION
-	[MIGRATE_ISOLATE]     =3D { MIGRATE_TYPES }, /* Never used */
-#endif
 };
=20
 #ifdef CONFIG_CMA
@@ -2795,8 +2790,8 @@ static void reserve_highatomic_pageblock(struct page =
*page, struct zone *zone,
=20
 	/* Yoink! */
 	mt =3D get_pageblock_migratetype(page);
-	if (!is_migrate_highatomic(mt) && !is_migrate_isolate(mt)
-	    && !is_migrate_cma(mt)) {
+	/* Only reserve normal pageblocks (i.e., they can merge with others) */
+	if (migratetype_is_mergeable(mt)) {
 		zone->nr_reserved_highatomic +=3D pageblock_nr_pages;
 		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
 		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
@@ -3545,8 +3540,11 @@ int __isolate_free_page(struct page *page, unsigned =
int order)
 		struct page *endpage =3D page + (1 << order) - 1;
 		for (; page < endpage; page +=3D pageblock_nr_pages) {
 			int mt =3D get_pageblock_migratetype(page);
-			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
-			    && !is_migrate_highatomic(mt))
+			/*
+			 * Only change normal pageblocks (i.e., they can merge
+			 * with others)
+			 */
+			if (migratetype_is_mergeable(mt))
 				set_pageblock_migratetype(page,
 							  MIGRATE_MOVABLE);
 		}
--=20
2.34.1

