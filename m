Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC4590913
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiHKXRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiHKXRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:17:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651C7A024C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 792A95C017D;
        Thu, 11 Aug 2022 19:16:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Aug 2022 19:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259810; x=
        1660346210; bh=uhHjqO7fMake/4Yw6e31S9FQXGCwAM7iMxFEnUEtZO8=; b=I
        xburOzFI2YavZy7hDOd13A3/uBpUcF+4U/SAds6S8HDCkF5Owkz2M1kTkV93F+95
        xGjM71TLIEd3xgzhnZ9ZfpptKuGEFPZU64C9A3/zc28ET8TTHb8wxHzdxVgNv/VJ
        hIzwRgASSRZ8TkmYC6yB1s3aBcTTDZ41K7s0RpGsHD3hEOedm26KRUXCGB+HegFs
        H74C6EsqK6KS3/wV+iMkruv+P/RphinFbCk6/XoE5dzlTXfqWaE7d49wx5lC45f4
        wXUg8PVjTZr8V+EfQwBv8nlnUqPQ9eX7VH7tLImQnhkmGdc/gSEZ/E/nmmplc5Nx
        0N8vqm1fOyE+EdSu4utFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259810; x=1660346210; bh=u
        hHjqO7fMake/4Yw6e31S9FQXGCwAM7iMxFEnUEtZO8=; b=exTAiZiEZnbLkmnO/
        ikhXgYLh0lCm+0VKyrVL765VJ44oLKYdhfx5vsxY5vruHwptG/h5YFBNpsXnDNtN
        4pJXt3l/EpZwAYFORNASEG7NC6f/eDIc4d700hpeBAtQD951YLEd3QvrhmZqK0O3
        Q0EG0ZGd0KqxysvOJvMuZBdF0587x4u91gBzC8aTsDnNove6Yb/OxolIYkTwSAZB
        6UaRRMpT/t9Izm8fMuEbP5+QXmV6/7Z2hlg/HusepiRko2DObkTWk6/rzVePPpOE
        AUqsxv/Fn+I/TmBsIAR84URimQAitewoZ+cdFddMV7a+eztde1pL1pFZOFSINFHn
        jLnIA==
X-ME-Sender: <xms:4o31YnXDrYpJzGS_dW0slUegEufbPwAAm9C_DKeITBV6Roxiu3412Q>
    <xme:4o31YvlyaRfNKRr1fk2ym_OybkMfpMnsR5XSKTwPDpbDMesxea87Rtm5TE5E9XOrz
    _yAdQC5-AG4cwW52w>
X-ME-Received: <xmr:4o31YjYCHphl207pA_Xc1iZrYmwnnwJE7A-eEXV2TGvy4D_vnpzLl0Yl_FiFvqhRU0sOtKWCTENFG3hwSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:4o31YiXhbt2fT_IkbjgW0vn-WSaokthNRMGUFqXWhucyYdu-givWog>
    <xmx:4o31Yhnf3MYbCgfl3mJ3xVLtjE2mua5g0O1ME0BysVp-dv6H08LwzQ>
    <xmx:4o31YvcPbvali2i4O-NRy0Ld8JQ48guxfoa3nFfAPbuqNfmfiNIihg>
    <xmx:4o31YqdpjT_XXvtUkaX56xSLyvOFoLo3tPb7xtetlKUBxjPjcy0uFQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:49 -0400 (EDT)
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
Subject: [RFC PATCH v2 08/12] mm/page_reporting: set page_reporting_order to -1 to prevent it running
Date:   Thu, 11 Aug 2022 19:16:39 -0400
Message-Id: <20220811231643.1012912-9-zi.yan@sent.com>
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

page_reporting_order was initialized to MAX_ORDER to prevent it running
before its value is overwritten. Use -1 instead to remove the
dependency on MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page_reporting.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index b48d6ad82998..001438f3dbeb 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -11,7 +11,11 @@
 #include "page_reporting.h"
 #include "internal.h"
=20
-unsigned int page_reporting_order =3D MAX_PHYS_CONTIG_ORDER + 1;
+/*
+ * Set page_reporting_order to (unsigned int)-1 to prevent it running unti=
l the
+ * value is being overwritten
+ */
+unsigned int page_reporting_order =3D (unsigned int)-1;
 module_param(page_reporting_order, uint, 0644);
 MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
=20
--=20
2.35.1

