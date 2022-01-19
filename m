Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F171849405D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiASTHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:07:20 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45505 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356987AbiASTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:06:39 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 057355806B8;
        Wed, 19 Jan 2022 14:06:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 19 Jan 2022 14:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=kGtmOv43gwxP+
        UrqqToKaIeWhe55nyzJ26XM081ht/o=; b=pR8fSDwb1tom9FXFNCKfHmdgbCuou
        e8ojq7E1qnAGz2bVqi2nqAG6E/frrQu1kLNmsAMSpZhTDxu1oH5d8LtYC1XOlTGy
        fAwwfoRMDF/jpk+iCIv/8hEVAoJoq2ypghxoxz2y5ie5rXFs/uzt4d1zhh7QGSdN
        Fz3HRr8O15SG1Huwtnl5WWmE2tkWb+2S/iFuaR3Lo9CLENvlUKq+GGkYdxp6xR11
        R5Jonprnf9TfVPhp1IDJ3KDQ9r/CUBehj/+lljZQ/6Gl4Py3S0Fp5vMkFtepaLPz
        gl1k1GRg9mnDo7UVcKymSdJp8jp/CCUkANGGotRRjn6/K6rpZXp0S7pyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=kGtmOv43gwxP+UrqqToKaIeWhe55nyzJ26XM081ht/o=; b=KnSJwE88
        NxfaG8VY+dc36U/RojAYjdAD1BGJm7jf4ppQ6ezozYCE436Yiq8EOsKyguh73YQN
        6XZiRobN/b3RqLmTNxCH3NuXvJbXohkRKD3LlnlJGsBlYIxjuKf54AwRD0aMaqRn
        8VcVK8fbNlR07a89cakGO+oK3q04Htz8kro1FL3Ck8h3+DNnbRrYIMx5P0JufLCU
        H0AA/Edk4DQhO0ubVcIZGRTReayrmtutO1iXEcb+R5pGnj0yplHUBmYbQewYX3rX
        rzLQuVrpionLY0p0Wk8coVQjyZXFzvxYH2euXpQxOeRhlvW0BglaP33f9t9WOExx
        hXODMmRwv/NyZQ==
X-ME-Sender: <xms:PWHoYaM73SogHMpxNSxZl-KvuJfKnqAuEEB5oqMHrmGKyXYqexthWA>
    <xme:PWHoYY_yAKAgM7VaVWiztbBamPuCxzExNOILnj8nPSztBZLyfOuE8kpjDCqsKHIX5
    dyyPxR8le6bAIoCEQ>
X-ME-Received: <xmr:PWHoYRQZiI9p084WFC0HnaAIUZ3-EF3toMH61PTZj-5mhBWe8GZTJqWSioLl3E7P_22mexO2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:PWHoYasRzh7ExqZ-4wwLkNKtIs7TU9inqG0T0tFGqv1TNmFhTUqTyA>
    <xmx:PWHoYSfshBHx3ynXcqJOkrmsHQGxT6JojD62Qy-ntl5BVJHydK7D6w>
    <xmx:PWHoYe0ynuijp-QZdnLwtgMA1AeCY_929vCYOSiPa1g6QDE4lm7GAw>
    <xmx:PmHoYY2oFuP4Sn_jE4hQh2TX8hG1y7L1V7ePFZ_Tr4oGNNoLOem-DA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 14:06:37 -0500 (EST)
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
Subject: [PATCH v4 4/7] mm: make alloc_contig_range work at pageblock granularity
Date:   Wed, 19 Jan 2022 14:06:20 -0500
Message-Id: <20220119190623.1029355-5-zi.yan@sent.com>
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

alloc_contig_range() worked at MAX_ORDER-1 granularity to avoid merging
pageblocks with different migratetypes. It might unnecessarily convert
extra pageblocks at the beginning and at the end of the range. Change
alloc_contig_range() to work at pageblock granularity.

It is done by restoring pageblock types and split >pageblock_order free
pages after isolating at MAX_ORDER-1 granularity and migrating pages
away at pageblock granularity. The reason for this process is that
during isolation, some pages, either free or in-use, might have >pageblock
sizes and isolating part of them can cause free accounting issues.
Restoring the migratetypes of the pageblocks not in the interesting
range later is much easier.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c | 175 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 155 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 812cf557b20f..6ed506234efa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8862,8 +8862,8 @@ void *__init alloc_large_system_hash(const char *tabl=
ename,
 #ifdef CONFIG_CONTIG_ALLOC
 static unsigned long pfn_max_align_down(unsigned long pfn)
 {
-	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
-			     pageblock_nr_pages) - 1);
+	return ALIGN_DOWN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
+				     pageblock_nr_pages));
 }
=20
 static unsigned long pfn_max_align_up(unsigned long pfn)
@@ -8952,6 +8952,52 @@ static int __alloc_contig_migrate_range(struct compa=
ct_control *cc,
 	return 0;
 }
=20
+static inline int save_migratetypes(unsigned char *migratetypes,
+				unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long pfn =3D start_pfn;
+	int num =3D 0;
+
+	while (pfn < end_pfn) {
+		migratetypes[num] =3D get_pageblock_migratetype(pfn_to_page(pfn));
+		num++;
+		pfn +=3D pageblock_nr_pages;
+	}
+	return num;
+}
+
+static inline int restore_migratetypes(unsigned char *migratetypes,
+				unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long pfn =3D start_pfn;
+	int num =3D 0;
+
+	while (pfn < end_pfn) {
+		set_pageblock_migratetype(pfn_to_page(pfn), migratetypes[num]);
+		num++;
+		pfn +=3D pageblock_nr_pages;
+	}
+	return num;
+}
+
+static inline void split_free_page_into_pageblocks(struct page *free_page,
+				int order, struct zone *zone)
+{
+	unsigned long pfn;
+
+	spin_lock(&zone->lock);
+	del_page_from_free_list(free_page, zone, order);
+	for (pfn =3D page_to_pfn(free_page);
+	     pfn < page_to_pfn(free_page) + (1UL << order);
+	     pfn +=3D pageblock_nr_pages) {
+		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
+
+		__free_one_page(pfn_to_page(pfn), pfn, zone, pageblock_order,
+				mt, FPI_NONE);
+	}
+	spin_unlock(&zone->lock);
+}
+
 /**
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
@@ -8977,8 +9023,15 @@ int alloc_contig_range(unsigned long start, unsigned=
 long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
+	unsigned long isolate_start =3D pfn_max_align_down(start);
+	unsigned long isolate_end =3D pfn_max_align_up(end);
+	unsigned long alloc_start =3D ALIGN_DOWN(start, pageblock_nr_pages);
+	unsigned long alloc_end =3D ALIGN(end, pageblock_nr_pages);
+	unsigned long num_pageblock_to_save;
 	unsigned int order;
 	int ret =3D 0;
+	unsigned char *saved_mt;
+	int num;
=20
 	struct compact_control cc =3D {
 		.nr_migratepages =3D 0,
@@ -8992,11 +9045,30 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
=20
+	/*
+	 * TODO: make MIGRATE_ISOLATE a standalone bit to avoid overwriting
+	 * the exiting migratetype. Then, we will not need the save and restore
+	 * process here.
+	 */
+
+	/* Save the migratepages of the pageblocks before start and after end */
+	num_pageblock_to_save =3D (alloc_start - isolate_start) / pageblock_nr_pa=
ges
+				+ (isolate_end - alloc_end) / pageblock_nr_pages;
+	saved_mt =3D
+		kmalloc_array(num_pageblock_to_save,
+			      sizeof(unsigned char), GFP_KERNEL);
+	if (!saved_mt)
+		return -ENOMEM;
+
+	num =3D save_migratetypes(saved_mt, isolate_start, alloc_start);
+
+	num =3D save_migratetypes(&saved_mt[num], alloc_end, isolate_end);
+
 	/*
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
 	 * have different sizes, and due to the way page allocator
-	 * work, we align the range to biggest of the two pages so
+	 * work, we align the isolation range to biggest of the two so
 	 * that page allocator won't try to merge buddies from
 	 * different pageblocks and change MIGRATE_ISOLATE to some
 	 * other migration type.
@@ -9006,6 +9078,20 @@ int alloc_contig_range(unsigned long start, unsigned=
 long end,
 	 * we are interested in).  This will put all the pages in
 	 * range back to page allocator as MIGRATE_ISOLATE.
 	 *
+	 * Afterwards, we restore the migratetypes of the pageblocks not
+	 * in range, split free pages spanning outside the range,
+	 * and put split free pages (at pageblock_order) to the right
+	 * migratetype list.
+	 *
+	 * NOTE: the above approach is used because it can cause free
+	 * page accounting issues during isolation, if a page, either
+	 * free or in-use, contains multiple pageblocks and we only
+	 * isolate a subset of them. For example, if only the second
+	 * pageblock is isolated from a page with 2 pageblocks, after
+	 * the page is free, it will be put in the first pageblock
+	 * migratetype list instead of having 2 pageblocks in two
+	 * separate migratetype lists.
+	 *
 	 * When this is done, we take the pages in range from page
 	 * allocator removing them from the buddy system.  This way
 	 * page allocator will never consider using them.
@@ -9016,10 +9102,10 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
=20
-	ret =3D start_isolate_page_range(start, end, pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+	ret =3D start_isolate_page_range(start, end, isolate_start, isolate_end,
+				migratetype, 0);
 	if (ret)
-		return ret;
+		goto done;
=20
 	drain_all_pages(cc.zone);
=20
@@ -9055,6 +9141,19 @@ int alloc_contig_range(unsigned long start, unsigned=
 long end,
 	 * isolated thus they won't get removed from buddy.
 	 */
=20
+	/*
+	 * Restore migratetypes of pageblocks outside [start, end)
+	 * TODO: remove it when MIGRATE_ISOLATE becomes a standalone bit
+	 */
+
+	num =3D restore_migratetypes(saved_mt, isolate_start, alloc_start);
+
+	num =3D restore_migratetypes(&saved_mt[num], alloc_end, isolate_end);
+
+	/*
+	 * Split free page spanning [isolate_start, alloc_start) and put the
+	 * pageblocks in the right migratetype lists.
+	 */
 	order =3D 0;
 	outer_start =3D start;
 	while (!PageBuddy(pfn_to_page(outer_start))) {
@@ -9069,37 +9168,73 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 		order =3D buddy_order(pfn_to_page(outer_start));
=20
 		/*
-		 * outer_start page could be small order buddy page and
-		 * it doesn't include start page. Adjust outer_start
-		 * in this case to report failed page properly
-		 * on tracepoint in test_pages_isolated()
+		 * split the free page has start page and put the pageblocks
+		 * in the right migratetype list
 		 */
-		if (outer_start + (1UL << order) <=3D start)
-			outer_start =3D start;
+		if (outer_start + (1UL << order) > start) {
+			struct page *free_page =3D pfn_to_page(outer_start);
+
+			split_free_page_into_pageblocks(free_page, order, cc.zone);
+		}
+	}
+
+	/*
+	 * Split free page spanning [alloc_end, isolate_end) and put the
+	 * pageblocks in the right migratetype list
+	 */
+	for (outer_end =3D alloc_end; outer_end < isolate_end;) {
+		unsigned long begin_pfn =3D outer_end;
+
+		order =3D 0;
+		while (!PageBuddy(pfn_to_page(outer_end))) {
+			if (++order >=3D MAX_ORDER) {
+				outer_end =3D begin_pfn;
+				break;
+			}
+			outer_end &=3D ~0UL << order;
+		}
+
+		if (outer_end !=3D begin_pfn) {
+			order =3D buddy_order(pfn_to_page(outer_end));
+
+			/*
+			 * split the free page has start page and put the pageblocks
+			 * in the right migratetype list
+			 */
+			VM_BUG_ON(outer_end + (1UL << order) <=3D begin_pfn);
+			{
+				struct page *free_page =3D pfn_to_page(outer_end);
+
+				split_free_page_into_pageblocks(free_page, order, cc.zone);
+			}
+			outer_end +=3D 1UL << order;
+		} else
+			outer_end =3D begin_pfn + 1;
 	}
=20
 	/* Make sure the range is really isolated. */
-	if (test_pages_isolated(outer_start, end, 0)) {
+	if (test_pages_isolated(alloc_start, alloc_end, 0)) {
 		ret =3D -EBUSY;
 		goto done;
 	}
=20
 	/* Grab isolated pages from freelists. */
-	outer_end =3D isolate_freepages_range(&cc, outer_start, end);
+	outer_end =3D isolate_freepages_range(&cc, alloc_start, alloc_end);
 	if (!outer_end) {
 		ret =3D -EBUSY;
 		goto done;
 	}
=20
 	/* Free head and tail (if any) */
-	if (start !=3D outer_start)
-		free_contig_range(outer_start, start - outer_start);
-	if (end !=3D outer_end)
-		free_contig_range(end, outer_end - end);
+	if (start !=3D alloc_start)
+		free_contig_range(alloc_start, start - alloc_start);
+	if (end !=3D alloc_end)
+		free_contig_range(end, alloc_end - end);
=20
 done:
-	undo_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype);
+	kfree(saved_mt);
+	undo_isolate_page_range(alloc_start,
+				alloc_end, migratetype);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
--=20
2.34.1

