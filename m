Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF6D50E32F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbiDYOe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiDYOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:34:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258C1EEFB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:31:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 156D95C0187;
        Mon, 25 Apr 2022 10:31:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Apr 2022 10:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1650897090; x=1650983490; bh=JZpLw6fnQnPze5Yn7EzGGyNnuGr18Ikq05h
        0cvuKnMk=; b=L+aYrOlZyn6hJXPRoCjqNZGoPXyNB9odmV363tpeLatzp5DmdSL
        L7ECgOcM6iN32gPONENDNP1Lv+WsNcJJgp2AfsLYbdWWD4KOLcugYseQr+6wBAhc
        yUjiiy6RBUM10vfCC9Bk3vnVTtKIP4yxlYNo1iMhZrnb30hxtCWJR+xvpfJUEJEN
        IKadMY8UXbYk39GKYwATGZPyeiM4d4+jEaT7bMI1QiZ9M/R9rn6nsTDnn5Ve41LU
        FphBwSPc/ibVenxv23HVEv0BO1Kz2HJgGDN7n84sO+o2UyakbcoVqGPZqxdbAnG0
        IQ8zFuj8FOOCW+XT+s8R74/69eauD5F6WkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650897090; x=1650983490; bh=J
        ZpLw6fnQnPze5Yn7EzGGyNnuGr18Ikq05h0cvuKnMk=; b=HAhaV4bOixAyT7g3T
        qFEHTkn1xj+sxuUk7b3R0/kFU4VcP72rki+DB32tAlRZLA/gEu3L4ZDBY83uw3gv
        6PM5I35cYdpv5eJ91MEJG9n0D9Q3SMcBp0g8G4Th795zxeSxz5f9CJaeUM0YeKeQ
        aTQxPvxkOXxeD4oBCUxxSABsHF1P2aCRJnhSb6oMP+jDKmOKiWNIvVCEBQ+xC3ig
        6jdBmZptNh5xLc30vbAdb42QBliz40+ftVAwPcON2GCrwr2aDipbJ4W8165d3Gg9
        L79flY6+3axCskKhEa8wFY8sunc5spyRbnAN185/Tx7kh4igUop7cj2kKJbqrY4N
        X4oZg==
X-ME-Sender: <xms:wbBmYiNhlcij3TV7WNLct2Hr_oSO4KEMuChq5m4Sxwabzz_lsrivGg>
    <xme:wbBmYg_qGctszpy-WY7GGaTVtQ0t-q2lFVpLKb_2KQ5nRGa51E4m6rIBq3MehTAAH
    4oCqRid4UxMncs88Q>
X-ME-Received: <xmr:wbBmYpR6hoFnW1t0-_Ev2HMwYdNj1sKGm4JjCLaUuTIOM7ViO_zREsuM1NHyx5Z86oe4piSaV2XE_pSRSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddugdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeevhe
    evleehgfduhffhudefteehhfegjeeiudevheevffetuedttdfhkeeuleehudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:wbBmYiuVtpUeeL3mYWDnprBshYb-LOCAnWOkKrpWPhFbm-PHkM2ilw>
    <xmx:wbBmYqfpqdJM0UwG6PKscY5-cuI5YuQRDI-cfF1gAHeuasFtmoIRFA>
    <xmx:wbBmYm0iHxOcwHkNeg9011TwaJV57iRmmBVIW5rusnA2Tki1aa1Xyw>
    <xmx:wrBmYm2qJtEeQzeZRIjUs8fWUKuZ4u00pehiU92X1GEmg_mjlE-clQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Apr 2022 10:31:29 -0400 (EDT)
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
        Zi Yan <ziy@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v11 3/6] mm: make alloc_contig_range work at pageblock granularity
Date:   Mon, 25 Apr 2022 10:31:15 -0400
Message-Id: <20220425143118.2850746-4-zi.yan@sent.com>
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

alloc_contig_range() worked at MAX_ORDER_NR_PAGES granularity to avoid
merging pageblocks with different migratetypes. It might unnecessarily
convert extra pageblocks at the beginning and at the end of the range.
Change alloc_contig_range() to work at pageblock granularity.

Special handling is needed for free pages and in-use pages across the
boundaries of the range specified by alloc_contig_range(). Because these
partially isolated pages causes free page accounting issues. The free
pages will be split and freed into separate migratetype lists; the
in-use pages will be migrated then the freed pages will be handled in
the aforementioned way.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |   4 +-
 mm/internal.h                  |   6 ++
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                |  54 ++++++++--
 mm/page_isolation.c            | 184 ++++++++++++++++++++++++++++++++-
 5 files changed, 233 insertions(+), 18 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index e14eddf6741a..5456b7be38ae 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -42,7 +42,7 @@ int move_freepages_block(struct zone *zone, struct page *=
page,
  */
 int
 start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			 unsigned migratetype, int flags);
+			 int migratetype, int flags, gfp_t gfp_flags);
=20
 /*
  * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
@@ -50,7 +50,7 @@ start_isolate_page_range(unsigned long start_pfn, unsigne=
d long end_pfn,
  */
 void
 undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			unsigned migratetype);
+			int migratetype);
=20
 /*
  * Test all pages in [start_pfn, end_pfn) are isolated or not.
diff --git a/mm/internal.h b/mm/internal.h
index 919fa07e1031..0667abd57634 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -359,6 +359,9 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t=
 align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);
=20
+void split_free_page(struct page *free_page,
+				int order, unsigned long split_pfn_offset);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
=20
 /*
@@ -422,6 +425,9 @@ isolate_freepages_range(struct compact_control *cc,
 int
 isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
+
+int __alloc_contig_migrate_range(struct compact_control *cc,
+					unsigned long start, unsigned long end);
 #endif
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4c6065e5d274..9f8ae4cb77ee 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1845,7 +1845,8 @@ int __ref offline_pages(unsigned long start_pfn, unsi=
gned long nr_pages,
 	/* set above range as isolated */
 	ret =3D start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
-				       MEMORY_OFFLINE | REPORT_FAILURE);
+				       MEMORY_OFFLINE | REPORT_FAILURE,
+				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
 	if (ret) {
 		reason =3D "failure to isolate range";
 		goto failed_removal_pcplists_disabled;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce23ac8ad085..70ddd9a0bcf3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1094,6 +1094,43 @@ static inline void __free_one_page(struct page *page,
 		page_reporting_notify_free(order);
 }
=20
+/**
+ * split_free_page() -- split a free page at split_pfn_offset
+ * @free_page:		the original free page
+ * @order:		the order of the page
+ * @split_pfn_offset:	split offset within the page
+ *
+ * It is used when the free page crosses two pageblocks with different mig=
ratetypes
+ * at split_pfn_offset within the page. The split free page will be put in=
to
+ * separate migratetype lists afterwards. Otherwise, the function achieves
+ * nothing.
+ */
+void split_free_page(struct page *free_page,
+				int order, unsigned long split_pfn_offset)
+{
+	struct zone *zone =3D page_zone(free_page);
+	unsigned long free_page_pfn =3D page_to_pfn(free_page);
+	unsigned long pfn;
+	unsigned long flags;
+	int free_page_order;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	del_page_from_free_list(free_page, zone, order);
+	for (pfn =3D free_page_pfn;
+	     pfn < free_page_pfn + (1UL << order);) {
+		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
+
+		free_page_order =3D ffs(split_pfn_offset) - 1;
+		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
+				mt, FPI_NONE);
+		pfn +=3D 1UL << free_page_order;
+		split_pfn_offset -=3D (1UL << free_page_order);
+		/* we have done the first part, now switch to second part */
+		if (split_pfn_offset =3D=3D 0)
+			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
 /*
  * A bad page could be due to a number of fields. Instead of multiple bran=
ches,
  * try and check multiple fields with one check. The caller must do a deta=
iled
@@ -8919,7 +8956,7 @@ static inline void alloc_contig_dump_pages(struct lis=
t_head *page_list)
 #endif
=20
 /* [start, end) must belong to a single zone. */
-static int __alloc_contig_migrate_range(struct compact_control *cc,
+int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end)
 {
 	/* This function is based on compact_zone() from compaction.c. */
@@ -9002,7 +9039,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
-	unsigned int order;
+	int order;
 	int ret =3D 0;
=20
 	struct compact_control cc =3D {
@@ -9021,14 +9058,11 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
 	 * have different sizes, and due to the way page allocator
-	 * work, we align the range to biggest of the two pages so
-	 * that page allocator won't try to merge buddies from
-	 * different pageblocks and change MIGRATE_ISOLATE to some
-	 * other migration type.
+	 * work, start_isolate_page_range() has special handlings for this.
 	 *
 	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
 	 * migrate the pages from an unaligned range (ie. pages that
-	 * we are interested in).  This will put all the pages in
+	 * we are interested in). This will put all the pages in
 	 * range back to page allocator as MIGRATE_ISOLATE.
 	 *
 	 * When this is done, we take the pages in range from page
@@ -9042,9 +9076,9 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 	 */
=20
 	ret =3D start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+				pfn_max_align_up(end), migratetype, 0, gfp_mask);
 	if (ret)
-		return ret;
+		goto done;
=20
 	drain_all_pages(cc.zone);
=20
@@ -9064,7 +9098,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 	ret =3D 0;
=20
 	/*
-	 * Pages from [start, end) are within a MAX_ORDER_NR_PAGES
+	 * Pages from [start, end) are within a pageblock_nr_pages
 	 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
 	 * more, all pages in [start, end) are free in page allocator.
 	 * What we are going to do is to allocate all pages from
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c2f7a8bb634d..94b3467e5ba2 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -203,7 +203,7 @@ static int set_migratetype_isolate(struct page *page, i=
nt migratetype, int isol_
 	return -EBUSY;
 }
=20
-static void unset_migratetype_isolate(struct page *page, unsigned migratet=
ype)
+static void unset_migratetype_isolate(struct page *page, int migratetype)
 {
 	struct zone *zone;
 	unsigned long flags, nr_pages;
@@ -279,6 +279,157 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
 	return NULL;
 }
=20
+/**
+ * isolate_single_pageblock() -- tries to isolate a pageblock that might be
+ * within a free or in-use page.
+ * @boundary_pfn:		pageblock-aligned pfn that a page might cross
+ * @gfp_flags:			GFP flags used for migrating pages
+ * @isolate_before:	isolate the pageblock before the boundary_pfn
+ *
+ * Free and in-use pages can be as big as MAX_ORDER-1 and contain more tha=
n one
+ * pageblock. When not all pageblocks within a page are isolated at the sa=
me
+ * time, free page accounting can go wrong. For example, in the case of
+ * MAX_ORDER-1 =3D pageblock_order + 1, a MAX_ORDER-1 page has two pagelbo=
cks.
+ * [         MAX_ORDER-1         ]
+ * [  pageblock0  |  pageblock1  ]
+ * When either pageblock is isolated, if it is a free page, the page is not
+ * split into separate migratetype lists, which is supposed to; if it is an
+ * in-use page and freed later, __free_one_page() does not split the free =
page
+ * either. The function handles this by splitting the free page or migrati=
ng
+ * the in-use page then splitting the free page.
+ */
+static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_=
flags,
+			bool isolate_before)
+{
+	unsigned char saved_mt;
+	unsigned long start_pfn;
+	unsigned long isolate_pageblock;
+	unsigned long pfn;
+	struct zone *zone;
+
+	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
+
+	if (isolate_before)
+		isolate_pageblock =3D boundary_pfn - pageblock_nr_pages;
+	else
+		isolate_pageblock =3D boundary_pfn;
+
+	/*
+	 * scan at the beginning of MAX_ORDER_NR_PAGES aligned range to avoid
+	 * only isolating a subset of pageblocks from a bigger than pageblock
+	 * free or in-use page. Also make sure all to-be-isolated pageblocks
+	 * are within the same zone.
+	 */
+	zone  =3D page_zone(pfn_to_page(isolate_pageblock));
+	start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
+				      zone->zone_start_pfn);
+
+	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
+	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISOLATE=
);
+
+	/*
+	 * Bail out early when the to-be-isolated pageblock does not form
+	 * a free or in-use page across boundary_pfn:
+	 *
+	 * 1. isolate before boundary_pfn: the page after is not online
+	 * 2. isolate after boundary_pfn: the page before is not online
+	 *
+	 * This also ensures correctness. Without it, when isolate after
+	 * boundary_pfn and [start_pfn, boundary_pfn) are not online,
+	 * __first_valid_page() will return unexpected NULL in the for loop
+	 * below.
+	 */
+	if (isolate_before) {
+		if (!pfn_to_online_page(boundary_pfn))
+			return 0;
+	} else {
+		if (!pfn_to_online_page(boundary_pfn - 1))
+			return 0;
+	}
+
+	for (pfn =3D start_pfn; pfn < boundary_pfn;) {
+		struct page *page =3D __first_valid_page(pfn, boundary_pfn - pfn);
+
+		VM_BUG_ON(!page);
+		pfn =3D page_to_pfn(page);
+		/*
+		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
+		 * free pages in [start_pfn, boundary_pfn), its head page will
+		 * always be in the range.
+		 */
+		if (PageBuddy(page)) {
+			int order =3D buddy_order(page);
+
+			if (pfn + (1UL << order) > boundary_pfn)
+				split_free_page(page, order, boundary_pfn - pfn);
+			pfn +=3D (1UL << order);
+			continue;
+		}
+		/*
+		 * migrate compound pages then let the free page handling code
+		 * above do the rest. If migration is not enabled, just fail.
+		 */
+		if (PageHuge(page) || PageTransCompound(page)) {
+#if defined CONFIG_COMPACTION || defined CONFIG_CMA
+			unsigned long nr_pages =3D compound_nr(page);
+			int order =3D compound_order(page);
+			struct page *head =3D compound_head(page);
+			unsigned long head_pfn =3D page_to_pfn(head);
+			int ret;
+			struct compact_control cc =3D {
+				.nr_migratepages =3D 0,
+				.order =3D -1,
+				.zone =3D page_zone(pfn_to_page(head_pfn)),
+				.mode =3D MIGRATE_SYNC,
+				.ignore_skip_hint =3D true,
+				.no_set_skip_hint =3D true,
+				.gfp_mask =3D gfp_flags,
+				.alloc_contig =3D true,
+			};
+			INIT_LIST_HEAD(&cc.migratepages);
+
+			if (head_pfn + nr_pages < boundary_pfn) {
+				pfn +=3D nr_pages;
+				continue;
+			}
+
+			ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
+						head_pfn + nr_pages);
+
+			if (ret)
+				goto failed;
+			/*
+			 * reset pfn, let the free page handling code above
+			 * split the free page to the right migratetype list.
+			 *
+			 * head_pfn is not used here as a hugetlb page order
+			 * can be bigger than MAX_ORDER-1, but after it is
+			 * freed, the free page order is not. Use pfn within
+			 * the range to find the head of the free page and
+			 * reset order to 0 if a hugetlb page with
+			 * >MAX_ORDER-1 order is encountered.
+			 */
+			if (order > MAX_ORDER-1)
+				order =3D 0;
+			while (!PageBuddy(pfn_to_page(pfn))) {
+				order++;
+				pfn &=3D ~0UL << order;
+			}
+			continue;
+#else
+			goto failed;
+#endif
+		}
+
+		pfn++;
+	}
+	return 0;
+failed:
+	/* restore the original migratetype */
+	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
+	return -EBUSY;
+}
+
 /**
  * start_isolate_page_range() - make page-allocation-type of range of page=
s to
  * be MIGRATE_ISOLATE.
@@ -293,6 +444,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_=
pages)
  *					 and PageOffline() pages.
  *			REPORT_FAILURE - report details about the failure to
  *			isolate the range
+ * @gfp_flags:		GFP flags used for migrating pages that sit across the
+ *			range boundaries.
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
  * the range will never be allocated. Any free pages and pages freed in the
@@ -301,6 +454,10 @@ __first_valid_page(unsigned long pfn, unsigned long nr=
_pages)
  * pages in the range finally, the caller have to free all pages in the ra=
nge.
  * test_page_isolated() can be used for test it.
  *
+ * The function first tries to isolate the pageblocks at the beginning and=
 end
+ * of the range, since there might be pages across the range boundaries.
+ * Afterwards, it isolates the rest of the range.
+ *
  * There is no high level synchronization mechanism that prevents two thre=
ads
  * from trying to isolate overlapping ranges. If this happens, one thread
  * will notice pageblocks in the overlapping range already set to isolate.
@@ -321,21 +478,38 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pf=
n,
-			     unsigned migratetype, int flags)
+			     int migratetype, int flags, gfp_t gfp_flags)
 {
 	unsigned long pfn;
 	struct page *page;
+	int ret;
=20
 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
=20
-	for (pfn =3D start_pfn;
-	     pfn < end_pfn;
+	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */
+	ret =3D isolate_single_pageblock(start_pfn, gfp_flags, false);
+	if (ret)
+		return ret;
+
+	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
+	ret =3D isolate_single_pageblock(end_pfn, gfp_flags, true);
+	if (ret) {
+		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
+		return ret;
+	}
+
+	/* skip isolated pageblocks at the beginning and end */
+	for (pfn =3D start_pfn + pageblock_nr_pages;
+	     pfn < end_pfn - pageblock_nr_pages;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(start_pfn, pfn, migratetype);
+			unset_migratetype_isolate(
+				pfn_to_page(end_pfn - pageblock_nr_pages),
+				migratetype);
 			return -EBUSY;
 		}
 	}
@@ -346,7 +520,7 @@ int start_isolate_page_range(unsigned long start_pfn, u=
nsigned long end_pfn,
  * Make isolated pages available again.
  */
 void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pf=
n,
-			    unsigned migratetype)
+			    int migratetype)
 {
 	unsigned long pfn;
 	struct page *page;
--=20
2.35.1

