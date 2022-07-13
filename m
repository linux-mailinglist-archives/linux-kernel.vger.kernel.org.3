Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094857302F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiGMIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiGMIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51881E95F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9332619E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD50C341C8;
        Wed, 13 Jul 2022 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=M8Aa96Z3HuGE4hJ6GD7jHYRvms6KfUwfd7nos1sx0tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6VEr4Q9rLLmnWv89SYL91H13x3eIp0Shr8pK4yxK2eotosElh53kXaT+gkQEXr4P
         fjGFifbVlOcu5x5y+eZir6/ONoU+TfC5Y/0w8AUl1/npE6/PpyPjR5uwqPaLDIC60P
         zXwUeIEAUn8fuB4GLKvIy8PPB0k4ooveJuMNQQFk9mepNiiHqNVtuCJftQdPFjzzrt
         2sII0ES3ywuu2FOjtxLllsoByPdG3X48xRiBv7e6xOXFobULtK3jjNSV2s16G8tABB
         IQkDCydA4Xb0BWlreGGF0lCBSdKN5HupxDxX0Y+R9oEUEC3SsBoJuY1GxB490ZhICr
         xrIs+Bl7Wy+3g==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zt2-HM;
        Wed, 13 Jul 2022 09:12:29 +0100
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
Subject: [PATCH v2 11/39] drm/i915: i915_gem_ttm_pm.c: fix kernel-doc markups
Date:   Wed, 13 Jul 2022 09:11:59 +0100
Message-Id: <d3c6c2b3afa1baa8061489d8d4cd358b251fd30e.1657699522.git.mchehab@kernel.org>
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
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
index 9aad84059d56..9843831c9b37 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
@@ -123,8 +123,9 @@ void i915_ttm_recover_region(struct intel_memory_region *mr)
 /**
  * i915_ttm_backup_region - Back up all objects of a region to smem.
  * @mr: The memory region
- * @allow_gpu: Whether to allow the gpu blitter for this backup.
- * @backup_pinned: Backup also pinned objects.
+ * @flags: Bitmap field with the following flags:
+ *	%I915_TTM_BACKUP_ALLOW_GPU: allow the gpu blitter for this backup;
+ *	%I915_TTM_BACKUP_PINNED: backup also pinned objects.
  *
  * Loops over all objects of a region and either evicts them if they are
  * evictable or backs them up using a backup object if they are pinned.
@@ -188,7 +189,8 @@ static int i915_ttm_restore(struct i915_gem_apply_to_region *apply,
 /**
  * i915_ttm_restore_region - Restore backed-up objects of a region from smem.
  * @mr: The memory region
- * @allow_gpu: Whether to allow the gpu blitter to recover.
+ * @flags: Bitmap field with the following flags:
+ *	%I915_TTM_BACKUP_ALLOW_GPU: allow the gpu blitter for this backup;
  *
  * Loops over all objects of a region and if they are backed-up, restores
  * them from smem.
-- 
2.36.1

