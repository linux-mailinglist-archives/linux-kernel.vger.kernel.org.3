Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45094EFCFB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353342AbiDAXKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiDAXKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:10:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144C1A7757
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 16:08:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 85B365C01C6;
        Fri,  1 Apr 2022 19:08:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Apr 2022 19:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=n7TcKvtoCX05FSZFqOIqh4H/JQJNmNodokE+bj
        ntX2M=; b=VDAVqSyUvErOuKXGvLhBqj13vFM2Pu/M1VOx9zjzs/ak8FGTQAfhp3
        XHIx4YEMxM5OjOhpwoWgkRIcROFUX/2JdGlAVVbgO5df2e41NkxKTJf5Dfe09ot5
        0LVTmNpQUnOVZG1QU5Lg95T+7PU2GEfuf4TaR8uehV8FPLTvGQpcoYgpbtSm4IJ2
        MxPjOcusxCKHstCEviiRoy/VtLEtXhu2v0FIsHq8GNNdK8mwJnJ+lCewNxfHZMUR
        NxQN47E0ZLekzArjh44gUEr8fKqqSX1VgYQuHjFMcU3lD+MP4ZWT0zWCA0BRaU/M
        AXHyaNs3aYX7IMDAFzZm2YXUJlEEshHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=n7TcKvtoCX05FSZFqOIqh4H/JQJNm
        NodokE+bjntX2M=; b=J3Dav6ap+XnWqah7nTw20jx+92by9t7q8rNPlP0FT3s1Y
        uk0UFFuQLEPxldHXdl6CMMn5b9Ivl70xM/rrPV8RcuZHuhbx5ljBN27rlddUa8R0
        U/CAlDwgV10LoYT/AuA2dp3+TN4tYqkGm0C/7bqKLwKoy/OlDyCQeByoXBO83Gel
        nV1HXp292OM0PkC5FXPRSSAo0hYmGL5EjswNb4OGowKDCvQD082Da6x0DRJGMpN2
        dWRICq249llCECQWTvdKzNDgPdhgj0zFalj1nvtXn6LxsXxcj64ZQBC/ku+6S2iN
        lMXJB/KV1WMKlcbHucO8VNsg1uvy+HeFMK43/iiOQ==
X-ME-Sender: <xms:2IVHYmGVhewSd7c5qZDW_SOEZ3HvJCmDgP8pSNDra4xxUwQqhe6hJA>
    <xme:2IVHYnXcd9QERIWc6RykZtP5Sc5Mg5ilkaPG-ALOhJf4AA5OAGAHU-FzbG3uYdA_I
    Fe0xHp321k0_Oe4WQ>
X-ME-Received: <xmr:2IVHYgJUVtCHUyBG7sKYFBfbUDBJPJIH44PkehqAxk8WC7HFvANIYxgKhHs7mWHqkVZJHjE2srJML_T2eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeijedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteeiiedtje
    fghfefueekjedvueeftddvudelhfetudffiefgfeetheeghfdvgedunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:2IVHYgH99ra5TIeFekGslBf4E1V_2EvcS7TvEGKuJJWmSk3jymav4g>
    <xmx:2IVHYsVjqCX-RJkfjbqIzMpKpQ1YGo5YxPZ1DyTfI02_QA4a8R07Cw>
    <xmx:2IVHYjMV2KIeryS3GXnoJaTcMsPYfxOz9QMuuND008sySFEdVEKgeA>
    <xmx:2YVHYgRgOYQcOWhkGh7M2LCELpRsNC8Q9fvftuttuQPAp7cK81iZpQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Apr 2022 19:08:08 -0400 (EDT)
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
Subject: [PATCH v3 1/2] mm: page_alloc: simplify pageblock migratetype check in __free_one_page().
Date:   Fri,  1 Apr 2022 19:08:03 -0400
Message-Id: <20220401230804.1658207-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
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

Move pageblock migratetype check code in the while loop to simplify the
logic. It also saves redundant buddy page checking code.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/linux-mm/27ff69f9-60c5-9e59-feb2-295250077551=
@suse.cz/
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 856473e54155..2ea106146686 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1054,7 +1054,6 @@ static inline void __free_one_page(struct page *page,
 		int migratetype, fpi_t fpi_flags)
 {
 	struct capture_control *capc =3D task_capc(zone);
-	unsigned int max_order =3D pageblock_order;
 	unsigned long buddy_pfn;
 	unsigned long combined_pfn;
 	struct page *buddy;
@@ -1070,8 +1069,7 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
=20
-continue_merging:
-	while (order < max_order) {
+	while (order < MAX_ORDER - 1) {
 		if (compaction_capture(capc, page, order, migratetype)) {
 			__mod_zone_freepage_state(zone, -(1 << order),
 								migratetype);
@@ -1082,6 +1080,22 @@ static inline void __free_one_page(struct page *page,
=20
 		if (!page_is_buddy(page, buddy, order))
 			goto done_merging;
+
+		if (unlikely(order >=3D pageblock_order)) {
+			/*
+			 * We want to prevent merge between freepages on pageblock
+			 * without fallbacks and normal pageblock. Without this,
+			 * pageblock isolation could cause incorrect freepage or CMA
+			 * accounting or HIGHATOMIC accounting.
+			 */
+			int buddy_mt =3D get_pageblock_migratetype(buddy);
+
+			if (migratetype !=3D buddy_mt
+					&& (!migratetype_is_mergeable(migratetype) ||
+						!migratetype_is_mergeable(buddy_mt)))
+				goto done_merging;
+		}
+
 		/*
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
@@ -1095,32 +1109,6 @@ static inline void __free_one_page(struct page *page,
 		pfn =3D combined_pfn;
 		order++;
 	}
-	if (order < MAX_ORDER - 1) {
-		/* If we are here, it means order is >=3D pageblock_order.
-		 * We want to prevent merge between freepages on pageblock
-		 * without fallbacks and normal pageblock. Without this,
-		 * pageblock isolation could cause incorrect freepage or CMA
-		 * accounting or HIGHATOMIC accounting.
-		 *
-		 * We don't want to hit this code for the more frequent
-		 * low-order merging.
-		 */
-		int buddy_mt;
-
-		buddy_pfn =3D __find_buddy_pfn(pfn, order);
-		buddy =3D page + (buddy_pfn - pfn);
-
-		if (!page_is_buddy(page, buddy, order))
-			goto done_merging;
-		buddy_mt =3D get_pageblock_migratetype(buddy);
-
-		if (migratetype !=3D buddy_mt
-				&& (!migratetype_is_mergeable(migratetype) ||
-					!migratetype_is_mergeable(buddy_mt)))
-			goto done_merging;
-		max_order =3D order + 1;
-		goto continue_merging;
-	}
=20
 done_merging:
 	set_buddy_order(page, order);
--=20
2.35.1

