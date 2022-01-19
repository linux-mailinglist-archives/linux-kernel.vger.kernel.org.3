Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFFA49405E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiASTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:07:26 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42691 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245670AbiASTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:06:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9E21658072C;
        Wed, 19 Jan 2022 14:06:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 19 Jan 2022 14:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=dYxmbR9lEBAS9
        0Asc/Ee5ysOhLtbovg7jYu3vdt1QAM=; b=gZ80mpqsKtYUF3rQxlpVYF4WbOyU8
        RoIvuOfT/JsP3wsD7cP7Fw4fahfzZd5z+hqHa7gihFN0tds5yZKBiJUDuotQretq
        uAKe77LkGCq3VTAOgYRrqwo7OtzL+zf1sN20LHlgfqiVeyIINEbkPtR9BLT0wDuS
        tbGv4YB8I2TZTIPP4uoOd2S3el1GoHvZPkLd9lKoqE1uK9OXUzpx2zb8h4sI7zNk
        6vd3Ht6dcEP+ZSwfQeIZJeM+xh7KGCaMjlH6n55dAxAYBNy9urV7sX3i6w+SPbZj
        zdc8g7b7PgH3O8qOjCKgbIA0eGkVQI3bC25uCOr7R9ramOTcJLYX4FNZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=dYxmbR9lEBAS90Asc/Ee5ysOhLtbovg7jYu3vdt1QAM=; b=Q0kZXCs2
        imBE8b4xbld6/tp6GuVLyqnJwSkqDnh3WSD4EbTQhDz/JheIA4k4GOrpZF1vkHvB
        6//nKaFX+vsqbJn2Je3zTbfMEK4FKaMRYHtbSKW+2nEx6Kz8BbBW8qiXui4Rp4ix
        ywM/AXyCfgOHA4i36rbOquVmwOO6oXEWYlBPVSENx3z6foRmFJ+h7AS+QsoZ6d6k
        frOq9u52eHph+WQoeG8W9V0Eeudu2AyMnFx3PLkmn4kTMk7RTGLEEol6PmVi1Ty4
        3cD79s+Q1uN2SrU6IVKZb9EfuBXXFUhGlHZeLldeFRUWd2cfiDATlYdXgEfTTkPC
        TiMi6ayBiHbVIw==
X-ME-Sender: <xms:P2HoYa4pXJU1z4gklavcyd5OaK92ioQBXxVq9XvaBA0pw8bKGeKRHg>
    <xme:P2HoYT4vDv4gzPlE0y-ygJpeOaryxquUn_lz8UWr2UHY7i-q-I2TguV3XvIB2y7VB
    zE3ahE3uxFpFYhw_A>
X-ME-Received: <xmr:P2HoYZcpBDNZ90K8Xe109bicWDCk4yd8kTLRvHsqCUB8ldegA6bPOczjrJR01tO-hV3XJPnV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:P2HoYXLLOgQLlKjLlhOEfWUnJgJ-r5ydQva39HIPhCru2P1Mt6_HDg>
    <xmx:P2HoYeLPLEVFG_pLXsjSZRAYYDrIOk6pL7__KHR0wUXYihn_lbe9gw>
    <xmx:P2HoYYwrGNhGqB1ffSHm5YKDqSz-iulneoVMJRTFxq9zfoCPBBgSyQ>
    <xmx:P2HoYQAx7fSixKtDz6d2ZgaoZs9UIRGnPbM7TZNTlvZU9WR2dGEmIQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 14:06:39 -0500 (EST)
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
        Eric Ren <renzhengeek@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v4 5/7] mm: cma: use pageblock_order as the single alignment
Date:   Wed, 19 Jan 2022 14:06:21 -0500
Message-Id: <20220119190623.1029355-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119190623.1029355-1-zi.yan@sent.com>
References: <20220119190623.1029355-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
 mm/page_alloc.c         | 6 +++---
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 71b77aab748d..7bd3694b24b4 100644
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
index bc9ca8f3c487..d171158bd418 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -180,8 +180,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys=
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
@@ -268,8 +267,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
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
index 6ed506234efa..a8ced1a00ce8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9008,8 +9008,8 @@ static inline void split_free_page_into_pageblocks(st=
ruct page *free_page,
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
@@ -9125,7 +9125,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 	ret =3D 0;
=20
 	/*
-	 * Pages from [start, end) are within a MAX_ORDER_NR_PAGES
+	 * Pages from [start, end) are within a pageblock_nr_pages
 	 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
 	 * more, all pages in [start, end) are free in page allocator.
 	 * What we are going to do is to allocate all pages from
--=20
2.34.1

