Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96784F66E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbiDFRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbiDFRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:21:09 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FC4A481A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:19:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D8F643201FB7;
        Wed,  6 Apr 2022 11:19:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Apr 2022 11:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm3; bh=GCOCd
        LBvER1uJBwqDC45zH4ip40h8EDSqkmzj6WuqzU=; b=zPfsw7WVg7lfi3ByClDpx
        0pg9uXOgZUC08+l+yyQFqE/eWFZSlTarVl1MDvLMXRaa/2/ZjcdDop5ig6LPxi2i
        j4kYOFR+TfFnmhQjpjSW6gsIDoqKEK0PWamdmqO+JnFlJmkgHejLe0IiZyGxWjQD
        9WWj7qlEhpZgWgBRjHaasWpxWQcFb7zMrClnM1yQnyvYCssZt0ow5jkcZLYVsEk3
        c0XziZ6YfQ/WRX92FzBENRpSTtmiPTNyw4WE1xi78f5AM4FX9p2aBudIvQmyECGh
        LbL6zIfdkVXNwSezQziFhLdIx4tgP4C1PXbuT26IiS3FN7uLTovmozdRHHoz6Wsg
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=GCOCdLBvER1uJBwqDC45zH4ip40h8
        EDSqkmzj6WuqzU=; b=OMSf9dZuR5EciBZYw7arT4M33IWjH+Ipyhk6Cd7wYEOza
        HMk/7C/mj6f0/M8yxDOjreUfQh75YaBjABO/8bsuvZPjvjNTEG2qKyu3lgvslmV3
        rYMKZTWZVAQWASYCBawcC403d7dEaQDbB6ktvqtHcMrpKbDtwJjffRcG7FLJVPrb
        DFPy6QA3t94cQWyzizf0hHmhExwOwtvQTYscmk84E9LGpgc7jdzNm02a3B9kkwGo
        Tt95wUjhhdunZJFqi2w0/VfS6YCobp5rPgUh5IHQn7R0KovLFxG43hHvnD/UQEu1
        kRQ/y3ACK7zjDl5Eiv+J8omBHjVjbS+zJ50CcI2YA==
X-ME-Sender: <xms:kK9NYkb6uA4DBfA1VhVtFd-GjdCTw2hUFHlrkkL01e0SA_ryq2arzQ>
    <xme:kK9NYvaPGyoYOGeNVYXxj5q75S5YjoQtGWo_TcZh3a6gXV2yNrFYsL-r2RtPcuch1
    YhPFKpMXb9HzseiWQ>
X-ME-Received: <xmr:kK9NYu-nO7Pw0kLuLbej1oiHsIETt54ut4V3_p_nq_wXIz8nlj9YSwDXnQ10Pl60VwJatrPXb6NYBiS-GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgf
    fgleejfeegjedttefhhedvgfffvdeffeekjeetgffhtedvudffkeegleettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:kK9NYuqmfkA0lZnbCC_0S0XBb7aMx4CabcwqEsmFO5ZZxEzCt4iBAA>
    <xmx:kK9NYvoR30di7gP_JbKssVimrCzfYbEAA_iawWkdLqh147OZ-A44nQ>
    <xmx:kK9NYsTff-Mwx5RyoJAslxvoKwpSX52hrK59EsvuGoDQ0RLKC7-uyQ>
    <xmx:kK9NYi1Wk9ymmcq9f9_8IsaEBWT8YGgw7OvhMgv__L2oNastjYGrJw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Apr 2022 11:19:44 -0400 (EDT)
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
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 4/5] mm: cma: use pageblock_order as the single alignment
Date:   Wed,  6 Apr 2022 11:18:57 -0400
Message-Id: <20220406151858.3149821-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406151858.3149821-1-zi.yan@sent.com>
References: <20220406151858.3149821-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now alloc_contig_range() works at pageblock granularity. Change CMA
allocation, which uses alloc_contig_range(), to use pageblock_nr_pages
alignment.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/cma.h    | 4 ++--
 include/linux/mmzone.h | 5 +----
 mm/page_alloc.c        | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index a6f637342740..63873b93deaa 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -17,11 +17,11 @@
 #define CMA_MAX_NAME 64
=20
 /*
- * TODO: once the buddy -- especially pageblock merging and alloc_contig_r=
ange()
+ *  the buddy -- especially pageblock merging and alloc_contig_range()
  * -- can deal with only some pageblocks of a higher-order page being
  *  MIGRATE_CMA, we can use pageblock_nr_pages.
  */
-#define CMA_MIN_ALIGNMENT_PAGES MAX_ORDER_NR_PAGES
+#define CMA_MIN_ALIGNMENT_PAGES pageblock_nr_pages
 #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
=20
 struct cma;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 46ffab808f03..aab70355d64f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -54,10 +54,7 @@ enum migratetype {
 	 *
 	 * The way to use it is to change migratetype of a range of
 	 * pageblocks to MIGRATE_CMA which can be done by
-	 * __free_pageblock_cma() function.  What is important though
-	 * is that a range of pageblocks must be aligned to
-	 * MAX_ORDER_NR_PAGES should biggest page be bigger than
-	 * a single pageblock.
+	 * __free_pageblock_cma() function.
 	 */
 	MIGRATE_CMA,
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2148d3d00a70..29bb5177a7f5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9000,8 +9000,8 @@ int __alloc_contig_migrate_range(struct compact_contr=
ol *cc,
  *			be either of the two.
  * @gfp_mask:	GFP mask to use during compaction
  *
- * The PFN range does not have to be pageblock or MAX_ORDER_NR_PAGES
- * aligned.  The PFN range must belong to a single zone.
+ * The PFN range does not have to be pageblock aligned. The PFN range must
+ * belong to a single zone.
  *
  * The first thing this routine does is attempt to MIGRATE_ISOLATE all
  * pageblocks in the range.  Once isolated, the pageblocks should not
--=20
2.35.1

