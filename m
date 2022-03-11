Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C452D4D6885
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350969AbiCKSiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350924AbiCKSic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:38:32 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFC123BDB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:37:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D23855C020E;
        Fri, 11 Mar 2022 13:37:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 11 Mar 2022 13:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=e95vsXP8jrOyuF
        run5UmlX0V2bedBHGJryguMu0faC4=; b=Aeu/f/mie3aIVmoHLJLu/tlQwDCvFY
        dgFIDrQ3u3efDBP8d1yJFDb6Wr1haN+okgglNFCKK+8il1qJpEGp6UGl+b+lcTw2
        ervx3bdd8lJbv4DrVFkSWJO47L/LDySOzOnHgq0eV9CBDkVSWw8bJM/RMzqu9oll
        M0oM8dGkri/a7XxCG1DWDOJI5PyVI1kciHH63VBf1Njc34RvogGhJv7mydwW7XrQ
        agENw2xGIEpPewdQaA2Ds10BJrE48guSK1sxkjhmf7ApOzz6KQzK1fK1iK3zeS8V
        dH0OlB9AOcJtxKhc3U6ltRAJ8LXIBuB7oyW2PhJJYRRbmegYptpOso/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=e95vsXP8jrOyuFrun5UmlX0V2bedBHGJryguMu0faC4=; b=eGEV6CNW
        JSiOrcEAknykSvmnNrnSa3nWPACWWOH//RfoelfIROxsGSKlnq3CBKgrPvZ3Zo5G
        +QqBMgXHULRaClhLpIQEpvDfKUkG2OEYvJ7pafepuqteoDL7TsQtRhduvk7olpAF
        DalsICTswRSjeKpHBYL/2q69VNsj1HfrI3rXW9h4sIPO2BY2GUBDS54CiLmqjFD9
        H8sKXMgoEieYhtWb8EylL1YUxz5hXQenNwHFz7L0tbr8gJvAmYVnLpobkejLQr/t
        8FLAaAwwcg12WgXEbKOGlpzuwRLg8pRM8/smlN4zAAK/t+xLw7nWtOX3oyPwmqg6
        ZtZeKgSa/MAZ7Q==
X-ME-Sender: <xms:45YrYv9TRJ2kxphcQRN8MmUrZ0Df78KFDseK2Pk-bZkFKDtHxTXESA>
    <xme:45YrYrv5mDJbiiDxT--n8cA8NSXwGzFZJ36nwDd0kb4KwWhnlVVB5e2-NPWcPePBr
    rAGBBt-GUp2GNYZMQ>
X-ME-Received: <xmr:45YrYtCuRFXuKpX5oyHCTHI_7hrRUzxdLOkIZCkhlK9h6ed5ko8M-EdrAe-jzeuhMOFEIjtF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeije
    euvdeuudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:45YrYre68M8Tp8W9XDso0-MY4iyiZTiUqlDfhIoWArnILYSN6Td1Zg>
    <xmx:45YrYkOuN-C1QTeKCbIZ5-tVr2q-hfmfzME0GhCqltffwg3mjrPIXg>
    <xmx:45YrYtkA8L4O2taBBMMnSmbdea3Nkfj2KjUd7GzvaMEaI8RRagz6nw>
    <xmx:45YrYjr3lQUOYHmSVpqsJVJfONQdPhUfj5UWkQWJSz48ScuzOsAWEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Mar 2022 13:37:23 -0500 (EST)
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
Subject: [PATCH v7 4/5] mm: cma: use pageblock_order as the single alignment
Date:   Fri, 11 Mar 2022 13:36:55 -0500
Message-Id: <20220311183656.1911811-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311183656.1911811-1-zi.yan@sent.com>
References: <20220311183656.1911811-1-zi.yan@sent.com>
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
allocation, which uses alloc_contig_range(), to use pageblock_order
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
index c2db271b874f..0f96bd57c258 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9065,8 +9065,8 @@ int __alloc_contig_migrate_range(struct compact_contr=
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

