Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30DB4F758E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbiDGGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbiDGGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:02:53 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09672FFDB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:00:53 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 7 Apr 2022
 14:00:52 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 7 Apr
 2022 14:00:51 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Haowen Bai <baihaowen@meizu.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Fix indenting mistakes in dcn10_hw_sequencer.c
Date:   Thu, 7 Apr 2022 14:00:50 +0800
Message-ID: <1649311250-17077-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports the following:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2174
dcn10_enable_vblanks_synchronization() warn: if statement not indented

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index ee22f4422d26..3c338b85040c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2172,13 +2172,13 @@ void dcn10_enable_vblanks_synchronization(
 	if (master >= 0) {
 		for (i = 0; i < group_size; i++) {
 			if (i != master && !grouped_pipes[i]->stream->has_non_synchronizable_pclk)
-			grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
-				grouped_pipes[master]->stream_res.tg,
-				grouped_pipes[i]->stream_res.tg,
-				grouped_pipes[master]->stream->timing.pix_clk_100hz,
-				grouped_pipes[i]->stream->timing.pix_clk_100hz,
-				get_clock_divider(grouped_pipes[master], false),
-				get_clock_divider(grouped_pipes[i], false));
+				grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
+					grouped_pipes[master]->stream_res.tg,
+					grouped_pipes[i]->stream_res.tg,
+					grouped_pipes[master]->stream->timing.pix_clk_100hz,
+					grouped_pipes[i]->stream->timing.pix_clk_100hz,
+					get_clock_divider(grouped_pipes[master], false),
+					get_clock_divider(grouped_pipes[i], false));
 				grouped_pipes[i]->stream->vblank_synchronized = true;
 		}
 		grouped_pipes[master]->stream->vblank_synchronized = true;
-- 
2.7.4

