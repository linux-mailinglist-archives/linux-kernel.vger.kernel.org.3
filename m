Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7EC52FBE3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiEULZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355041AbiEULOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:14:08 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0E013326D;
        Sat, 21 May 2022 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Md9/6NzAv0jrHFbIgTAsd+38B+aN7Go6jo2y146vOSs=;
  b=nEkZMStRD5LCP/VtnJZ2rb7SbzoSoQmd6Y7PlbrHS+OlZZVHojupzuFz
   wOJVUYAhRgiCdK5R0aiA9Sd5V9CdCvgiG97CfVa0Vy7lKiwrgN7152Nui
   2oq2VhsyrUmBopkMe4/ki4O4qkCTRa2rN1aX8HQNyyqXmnh/yttadOjeD
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727998"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:08 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: fix typos in comments
Date:   Sat, 21 May 2022 13:11:40 +0200
Message-Id: <20220521111145.81697-90-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/i915/display/intel_color.c           |    2 +-
 drivers/gpu/drm/i915/display/intel_pps.c             |    2 +-
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c           |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 34128c9c635c..a27ce874a9e8 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -1638,7 +1638,7 @@ static u32 icl_gamma_mode(const struct intel_crtc_state *crtc_state)
 	/*
 	 * Enable 10bit gamma for D13
 	 * ToDo: Extend to Logarithmic Gamma once the new UAPI
-	 * is acccepted and implemented by a userspace consumer
+	 * is accepted and implemented by a userspace consumer
 	 */
 	else if (DISPLAY_VER(i915) >= 13)
 		gamma_mode |= GAMMA_MODE_MODE_10BIT;
diff --git a/drivers/gpu/drm/i915/display/intel_pps.c b/drivers/gpu/drm/i915/display/intel_pps.c
index 5a598dd06039..4bc0563dde92 100644
--- a/drivers/gpu/drm/i915/display/intel_pps.c
+++ b/drivers/gpu/drm/i915/display/intel_pps.c
@@ -509,7 +509,7 @@ static void wait_panel_power_cycle(struct intel_dp *intel_dp)
 
 	drm_dbg_kms(&i915->drm, "Wait for panel power cycle\n");
 
-	/* take the difference of currrent time and panel power off time
+	/* take the difference of current time and panel power off time
 	 * and then make panel wait for t11_t12 if needed. */
 	panel_power_on_time = ktime_get_boottime();
 	panel_power_off_duration = ktime_ms_delta(panel_power_on_time, intel_dp->pps.panel_power_off_time);
diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 86f7a9ac1c39..aa0d2bbbbcc4 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -1350,7 +1350,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 			 * submission. If we don't cancel the timer now,
 			 * we will see that the timer has expired and
 			 * reschedule the tasklet; continually until the
-			 * next context switch or other preeemption event.
+			 * next context switch or other preemption event.
 			 *
 			 * Since we have decided to reschedule based on
 			 * consumption of this timeslice, if we submit the
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
index 78d2989fe917..02311ad90264 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
@@ -588,7 +588,7 @@ int intel_guc_log_relay_open(struct intel_guc_log *log)
 	/*
 	 * We require SSE 4.1 for fast reads from the GuC log buffer and
 	 * it should be present on the chipsets supporting GuC based
-	 * submisssions.
+	 * submissions.
 	 */
 	if (!i915_has_memcpy_from_wc()) {
 		ret = -ENXIO;

