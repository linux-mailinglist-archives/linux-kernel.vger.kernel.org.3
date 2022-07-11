Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8001E570B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiGKU0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiGKUZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3883E769;
        Mon, 11 Jul 2022 13:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E8B61638;
        Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94337C341E7;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=Tb3n3/77/mwtYV5OZDyxgvvYQBkjH8JCjYZvi9rWx9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jP7DpuRIJz8Fxss/u3G7CD6q/E50x9Rz5zZWBy4PZfPUdbVTGtI7I6nu54fuePZg7
         C5Dj/LESQVwPxC8mrbcw48R5DL776Sw4mBh2DRvLzdthRaMSyr38VykNWRuCwrMPIX
         z4PpVnqGw6RC5CT2zbyj6CdDsz9LojiLMMncQljnFV+uxHmnIGdHiILTPM6Lvo14V3
         ron1Hp0JcdMLYbtxstgvbjijZnDm4m8e8lwaLJM0Rfdoe+apqPbijrrIvfd3q9W0gg
         Ojh+4pfZPYl27c1yM6NkEwvD52faFE1dg+E7mAAOyrMWwsjfTsPiZDXORXPLV+E2g/
         eOPxAURtlab8Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e92-SK;
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
Subject: [PATCH 27/32] docs: gpu: i915.rst: gt: add more kernel-doc markups
Date:   Mon, 11 Jul 2022 21:25:12 +0100
Message-Id: <f72fa9e642123591cf6ef367a3808b30a0951f22.1657565224.git.mchehab@kernel.org>
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

There are several documented GT kAPI that aren't currently part
of the docs. Add them, as this allows identifying issues with
badly-formatted tags.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 43 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 2ad7941a79f2..afd8c0e3c689 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -149,7 +149,6 @@ Misc display functions
 
 .. kernel-doc:: drivers/gpu/drm/i915/display/skl_scaler.c
 
-
 Plane Configuration
 -------------------
 
@@ -308,6 +307,48 @@ Multicast/Replicated (MCR) Registers
 .. kernel-doc:: drivers/gpu/drm/i915/gt/intel_gt_mcr.c
    :internal:
 
+GT engine
+---------
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_engine_types.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_engine_cs.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_engine_pm.c
+
+GT context
+----------
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_context.h
+
+Graphics Translation Tables
+---------------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_ggtt.c
+
+Other GT functionality
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_gsc.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_gtt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_gtt.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_migrate.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_mocs.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_rc6.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_reset.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_rps_types.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_rps.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_sseu.c
+
 Memory Management and Command Submission
 ========================================
 
-- 
2.36.1

