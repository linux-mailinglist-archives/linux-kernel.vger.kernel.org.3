Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E904DCA29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiCQPjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiCQPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:39:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CF20C194
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:37:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 54EC95C080D;
        Thu, 17 Mar 2022 11:37:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Mar 2022 11:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=e95vsXP8jrOyuF
        run5UmlX0V2bedBHGJryguMu0faC4=; b=UWqNf3Kd8KaotX/ss1294lyy7fSU7G
        dgiWKlnTxajt1HhcH88NGj9IWgd8aml2RydYGNAgtCZJiT3xL808/6YLwJ4doshL
        9Bnw1yBPNfPjGUviYLX7IAmLSycPZnl2vMEhSbHr6ylCATHdS8fHf2TgO6qva2NW
        uiJhg/YP33v8zC8w+c5bWv+ncmXmsiET5vfvLdPViP8ZLV4v8Prf4hY6FPhi/5lA
        2+0nRXVNzWjYwPennFl+yVmqkVDhWryDVasUkDfSNf7HDAxVJ9dOeu4MFf5WOgLy
        pvf27NS8ipIvVyTuVMdbG1degJ51OwZ+3r7iG3ffXF7ahWy6BuC6RHqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=e95vsXP8jrOyuFrun5UmlX0V2bedBHGJryguMu0faC4=; b=ba2pks95
        Vd3e2+EnF27pbioPl7YMlxl+GINDwzJWSw2bAdNaOdkDPcQy5wP/mrhjnVWGAeuz
        pTIp0R0sWJvPdi66QM8lPjgmbvhHfUov9kien+UlOGihGryV6SAUEgYbhBFK9jh2
        O0NjVqjNBZud4Fa6g9NtdFqFv/xv1A+HHUfm+rg1PS5PjPq2LSsF8Q49//0jv5Bm
        Pz15x09QegkYcTe/ZGWPZPwVyN2iSjBj2ifb+LIP2AFvxtx2L1Ytcmwf8XmRoT2j
        d+iI7SyBCgYGsEhzGa+Rt5m4VvZpCFxQQpK5zdir+wUAtu5v5FXWkfV6onILxl2W
        K3CpdNuVgpBqlQ==
X-ME-Sender: <xms:zVUzYo7jaDcu7x40WVrVJOkst9GHQmPScAnA-5kWQ8_55RuslDncoQ>
    <xme:zVUzYp6T-AZBF9deQpir7xg7ZV2bS1NBSLzBRhyaTFs4CPwSMqZSWPOdUR9xudyug
    SHd6xzEYpdkSU-pQg>
X-ME-Received: <xmr:zVUzYncmf12OVKyDt4RmpyxAM-5SeFiGWo2H-3pCET-AUCoeOZFQ0zNSCwEo_9svRpsBitjzCbl5jTU0zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:zVUzYtK2SfgxSSCMZ6DseYrRx2D_wD-AjKhqsU4jlnIyPcVnqgglfQ>
    <xmx:zVUzYsJHf9PqonqJqFP9X8-1lKJo9tnXYrc3IidwYa9LY4kVBoDq2Q>
    <xmx:zVUzYux1aEs7FVm9zlTZNEoLILncyzb0FYA4ssXnJn5Jyvj8OCQ6oQ>
    <xmx:zVUzYhUwYlImQkreykkW1CKRI8ere-HquVTJU8V6ilwULHGtY3kxzg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 11:37:48 -0400 (EDT)
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
Subject: [PATCH v8 4/5] mm: cma: use pageblock_order as the single alignment
Date:   Thu, 17 Mar 2022 11:37:32 -0400
Message-Id: <20220317153733.2171277-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317153733.2171277-1-zi.yan@sent.com>
References: <20220317153733.2171277-1-zi.yan@sent.com>
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

Now alloc_contig_range() works at pageblock granularity. Change CMA
allocation, which uses alloc_contig_range(), to use pageblock_order
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
index 962b14d403e8..0725c50ca0cb 100644
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
index c2db271b874f..0f96bd57c258 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9065,8 +9065,8 @@ int __alloc_contig_migrate_range(struct compact_contr=
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

