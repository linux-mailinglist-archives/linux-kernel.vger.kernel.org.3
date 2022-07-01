Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD8562FB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiGAJT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiGAJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:19:21 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF351B2B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:19:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VI0Cs3W_1656667156;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VI0Cs3W_1656667156)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 17:19:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: clean up some inconsistent indenting
Date:   Fri,  1 Jul 2022 17:19:14 +0800
Message-Id: <20220701091914.66476-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3151 commit_planes_for_stream() warn: inconsistent indenting

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 146fd4b864b2..d31da9c0256a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3148,15 +3148,15 @@ static void commit_planes_for_stream(struct dc *dc,
 		else
 			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 
-	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
-		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
-			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+		if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+			if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 					top_pipe_to_program->stream_res.tg,
 					CRTC_STATE_VACTIVE);
-			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 					top_pipe_to_program->stream_res.tg,
 					CRTC_STATE_VBLANK);
-			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 					top_pipe_to_program->stream_res.tg,
 					CRTC_STATE_VACTIVE);
 
-- 
2.20.1.7.g153144c

