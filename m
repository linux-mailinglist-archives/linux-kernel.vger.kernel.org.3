Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD35730AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiGMIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiGMIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DBFEA163
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 101DDB81D6D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB5EC36AF6;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=cek8uuJCsBV9acCHN6Py4rPGTwRaYdkk3T9/tHIBSPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3/I4po2XZFKDYXmAwUF7rpr4fWvqBpcWvvmCcYQJ3UD7WVeBM/Vmtc4THACX0n4a
         T3B/Oase/GG28x4wmKNEttXdZdrAxWd3amGxpOqh+rWET93h9r8aWICwmL0q42PGPj
         lfuSzFhwgzo+UX6m8V/m3vFwRuEFVEL8G+KCzyLtz2Ew1NIVXRhHrdGiL4VC6LBA3P
         FvD0M9GKD7ctbEF7N0DyJ9peyImvcVmrkbhBuqXwdzmx8uySnLGwNZ1vY4BlUl03Wl
         4Ga4S4ja1029U7I2XfhOc8/rLIH5DrjO41zx5cni5fm2B9WkJFsaNBhiMsTFbxRYNN
         c/oVYaLtki7DA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTy-004zud-1u;
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
Subject: [PATCH v2 36/39] drm/i915 i915_gem_object_types.h: document struct i915_lut_handle
Date:   Wed, 13 Jul 2022 09:12:24 +0100
Message-Id: <6bdbfc5a739deceba57175269cc8e129ca481ed9.1657699522.git.mchehab@kernel.org>
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

commit d1b48c1e7184 ("drm/i915: Replace execbuf vma ht with an idr")
added a rbtree list to allow searching for obj/ctx.

Document it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_object_types.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index 5cf36a130061..ceed0d220ce3 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -21,9 +21,15 @@ struct drm_i915_gem_object;
 struct intel_fronbuffer;
 struct intel_memory_region;
 
-/*
- * struct i915_lut_handle tracks the fast lookups from handle to vma used
- * for execbuf. Although we use a radixtree for that mapping, in order to
+/**
+ * struct i915_lut_handle - tracks the fast lookups from handle to vma used
+ * for execbuf.
+ *
+ * @obj_link: link to the object associated with the @handle.
+ * @ctx: context associated with the @handle.
+ * @handle: a rbtree handle to lookup context for specific obj/vma.
+ *
+ * Although we use a radixtree for that mapping, in order to
  * remove them as the object or context is closed, we need a secondary list
  * and a translation entry (i915_lut_handle).
  */
-- 
2.36.1

