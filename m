Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EA059E6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbiHWQMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244207AbiHWQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:12:14 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA11101D1B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:32:06 -0700 (PDT)
X-QQ-mid: bizesmtp72t1661257477tdz1ih66
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:24:35 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: QityeSR92A3zzuGSIzJAtcdxbIqL34B1PehVthBKRy5VFFSs1nL1t8s0bbUJX
        Yj9cRUAKJ++nuEdSE+zGOySzq1CIBygZ7M7n/P0G6aoBPxdv/7niZjdKF8DjSQH/5Kp7U4y
        cLI8exuULS+NAv8sUnmC9/qI4x7qrjhgkM5b2ZLAM+4M8MY2r3JvShfhIRzGnFj8IpQaqsX
        GpyVoCowXeNFt8VPXKtH2WzZ/B57Er4gJ7yVdcfXWWKYmi4eUEZgZ2U7j0i5WCzINTZbHDJ
        qI9tFz+oxO8ufl6+6o5ASUnLCzSevLNTRnteFMJapsxvPUPlZV9yLdxa6mZVKeC//FEk7wc
        PvkdXc2/0KSWYPp+e4tZWfPqYPbV0jN/fvgirFX1Tzh9M5eE0Gc64Q/bJfjOoME2MwwNmGt
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/gma500: fix repeated words in comments
Date:   Tue, 23 Aug 2022 20:24:27 +0800
Message-Id: <20220823122427.18762-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'the'.
 Delete the redundant word 'for'.
 Delete the redundant word 'really'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c  | 2 +-
 drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 9ee99a7d4fbe..a286861ffa3f 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -114,7 +114,7 @@ i2c_algo_dp_aux_stop(struct i2c_adapter *adapter, bool reading)
 
 /*
  * Write a single byte to the current I2C address, the
- * the I2C link must be running or this returns -EIO
+ * I2C link must be running or this returns -EIO
  */
 static int
 i2c_algo_dp_aux_put_byte(struct i2c_adapter *adapter, u8 byte)
diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 22398d34853a..407ce948bf68 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -309,7 +309,7 @@ static void oaktrail_crtc_dpms(struct drm_crtc *crtc, int mode)
 						   temp & ~PIPEACONF_ENABLE, i);
 				REG_READ_WITH_AUX(map->conf, i);
 			}
-			/* Wait for for the pipe disable to take effect. */
+			/* Wait for the pipe disable to take effect. */
 			gma_wait_for_vblank(dev);
 
 			temp = REG_READ_WITH_AUX(map->dpll, i);
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index b5946a1cdcd5..6b6f2e162ebd 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -225,7 +225,7 @@ static void scu_busy_loop(void __iomem *scu_base)
 }
 
 /*
- *	You don't want to know, you really really don't want to know....
+ *	You don't want to know, you really don't want to know....
  *
  *	This is magic. However it's safe magic because of the way the platform
  *	works and it is necessary magic.
-- 
2.36.1

