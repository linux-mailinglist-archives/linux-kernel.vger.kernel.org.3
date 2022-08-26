Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824EF5A2555
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbiHZKCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbiHZKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:31 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE47B8A48
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id 6860F32383E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508086;
        bh=AQeR8ILdZrHYlixwXWZ9TJtLVXw6lpIE0xrXp5n66VM=;
        h=From:To:Cc:Subject:Date;
        b=Fd8eaBJF1V0wM/i9W5BSk6tWPXYX7/vBcFob1cQDxdPxDyeILGtnzDNfbYASu6S+F
         XanIWqTksxI8k+6rBAQifLJCGMynC+lwi8GAb36oGTxRJQto5FPwZm/PK2DEimB8VX
         lQSSZSixZcpwEozKprAQ3oI8Ve2RkoQv2b0objWw=
Received: from fx405 (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id 0E7E83237D3;
        Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <97fc.630899f2.51286.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx405.security-mail.net (Postfix) with ESMTPS id D36AD3236A2;
        Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 2E25727E0396;
        Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 167C127E0392;
        Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 167C127E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508082;
        bh=7YkIwgTRyznEJf4Uaeh9hIBcIzx+ZpeKjWZoSTHVrrM=;
        h=From:To:Date:Message-Id;
        b=OZgCjUdiOJy7xwK9dfZcA66r9fryRJzHRYJWVZBLjF5lqpqnRMqcUl4mURQCn5/t+
         docm1GxGNGyMTGZiNJiAgw4mKM79GGJw+1VK/cOkfLpzIjAmv5NWZp90+jnX/tyfEa
         B3UH1XdjT2uISvf/REsXGUt8QJtUKNdFuXJg9o0Q=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oyFfAiPO1JCj; Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 023C327E02FA;
        Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:44 +0200
Message-Id: <20220826100052.22945-16-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant words `the` and `this`.

CC: David Airlie <airlied@linux.ie>
CC: Maxime Ripard <mripard@kernel.org>
CC: Thomas Zimmermann <tzimmermann@suse.de>
CC: amd-gfx@lists.freedesktop.org
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h | 2 +-
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h   | 2 +-
 drivers/gpu/drm/display/drm_dp_helper.c                         | 2 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c                  | 2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c                            | 2 +-
 drivers/gpu/drm/i915/i915_irq.c                                 | 2 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c                   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
index 43d43d6addc0..4164da83380f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
@@ -486,7 +486,7 @@ typedef struct {
   uint16_t Tvr_socLimit;            // Celcius
   uint32_t FitLimit;                // Failures in time (failures per million parts over the defined lifetime)
 
-  uint16_t PpmPowerLimit;           // Switch this this power limit when temperature is above PpmTempThreshold
+  uint16_t PpmPowerLimit;           // Switch this power limit when temperature is above PpmTempThreshold
   uint16_t PpmTemperatureThreshold;
 
   // SECTION: Throttler settings
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
index 04752ade1016..ba7c68a20425 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
@@ -544,7 +544,7 @@ typedef struct {
   uint16_t TplxLimit;               // Celcius
   uint32_t FitLimit;                // Failures in time (failures per million parts over the defined lifetime)
 
-  uint16_t PpmPowerLimit;           // Switch this this power limit when temperature is above PpmTempThreshold
+  uint16_t PpmPowerLimit;           // Switch this power limit when temperature is above PpmTempThreshold
   uint16_t PpmTemperatureThreshold;
   
   // SECTION: Throttler settings
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e5bab236b3ae..32b295003f49 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1597,7 +1597,7 @@ static int drm_dp_aux_reply_duration(const struct drm_dp_aux_msg *msg)
 
 /*
  * Calculate the length of the i2c transfer in usec, assuming
- * the i2c bus speed is as specified. Gives the the "worst"
+ * the i2c bus speed is as specified. Gives the "worst"
  * case estimate, ie. successful while as long as possible.
  * Doesn't account the "MOT" bit, and instead assumes each
  * message includes a START, ADDRESS and STOP. Neither does it
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index fc1728d46ac2..dde2f4c4c6cb 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -349,7 +349,7 @@ static const struct dmi_system_id orientation_data[] = {
  * resolution expected by the quirk-table entry.
  *
  * Note this function is also used outside of the drm-subsys, by for example
- * the efifb code. Because of this this function gets compiled into its own
+ * the efifb code. Because of this function gets compiled into its own
  * kernel-module when built as a module.
  *
  * Returns:
diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index d6fe94cd0fdb..7670ae4dd8fa 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -193,7 +193,7 @@ static int populate_shadow_context(struct intel_vgpu_workload *workload)
 			workload->ring_context_gpa);
 
 	/* only need to ensure this context is not pinned/unpinned during the
-	 * period from last submission to this this submission.
+	 * period from last submission to this submission.
 	 * Upon reaching this function, the currently submitted context is not
 	 * supposed to get unpinned. If a misbehaving guest driver ever does
 	 * this, it would corrupt itself.
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 73cebc6aa650..783a6ca41a61 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -65,7 +65,7 @@
 
 /*
  * Interrupt statistic for PMU. Increments the counter only if the
- * interrupt originated from the the GPU so interrupts from a device which
+ * interrupt originated from the GPU so interrupts from a device which
  * shares the interrupt line are not accounted.
  */
 static inline void pmu_irq_stats(struct drm_i915_private *i915,
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index 40ea41b0a5dd..4085822f619a 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -231,7 +231,7 @@ struct nt35510_config {
 	 * bits 0..2 in the lower nibble controls HCK, the booster clock
 	 * frequency, the values are the same as for PCK in @bt1ctr.
 	 * bits 4..5 in the upper nibble controls BTH, the boosting
-	 * amplification for the the step-up circuit.
+	 * amplification for the step-up circuit.
 	 * 0 = AVDD + VDDB
 	 * 1 = AVDD - AVEE
 	 * 2 = AVDD - AVEE + VDDB
-- 
2.17.1

