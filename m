Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B2485B02
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiAEVsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:48:33 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35175 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234125AbiAEVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:48:25 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id B286B580514;
        Wed,  5 Jan 2022 16:48:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jan 2022 16:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=F+6ytW8tADp2L
        NXytpAkKv+4a//pcBSmjTaldQvhu2o=; b=zJFe7Ao9MCOK+TZjq/K/TbeuXuhub
        uEMymMtNy7GDdtEO7HZkK2k7I0QJefpyNTc6QIDRv3VbTOQEz0mNoaKnX14u+Qdb
        o2OErLMPr8nbMPNViHntkADNEWvCU58ZNRNcUUUmv7lhKZFOrqn1ybsMWLAGNaxm
        lUcKl2Ja/YD7ICRFcBTTQK5B8G882NbVn06HGziGFLC39Gegp3cWIj7DDkwJ7odw
        C+Q7WHZw32/+23uQlB375cehRMhlM7Ev0KcGrO73+dc0fxhwnorPVP9V7xPUULlD
        Bm5XJPhUX0VfbeXD3jZhrIUp323BLLWatMr3g4u8XfgsAcn1XBlhLyzSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=F+6ytW8tADp2LNXytpAkKv+4a//pcBSmjTaldQvhu2o=; b=I9TcvzqS
        Rw1NjBo+afbuM8HtqRLcbw5Y9/BUmNxengQ94iNfi4ETD2oDiTzizNxDWj0LPQ2B
        OfoQMTZ8GfnHobghTSW7URMh5JN5eZgGZ1w1YXl8AjktYUMIuDvEgCbRBWcFvfmk
        0IByqySd67Ky97vYXjeCnQL5mgBwYo6aKzFN7QmZ5aHMGZ6AdspxurgVt+kzf4fz
        5lvpapJNbk7lbPeWTK66P7UyBJJmRF+mSGy4zhtshTg3cFHYh2Mf0BZtzjnCEePw
        eIGV2ZIxnul9Y/lJzUQVQC08PkN8ojSSITPC+8d7mVxj8WOETGsGkuW690Y2Ehkt
        n6DTyTq83VG7/w==
X-ME-Sender: <xms:KBLWYWudW-f_b8lxHrHC0ANfNhVh1kU6W5VuYTCGJeKwxUprJ2lhRw>
    <xme:KBLWYbdECgIoVGkrmS1Ler2I7x_DQeKfKtFS9G2bH723wbLALFLR2jxIMrGlNkkh1
    vYTfON0Z9EmgIU1Ew>
X-ME-Received: <xmr:KBLWYRwEMBrJrMNO3NLltA-ncavGBeJJsfnEQjJC0IqIbEYhrkNm2SwGtWlowtYCB52UGbH5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:KBLWYRNU1qDmXKct-2LwZuXjSGwzfevVTXIyvqvS_1nUwOXOqxqSdw>
    <xmx:KBLWYW-ikkLLSpKvGvdFTzzd6nt9QY3FeQkAZZEGGVnliys1-pAACQ>
    <xmx:KBLWYZV_mZeFmV6P6ybsv87N65vJ1FwD3zpTdVueHFAhW_SanZr7og>
    <xmx:KBLWYRUuQYynZ-mTXTyZCnQKtoV-i-cxoeAoO2SIlFPDgV2JOnSUmg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:24 -0500 (EST)
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
        Eric Ren <renzhengeek@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v3 2/8] mm: compaction: handle non-lru compound pages properly in isolate_migratepages_block().
Date:   Wed,  5 Jan 2022 16:47:50 -0500
Message-Id: <20220105214756.91065-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105214756.91065-1-zi.yan@sent.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

In isolate_migratepages_block(), a !PageLRU tail page can be encountered
when the page is larger than a pageblock. Use compound head page for the
checks inside and skip the entire compound page when isolation succeeds.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b4e94cda3019..ad9053fbbe06 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -979,19 +979,23 @@ isolate_migratepages_block(struct compact_control *cc=
, unsigned long low_pfn,
 		 * Skip any other type of page
 		 */
 		if (!PageLRU(page)) {
+			struct page *head =3D compound_head(page);
 			/*
 			 * __PageMovable can return false positive so we need
 			 * to verify it under page_lock.
 			 */
-			if (unlikely(__PageMovable(page)) &&
-					!PageIsolated(page)) {
+			if (unlikely(__PageMovable(head)) &&
+					!PageIsolated(head)) {
 				if (locked) {
 					unlock_page_lruvec_irqrestore(locked, flags);
 					locked =3D NULL;
 				}
=20
-				if (!isolate_movable_page(page, isolate_mode))
+				if (!isolate_movable_page(head, isolate_mode)) {
+					low_pfn +=3D (1 << compound_order(head)) - 1 - (page - head);
+					page =3D head;
 					goto isolate_success;
+				}
 			}
=20
 			goto isolate_fail;
--=20
2.34.1

