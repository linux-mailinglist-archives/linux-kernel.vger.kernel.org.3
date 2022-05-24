Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D15331DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiEXTsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiEXTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:48:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882FF7891F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:48:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A29A5C0032;
        Tue, 24 May 2022 15:48:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 24 May 2022 15:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653421685; x=1653508085; bh=ZpwXMIH/Cm
        QdxWrQcbDbQD73tby8hCsCaEBy16ra0II=; b=FkXa5Knqp+IZCcFZsxvn1Ra3SB
        DxPM/HVse9ZyObwufToUzzmilQkNVBRvb2EsScy1Jz0kDcrE6EJsl2aYtCUxBsGg
        +PSLHnlZ0d/5Z93z71VteCchkZfeTxhtzuE+wQAAHUGx1Pkb3M+dX5LFPxc9dvXY
        1Jf2BfuYc3098Y7pS/e2Agci+I6b/vsZC4skoiP4SYdvAh+g7muM6W37FupcZF3m
        V2LkVWQ5+HLZ0ftTIgkfnPXw+g6CQb4JENV4oTEjqXQPu17wdHrIDm0tVzQlmefS
        u783KPglaSw5aBfaBe9Km45tgXAMe3kZBEyclDxw8fltprwBd9pCmU8ZPLfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653421685; x=1653508085; bh=ZpwXMIH/CmQdxWrQcbDbQD73tby8
        hCsCaEBy16ra0II=; b=XqLXcJmea8MdC4D+ax5PhyF8VI+qWZxIIaNqvn5nTqCl
        7PpG5/fPPVNWlTsRrGOhW2binwQXiwAIgy0RKJt57K5SfH2p/GqpxClXhvakqPxs
        99TFY1kKZaOff4TduN/QAplFFoJh/qURkSCn/Ak5GnyWbpgfbmBYMwTsTAe1MTOu
        iSzupr2dCm5r1haHjft9pixL6JuKYIab3HCFGEwgh6oQ8Wa2wDZAF524arTkGRbH
        RLqEqEJhJioYyl0OTjmXhiQTRWsJD4Qsv2xVcUsiQ/rVyAbkSa9mkchCvVTPkQBj
        XLO8ok2IVjfHAgb+/yKJdlOOUREgOOmdkvRwnVoRHA==
X-ME-Sender: <xms:dDaNYuK4EqWE1f1pZ1xajryIdx_8JnT0wIC7GFXsjoVbo-MSFIlVaw>
    <xme:dDaNYmLgYc__OTsVWFBsyUNeNS005izMzEa71lIha6Y0DQkm0mWLu2EEDjJhQOu3D
    B3BLlo4tZE-P7qp3w>
X-ME-Received: <xmr:dDaNYuvt_AnrgXk1Pv7Mn9n1ciOb_zIagrA-nYPC6KlrYpudZ3dzk1Cw-WCZU98IpuyblLxPSmlMyzjalQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeefgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpedtgffhtd
    etledtkeeihfefueeuhedvudfhvdeifeevtdektdetgfeiieejuefhtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:dDaNYjbb-eHqit3QHqdAegvbrWE4KVKJAuSErctLLm8kpCH77pYPPQ>
    <xmx:dDaNYlaeYNiBArPkQouzhSuoMLqhIAIvEmghmwdNt5S656HQdCBczg>
    <xmx:dDaNYvBKk_tMmL0oJDMwpyV2h0BL4OHBQTBKSpVCBUkLNBeiFWjggQ>
    <xmx:dTaNYrD5UTrY7dTrX6LV_ZMxuOHodmUk6daZ6Pd8Y9OyBqS_UuW_7w>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 May 2022 15:48:04 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm: fix a potential infinite loop in start_isolate_page_range().
Date:   Tue, 24 May 2022 15:47:56 -0400
Message-Id: <20220524194756.1698351-1-zi.yan@sent.com>
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

In isolate_single_pageblock() called by start_isolate_page_range(),
there are some pageblock isolation issues causing a potential
infinite loop when isolating a page range. This is reported by Qian Cai.

1. the pageblock was isolated by just changing pageblock migratetype
   without checking unmovable pages. Calling set_migratetype_isolate() to
   isolate pageblock properly.
2. an off-by-one error caused migrating pages unnecessarily, since the page
   is not crossing pageblock boundary.
3. migrating a compound page across pageblock boundary then splitting the
   free page later has a small race window that the free page might be
   allocated again, so that the code will try again, causing an potential
   infinite loop. Temporarily set the to-be-migrated page's pageblock to
   MIGRATE_ISOLATE to prevent that and bail out early if no free page is
   found after page migration.

An additional fix to split_free_page() aims to avoid crashing in
__free_one_page(). When the free page is split at the specified
split_pfn_offset, free_page_order should check both the first bit of
free_page_pfn and the last bit of split_pfn_offset and use the smaller one.
For example, if free_page_pfn=3D0x10000, split_pfn_offset=3D0xc000,
free_page_order should first be 0x8000 then 0x4000, instead of 0x4000 then
0x8000, which the original algorithm did.

Fixes: b2c9e2fbba ("mm: make alloc_contig_range work at pageblock granulari=
ty")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c     |  5 ++++-
 mm/page_isolation.c | 52 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 267599dd9706..6eec0211e0be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1114,13 +1114,16 @@ void split_free_page(struct page *free_page,
 	unsigned long flags;
 	int free_page_order;
=20
+	if (split_pfn_offset =3D=3D 0)
+		return;
+
 	spin_lock_irqsave(&zone->lock, flags);
 	del_page_from_free_list(free_page, zone, order);
 	for (pfn =3D free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
=20
-		free_page_order =3D ffs(split_pfn_offset) - 1;
+		free_page_order =3D min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offset=
));
 		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
 				mt, FPI_NONE);
 		pfn +=3D 1UL << free_page_order;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b3f074d1682e..c643c8420809 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -283,6 +283,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_=
pages)
  * isolate_single_pageblock() -- tries to isolate a pageblock that might be
  * within a free or in-use page.
  * @boundary_pfn:		pageblock-aligned pfn that a page might cross
+ * @flags:			isolation flags
  * @gfp_flags:			GFP flags used for migrating pages
  * @isolate_before:	isolate the pageblock before the boundary_pfn
  *
@@ -298,14 +299,15 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * either. The function handles this by splitting the free page or migrati=
ng
  * the in-use page then splitting the free page.
  */
-static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_=
flags,
-			bool isolate_before)
+static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
+			gfp_t gfp_flags, bool isolate_before)
 {
 	unsigned char saved_mt;
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
 	unsigned long pfn;
 	struct zone *zone;
+	int ret;
=20
 	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
=20
@@ -325,7 +327,11 @@ static int isolate_single_pageblock(unsigned long boun=
dary_pfn, gfp_t gfp_flags,
 				      zone->zone_start_pfn);
=20
 	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
-	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISOLATE=
);
+	ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt,=
 flags,
+			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
+
+	if (ret)
+		return ret;
=20
 	/*
 	 * Bail out early when the to-be-isolated pageblock does not form
@@ -374,7 +380,7 @@ static int isolate_single_pageblock(unsigned long bound=
ary_pfn, gfp_t gfp_flags,
 			struct page *head =3D compound_head(page);
 			unsigned long head_pfn =3D page_to_pfn(head);
=20
-			if (head_pfn + nr_pages < boundary_pfn) {
+			if (head_pfn + nr_pages <=3D boundary_pfn) {
 				pfn =3D head_pfn + nr_pages;
 				continue;
 			}
@@ -386,7 +392,8 @@ static int isolate_single_pageblock(unsigned long bound=
ary_pfn, gfp_t gfp_flags,
 			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
 				int order;
 				unsigned long outer_pfn;
-				int ret;
+				int page_mt =3D get_pageblock_migratetype(page);
+				bool isolate_page =3D !is_migrate_isolate_page(page);
 				struct compact_control cc =3D {
 					.nr_migratepages =3D 0,
 					.order =3D -1,
@@ -399,9 +406,31 @@ static int isolate_single_pageblock(unsigned long boun=
dary_pfn, gfp_t gfp_flags,
 				};
 				INIT_LIST_HEAD(&cc.migratepages);
=20
+				/*
+				 * XXX: mark the page as MIGRATE_ISOLATE so that
+				 * no one else can grab the freed page after migration.
+				 * Ideally, the page should be freed as two separate
+				 * pages to be added into separate migratetype free
+				 * lists.
+				 */
+				if (isolate_page) {
+					ret =3D set_migratetype_isolate(page, page_mt,
+						flags, head_pfn, head_pfn + nr_pages);
+					if (ret)
+						goto failed;
+				}
+
 				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
 							head_pfn + nr_pages);
=20
+				/*
+				 * restore the page's migratetype so that it can
+				 * be split into separate migratetype free lists
+				 * later.
+				 */
+				if (isolate_page)
+					unset_migratetype_isolate(page, page_mt);
+
 				if (ret)
 					goto failed;
 				/*
@@ -417,10 +446,9 @@ static int isolate_single_pageblock(unsigned long boun=
dary_pfn, gfp_t gfp_flags,
 				order =3D 0;
 				outer_pfn =3D pfn;
 				while (!PageBuddy(pfn_to_page(outer_pfn))) {
-					if (++order >=3D MAX_ORDER) {
-						outer_pfn =3D pfn;
-						break;
-					}
+					/* stop if we cannot find the free page */
+					if (++order >=3D MAX_ORDER)
+						goto failed;
 					outer_pfn &=3D ~0UL << order;
 				}
 				pfn =3D outer_pfn;
@@ -435,7 +463,7 @@ static int isolate_single_pageblock(unsigned long bound=
ary_pfn, gfp_t gfp_flags,
 	return 0;
 failed:
 	/* restore the original migratetype */
-	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
+	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
 	return -EBUSY;
 }
=20
@@ -496,12 +524,12 @@ int start_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
 	int ret;
=20
 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock =
*/
-	ret =3D isolate_single_pageblock(isolate_start, gfp_flags, false);
+	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
 	if (ret)
 		return ret;
=20
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
-	ret =3D isolate_single_pageblock(isolate_end, gfp_flags, true);
+	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
 		return ret;
--=20
2.35.1

