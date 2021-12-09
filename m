Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E246F72F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhLIXIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:08:21 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52403 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234078AbhLIXIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:08:14 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id A15E258025B;
        Thu,  9 Dec 2021 18:04:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 09 Dec 2021 18:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=uSnT9wX9f4RMq
        YBTDyi5K0c2MPG9GRSJQ2BdfgYLu1Y=; b=yrJquY5Vxp9aHnRf1yxk/mrjinrMk
        puUT86QJ3m3xejhByD6AGOCAMlWkM4ic+/fTJsjGrrOlrGgw+A5D8LaeKXrgQs5K
        XyW9WKm3mTXS7i27T8wFG+DgqoPVTrmGsWSFISPxdXkmsGRVN00OIGqTecWzeVtj
        JyOw1zdKO6tBcX7/CEazWnk4ZPnIEbYhy//29o88prEDHcSN5qSP9EPVigm2Srh/
        vOa84XBnLXIMVs/hU/df53IlEn08xNSacedy2WSCALroQ0NROQkPd4l0SUT4aNN6
        gRZPtBQt+VBrfOncH0bDf/73yxhHM6qJwSS4DDOaJjx3R158ZPTX2RnKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=uSnT9wX9f4RMqYBTDyi5K0c2MPG9GRSJQ2BdfgYLu1Y=; b=AQVq+JfE
        lFDq+6QUOYTBvKLjaTXK0jnW0c9jpLBUM1WhMe8NY5jNBBfgSQYDKtDratHPUlQp
        sTEGcUYldmZ3hm4TllzwO3DjdaT0tAQMSJlWDOvtwNFzimFTi5cCZDnc1QpY/2gI
        O9SyXfzO4SjmT51Ujnstws3Jtl7Kc4JBTOMhhlYWtkuT7NNLNiUw1JYvJvRQ9/gB
        T7h/Th+4MX/sfEi2vcnLzQN6WaSopOvf5U3sp8dd6TgnUiUAAOC8XKXVj3seJLXN
        0DUIZ1TnJcWCcs4yumsuCl15ys/edoz4MnEUoCbNRUxJhlQn/OHJvrjOpTwtt9wX
        vR6qrSjGWm+ZGg==
X-ME-Sender: <xms:houyYXo2UaCMhdwzrPsUASB_AjBU2-VtIa4KDxO2DW_KNySeyD0juw>
    <xme:houyYRrq84WXQAXKEqDIwIxbxbprwwlG8kpnen6Y4YmYaMrnmejk_o_dblfLINU6L
    29JlHllLvEBIMNshw>
X-ME-Received: <xmr:houyYUNhhoBGrbQJP7RH87Gh2L-nfv9BKNkG_ENwUD8BgCXc8EyzNX-lxz2C5vHQ37JbJQAR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:houyYa4HQX3J5SVelIDGoSq8cSgPVHZwVTosHjfcQy3l6m3o9v_TKg>
    <xmx:houyYW5dQvbsiXKespuU4N6x0MC6_a48W5AVL4kMYgQFAYC5maNTgA>
    <xmx:houyYSg4gYCmnKIF-RDJ-4hhe-8PVPFLZJXq_ENBhzubCaE4u8LoAQ>
    <xmx:h4uyYWwqapDJS_QzqajhhXE7IEK_4nnU1oDXPelIE51DF24d6jSrEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:38 -0500 (EST)
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
Subject: [RFC PATCH v2 3/7] mm: migrate: allocate the right size of non hugetlb or THP compound pages.
Date:   Thu,  9 Dec 2021 18:04:10 -0500
Message-Id: <20211209230414.2766515-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
References: <20211209230414.2766515-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

alloc_migration_target() is used by alloc_contig_range() and non-LRU
movable compound pages can be migrated. Current code does not allocate the
right page size for such pages. Check THP precisely using
is_transparent_huge() and add allocation support for non-LRU compound
pages.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d487a399253b..2ce3c771b1de 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1563,7 +1563,7 @@ struct page *alloc_migration_target(struct page *page=
, unsigned long private)
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
 	}
=20
-	if (PageTransHuge(page)) {
+	if (is_transparent_hugepage(page)) {
 		/*
 		 * clear __GFP_RECLAIM to make the migration callback
 		 * consistent with regular THP allocations.
@@ -1572,13 +1572,17 @@ struct page *alloc_migration_target(struct page *pa=
ge, unsigned long private)
 		gfp_mask |=3D GFP_TRANSHUGE;
 		order =3D HPAGE_PMD_ORDER;
 	}
+	if (PageCompound(page)) {
+		gfp_mask |=3D __GFP_COMP;
+		order =3D compound_order(page);
+	}
 	zidx =3D zone_idx(page_zone(page));
 	if (is_highmem_idx(zidx) || zidx =3D=3D ZONE_MOVABLE)
 		gfp_mask |=3D __GFP_HIGHMEM;
=20
 	new_page =3D __alloc_pages(gfp_mask, order, nid, mtc->nmask);
=20
-	if (new_page && PageTransHuge(new_page))
+	if (new_page && is_transparent_hugepage(page))
 		prep_transhuge_page(new_page);
=20
 	return new_page;
--=20
2.33.0

