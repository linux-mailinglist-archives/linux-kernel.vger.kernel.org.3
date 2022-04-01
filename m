Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CA94EF990
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiDASNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350046AbiDASNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:13:02 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065491350B8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:11:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 34C5E5C00FF;
        Fri,  1 Apr 2022 14:11:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 01 Apr 2022 14:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=2nU+VZUHjfRgXw79i6wfh74gnFpHiuHpC7Kwwp
        V6T0c=; b=BvgMvHQH6WqSN3yuESJpc6OgNQ4daniLDMKJIWe1jo/uA7Cslp/2mV
        cllA9QvnbWCKmXS2RaySyaufLO49J8Qws2cuGY7AxOuaVTZKjGloHUw1Q/PJ7a0M
        edG+YoR2bPTJB2VZ3KSakhOINl4QNYtEAJva1z8LKeQRONWfOXFi6Iuhm86Ej+fu
        hTr3YjvD6zX2rbZi6foc4WyiWgaj7dA2b0zZ6JCaOKghiP4sZacxg2nl0ZZ0EcA/
        tL49zNzeOFiMOA2xWMae2B1UA6SVlK947tbi0KIye4tlvMnPOKKbrIV0OC2FCJfR
        dfEBF0+AFMuGSvgJXsDzzjD//0G4L2DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=2nU+VZUHjfRgXw79i6wfh74gnFpHi
        uHpC7KwwpV6T0c=; b=Ze8jvykDpD1eKriGlh5yFRWi9dJXlDQ3PsDdAuhzZ2zgU
        6BTHhZmxvO3++wVEcN3D5UiJXOtkCnWv9OOQGpE0CfmVBi8l/BG7R7Afj6BFbgrv
        uMhV3YvDKvuFehGvkFMPP54jKI93dafxPs7cvdUpeidC4/spPjRZkrVGe8nm63ZC
        3kGzkfyGAqDFa6R5xxeo+yEpNcabwyUm8A+K6sOWOwwYBfE5LXuHIjH7QP+hkWib
        nQ7njh7gDxe54iuxBnVmUvkuCuf07CPtdiyjdbzwO5peWkyP3fjax2deq4ylyKWK
        DWITbSCJa8LMqyu2Bzvh9Tqv8BbNotx5KuOj2fBMw==
X-ME-Sender: <xms:P0BHYhweB2pTyc0GUHvIamDslASzB53I1AMDUKGt59nIBoFtmNUcIA>
    <xme:P0BHYhQW29tkO6l3YosIFE3DAf5_LfYU1ASOUM0u-vtR-W6U5wecSSF7Mc8c071gJ
    q58w76sQGsySLtZKA>
X-ME-Received: <xmr:P0BHYrW27hvrAmMH2A9qPsg3Uw8HWuyz2qhNR6Nz-oaSQIPV0R7vsKGP95r5hEMUzzhxNOa3uSdkUlHRZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitd
    ejgffhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:P0BHYjjViQbT4n4-LS_Z1f49klCNsTuSF3jnWLGoU-ax-Tb6UjtpRg>
    <xmx:P0BHYjDdI_qOYOo1R9aPxWfthNtgiXlUMpzacHn93KYWplh5Xnp-Vg>
    <xmx:P0BHYsLpJMOfNLeRYdQyAAUtWNgQbn_xErNoY2TgoiOtyzNBd4ATZA>
    <xmx:QEBHYvuzHncK5oeEdFkm4XLd6dY15LvBkZTfZMU5sqFKkgnfiEwQkg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Apr 2022 14:11:11 -0400 (EDT)
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
Subject: [PATCH v2 1/2] mm: page_alloc: simplify pageblock migratetype check in __free_one_page().
Date:   Fri,  1 Apr 2022 14:11:08 -0400
Message-Id: <20220401181109.1477354-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
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

