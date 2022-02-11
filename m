Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858E54B2AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351770AbiBKQvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:51:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351729AbiBKQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:51:03 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91960CD0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:51:00 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 261C6580376;
        Fri, 11 Feb 2022 11:41:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Feb 2022 11:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=TkAiSDDqHj52sQ
        QpS3No7LU7FQn/P0B4WvW+CLbRBDY=; b=RX+guAPK53EbPT+OY+vpQb5TtsbFIU
        ZmLWgYD4H5jvi4GUeeMVGCAXfvGXwg2nNX4Wt64mYQt7bCj+YaXETqx7X3oqQa3R
        cV1dCprYGVOsBqZMjStHt1ylDGBNvQi43FQudL9mMf+J5hJY9HQu/pvBZNLPmMiG
        5JW9Jd5ygnP+H3CMuKvKQ6RWbjoFqVPuKKFvBSedVZv8cQUKFgb+2PrvEPm/69zG
        6Ar9HRuN1uBPLZnkfesb2VBreuz1g4oPCGjvhHX5AEXByp1VCCtLz890TAxxEwYF
        1KebR2zyQny0/sL5+iqC5IVH/MLM6QfspFhpHW9mo14tgoT6LRqEdejA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=TkAiSDDqHj52sQQpS3No7LU7FQn/P0B4WvW+CLbRBDY=; b=iVnxPXU0
        4v3uW6oEWaQ9G8CXU0jDyjtvDCPA/AJd+gLIWBITBQHC4vbFywDecuKk+WV9wQZv
        NzJLwsY5cI0vo2nn8MHHjwc7WD/dBKOCcbDUwMgqhGp3wjJfKNuYBpNR97+nnE5k
        fWeN0IdGilm0mTbkKFVwnI7HXeHMDbml4C0Z311M485Iko5YOYLCIHuem23Klc3W
        Q4M9ZukWGFOKJQFDg5DXRqfTsLSiqSIXbPPZTdlo8CVEkGkFafSO6UfAK/yskgz1
        1vmyc7T/thVED+4T03i06hluA/ZsbnuwtWbjpM5PSf3zCTpTaUspeSnaHKPKIIFF
        jwIUezBJJ2Y30w==
X-ME-Sender: <xms:ypEGYmIuDKK2k51RzRGWGKTVDX38PrJY-DL7AEtzB4LKniWCofkM-A>
    <xme:ypEGYuLnKfeGf7pJfv2YmZHEV63MUyYUAxK4dR53b2RNGG9T-KJWc5wuTvSpkFmiI
    mzZiJLHgTy7_USb4w>
X-ME-Received: <xmr:ypEGYmsf5Zpdb5HMDRfqGLQQKIMJYuelq9SnHTibV2knJjPVm34yBsG3z3Sh55R7Dns3elGD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:ypEGYrbuT9Oa34-nNeugxpS8mvpjVdx2zsUjkgEqmQFKSGYRjIF9VA>
    <xmx:ypEGYtbri-nnGIuNfYMNbkYlVxfRRagxOipZYc3C0T5MYFEchyjc0A>
    <xmx:ypEGYnBKpKRwK6xw6LLWbQHSWmGbQ6TUOiEZqjmQYHICI_5QbPSvLQ>
    <xmx:zJEGYjyZr-KrSuAbClDp6SGTTgE184bIZFPjtfPMPNPamoUoIG9cdw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:46 -0500 (EST)
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
Subject: [PATCH v5 2/6] mm: page_isolation: check specified range for unmovable pages
Date:   Fri, 11 Feb 2022 11:41:31 -0500
Message-Id: <20220211164135.1803616-3-zi.yan@sent.com>
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
 include/linux/page-isolation.h | 12 +++++++++
 mm/page_alloc.c                | 15 +----------
 mm/page_isolation.c            | 46 +++++++++++++++++++++-------------
 3 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index e14eddf6741a..4ef7be6def83 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -15,6 +15,18 @@ static inline bool is_migrate_isolate(int migratetype)
 {
 	return migratetype =3D=3D MIGRATE_ISOLATE;
 }
+static inline unsigned long pfn_max_align_down(unsigned long pfn)
+{
+	return ALIGN_DOWN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
+				     pageblock_nr_pages));
+}
+
+static inline unsigned long pfn_max_align_up(unsigned long pfn)
+{
+	return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
+				pageblock_nr_pages));
+}
+
 #else
 static inline bool has_isolate_pageblock(struct zone *zone)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e2c6a67fc386..62ef78f3d771 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8963,18 +8963,6 @@ void *__init alloc_large_system_hash(const char *tab=
lename,
 }
=20
 #ifdef CONFIG_CONTIG_ALLOC
-static unsigned long pfn_max_align_down(unsigned long pfn)
-{
-	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
-			     pageblock_nr_pages) - 1);
-}
-
-static unsigned long pfn_max_align_up(unsigned long pfn)
-{
-	return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
-				pageblock_nr_pages));
-}
-
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 /* Usage: See admin-guide/dynamic-debug-howto.rst */
@@ -9119,8 +9107,7 @@ int alloc_contig_range(unsigned long start, unsigned =
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
index b34f1310aeaa..64d093ab83ec 100644
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
@@ -29,11 +30,14 @@
  *
  */
 static struct page *has_unmovable_pages(struct zone *zone, struct page *pa=
ge,
-				 int migratetype, int flags)
+				 int migratetype, int flags,
+				 unsigned long start_pfn, unsigned long end_pfn)
 {
-	unsigned long iter =3D 0;
-	unsigned long pfn =3D page_to_pfn(page);
-	unsigned long offset =3D pfn % pageblock_nr_pages;
+	unsigned long first_pfn =3D max(page_to_pfn(page), start_pfn);
+	unsigned long pfn =3D first_pfn;
+	unsigned long last_pfn =3D min(ALIGN(pfn + 1, pageblock_nr_pages), end_pf=
n);
+
+	page =3D pfn_to_page(pfn);
=20
 	if (is_migrate_cma_page(page)) {
 		/*
@@ -47,8 +51,8 @@ static struct page *has_unmovable_pages(struct zone *zone=
, struct page *page,
 		return page;
 	}
=20
-	for (; iter < pageblock_nr_pages - offset; iter++) {
-		page =3D pfn_to_page(pfn + iter);
+	for (pfn =3D first_pfn; pfn < last_pfn; pfn++) {
+		page =3D pfn_to_page(pfn);
=20
 		/*
 		 * Both, bootmem allocations and memory holes are marked
@@ -85,7 +89,7 @@ static struct page *has_unmovable_pages(struct zone *zone=
, struct page *page,
 			}
=20
 			skip_pages =3D compound_nr(head) - (page - head);
-			iter +=3D skip_pages - 1;
+			pfn +=3D skip_pages - 1;
 			continue;
 		}
=20
@@ -97,7 +101,7 @@ static struct page *has_unmovable_pages(struct zone *zon=
e, struct page *page,
 		 */
 		if (!page_ref_count(page)) {
 			if (PageBuddy(page))
-				iter +=3D (1 << buddy_order(page)) - 1;
+				pfn +=3D (1 << buddy_order(page)) - 1;
 			continue;
 		}
=20
@@ -134,7 +138,13 @@ static struct page *has_unmovable_pages(struct zone *z=
one, struct page *page,
 	return NULL;
 }
=20
-static int set_migratetype_isolate(struct page *page, int migratetype, int=
 isol_flags)
+/*
+ * This function set pageblock migratetype to isolate if no unmovable page=
 is
+ * present in [start_pfn, end_pfn). The pageblock must be within
+ * [start_pfn, end_pfn).
+ */
+static int set_migratetype_isolate(struct page *page, int migratetype, int=
 isol_flags,
+			unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct zone *zone =3D page_zone(page);
 	struct page *unmovable;
@@ -156,7 +166,7 @@ static int set_migratetype_isolate(struct page *page, i=
nt migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	unmovable =3D has_unmovable_pages(zone, page, migratetype, isol_flags);
+	unmovable =3D has_unmovable_pages(zone, page, migratetype, isol_flags, st=
art_pfn, end_pfn);
 	if (!unmovable) {
 		unsigned long nr_pages;
 		int mt =3D get_pageblock_migratetype(page);
@@ -267,7 +277,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_=
pages)
  * be MIGRATE_ISOLATE.
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
- *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
@@ -309,15 +318,16 @@ int start_isolate_page_range(unsigned long start_pfn,=
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
2.34.1

