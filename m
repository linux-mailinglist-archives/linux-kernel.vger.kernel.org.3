Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040024B0C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbiBJLlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:41:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiBJLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:41:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D777101E;
        Thu, 10 Feb 2022 03:41:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2746F61D1F;
        Thu, 10 Feb 2022 11:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C632EC004E1;
        Thu, 10 Feb 2022 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644493275;
        bh=YX1gi59/HZbFW3O0Wnmg+lqGfVhLTyza+iIoN+OkqZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=WdhEQGRtOpRhyZ6JWVwUVoJSQt9Imap+QU8DPJgQYnD4UI6NkPC67iN6XW2w4X4zx
         sRcVtwhOm9l3tiEY6pMPQlccFPEDowvg7IVRhr1hTosIlbhx0RZR6Jc21emXLIX7KY
         XCjFH6rdRXbkuSQVEii+16t3UZk3uWOPbmBz2dcPsjtIwfsa66vLxkxdwvOi8nMCbS
         aN4h77DFeEsc+PMnpyxGgfGQZzAn0a8zKoiJZtrEBK6v8mXBJvShV++3j1pbL2zItX
         6FhW2VjPqdwm2xjlFNP8oPu04Cfn5eT88xdnXL2UynMZ9jwKj69rKFpOQ9cJwKrw9p
         JmVgwIN2YxCBw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Mark Yacoub <markyacoub@google.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/msm/dpu: Remove set but unused variables
Date:   Thu, 10 Feb 2022 17:11:04 +0530
Message-Id: <20220210114106.290669-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get warning:

In function ‘dpu_encoder_virt_enable’: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1145:33:
warning: variable ‘priv’ set but not used [-Wunused-but-set-variable]
 1145 |         struct msm_drm_private *priv;

In function ‘dpu_encoder_virt_disable’: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1182:33:
warning: variable ‘priv’ set but not used [-Wunused-but-set-variable]
 1182 |         struct msm_drm_private *priv;

Remove these unused but set variables

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1e648db439f9..132844801e92 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1142,14 +1142,12 @@ static void dpu_encoder_virt_enable(struct drm_encoder *drm_enc)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	int ret = 0;
-	struct msm_drm_private *priv;
 	struct drm_display_mode *cur_mode = NULL;
 
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
 
 	mutex_lock(&dpu_enc->enc_lock);
 	cur_mode = &dpu_enc->base.crtc->state->adjusted_mode;
-	priv = drm_enc->dev->dev_private;
 
 	trace_dpu_enc_enable(DRMID(drm_enc), cur_mode->hdisplay,
 			     cur_mode->vdisplay);
@@ -1179,7 +1177,6 @@ static void dpu_encoder_virt_enable(struct drm_encoder *drm_enc)
 static void dpu_encoder_virt_disable(struct drm_encoder *drm_enc)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
-	struct msm_drm_private *priv;
 	int i = 0;
 
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
@@ -1188,8 +1185,6 @@ static void dpu_encoder_virt_disable(struct drm_encoder *drm_enc)
 	mutex_lock(&dpu_enc->enc_lock);
 	dpu_enc->enabled = false;
 
-	priv = drm_enc->dev->dev_private;
-
 	trace_dpu_enc_disable(DRMID(drm_enc));
 
 	/* wait for idle */
-- 
2.31.1

