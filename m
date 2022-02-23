Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0B4C0B18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiBWEb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiBWEbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:31:16 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9949C90
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:30:50 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id E68F7580151;
        Tue, 22 Feb 2022 23:30:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Feb 2022 23:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=EW0q3DKsqq85t3
        6Mhl5XwyP6zYfcE0gyy04nLECgLok=; b=OvJS9MBw0ak9QSpdlP0SjZT4EbTlVg
        G957KqEariXB87msO6UEXK8rXWBNRiPEu8WQJtJhslcx5XbwmNwSj3g3yHIcD3Aa
        SXiPHwpFb9ZgkYzgwvFBvEml0kMAqhy4E9+2zq6+vi+84oAzkthnmjNYuJQvkkn3
        NvFUSmz6hDV3JJJ/ZumtEv+VUUgQpHWpllbYbuOSSKSGMHKg/USS+2Gk+fz7X8bI
        U/ERaWqu7MWOyHGgT7DwKGWmA4vtyGUeJiWMOrwCTh4+jisPnnkxbBVin85fUNea
        udm6VtqSbdnaaffHtdOQ/X2JowEj6fIe6V17/71xEMwF6xKyGL7fUOdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=EW0q3DKsqq85t36Mhl5XwyP6zYfcE0gyy04nLECgLok=; b=QQvfRN3w
        vMMnMOJfAC8ZY+rjIyJbgTJjBhTpPhCYy90nbh3dYxs8/uZ6tuSzkBIGf4/x0vP5
        h6P/BKfhvldynl22wSwYvr/jJhB0Oj1gfbn2dv85xVGT0THw00i/Yb+ZW08YEtZD
        SylhU/7swIv5Xpg1J9U+wYuAMU4ISXpTUJJLGf9nEfvU68RBOCylLg7vWlESVm6O
        /pv6gyEJguWkNqbwAqQaTD2H17LYwzISaEX8/JsZFDYvcjRF9y2MyAjK3Ohvfwmp
        ROwTD+y/D+k1wO3Ca5vLJJskVHGgGB4uJuPwU1yVayCIqmrf6wG2Z/N+vrtWHYkC
        kMaHkBXEgB4Qmg==
X-ME-Sender: <xms:ebgVYrJ4ulT1rRejF-PBu9amo-MxXNhUbsVqtw7ain1W8mUD58c-NA>
    <xme:ebgVYvJr44MKSnAMIpfiFXrgh2SAnUbxdILzJb1_a8PBvyfIOlDuTvbaFqhkAf9J7
    0QUS0ul53vLMFTvfQ>
X-ME-Received: <xmr:ebgVYju6SNG5wG97wpYPtCi_ac0X3RGv8KZHIVFAuAZJON7ognS8SMc9XbZ2L2hWHeMKdajw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:ebgVYka5j5CFpx65WA7YkbyC4MicIWPpBuOfY6VBkCLl3oxKxg5CZg>
    <xmx:ebgVYiaLcmpM7HJmJ_-H90HXOnxzCK4ajyZGKggtrmU_EpQHSNW_bw>
    <xmx:ebgVYoD_t_cAY9j91YpfqwQPi4RLTQ3GIsRpGMeyU5h7eBCnrG1gRw>
    <xmx:ebgVYnLK_DN2ZYxxBsbKhrUuS3SRjebwvZKdMzoMrfnalSiIoXwspw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 23:30:49 -0500 (EST)
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
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v6 5/5] drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
Date:   Tue, 22 Feb 2022 23:30:37 -0500
Message-Id: <20220223043037.715205-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223043037.715205-1-zi.yan@sent.com>
References: <20220223043037.715205-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

alloc_contig_range() now only needs to be aligned to pageblock_order,
drop virtio_mem size requirement that it needs to be the max of
pageblock_order and MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e7d6b679596d..e07486f01999 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2476,10 +2476,10 @@ static int virtio_mem_init_hotplug(struct virtio_me=
m *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
=20
 	/*
-	 * TODO: once alloc_contig_range() works reliably with pageblock
-	 * granularity on ZONE_NORMAL, use pageblock_nr_pages instead.
+	 * alloc_contig_range() works reliably with pageblock
+	 * granularity on ZONE_NORMAL, use pageblock_nr_pages.
 	 */
-	sb_size =3D PAGE_SIZE * MAX_ORDER_NR_PAGES;
+	sb_size =3D PAGE_SIZE * pageblock_nr_pages;
 	sb_size =3D max_t(uint64_t, vm->device_block_size, sb_size);
=20
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
--=20
2.34.1

