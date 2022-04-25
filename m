Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB750E336
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbiDYOeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiDYOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:34:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011856466
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:31:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 655155C0165;
        Mon, 25 Apr 2022 10:31:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Apr 2022 10:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1650897089; x=1650983489; bh=OeQFxiIFvToaCLpTa2plz66iPIth4OqYoQ1
        7JpnzViQ=; b=A9b3waUUGp3F2UWeLiSYPfFrFcvP+AopJc6K0snGGxr9P40nHHo
        EIoODQMsQjv0W6y8i2bYfegJq0o9QJgpx/pcL/vmu1ZfX87ybZYI44mMea8YhNa/
        N39Ba+44iuTydKxdvHlTwn3oWeXJmk7zgEsxvKouV4GswEQZE4OyV10tjlE/W0On
        0mCmoW7i+4K0TKA0Pg52p6M7xMIy1Sgl6e4GpkrTDPFGvUAA7zegvbqAebNYDlhe
        zD7kCKskjDgdQABpnmOOuzux09fEh3E/q6YpCCXqABPto1TkNp9BNskU6NI7vTpE
        HLsvtyXguNt4SClWV4nyoEUaxApG+61awxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650897089; x=1650983489; bh=O
        eQFxiIFvToaCLpTa2plz66iPIth4OqYoQ17JpnzViQ=; b=oYsissR3PHWqDArA4
        HfFAmFfENAfSER9HKJGmrMOrOCpfxw0HustA7k6EVvUhGGUryXMusRnyuDwV+8ub
        iZ0PxQRtPkk9ABrQhiqeenaony75e23HvlqmH/+p9KUnttwYyY6IPtP1Z7PE005K
        d/EippddZZJnHM5pkdbZtal+8YW3oghi3t4c1ceARr9xQV9nePP3NK7nvjL/gugm
        fY2nY+XvzV5GPRCPiV0a5o7wDXQ+ZaF8zvVRgDvfefckuPHJVuAZTa/fghuv2N2a
        pXk+5Dw1CKTqX/s9dVdc/PbCWl0MtoKo0mjqzU95VedAD5PNwG/MDtPnaflvR4DG
        0kbDg==
X-ME-Sender: <xms:wbBmYpOcskIFYyNEMs6r93hzSZslEn2suc7QVLJYtT8T2cbgykuUMw>
    <xme:wbBmYr_YMvipxgQOv9bKm6fbpzu1uQOXrZbn8o53rxne4lz8DgT15GggWGNZ10BX_
    F32SBJnbXucjGKZ8Q>
X-ME-Received: <xmr:wbBmYoQ71sUE13J6VbFnVdrETkxRRnzkQFoNFzhQlPUa3OqZiuTmyB8aHhdNHng7lxLNlMl22tD7i398dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddugdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeevhe
    evleehgfduhffhudefteehhfegjeeiudevheevffetuedttdfhkeeuleehudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:wbBmYltbQ1CrDXOM3gxEVjsWRIHUz8xIZB5jVzhj3XNxNjQo79Q2vg>
    <xmx:wbBmYhds6Q7E2lqkZEZ7uIY0TuIwMMcCoY71roAUHjzuMi4cjxHWlw>
    <xmx:wbBmYh1MmiiZeXsDJBvKOZ37xmokOL1kV39vbDh4XyB7iYsZwFsBLQ>
    <xmx:wbBmYiUy78YTBybpy0iekAkVgk3ICQ1cyipRpqMVEAnTuDRLQdmJ0g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Apr 2022 10:31:28 -0400 (EDT)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v11 2/6] mm: page_isolation: check specified range for unmovable pages
Date:   Mon, 25 Apr 2022 10:31:14 -0400
Message-Id: <20220425143118.2850746-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425143118.2850746-1-zi.yan@sent.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Enable set_migratetype_isolate() to check specified range for
unmovable pages during isolation to prepare arbitrary range page
isolation. The functionality will take effect in upcoming commits by
adjusting the callers of start_isolate_page_range(), which uses
set_migratetype_isolate().

For example, alloc_contig_range(), which calls start_isolate_page_range(),
accepts unaligned ranges, but because page isolation is currently done at
MAX_ORDER_NR_PAEGS granularity, pages that are out of the specified range
but withint MAX_ORDER_NR_PAEGS alignment might be attempted for isolation
and the failure of isolating these unrelated pages fails the whole
operation undesirably.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_isolation.c | 47 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index df49f86a6ed1..c2f7a8bb634d 100644
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
@@ -28,12 +30,15 @@
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
+	struct page *page =3D pfn_to_page(start_pfn);
+	struct zone *zone =3D page_zone(page);
+	unsigned long pfn;
+
+	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=3D
+		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
=20
 	if (is_migrate_cma_page(page)) {
 		/*
@@ -47,8 +52,8 @@ static struct page *has_unmovable_pages(struct zone *zone=
, struct page *page,
 		return page;
 	}
=20
-	for (; iter < pageblock_nr_pages - offset; iter++) {
-		page =3D pfn_to_page(pfn + iter);
+	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
+		page =3D pfn_to_page(pfn);
=20
 		/*
 		 * Both, bootmem allocations and memory holes are marked
@@ -85,7 +90,7 @@ static struct page *has_unmovable_pages(struct zone *zone=
, struct page *page,
 			}
=20
 			skip_pages =3D compound_nr(head) - (page - head);
-			iter +=3D skip_pages - 1;
+			pfn +=3D skip_pages - 1;
 			continue;
 		}
=20
@@ -97,7 +102,7 @@ static struct page *has_unmovable_pages(struct zone *zon=
e, struct page *page,
 		 */
 		if (!page_ref_count(page)) {
 			if (PageBuddy(page))
-				iter +=3D (1 << buddy_order(page)) - 1;
+				pfn +=3D (1 << buddy_order(page)) - 1;
 			continue;
 		}
=20
@@ -134,11 +139,18 @@ static struct page *has_unmovable_pages(struct zone *=
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
@@ -155,8 +167,16 @@ static int set_migratetype_isolate(struct page *page, =
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
@@ -313,7 +333,8 @@ int start_isolate_page_range(unsigned long start_pfn, u=
nsigned long end_pfn,
 	     pfn < end_pfn;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
-		if (page && set_migratetype_isolate(page, migratetype, flags)) {
+		if (page && set_migratetype_isolate(page, migratetype, flags,
+					start_pfn, end_pfn)) {
 			undo_isolate_page_range(start_pfn, pfn, migratetype);
 			return -EBUSY;
 		}
--=20
2.35.1

