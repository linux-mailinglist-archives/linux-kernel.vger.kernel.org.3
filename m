Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1572159E69B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbiHWQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiHWQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:05:37 -0400
X-Greylist: delayed 155 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 05:16:46 PDT
Received: from bg2.exmail.qq.com (bg2.exmail.qq.com [114.132.75.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F67B1CB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:16:46 -0700 (PDT)
X-QQ-mid: bizesmtp76t1661256782tgvbn6j0
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:13:01 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: ZpVBcTpAW5OCEhGEBuH7M3/VNPcRmTX6IfPaP249ZQj3I5tEuuRACRGTMqtzN
        ilKst+e8JK5KdlP0hR4J8NNTixqVLdPyk5wB3+1yyY7/jz6/frsyN2uzPxohUjh7Xw/K7Bq
        j53no6+SQosRBxngo63jcZfxc/7V6PQg+v4RK/PT2OXt9HvQn36SED+DH2SIHQt25zT1dg7
        tVXoWWKAN7/HnbZrCNvs1F4dYbUxXqicBZQpdG3IWWuGPFvKGhpLexusDfp13FR421j5b/Z
        I0PUGyRcDxxkY2wyVKZWY6nkC+qtty00mE77baSYB+mqcPiss+xuBN7KneRcCx/X2TycLcj
        YI6gu27DkanXOEBletUR5WBFK7o/ScFQhses/BToq2zwTwMTr+vNcJe7KFzMAF46S5G5A7s
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] gpu/drm: fix repeated words in comments
Date:   Tue, 23 Aug 2022 20:12:54 +0800
Message-Id: <20220823121254.6826-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.
 Delete the redundant word 'on'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/drm_edid.c        | 2 +-
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index bc43e1b32092..71e5b4d805fb 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6023,7 +6023,7 @@ drm_hdmi_avi_infoframe_quant_range(struct hdmi_avi_infoframe *frame,
 	 * by non-zero YQ when receiving RGB. There doesn't seem to be any
 	 * good way to tell which version of CEA-861 the sink supports, so
 	 * we limit non-zero YQ to HDMI 2.0 sinks only as HDMI 2.0 is based
-	 * on on CEA-861-F.
+	 * on CEA-861-F.
 	 */
 	if (!is_hdmi2_sink(connector) ||
 	    rgb_quant_range == HDMI_QUANTIZATION_RANGE_LIMITED)
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 4562a8b86579..1ece22e7b6cb 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -935,7 +935,7 @@ EXPORT_SYMBOL(drm_framebuffer_unregister_private);
  * the id and get back -EINVAL. Obviously no concern at driver unload time.
  *
  * Also, the framebuffer will not be removed from the lookup idr - for
- * user-created framebuffers this will happen in in the rmfb ioctl. For
+ * user-created framebuffers this will happen in the rmfb ioctl. For
  * driver-private objects (e.g. for fbdev) drivers need to explicitly call
  * drm_framebuffer_unregister_private.
  */
-- 
2.36.1

