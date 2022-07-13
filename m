Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB7A573071
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiGMINp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiGMIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB7EEA143;
        Wed, 13 Jul 2022 01:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CED5E61A51;
        Wed, 13 Jul 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508C2C36AEC;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=NGoFV+XEZz1AEK80xsrPTYnST06m5w8suHzIjN1TXLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbUrNe6uWcxuzBp+/Z4L0Q8+2yXsy+bgXUTT5LfdHo7xYiuUPk2y3DOWfPoSEYgPe
         obNgdcxxmFAqqs14rJfc0LXc4VnCtb9kl1Y4p/tFGktP00AHWF58lrMKs0axc9AiDM
         t2FimThIjjrc7qjzljsR0LhHhUOK/QM6u8PlIcZNx3xngD+nOLHYlQyIIihmEj3Thu
         CbjEaQkoXziFLZphz13iWRWEF1rKSnIXCsR3EqkoMG8vvmsEHwc4LcMZNv0co4R4Ey
         NcANxAh2btb+kJT2VgTBHJauOeqAakwxbTe3GGL+vHnciPPhr1l2SEnWN8hs5b3ToC
         hsnUbaZ9rZwNQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zuH-U6;
        Wed, 13 Jul 2022 09:12:29 +0100
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
Subject: [PATCH v2 30/39] docs: gpu: i915.rst: gt: add more kernel-doc markups
Date:   Wed, 13 Jul 2022 09:12:18 +0100
Message-Id: <d7d1f6d6516eb3a82041af1d5f40c2f550de40db.1657699522.git.mchehab@kernel.org>
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

There are several documented GT kAPI that aren't currently part
of the docs. Add them, as this allows identifying issues with
badly-formatted tags.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

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

