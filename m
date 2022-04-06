Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB034F6790
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiDFRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbiDFRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:21:16 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EC84A482E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:19:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B5797320214B;
        Wed,  6 Apr 2022 11:19:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Apr 2022 11:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm3; bh=RypWu
        AcjXYhvuMrAXCozdcgxcIlBzpaT89Q2nmHZmv8=; b=iEA4AuDoPggKN096HOVI5
        bHlUpSMzgSupgdJAnxGAGJqz+Jvalaudj7F3k9G8g8Sfq5NOu7MopfrnZDIQhNuC
        o+KHZ1KsgkelKMm9XJlUbIJjNFlks0Jv1AeLCn81O7H4LgBBRqUMhyZT+IFWufRq
        5wzUpeSxQnFhfbn2bBm5M1nCXOVIgKPZruF5012eTdndUGvhju48xppjdBQp+Njo
        ao56JcYBpACCLOmfqdUX1sunoodAXUOaSr1mv1Y/Cqrs9s/Wsvx5fUUig5qhnvm5
        LkVDuV3U4HMs4Sixmj4FZVLFYt6R4E+ObPrhemAtk3lf725y5T6rzjUw7JsgF9n7
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=RypWuAcjXYhvuMrAXCozdcgxcIlBz
        paT89Q2nmHZmv8=; b=Mi9UhQlYlFA+5GOhJKjv1ga8m/lGC0uEsQjiUXcaVK4tS
        M50O6bFsrYQKpmqxZ+u1aE6mTSlFiC/yJ5ZjSZyTJ/28N8YCuQ6RJvQSxhje328O
        4BEYu0l6eiC9ObiBqiS51IA6ZUv5t2y83Qp2KhZqjpNrb793aYreLTc+BoHP19fd
        9bwQ2fLSf7siiA/u4JaizoYKA19G8saIodBB5LFlbImMh3cPtKdMj5mXkcRXlvUV
        WDhPg1Ian5uhb1TtZGpZauW7IkHAA7hWxi3wuvbmssZRfOmL5HOaaxmhID3i//J6
        VNQ/ZjuGk16QWQzaXgJxzDwnabkWFxG0sjWWL2XgA==
X-ME-Sender: <xms:kq9NYip4qTGsIebt7pTaYsTtCfGGn2ckye7ZsJtqjwSszrUKURjcbQ>
    <xme:kq9NYgoCzOFEAuQvku59Iix28xTXziQpiZJIxx_f_qXG6yIyOtzbnonhjyFLOL50-
    1sOODJUxeyaapmApQ>
X-ME-Received: <xmr:kq9NYnMySvJyp9MUFvir4_QJVMlpSyToPvMOAbNCw7_ON5IFjwPcbgp0e8GAhv4n7Gu8A6jGnb-BB6TSOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgf
    fgleejfeegjedttefhhedvgfffvdeffeekjeetgffhtedvudffkeegleettdenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:kq9NYh450lNQwPhkWmSg2moOMEddBvZ1HrqrvvBCDLKltD9DCJMNeg>
    <xmx:kq9NYh4Kv3d0LP4QzYNGtKlYDgwDcWdYO85mqYoZy78f4LVAo7CNsw>
    <xmx:kq9NYhjf_Hc4eX_AO2i2BHjlHMoXOhhURkoaKsyg2HRjrzd7eVPlsg>
    <xmx:kq9NYmHdfyuRoe7-mAUn9i0OmjBuDyYJxaSadtIHiQDzf2Q2XIm54g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Apr 2022 11:19:45 -0400 (EDT)
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
Subject: [PATCH v10 5/5] drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
Date:   Wed,  6 Apr 2022 11:18:58 -0400
Message-Id: <20220406151858.3149821-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406151858.3149821-1-zi.yan@sent.com>
References: <20220406151858.3149821-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

alloc_contig_range() now only needs to be aligned to pageblock_nr_pages,
drop virtio_mem size requirement that it needs to be MAX_ORDER_NR_PAGES.

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

