Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DC959E6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiHWQMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbiHWQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:11:55 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56483FB0F5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:31:30 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661257699tzwdgpjs
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:28:17 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: DRnj/z+Sqaf2Zp2vGdN0+GAC4bAixq9uAkJsGXqE8c1ZOp77y7v7oefrIZuTT
        NsjlTF26dvCJjpO2u7sSaEfqIxPXG7I0CCqDNpOkhugzrU0zjQN9+5rySP7M8kKr/GvR1fu
        Asq9fJECZUjhW9tz4PKI/AmdszlxMT8YXOwDTH06Pqhiy4xIi+UAoJ177ed2HMXopHFYyg3
        tyn+N4wSGojewCTIzCHoZWRCBznI1dXA2k70um3sOPstl51EhT0LAbybJyrm9OKYkrGD5en
        +9u2GO8Jas8mjUPsBUU/DM3vkvTlG0VGfM0VTt96ge9WkgC0Mr2qUpGk6ulOd0nvFB/HgYt
        JcuKitQqvsC0pw71df5NfupRW6FWLCKmHpJfMDty01zGFb601mnLiV3VKObsgBPD2H/LOYE
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/i915: fix repeated words in comments
Date:   Tue, 23 Aug 2022 20:28:11 +0800
Message-Id: <20220823122811.22525-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'for'.
 Delete the redundant word 'the'.
 Delete the redundant word 'into'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/i915/i915_reg.h          | 2 +-
 drivers/gpu/drm/i915/i915_request.c      | 2 +-
 drivers/gpu/drm/i915/intel_device_info.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 4f5a51bb9e1e..c0c4f4acfbf9 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -2534,7 +2534,7 @@
  * HDMI/DP bits are g4x+
  *
  * WARNING: Bspec for hpd status bits on gen4 seems to be completely confused.
- * Please check the detailed lore in the commit message for for experimental
+ * Please check the detailed lore in the commit message for experimental
  * evidence.
  */
 /* Bspec says GM45 should match G4X/VLV/CHV, but reality disagrees */
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 73d5195146b0..9caf99a13c61 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -1735,7 +1735,7 @@ __i915_request_add_to_timeline(struct i915_request *rq)
 }
 
 /*
- * NB: This function is not allowed to fail. Doing so would mean the the
+ * NB: This function is not allowed to fail. Doing so would mean the
  * request is not being tracked for completion but the work itself is
  * going to happen on the hardware. This would be a Bad Thing(tm).
  */
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index e7d2cf7d65c8..70e092f2b63a 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -253,7 +253,7 @@ struct intel_device_info {
 struct intel_runtime_info {
 	/*
 	 * Platform mask is used for optimizing or-ed IS_PLATFORM calls into
-	 * into single runtime conditionals, and also to provide groundwork
+	 * single runtime conditionals, and also to provide groundwork
 	 * for future per platform, or per SKU build optimizations.
 	 *
 	 * Array can be extended when necessary if the corresponding
-- 
2.36.1

