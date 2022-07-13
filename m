Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56001573072
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiGMIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiGMIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03BEA146
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 176D361A7B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A73C36AE7;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=Bmte6pkPKEOsNY8boMcDubrEjTNZt2JaXVTTSbZp1vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRAFxVOnRlXPyhvhttJc8yyCD+gz9n4bAufpI+FsX0Z/+evuPEghkuADAl0ERbHeU
         MfK5rXkAGFKhJYRZ5GRgY2q+oPPOHgJhsQDppWQyt1f8QtkSzCLYCA0xgA24wHGn/o
         9kEyYUAjv193xtfKwudcZZJE9Wj2RALRKQihqiF0BHHC125YMzgaXkmeEWNzscH2RG
         3QF/djKC3VkrgzMO07yunYgjl/JreVO2Jikg+NnnJW4gy3pabatvtvMloRW6IHKlm9
         UncT1BOaZO/wPE+GIh/qwRLNWEx2P+mx114AODDpYs9eviWwZRA/WtpzpWeY369ZPq
         IO3JEo3qEpIjQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zty-R5;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/39] drm/i915: i915_vma_resource.c: fix some kernel-doc markups
Date:   Wed, 13 Jul 2022 09:12:13 +0100
Message-Id: <a830bd63085178004106069a914e80758e321fcd.1657699522.git.mchehab@kernel.org>
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

Building docs currently produces two warnings:

    Documentation/foo/i915:71: ./drivers/gpu/drm/i915/i915_vma_resource.c:286: WARNING: Inline strong start-string without end-string.
    Documentation/foo/i915:71: ./drivers/gpu/drm/i915/i915_vma_resource.c:370: WARNING: Inline strong start-string without end-string.

That's because @foo evaluates into **foo**, and placing anything
after it without spaces cause Sphinx to warn and do the wrong
thing.. So, replace them by a different Sphinx-compatible tag.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_vma_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
index 27c55027387a..fa5a678018d9 100644
--- a/drivers/gpu/drm/i915/i915_vma_resource.c
+++ b/drivers/gpu/drm/i915/i915_vma_resource.c
@@ -283,7 +283,7 @@ i915_vma_resource_color_adjust_range(struct i915_address_space *vm,
  *
  * The function needs to be called with the vm lock held.
  *
- * Return: Zero on success, -ERESTARTSYS if interrupted and @intr==true
+ * Return: Zero on success, -ERESTARTSYS if interrupted and ``intr==true``
  */
 int i915_vma_resource_bind_dep_sync(struct i915_address_space *vm,
 				    u64 offset,
@@ -367,7 +367,7 @@ void i915_vma_resource_bind_dep_sync_all(struct i915_address_space *vm)
  * this means that during heavy memory pressure, we will sync in this
  * function.
  *
- * Return: Zero on success, -ERESTARTSYS if interrupted and @intr==true
+ * Return: Zero on success, -ERESTARTSYS if interrupted and ``intr==true``
  */
 int i915_vma_resource_bind_dep_await(struct i915_address_space *vm,
 				     struct i915_sw_fence *sw_fence,
-- 
2.36.1

