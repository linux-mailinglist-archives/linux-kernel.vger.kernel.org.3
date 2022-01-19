Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5449405F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiASTH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:07:27 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42369 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356998AbiASTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:06:40 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4B986580730;
        Wed, 19 Jan 2022 14:06:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 19 Jan 2022 14:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=VbnqumJAL4r7o
        PXU1B7/2AqlEeyilMgkB8Z6AdGXQWo=; b=iI0XifscyxRyNU2nNcg0p2IMkEy3e
        1EuyVZfwKTLv+XEo9nCFdk0H5mkwD7i7Aq+gayhI/BlCO24BAgXF5jaHx3S3FQRE
        rxdrdZsc12FBtiE2Dpar0r6YxrhJU+WU6hTXLnsZjClhQ8cTTWFKKq7ea+N9rq6T
        Xh7uK0moTsH4LK4/jK0QbDVdODFQa1o+99M/gn46XI67hUpfY65bcPCyJHv6PHF/
        bGcAwer4Ms9MbJmV2ET/Tw3v54jfWJgP92rHXTF0kbhZEMuiK8LZWVccwfOF9NRx
        Y8wYL2JPLD1mXMtkWQCf9fE74qq7bnrnrOC3VPh40ulPoeJZs3qjZc/dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VbnqumJAL4r7oPXU1B7/2AqlEeyilMgkB8Z6AdGXQWo=; b=ln/IExRu
        IX3Ngu9Srz6FhkcAULotpPuKNYZGxiHzOvW3borqnE/QzdlHZ9Z7R/ZXOULt5zd7
        XgZdpUUIVFX2rj1W7OkdqrhQa5/SfoU/EZFTMye5P5+TmSbriwaBHVWc7xXT8Bd7
        9rbQ4Q0A+UecyD0TADRV1zaCKmgjNeWOE0EuXw9widzTi6YryjkGqp11INm1zwzk
        CvdrBNAUGz0bxozLyW5o9FMi//QVU3lBQAUCFoUQvB4xWcxrHjUzHmn1hmFreVpN
        V7dPt938YbZA1XI5W/flHNeegA98GnbKMOpTdQw5i4iUI92GTwy0mrqC6jT77Gv/
        KSZUvGlhcve8Wg==
X-ME-Sender: <xms:QGHoYbtp_B1wdpMo5t2l9oE7stqZFzq20lCeQ4uCxBMgaZV1F2c9MA>
    <xme:QGHoYcci0XXibWIkEosG1VlR9Rvx_MHnWSEf1IBPA2w39EMp3Ho4N5nk0VBIMoW6u
    1-fMcFG49YaHimOSg>
X-ME-Received: <xmr:QGHoYezwHqjwC8A7_YI1pFVJYTWHfhXWYwjdXWq7D1l2WsX7CQUGIUK_Mt8WTAHKp8M2cak1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:QGHoYaMIFGiyyNjgwRGKm380P0rbj2Frq10NmQVKCCjaPPhbW2Flpw>
    <xmx:QGHoYb_j0dzi9YXmkoNqMy_hu9Ge4gKGK02fSjLO7eZTdA8DYz4a_Q>
    <xmx:QGHoYaUu9q5u7A5e7HgnMDS97TVHUVwdqePaaQYgyTAa3wtxSiJAUg>
    <xmx:QGHoYeUrjpbHQ0fZM8NhK9zLdS_e2FUfjnVkcUw25okDdKH3fWbFAg>
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
Subject: [PATCH v4 6/7] drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
Date:   Wed, 19 Jan 2022 14:06:22 -0500
Message-Id: <20220119190623.1029355-7-zi.yan@sent.com>
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

alloc_contig_range() now only needs to be aligned to pageblock_order,
drop virtio_mem size requirement that it needs to be the max of
pageblock_order and MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a6a78685cfbe..eafba2119ae3 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2476,13 +2476,12 @@ static int virtio_mem_init_hotplug(struct virtio_me=
m *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
=20
 	/*
-	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
-	 * pageblock_nr_pages pages. This:
+	 * We want subblocks to span at least pageblock_nr_pages pages.
+	 * This:
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	sb_size =3D max_t(uint64_t, MAX_ORDER_NR_PAGES,
-			pageblock_nr_pages) * PAGE_SIZE;
+	sb_size =3D pageblock_nr_pages * PAGE_SIZE;
 	sb_size =3D max_t(uint64_t, vm->device_block_size, sb_size);
=20
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
--=20
2.34.1

