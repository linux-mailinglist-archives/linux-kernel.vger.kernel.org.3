Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27184DCA27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiCQPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiCQPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:39:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E67F20C19D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:37:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F2A105C080A;
        Thu, 17 Mar 2022 11:37:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 17 Mar 2022 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=IwpK4EjSDm5cyo
        9H1N99J/Cf3Rm01pT5/3W5ylhq6co=; b=k0LgMa6N5Ps6AGLiW1XLeCiRs/ic0h
        hpfzCIlmN6GC98gjQj1w0ZUWcAtj4Bnh1PZx0x+b3RIm73VSW6bhnJpMdbsTMU6j
        rMmHbJtSebIfl+qPUVAXB3tIvtdrRzAngtE+hIZw3UeK4lRH72onqT72l8juLk+g
        a2tLz3Y6wS1uudGsSeDZqfhXR28J+Y+7hRps+HvXFhX/CPZ4ygJAmZqCl/c9Jm+N
        eibRyroteRE2ka+RDGMN2N//O+CF6wKjwPWI4uexPADbwNLKvKx7/YVjPQzyLurK
        Xb3q/ij7ELB09tUafMuhnMZ10MybMtxbDIgvFanEl/KN2h+s0dy5CpDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=IwpK4EjSDm5cyo9H1N99J/Cf3Rm01pT5/3W5ylhq6co=; b=hW5vjcZI
        P2MDORtXn+WqKJR9NVrHgxleRDaTWtFwx12CP7+HUGjnb2YGsfsPfonmcMgVP9GB
        if1VcIxQnq8Awfvk4v606w8+p0e7t+UQA+EwPMUtlEpy3jSLVab/JOc2rPr74d+K
        g0ud7k6zhvTeJd4gsgAqt96hr/QK98mXi6dQi1gb4WRthQQkQ+BSUxjV2uW07/WS
        6MS8VT++IgT/IfjrTuyfh7QHWn1NeVgC9TYjTjkV6VNuBnC0Ya7MRkpC2GaVO3IH
        ImWOyfIlLDSrB79k/MR3Ie/o2CWb3ePrd12oTxkZ/BQTcBJ8UpB2bN83YWBTNQp3
        nk6eM+sfg2lZ2w==
X-ME-Sender: <xms:y1UzYrEs9e2IDLyDZ-H-K3_fw7eIJ88R6hiaOn7R-ZZXNvlvuWr0jw>
    <xme:y1UzYoUprZALnqaOF9kfu1Vxy3V3HBjiT1o0ls4vuBLsl3X6WRCPLGDN13KufD21w
    I6Lz9ZHaT1zL85oDg>
X-ME-Received: <xmr:y1UzYtKDBMEXUzbX5FQxxnX5Dxyuv3F-NsJz0KBkFk_cZ-svSCQOD-NoaX0UcVAfzYiJTnNQMk0peODBFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:y1UzYpE41iMOc50b0fuRqN3EZ04QZ69ZVa9Yoeig_0Ih1rYrNEw4bA>
    <xmx:y1UzYhUg-NhFYpxWwABS1ArXtxnfc_eeKx7KauVlWBHRBdCCIN1xdw>
    <xmx:y1UzYkMju5h6v5GWb1cVOuqKde20j8c0GchhqWngkZpSSXbzFuws3w>
    <xmx:y1UzYpSfnuTI7OjB-h3WoUoC6h9YcCPCgN_M-uBodekCUyvdj_sWpg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 11:37:47 -0400 (EDT)
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
Subject: [PATCH v8 2/5] mm: page_isolation: check specified range for unmovable pages
Date:   Thu, 17 Mar 2022 11:37:30 -0400
Message-Id: <20220317153733.2171277-3-zi.yan@sent.com>
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

Enable set_migratetype_isolate() to check specified sub-range for
unmovable pages during isolation. Page isolation is done
at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
pages within that granularity are intended to be isolated. For example,
alloc_contig_range(), which uses page isolation, allows ranges without
alignment. This commit makes unmovable page check only look for
interesting pages, so that page isolation can succeed for any
non-overlapping ranges.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h | 10 +++++
 mm/page_alloc.c                | 13 +------
 mm/page_isolation.c            | 69 ++++++++++++++++++++--------------
 3 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index e14eddf6741a..eb4a208fe907 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratetype)
 {
 	return migratetype =3D=3D MIGRATE_ISOLATE;
 }
+static inline unsigned long pfn_max_align_down(unsigned long pfn)
+{
+	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
+}
+
+static inline unsigned long pfn_max_align_up(unsigned long pfn)
+{
+	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
+}
+
 #else
 static inline bool has_isolate_pageblock(struct zone *zone)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6de57d058d3d..680580a40a35 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8937,16 +8937,6 @@ void *__init alloc_large_system_hash(const char *tab=
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
@@ -9091,8 +9081,7 @@ int alloc_contig_range(unsigned long start, unsigned =
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
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b34f1310aeaa..419c805dbdcd 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -16,7 +16,8 @@
 #include <trace/events/page_isolation.h>
=20
 /*
- * This function checks whether pageblock includes unmovable pages or not.
+ * This function checks whether pageblock within [start_pfn, end_pfn) incl=
udes
+ * unmovable pages or not.
  *
  * PageLRU check without isolation or lru_lock could race so that
  * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
@@ -28,27 +29,26 @@
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
=20
-	if (is_migrate_cma_page(page)) {
-		/*
-		 * CMA allocations (alloc_contig_range) really need to mark
-		 * isolate CMA pageblocks even when they are not movable in fact
-		 * so consider them movable here.
-		 */
-		if (is_migrate_cma(migratetype))
-			return NULL;
+	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
+		struct page *page =3D pfn_to_page(pfn);
+		struct zone *zone =3D page_zone(page);
=20
-		return page;
-	}
+		if (is_migrate_cma_page(page)) {
+			/*
+			 * CMA allocations (alloc_contig_range) really need to mark
+			 * isolate CMA pageblocks even when they are not movable in fact
+			 * so consider them movable here.
+			 */
+			if (is_migrate_cma(migratetype))
+				return NULL;
=20
-	for (; iter < pageblock_nr_pages - offset; iter++) {
-		page =3D pfn_to_page(pfn + iter);
+			return page;
+		}
=20
 		/*
 		 * Both, bootmem allocations and memory holes are marked
@@ -85,7 +85,7 @@ static struct page *has_unmovable_pages(struct zone *zone=
, struct page *page,
 			}
=20
 			skip_pages =3D compound_nr(head) - (page - head);
-			iter +=3D skip_pages - 1;
+			pfn +=3D skip_pages - 1;
 			continue;
 		}
=20
@@ -97,7 +97,7 @@ static struct page *has_unmovable_pages(struct zone *zone=
, struct page *page,
 		 */
 		if (!page_ref_count(page)) {
 			if (PageBuddy(page))
-				iter +=3D (1 << buddy_order(page)) - 1;
+				pfn +=3D (1 << buddy_order(page)) - 1;
 			continue;
 		}
=20
@@ -134,7 +134,13 @@ static struct page *has_unmovable_pages(struct zone *z=
one, struct page *page,
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
@@ -155,8 +161,13 @@ static int set_migratetype_isolate(struct page *page, =
int migratetype, int isol_
 	/*
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
+	 *
+	 * Pass the intersection of [start_pfn, end_pfn) and the page's pageblock
+	 * to avoid redundant checks.
 	 */
-	unmovable =3D has_unmovable_pages(zone, page, migratetype, isol_flags);
+	unmovable =3D has_unmovable_pages(max(page_to_pfn(page), start_pfn),
+			min(ALIGN(page_to_pfn(page) + 1, pageblock_nr_pages), end_pfn),
+			migratetype, isol_flags);
 	if (!unmovable) {
 		unsigned long nr_pages;
 		int mt =3D get_pageblock_migratetype(page);
@@ -267,7 +278,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_=
pages)
  * be MIGRATE_ISOLATE.
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
- *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
@@ -309,15 +319,16 @@ int start_isolate_page_range(unsigned long start_pfn,=
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
--=20
2.35.1

