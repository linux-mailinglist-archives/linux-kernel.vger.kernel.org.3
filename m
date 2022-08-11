Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5119590909
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiHKXRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiHKXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE297A1A45
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 193645C013A;
        Thu, 11 Aug 2022 19:16:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Aug 2022 19:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259808; x=
        1660346208; bh=3J6erN9Meq/qjQOGkR6S/xWYYRm40MXKsAmQN5L+EFk=; b=t
        0SW/+nwNBkcP5/lWXHShtewEsmEPAI04/9aw2b9RP2wvNLXAFCo5e2pNZGGQc0/5
        enT6UZIKJ63YsQ+DOQOstXJMI2NZ2rweD8x7gQsCgyZ6t9hTPvkEBNcIx27MSmoR
        NPecHeLTR8ULn03DdCssP70gdFtUJ1q45yeKYawweuOFT4QW5gLntHUti5i3YgoJ
        VSDuCKoSkcL8DQttPdRd+4kOMfIw7NJfVQ6Ee5Tu7in2tW9GZnj4zcx04vlRTWzn
        VdyTLID40U64nuwVJ0+kziZaPk9L1ocb7MTGqgq9ehqDjUad68S8lx9E0EUCqYD3
        GPp1Ce7fDbNHWqf3O+56g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259808; x=1660346208; bh=3
        J6erN9Meq/qjQOGkR6S/xWYYRm40MXKsAmQN5L+EFk=; b=NatkXLZ8QrtCktwi7
        HEtm6vzzaK0AmMkDeJPoDyP5ESfnZRBL9gJGwZa6Mi/g5zGhUbHGnIZBNpTEPuKI
        Bd16M1dGGP90ranNjSUBIYyLZqkLMdM3MNN7+Sa89qYoZPcg8z7ZUsDrccXWdXa3
        Xa1fYT/p69HpXQ14C1BefJbQgQWXMwimcUUwUuc+MSgsDLPFIDPpJmjVifSE4CIO
        +6eNGJg8xNm0IslzJN97LIKJ27EhBwycwrlUNR5LNOTChpOza3Z6Kb0BpbRmBz0I
        ze7HyFDMU6wgVI0aJM3jLsaDBwR/yc0pP3ksyhviAnXktnw4IXS4KWBR7fr40/r2
        9il2A==
X-ME-Sender: <xms:3431Yt14V4dp2ryMf6otp2uOQRYb4m4pC2E1tC5lxf3k7DXpBJgSjQ>
    <xme:3431YkEgh5DJCs91Sthh6D4q9L-0ESpPTp24RGZVcP_7yt4JkgDpS_EKW91i2eYx2
    On-qNNFURwH6op_Cw>
X-ME-Received: <xmr:3431Yt55zwGEAtTL0ko2K9iAD5GhisJFYtIdLXGur9EqtndZ-bZmsGm2cS2CUiqmZ7saMRsQlF7vwvUatg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:3431Yq3DX06q3Dv7zZrBYLgOAtTMImnLcXgY4pi23M4HpkumtSmJwQ>
    <xmx:3431YgGDUw5BaOH3QN1jkxp7PkgFOTwmX9cI679FcKNdEQ1MMxWT-Q>
    <xmx:3431Yr9JFEWhQEPxpv5SSkKn5qe3lFQAztcCPDn2ENdmIx0RGLmOXw>
    <xmx:4I31Yo_XFJdQk0l60bwB4B93tglTw1wJJbSbSbsOz9_s1vtgCd_wZw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:47 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 04/12] mm: adapt deferred struct page init to new MAX_ORDER.
Date:   Thu, 11 Aug 2022 19:16:35 -0400
Message-Id: <20220811231643.1012912-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811231643.1012912-1-zi.yan@sent.com>
References: <20220811231643.1012912-1-zi.yan@sent.com>
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

deferred_init only initializes first section of a zone and defers the
rest and the rest of the zone will be initialized in size of a section.
When MAX_ORDER grows beyond a section size, early_page_uninitialised()
did not prevent pages beyond first section from initialization, since it
only checked the starting pfn and assumes MAX_ORDER is smaller than
a section size. In addition, deferred_init_maxorder() uses
MAX_ORDER_NR_PAGES as the initialization unit, which can cause the
initialized chunk of memory overlapping with other initialization jobs.

For the first issue, make early_page_uninitialised() decrease the order
for non-deferred memory initialization when it is bigger than first
section. For the second issue, when adjust pfn alignment in
deferred_init_maxorder(), make sure the alignment is not bigger than
a section size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/internal.h   |  2 +-
 mm/memblock.c   |  6 ++++--
 mm/page_alloc.c | 26 +++++++++++++++++++-------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1433e3a6fdd0..cbe745670c6e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -355,7 +355,7 @@ extern int __isolate_free_page(struct page *page, unsig=
ned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
-					unsigned int order);
+					unsigned int *order);
 extern void __free_pages_core(struct page *page, unsigned int order);
 extern void prep_compound_page(struct page *page, unsigned int order);
 extern void post_alloc_hook(struct page *page, unsigned int order,
diff --git a/mm/memblock.c b/mm/memblock.c
index d1525463c05e..dc2ce6df8fe3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1640,7 +1640,9 @@ void __init memblock_free_late(phys_addr_t base, phys=
_addr_t size)
 	end =3D PFN_DOWN(base + size);
=20
 	for (; cursor < end; cursor++) {
-		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
+		unsigned int order =3D 0;
+
+		memblock_free_pages(pfn_to_page(cursor), cursor, &order);
 		totalram_pages_inc();
 	}
 }
@@ -2035,7 +2037,7 @@ static void __init __free_pages_memory(unsigned long =
start, unsigned long end)
 		while (start + (1UL << order) > end)
 			order--;
=20
-		memblock_free_pages(pfn_to_page(start), start, order);
+		memblock_free_pages(pfn_to_page(start), start, &order);
=20
 		start +=3D (1UL << order);
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 07ad8074950f..3f3af7cd5164 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -463,13 +463,19 @@ static inline bool deferred_pages_enabled(void)
 }
=20
 /* Returns true if the struct page for the pfn is uninitialised */
-static inline bool __meminit early_page_uninitialised(unsigned long pfn)
+static inline bool __meminit early_page_uninitialised(unsigned long pfn, u=
nsigned int *order)
 {
 	int nid =3D early_pfn_to_nid(pfn);
=20
 	if (node_online(nid) && pfn >=3D NODE_DATA(nid)->first_deferred_pfn)
 		return true;
=20
+	/* clamp down order to not exceed first_deferred_pfn */
+	if (order)
+		*order =3D min_t(unsigned int,
+			       *order,
+			       ilog2(NODE_DATA(nid)->first_deferred_pfn - pfn));
+
 	return false;
 }
=20
@@ -515,7 +521,7 @@ static inline bool deferred_pages_enabled(void)
 	return false;
 }
=20
-static inline bool early_page_uninitialised(unsigned long pfn)
+static inline bool early_page_uninitialised(unsigned long pfn, unsigned in=
t *order)
 {
 	return false;
 }
@@ -1644,7 +1650,7 @@ static void __meminit init_reserved_page(unsigned lon=
g pfn)
 	pg_data_t *pgdat;
 	int nid, zid;
=20
-	if (!early_page_uninitialised(pfn))
+	if (!early_page_uninitialised(pfn, NULL))
 		return;
=20
 	nid =3D early_pfn_to_nid(pfn);
@@ -1800,11 +1806,11 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
 #endif /* CONFIG_NUMA */
=20
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
-							unsigned int order)
+							unsigned int *order)
 {
-	if (early_page_uninitialised(pfn))
+	if (early_page_uninitialised(pfn, order))
 		return;
-	__free_pages_core(page, order);
+	__free_pages_core(page, *order);
 }
=20
 /*
@@ -2030,7 +2036,13 @@ static unsigned long __init
 deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
 		       unsigned long *end_pfn)
 {
-	unsigned long mo_pfn =3D ALIGN(*start_pfn + 1, MAX_ORDER_NR_PAGES);
+	/*
+	 * deferred_init_memmap_chunk gives out jobs with max size to
+	 * PAGES_PER_SECTION. Do not align mo_pfn beyond that.
+	 */
+	unsigned long align =3D min_t(unsigned long,
+				MAX_ORDER_NR_PAGES, PAGES_PER_SECTION);
+	unsigned long mo_pfn =3D ALIGN(*start_pfn + 1, align);
 	unsigned long spfn =3D *start_pfn, epfn =3D *end_pfn;
 	unsigned long nr_pages =3D 0;
 	u64 j =3D *i;
--=20
2.35.1

