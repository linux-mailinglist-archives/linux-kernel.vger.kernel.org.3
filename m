Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7F570BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiGKU1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiGKUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708B7509FF;
        Mon, 11 Jul 2022 13:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16003B8122D;
        Mon, 11 Jul 2022 20:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94604C341EA;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=r3W63NJWrdS0Vy07BtL9oix19YbndHPlmCwb9o4vglU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NdARCe/QsxWvA3TRtTGk58YbkclQO/ywDMeQ/EjhYKu2pGdaIN0sJhO5X3tEs7Pz6
         g52H5FnyHNp9SMWougn6WXlhC9yB5qmRIMq4LT68mzZ2fuEC4itKNB1sufP/7bgres
         9J1EWaQyqw+6kBGjwBKivf/iCGRPA53ZQgH76Omo4J8Ff1Dzic4FkKM23AnPth3lQB
         T1uDpL9Zxcyq9hsAtUOjJ8a6K8H3lrj8DolDLn4uPJrdWdC07fkkqEiLrRtI+9jxtf
         1tY3WjOMDSFHlS+1YmPFWcHjhb564ZX25lZQjalKRRu0zD1IkTwJCYMJzrMc48fMut
         fRKfCkD3UBrXA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e9K-V6;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/32] docs: gpu: i915.rst: GEM/TTM: add more kernel-doc markups
Date:   Mon, 11 Jul 2022 21:25:16 +0100
Message-Id: <692da4d8c56a1ab99c95042e7fc18deeb608c022.1657565224.git.mchehab@kernel.org>
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

There are several documented GEM/TTM kAPI that aren't currently part
of the docs. Add them, as this allows identifying issues with
badly-formatted tags.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

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

