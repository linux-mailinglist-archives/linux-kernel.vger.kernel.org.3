Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBEB46F72D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhLIXIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:08:15 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34691 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232635AbhLIXIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:08:12 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 69DEC580257;
        Thu,  9 Dec 2021 18:04:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Dec 2021 18:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=y4otJIL1EgX6a
        ObpjvB92P7uYIVdj2sVeaHJNkCjjuY=; b=g+PDsS02y4+JveF/46j/0PLyhWMLO
        L/R1KjghmfnnQHTnqIM/5mZ0nvWeLeL/KCYbYkZkWNrcDtNnh5ZQY1PxhOOGTtlU
        Q4rGINDxGytfy/wPqRglLvPlfDPrEkByi/iTGk/mOeGdFQx3lMqQ2apddFrZCWuI
        1YXqW7nCtbkXJvDMRqrQa5/5/v/KJbRuAbqHArHLXtoYO+x53tBVazlWuT5AGdcD
        h9QhX4r4r4JncerMMdjtyc+ThqUhWZYuoQeYjOvGqk02yyhFp7KdXGrha77sHeO3
        reB1Y4ionbXhXYZJYfWIvlTPyexGRZET6UHMShnj1VERUDkZcUux8cAgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=y4otJIL1EgX6aObpjvB92P7uYIVdj2sVeaHJNkCjjuY=; b=eCoL+zNN
        UA/BxX4nhZ3kc/QdU1C/nfYJs5qMlOVZvb38K20KDs88RniGUUZBd/7JCFEfMjot
        jo9tenB5M5EbEb38FbPuSkjVvthw3sC7+NP9b3X8DA2/LP9BAbFf1gXtBRgqPKFK
        iqjzrXkS3GrpBpFoEhpQ3ZIdqbat82NQS2RHNjW1f0hcCu7QS1ChN5t2u+0nu65z
        v19mQczkSg3wZxq6ulkf7X56/bfb8mnW/3ayxANqHq1hmDdNDpLi+74B2PjGYkiI
        tU6OZmTO3tk7cjo8QGp/X4oQMSLVUFVCiQUB7jX8W+6zM1WuOGHorWZtOlu1BEc4
        vcj883fkVHOquQ==
X-ME-Sender: <xms:houyYQHjJX9StgPUOKcMNCXWVCj2jFYBwgaUReut2c_Zd0DPoJoDZg>
    <xme:houyYZWp9pe8d-gywMH_MFlb0NgBQ-044w_6AKQj_XLlCiqMCRX4m6EFweFp768bU
    c3zyc639YwCAwtAQw>
X-ME-Received: <xmr:houyYaJqHtOBQtXHsfPsnHi9ZH_dMeuKGXl3BdT77Ga8wgCRz1mG1KCUo8_pNvKifv4wC3Ra>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:houyYSFf_EUZi7a7rdBRW-8BtBrw51wIV28fTa7sEI5-ienR2b9BYA>
    <xmx:houyYWXrmxZwinR_Dj9o4ndGpNXXxuZUiKEzmRKShqz8vJ-N7MsCDg>
    <xmx:houyYVOU4s16PfCFZCtFAgKLI3E4kx7SfrgtrRf_PFyek9IoUrCKyw>
    <xmx:houyYXu8lYiplwQusfJaXp0KrLu2FZ8TBlLef0O5FsDEtDRcCKsAWA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:37 -0500 (EST)
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
Subject: [RFC PATCH v2 2/7] mm: compaction: handle non-lru compound pages properly in isolate_migratepages_block().
Date:   Thu,  9 Dec 2021 18:04:09 -0500
Message-Id: <20211209230414.2766515-3-zi.yan@sent.com>
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

In isolate_migratepages_block(), a !PageLRU tail page can be encountered
when the page is larger than a pageblock. Use compound head page for the
checks inside and skip the entire compound page when isolation succeeds.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b4e94cda3019..ad9053fbbe06 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -979,19 +979,23 @@ isolate_migratepages_block(struct compact_control *cc=
, unsigned long low_pfn,
 		 * Skip any other type of page
 		 */
 		if (!PageLRU(page)) {
+			struct page *head =3D compound_head(page);
 			/*
 			 * __PageMovable can return false positive so we need
 			 * to verify it under page_lock.
 			 */
-			if (unlikely(__PageMovable(page)) &&
-					!PageIsolated(page)) {
+			if (unlikely(__PageMovable(head)) &&
+					!PageIsolated(head)) {
 				if (locked) {
 					unlock_page_lruvec_irqrestore(locked, flags);
 					locked =3D NULL;
 				}
=20
-				if (!isolate_movable_page(page, isolate_mode))
+				if (!isolate_movable_page(head, isolate_mode)) {
+					low_pfn +=3D (1 << compound_order(head)) - 1 - (page - head);
+					page =3D head;
 					goto isolate_success;
+				}
 			}
=20
 			goto isolate_fail;
--=20
2.33.0

