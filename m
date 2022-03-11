Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8744D6880
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350963AbiCKSir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350925AbiCKSic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:38:32 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09131E8B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:37:28 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5AC9F5C0270;
        Fri, 11 Mar 2022 13:37:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Mar 2022 13:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=j1NPISH+l624H2
        cG6MYTSkySP6eLhrxXfSj11vAvYwo=; b=V3vSXoaFybxo84Ee4yrWh3V5zGpdmL
        AeVQsqJqkloux83Pa9wzI3sqii1Pam2/d1kKcKn75EQBtPPyCbdxV6QtH3WJn2pg
        1VhBRwT3FylAn50qk5xAJeag6+Iwb+BvPta7dLhlHucnWkh0XknZNqFGiVhRGkZi
        fVm8OlqdwHCjVivNTo0vX5arzzeCHjQx31eQDFfm4puq94nz8WMTZpUUm9QcRK0V
        3iXzIn3Zw/8IGjYI2o9JxugM/lTsyx7Ecyh/oQsu+tQTt/D03gMRTEywvkIWXbsy
        cYA43HydClVmi0hwFjAS0Mtb8yQum9pruTcNvP7SXJK6r2vkFJCMk1ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=j1NPISH+l624H2cG6MYTSkySP6eLhrxXfSj11vAvYwo=; b=e9mb3dlK
        uxl6FtHxHyD8ArjJvdc3+DWkr20woot6m2OkSgtUeg9N/vGCDGTtzAffFljcdxyr
        +UFHhE5fxD5h3uq4lbBQ8r2Q0tJ6NcgBrYZddPWv2GJPbR/P/JT1aRSfAD0mAOJL
        +OxNwPmKdCBGR8thF2HVT7U33uvdrUW+qGzHhqyYkVmdDo+BnWtFiDtE5fsAH+92
        zWk8Iwe1Xqwcrnf2njM7Z7D1j9F86oYGP7D/CVbC+xg4ju9Bg8+GJGAaxpUQLmXQ
        uwTN9f/Y2ydIycoCUF19M3XfKuvHh8cZfcVM4XYEgr0dXqnbQMCVyN3AAGaFGNRY
        RG3rNOf4I7LC6w==
X-ME-Sender: <xms:5JYrYr0JvtFT8X6pr5BXbZLYKsmIJZgkNeZ9nhexpnwtaed332Y-dg>
    <xme:5JYrYqEP3DJpBwoGmReyEcoctnb9kVYE7J3wV9fCnk7jYKFo_pnN5HIzQbOZ6OJ76
    MWIkV2S82q4WOropw>
X-ME-Received: <xmr:5JYrYr6liVvPy_774szB04b55v_6dnkmMKu14RyRjUrZ4Rt71g82d-nhC4uN-cdw-5-sh0mN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeije
    euvdeuudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:5JYrYg2yj3hxwNOb6oEuummSx4XhFt4IDtICiyHdF6AySuBXmsDIOg>
    <xmx:5JYrYuFBZhXdSXovR6ylx7q7-m9cZggRV22DE58IDVql1iu2i-psmQ>
    <xmx:5JYrYh_PDFawYqypGs1T8QIIQNr7sbfyJ4XiCUYTYCcIuo3YHOWobA>
    <xmx:5JYrYhBw2WZUzgR7SJzmZt13wAj_4OMNcEfVCWUT9_csn_QvhZVVfw>
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
Subject: [PATCH v7 5/5] drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
Date:   Fri, 11 Mar 2022 13:36:56 -0500
Message-Id: <20220311183656.1911811-6-zi.yan@sent.com>
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

alloc_contig_range() now only needs to be aligned to pageblock_order,
drop virtio_mem size requirement that it needs to be the max of
pageblock_order and MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e7d6b679596d..e07486f01999 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2476,10 +2476,10 @@ static int virtio_mem_init_hotplug(struct virtio_me=
m *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
=20
 	/*
-	 * TODO: once alloc_contig_range() works reliably with pageblock
-	 * granularity on ZONE_NORMAL, use pageblock_nr_pages instead.
+	 * alloc_contig_range() works reliably with pageblock
+	 * granularity on ZONE_NORMAL, use pageblock_nr_pages.
 	 */
-	sb_size =3D PAGE_SIZE * MAX_ORDER_NR_PAGES;
+	sb_size =3D PAGE_SIZE * pageblock_nr_pages;
 	sb_size =3D max_t(uint64_t, vm->device_block_size, sb_size);
=20
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
--=20
2.35.1

