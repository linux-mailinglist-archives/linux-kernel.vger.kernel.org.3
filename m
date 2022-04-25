Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8093250E331
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbiDYOet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiDYOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:34:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CFB2666
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:31:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C26B5C0185;
        Mon, 25 Apr 2022 10:31:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Apr 2022 10:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1650897091; x=1650983491; bh=FGuSjq7Qo3xUzFw7F3hZNaEuHq5HI+jj6I+
        FwTpeURQ=; b=PMgvB8euRccq21wM7F4HnHrBKTiTgoZEpN3WVqB5zlpFZxbrB48
        qhfl/a7b8yXeFFi3Xo0fNpxjbOzr998/Bcq1/6FxoX7iCxu4bMMuBfOY8faEBNCM
        exGviOuRiFZXq9CnnfR6DyJ/HpUzPMVYYv6f8k8BQCcVMFZAvOoxU9jO3eZkdD6A
        SEej2hXqTRrTnVmKtGKdnMVcxyRwVxcVkpLzfML5EE6l2xCwsJsnk4QhXKukybla
        PmYZcwpo3flYMI2amf9m5hD/2RgjBdV4hzHRtMQFod1gXz5Bn9Q/JANUgYmeio/2
        J2CAAPclPa0iEjDu/Mo0aG6DvfxYyXtXdbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650897091; x=1650983491; bh=F
        GuSjq7Qo3xUzFw7F3hZNaEuHq5HI+jj6I+FwTpeURQ=; b=qF6TRLPv4pfzD9D9/
        Va14A9OhcHzxGGmwchLkfogHJk8Kw/w3urkm17g1zS7m5zLGfrkHltP491iRgIlL
        SjVWPErSQ6CHljQY1LzsKrHF8LMxSbfXjVEv0RODooUTNTHkqi15kT/KqCjSKVe1
        RZ4tR2vxCLxmJjSf5Ik2WhoxTTR0XqWmkPyjTUKLJWbvM0SShmVESvM6vo2xG+x5
        w5cKHyDn8FBsn22O2i/GNF2hbLAq/X8yx9bOlsYlpwxEMJT9UB4fx54Je+Bw5hF0
        KvV5szFX8WUati0aY0SlUcEGqhdbY9VcXGEDQy2ce5BvdG9hiNbfUBPOaqEh2J1d
        ZH1Qw==
X-ME-Sender: <xms:wrBmYk57kdiDNgYPe3fjrybhSIl-OjaIr4ayW1XIc4rydNAlyGag6A>
    <xme:wrBmYl6wl4KfUaXM7K1jJf2jNu6d5BRCYOcAODtyXo8TtdVxzjET_TvABXxd6fnQ-
    CkEa0cjPPHP-ybUNA>
X-ME-Received: <xmr:wrBmYjfkEvWVenocoJPqCuZiNTeqr-DIU-VgP9Nw4PSgbGGj0FN-zG1-W4S48QKB0RMtKeoVy07-hkzxig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddugdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeevhe
    evleehgfduhffhudefteehhfegjeeiudevheevffetuedttdfhkeeuleehudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:wrBmYpIBrKt925zD6JjWG5bCqdiEYBjcTwWlD3vysN5khjqLC9OjBw>
    <xmx:wrBmYoKbgeyIz73j_Wd0eW-I1JFuAFMqlrDoo-OHC-Oez2a_PwiUWg>
    <xmx:wrBmYqyepL1XHzTtBWHDmpc89nbMrYIZrbo7SVGSveRIMX__rK_axQ>
    <xmx:w7BmYlASbtcyLYrCbgqtlT8h8cuY9WneDmUbuHGKOT3wB1R8MWApwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Apr 2022 10:31:30 -0400 (EDT)
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
Subject: [PATCH v11 4/6] mm: page_isolation: enable arbitrary range page isolation.
Date:   Mon, 25 Apr 2022 10:31:16 -0400
Message-Id: <20220425143118.2850746-5-zi.yan@sent.com>
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

Now start_isolate_page_range() is ready to handle arbitrary range
isolation, so move the alignment check/adjustment into the function body.
Do the same for its counterpart undo_isolate_page_range().
alloc_contig_range(), its caller, can pass an arbitrary range instead of
a MAX_ORDER_NR_PAGES aligned one.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c     | 16 ++--------------
 mm/page_isolation.c | 33 ++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 70ddd9a0bcf3..a002cf12eb6c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8924,16 +8924,6 @@ void *__init alloc_large_system_hash(const char *tab=
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
@@ -9075,8 +9065,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
=20
-	ret =3D start_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype, 0, gfp_mask);
+	ret =3D start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
 	if (ret)
 		goto done;
=20
@@ -9157,8 +9146,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 		free_contig_range(end, outer_end - end);
=20
 done:
-	undo_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype);
+	undo_isolate_page_range(start, end, migratetype);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 94b3467e5ba2..75e454f5cf45 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -435,7 +435,6 @@ static int isolate_single_pageblock(unsigned long bound=
ary_pfn, gfp_t gfp_flags,
  * be MIGRATE_ISOLATE.
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
- *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
@@ -482,33 +481,33 @@ int start_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
 {
 	unsigned long pfn;
 	struct page *page;
+	/* isolation is done at page block granularity */
+	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_pages);
+	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
 	int ret;
=20
-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
-
-	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */
-	ret =3D isolate_single_pageblock(start_pfn, gfp_flags, false);
+	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock =
*/
+	ret =3D isolate_single_pageblock(isolate_start, gfp_flags, false);
 	if (ret)
 		return ret;
=20
-	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
-	ret =3D isolate_single_pageblock(end_pfn, gfp_flags, true);
+	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
+	ret =3D isolate_single_pageblock(isolate_end, gfp_flags, true);
 	if (ret) {
-		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
+		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
 		return ret;
 	}
=20
 	/* skip isolated pageblocks at the beginning and end */
-	for (pfn =3D start_pfn + pageblock_nr_pages;
-	     pfn < end_pfn - pageblock_nr_pages;
+	for (pfn =3D isolate_start + pageblock_nr_pages;
+	     pfn < isolate_end - pageblock_nr_pages;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
 					start_pfn, end_pfn)) {
-			undo_isolate_page_range(start_pfn, pfn, migratetype);
+			undo_isolate_page_range(isolate_start, pfn, migratetype);
 			unset_migratetype_isolate(
-				pfn_to_page(end_pfn - pageblock_nr_pages),
+				pfn_to_page(isolate_end - pageblock_nr_pages),
 				migratetype);
 			return -EBUSY;
 		}
@@ -524,12 +523,12 @@ void undo_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
 {
 	unsigned long pfn;
 	struct page *page;
+	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_pages);
+	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
=20
-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
=20
-	for (pfn =3D start_pfn;
-	     pfn < end_pfn;
+	for (pfn =3D isolate_start;
+	     pfn < isolate_end;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
 		if (!page || !is_migrate_isolate_page(page))
--=20
2.35.1

