Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F325F4DCA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiCQPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiCQPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:39:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F920C194
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:37:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 624F55C052D;
        Thu, 17 Mar 2022 11:37:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 17 Mar 2022 11:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=j1NPISH+l624H2
        cG6MYTSkySP6eLhrxXfSj11vAvYwo=; b=OEg4pekKGsqANjnlRxk6Ne+AKRv5J0
        gC7chvs4deAZLS0IGG5xg4Of1D65Fzamd9mUuCvUoLnYn4xlIxU9oAdXjwtjx0Ks
        KC91J9kj4ZNhKl0fIA/YPwzLZsMzBWpDvUcjb7oTEGAof2YmbxeT3FVdSJK7sxal
        Tpr1F0M/iwE4LeOgUl+wnkdzp/tco7LVCuNDOjZbWIMyVr8SFB/kC5FOIvnZx/uv
        ciEb56hSR6EOpwJNPBnhlDFXfxF181IKRYFviVJHiX99j1Lb5awrIHtlkhq5XwOL
        ckwWPvXlltzxHnBRF6thhp/0WWwIOgJ2FcGglXqhzkxL4Ynn3mtsD6CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=j1NPISH+l624H2cG6MYTSkySP6eLhrxXfSj11vAvYwo=; b=fsPD+QP4
        oVKblv83NDRSSHsq8ic1HamtNf556nGnG96rIRcy6U/kkmmrE+vgioPHL+eZ62Kn
        bkau6+QzC2KZ7teDzNah5mv88yVVPNfr6C7KS3v7ZapCBkIJwD58Pc6OnvUYeBkz
        FLtkRFb0DBWWFQKqdIZnxxgbxWqzn1vh8GmmPnly5Dxf4mwugmehI+sS3teVK+s+
        aT6Twa4cwnVdahGFFZQ6TqSsy3cfeaiKb0X4hC3WanxU/LYsK/+6UKWwC1CZZEsK
        qlsK9etDMocxMbQlOGzK9cGvj9a776nbLMw6AefiaBin5CF6KeoWCBBXRKloHMNR
        NeW0X4AQWZ30Ig==
X-ME-Sender: <xms:zVUzYm9mayJt5TpNk0vu9qE5KQUzuTZ9vJJE6qPurGsnTzV-SYBzTA>
    <xme:zVUzYmtzDB40YZGMo9KJIlCKSu4U_tvp1Chx0VD6Snv2fWjeJEXubhifRxJ-OKrhn
    S5A6ZnCxhRgT1x_-g>
X-ME-Received: <xmr:zVUzYsCeAyOxdTVA1UoIcgufxJ68CAft14qRUSabpkFcywONCyC7HlLvPdtVDTB9D3rbiG9sCKRCJjSQvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:zVUzYueDDkdQvVcTsY8rJPVgFbfokYc_HWqCuQ9i1zcLxSWuM_fQAQ>
    <xmx:zVUzYrN353Ikh7oS8nFdYl5Cj16xDOc9EGNppahPFkLxDXG384pAyA>
    <xmx:zVUzYollA_b2Eb__yMI4PWwBetcNKYBXJKEv5XXeW-snDoJ-XgM8aw>
    <xmx:zlUzYmpseKnei9xDovW9v5iwid23SPpZudGziSqwNwTO96Kk8xiCaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 11:37:49 -0400 (EDT)
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
Subject: [PATCH v8 5/5] drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
Date:   Thu, 17 Mar 2022 11:37:33 -0400
Message-Id: <20220317153733.2171277-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317153733.2171277-1-zi.yan@sent.com>
References: <20220317153733.2171277-1-zi.yan@sent.com>
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

