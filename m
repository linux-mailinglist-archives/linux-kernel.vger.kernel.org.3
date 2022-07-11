Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5844570BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGKU1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiGKUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE051439
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB6F61652
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D49AC385A5;
        Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571125;
        bh=UdbBOFAYSkJ31LJ7NEPV5jkgfH7PpdrewW2qgrHkwbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLMeVYWxALOk8RWwUW5gRt3PP0b62nRZLuSxKIPXqZzUVOUnKhFAvdDnKuEQfEz/r
         j69hS+Z5GWEEzkl/nlNifflKxbYXM/hMOw0pu4KT4XjT1RYn5EDiTWmTkAkUWHf6Et
         PRhTH6Q4y7jdqSQXsbgDXGY0FW5lU8l/ZT2kahZUCRubeqOgdp6yGEdjoQp3m5IJbi
         utfQLWfEAk6L1Ct+rs4UBW0QTiY1pdkuErID8ffN8ejOAnucgW0iUBvpYSeLPgW5aG
         ovD4zNor57X0TN6Wr2vZjoF1tRDEtLae8gtVggIi9KQxK/HcGanmQOvzPpurETLh8V
         vahxDA6QbIBZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e7p-F4;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/32] drm/i915: i915_gem_ttm_pm.c: fix kernel-doc markups
Date:   Mon, 11 Jul 2022 21:24:53 +0100
Message-Id: <5f03e188e48746f86da543b1c983d01fab70e9ef.1657565224.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657565224.git.mchehab@kernel.org>
References: <cover.1657565224.git.mchehab@kernel.org>
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

The documentation for the flags field is missing there. It sounds
that some last-time change converted some bools into flags, but
the kernel-doc change didn't follow it.

Fix those warnings:

	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:135: warning: Function parameter or member 'flags' not described in 'i915_ttm_backup_region'
	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:135: warning: Excess function parameter 'allow_gpu' description in 'i915_ttm_backup_region'
	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:135: warning: Excess function parameter 'backup_pinned' description in 'i915_ttm_backup_region'
	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:199: warning: Function parameter or member 'flags' not described in 'i915_ttm_restore_region'
	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:199: warning: Excess function parameter 'allow_gpu' description in 'i915_ttm_restore_region'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
index 9aad84059d56..1c4b576a2540 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
@@ -123,8 +123,9 @@ void i915_ttm_recover_region(struct intel_memory_region *mr)
 /**
  * i915_ttm_backup_region - Back up all objects of a region to smem.
  * @mr: The memory region
- * @allow_gpu: Whether to allow the gpu blitter for this backup.
- * @backup_pinned: Backup also pinned objects.
+ * @flags: Bitmap field with the following flags:
+ * 	%I915_TTM_BACKUP_ALLOW_GPU: allow the gpu blitter for this backup;
+ * 	%I915_TTM_BACKUP_PINNED: backup also pinned objects.
  *
  * Loops over all objects of a region and either evicts them if they are
  * evictable or backs them up using a backup object if they are pinned.
@@ -188,7 +189,8 @@ static int i915_ttm_restore(struct i915_gem_apply_to_region *apply,
 /**
  * i915_ttm_restore_region - Restore backed-up objects of a region from smem.
  * @mr: The memory region
- * @allow_gpu: Whether to allow the gpu blitter to recover.
+ * @flags: Bitmap field with the following flags:
+ * 	%I915_TTM_BACKUP_ALLOW_GPU: allow the gpu blitter for this backup;
  *
  * Loops over all objects of a region and if they are backed-up, restores
  * them from smem.
-- 
2.36.1

