Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D21259090F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiHKXSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbiHKXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:17:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9FA1A43
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AC7C05C0162;
        Thu, 11 Aug 2022 19:16:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Aug 2022 19:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259812; x=
        1660346212; bh=JX6+NOODRkUOKgp6gGFaE5LIUkI5KzCmUjjUDH9D5W8=; b=o
        MAZmAaohLGJohsfh/rU7NMYoGj7Har723r+mkHEsKIh8ZvsnqGOrQ+BJj2B1xIVA
        DkG5FYekOq/RAdfYnJ74QuRFTqXGOWQxxVkBU5B5KiH6UvQljCq1wXs6zT0Wz8a7
        Fjtuu0uCgxv+fSWxokelAQLwx1rYQNWUEwNeQ864euqkzDTwCkaI0ZWNntY6PUqe
        ytMjmrDhNA1qQBTzHD7HgVGtlcG7BC0omuWZcAYN6xbChCtaU2UCSGQBiCuIk6HE
        lA5D/bG/ctDByeCHhcN7qsvXLr1oJ7diYvKISNJ2CmEzNSldklCnsaYvSm/q2z8a
        I8Pn7c1Es0vv6yDUu/fGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259812; x=1660346212; bh=J
        X6+NOODRkUOKgp6gGFaE5LIUkI5KzCmUjjUDH9D5W8=; b=e+ZAtnJh3F/myKnVO
        xJIUtKWprOiXXdBENhlDb7s3V0K5VmFj2hGRAtNm7ei2YtnuxPGAzxbhvbYkxhah
        OJ178oCM+ASVPLcSjsumkCienO+zBbwssxYOr8lyvUgF5h3T+8dyVW1m9ZjWLYvU
        p8k044vrw+q/pMPwJdVrINlYqCKPI3lE5IgJ/e30b8zzPvcZw6LatoWgzagF39xQ
        EY+NFKF/RyJu/RCrTMIfsV1RRt+7svG1WKwa3ik/Dg+aUa9N0ufpdsaPm9ie8Jwx
        RwLtBfHq3dRQvVStvolPgEOUwJmk+Q7TOl0D2XtA2n5oWxAMPzomWMOVuCFQ8eZx
        85VYQ==
X-ME-Sender: <xms:5I31Yh7KmxD7KVIMmV_-J2lKGyb7_bDVbtPw8O_EtOOVcDxUs_R9Lg>
    <xme:5I31Yu4eiqn_mSN8ldXbi7FUs7BK2Sip6yj-r7szoQmh6cUwSS1TQVuwCS9W_kQZH
    I2Ljk9pTOxyAv_MFg>
X-ME-Received: <xmr:5I31YodXYSY_OmqxxnyqmiUNU1fheXc5sqMyGeiSE4pk6fkHfonwRVXT6Ee2xfKXVlRFfT4c1C2tktgLfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:5I31YqL6bNM94Nr-0bB_jULHspHbilQqzRMWL8DaWDbzniGfJKNnuw>
    <xmx:5I31YlIHMLQUyIC0zVzybadY-Ps9brct4tfO7AfVyFwi86rLBRm0Ig>
    <xmx:5I31YjxmhTs12efRA2B4Y0SnKpQuWKw5hbCtf95rQ8TIj6dLGL0tYg>
    <xmx:5I31YiASz8GWZXibNvGHx7ExypZQXGIfgk-7D4-TQ2z9uyw-2rIZsw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:52 -0400 (EDT)
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
Subject: [RFC PATCH v2 12/12] mm: make MAX_ORDER a kernel boot time parameter.
Date:   Thu, 11 Aug 2022 19:16:43 -0400
Message-Id: <20220811231643.1012912-13-zi.yan@sent.com>
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

With the new buddy_alloc_max_order, users can specify larger MAX_ORDER
than set in CONFIG_ARCH_MAX_ORDER or CONFIG_SET_MAX_ORDER.
It can be set any value >=3D CONFIG_ARCH_MAX_ORDER or CONFIG_SET_MAX_ORDER,
but < 256 (limited by vmscan scan_control and per-cpu free page list).

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 include/linux/mmzone.h                        |  8 +++++
 mm/Kconfig                                    | 13 +++++++
 mm/page_alloc.c                               | 34 ++++++++++++++++++-
 mm/vmscan.c                                   |  1 -
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index ec519225b671..0f71233ae396 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -494,6 +494,11 @@
 	bttv.pll=3D	See Documentation/admin-guide/media/bttv.rst
 	bttv.tuner=3D
=20
+	buddy_alloc_max_order=3D	[KNL] This parameter adjusts the size of largest
+			pages that can be allocated from kernel buddy allocator. The largest
+			page size is 2^buddy_alloc_max_order * PAGE_SIZE.
+            Format: integer
+
 	bulk_remove=3Doff	[PPC]  This parameter disables the use of the pSeries
 			firmware feature for flushing multiple hpte entries
 			at a time.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b5774e4c2700..90121d25d660 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -35,6 +35,14 @@
 #define MIN_MAX_ORDER MAX_ORDER
 #endif
=20
+/* remap MAX_ORDER to buddy_alloc_max_order for boot time adjustment */
+#ifdef CONFIG_BOOT_TIME_MAX_ORDER
+/* Defined in mm/page_alloc.c */
+extern int buddy_alloc_max_order;
+#undef MAX_ORDER
+#define MAX_ORDER buddy_alloc_max_order
+#endif /* CONFIG_BOOT_TIME_MAX_ORDER */
+
 #define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
=20
 /*
diff --git a/mm/Kconfig b/mm/Kconfig
index e558f5679707..acccb919d72d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -455,6 +455,19 @@ config SET_MAX_ORDER
 	  increase this value. A value of 10 means that the largest free memory
 	  block is 2^10 pages.
=20
+config BOOT_TIME_MAX_ORDER
+	bool "Set maximum order of buddy allocator at boot time"
+	depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER !=3D 0 || SET_MAX_O=
RDER !=3D 0)
+	help
+	  It enables users to set the maximum order of buddy allocator at system
+      boot time instead of a static MACRO set at compilation time. Systems=
 with
+      a lot of memory might want to allocate large pages whereas it is much
+      less feasible and desirable for systems with less memory. This option
+      allows different systems to control the largest page they want to
+      allocate. By default, MAX_ORDER will be set to ARCH_FORCE_MAX_ORDER =
or
+      SET_MAX_ORDER, whichever is non-zero, when the boot time parameter i=
s not
+      set. The maximum of MAX_ORDER is currently limited at 256.
+
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
=20
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 941a94bb8cf0..4c4d68da1922 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1581,7 +1581,7 @@ static void free_pcppages_bulk(struct zone *zone, int=
 count,
=20
 		order =3D pindex_to_order(pindex);
 		nr_pages =3D 1 << order;
-		BUILD_BUG_ON(MAX_ORDER >=3D (1<<NR_PCP_ORDER_WIDTH));
+		BUILD_BUG_ON(MIN_MAX_ORDER >=3D (1<<NR_PCP_ORDER_WIDTH));
 		do {
 			int mt;
=20
@@ -9679,3 +9679,35 @@ bool has_managed_dma(void)
 	return false;
 }
 #endif /* CONFIG_ZONE_DMA */
+
+#ifdef CONFIG_BOOT_TIME_MAX_ORDER
+int buddy_alloc_max_order =3D MIN_MAX_ORDER;
+EXPORT_SYMBOL(buddy_alloc_max_order);
+
+static int __init buddy_alloc_set(char *val)
+{
+	int ret;
+	unsigned long max_order;
+
+	ret =3D kstrtoul(val, 10, &max_order);
+
+	if (ret < 0)
+		return -EINVAL;
+
+	/*
+	 * max_order is also limited at below locations:
+	 * 1. scan_control in mm/vmscan.c uses s8 field for order, max_order cann=
ot
+	 * be bigger than S8_MAX before the field is changed.
+	 * 2. free_pcppages_bulk has max_order upper limit.
+	 */
+	if (max_order > MIN_MAX_ORDER && max_order <=3D S8_MAX &&
+	    max_order <=3D (1<<NR_PCP_ORDER_WIDTH))
+		buddy_alloc_max_order =3D max_order;
+	else
+		buddy_alloc_max_order =3D MIN_MAX_ORDER;
+
+	return 0;
+}
+
+early_param("buddy_alloc_max_order", buddy_alloc_set);
+#endif /* CONFIG_BOOT_TIME_MAX_ORDER */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 06eeeae038dd..9d4fde8705d9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3816,7 +3816,6 @@ unsigned long try_to_free_pages(struct zonelist *zone=
list, int order,
 	 * scan_control uses s8 fields for order, priority, and reclaim_idx.
 	 * Confirm they are large enough for max values.
 	 */
-	BUILD_BUG_ON(MAX_ORDER > S8_MAX);
 	BUILD_BUG_ON(DEF_PRIORITY > S8_MAX);
 	BUILD_BUG_ON(MAX_NR_ZONES > S8_MAX);
=20
--=20
2.35.1

