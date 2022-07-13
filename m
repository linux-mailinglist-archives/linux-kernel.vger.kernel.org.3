Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA8573089
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiGMIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiGMIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA2EA15F;
        Wed, 13 Jul 2022 01:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8375B81D67;
        Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E08AC36AFB;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=9vM61Icn6cpMZl0FqNeIaFxyP6yis74ANKS+8wGnBls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFOMdYvM+pXQWzhSLnxONskvZEAU/TOAuLPpUiEoLejlJYxtFWti1GIYftKe/mfSL
         mKjO2r8l8Ty6TSmU21JJkuvMr5+U2VRWS0CAGZn40sWssFGcQtfVNqRGjGiMH/eu6r
         B1r9BjwQx0nreN06mxWBYznS3iReaVyyCauOz8dFUoz/lk8rMVURTlfzJG1vamTSM+
         NxRPeSMSTsCTKiSWHDqECI0xwAj1R1qnDbPg3gFg8RKbGIaU/x2GUnUiXYDiZauN+m
         2bB+EJrVOiRb4oYY51Ev4QyGZjT/zIwCw+s8iArF6gWvq73x+9H75/wxkGWTq69cXd
         SnOj42OG2jvQw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTy-004zuV-0X;
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
Subject: [PATCH v2 34/39] docs: gpu: i915.rst: GEM/TTM: add more kernel-doc markups
Date:   Wed, 13 Jul 2022 09:12:22 +0100
Message-Id: <207b2aa899bbe440a61b5fed5f26d9f78bcd38cb.1657699522.git.mchehab@kernel.org>
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

There are several documented GEM/TTM kAPI that aren't currently part
of the docs. Add them, as this allows identifying issues with
badly-formatted tags.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index c32409c03d32..974754586be8 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -615,6 +615,44 @@ Protected Objects
 
 .. kernel-doc:: drivers/gpu/drm/i915/pxp/intel_pxp_types.h
 
+Table Manager (TTM)
+-------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+
+Graphics Execution Manager (GEM)
+--------------------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_create.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_domain.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_internal.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_lmem.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_mman.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_object.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_object.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_region.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_region.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_wait.c
+
 Microcontrollers
 ================
 
-- 
2.36.1

