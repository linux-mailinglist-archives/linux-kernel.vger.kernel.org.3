Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9A50E334
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbiDYOex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiDYOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:34:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34556466
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:31:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DE5505C015E;
        Mon, 25 Apr 2022 10:31:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Apr 2022 10:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1650897091; x=1650983491; bh=JX3ps6oeKyuY4MRNJ2GnR5dfK9tpHY2lYtV
        KJFK+Xqk=; b=TDLUN33aq/3MMOOBQQuus8Fk/UJeHWVmjSrGGfM1mfa8bAK7vJ5
        wBgjeOJBfDbCb1I+PWErV8urwm1X8HsvklEN2dNwEBFu94cLiujXIAvbXoffx4gk
        l2kjZo7ki3kbSZyrX5cNTWKwN64199owIRtTiDNJgbbg8OHol/1LlxZuobIz0GVg
        InGz1TautCYF+GhvEtdFDS4AkX0OenV93TdDt+1GDmoLvymu8FlJ6s+1hBmj+Mkk
        SZar04DgOqU5FQqIekQsE4D+SpcP3Mg2/7TC2gu6nKcBytgL90mZ/VmMEprwPZ7U
        shukvJcGtjcIIeMfMU5hz29FVM+3qGS/iew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650897091; x=1650983491; bh=J
        X3ps6oeKyuY4MRNJ2GnR5dfK9tpHY2lYtVKJFK+Xqk=; b=kPGxsDlj958gfs7of
        XLw5DbJmBrF786oXF8yS51MeyrHP/OkunAM2eAuyNQdZi0QGdoccKuDxO1XUYst8
        yiFIaBmFTDJ7CWWYlvSwpqV9LLqzLRcXPmnXmFk5ZaBjX1kiCHnT/nE6xylRvB+j
        lT+TQJnJ3Y9RGorphVoO7+m056go8ZZopyTT2x7vMqUeNb5Z0C2yyRiep1NW0t1v
        VqqTDedauWXYj1AsuuOJNYVa2NZDx/MF2dpkqgz0/cdLt52NSLD2OPWd0sjE4xMX
        I0KJdFXQD/ThxZwdIYcZPbxwittjpaGNQi/XUJtLaQ68tM/UAUUvv/sZi1WwMNE5
        a++TA==
X-ME-Sender: <xms:w7BmYnDwKm_PDQPNCTl4IgLxodQMFDD6EkYllo0jKUez5u2GZvV94Q>
    <xme:w7BmYtgbg_ikPkhuUurLepUdb2CFD2kVPSDH1JBl4WQKiB55FoJ0iOs1qlQ7lX8K9
    h-NdX_u4stz4VlArA>
X-ME-Received: <xmr:w7BmYilDV43EsEF_ojfwueBKdvLgAndEedj9hmD_KmyYkSOf2C-sadR2U66Pniiy8K8mkg2XLhBjXOj6ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddugdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeevhe
    evleehgfduhffhudefteehhfegjeeiudevheevffetuedttdfhkeeuleehudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:w7BmYpzaLVFygjvF6d7RY9wCHz3c2oCesNKkulzXj3GSW7FM41rXuw>
    <xmx:w7BmYsQAAs9TcnabBLlSX6rFQipCsYBOpVMpHcZ_Mu8DZbyGxA_E5A>
    <xmx:w7BmYsYHIR62xfbVxunxbePn9XWhB__bJ6G6G5tAnr9bTRI11B-OsQ>
    <xmx:w7BmYhJMuvyTvUihiv9KztRthquQg_LYkQ4d7F4w8YYTfaQw5u7s-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Apr 2022 10:31:31 -0400 (EDT)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v11 5/6] mm: cma: use pageblock_order as the single alignment
Date:   Mon, 25 Apr 2022 10:31:17 -0400
Message-Id: <20220425143118.2850746-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425143118.2850746-1-zi.yan@sent.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 46ffab808f03..aab70355d64f 100644
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
index a002cf12eb6c..bc9e129ab3d1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9014,8 +9014,8 @@ int __alloc_contig_migrate_range(struct compact_contr=
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

