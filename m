Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C4485B03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbiAEVsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:48:45 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48101 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234142AbiAEVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:48:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 82E62580516;
        Wed,  5 Jan 2022 16:48:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 05 Jan 2022 16:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=pLhfLGipzI8++
        qIYMIVnkD5rDV8QoVpF5W3LR+3/IwA=; b=Gnw5kDEvRJbOmlvoEvQ4vpKG7S8SK
        j1uu9JA2H2vtlHmY099jZo9uhUqNplL221UZxxWi+kHEMyPceoZkdK2p7+Tx3hze
        GMvmLX15SjHzUzKPoJC+pamMGxn73Tui3GMN+JAO5QTamS5hCjQ8dBhpcXXHjQG9
        Myz+ZVi8CB6lYahF5KghMzqj1aDHAj05t5Ub8VuHPGI+Hm2n6zveQGMe7MG/sHOJ
        vj9NG7hfG8ue3GU6uoDuNLBvY5MQXtPIOUjzLxW8yYfZ3DCBhZnMMntbBcuer2Ko
        BkaWE4NqlvBkEKtNV5dymaUNWqZBZSy1mb2x0cZyBeSYF2+iy7PjoxtKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pLhfLGipzI8++qIYMIVnkD5rDV8QoVpF5W3LR+3/IwA=; b=AEIybQwU
        Bc1S4r9mo8e/ZMtEZcXVTF6muGnmR9mczNKkfx5ZlTQPpJs4piw9GhQkuFHUFjGM
        yNQ1nU/dsySLhoLyiFzdNy8bQaqc2HT0vSOQNqYd4+N0o5UWBInRVpGOw/oiNKS0
        lmFkv5kU3BZTCm/osmv0mkgFBzh0m3pmkbMLMUcHuOh7dxWwoNKMazib8+2Mq1K2
        UM+mpLiLDibOWX5C7oMRIZSbTojBAtkWPJ/at9ESR8huXzTBFzHMWcH/98q5WvAP
        X6Iahi7RbyxXhocqm5DWjf04XK0Xr/kX2mzTsbKmbd41fBtSDUgwzaeQGxUAhTsA
        NJ0myAio5iyJ+A==
X-ME-Sender: <xms:KRLWYXgJbYYomj09YaKZvJffXG3--n1E19sF9rW04i4EsGDhZOLatg>
    <xme:KRLWYUD0hEVqOYh_O1a6Rbb1C3sMVJvWKQ_tzmNzRVE5Exmw1M53AJFwFHe0blaMy
    8f7qHEox9H5c2d1Cw>
X-ME-Received: <xmr:KRLWYXHXba88Nt0fqWBicghRi_AGs-v9IOKVKJblSdPpgHJRU-KbmUFbFQk4eU2VwLuVcKJ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:KRLWYUStY0C_yNp3tnXJg3h-VZlU3vlqaZI9NfCcDMZKj-HqA6OBsA>
    <xmx:KRLWYUyiD-cGy-aT2pFUZUoguosb-4450_lqWtS2mMa-Mqw-DvvTdw>
    <xmx:KRLWYa7-bnQSHbm8b1coARXyZRnyOmoJmGcFg6bzebrso1OKTgDFcA>
    <xmx:KRLWYfr0NFMz910K1mT81YWcSwpmDW8BBw2N18y7MOfApSsbK3ospg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:24 -0500 (EST)
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
Subject: [RFC PATCH v3 3/8] mm: migrate: allocate the right size of non hugetlb or THP compound pages.
Date:   Wed,  5 Jan 2022 16:47:51 -0500
Message-Id: <20220105214756.91065-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105214756.91065-1-zi.yan@sent.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
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
 mm/migrate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..b1851ffb8576 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1546,9 +1546,7 @@ struct page *alloc_migration_target(struct page *page=
, unsigned long private)
=20
 		gfp_mask =3D htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
-	}
-
-	if (PageTransHuge(page)) {
+	} else if (is_transparent_hugepage(page)) {
 		/*
 		 * clear __GFP_RECLAIM to make the migration callback
 		 * consistent with regular THP allocations.
@@ -1556,14 +1554,19 @@ struct page *alloc_migration_target(struct page *pa=
ge, unsigned long private)
 		gfp_mask &=3D ~__GFP_RECLAIM;
 		gfp_mask |=3D GFP_TRANSHUGE;
 		order =3D HPAGE_PMD_ORDER;
+	} else if (PageCompound(page)) {
+		/* for non-LRU movable compound pages */
+		gfp_mask |=3D __GFP_COMP;
+		order =3D compound_order(page);
 	}
+
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
2.34.1

