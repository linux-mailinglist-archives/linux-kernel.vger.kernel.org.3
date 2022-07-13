Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16957306F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiGMINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiGMIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B708EA142;
        Wed, 13 Jul 2022 01:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 035FD61A55;
        Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD21C36AFA;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=HeQqUJvrGcgYZ3zwMqACCOwmFJoNKkacbDuzCb76kf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JU1uPcPoXoaKexY3zQNP7ndYqYVk4nOaRZtPoCbgzOxMncB1AQRgPli10liVuE20i
         OBt3GAmnNTiUarxdWqoJcHeY5MOOlkdoD0PDPtA8c7gwTXZnXM2WlqjpipNwxZ/OiU
         wNfAfvw+VRDwSiB+9jxsFqTMixLIBp0gC6snditMXUQ2QIewFFV8M4Xh9RwgACGFco
         cxW5ZQ1eSfa6hL6p9C681o2udmJFMuRVnvu12duzHIPkV+TN/nzlBb63e1KaXQghvN
         SivMTLFTVpes8tac4T5m3xcpfS+jAblYdzsFUUeMZUROmQIguF9JMW0JsUxJyPA8ii
         +SDvt5GhYU+yw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTy-004zuZ-1E;
        Wed, 13 Jul 2022 09:12:30 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/39] docs: gpu: i915.rst: add the remaining kernel-doc markup files
Date:   Wed, 13 Jul 2022 09:12:23 +0100
Message-Id: <5630ff7f2d5a99fc78b4fc2fa7e63649d23f226c.1657699522.git.mchehab@kernel.org>
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

There are other files with kernel-doc markups:

	$ git grep -l "/\*\*" $(git ls-files|grep drivers/gpu/drm/i915/) >kernel-doc-files
	$ for i in $(cat kernel-doc-files); do if [ "$(git grep $i Documentation/)" == "" ]; then echo "$i"; fi; done >aaa

Add them to i915.rst as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 87 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 974754586be8..6bb50edc6d79 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -13,6 +13,11 @@ Core Driver Infrastructure
 This section covers core driver infrastructure used by both the display
 and the GEM parts of the driver.
 
+Core driver
+-----------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_driver.c
+
 Runtime Power Management
 ------------------------
 
@@ -29,6 +34,10 @@ Runtime Power Management
 
 .. kernel-doc:: drivers/gpu/drm/i915/intel_pm.c
 
+.. kernel-doc:: drivers/gpu/drm/i915/intel_wakeref.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_active.h
+
 Interrupt Handling
 ------------------
 
@@ -44,6 +53,28 @@ Interrupt Handling
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
    :functions: intel_runtime_pm_enable_interrupts
 
+Error handling
+--------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_gpu_error.c
+
+Memory Handling
+---------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_vma_resource.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_vma_resource.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_vma.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_vma.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_mm.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_memory_region.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_memcpy.c
+
 Intel GVT-g Guest Support(vGPU)
 -------------------------------
 
@@ -109,6 +140,54 @@ Workarounds
 .. kernel-doc:: drivers/gpu/drm/i915/gt/intel_workarounds.c
    :doc: Hardware workarounds
 
+32-bits compatible ioctl Logic
+------------------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_ioc32.c
+
+Scatterlist handling
+--------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_scatterlist.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_scatterlist.c
+
+i915 request
+------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_request.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_request.c
+
+Ancillary routines
+------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_deps.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_deps.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_device_info.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_params.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_sw_fence_work.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_syncmap.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_pcode.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_reg_defs.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_wopcm.h
+
+
+PXP
+---
+
+.. kernel-doc:: drivers/gpu/drm/i915/pxp/intel_pxp_irq.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
+
 Display Hardware Handling
 =========================
 
@@ -618,6 +697,12 @@ Protected Objects
 Table Manager (TTM)
 -------------------
 
+.. kernel-doc:: drivers/gpu/drm/i915/i915_ttm_buddy_manager.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_region_ttm.c
+
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm.c
 
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm.h
@@ -627,6 +712,8 @@ Table Manager (TTM)
 Graphics Execution Manager (GEM)
 --------------------------------
 
+.. kernel-doc:: drivers/gpu/drm/i915/i915_gem.c
+
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_create.c
 
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_domain.c
-- 
2.36.1

