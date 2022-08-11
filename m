Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C92590912
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiHKXRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiHKXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F57A1A47
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A85585C016A;
        Thu, 11 Aug 2022 19:16:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Aug 2022 19:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259808; x=
        1660346208; bh=h7KvVoFgGWP9FjrKQ1xzyC233beztE1gWDCxy87SIdw=; b=M
        S7Yo7dRKmxYgBaUAIPZt6K1dzK+mkREVRbiFyc33eCtEKxHMAai/dK4sMQgi/KjQ
        aSuIPaMDagxyUtNK0nqGqkrtzmvgCvNUYQ+Ty5dssjYJzuqJ149DqvxG02cJ4vFr
        uqSAmpried/ZVC7Mu+yt6ogLuOjAauEh2X9vk/PkStbTcwMh2bYhoq1RMYAnXKgs
        xzMuYU7VzOiiGlNASVJ+xpKEyegvuvVK1o4Hbcy4yJWJCGMFacbYEANSgS58xiSp
        f1cKkCwWfl7XeViuc9c6zjUAxfqThqGARJngxcJ85V8LZNEZ1IFEqKmQyYj4t5V9
        1lNqLh6HH5Dozbu1ZuOIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259808; x=1660346208; bh=h
        7KvVoFgGWP9FjrKQ1xzyC233beztE1gWDCxy87SIdw=; b=zFmpwpxtxD4EJ/NJ4
        iy8+P15+cNAjsKn2vaINhpPO/H5BsFI5QldjHbAA4r7RcpFo88NQrDPt9JVxI5h9
        T+yynq60tigfn/M7vXfcCX+u+ps4+SOcoQMs55ZL9+K+qTbn0pCrKDkRamV2pFvK
        I6eqhqGfcUY7/dQFj1AXb9NAva2zrAfgA47oVmC9IKitjHBje0i9zWH579hb6wkz
        G9WSzKhMfKrMoJ1GMIbIm332W1nv1cnk0WDtz9NBHVRegRgsaBf+fFbYG5iIC3bM
        mDepKmzGm06FfWMu7vMFbGo4V6UU/y2FEi4o8y7a8GlO2ZmFKe3aSeMUsfsjKRCV
        uAALA==
X-ME-Sender: <xms:4I31Yk26UhKsl3Bwu09mcNxWjnosr_Q7BJvkd9C8PLwspYZ505zq0g>
    <xme:4I31YvGcjO3H6LzZcBgbDgNNZh1BVTlCBIofRHSiBl02xJghFH-IjvH9X1hzw26ES
    hQm841_mWgJp0VJxA>
X-ME-Received: <xmr:4I31Ys6wax1Q200XFElEys6WzWQa_xJ4r-5Svjczednss086cLKopquG1rB1uwiWlk3MsFYe2RNQyqZJjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:4I31Yt3Hfi5el5uuWcSxquf0G6PQOc6uGfJ0APyV4wC1EEUNE8SszQ>
    <xmx:4I31YnFri9VeUKOw0hjYQqeLV6oO0TvTwZ1F-pwaQX-KuDqNq-wwSQ>
    <xmx:4I31Ym_h9rlEcCklMfFMaUgJXEQlr50ZQXu0PjJaBMArCVzOQ9mC1g>
    <xmx:4I31Yv-71-4QbXxTnfkxFHIZej9RuxzJx4f2eJPWLQiXBCIrrGjmtw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:48 -0400 (EDT)
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
Subject: [RFC PATCH v2 05/12] mm: prevent pageblock size being larger than section size.
Date:   Thu, 11 Aug 2022 19:16:36 -0400
Message-Id: <20220811231643.1012912-6-zi.yan@sent.com>
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

Only physical pages from a section can be guaranteed to be contiguous
and so far a pageblock can only group contiguous physical pages by
design. Set pageblock_order properly to prevent pageblock going beyond
section size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/pageblock-flags.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flag=
s.h
index 358b871b07ca..2679b2b4c079 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -47,8 +47,11 @@ extern unsigned int pageblock_order;
=20
 #else /* CONFIG_HUGETLB_PAGE */
=20
-/* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
-#define pageblock_order		MAX_ORDER
+/*
+ * If huge pages are not used, group by MAX_ORDER_NR_PAGES or
+ * PAGES_PER_SECTION when MAX_ORDER_NR_PAGES is larger.
+ */
+#define pageblock_order		(min(PFN_SECTION_SHIFT, MAX_ORDER))
=20
 #endif /* CONFIG_HUGETLB_PAGE */
=20
--=20
2.35.1

