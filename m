Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296D45B0337
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIGLhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIGLhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:37:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C09510FE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:37:01 -0700 (PDT)
X-QQ-mid: bizesmtp76t1662550611t69rfsxr
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Sep 2022 19:36:50 +0800 (CST)
X-QQ-SSF: 01000000002000D0F000B00A0000000
X-QQ-FEAT: xo0edGM1fUgzs0t7dv5TswAcz+UwGqM28Cv2CGjKh7qwMxoOmvi7Nu37gNRyv
        hBFn91BKRuiCwcoJHqRD6UWoOFVuHypAkfifg37nMxsF4awZjlzUYfjyBGP094dbfcqj8tp
        N5ktFuKUKVL1JmOLebhYUDSmLWmwDVtKuq9lTmWlIZp3qqqhJmtvVKQqj8U/47hbY52R6KA
        Qsz9FxnwuOdZkU+JzVXJ3P3ZSKuEg5y0/xIDH3iS3mhh/eM4zSuRHXdUS89Ao3MM1pf3Mw/
        GHLhJW1+YURQxorDXYQPhWMhID7lsW8PwfPqhXJj65rOpo0O9ldhw0pnFeKb8wAsNYEwvys
        81HiumNLatq2+dWsGF65FmbvM1+9TngB4j9c/YnN3i7fVQZCbgjgolX6JzAFA==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/edid: fix repeated words in comments
Date:   Wed,  7 Sep 2022 19:36:44 +0800
Message-Id: <20220907113644.32831-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'on'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 4005dab6147d..25866b568d6b 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6837,7 +6837,7 @@ drm_hdmi_avi_infoframe_quant_range(struct hdmi_avi_infoframe *frame,
 	 * by non-zero YQ when receiving RGB. There doesn't seem to be any
 	 * good way to tell which version of CEA-861 the sink supports, so
 	 * we limit non-zero YQ to HDMI 2.0 sinks only as HDMI 2.0 is based
-	 * on on CEA-861-F.
+	 * on CEA-861-F.
 	 */
 	if (!is_hdmi2_sink(connector) ||
 	    rgb_quant_range == HDMI_QUANTIZATION_RANGE_LIMITED)
-- 
2.36.1

