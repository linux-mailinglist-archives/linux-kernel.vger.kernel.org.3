Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE744B2AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351790AbiBKQvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:51:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351731AbiBKQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:51:03 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E93D67
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:51:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id DC08A58037A;
        Fri, 11 Feb 2022 11:41:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 11 Feb 2022 11:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=New+plem0avY8e
        mMqwW+nHffrxO930geSXXz9NumNjU=; b=zlqzeudlmr9ByiQoXiXD4oWkPkQWrO
        9LeIZ5gkrbGwvDnTKD/QP5C7t0n60UprSyOc91UIp0QDNUGC/3yQQEqBXXxYPQHo
        ISZooymnxzQdfCRxb1cSPvkuA++2BhOfDjBnGnr6HfxxZjGFmymJKMpeCBwAJJx4
        Kdn2JXSIhmmG3UOv+Qr8TpZJ1iwPScWnQ4pqjPXgPSS5jLPDysklL2yiPX/5kegT
        N0v3yf7/Z7hTjjBH4xB5E3WvuLfQ/z/wvG4sKohcJCv3nPbLVIVN1gwBLXOmdHpg
        fs3ACxLgHy3notg1CzORsf99n6aUNQxFEtaUUKM7GycuXURNpPAN697w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=New+plem0avY8emMqwW+nHffrxO930geSXXz9NumNjU=; b=glMY8862
        ++fO/DiQl5ZcoUaX+3OrMgqO2GO7ce+m2y9vaERy5c20bmlc8TH+s4mIm7bau+jn
        jSQfTEV+8mBxlbrK/mnQe4uNCUYC4p35uLcjIiVDokPV9tHvIu4Ye4KhmqYt0Zd1
        /x49iWVgUZj+MmtBWMPAGHEqxXvd+5Z6CJnrEtC77JEDadDAgHCyQgLFljig4rD5
        DqMIcKJqEzXma0s5g25GvRIJb+kwjvY0owefkDGcJTmyahN+EsZToLLNW7BzbE7Z
        5yPcfnEsRT1G3Mj5rrTWVqFOHBPdNTyIluvVLCcaXsGCCD3gZZB+4VdSu45pxDPL
        bDEo/wpcNkunpg==
X-ME-Sender: <xms:zZEGYvQZk8gpyJ8Pj4MtnKrrV1cllmk7bA-shBiID7da2bQ5TfFOsg>
    <xme:zZEGYgxh2VzsSsDHtoWGS92KROwDZ6IOaP5yp-fIYliNcFFTLOv5w4rxgSEBJRqwP
    ZCDZDRd6w2oJHLnEQ>
X-ME-Received: <xmr:zZEGYk1yL6ya38syYLr1G1LjqLKWtYDTBZ7f511fQKctG2agJkuWDrwSlf3I7UuSfR3zQD5d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:zZEGYvBExFrnqYPN1GAKuz3RfYVV016pydxo0I-qLICR1sqI2XXPJw>
    <xmx:zZEGYoi-BOVP3_n8Ys5qoDZIFjMyE5GUdJwZxKSWp7tJlEegBTEG5w>
    <xmx:zZEGYjrsedyBgPkS-8bdCK94Arbn9ZHrPjME_UrpWTWcOWYgILTTsg>
    <xmx:zZEGYo49QItq9tPnt2bioyW51iIaWPWLBspFiKS4UQyw7KC7EbNW1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:49 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v5 4/6] mm: cma: use pageblock_order as the single alignment
Date:   Fri, 11 Feb 2022 11:41:33 -0500
Message-Id: <20220211164135.1803616-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211164135.1803616-1-zi.yan@sent.com>
References: <20220211164135.1803616-1-zi.yan@sent.com>
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
 include/linux/mmzone.h  | 5 +----
 kernel/dma/contiguous.c | 2 +-
 mm/cma.c                | 6 ++----
 mm/page_alloc.c         | 4 ++--
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3fff6deca2c0..da38c8436493 100644
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
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..ac35b14b0786 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -399,7 +399,7 @@ static const struct reserved_mem_ops rmem_cma_ops =3D {
=20
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	phys_addr_t align =3D PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
+	phys_addr_t align =3D PAGE_SIZE << pageblock_order;
 	phys_addr_t mask =3D align - 1;
 	unsigned long node =3D rmem->fdt_node;
 	bool default_cma =3D of_get_flat_dt_prop(node, "linux,cma-default", NULL);
diff --git a/mm/cma.c b/mm/cma.c
index 766f1b82b532..b2e927fab7b5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -187,8 +187,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys=
_addr_t size,
 		return -EINVAL;
=20
 	/* ensure minimal alignment required by mm core */
-	alignment =3D PAGE_SIZE <<
-			max_t(unsigned long, MAX_ORDER - 1, pageblock_order);
+	alignment =3D PAGE_SIZE << pageblock_order;
=20
 	/* alignment should be aligned with order_per_bit */
 	if (!IS_ALIGNED(alignment >> PAGE_SHIFT, 1 << order_per_bit))
@@ -275,8 +274,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	 * migratetype page by page allocator's buddy algorithm. In the case,
 	 * you couldn't get a contiguous memory, which is not what we want.
 	 */
-	alignment =3D max(alignment,  (phys_addr_t)PAGE_SIZE <<
-			  max_t(unsigned long, MAX_ORDER - 1, pageblock_order));
+	alignment =3D max(alignment,  (phys_addr_t)PAGE_SIZE << pageblock_order);
 	if (fixed && base & (alignment - 1)) {
 		ret =3D -EINVAL;
 		pr_err("Region at %pa must be aligned to %pa bytes\n",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a4fa21aea5c..ac9432e63ce1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9214,8 +9214,8 @@ int isolate_single_pageblock(unsigned long boundary_p=
fn, gfp_t gfp_flags,
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
2.34.1

