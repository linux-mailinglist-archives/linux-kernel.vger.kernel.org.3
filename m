Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB85730AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiGMIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiGMIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC57FE95F6;
        Wed, 13 Jul 2022 01:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F07261A9D;
        Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBA8C36AF8;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=a3vP6iHzNOJCMwtaBN14hmMw2q8S+uzTNcEZhZf06hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UURe8/YXGfu2jqEBiwyn+AYexKbfLR5d2PncI/GYyBrZ6e8WtzIOerkTBqUmhIv9A
         V3CSLNC6DtjIZtvCb9GhVSxyKtwoOng05GfczPis02qGmY5sHlPll7pEhYvC2Q7P0t
         MUiugafiUUPQ9H2j1aCenP1Abw/HVR0Um7H9jesBsMdi/yJN5tEHf57mE9akKhpn52
         E4IiyL2qOlJ/hhSxZSeqweFhxEYaEpDQXUcWTkbhvJQe/qARc7j1NeAa7IVAdS34g5
         48DfFNaH1nd5Lh+xheaMarhJZIW76zaf9svvARLfzliAPIdbHC98b4aRMthS72EG5Q
         cDFG4nj1KCG0Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTy-004zun-3W;
        Wed, 13 Jul 2022 09:12:30 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/39] drm/i915: add descriptions for some RPM macros at intel_gt_pm.h
Date:   Wed, 13 Jul 2022 09:12:26 +0100
Message-Id: <37e3b9aac85f1d08c0a53bae86680d504308bf67.1657699522.git.mchehab@kernel.org>
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

The intel_gt_pm.h file contains some convenient macros to be used
in GT code in order to get/put runtime PM references and for
checking them.

Add descriptions based on the ones at intel_wakeref.h and
intel_runtime_pm.c.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst            |  2 +
 drivers/gpu/drm/i915/gt/intel_gt_pm.h | 62 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 6bb50edc6d79..9862d504df4d 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -709,6 +709,8 @@ Table Manager (TTM)
 
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
 
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_gt_pm.h
+
 Graphics Execution Manager (GEM)
 --------------------------------
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.h b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
index bc898df7a48c..a8ea6846980a 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
@@ -11,21 +11,57 @@
 #include "intel_gt_types.h"
 #include "intel_wakeref.h"
 
+/**
+ * intel_gt_pm_is_awake: Query whether the runtime PM is awake held
+ *
+ * @gt: pointer to the graphics engine
+ *
+ * Returns: true if a runtime pm reference is currently held and the GT is
+ * awake.
+ */
 static inline bool intel_gt_pm_is_awake(const struct intel_gt *gt)
 {
 	return intel_wakeref_is_active(&gt->wakeref);
 }
 
+/**
+ * intel_gt_pm_get: grab a runtime PM reference ensuring that GT is powered up
+ * @gt: pointer to the graphics engine
+ *
+ * Any runtime pm reference obtained by this function must have a symmetric
+ * call to intel_gt_pm_put() to release the reference again.
+ *
+ * Note that this is allowed to fail, in which case the runtime-pm wakeref
+ * will be released and the acquisition unwound.
+ */
 static inline void intel_gt_pm_get(struct intel_gt *gt)
 {
 	intel_wakeref_get(&gt->wakeref);
 }
 
+/**
+ * __intel_gt_pm_get: Acquire the runtime PM reference again
+ * @gt: pointer to the graphics engine which contains the wakeref
+ *
+ * Increment the PM reference counter, only valid if it is already held by
+ * the caller.
+ *
+ * See intel_gt_pm_get().
+ */
 static inline void __intel_gt_pm_get(struct intel_gt *gt)
 {
 	__intel_wakeref_get(&gt->wakeref);
 }
 
+/**
+ * intel_gt_pm_get_if_awake: Acquire the runtime PM reference if active
+ * @gt: pointer to the graphics engine which contains the PM reference
+ *
+ * Acquire a hold on the PM reference, but only if the GT is already
+ * active.
+ *
+ * Returns: true if the wakeref was acquired, false otherwise.
+ */
 static inline bool intel_gt_pm_get_if_awake(struct intel_gt *gt)
 {
 	return intel_wakeref_get_if_active(&gt->wakeref);
@@ -36,6 +72,14 @@ static inline void intel_gt_pm_might_get(struct intel_gt *gt)
 	intel_wakeref_might_get(&gt->wakeref);
 }
 
+/**
+ * intel_gt_pm_put: Release the runtime PM reference
+ * @gt: pointer to the graphics engine which contains the PM reference
+ *
+ * Release our hold on the runtime PM for GT.
+ *
+ * It might power down the GT right away if this is the last reference.
+ */
 static inline void intel_gt_pm_put(struct intel_gt *gt)
 {
 	intel_wakeref_put(&gt->wakeref);
@@ -51,10 +95,28 @@ static inline void intel_gt_pm_might_put(struct intel_gt *gt)
 	intel_wakeref_might_put(&gt->wakeref);
 }
 
+/**
+ * with_intel_gt_pm - get a GT reference ensuring that GT is powered up,
+ *	run some code and then put the reference away.
+ *
+ * @gt: pointer to the gt
+ * @tmp: pointer to a temporary wakeref.
+ */
 #define with_intel_gt_pm(gt, tmp) \
 	for (tmp = 1, intel_gt_pm_get(gt); tmp; \
 	     intel_gt_pm_put(gt), tmp = 0)
 
+/**
+ * intel_gt_pm_wait_for_idle: Wait until the runtime PM reference is idle
+ * @gt: pointer to the graphics engine which contains the PM reference
+ *
+ * Wait for the earlier asynchronous release of the runtime PM reference. Note
+ * this will wait for any third party as well, so make sure you only wait
+ * when you have control over the GT runtime PM and trust no one else is
+ * acquiring it.
+ *
+ * Return: 0 on success, error code if killed.
+ */
 static inline int intel_gt_pm_wait_for_idle(struct intel_gt *gt)
 {
 	return intel_wakeref_wait_for_idle(&gt->wakeref);
-- 
2.36.1

