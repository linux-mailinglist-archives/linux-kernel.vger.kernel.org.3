Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB05909F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiHLBjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiHLBjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:39:21 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E094EF3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:39:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VM.f8BQ_1660268355;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VM.f8BQ_1660268355)
          by smtp.aliyun-inc.com;
          Fri, 12 Aug 2022 09:39:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     daniel@ffwll.ch
Cc:     airlied@linux.ie, Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        sunpeng.li@amd.com, harry.wentland@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/4] drm/amd/display: clean up one inconsistent indenting
Date:   Fri, 12 Aug 2022 09:39:10 +0800
Message-Id: <20220812013912.70000-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220812013912.70000-1-yang.lee@linux.alibaba.com>
References: <20220812013912.70000-1-yang.lee@linux.alibaba.com>
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

1. The indentation of statements in the same curly bracket should be
consistent.
2. Variable declarations in the same function should be aligned.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1887
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1888
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1889
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c    | 13 ++++++++-----
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c  |  6 +++---
 .../display/dc/dml/dcn32/display_mode_vba_util_32.c |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 3316c4a64901..a8539922715e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2135,13 +2135,16 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 
 			if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
 				if (bb_info.dram_clock_change_latency_100ns > 0)
-					dcn3_2_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
+					dcn3_2_soc.dram_clock_change_latency_us =
+						bb_info.dram_clock_change_latency_100ns * 10;
 
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dcn3_2_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
+				if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+					dcn3_2_soc.sr_enter_plus_exit_time_us =
+						bb_info.dram_sr_enter_exit_latency_100ns * 10;
 
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dcn3_2_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
+				if (bb_info.dram_sr_exit_latency_100ns > 0)
+					dcn3_2_soc.sr_exit_time_us =
+						bb_info.dram_sr_exit_latency_100ns * 10;
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index cb2025771646..6a4f730419c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -677,9 +677,9 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				dml_ceil((double) v->WritebackDelay[mode_lib->vba.VoltageLevel][k]
 				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]), 1));
 
-	// Clamp to max OTG vstartup register limit
-	if (v->MaxVStartupLines[k] > 1023)
-		v->MaxVStartupLines[k] = 1023;
+		// Clamp to max OTG vstartup register limit
+		if (v->MaxVStartupLines[k] > 1023)
+			v->MaxVStartupLines[k] = 1023;
 
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: k=%d MaxVStartupLines = %d\n", __func__, k, v->MaxVStartupLines[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 05fc14a47fba..3ba76aab0a20 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4277,7 +4277,7 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 	double ActiveClockChangeLatencyHidingY;
 	double ActiveClockChangeLatencyHidingC;
 	double ActiveClockChangeLatencyHiding;
-    double EffectiveDETBufferSizeY;
+	double EffectiveDETBufferSizeY;
 	double     ActiveFCLKChangeLatencyMargin[DC__NUM_DPP__MAX];
 	double     USRRetrainingLatencyMargin[DC__NUM_DPP__MAX];
 	double TotalPixelBW = 0.0;
-- 
2.20.1.7.g153144c

