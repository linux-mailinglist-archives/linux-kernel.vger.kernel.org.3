Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6959E692
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbiHWQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243857AbiHWQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:04:40 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CEC99250
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:16:25 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661256953tey1azri
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:15:51 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: XBN7tc9DADKOu7nqgEn/xfy1ddb7BNa8BsdiV45GuuyAjUHAfmb3VhwZRoVY6
        PGj/QHiiaJX0zblpPzgPPoVCIfjPDCuT5+5SyPVeqczjxvxlvSg7mmVk8EVLuiIxeaSkQIX
        YtU89wfeK4/D/9jwOWgNA9UZFukNGpJIWb5tx962ANkF+0exmusw8ZfvG57TdRh+Uz4J3JZ
        Hxs8JfKCkzlAUvP1pRDQwSHgw5QtXCRR1xh1sUmECJVlevMdaxnhURSdJvT8YucasJHAGhI
        J+Ix95SaLzIoAeDPUzZJa/zUKRlCFCfyVqeTbY7u/6av/zCE/fmWye68vapIASTi1THtjgk
        DyGt7NHNAujs64dxBzOYY1xvXwkgrk6ablIRkUj7FfJ2wGc5iail7bttd2OulRhikMMhFed
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] gpu/drm: fix repeated words in comments
Date:   Tue, 23 Aug 2022 20:15:44 +0800
Message-Id: <20220823121544.9082-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'old'.
 Delete the redundant word 'new'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/drm_context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
index c6e6a3e7219a..2d871159162b 100644
--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -267,8 +267,8 @@ int drm_legacy_setsareactx(struct drm_device *dev, void *data,
  * Switch context.
  *
  * \param dev DRM device.
- * \param old old context handle.
- * \param new new context handle.
+ * \param old context handle.
+ * \param new context handle.
  * \return zero on success or a negative number on failure.
  *
  * Attempt to set drm_device::context_flag.
@@ -294,7 +294,7 @@ static int drm_context_switch(struct drm_device * dev, int old, int new)
  * Complete context switch.
  *
  * \param dev DRM device.
- * \param new new context handle.
+ * \param new context handle.
  * \return zero on success or a negative number on failure.
  *
  * Updates drm_device::last_context and drm_device::last_switch. Verifies the
-- 
2.36.1

