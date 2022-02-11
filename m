Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBB4B2AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351816AbiBKQvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:51:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351726AbiBKQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:51:05 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62444D74
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:51:02 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7367F58037F;
        Fri, 11 Feb 2022 11:41:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 11 Feb 2022 11:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=8yuexR1+nrtHGS
        O8wGNcV0MvB+tGU4p0S4nQ2u6/h9Y=; b=D3VqJlhlbyWtV6r6GqE/sdQHhhzfao
        jEbpnb9Wr0ZReRqYHRz6KCXTCd0yivunmYqzFRoQLkQegNx2uHlUfqnjdWV/uzSJ
        zU8M0dPa33aRq+dlCTIv1HKtBD/Kh7pykEWL/ODQJPonFg0wqPv8sIrL0qYanslJ
        /JLrIUPIaJr4Z6KM4Og/F2X8lkSYDPbN7ITWDitlcOlpiq78n71xOGLIXJXz0Odg
        DRLO19YIQToJHSo/aJlV9Z59lWZxCAiI+H1agFbgcJWflqv/7sa6Z/DEHrtZkp3d
        sm83CKxYJVqNKbxcCcoENzJCEn26apNqoREHw+PQFH0GDXE8WDR4bjCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=8yuexR1+nrtHGSO8wGNcV0MvB+tGU4p0S4nQ2u6/h9Y=; b=YQN1sACl
        87xj+F47lfbNUuu2eOmgbTwH2DjTS/HIzp4OOKxqbF9Ccp5g2TMpkwWX2gBWSZNt
        EIPNTSk5Nl922Lg6gwveaU2GuyEA3/UfkKtvPP7p+AGcRnn4sIlGCdRzlTfHo2x1
        OxQNvyL/puQhqVLBtDsJccw8y7Iaq1sUjOQ2m/rnf7M6NoneAkAyKwJj4wZzSkaB
        WxyqKOeTGmYirNdGfaMPZnppY7uXdXPT4AHgxf5NVJMRxE3UDqkMzGCzf8L0gtEi
        VzZ9ycKNj3Y88HlVS7sXcuD+X/zVMZSnrQ0sI1ttCUNu1pmn/5U64GI9YlSxP+j6
        Ee5VZdGDqCSGFw==
X-ME-Sender: <xms:z5EGYoD0HNOZcFFbJ4BM6mXHloZ_7ZKKhfRmcpgqUKvf_v9Nj3klng>
    <xme:z5EGYqg29ZRCUlsrXWU4LEuzwwgbc33fWkpaJRahLkzsJe-fXsry7pQWrWrRrho17
    Ml7Nmn8zyL2dMmaxw>
X-ME-Received: <xmr:z5EGYrmNw8VWdjs_Tz1ZRVcOLW6HyNjege8PTS3V998EKzdu4gQzO5LRhGwaiyvxWsdezm1N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
    euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:z5EGYuz5Bj9-JaqGriH-MKRe3zFXlOgPQ60DeTL5Jzmwi573abPhjQ>
    <xmx:z5EGYtQ1VmRFqGNTnFcrQNIS2JDX1K0F3ipTVIQHg82r79TtOBAQjQ>
    <xmx:z5EGYpb_ZyVuWCbl_iOa2f738FO1CUfDztTRyhGyeaILcTWnSeqCNQ>
    <xmx:z5EGYpp4NsHG7dNpBbY_x8GNgLUNpaRSeSapkd1LGcqN-l8MqDZo0Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:50 -0500 (EST)
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
Subject: [PATCH v5 6/6] arch: powerpc: adjust fadump alignment to be pageblock aligned.
Date:   Fri, 11 Feb 2022 11:41:35 -0500
Message-Id: <20220211164135.1803616-7-zi.yan@sent.com>
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

CMA only requires pageblock alignment now. Change CMA alignment in
fadump too.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/powerpc/include/asm/fadump-internal.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump-internal.h b/arch/powerpc/incl=
ude/asm/fadump-internal.h
index 52189928ec08..fbfca85b4200 100644
--- a/arch/powerpc/include/asm/fadump-internal.h
+++ b/arch/powerpc/include/asm/fadump-internal.h
@@ -20,9 +20,7 @@
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
=20
 /* Alignment per CMA requirement. */
-#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
-				 max_t(unsigned long, MAX_ORDER - 1,	\
-				 pageblock_order))
+#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE << pageblock_order)
=20
 /* FAD commands */
 #define FADUMP_REGISTER			1
--=20
2.34.1

