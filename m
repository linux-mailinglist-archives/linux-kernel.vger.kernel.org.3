Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06D04F1BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381012AbiDDVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379296AbiDDQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:55:37 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6748B2D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:53:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0987E3201D2F;
        Mon,  4 Apr 2022 12:53:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Apr 2022 12:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=iE5HYjsyDrhb8gHe12sa/zLc2S6ikdXgUfBcf8
        +yKi0=; b=SyzsSDStAvh1o2yCDwOVwCws8cpu+I55eGXZfR7qnsRSPBR4M6Hl1F
        9ZH2pHc7PsT1hs3PQhQvHtD0JQwSR0eNXKQShLQMZAPqmDLQtxYLmvpR//z0E++N
        99/p5M/9QWsqFMzyxO2TLGozFUWKsSAFcNspT9Sp0GXc6bS8mKGcYy7/u59L1oAu
        7Gi73zaUZNGHl2Z6gY2XtdYAKqDYs2z8CbPH1vCWZOMB979dJ2taMaTl2gFAIZp1
        jt2wVTqqM0lQ1bG3hGQtgGtg1aF0+Fruhw9NbPkQDrUJ5CTfEMBwGbzS3NadQJCo
        AU7EL1ViDgV6HazeuLFvMYIMI4cvKang==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=iE5HYjsyDrhb8gHe12sa/zLc2S6ik
        dXgUfBcf8+yKi0=; b=oBW5VwmG+K3jmQoLcOiV8hb76nF90lzElkDaeTLAClAhD
        ObVW9yy6g5U4zsvNcAbMOl8qZdTVJDctAcf4x7Xc1DkwhfP9qzJc5QO/JqtqCXJn
        OgzQMRXAZA13EloVpNIlhlSPUoE8H0Dd/E+oLWlBHlmzHn+E+Wl4jDdIpForQr9a
        e1HcO6g8gKtymM3ow+E7jxFGxWKqwf9q6oj3yrJJLxPgUtxI4hpGjduZLdFsocQo
        lC9kXVl4OyXsPhLiF7yY90xO2RblQkHPLprgcDX9xlFy/nPGNHUd4WUpOzFHSNKe
        Co5oeX4gDN1l7o1/Tgd6lAmhN6sUmd39efQw69AiA==
X-ME-Sender: <xms:kSJLYr5M5CJQ2wGCe2yIY_fWVz9Lwr3dC3k9Tq4wuDZ2BHIvytVBCA>
    <xme:kSJLYg59RcOi4dQyy27_Sij_t-AcCTY1IKtRXbOPUNtWz3Ac6SsNyc8qulNE_yfyl
    Gqu9fiB5KtOg4lI4Q>
X-ME-Received: <xmr:kSJLYicrOffp66tlXy2VqmD44_zKPeUlxbxsJifMWVmFDGVRggEXbfmIbxPUcjcyQmluH_W1kr_udbFd9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitd
    ejgffhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:kiJLYsLV8372xBzv5w-Qn9Shoc09Y6QaOPUQO67L5JxTGakh7Xg1ww>
    <xmx:kiJLYvIT-qa-g7iLP7U0POxQzAws2Uhqt7V7It15NsfBsZNWVIv3kw>
    <xmx:kiJLYlyGZIZ4psGDLLhUkifd1opIOrIUX3sAgJkS25_ARLaH8gGHFQ>
    <xmx:kiJLYn9dFlacP69nO-L6QFbdOCoze0BmZ-yxjpM9HSoga7DBMdiLTg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Apr 2022 12:53:37 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: [PATCH] mm: migrate: use thp_order instead of HPAGE_PMD_ORDER for new page allocation.
Date:   Mon,  4 Apr 2022 12:53:25 -0400
Message-Id: <20220404165325.1883267-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

With folios support, it is possible to have other than HPAGE_PMD_ORDER
THPs, in the form of folios, in the system. Use thp_order() to correctly
determine the source page order during migration.

Fixes: d68eccad3706 ("mm/filemap: Allow large folios to be added to the pag=
e cache")
Reported-by: Naoya Horiguchi <naoya.horiguchi@linux.dev>
Link: https://lore.kernel.org/linux-mm/20220404132908.GA785673@u2004/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/mempolicy.c | 2 +-
 mm/migrate.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6b34c5d5e65a..88a74bc4cba5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1209,7 +1209,7 @@ static struct page *new_page(struct page *page, unsig=
ned long start)
 		struct page *thp;
=20
 		thp =3D alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
-					 HPAGE_PMD_ORDER);
+					 thp_order(page));
 		if (!thp)
 			return NULL;
 		prep_transhuge_page(thp);
diff --git a/mm/migrate.c b/mm/migrate.c
index 4639dfc2b7ee..b58b96fdb174 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1553,7 +1553,7 @@ struct page *alloc_migration_target(struct page *page=
, unsigned long private)
 		 */
 		gfp_mask &=3D ~__GFP_RECLAIM;
 		gfp_mask |=3D GFP_TRANSHUGE;
-		order =3D HPAGE_PMD_ORDER;
+		order =3D thp_order(page);
 	}
 	zidx =3D zone_idx(page_zone(page));
 	if (is_highmem_idx(zidx) || zidx =3D=3D ZONE_MOVABLE)
--=20
2.35.1

