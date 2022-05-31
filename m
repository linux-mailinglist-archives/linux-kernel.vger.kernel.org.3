Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052365389FD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbiEaCpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiEaCpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:45:01 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1394185
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:45:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CDBEB3200954;
        Mon, 30 May 2022 22:44:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 30 May 2022 22:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653965096; x=1654051496; bh=xLBULzBh5o
        Hqd8PDcEQQTLRKpqJ5mFh2Oa5dm6Do8/E=; b=FG2WFsU9TrYfVAoOnfaPdPB1XY
        sDzGhRYv0B6tCLQzphZMWNs6qhdRHL6zPercheXJl8G++J3MNBpNzJCM6CkkigoL
        DGF/dsHb1do2S/dJQgieKEsZ7ULOSsmeDuewOzbKDEvXx6uYTxdp1Zd/CSgBmMPN
        YkpSBzkRli9lFkzTUoDKXSHVwUwYrxYkaCowryVMzX5vahYAYtV72CFH7YLc5l+z
        rQ5D576bkIFFxku3W9AyvBfXRCd/bid7cV0vVjIYmgAevx7vHIy3XTte4E9mw2Zd
        qAG37luJNc+/91y/+csrahP5HEASi+C6G7kgme7dkvaRwOjlfYQr1dYF3tYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653965096; x=1654051496; bh=xLBULzBh5oHqd8PDcEQQTLRKpqJ5
        mFh2Oa5dm6Do8/E=; b=w+0bnPYtu5raQinXgwH+c1kagKzA5zbjw06Q8iSH4SKS
        DEwQ3kOCCff0tw+kan0iVUieAtqCUgniC4OVM/BSxuVS+47sruGK0FO73lS1gCZH
        1ShT68bhoXHYFbdGjf0tGYIKaryF8II00ZK0VfgdtVYKtvQylJNF8fB2L1fkCKso
        uGd4cvQf7zgetBqzNy4l/+QOICp4RPlH1vjotwc5WiCmHFu8ioJzH5R9KRQLxMta
        65sjaI3m+dm2BA/h1oApXuMqxnfy+eQatEbyVJjIn24M2eJJXDmC0xmRTXT2LP3p
        PLdBKm1A7KLiTyyd+GB8xBtF1Umgs2cMgMskuh6vIg==
X-ME-Sender: <xms:J4GVYuxqmioWa5wQuFlcJDtaH3HRS1P9uqkvTJyfftE-vKiLucXF-A>
    <xme:J4GVYqSqVWHFiRZIbGguSk0KtQbnqX3Pj-tVOGTvLdsOBig83NM9VEqJlzjYZQ3bQ
    XJmy_XXndOjPup3_A>
X-ME-Received: <xmr:J4GVYgVYWeeT7cSn62WIbkasOo_KojCGsFZtOJ1sbAy89SrElcbNeYlPvKMS3nhJd8jGOkKdAKmnREx6Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepvdeiuedthe
    dttdfhgeevkeeuveefvdeuheejledtvefgjeetkedugfdvleevkeffnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:J4GVYkhknoUfr34SFb0QGk6YgAAMVxHqA9S9tKQiT9SDSDPSeS0LaA>
    <xmx:J4GVYgAnLVEHpbFC_c-sTik60egAuYmr2rO_JaR4iXHFsosbZzG0Kw>
    <xmx:J4GVYlI3Kpbsw3P8zwapl46WaPrsPatZj6_opOaNf5VK1OW37SWZYw>
    <xmx:KIGVYpLC5ITysBTH1i_yug0AsFSZZ6oc4oSz4Ea0B_yU_Jv4wGZa8g>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 May 2022 22:44:55 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] mm: page_isolation: use compound_nr() correctly in isolate_single_pageblock()
Date:   Mon, 30 May 2022 22:44:50 -0400
Message-Id: <20220531024450.2498431-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

When compound_nr(page) was used, page was not guaranteed to be the head
of the compound page and it could cause an infinite loop. Fix it by calling
it on the head page.

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granula=
rity")
Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/linux-mm/20220530115027.123341-1-anshuman.kha=
ndual@arm.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6021f8444b5a..d200d41ad0d3 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -385,9 +385,9 @@ static int isolate_single_pageblock(unsigned long bound=
ary_pfn, int flags,
 		 * above do the rest. If migration is not possible, just fail.
 		 */
 		if (PageCompound(page)) {
-			unsigned long nr_pages =3D compound_nr(page);
 			struct page *head =3D compound_head(page);
 			unsigned long head_pfn =3D page_to_pfn(head);
+			unsigned long nr_pages =3D compound_nr(head);
=20
 			if (head_pfn + nr_pages <=3D boundary_pfn) {
 				pfn =3D head_pfn + nr_pages;
--=20
2.35.1

