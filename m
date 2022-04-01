Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613514EFCFC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353353AbiDAXKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348954AbiDAXKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:10:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11271A7748
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 16:08:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AB635C01A4;
        Fri,  1 Apr 2022 19:08:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Apr 2022 19:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=sY3p/Hs4wasZBU
        gKGBvaUDfyN3fVA73veu73/gqoqQo=; b=ogM2whPW4uA/6DeP2LN+WjgLQg8rQr
        ssNzk6Nj8zl+RqWiq4vJ1UkthzMAXY7FO8/gTleuMOviNGlXlHuOZJlO1vJg1NHq
        g7yU8KuCfCey9VJZm0RaKrMJCK32C844j3zfKtq+TEtjgQKYp97s21Cv803ehW2/
        c1l27mbX2FCROnC7sOryaJlUVd5geg3c6NF5gItreAEIKDBdylX45EMRdBBc24EJ
        1wnW5BzXYGc9I8fvBAZvGjdiPpsyYH7e0VYE10NTIARdV/iaB5g8GERwVqg3NaSm
        KEbLN8VgfIfSFrLuh2A3Ly0Uy/fbMIv4u2nJ7GnRVIfY9kzocFWoGiYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=sY3p/Hs4wasZBUgKGBvaUDfyN3fVA73veu73/gqoqQo=; b=Zt3RWstc
        rBo8qzxFzEjdM4JrOGzJEm3tWNxbmueSu5LZTNvHu6CU9cY4Wo9tItz7ED3M3QvP
        HcSvcDdvrtlApTP9ClbCspbbcksYjkObUQo43cTV5ODkL1iSOmLPgqxeqq1Due5m
        s1ebzQWTY3WgIGzqHV/sZfYs7O3BjArqyiMPAdtn16UUiF4gwtjr68vOJdRQYjFs
        X/Zwz+KMVSv0yfEl5uG4dEn4KMXRKQYTtKfrXkRccT3WiPs6AK4ph0zVc0gSu4lb
        +9P4HaYR3go+jPLM1LWxeODVkJl8ByU6tGoJeF1oa6R8GC+Xs+r6W8Bg8y469GFO
        SHCOY/wwi+mRmw==
X-ME-Sender: <xms:2YVHYvILzxe3vnY-yK8L9Z_S6RS1tE7Lj2auwU8s8dfL47HwkfPlZA>
    <xme:2YVHYjKe8U5wgXPXvrUy91z2lwHm0-haLR5NHYrCnsj6Vpr9txNCyq5G37cy_CmbA
    VUSN1Xh1suFEDptJw>
X-ME-Received: <xmr:2YVHYnufedr3VGOeuZLBhERPBUA7Omz-pyjAsjOOiFeYAcw-cm3cHki4NUMgUUUBLpvtLa_82NGVLCYmlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeijedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkeeiue
    elvddtteeujeehtdegheejledvtdetgfeileejfeeghfeftdeuffefleevnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:2YVHYobVWD8MuI7jkrHEc7bdjwiQl_9ibXbWDjUnunHL7F1J73Mlpg>
    <xmx:2YVHYmYSdRAwYPZHkKjqHY4tbxNoWunT3Pr5CE6SfaK_lQyLNgTjyA>
    <xmx:2YVHYsAVTxsYP7LEh_UygQaT4dq8yRm_2VL2vj_6IiHUHBnZDgHs9w>
    <xmx:2oVHYsljBuUiTa927Wzh29wvRQkJe3dweFUnqsEc6YwSnpiku7ZPAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Apr 2022 19:08:09 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy page validation.
Date:   Fri,  1 Apr 2022 19:08:04 -0400
Message-Id: <20220401230804.1658207-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401230804.1658207-1-zi.yan@sent.com>
References: <20220401230804.1658207-1-zi.yan@sent.com>
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

Whenever the buddy of a page is found from __find_buddy_pfn(),
page_is_buddy() should be used to check its validity. Add a helper
function find_buddy_page_pfn() to find the buddy page and do the check
together.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-mm/CAHk-=3Dwji_AmYygZMTsPMdJ7XksMt7kOur=
8oDfDdniBRMjm4VkQ@mail.gmail.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/internal.h       | 117 ++++++++++++++++++++++++++++++++++----------
 mm/page_alloc.c     |  52 +++-----------------
 mm/page_isolation.c |   9 ++--
 3 files changed, 101 insertions(+), 77 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 876e66237c89..56bbae014e0e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -211,6 +211,67 @@ struct alloc_context {
 	bool spread_dirty_pages;
 };
=20
+/*
+ * This function returns the order of a free page in the buddy system. In
+ * general, page_zone(page)->lock must be held by the caller to prevent the
+ * page from being allocated in parallel and returning garbage as the orde=
r.
+ * If a caller does not hold page_zone(page)->lock, it must guarantee that=
 the
+ * page cannot be allocated or merged in parallel. Alternatively, it must
+ * handle invalid values gracefully, and use buddy_order_unsafe() below.
+ */
+static inline unsigned int buddy_order(struct page *page)
+{
+	/* PageBuddy() must be checked by the caller */
+	return page_private(page);
+}
+
+/*
+ * Like buddy_order(), but for callers who cannot afford to hold the zone =
lock.
+ * PageBuddy() should be checked first by the caller to minimize race wind=
ow,
+ * and invalid values must be handled gracefully.
+ *
+ * READ_ONCE is used so that if the caller assigns the result into a local
+ * variable and e.g. tests it for valid range before using, the compiler c=
annot
+ * decide to remove the variable and inline the page_private(page) multiple
+ * times, potentially observing different values in the tests and the actu=
al
+ * use of the result.
+ */
+#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+
+/*
+ * This function checks whether a page is free && is the buddy
+ * we can coalesce a page and its buddy if
+ * (a) the buddy is not in a hole (check before calling!) &&
+ * (b) the buddy is in the buddy system &&
+ * (c) a page and its buddy have the same order &&
+ * (d) a page and its buddy are in the same zone.
+ *
+ * For recording whether a page is in the buddy system, we set PageBuddy.
+ * Setting, clearing, and testing PageBuddy is serialized by zone->lock.
+ *
+ * For recording page's order, we use page_private(page).
+ */
+static inline bool page_is_buddy(struct page *page, struct page *buddy,
+							unsigned int order)
+{
+	if (!page_is_guard(buddy) && !PageBuddy(buddy))
+		return false;
+
+	if (buddy_order(buddy) !=3D order)
+		return false;
+
+	/*
+	 * zone check is done late to avoid uselessly calculating
+	 * zone/node ids for pages that could never merge.
+	 */
+	if (page_zone_id(page) !=3D page_zone_id(buddy))
+		return false;
+
+	VM_BUG_ON_PAGE(page_count(buddy) !=3D 0, buddy);
+
+	return true;
+}
+
 /*
  * Locate the struct page for both the matching buddy in our
  * pair (buddy1) and the combined O(n+1) page they form (page).
@@ -234,6 +295,35 @@ __find_buddy_pfn(unsigned long page_pfn, unsigned int =
order)
 	return page_pfn ^ (1 << order);
 }
=20
+/*
+ * Find the buddy of @page and validate it.
+ * @page: The input page
+ * @pfn: The pfn of the page, it saves a call to page_to_pfn() when the
+ *       function is used in the performance-critical __free_one_page().
+ * @order: The order of the page
+ * @buddy_pfn: The output pointer to the buddy pfn, it also saves a call to
+ *             page_to_pfn().
+ *
+ * The found buddy can be a non PageBuddy, out of @page's zone, or its ord=
er is
+ * not the same as @page. The validation is necessary before use it.
+ *
+ * Return: the found buddy page or NULL if not found.
+ */
+static inline struct page *find_buddy_page_pfn(struct page *page,
+			unsigned long pfn, unsigned int order, unsigned long *buddy_pfn)
+{
+	struct page *buddy;
+	unsigned long __buddy_pfn =3D __find_buddy_pfn(pfn, order);
+
+	buddy =3D page + (__buddy_pfn - pfn);
+	if (buddy_pfn)
+		*buddy_pfn =3D __buddy_pfn;
+
+	if (page_is_buddy(page, buddy, order))
+		return buddy;
+	return NULL;
+}
+
 extern struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 				unsigned long end_pfn, struct zone *zone);
=20
@@ -336,33 +426,6 @@ isolate_migratepages_range(struct compact_control *cc,
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
=20
-/*
- * This function returns the order of a free page in the buddy system. In
- * general, page_zone(page)->lock must be held by the caller to prevent the
- * page from being allocated in parallel and returning garbage as the orde=
r.
- * If a caller does not hold page_zone(page)->lock, it must guarantee that=
 the
- * page cannot be allocated or merged in parallel. Alternatively, it must
- * handle invalid values gracefully, and use buddy_order_unsafe() below.
- */
-static inline unsigned int buddy_order(struct page *page)
-{
-	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
-}
-
-/*
- * Like buddy_order(), but for callers who cannot afford to hold the zone =
lock.
- * PageBuddy() should be checked first by the caller to minimize race wind=
ow,
- * and invalid values must be handled gracefully.
- *
- * READ_ONCE is used so that if the caller assigns the result into a local
- * variable and e.g. tests it for valid range before using, the compiler c=
annot
- * decide to remove the variable and inline the page_private(page) multiple
- * times, potentially observing different values in the tests and the actu=
al
- * use of the result.
- */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
-
 /*
  * These three helpers classifies VMAs for virtual memory accounting.
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ea106146686..b08eecd67aba 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -868,40 +868,6 @@ static inline void set_buddy_order(struct page *page, =
unsigned int order)
 	__SetPageBuddy(page);
 }
=20
-/*
- * This function checks whether a page is free && is the buddy
- * we can coalesce a page and its buddy if
- * (a) the buddy is not in a hole (check before calling!) &&
- * (b) the buddy is in the buddy system &&
- * (c) a page and its buddy have the same order &&
- * (d) a page and its buddy are in the same zone.
- *
- * For recording whether a page is in the buddy system, we set PageBuddy.
- * Setting, clearing, and testing PageBuddy is serialized by zone->lock.
- *
- * For recording page's order, we use page_private(page).
- */
-static inline bool page_is_buddy(struct page *page, struct page *buddy,
-							unsigned int order)
-{
-	if (!page_is_guard(buddy) && !PageBuddy(buddy))
-		return false;
-
-	if (buddy_order(buddy) !=3D order)
-		return false;
-
-	/*
-	 * zone check is done late to avoid uselessly calculating
-	 * zone/node ids for pages that could never merge.
-	 */
-	if (page_zone_id(page) !=3D page_zone_id(buddy))
-		return false;
-
-	VM_BUG_ON_PAGE(page_count(buddy) !=3D 0, buddy);
-
-	return true;
-}
-
 #ifdef CONFIG_COMPACTION
 static inline struct capture_control *task_capc(struct zone *zone)
 {
@@ -1010,18 +976,17 @@ static inline bool
 buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 		   struct page *page, unsigned int order)
 {
-	struct page *higher_page, *higher_buddy;
-	unsigned long combined_pfn;
+	struct page *higher_page;
+	unsigned long higher_page_pfn;
=20
 	if (order >=3D MAX_ORDER - 2)
 		return false;
=20
-	combined_pfn =3D buddy_pfn & pfn;
-	higher_page =3D page + (combined_pfn - pfn);
-	buddy_pfn =3D __find_buddy_pfn(combined_pfn, order + 1);
-	higher_buddy =3D higher_page + (buddy_pfn - combined_pfn);
+	higher_page_pfn =3D buddy_pfn & pfn;
+	higher_page =3D page + (higher_page_pfn - pfn);
=20
-	return page_is_buddy(higher_page, higher_buddy, order + 1);
+	return find_buddy_page_pfn(higher_page, higher_page_pfn, order + 1,
+			NULL) !=3D NULL;
 }
=20
 /*
@@ -1075,10 +1040,9 @@ static inline void __free_one_page(struct page *page,
 								migratetype);
 			return;
 		}
-		buddy_pfn =3D __find_buddy_pfn(pfn, order);
-		buddy =3D page + (buddy_pfn - pfn);
=20
-		if (!page_is_buddy(page, buddy, order))
+		buddy =3D find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
+		if (!buddy)
 			goto done_merging;
=20
 		if (unlikely(order >=3D pageblock_order)) {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f67c4c70f17f..ff0ea6308299 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -70,7 +70,6 @@ static void unset_migratetype_isolate(struct page *page, =
unsigned migratetype)
 	unsigned long flags, nr_pages;
 	bool isolated_page =3D false;
 	unsigned int order;
-	unsigned long pfn, buddy_pfn;
 	struct page *buddy;
=20
 	zone =3D page_zone(page);
@@ -89,11 +88,9 @@ static void unset_migratetype_isolate(struct page *page,=
 unsigned migratetype)
 	if (PageBuddy(page)) {
 		order =3D buddy_order(page);
 		if (order >=3D pageblock_order && order < MAX_ORDER - 1) {
-			pfn =3D page_to_pfn(page);
-			buddy_pfn =3D __find_buddy_pfn(pfn, order);
-			buddy =3D page + (buddy_pfn - pfn);
-
-			if (!is_migrate_isolate_page(buddy)) {
+			buddy =3D find_buddy_page_pfn(page, page_to_pfn(page),
+						    order, NULL);
+			if (buddy && !is_migrate_isolate_page(buddy)) {
 				isolated_page =3D !!__isolate_free_page(page, order);
 				/*
 				 * Isolating a free page in an isolated pageblock
--=20
2.35.1

