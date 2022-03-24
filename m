Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A944E6AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355519AbiCXWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355485AbiCXWqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:46:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6CB6E50
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:44:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 135A25C00FE;
        Thu, 24 Mar 2022 18:44:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 24 Mar 2022 18:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=f9PRefpx2MpIl5
        yijJ96u+SD2q2v2niHZWJF91cTEZE=; b=zlsIHf+ko7hXDjnl4e0JXlI13d3DiH
        VTnMBV5NQIJQW7+4MfNgpIiVk0VzWfo/RZDl53JeBLZWhaorG5c/9MeeXWDmLFaH
        v2fhjNyt68cq3rYjPKUgvHu+qGc7ZbxTZJIlIl65AGJYelVrhjQHetFoWP6pdsta
        4zOXD7gYGE58b0f1yNmlQ/kwmT5qwpdWjQ6ViS2rrwj7D8S0N2Zj8cnwU9PJabkt
        n/q5GfeOMQb7dcg/fNEh5X4uzz3qxfHVATMAjqSBR7z3CMrccUANfY4iGL3TvwiE
        OFxIveNCGebQHpOytwcIN1JpHhziZ6ZMWdJGtSUEFn73uJAoE4aC0cjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=f9PRefpx2MpIl5yijJ96u+SD2q2v2niHZWJF91cTEZE=; b=iediQyBs
        CiVWpucnx9uunrZzCBibY6sZNe3byiyQ7tcjFXwIMn9XZR1vQt3lF9Os3HAB1Vt0
        n2F445nXGuWzIm02pBmmBvNqKKeXJv/rDl+2U0fgNKnBpfj9unTB8YBGjdUc0Umv
        +7i5qsMozjTvs0wnPozBmmEsm9NrkQN8dYmLhVbFW0gpTyqvQEzeETZc22AKwJM6
        VuvEK7UQPUClu3mqrut0rjmwIryArKnhK6pF53pyHIXgIjtn6YisHxmLAKB9ejt1
        vUVLmZCiTNkzaZVuKl6t6ikmahDjx7L6e9wjHRqddASv6a28Dcx+jeCtoAer/XE7
        iYtGru+sxPomXQ==
X-ME-Sender: <xms:WfQ8Yu6BTDSeQ5BmNTa50CtbNXIMPjGtDoFKchrgrhfpew7WLoWjHw>
    <xme:WfQ8Yn5CrXSLMH0uvBc0KWxKLkOmmcKbT6byTti_C1ipjJWkjd6LSFsWkdR3wCtX0
    TKhYxa399o0lYj3ZQ>
X-ME-Received: <xmr:WfQ8YtfbCt9Nt0hZr8pFjAVaK_s3M8EUwlg-02rqrsPjIq3Pml2CYV1jxIghtjx_3ZGdxCDnXxBiV_kXrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeije
    euvdeuudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:WvQ8YrIwOhrrAX8khAs0KiBzCrqYVkuJwUvAWt5uk661Pm45oSZBCw>
    <xmx:WvQ8YiJs4u45PGhBeSUFnHe2tIWx8BWrIFGjrNetNF807uckyeNaEQ>
    <xmx:WvQ8Yswyzc9LH7H0-M60dj8XK2Q9cPgKADNCzHZbwbJHaqUsknckFg>
    <xmx:WvQ8YvXh5AoP9DMKL9gXUH3dJMxLjk5oZ5OHRz6lScurWDav3-sCjQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 18:44:41 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v9 4/5] mm: cma: use pageblock_order as the single alignment
Date:   Thu, 24 Mar 2022 18:44:34 -0400
Message-Id: <20220324224435.17794-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324224435.17794-1-zi.yan@sent.com>
References: <20220324224435.17794-1-zi.yan@sent.com>
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
allocation, which uses alloc_contig_range(), to use pageblock_nr_pages
alignment.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/cma.h    | 4 ++--
 include/linux/mmzone.h | 5 +----
 mm/page_alloc.c        | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index a6f637342740..63873b93deaa 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -17,11 +17,11 @@
 #define CMA_MAX_NAME 64
=20
 /*
- * TODO: once the buddy -- especially pageblock merging and alloc_contig_r=
ange()
+ *  the buddy -- especially pageblock merging and alloc_contig_range()
  * -- can deal with only some pageblocks of a higher-order page being
  *  MIGRATE_CMA, we can use pageblock_nr_pages.
  */
-#define CMA_MIN_ALIGNMENT_PAGES MAX_ORDER_NR_PAGES
+#define CMA_MIN_ALIGNMENT_PAGES pageblock_nr_pages
 #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
=20
 struct cma;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 962b14d403e8..0725c50ca0cb 100644
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 57ebc9e41414..e5b545d60456 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9064,8 +9064,8 @@ int __alloc_contig_migrate_range(struct compact_contr=
ol *cc,
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
2.35.1

