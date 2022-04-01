Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B134EF991
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbiDASNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350180AbiDASND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:13:03 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AFE137036
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:11:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 04D0C5C0113;
        Fri,  1 Apr 2022 14:11:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Apr 2022 14:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=5Gk8ojAh+kjQww
        m1eaNCCrbPZRcvgtihcLP51TB7JEA=; b=uA+yxaatWO5NZ2nMetzW6wRY/CK/6D
        xGdGpsLWzWvmlcrLqan6RpTXw2vgZcQ6wC8A/S+XKpdsJ2QbYHcGt3MID0Go7qfD
        ZlGF6/GOQn5MEnY8Q5WsCrhJob1VU0nB0RaqTGgf50V5xsXc0ql9SoPWDL2V3e+P
        pnwyFB8lzQ+5oAxb6h6qBIHUUugGjsEUn9Pa8CX+63e8Oi20gnsbgIFRkr0l4Tnb
        T77iK2DuGfqNHYH2mR/BOo6zin3iaNwcUqoGOAejg8u8GDdX3FN6CO6MKWc46afQ
        sp7gwcjsAqgWiaGSAtVXwqCaqQ7DGjD3ZKCACVmbcUW3ZMu4gqTy+BEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=5Gk8ojAh+kjQwwm1eaNCCrbPZRcvgtihcLP51TB7JEA=; b=OUFHIpYC
        QfKFnbI2tJ8Llnbj4As8s4e2eZ7DYzxDfNgtUzxHAOCdB9VPd58LXnbHQLr4Vhj1
        kOW7y4+Z6nSMw5fRgyzYds6hAXeUNi9uWD2Oyb6QSIcM7Y3u/T7vEaJmQI5caFff
        loaC18ghpI+151dyP++fygZs1kGa0eHEy5HR7tOcMKRSwm+RhEYZvN8OBw22bW5G
        do+8Qusa8jsIYzhr7MckErCRUms8BNKZ/IPtZsS/GJ4yO7+NgdDgyt8QpMJXXHc0
        lywV2x4nV7RvBK7A0zqLJuKp/VLbRXPd/vD/yhxtJnFlNI5ayau0xIqsBY7AIRMj
        M2/gGYvZLRFKnA==
X-ME-Sender: <xms:QEBHYh-iQzVC_VtvyO-mqty1eLRjS2B0Unat7BTVW5vx8SK5Qmkk7A>
    <xme:QEBHYlv9_Q-FwY4FTkJftgH_mmNmZSyPW7ktt2kNYN7wlurlwN7Rui6uXmhH-Djfe
    TzZeGUwkeLulT2fhQ>
X-ME-Received: <xmr:QEBHYvD5CHJVr6Q7sfuV7Ms14RsiUF7IQjZOoT-mDNCAExUPLAitJxOTGKNw-JPxiKxGfHNV1lzpnESM_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiiedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeekie
    euledvtdetueejhedtgeehjeelvddttefgieeljeefgefhfedtuefffeelveenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:QEBHYld3g2wPMncNfmJNwHZcN_L5zoPcdogeIQjmPVXvdDK21lIl7A>
    <xmx:QEBHYmO-qQPYI8a_087N9elXqgktkTpkq3Cj8xQN_tc7L3Ft0jRS7A>
    <xmx:QEBHYnmefe5k-MzwaXkzvH8j4xl8ojV7IaBCrMWxHuVu8gQ423XYSA>
    <xmx:QUBHYtob0WReQFMrlJ2oS4dM4P2g7WmV9xgMxZnFmF0vkR8yg77IcQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Apr 2022 14:11:12 -0400 (EDT)
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
Subject: [PATCH v2 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy page validation.
Date:   Fri,  1 Apr 2022 14:11:09 -0400
Message-Id: <20220401181109.1477354-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401181109.1477354-1-zi.yan@sent.com>
References: <20220401181109.1477354-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 mm/internal.h       | 23 +----------------
 mm/page_alloc.c     | 63 ++++++++++++++++++++++++++++++++++++++-------
 mm/page_isolation.c |  8 ++----
 3 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 876e66237c89..f43565ed5ff6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -211,28 +211,7 @@ struct alloc_context {
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
+extern struct page *find_buddy_page_pfn(struct page *page, unsigned int or=
der);
=20
 extern struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 				unsigned long end_pfn, struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ea106146686..8aedc6fbfdd0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -998,6 +998,51 @@ static inline void del_page_from_free_list(struct page=
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
+ * @order: The order of the input page
+ *
+ * The found buddy can be a non PageBuddy, out of @page's zone, or its ord=
er is
+ * not the same as @page. The validation is necessary before use it.
+ *
+ * Return: the found buddy page or NULL if not found.
+ */
+struct page *find_buddy_page_pfn(struct page *page, unsigned int order)
+{
+	unsigned long pfn =3D page_to_pfn(page);
+	unsigned long buddy_pfn =3D __find_buddy_pfn(pfn, order);
+	struct page *buddy =3D page + (buddy_pfn - pfn);
+
+	if (page_is_buddy(page, buddy, order))
+		return buddy;
+	return NULL;
+}
+
 /*
  * If this is not the largest possible page, check if the buddy
  * of the next-highest order is free. If it is, it's possible
@@ -1010,18 +1055,16 @@ static inline bool
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
+	return find_buddy_page_pfn(higher_page, order + 1) !=3D NULL;
 }
=20
 /*
@@ -1075,11 +1118,11 @@ static inline void __free_one_page(struct page *pag=
e,
 								migratetype);
 			return;
 		}
-		buddy_pfn =3D __find_buddy_pfn(pfn, order);
-		buddy =3D page + (buddy_pfn - pfn);
=20
-		if (!page_is_buddy(page, buddy, order))
+		buddy =3D find_buddy_page_pfn(page, order);
+		if (!buddy)
 			goto done_merging;
+		buddy_pfn =3D page_to_pfn(buddy);
=20
 		if (unlikely(order >=3D pageblock_order)) {
 			/*
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f67c4c70f17f..7326c9f57d55 100644
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
@@ -89,11 +88,8 @@ static void unset_migratetype_isolate(struct page *page,=
 unsigned migratetype)
 	if (PageBuddy(page)) {
 		order =3D buddy_order(page);
 		if (order >=3D pageblock_order && order < MAX_ORDER - 1) {
-			pfn =3D page_to_pfn(page);
-			buddy_pfn =3D __find_buddy_pfn(pfn, order);
-			buddy =3D page + (buddy_pfn - pfn);
-
-			if (!is_migrate_isolate_page(buddy)) {
+			buddy =3D find_buddy_page_pfn(page, order);
+			if (buddy && !is_migrate_isolate_page(buddy)) {
 				isolated_page =3D !!__isolate_free_page(page, order);
 				/*
 				 * Isolating a free page in an isolated pageblock
--=20
2.35.1

