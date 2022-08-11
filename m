Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE759090B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiHKXSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiHKXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:17:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D6A1A46
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CB655C017F;
        Thu, 11 Aug 2022 19:16:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 11 Aug 2022 19:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259811; x=
        1660346211; bh=KqyAltuV0l6VggMJZ/X8DJ5z8l2OLxGSSS19zX3wJgA=; b=t
        6aBBIUIiKBgyF0nq9M2l/FkGxLKyoQ5GA3HDr25AhRzkcwFdcL2GgtYrOWJ5zQqg
        55uAFWTBlpUg3YLJ/35T98aRWOuWVIfw4vAx+4qGHKsRpVG/pJkx9+tINY2FemoY
        1L9IEZZHzkZoZTIUgYwdalFoqXsQ6orMDiaP54yoiH7wpz2/1SlAae+WwBU1OBYC
        dtzN/xngzp1wkdyXaP2QJ3BDMcks9vfOpeQV+bktQo978O3SlzrX2BVib8iLFQfv
        iBsnt0V8B/Dlt0PvsOeWVmeHPEqgZTlhEeQF66UrLaPrvymUUsTezvHovlss3qSh
        9kv/O8teFkcyEPo45wzFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259811; x=1660346211; bh=K
        qyAltuV0l6VggMJZ/X8DJ5z8l2OLxGSSS19zX3wJgA=; b=UNOQe8eOqO2joIxWT
        odoyDyprra/+Mk8v4f74AJRsjFXjz8fzmX9jJ+5owNqpXzPCT4H1H0RbUBnkV6o2
        HvE1cUH/FlJhhJvsni7HgTcNoAuj6pY3TaJHkr2nyMBJ96BhD8yhwNgWp9Ajo/2a
        xd5GE5CYIA6nQjQPpZRHpNo1XqzQQMG41K7EKiitIMZqSIZpwIHyNPA2kxzJXd8z
        7sOAdzLF7wRxp4Vo+aGs8vqRgiX9g8UVwjXy0vBLbYViflOkfCKWJVU+GjadMzb/
        rdJzKSWbLJv2j4Jlh22eEYEsPlZKsMfpB1xvWyy3WbpfNBUP0Q20eaIJppZ2JW64
        h0KSQ==
X-ME-Sender: <xms:4431YkR4i2MOW1QsqFk3pvA-KBDGI2ckPhk7Si1SDwHfi-sBkpxaNg>
    <xme:4431YhxpFc_10nzBvTpyADMdO31Z3Z4B88-wFmlhQ8MBZznGkQnVdMLsVHy4lwGuX
    pJEHSOLLan00eTP2g>
X-ME-Received: <xmr:4431Yh1BvY2zMKuQP_uEiQ4oweaHkiReylI_8wssi5dyUc1FoY6Ctc0bI-mSaGF-4F08F2XzT7uCVuWtMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:4431YoAztNNhFA6e3zExOL5jiBtJ3lfZKNj55lLYR4ij_o74eQZ5ag>
    <xmx:4431YtixQsAcHqjhBVfH37elfzk1sDk-mwPoUkvDxDLCxw8gHKiHDA>
    <xmx:4431YkplNIzkJT92D75ZgGhJgK47yM-f7Vic3KbP_qVQhPAsGMGHPg>
    <xmx:4431YiZqmXzaiT-pYRbwargpSCPnAkVn4e6ke3d6j2bbPPK9nn7DKw>
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
Subject: [RFC PATCH v2 10/12] mm: convert MAX_ORDER sized static arrays to dynamic ones.
Date:   Thu, 11 Aug 2022 19:16:41 -0400
Message-Id: <20220811231643.1012912-11-zi.yan@sent.com>
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

This prepares for the upcoming changes to make MAX_ORDER a boot time
parameter instead of compilation time constant. All static arrays with
MAX_ORDER size are converted to pointers and their memory is allocated
at runtime.

free_area array in struct zone is allocated using memblock_alloc_node()
at boot time and using kzalloc() when memory is hot-added.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: kexec@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 .../admin-guide/kdump/vmcoreinfo.rst          |  2 +-
 drivers/gpu/drm/ttm/ttm_device.c              |  7 ++-
 drivers/gpu/drm/ttm/ttm_pool.c                | 58 +++++++++++++++++--
 include/drm/ttm/ttm_pool.h                    |  4 +-
 include/linux/mmzone.h                        |  2 +-
 mm/page_alloc.c                               | 32 ++++++++--
 6 files changed, 87 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation=
/admin-guide/kdump/vmcoreinfo.rst
index c572b5230fe0..a775462aa7c7 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -172,7 +172,7 @@ variables.
 Offset of the free_list's member. This value is used to compute the number
 of free pages.
=20
-Each zone has a free_area structure array called free_area[MAX_ORDER + 1].
+Each zone has a free_area structure array called free_area with length of =
MAX_ORDER + 1.
 The free_list represents a linked list of free page blocks.
=20
 (list_head, next|prev)
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_dev=
ice.c
index e7147e304637..442a77bb5b4f 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -92,7 +92,9 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 =3D min(num_dma32, 2UL << (30 - PAGE_SHIFT));
=20
-	ttm_pool_mgr_init(num_pages);
+	ret =3D ttm_pool_mgr_init(num_pages);
+	if (ret)
+		goto out;
 	ttm_tt_mgr_init(num_pages, num_dma32);
=20
 	glob->dummy_read_page =3D alloc_page(__GFP_ZERO | GFP_DMA32);
@@ -218,7 +220,8 @@ int ttm_device_init(struct ttm_device *bdev, struct ttm=
_device_funcs *funcs,
 	bdev->funcs =3D funcs;
=20
 	ttm_sys_man_init(bdev);
-	ttm_pool_init(&bdev->pool, dev, use_dma_alloc, use_dma32);
+	if (ttm_pool_init(&bdev->pool, dev, use_dma_alloc, use_dma32))
+		return -ENOMEM;
=20
 	bdev->vma_manager =3D vma_manager;
 	INIT_DELAYED_WORK(&bdev->wq, ttm_device_delayed_workqueue);
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 85d19f425af6..d76f7d476421 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -64,11 +64,11 @@ module_param(page_pool_size, ulong, 0644);
=20
 static atomic_long_t allocated_pages;
=20
-static struct ttm_pool_type global_write_combined[MAX_ORDER + 1];
-static struct ttm_pool_type global_uncached[MAX_ORDER + 1];
+static struct ttm_pool_type *global_write_combined;
+static struct ttm_pool_type *global_uncached;
=20
-static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER + 1];
-static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
+static struct ttm_pool_type *global_dma32_write_combined;
+static struct ttm_pool_type *global_dma32_uncached;
=20
 static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
@@ -493,8 +493,10 @@ EXPORT_SYMBOL(ttm_pool_free);
  * @use_dma32: true if GFP_DMA32 should be used
  *
  * Initialize the pool and its pool types.
+ *
+ * Returns: 0 on successe, negative error code otherwise
  */
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   bool use_dma_alloc, bool use_dma32)
 {
 	unsigned int i, j;
@@ -506,11 +508,30 @@ void ttm_pool_init(struct ttm_pool *pool, struct devi=
ce *dev,
 	pool->use_dma32 =3D use_dma32;
=20
 	if (use_dma_alloc) {
-		for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i)
+		for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+			pool->caching[i].orders =3D
+				kvcalloc(MAX_ORDER + 1, sizeof(struct ttm_pool_type),
+					GFP_KERNEL);
+			if (!pool->caching[i].orders) {
+				i--;
+				goto failed;
+			}
 			for (j =3D 0; j <=3D MAX_ORDER; ++j)
 				ttm_pool_type_init(&pool->caching[i].orders[j],
 						   pool, i, j);
+
+		}
+		return 0;
+
+failed:
+		for (; i >=3D 0; i--) {
+			for (j =3D 0; j <=3D MAX_ORDER; ++j)
+				ttm_pool_type_fini(&pool->caching[i].orders[j]);
+			kfree(pool->caching[i].orders);
+		}
+		return -ENOMEM;
 	}
+	return 0;
 }
=20
 /**
@@ -701,6 +722,31 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
=20
+	if (!global_write_combined) {
+		global_write_combined =3D kvcalloc(MAX_ORDER + 1, sizeof(struct ttm_pool=
_type),
+						GFP_KERNEL);
+		if (!global_write_combined)
+			return -ENOMEM;
+	}
+	if (!global_uncached) {
+		global_uncached =3D kvcalloc(MAX_ORDER + 1, sizeof(struct ttm_pool_type),
+					  GFP_KERNEL);
+		if (!global_uncached)
+			return -ENOMEM;
+	}
+	if (!global_dma32_write_combined) {
+		global_dma32_write_combined =3D kvcalloc(MAX_ORDER + 1, sizeof(struct tt=
m_pool_type),
+						      GFP_KERNEL);
+		if (!global_dma32_write_combined)
+			return -ENOMEM;
+	}
+	if (!global_dma32_uncached) {
+		global_dma32_uncached =3D kvcalloc(MAX_ORDER + 1, sizeof(struct ttm_pool=
_type),
+						GFP_KERNEL);
+		if (!global_dma32_uncached)
+			return -ENOMEM;
+	}
+
 	for (i =3D 0; i <=3D MAX_ORDER; ++i) {
 		ttm_pool_type_init(&global_write_combined[i], NULL,
 				   ttm_write_combined, i);
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 8ce14f9d202a..f5ce60f629ae 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -72,7 +72,7 @@ struct ttm_pool {
 	bool use_dma32;
=20
 	struct {
-		struct ttm_pool_type orders[MAX_ORDER + 1];
+		struct ttm_pool_type *orders;
 	} caching[TTM_NUM_CACHING_TYPES];
 };
=20
@@ -80,7 +80,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *=
tt,
 		   struct ttm_operation_ctx *ctx);
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
=20
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   bool use_dma_alloc, bool use_dma32);
 void ttm_pool_fini(struct ttm_pool *pool);
=20
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b83b481e250b..60d8cce2aed8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -635,7 +635,7 @@ struct zone {
 	ZONE_PADDING(_pad1_)
=20
 	/* free areas of different sizes */
-	struct free_area	free_area[MAX_ORDER + 1];
+	struct free_area	*free_area;
=20
 	/* zone flags, see below */
 	unsigned long		flags;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3f3af7cd5164..941a94bb8cf0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6195,11 +6195,21 @@ void show_free_areas(unsigned int filter, nodemask_=
t *nodemask)
=20
 	for_each_populated_zone(zone) {
 		unsigned int order;
-		unsigned long nr[MAX_ORDER + 1], flags, total =3D 0;
-		unsigned char types[MAX_ORDER + 1];
+		unsigned long *nr, flags, total =3D 0;
+		unsigned char *types;
=20
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
+
+		nr =3D kmalloc_array(MAX_ORDER + 1, sizeof(unsigned long), GFP_KERNEL);
+		if (!nr)
+			break;
+		types =3D kmalloc_array(MAX_ORDER + 1, sizeof(unsigned char), GFP_KERNEL=
);
+		if (!types) {
+			kfree(nr);
+			break;
+		}
+
 		show_node(zone);
 		printk(KERN_CONT "%s: ", zone->name);
=20
@@ -7649,8 +7659,8 @@ static void __meminit pgdat_init_internals(struct pgl=
ist_data *pgdat)
 	lruvec_init(&pgdat->__lruvec);
 }
=20
-static void __meminit zone_init_internals(struct zone *zone, enum zone_typ=
e idx, int nid,
-							unsigned long remaining_pages)
+static void __init zone_init_internals(struct zone *zone, enum zone_type i=
dx, int nid,
+					unsigned long remaining_pages, bool hotplug)
 {
 	atomic_long_set(&zone->managed_pages, remaining_pages);
 	zone_set_nid(zone, nid);
@@ -7659,6 +7669,16 @@ static void __meminit zone_init_internals(struct zon=
e *zone, enum zone_type idx,
 	spin_lock_init(&zone->lock);
 	zone_seqlock_init(zone);
 	zone_pcp_init(zone);
+	if (hotplug)
+		zone->free_area =3D
+			kcalloc_node(MAX_ORDER + 1, sizeof(struct free_area),
+				     GFP_KERNEL, nid);
+	else
+		zone->free_area =3D
+			memblock_alloc_node(sizeof(struct free_area) * (MAX_ORDER + 1),
+					    sizeof(struct free_area), nid);
+	BUG_ON(!zone->free_area);
+
 }
=20
 /*
@@ -7697,7 +7717,7 @@ void __ref free_area_init_core_hotplug(struct pglist_=
data *pgdat)
 	}
=20
 	for (z =3D 0; z < MAX_NR_ZONES; z++)
-		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
+		zone_init_internals(&pgdat->node_zones[z], z, nid, 0, true);
 }
 #endif
=20
@@ -7760,7 +7780,7 @@ static void __init free_area_init_core(struct pglist_=
data *pgdat)
 		 * when the bootmem allocator frees pages into the buddy system.
 		 * And all highmem pages will be managed by the buddy system.
 		 */
-		zone_init_internals(zone, j, nid, freesize);
+		zone_init_internals(zone, j, nid, freesize, false);
=20
 		if (!size)
 			continue;
--=20
2.35.1

