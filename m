Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50624EEEA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346590AbiDAOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbiDAOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:00:19 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71BDE0D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:58:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A709E3201F86;
        Fri,  1 Apr 2022 09:58:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Apr 2022 09:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=iwnEykB1b2/b8D
        mQ8le6vvZj3QpvHIfY2VKFpdl/8nY=; b=g+Om+fuhzju2leUInivnh8C2qIQaHL
        XF/QPDkiMuLNqKa+wFapEwVQFlOZkN/a+AoTHMZa0aazl59SumO7kj2k93ahIhk+
        5hvvLFY7rTHb3WGdwUVmEKzMCGuBuggvz8tABe9SM0dT7F5ZK3ez2aw14Tmt36p+
        Zj2bvWR2+IhplHrSsfqziPOM0zHu9W/F0HPt6fk9L2sJhyPcnsCK3+s6Y8uw/w/F
        o9v9K5BOr+JircZo655rMCdFJjMQLsk4yor09WmYaySLsWgbcuaZGZ/VxaW1zJlr
        76SbN8ownfqTjhGe1BWmwnYw6UYrvCpm1rq7TQf/y7AERgNnK3bR+hMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iwnEykB1b2/b8DmQ8le6vvZj3QpvHIfY2VKFpdl/8nY=; b=UE0Zvq/N
        YUG7Z+ibUqLWwT4//+gQfQ9p51b0xLhv15bY3/NlXphUDo27/IbWth5BBfaZBlTa
        f5hkOaBY2i9FM8yCs1uef82Ae9SEc1zbfpAPRdtZzKnibrWO6FclcX68Z4MxKOe3
        61SvbwUu/Ej1KyBkIZwlbXHMbjHdjame3xyw5lxXv8eHQlhfuMFxythCqWKGObGb
        5yslizwwayQwLoyfrG2dKMUP/hOT9/LmKyFvtzLgOA6F9t7p3zNNPa4wXerotpwO
        qYqvLJqqLSf073rjx3Ft3qv0gQ+LeKYUYEcRFQtwLCC2F8WEIMND7p/wH0V1uooI
        jKxcG3a4vYxTLg==
X-ME-Sender: <xms:AgVHYhUzU0BPft3YUh5T3YkZqzVhKt8KTEfSHc82yLgMWDflTNM8oQ>
    <xme:AgVHYhm6o7hGx74IrB6R4Zdq3dVD0740Ym9yarGpwYw4uT4i6ntG4MzX26e1e9pRX
    ldRffNu5hPcJcyKCw>
X-ME-Received: <xmr:AgVHYtYKVesu7lS6N9bwWfUbk2Y0rsp8LZr-x8vAqGA07VjzbdTzXWfOsiyT44V8XYzveI7UJTts4ecwow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkeeiue
    elvddtteeujeehtdegheejledvtdetgfeileejfeeghfeftdeuffefleevnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:AgVHYkVNHXE_2kSzpoiq11ZnYvXYXhlIv0TGBHpVBvO8MyzFG98euA>
    <xmx:AgVHYrmoxcqOcX3EdeAg1t591s05gdy1J_jS4WNaM6Tu24vhnle01g>
    <xmx:AgVHYhepMWUej4hUv3u8zbRUB0RSq6V9xLST0lKWRAIli1sZV7c5bg>
    <xmx:AgVHYkhJZPN0WLEYNIPhvovbHNR4K9PIRQJP4x1zZ48mQ-ACOtqDjQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Apr 2022 09:58:25 -0400 (EDT)
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
Subject: [PATCH 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy page validation.
Date:   Fri,  1 Apr 2022 09:58:20 -0400
Message-Id: <20220401135820.1453829-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401135820.1453829-1-zi.yan@sent.com>
References: <20220401135820.1453829-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
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

Whenever the buddy of a page is found from __find_buddy_pfn(),
page_is_buddy() should be used to check its validity. Add a helper
function find_buddy_page_pfn() to find the buddy page and do the check
together.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-mm/CAHk-=3Dwji_AmYygZMTsPMdJ7XksMt7kOur=
8oDfDdniBRMjm4VkQ@mail.gmail.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/internal.h       | 24 ++---------------
 mm/page_alloc.c     | 63 ++++++++++++++++++++++++++++++++++++++-------
 mm/page_isolation.c |  9 +++----
 3 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 876e66237c89..791653c95bf1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -211,28 +211,8 @@ struct alloc_context {
 	bool spread_dirty_pages;
 };
=20
-/*
- * Locate the struct page for both the matching buddy in our
- * pair (buddy1) and the combined O(n+1) page they form (page).
- *
- * 1) Any buddy B1 will have an order O twin B2 which satisfies
- * the following equation:
- *     B2 =3D B1 ^ (1 << O)
- * For example, if the starting buddy (buddy2) is #8 its order
- * 1 buddy is #10:
- *     B2 =3D 8 ^ (1 << 1) =3D 8 ^ 2 =3D 10
- *
- * 2) Any buddy B will have an order O+1 parent P which
- * satisfies the following equation:
- *     P =3D B & ~(1 << O)
- *
- * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
- */
-static inline unsigned long
-__find_buddy_pfn(unsigned long page_pfn, unsigned int order)
-{
-	return page_pfn ^ (1 << order);
-}
+extern bool find_buddy_page_pfn(struct page *page, unsigned int order,
+				struct page **buddy, unsigned long *buddy_pfn);
=20
 extern struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 				unsigned long end_pfn, struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ea106146686..89490b9a19ef 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -998,6 +998,54 @@ static inline void del_page_from_free_list(struct page=
 *page, struct zone *zone,
 	zone->free_area[order].nr_free--;
 }
=20
+/*
+ * Locate the struct page for both the matching buddy in our
+ * pair (buddy1) and the combined O(n+1) page they form (page).
+ *
+ * 1) Any buddy B1 will have an order O twin B2 which satisfies
+ * the following equation:
+ *     B2 =3D B1 ^ (1 << O)
+ * For example, if the starting buddy (buddy2) is #8 its order
+ * 1 buddy is #10:
+ *     B2 =3D 8 ^ (1 << 1) =3D 8 ^ 2 =3D 10
+ *
+ * 2) Any buddy B will have an order O+1 parent P which
+ * satisfies the following equation:
+ *     P =3D B & ~(1 << O)
+ *
+ * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
+ */
+static inline unsigned long
+__find_buddy_pfn(unsigned long page_pfn, unsigned int order)
+{
+	return page_pfn ^ (1 << order);
+}
+
+
+/*
+ * Find the buddy of @page and validate it.
+ * @page: The input page
+ * @order: Order of the input page
+ * @buddy: Output pointer to the buddy page
+ * @buddy_pfn: Output pointer to the buddy pfn
+ *
+ * The found buddy can be a non PageBuddy, out of @page's zone, or its ord=
er is
+ * not the same as @page. The validation is necessary before use it.
+ *
+ * Return: true if the found buddy page is valid or false if not.
+ *
+ */
+bool find_buddy_page_pfn(struct page *page, unsigned int order,
+			 struct page **buddy, unsigned long *buddy_pfn)
+{
+	unsigned long pfn =3D page_to_pfn(page);
+
+	*buddy_pfn =3D __find_buddy_pfn(pfn, order);
+	*buddy =3D page + (*buddy_pfn - pfn);
+
+	return page_is_buddy(page, *buddy, order);
+}
+
 /*
  * If this is not the largest possible page, check if the buddy
  * of the next-highest order is free. If it is, it's possible
@@ -1011,17 +1059,16 @@ buddy_merge_likely(unsigned long pfn, unsigned long=
 buddy_pfn,
 		   struct page *page, unsigned int order)
 {
 	struct page *higher_page, *higher_buddy;
-	unsigned long combined_pfn;
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
+	return find_buddy_page_pfn(higher_page, order + 1,
+			&higher_buddy, &buddy_pfn);
 }
=20
 /*
@@ -1075,10 +1122,8 @@ static inline void __free_one_page(struct page *page,
 								migratetype);
 			return;
 		}
-		buddy_pfn =3D __find_buddy_pfn(pfn, order);
-		buddy =3D page + (buddy_pfn - pfn);
=20
-		if (!page_is_buddy(page, buddy, order))
+		if (!find_buddy_page_pfn(page, order, &buddy, &buddy_pfn))
 			goto done_merging;
=20
 		if (unlikely(order >=3D pageblock_order)) {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f67c4c70f17f..743c52f489f5 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -70,7 +70,7 @@ static void unset_migratetype_isolate(struct page *page, =
unsigned migratetype)
 	unsigned long flags, nr_pages;
 	bool isolated_page =3D false;
 	unsigned int order;
-	unsigned long pfn, buddy_pfn;
+	unsigned long buddy_pfn;
 	struct page *buddy;
=20
 	zone =3D page_zone(page);
@@ -89,11 +89,8 @@ static void unset_migratetype_isolate(struct page *page,=
 unsigned migratetype)
 	if (PageBuddy(page)) {
 		order =3D buddy_order(page);
 		if (order >=3D pageblock_order && order < MAX_ORDER - 1) {
-			pfn =3D page_to_pfn(page);
-			buddy_pfn =3D __find_buddy_pfn(pfn, order);
-			buddy =3D page + (buddy_pfn - pfn);
-
-			if (!is_migrate_isolate_page(buddy)) {
+			if (find_buddy_page_pfn(page, order, &buddy, &buddy_pfn) &&
+			    !is_migrate_isolate_page(buddy)) {
 				isolated_page =3D !!__isolate_free_page(page, order);
 				/*
 				 * Isolating a free page in an isolated pageblock
--=20
2.35.1

