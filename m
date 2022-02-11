Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF94B2AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbiBKQv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:51:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351764AbiBKQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:51:05 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C6D75
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:51:02 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id AB9DA58037C;
        Fri, 11 Feb 2022 11:41:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 11 Feb 2022 11:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=ns7zKpm4A9Xmsm
        ZwroT9dHnb6rgarNlTVL3pcGHHu0o=; b=HhkSZgj0d6uRtnT7s5z1WUa0qj27bC
        RPCjKEp+cbL/NNOORX1x08Je1Mb+zbU9hACFgx4vaehD0ZTg5j8N5A60hXkTStCy
        Rv3h+mkhOAeW+uSlBJXL2tBu25fgGR1H036XJbizSq7S+1Jo/kOmWIFe9ke16Omh
        vAU+Ys9UTqbD4kgtyX6RyUKSfEFijWPBxjbxZoDeOHAfCLwr8bNOqW7VSiUScaiP
        UXWhGfveqUGCmzHskSNDQhIqL71z/XsmBtobnRUISr9WbV1hvE7vqWkBckPtwQVR
        uoPFf1TYIIpWKFZQRzNfPhkJGXzXJ9VNr0/BjJVnIcPYaME1mwO8QF4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ns7zKpm4A9XmsmZwroT9dHnb6rgarNlTVL3pcGHHu0o=; b=b+HoxZQU
        sEXEVT7xD5fjST3/BM4MLUWPtVa/KKDHkcI8gFADHiFTXKmt7DZXdHdx6ZwYbwoq
        BklXre/vDPSfD0+Qw8Lx0GErCtY2BCkp24uBzza6Gus/TtT4yAVtGCX1SzS/UC2T
        qcKZnMV7l1b0G64riBoSSPoS8aUFV0q+o5zYaC5ZMVpHrU/2P7YqZ4uSGCiaAimf
        4+HJJ/OMddls4LrrNOvGOG90TS3HS1/VoAKDA39nyPDD0EdqJBFZkALEJ3wmGxyC
        6J4gppe20SdY1bb8QZGNwb/Tmk996l331/q91v4f7LAecyWfYMBpua2+7rkiIDCu
        633kilwZzAHD/g==
X-ME-Sender: <xms:zpEGYt8YBMIg8CcaUo7OhFh16T-q410PSZmYmPZAgExWxInlYMMB7g>
    <xme:zpEGYhsNoeGu3IfROXDOMCJCEILTPI5V9eTNzWyjubD6QCdzZbWrTfQxakq2vGPdh
    AhBktCT1ZbLbaz1ug>
X-ME-Received: <xmr:zpEGYrAunTmnZ4Lihw66gtLKSavy8pghJlRaXMkVOx0KAfFo_KSGaByNO17aWuyx_Xc0rHs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:zpEGYhdtAq80HV6uL94doGOQhiGCJT2kRZQklRM_ncx5859q-xVh0A>
    <xmx:zpEGYiPhgnG7MOILjVrDdUXC1xtgAwIf_oRHvBXUCCQVvnx9y3RXqg>
    <xmx:zpEGYjnqKVITtFlfbkrccG5Yo0EBjtUr5VJw2ePxbh93T4FsYNUNCQ>
    <xmx:zpEGYpn3rhItMIS_FdKpzmOeT8IkC1ap9lgL03qU1_2AM5KWNIB4IA>
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
Subject: [PATCH v5 5/6] drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
Date:   Fri, 11 Feb 2022 11:41:34 -0500
Message-Id: <20220211164135.1803616-6-zi.yan@sent.com>
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

alloc_contig_range() now only needs to be aligned to pageblock_order,
drop virtio_mem size requirement that it needs to be the max of
pageblock_order and MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 38becd8d578c..2307e65d18c2 100644
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

