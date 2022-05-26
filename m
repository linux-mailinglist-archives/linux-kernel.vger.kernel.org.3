Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768DC535659
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349490AbiEZXPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiEZXPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:15:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80434E52A3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:15:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 97E045C01E4;
        Thu, 26 May 2022 19:15:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 May 2022 19:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653606939; x=1653693339; bh=qCVBc37kvb
        RszsEQWErm5bs0GrXfiWiwMbQyFvk4XSk=; b=r+k3sseNp3hgKV6KYqE5AEMXyP
        ARuxlET4aUSFmVJaBFMglZ1BWjzHWif4PY9OXqflziN9J0jMuBvtBK1lqi0MPf+f
        Yzgd0SHcmcek+EHHp6uNAHsyY6oLolaIsTDjGDoTsg9sdUOZE2SyCxwvyMMYW+aH
        FvABK+TT2dkpOjiH1D0b5fydd/MnhGCrAS43XpQprNT0lGB8h7+RWywc0bImlYfa
        aDYY3iOyrzQATDG4VenDOrYRseTt83MAGHbWE4HZ2QlnX9K+lroX7Jw0hIz8WViv
        G9RWiEy7qsbhlZL1QurhJMDRvdFz6ZV9XGBkCChQoZqK8zO+PMI0ybjLQOjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653606939; x=1653693339; bh=qCVBc37kvbRszsEQWErm5bs0GrXf
        iWiwMbQyFvk4XSk=; b=vTaJwHRxEds7yaBLMX8wV+cHSOI1lqc15hAGEr/BGSyc
        9r9O7qaVU48pWGhScb7PE7jlFqRREVJUCvw0TBK7JBf5QrKB/pEtRkljfoxzLuMV
        7Ljer4tIGh6k9Pouee3a7v5Bge4dAGNzRywftI0RVJPRG/i9Q3Qeje2d99obZju+
        LBm2f0b+OYuYAsCRcj9t7N559brFl4Ugy3rnaz/FSHpmdhtP/maaUUyoJQ740ZA6
        y9svYiBJneAEOz4lhdCGtxzoW6Ko+3ZWyudoiNBgCIumf6YPd6167nbpYJD/Df5L
        gLGL/pk3VnfZwbscG86CUWyTMPDjMgRxQmV7oqpskQ==
X-ME-Sender: <xms:GgqQYp9RZXCM2aBISs4cOX5Km3IihxwZBqRxCsil_HkBVv2ougkHHQ>
    <xme:GgqQYtu2Aksl3yR8CNthBMzrp84NUOk1GG1lFW-Fmo8yMy08idW-2OIDOeq6KRjzL
    0e1FMYG4gTHf_lAqQ>
X-ME-Received: <xmr:GgqQYnD1tNMwTStJDybldiZ7DtY0-BI9wn91oSYICzqv6hFpmVrtHp3xu-eHxFT1HH637GoyoY5rM29fLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeekgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddutddmnegovehorghsthgrlhdqhfeguddvqddtvdculdduhedtmden
    ucfjughrpefhvfevufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrg
    hnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepvdeiuedt
    hedttdfhgeevkeeuveefvdeuheejledtvefgjeetkedugfdvleevkeffnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:GgqQYteMsmCtSBCJOOiD0Qj2UxQfiRYWOumO_t5OrgqOD9aAVAE1_g>
    <xmx:GgqQYuPlBhtf70HRGpi4jxDFdfrApvKPLrNv-a3OEiA06tcN17IW4g>
    <xmx:GgqQYvlvpPxO0YAxXbHFW5K28qdFIU6ZrDon-UcL2BRXS_OclqmmvQ>
    <xmx:GwqQYovCN4Z5w9zSaTzxC6VZjHWgNgA96h9vemM3QYCiC7PwSVFpJg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 May 2022 19:15:37 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] mm: page-isolation: skip isolated pageblock in start_isolate_page_range()
Date:   Thu, 26 May 2022 19:15:30 -0400
Message-Id: <20220526231531.2404977-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
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

start_isolate_page_range() first isolates the first and the last
pageblocks in the range and ensure pages across range boundaries are split
during isolation. But it missed the case when the range is <=3D a pageblock
and the first and the last pageblocks are the same one, so the second
isolate_single_pageblock() will always fail. To fix it, skip the pageblock
isolation in second isolate_single_pageblock().

Fixes: 88ee134320b8 ("mm: fix a potential infinite loop in start_isolate_pa=
ge_range()")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/linux-mm/ac65adc0-a7e4-cdfe-a0d8-757195b86293=
@samsung.com/

Reported-by: Michael Walle <michael@walle.cc>
Tested-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/linux-mm/8ca048ca8b547e0dd1c95387ee05c23d@wal=
le.cc/

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_isolation.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c643c8420809..fbd820b21292 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -300,7 +300,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_=
pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
-			gfp_t gfp_flags, bool isolate_before)
+			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
 {
 	unsigned char saved_mt;
 	unsigned long start_pfn;
@@ -327,11 +327,16 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
 				      zone->zone_start_pfn);
=20
 	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
-	ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt,=
 flags,
-			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
=20
-	if (ret)
-		return ret;
+	if (skip_isolation)
+		VM_BUG_ON(!is_migrate_isolate(saved_mt));
+	else {
+		ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt=
, flags,
+				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
+
+		if (ret)
+			return ret;
+	}
=20
 	/*
 	 * Bail out early when the to-be-isolated pageblock does not form
@@ -463,7 +468,8 @@ static int isolate_single_pageblock(unsigned long bound=
ary_pfn, int flags,
 	return 0;
 failed:
 	/* restore the original migratetype */
-	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
+	if (!skip_isolation)
+		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
 	return -EBUSY;
 }
=20
@@ -522,14 +528,18 @@ int start_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
 	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_pages);
 	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
 	int ret;
+	bool skip_isolation =3D false;
=20
 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock =
*/
-	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
+	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false, =
skip_isolation);
 	if (ret)
 		return ret;
=20
+	if (isolate_start =3D=3D isolate_end - pageblock_nr_pages)
+		skip_isolation =3D true;
+
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
-	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
+	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true, ski=
p_isolation);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
 		return ret;
--=20
2.35.1

