Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC15A5730B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiGMIOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiGMIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D0DEA160
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11399619E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7988AC341F7;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=2wmxuMUZY1VgyyhfHRin+pKYCCTE3QrkPUnnBhPYRKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSYP/dCP3zikanSBk+cL3IDH5a3i/MEOexi/J3Klc9ZYoRRqG8XqmI2Ry/JmYkwWH
         A81y7Nnl01INcBNYPTMy5mGkNtyUaWGdOikq4dbb78N84I0v2tQ+Rs4u1n/+R/5tzW
         V7btbgj9VAMW944JEIMXkAhYjqMvxzy6AHZCM+cbDx7jWNVpakVJukNBSwoAJ5T8gY
         Sz5011AaubBaS+p5Z/Q84TSk1/HSMIHBUkNQ5g+zO5o4IpkfbxHwc/rlzOQvsxl+TE
         xF6neZbjIQgdLZ/pDbfIyNK+La36kMXgnpllWBxiBVMHxIJazgDCNt0x7LMjYMddx3
         5ENEBfxAc8Qog==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTy-004zug-2Y;
        Wed, 13 Jul 2022 09:12:30 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/39] drm/i915: document struct drm_i915_gem_object
Date:   Wed, 13 Jul 2022 09:12:25 +0100
Message-Id: <595fc6f7954e07cb8b6ea2e60f6ef2270bd65777.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a large struct used to describe gem objects. It is
currently partially documented. Finish its documentation, filling
the gaps from git logs.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 .../gpu/drm/i915/gem/i915_gem_object_types.h  | 200 ++++++++++++++----
 1 file changed, 158 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index ceed0d220ce3..8c09e493590d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -233,6 +233,9 @@ struct i915_gem_object_page_iter {
 	struct mutex lock; /* protects this cache */
 };
 
+/**
+ * struct drm_i915_gem_object - describes an i915 GEM object
+ */
 struct drm_i915_gem_object {
 	/*
 	 * We might have reason to revisit the below since it wastes
@@ -241,12 +244,16 @@ struct drm_i915_gem_object {
 	 * when accessing it.
 	 */
 	union {
+		/** @base: GEM base object */
 		struct drm_gem_object base;
+		/** @__do_not_access: TTM buffer object */
 		struct ttm_buffer_object __do_not_access;
 	};
 
+	/** @ops: pointer to GEM object ops */
 	const struct drm_i915_gem_object_ops *ops;
 
+	/** @vma: struct containing VMA list, tree and lock */
 	struct {
 		/**
 		 * @vma.lock: protect the list/tree of vmas
@@ -280,10 +287,12 @@ struct drm_i915_gem_object {
 	 *
 	 * If this object is closed, we need to remove all of its VMA from
 	 * the fast lookup index in associated contexts; @lut_list provides
-	 * this translation from object to context->handles_vma.
+	 * this translation from object to ``context->handles_vma``.
 	 */
 	struct list_head lut_list;
-	spinlock_t lut_lock; /* guards lut_list */
+
+	/** @lut_lock: guards @lut_list */
+	spinlock_t lut_lock;
 
 	/**
 	 * @obj_link: Link into @i915_gem_ww_ctx.obj_list
@@ -294,42 +303,88 @@ struct drm_i915_gem_object {
 	 */
 	struct list_head obj_link;
 	/**
-	 * @shared_resv_from: The object shares the resv from this vm.
+	 * @shares_resv_from: The object shares the resv from this vm.
 	 */
 	struct i915_address_space *shares_resv_from;
 
 	union {
+		/** @rcu: head used when freeing objects with RCU */
 		struct rcu_head rcu;
+		/** @freed: list of GEM freed objects */
 		struct llist_node freed;
 	};
 
 	/**
-	 * Whether the object is currently in the GGTT mmap.
+	 * @userfault_count: a value bigger than zero means that the object
+	 * was mmapped into userspace.
+	 *
+	 * Used when the object is currently in the GGTT mmap.
 	 */
 	unsigned int userfault_count;
+	/**
+	 * @userfault_link: list of all objects that were
+	 * mmapped into userspace.
+	 *
+	 * Used when the object is currently in the GGTT mmap.
+	 */
 	struct list_head userfault_link;
 
+	/** @mmo: struct containing mmo offsets and lock */
 	struct {
-		spinlock_t lock; /* Protects access to mmo offsets */
+		/** @mmo.lock: protects access to @mmo.offsets */
+		spinlock_t lock;
+		/** @mmo.offsets: rbtree list of mmo offsets */
 		struct rb_root offsets;
 	} mmo;
 
+	/* private: used on selftest only */
 	I915_SELFTEST_DECLARE(struct list_head st_link);
+	/* public: */
 
+	/**
+	 * @flags: object flags. Current flags are:
+	 *
+	 * %I915_BO_ALLOC_CONTIGUOUS:
+	 *	Object requires to be allocated as a contiguous block
+	 * %I915_BO_ALLOC_VOLATILE:
+	 *	Volatile objects are marked as %DONTNEED while pinned, therefore
+	 *	once unpinned the backing store can be discarded.
+	 *	This is limited to kernel internal objects.
+	 * %I915_BO_ALLOC_CPU_CLEAR:
+	 *	Some internal device local-memory objects may have an option
+	 *	to CPU clear the pages upon gathering the backing store.
+	 *	Note that this might be before the blitter is usable, which
+	 *	is the case for some internal GuC objects.
+	 * %I915_BO_ALLOC_USER:
+	 *	Make sure the object is cleared before any user access.
+	 * %I915_BO_ALLOC_PM_VOLATILE:
+	 *	Object is allowed to lose its contents on suspend / resume,
+	 *	even if pinned
+	 * %I915_BO_ALLOC_PM_EARLY:
+	 *	Object needs to be restored early using memcpy during resume
+	 * %I915_BO_ALLOC_GPU_ONLY:
+	 *	Object is likely never accessed by the CPU. This will
+	 *	prioritise the BO to be allocated in the non-mappable portion
+	 *	of lmem. This is merely a hint, and if dealing with userspace
+	 *	objects the CPU fault handler is free to ignore this.
+	 * %I915_BO_READONLY:
+	 *	User has created object as read-only
+	 * %I915_BO_PROTECTED:
+	 *	User has created protected. All protected objects and
+	 *	contexts will be considered invalid when the PXP session
+	 *	is destroyed and all new submissions using them will be
+	 *	rejected. All intel contexts within the invalidated gem
+	 *	contexts will be marked banned. Userspace can detect that
+	 *	an invalidation has occurred via the %RESET_STATS ioctl,
+	 *	where we report it the same way as a ban due to a hang.
+	 */
 	unsigned long flags;
 #define I915_BO_ALLOC_CONTIGUOUS  BIT(0)
 #define I915_BO_ALLOC_VOLATILE    BIT(1)
 #define I915_BO_ALLOC_CPU_CLEAR   BIT(2)
 #define I915_BO_ALLOC_USER        BIT(3)
-/* Object is allowed to lose its contents on suspend / resume, even if pinned */
 #define I915_BO_ALLOC_PM_VOLATILE BIT(4)
-/* Object needs to be restored early using memcpy during resume */
 #define I915_BO_ALLOC_PM_EARLY    BIT(5)
-/*
- * Object is likely never accessed by the CPU. This will prioritise the BO to be
- * allocated in the non-mappable portion of lmem. This is merely a hint, and if
- * dealing with userspace objects the CPU fault handler is free to ignore this.
- */
 #define I915_BO_ALLOC_GPU_ONLY	  BIT(6)
 #define I915_BO_ALLOC_FLAGS (I915_BO_ALLOC_CONTIGUOUS | \
 			     I915_BO_ALLOC_VOLATILE | \
@@ -343,15 +398,21 @@ struct drm_i915_gem_object {
 #define I915_BO_PROTECTED         BIT(9)
 #define I915_BO_WAS_BOUND_BIT     10
 	/**
-	 * @mem_flags - Mutable placement-related flags
+	 * @mem_flags: Mutable placement-related flags
 	 *
 	 * These are flags that indicate specifics of the memory region
 	 * the object is currently in. As such they are only stable
 	 * either under the object lock or if the object is pinned.
+	 * There are two flags:
+	 *
+	 * %I915_BO_FLAG_STRUCT_PAGE:
+	 *	 Object backed by struct pages
+	 * %I915_BO_FLAG_IOMEM:
+	 *	Object backed by IO memory
 	 */
 	unsigned int mem_flags;
-#define I915_BO_FLAG_STRUCT_PAGE BIT(0) /* Object backed by struct pages */
-#define I915_BO_FLAG_IOMEM       BIT(1) /* Object backed by IO memory */
+#define I915_BO_FLAG_STRUCT_PAGE BIT(0)
+#define I915_BO_FLAG_IOMEM       BIT(1)
 	/**
 	 * @cache_level: The desired GTT caching level.
 	 *
@@ -400,7 +461,7 @@ struct drm_i915_gem_object {
 	 *
 	 * Supported values:
 	 *
-	 * I915_BO_CACHE_COHERENT_FOR_READ:
+	 * %I915_BO_CACHE_COHERENT_FOR_READ:
 	 *
 	 * On shared LLC platforms, we use this for special scanout surfaces,
 	 * where the display engine is not coherent with the CPU cache. As such
@@ -423,7 +484,7 @@ struct drm_i915_gem_object {
 	 *
 	 *	cache_coherent = 0
 	 *
-	 * I915_BO_CACHE_COHERENT_FOR_WRITE:
+	 * %I915_BO_CACHE_COHERENT_FOR_WRITE:
 	 *
 	 * When writing through the CPU cache, the GPU is still coherent. Note
 	 * that this also implies I915_BO_CACHE_COHERENT_FOR_READ.
@@ -509,23 +570,29 @@ struct drm_i915_gem_object {
 	 */
 	u16 write_domain;
 
+	/** @frontbuffer: pointer to the object's frontbuffer */
 	struct intel_frontbuffer __rcu *frontbuffer;
 
-	/** Current tiling stride for the object, if it's tiled. */
+	/**
+	 * @tiling_and_stride: current tiling stride for the object,
+	 * if it's tiled.
+	 */
 	unsigned int tiling_and_stride;
 #define FENCE_MINIMUM_STRIDE 128 /* See i915_tiling_ok() */
 #define TILING_MASK (FENCE_MINIMUM_STRIDE - 1)
 #define STRIDE_MASK (~TILING_MASK)
 
+	/** @mm: struct containing mm-specific fields */
 	struct {
-		/*
-		 * Protects the pages and their use. Do not use directly, but
-		 * instead go through the pin/unpin interfaces.
+		/**
+		 * @mm.pages_pin_count: protects the pages and their use. Do
+		 * not use directly, but instead go through the pin/unpin
+		 * interfaces.
 		 */
 		atomic_t pages_pin_count;
 
 		/**
-		 * @shrink_pin: Prevents the pages from being made visible to
+		 * @mm.shrink_pin: Prevents the pages from being made visible to
 		 * the shrinker, while the shrink_pin is non-zero. Most users
 		 * should pretty much never have to care about this, outside of
 		 * some special use cases.
@@ -536,7 +603,7 @@ struct drm_i915_gem_object {
 		 * __i915_gem_object_set_pages(). They will then be removed the
 		 * shrinker list once the pages are released.
 		 *
-		 * The @shrink_pin is incremented by calling
+		 * The @mm.shrink_pin is incremented by calling
 		 * i915_gem_object_make_unshrinkable(), which will also remove
 		 * the object from the shrinker list, if the pin count was zero.
 		 *
@@ -548,13 +615,13 @@ struct drm_i915_gem_object {
 		atomic_t shrink_pin;
 
 		/**
-		 * @ttm_shrinkable: True when the object is using shmem pages
+		 * @mm.ttm_shrinkable: True when the object is using shmem pages
 		 * underneath. Protected by the object lock.
 		 */
 		bool ttm_shrinkable;
 
 		/**
-		 * @unknown_state: Indicate that the object is effectively
+		 * @mm.unknown_state: Indicate that the object is effectively
 		 * borked. This is write-once and set if we somehow encounter a
 		 * fatal error when moving/clearing the pages, and we are not
 		 * able to fallback to memcpy/memset, like on small-BAR systems.
@@ -572,94 +639,143 @@ struct drm_i915_gem_object {
 		bool unknown_state;
 
 		/**
-		 * Priority list of potential placements for this object.
+		 * @mm.placements: priority list of potential placements for
+		 * this object.
 		 */
 		struct intel_memory_region **placements;
+		/**
+		 * @mm.n_placements: Size of @mm.placements.
+		 */
 		int n_placements;
 
 		/**
-		 * Memory region for this object.
+		 * @mm.region: memory region for this object.
 		 */
 		struct intel_memory_region *region;
 
 		/**
-		 * Memory manager resource allocated for this object. Only
-		 * needed for the mock region.
+		 * @mm.res: Memory manager resource allocated for this object.
+		 * Only needed for the mock region.
 		 */
 		struct ttm_resource *res;
 
 		/**
-		 * Element within memory_region->objects or region->purgeable
-		 * if the object is marked as DONTNEED. Access is protected by
-		 * region->obj_lock.
+		 * @mm.region_link: element within memory_region->objects or
+		 * ``region->purgeable`` if the object is marked as %DONTNEED.
+		 * Access is protected by ``region->obj_lock``.
 		 */
 		struct list_head region_link;
 
+		/** @mm.rsgt: refcounted sg-tables */
 		struct i915_refct_sgt *rsgt;
+		/** @mm.pages: pages pointer for GGTT entries */
 		struct sg_table *pages;
+		/**
+		 * @mm.mapping: mapped pages of the object into kernel space.
+		 * can be %NULL if unmapped.
+		 */
 		void *mapping;
 
+		/**
+		 * @mm.page_sizes: Page sizes of the pages.
+		 */
 		struct i915_page_sizes page_sizes;
 
+		/* private: used on selftest only */
 		I915_SELFTEST_DECLARE(unsigned int page_mask);
+		/* public: */
 
+		/** @mm.get_page: */
 		struct i915_gem_object_page_iter get_page;
+		/** @mm.get_dma_page: */
 		struct i915_gem_object_page_iter get_dma_page;
 
 		/**
-		 * Element within i915->mm.shrink_list or i915->mm.purge_list,
-		 * locked by i915->mm.obj_lock.
+		 * @mm.link: element within ``i915->mm.shrink_list`` or
+		 * ``i915->mm.purge_list``, locked by ``i915->mm.obj_lock``.
 		 */
 		struct list_head link;
 
 		/**
-		 * Advice: are the backing pages purgeable?
+		 * @mm.madv: Advice: are the backing pages purgeable?
 		 */
 		unsigned int madv:2;
 
 		/**
-		 * This is set if the object has been written to since the
-		 * pages were last acquired.
+		 * @mm.dirty: this is set if the object has been written to
+		 * since the pages were last acquired.
 		 */
 		bool dirty:1;
 	} mm;
 
+	/** @ttm: struct containing TTM specific fields */
 	struct {
+		/** @ttm.cached_io_rsgt: cached refcounted sg-tables */
 		struct i915_refct_sgt *cached_io_rsgt;
+		/** @ttm.get_io_page: rbtree iterator to get IO pages */
 		struct i915_gem_object_page_iter get_io_page;
+		/** @ttm.backup: list of LMEM objects backed up at suspend */
 		struct drm_i915_gem_object *backup;
+		/** @ttm.created: indicate that object as created with TTM */
 		bool created:1;
 	} ttm;
 
-	/*
-	 * Record which PXP key instance this object was created against (if
-	 * any), so we can use it to determine if the encryption is valid by
-	 * comparing against the current key instance.
+	/**
+	 * @pxp_key_instance: rRecord which PXP key instance this object was
+	 * created against (if any), so we can use it to determine if the
+	 * encryption is valid by comparing against the current key instance.
 	 */
 	u32 pxp_key_instance;
 
-	/** Record of address bit 17 of each page at last unbind. */
+	/** @bit_17: Record of address bit 17 of each page at last unbind. */
 	unsigned long *bit_17;
 
 	union {
 #ifdef CONFIG_MMU_NOTIFIER
+		/**
+		 * @userptr: Struct which supports userptr data
+		 * Only used when %CONFIG_MMU_NOTIFIER is enabled
+		 */
 		struct i915_gem_userptr {
+			/** @userptr.ptr: pointer to the user-mapped ptr */
 			uintptr_t ptr;
+			/** @userptr.notifier_seq: */
 			unsigned long notifier_seq;
 
+			/** @userptr.notifier: data used by MMU notifier */
 			struct mmu_interval_notifier notifier;
+			/** @userptr.pvec: S/G pages used by userptr */
 			struct page **pvec;
+			/**
+			 * @userptr.page_ref: number of page references
+			 * incremented when pages are in usage.
+			 *
+			 */
 			int page_ref;
 		} userptr;
 #endif
 
+		/**
+		 * @stolen: Used to identify an object allocated from
+		 * stolen memory.
+		 */
 		struct drm_mm_node *stolen;
 
+		/**
+		 * @bo_offset: The range start.
+		 * Used only by TTM.
+		 */
 		resource_size_t bo_offset;
 
+		/** @scratch: physical size of huge gem object */
 		unsigned long scratch;
+		/** @encode: gen8 PDE encode address */
 		u64 encode;
 
+		/**
+		 * @gvt_info: contains a pointer to ``dmabuf_obj->info``
+		 * Used only by gvt.
+		 */
 		void *gvt_info;
 	};
 };
-- 
2.36.1

