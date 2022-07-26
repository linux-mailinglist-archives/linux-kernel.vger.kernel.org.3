Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EBA580DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiGZHdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbiGZHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:31:57 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD7628726
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:27:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKUOHEZ_1658820454;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VKUOHEZ_1658820454)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:27:36 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 18/20] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 26 Jul 2022 15:25:53 +0800
Message-Id: <20220726072555.91323-18-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

smatch warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn303/dcn303_fpu.c:205 dcn303_fpu_update_bw_bounding_box() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn303/dcn303_fpu.c:355 dcn303_fpu_init_soc_bounding_box() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../drm/amd/display/dc/dml/dcn303/dcn303_fpu.c    | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
index 8fb14baed208..3eb3a021ab7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
@@ -202,7 +202,7 @@ void dcn303_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 	unsigned int num_dcfclk_sta_targets = 4;
 	unsigned int num_uclk_states;
 
-    dc_assert_fp_enabled();
+	dc_assert_fp_enabled();
 
 	if (dc->ctx->dc_bios->vram_info.num_chans)
 		dcn3_03_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
@@ -349,14 +349,11 @@ void dcn303_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
 	dc_assert_fp_enabled();
 
 	if (bb_info.dram_clock_change_latency_100ns > 0)
-				dcn3_03_soc.dram_clock_change_latency_us =
-					bb_info.dram_clock_change_latency_100ns * 10;
+		dcn3_03_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
 
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dcn3_03_soc.sr_enter_plus_exit_time_us =
-					bb_info.dram_sr_enter_exit_latency_100ns * 10;
+	if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+		dcn3_03_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
 
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dcn3_03_soc.sr_exit_time_us =
-					bb_info.dram_sr_exit_latency_100ns * 10;
+	if (bb_info.dram_sr_exit_latency_100ns > 0)
+		dcn3_03_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
 }
-- 
2.20.1.7.g153144c

