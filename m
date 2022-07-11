Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8066570B70
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiGKU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGKUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E633424
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33162B81211
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B213C341CE;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=iPo5yEgWndhfMQR64zKLfth2omME0GYPHNfw6ZASCpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4whE9rwW4KXNlMHWzbc7yx6XzNTYs9ra7km0iqGCLFDSLSmTni+LfhcvLghZeXyo
         cfLGuGuLp8khxdX4eYIE/2X/pDzsup0ditp5lTcwMkCfKbSm5LV6bawjEYAvHr34ui
         /jVq5+jx2ky7bEWrHOCnVtcX7zF8l4om6DPr7iH0bvI5oFiTEDympLGL/aAtjaY1jY
         sWOkkCmowZ8nVUVlsmsg0BKU6Wp+hkQE2zzBlKtFz1Eci8I0QJ45ucMzN8WLseNgZw
         aWTIf+VCcDacRzHJZnWbCP9C6T3JEYLudQ7VbBG9OVbKyE0JCnf5Jga06VDVK5i5PU
         WqGCMrIJ2kJeg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e8k-PG;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/32] drm/i915: i915_vma_resource.c: fix some kernel-doc markups
Date:   Mon, 11 Jul 2022 21:25:07 +0100
Message-Id: <7d31d5221e03c875f3b366e320355faaf98a10a4.1657565224.git.mchehab@kernel.org>
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

Building docs currently produces two warnings:

    Documentation/foo/i915:71: ./drivers/gpu/drm/i915/i915_vma_resource.c:286: WARNING: Inline strong start-string without end-string.
    Documentation/foo/i915:71: ./drivers/gpu/drm/i915/i915_vma_resource.c:370: WARNING: Inline strong start-string without end-string.

That's because @foo evaluates into **foo**, and placing anything
after it without spaces cause Sphinx to warn and do the wrong
thing.. So, replace them by a different Sphinx-compatible tag.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

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

