Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC34580DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiGZHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiGZHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:32:03 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47EB29C9C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:27:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKUOHFo_1658820458;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VKUOHFo_1658820458)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:27:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 19/20] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 26 Jul 2022 15:25:54 +0800
Message-Id: <20220726072555.91323-19-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some inconsistent indenting, replace sizeof(x) / sizeof((x)[0]))
with ARRAY_SIZE(x).

smatch warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:185 optc3_fpu_set_vrr_m_const() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:355 dcn30_fpu_set_mcif_arb_params() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:384 dcn30_fpu_calculate_wm_and_dlg() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:390 dcn30_fpu_calculate_wm_and_dlg() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index c00f759fdded..060426916998 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -181,7 +181,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
 		double vtotal_avg)
 {
-struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	double vtotal_min, vtotal_max;
 	double ratio, modulo, phase;
 	uint32_t vblank_start;
@@ -350,24 +350,24 @@ void dcn30_fpu_set_mcif_arb_params(struct mcif_arb_params *wb_arb_params,
 	int pipe_cnt,
 	int cur_pipe)
 {
-    int i;
+	int i;
 
 	dc_assert_fp_enabled();
 
-    for (i = 0; i < sizeof(wb_arb_params->cli_watermark)/sizeof(wb_arb_params->cli_watermark[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(wb_arb_params->cli_watermark); i++) {
 		wb_arb_params->cli_watermark[i] = get_wm_writeback_urgent(dml, pipes, pipe_cnt) * 1000;
 		wb_arb_params->pstate_watermark[i] = get_wm_writeback_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
-    }
+	}
 
-    wb_arb_params->dram_speed_change_duration = dml->vba.WritebackAllowDRAMClockChangeEndPosition[cur_pipe] * pipes[0].clks_cfg.refclk_mhz; /* num_clock_cycles = us * MHz */
+	wb_arb_params->dram_speed_change_duration = dml->vba.WritebackAllowDRAMClockChangeEndPosition[cur_pipe] * pipes[0].clks_cfg.refclk_mhz; /* num_clock_cycles = us * MHz */
 }
 
 void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 {
 
-dc_assert_fp_enabled();
+	dc_assert_fp_enabled();
 
-if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
@@ -380,12 +380,12 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		int pipe_cnt,
 		int vlevel)
 {
-int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
+	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 	int i, pipe_idx;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][maxMpcComb];
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
 
-dc_assert_fp_enabled();
+	dc_assert_fp_enabled();
 
 	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
 		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
-- 
2.20.1.7.g153144c

