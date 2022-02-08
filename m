Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB54ACDF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiBHBXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbiBHBXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:23:30 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E59C053987;
        Mon,  7 Feb 2022 17:23:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V3tTUEL_1644283402;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3tTUEL_1644283402)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Feb 2022 09:23:23 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     daniel@ffwll.ch
Cc:     airlied@linux.ie, sean@poorly.run, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/msm/dpu: clean up some inconsistent indenting
Date:   Tue,  8 Feb 2022 09:23:21 +0800
Message-Id: <20220208012321.43587-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:411
_dpu_crtc_blend_setup_mixer() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index e7c9fe1a250f..662b7bc9c219 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -408,7 +408,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	if (ctl->ops.set_active_pipes)
 		ctl->ops.set_active_pipes(ctl, fetch_active);
 
-	 _dpu_crtc_program_lm_output_roi(crtc);
+	_dpu_crtc_program_lm_output_roi(crtc);
 }
 
 /**
-- 
2.20.1.7.g153144c

