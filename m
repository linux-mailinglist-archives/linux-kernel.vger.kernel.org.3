Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3657590914
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiHKXSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiHKXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:17:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC3A1A63
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E2265C0181;
        Thu, 11 Aug 2022 19:16:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Aug 2022 19:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259812; x=
        1660346212; bh=JJp8/WbfdgzTShpKb6EAlVBgY9k+ndflpg8+oR/k5/U=; b=a
        VzCd2BkWTYFNhH59UG/DCqw8k/WSQRR/u3dt97Rx/Xp2zW3uPUhMloYuCEv9VLql
        NEG0HZhwo16heeyZusiNHd7PVXiM1n/awcRkb6NwS9Sb9YxnR8q3M9GfR2pOWr8d
        78sZ8fOk6lqn4iYSIOpwqaFR51D8tpz1EZ0I6v7yf0BCLDfutjxLR8vWWbB2FWmN
        FXWoSvgtXWDeo6zrYpDztC9JJ/nQUzC5p0NNGjlKly4j7WmHg4jiPEZVEcNNZRlT
        VSj+ZUnbTURnGGstbGxYV1NB9BzknroblSrEK8xVpFVfkEFBZYJbcJDyLnrSqKj6
        aFL16VKkv4mtcwVXbFxGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259812; x=1660346212; bh=J
        Jp8/WbfdgzTShpKb6EAlVBgY9k+ndflpg8+oR/k5/U=; b=LdFtYcpqWUM2Q+SmN
        b9rKag+KtCSNa5Awkn9HIwke+3Lu/DectUgGfRZymL6m4yXGqaS+/FjHa5Jpc7cE
        WO1lStQn4KtYb68M3fOA4/nXY8smCm4bBCrtIWa46+02sXU+kQNRg2GVC6Lv/zra
        D3axOMKaP3Z9BVOta3SV/FLqIAsxoGFUm0d1T3m7bBlSdRaWJoSN2UY9gLcy6Ebn
        ga3Y9VXSBWZ+0ZKOAeRLAbfVxzhRppYYAL0/+HdV8kuo2Y+OJCNivzuq7wB9Hytj
        yK0xAT6grDeibh9+v0txk898fpM6wyyXIpid4udGX/gDGmlOp6YDTAs46ezPrVtH
        Qecyw==
X-ME-Sender: <xms:4431YuyQ8RaADhVQJO_t-Rn4Z8DR9DZ2vo6nEYFsPyKXZgMkaii-CA>
    <xme:4431YqTYlFaQlfhoIQ3SUCd050wbtNrmj7tv1EGHBcqOVcEKf004t3L59Lz4LXds_
    Hr4REMLH-Ee7qCnLA>
X-ME-Received: <xmr:4431YgXuk354WfKrOrEXReLKj6HJusDGOr_GV3obYF9tMZcEwFqpgzGACtKBZd-rPXaiwZySTchKmTG7aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:4431YkhCVNTY2_OvAlpuqd4u-tbj8FRla_-lpmoIeQ8CfHRdVtj0fQ>
    <xmx:4431YgCtEOKwmt_dTrz6MEGJtCWlzGoDlTmghYk7vjCXqY2MkPefRg>
    <xmx:4431YlJFbjmHowgLQHEwhuENEmvZkNPRHTki059nEG2Aw_wMs2SAUQ>
    <xmx:5I31Yk5__HsZbu_IlgJSLqVevnr3605nRuApAOdCLnK_oKNEJUJhbQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:51 -0400 (EDT)
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
Subject: [RFC PATCH v2 11/12] mm: introduce MIN_MAX_ORDER to replace MAX_ORDER as compile time constant.
Date:   Thu, 11 Aug 2022 19:16:42 -0400
Message-Id: <20220811231643.1012912-12-zi.yan@sent.com>
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

For other MAX_ORDER uses (described below), there is no need or too much
hassle to convert certain static array to dynamic ones. Add
MIN_MAX_ORDER to serve as compile time constant in place of MAX_ORDER.

ARM64 hypervisor maintains its own free page list and does not import
any core kernel symbols, so soon-to-be runtime variable MAX_ORDER is not
accessible in ARM64 hypervisor code. Also there is no need to allocating
very large pages.

In SLAB/SLOB/SLUB, 2-D array kmalloc_caches uses MAX_ORDER in its second
dimension. It is too much hassle to allocate memory for kmalloc_caches
before any proper memory allocator is set up.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Quentin Perret <qperret@google.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h | 2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 2 +-
 include/linux/mmzone.h                | 3 +++
 include/linux/slab.h                  | 8 ++++----
 mm/slab.c                             | 2 +-
 mm/slub.c                             | 6 +++---
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/inc=
lude/nvhe/gfp.h
index fe5472a184a3..29b92f68ab69 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -16,7 +16,7 @@ struct hyp_pool {
 	 * API at EL2.
 	 */
 	hyp_spinlock_t lock;
-	struct list_head free_area[MAX_ORDER + 1];
+	struct list_head free_area[MIN_MAX_ORDER + 1];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
 	unsigned short max_order;
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe=
/page_alloc.c
index d40f0b30b534..7ebbac3e2e76 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -241,7 +241,7 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsig=
ned int nr_pages,
 	int i;
=20
 	hyp_spin_lock_init(&pool->lock);
-	pool->max_order =3D min(MAX_ORDER, get_order((nr_pages + 1) << PAGE_SHIFT=
));
+	pool->max_order =3D min(MIN_MAX_ORDER, get_order((nr_pages + 1) << PAGE_S=
HIFT));
 	for (i =3D 0; i < pool->max_order; i++)
 		INIT_LIST_HEAD(&pool->free_area[i]);
 	pool->range_start =3D phys;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 60d8cce2aed8..b5774e4c2700 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -26,10 +26,13 @@
 /* Free memory management - zoned buddy allocator.  */
 #ifdef CONFIG_SET_MAX_ORDER
 #define MAX_ORDER CONFIG_SET_MAX_ORDER
+#define MIN_MAX_ORDER CONFIG_SET_MAX_ORDER
 #elif CONFIG_ARCH_FORCE_MAX_ORDER !=3D 0
 #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
+#define MIN_MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
 #else
 #define MAX_ORDER 10
+#define MIN_MAX_ORDER MAX_ORDER
 #endif
=20
 #define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 568b5dfb3bd9..e34b2c9bda09 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -251,8 +251,8 @@ static inline unsigned int arch_slab_minalign(void)
  * to do various tricks to work around compiler limitations in order to
  * ensure proper constant folding.
  */
-#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT) <=3D 25 ? \
-				(MAX_ORDER + PAGE_SHIFT) : 25)
+#define KMALLOC_SHIFT_HIGH	((MIN_MAX_ORDER + PAGE_SHIFT) <=3D 25 ? \
+				(MIN_MAX_ORDER + PAGE_SHIFT) : 25)
 #define KMALLOC_SHIFT_MAX	KMALLOC_SHIFT_HIGH
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	5
@@ -265,7 +265,7 @@ static inline unsigned int arch_slab_minalign(void)
  * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
  */
 #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
+#define KMALLOC_SHIFT_MAX	(MIN_MAX_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
@@ -278,7 +278,7 @@ static inline unsigned int arch_slab_minalign(void)
  * be allocated from the same page.
  */
 #define KMALLOC_SHIFT_HIGH	PAGE_SHIFT
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
+#define KMALLOC_SHIFT_MAX	(MIN_MAX_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
diff --git a/mm/slab.c b/mm/slab.c
index 530f418a4930..23798c32bb38 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -466,7 +466,7 @@ static int __init slab_max_order_setup(char *str)
 {
 	get_option(&str, &slab_max_order);
 	slab_max_order =3D slab_max_order < 0 ? 0 :
-				min(slab_max_order, MAX_ORDER);
+				min(slab_max_order, MIN_MAX_ORDER);
 	slab_max_order_set =3D true;
=20
 	return 1;
diff --git a/mm/slub.c b/mm/slub.c
index 5acf5407cbc6..940fe48ea298 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3876,8 +3876,8 @@ static inline int calculate_order(unsigned int size)
 	/*
 	 * Doh this slab cannot be placed using slub_max_order.
 	 */
-	order =3D calc_slab_order(size, 1, MAX_ORDER, 1);
-	if (order <=3D MAX_ORDER)
+	order =3D calc_slab_order(size, 1, MIN_MAX_ORDER, 1);
+	if (order <=3D MIN_MAX_ORDER)
 		return order;
 	return -ENOSYS;
 }
@@ -4388,7 +4388,7 @@ __setup("slub_min_order=3D", setup_slub_min_order);
 static int __init setup_slub_max_order(char *str)
 {
 	get_option(&str, (int *)&slub_max_order);
-	slub_max_order =3D min_t(unsigned int, slub_max_order, MAX_ORDER);
+	slub_max_order =3D min_t(unsigned int, slub_max_order, MIN_MAX_ORDER);
=20
 	return 1;
 }
--=20
2.35.1

