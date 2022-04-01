Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218CF4EEEAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346597AbiDAOA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiDAOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:00:19 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E2C79
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:58:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D9D393200F72;
        Fri,  1 Apr 2022 09:58:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Apr 2022 09:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=2nU+VZUHjfRgXw79i6wfh74gnFpHiuHpC7Kwwp
        V6T0c=; b=OuASuwFKrQxica335ULucZKiokxQcmSt4KrmN5ES0JNIb755nefSlm
        3edc33v1hLP0t+++hbn32p5/Ak5JDlDw9fmTC/iZuAUYnTwB6nf7znDzlMl/QhfC
        hTjiJ1ZwmkyEj0yI8q6JfJwyb41KjqQgmAKYLV8gHjXhi9kGXSaCNbgIRvpnoksZ
        p/CQFKRtvkQQNhHsb0LGhRvnI+G7aYdrDuU0ixKwCusEYB3JQnFvLoWzPUm6ms0h
        ud/mQsnYX31xUYwtFz7TdiA2b8COWNTKS67w32Y9KHA6njHttK17oQZmMtLKFLTb
        ApZ1CEF6rnYO9ut+HCHwy6bUSmYJUJxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=2nU+VZUHjfRgXw79i6wfh74gnFpHi
        uHpC7KwwpV6T0c=; b=f35dgA121EFkB1TBtfF78IZ6c6+Bq4ZdaFRMx3RMTaJpK
        l/9faZdXR6pgZYfw0zY02vrMLoGvVagPt9w9T7BMdI0vf7UCExAT6iZBYwx0TrI3
        K7Kpn5yCBO7lnElRw+nc+i6rz56DF4c66CAR7gAlhKpKNjQclGsgm9Qf9GhXWutv
        qNme3Al6fAbwd05wRzCZPhCDchytZLJu7IfCo515Zw+ZqRFqO3VJIoRXyTwB67aZ
        R8mk58tkqQgGSWvgk7V0AZovlj0rOASRmHhvtPVv525ZUNHXGiLGLYtwuuXgqPlu
        Y+7TjwVMaCnNkL0iGBFlFzd/JozwX6CuDAPuTWruA==
X-ME-Sender: <xms:_wRHYvNGqM70L1016mlgyn4N64r7Fo4gWrKuKeLreRVf-ANLm88ILA>
    <xme:_wRHYp-jXpdYkGyFDlVHUKTXpYRmZEqz4RknYJp-awzlTLeBn7x1fsE5d2qYGLTml
    8BmP_G4k9Bay_sGbQ>
X-ME-Received: <xmr:_wRHYuTcQCpnAYLUomeJr4OUqusJk5zatHo5DL805ra1qHH_IK0NjbSxbiKizwvRP3WPcyUxspxNV6FSiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteeiiedtje
    fghfefueekjedvueeftddvudelhfetudffiefgfeetheeghfdvgedunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:_wRHYjtRJuPRHJZXfsZJ-GAvc1cOnCF5FujH0B8Q30ZM8D_a1vdrLA>
    <xmx:_wRHYndc82xGckScSSpi632FMYpH5Uo-BMeDe7HFcg35gfG6PHgllg>
    <xmx:_wRHYv3kS_lPx50KHR-leB7F1ZdjpYpiiqJlWZZ4xNnI2DlqPQLWXA>
    <xmx:AAVHYr42LgWsjsjgFAOM0TDK25FSar7JBQ8ym9BQQ2QTYgs84MVEYQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Apr 2022 09:58:23 -0400 (EDT)
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
Subject: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check in __free_one_page().
Date:   Fri,  1 Apr 2022 09:58:19 -0400
Message-Id: <20220401135820.1453829-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
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

Move pageblock migratetype check code in the while loop to simplify the
logic. It also saves redundant buddy page checking code.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/linux-mm/27ff69f9-60c5-9e59-feb2-295250077551=
@suse.cz/
Signed-off-by: Zi Yan <ziy@nvidia.com>
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

