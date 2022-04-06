Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A94E4F67B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiDFRWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbiDFRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:21:11 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F444758F2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:19:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 164BF32020DA;
        Wed,  6 Apr 2022 11:19:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Apr 2022 11:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm3; bh=RGYRT
        asxd5Dpa8d83L6RL9egVJEMDVpoACx03JYFGm8=; b=MU5uPcobAVieisNagCPhQ
        cV2ywxv7LhC4euJ6AYNgE6TKw2mYsf9OvSglwA1EmhAkcdVrhNGgWO+6bw7cY+G3
        oFN5rPzy2KPqe9zR0rLWpH4xQJtGSg6aB1ftX/I6W2Ptp/VbE587ALkgBuuVKYv4
        RMsxmq5a9ImlZG4Ki9d/wMgwPM/MqczjWOzXkTUm1YfD8My/OtKzMSHV8pqhIB+N
        knU77s7zVkkOTO+T9MeDSzfzFTspjaFQGo29pUzzOXrOv5e/3uRn6ciRILoAdszu
        dm5WQ5vRMhhSydHl0KsMs2KatfffkILknOclB8addfQ21tSx4SEpTY5DSnqxZfal
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=RGYRTasxd5Dpa8d83L6RL9egVJEMD
        VpoACx03JYFGm8=; b=Sekc3kjT//xWXbSNoj4AXd2XJ9R1JpnK+Ps7iOr60n8tw
        ZXs2rOGOtYExG4VXf0IHpPeuc9Q0/pE/UNrk41LMu1rmea0e2INsjfbWJ/nTnKrD
        UOOfTCWp7N1ELZde6uY9M7yA9a/sFk/tlKEp3Xn5z5ajm62dbORUlhpITgNGQN6c
        VIZ7DQTgXwVifMsFXSu5xhqFBnB3+lUBA8aFjpqjeQDE/axKMB4sRK5gdSxNzbdD
        r16W7GLcYforeVKgM6XpboGwl/5T82wHmXz2QDItgeCffBsdJGu9ivLUP8W+4g84
        XfvJFI26hZuV5ajQ+cW7CobuUoSruBbeuEti42hHg==
X-ME-Sender: <xms:jK9NYs2BDhS3mruxE-xkJVIpWL3yIA5pQTrXfudN9ikDsRpvyzFEug>
    <xme:jK9NYnGOvUn6T5F1QkEAnq7WM7RX9SvOwOfM6WeCzbYh6nK85js-G-VJGWq2t0VCG
    213T_iUAWgc18oxhw>
X-ME-Received: <xmr:jK9NYk6EO_lXj0re7p_K6qA-lgg9yjbMcM4dsN8zgo6LQhc_My0SLkDlF4Pk9PFvMDRqx0pxwly1lijipA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgf
    fgleejfeegjedttefhhedvgfffvdeffeekjeetgffhtedvudffkeegleettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:jK9NYl3VAHiv8xN5TBi8SkffIWCo6-TvXRwlB0DIAk2-yhKqcmlJDQ>
    <xmx:jK9NYvEqDGzYRzzrWQ8dVGLwYqGUZj6vwR_mCloHEr5Hx9K3luZdkA>
    <xmx:jK9NYu9q1QRciNs8wy4wlIw7APsvYDjToo9goBIYfzTdpJr3Wh6-hQ>
    <xmx:jK9NYmAHGiX82c9pRJM3vGfknze0goQ0vzMe1wEpYOad2R_fFh8GUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Apr 2022 11:19:40 -0400 (EDT)
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
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 2/5] mm: page_isolation: check specified range for unmovable pages
Date:   Wed,  6 Apr 2022 11:18:55 -0400
Message-Id: <20220406151858.3149821-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406151858.3149821-1-zi.yan@sent.com>
References: <20220406151858.3149821-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Enable set_migratetype_isolate() to check specified sub-range for
unmovable pages during isolation. Page isolation is done
at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
granularity are intended to be isolated. For example,
alloc_contig_range(), which uses page isolation, allows ranges without
alignment. This commit makes unmovable page check only look for
interesting pages, so that page isolation can succeed for any
non-overlapping ranges.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c     | 16 ++--------
 mm/page_isolation.c | 78 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dafef8099acd..cacb2a16145e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8873,16 +8873,6 @@ void *__init alloc_large_system_hash(const char *tab=
lename,
 }
=20
 #ifdef CONFIG_CONTIG_ALLOC
-static unsigned long pfn_max_align_down(unsigned long pfn)
-{
-	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
-}
-
-static unsigned long pfn_max_align_up(unsigned long pfn)
-{
-	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
-}
-
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 /* Usage: See admin-guide/dynamic-debug-howto.rst */
@@ -9027,8 +9017,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
=20
-	ret =3D start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+	ret =3D start_isolate_page_range(start, end, migratetype, 0);
 	if (ret)
 		return ret;
=20
@@ -9109,8 +9098,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 		free_contig_range(end, outer_end - end);
=20
 done:
-	undo_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype);
+	undo_isolate_page_range(start, end, migratetype);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index df49f86a6ed1..b8f96ed49d8b 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -16,7 +16,9 @@
 #include <trace/events/page_isolation.h>
=20
 /*
- * This function checks whether pageblock includes unmovable pages or not.
+ * This function checks whether the range [start_pfn, end_pfn) includes
+ * unmovable pages or not. The range must fall into a single pageblock and
+ * consequently belong to a single zone.
  *
  * PageLRU check without isolation or lru_lock could race so that
  * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
@@ -28,12 +30,14 @@
  * cannot get removed (e.g., via memory unplug) concurrently.
  *
  */
-static struct page *has_unmovable_pages(struct zone *zone, struct page *pa=
ge,
-				 int migratetype, int flags)
+static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned =
long end_pfn,
+				int migratetype, int flags)
 {
-	unsigned long iter =3D 0;
-	unsigned long pfn =3D page_to_pfn(page);
-	unsigned long offset =3D pfn % pageblock_nr_pages;
+	unsigned long pfn =3D start_pfn;
+	struct page *page =3D pfn_to_page(pfn);
+
+	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=3D
+		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
=20
 	if (is_migrate_cma_page(page)) {
 		/*
@@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct zone *zon=
e, struct page *page,
 		return page;
 	}
=20
-	for (; iter < pageblock_nr_pages - offset; iter++) {
-		page =3D pfn_to_page(pfn + iter);
+	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
+		struct zone *zone;
+
+		page =3D pfn_to_page(pfn);
+		zone =3D page_zone(page);
=20
 		/*
 		 * Both, bootmem allocations and memory holes are marked
@@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct zone *zone=
, struct page *page,
 			}
=20
 			skip_pages =3D compound_nr(head) - (page - head);
-			iter +=3D skip_pages - 1;
+			pfn +=3D skip_pages - 1;
 			continue;
 		}
=20
@@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct zone *zon=
e, struct page *page,
 		 */
 		if (!page_ref_count(page)) {
 			if (PageBuddy(page))
-				iter +=3D (1 << buddy_order(page)) - 1;
+				pfn +=3D (1 << buddy_order(page)) - 1;
 			continue;
 		}
=20
@@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(struct zone *=
zone, struct page *page,
 	return NULL;
 }
=20
-static int set_migratetype_isolate(struct page *page, int migratetype, int=
 isol_flags)
+/*
+ * This function set pageblock migratetype to isolate if no unmovable page=
 is
+ * present in [start_pfn, end_pfn). The pageblock must intersect with
+ * [start_pfn, end_pfn).
+ */
+static int set_migratetype_isolate(struct page *page, int migratetype, int=
 isol_flags,
+			unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct zone *zone =3D page_zone(page);
 	struct page *unmovable;
 	unsigned long flags;
+	unsigned long check_unmovable_start, check_unmovable_end;
=20
 	spin_lock_irqsave(&zone->lock, flags);
=20
@@ -155,8 +169,16 @@ static int set_migratetype_isolate(struct page *page, =
int migratetype, int isol_
 	/*
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
+	 *
+	 * Pass the intersection of [start_pfn, end_pfn) and the page's pageblock
+	 * to avoid redundant checks.
 	 */
-	unmovable =3D has_unmovable_pages(zone, page, migratetype, isol_flags);
+	check_unmovable_start =3D max(page_to_pfn(page), start_pfn);
+	check_unmovable_end =3D min(ALIGN(page_to_pfn(page) + 1, pageblock_nr_pag=
es),
+				  end_pfn);
+
+	unmovable =3D has_unmovable_pages(check_unmovable_start, check_unmovable_=
end,
+			migratetype, isol_flags);
 	if (!unmovable) {
 		unsigned long nr_pages;
 		int mt =3D get_pageblock_migratetype(page);
@@ -259,12 +281,21 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
 	return NULL;
 }
=20
+static unsigned long pfn_max_align_down(unsigned long pfn)
+{
+	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
+}
+
+static unsigned long pfn_max_align_up(unsigned long pfn)
+{
+	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
+}
+
 /**
  * start_isolate_page_range() - make page-allocation-type of range of page=
s to
  * be MIGRATE_ISOLATE.
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
- *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
@@ -306,15 +337,16 @@ int start_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
 	unsigned long pfn;
 	struct page *page;
=20
-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
+	unsigned long isolate_start =3D pfn_max_align_down(start_pfn);
+	unsigned long isolate_end =3D pfn_max_align_up(end_pfn);
=20
-	for (pfn =3D start_pfn;
-	     pfn < end_pfn;
+	for (pfn =3D isolate_start;
+	     pfn < isolate_end;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
-		if (page && set_migratetype_isolate(page, migratetype, flags)) {
-			undo_isolate_page_range(start_pfn, pfn, migratetype);
+		if (page && set_migratetype_isolate(page, migratetype, flags,
+					start_pfn, end_pfn)) {
+			undo_isolate_page_range(isolate_start, pfn, migratetype);
 			return -EBUSY;
 		}
 	}
@@ -329,12 +361,12 @@ void undo_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
 {
 	unsigned long pfn;
 	struct page *page;
+	unsigned long isolate_start =3D pfn_max_align_down(start_pfn);
+	unsigned long isolate_end =3D pfn_max_align_up(end_pfn);
=20
-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
=20
-	for (pfn =3D start_pfn;
-	     pfn < end_pfn;
+	for (pfn =3D isolate_start;
+	     pfn < isolate_end;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
 		if (!page || !is_migrate_isolate_page(page))
--=20
2.35.1

