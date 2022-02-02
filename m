Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98E4A7804
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbiBBSfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:35:51 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:56147 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbiBBSfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:35:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643826950; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2gD4DUYwexPVHFxJ8Ew9p8ZXEtKHbZXhQ8+1Ke4/qeQ=; b=Romcs3Ux1RY5F1nVjfpwMWx9xHdYGRVcecv7I9QsbLZYm5V01YIVg/AIRkbuwD/Z2zelXoNp
 ekb8KHB9f29vSESI4xiVk3WmBHjxoPrNjeYWV1lMWapLzI0Ky/k0KXE9HVJts7Qa3NtmgCQZ
 hnRqAKbl1QtP6Q81qq4YTA1vvAw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61facf06d9f69c7276937981 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Feb 2022 18:35:50
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07D3DC43616; Wed,  2 Feb 2022 18:35:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 585A9C4360C;
        Wed,  2 Feb 2022 18:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 585A9C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 2/4] clk: qcom: sc7280: Update clk_init_data to const for CAMCC
Date:   Thu,  3 Feb 2022 00:05:26 +0530
Message-Id: <20220202183528.3911-2-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220202183528.3911-1-tdas@codeaurora.org>
References: <20220202183528.3911-1-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clk_init_data to const and also use index instead of fw_name for
camera clock controller.

Fixes: 1daec8cfebc28 ("clk: qcom: camcc: Add camera clock controller driver for SC7280")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/camcc-sc7280.c | 252 ++++++++++++++++----------------
 1 file changed, 126 insertions(+), 126 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc7280.c b/drivers/clk/qcom/camcc-sc7280.c
index ec163ea769f5..67bf52daa8a8 100644
--- a/drivers/clk/qcom/camcc-sc7280.c
+++ b/drivers/clk/qcom/camcc-sc7280.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
  */

 #include <linux/clk-provider.h>
@@ -63,10 +63,10 @@ static struct clk_alpha_pll cam_cc_pll0 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll0",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -86,7 +86,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll0_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll0_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll0.clkr.hw,
@@ -109,7 +109,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_odd = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll0_out_odd),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll0_out_odd",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll0.clkr.hw,
@@ -138,10 +138,10 @@ static struct clk_alpha_pll cam_cc_pll1 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll1",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -161,7 +161,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll1_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll1_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll1_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll1.clkr.hw,
@@ -188,10 +188,10 @@ static struct clk_alpha_pll cam_cc_pll2 = {
 	.num_vco = ARRAY_SIZE(zonda_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll2",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_zonda_ops,
@@ -211,7 +211,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll2_out_aux = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll2_out_aux),
 	.width = 2,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll2_out_aux",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll2.clkr.hw,
@@ -234,7 +234,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll2_out_aux2 = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll2_out_aux2),
 	.width = 2,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll2_out_aux2",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll2.clkr.hw,
@@ -263,10 +263,10 @@ static struct clk_alpha_pll cam_cc_pll3 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll3",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -286,7 +286,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll3_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll3_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll3_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll3.clkr.hw,
@@ -315,10 +315,10 @@ static struct clk_alpha_pll cam_cc_pll4 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll4",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -338,7 +338,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll4_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll4_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll4_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll4.clkr.hw,
@@ -367,10 +367,10 @@ static struct clk_alpha_pll cam_cc_pll5 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll5",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -390,7 +390,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll5_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll5_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll5_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll5.clkr.hw,
@@ -419,10 +419,10 @@ static struct clk_alpha_pll cam_cc_pll6 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll6",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -442,7 +442,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll6_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll6_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll6_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll6.clkr.hw,
@@ -465,7 +465,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll6_out_odd = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll6_out_odd),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll6_out_odd",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll6.clkr.hw,
@@ -485,7 +485,7 @@ static const struct parent_map cam_cc_parent_map_0[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll0.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_even.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_odd.clkr.hw },
@@ -502,7 +502,7 @@ static const struct parent_map cam_cc_parent_map_1[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_1[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll0.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_even.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_odd.clkr.hw },
@@ -517,7 +517,7 @@ static const struct parent_map cam_cc_parent_map_2[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_2[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll2_out_aux2.clkr.hw },
 	{ .hw = &cam_cc_pll2.clkr.hw },
 };
@@ -532,7 +532,7 @@ static const struct parent_map cam_cc_parent_map_3[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_3[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll0.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_even.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_odd.clkr.hw },
@@ -546,7 +546,7 @@ static const struct parent_map cam_cc_parent_map_4[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_4[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll3_out_even.clkr.hw },
 };

@@ -556,7 +556,7 @@ static const struct parent_map cam_cc_parent_map_5[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_5[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll4_out_even.clkr.hw },
 };

@@ -566,7 +566,7 @@ static const struct parent_map cam_cc_parent_map_6[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_6[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll5_out_even.clkr.hw },
 };

@@ -576,7 +576,7 @@ static const struct parent_map cam_cc_parent_map_7[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_7[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll1_out_even.clkr.hw },
 };

@@ -585,7 +585,7 @@ static const struct parent_map cam_cc_parent_map_8[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_8[] = {
-	{ .fw_name = "sleep_clk" },
+	{ .index = 2 },
 };

 static const struct parent_map cam_cc_parent_map_9[] = {
@@ -593,7 +593,7 @@ static const struct parent_map cam_cc_parent_map_9[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_9_ao[] = {
-	{ .fw_name = "bi_tcxo_ao" },
+	{ .index = 1 },
 };

 static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
@@ -612,7 +612,7 @@ static struct clk_rcg2 cam_cc_bps_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_bps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_bps_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -636,7 +636,7 @@ static struct clk_rcg2 cam_cc_camnoc_axi_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_camnoc_axi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_camnoc_axi_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
@@ -656,7 +656,7 @@ static struct clk_rcg2 cam_cc_cci_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_cci_0_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -670,7 +670,7 @@ static struct clk_rcg2 cam_cc_cci_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_cci_1_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -691,7 +691,7 @@ static struct clk_rcg2 cam_cc_cphy_rx_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_cphy_rx_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_cphy_rx_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -711,7 +711,7 @@ static struct clk_rcg2 cam_cc_csi0phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi0phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -725,7 +725,7 @@ static struct clk_rcg2 cam_cc_csi1phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi1phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -739,7 +739,7 @@ static struct clk_rcg2 cam_cc_csi2phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi2phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -753,7 +753,7 @@ static struct clk_rcg2 cam_cc_csi3phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi3phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -767,7 +767,7 @@ static struct clk_rcg2 cam_cc_csi4phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi4phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -791,7 +791,7 @@ static struct clk_rcg2 cam_cc_fast_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_fast_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_fast_ahb_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -813,7 +813,7 @@ static struct clk_rcg2 cam_cc_icp_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_icp_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_icp_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -836,7 +836,7 @@ static struct clk_rcg2 cam_cc_ife_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_4,
 	.freq_tbl = ftbl_cam_cc_ife_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_0_clk_src",
 		.parent_data = cam_cc_parent_data_4,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_4),
@@ -860,7 +860,7 @@ static struct clk_rcg2 cam_cc_ife_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_5,
 	.freq_tbl = ftbl_cam_cc_ife_1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_1_clk_src",
 		.parent_data = cam_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_5),
@@ -883,7 +883,7 @@ static struct clk_rcg2 cam_cc_ife_0_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_0_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -897,7 +897,7 @@ static struct clk_rcg2 cam_cc_ife_1_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_1_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -920,7 +920,7 @@ static struct clk_rcg2 cam_cc_ife_2_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_6,
 	.freq_tbl = ftbl_cam_cc_ife_2_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_2_clk_src",
 		.parent_data = cam_cc_parent_data_6,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_6),
@@ -935,7 +935,7 @@ static struct clk_rcg2 cam_cc_ife_2_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_2_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -958,7 +958,7 @@ static struct clk_rcg2 cam_cc_ife_lite_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_ife_lite_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_lite_0_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
@@ -972,7 +972,7 @@ static struct clk_rcg2 cam_cc_ife_lite_0_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_lite_0_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -986,7 +986,7 @@ static struct clk_rcg2 cam_cc_ife_lite_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_ife_lite_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_lite_1_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
@@ -1000,7 +1000,7 @@ static struct clk_rcg2 cam_cc_ife_lite_1_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_lite_1_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -1023,7 +1023,7 @@ static struct clk_rcg2 cam_cc_ipe_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_7,
 	.freq_tbl = ftbl_cam_cc_ipe_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ipe_0_clk_src",
 		.parent_data = cam_cc_parent_data_7,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_7),
@@ -1038,7 +1038,7 @@ static struct clk_rcg2 cam_cc_jpeg_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_bps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_jpeg_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -1062,7 +1062,7 @@ static struct clk_rcg2 cam_cc_lrme_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_lrme_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_lrme_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
@@ -1083,7 +1083,7 @@ static struct clk_rcg2 cam_cc_mclk0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk0_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1097,7 +1097,7 @@ static struct clk_rcg2 cam_cc_mclk1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk1_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1111,7 +1111,7 @@ static struct clk_rcg2 cam_cc_mclk2_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk2_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1125,7 +1125,7 @@ static struct clk_rcg2 cam_cc_mclk3_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk3_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1139,7 +1139,7 @@ static struct clk_rcg2 cam_cc_mclk4_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk4_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1153,7 +1153,7 @@ static struct clk_rcg2 cam_cc_mclk5_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk5_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1172,7 +1172,7 @@ static struct clk_rcg2 cam_cc_sleep_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_8,
 	.freq_tbl = ftbl_cam_cc_sleep_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_sleep_clk_src",
 		.parent_data = cam_cc_parent_data_8,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_8),
@@ -1192,7 +1192,7 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_slow_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_slow_ahb_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -1211,7 +1211,7 @@ static struct clk_rcg2 cam_cc_xo_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_9,
 	.freq_tbl = ftbl_cam_cc_xo_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_xo_clk_src",
 		.parent_data = cam_cc_parent_data_9_ao,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_9_ao),
@@ -1225,7 +1225,7 @@ static struct clk_branch cam_cc_bps_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x7070,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_bps_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -1243,7 +1243,7 @@ static struct clk_branch cam_cc_bps_areg_clk = {
 	.clkr = {
 		.enable_reg = 0x7054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_bps_areg_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_fast_ahb_clk_src.clkr.hw,
@@ -1261,7 +1261,7 @@ static struct clk_branch cam_cc_bps_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x7038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_bps_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1279,7 +1279,7 @@ static struct clk_branch cam_cc_bps_clk = {
 	.clkr = {
 		.enable_reg = 0x7028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_bps_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_bps_clk_src.clkr.hw,
@@ -1297,7 +1297,7 @@ static struct clk_branch cam_cc_camnoc_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xc140,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_camnoc_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1315,7 +1315,7 @@ static struct clk_branch cam_cc_camnoc_dcd_xo_clk = {
 	.clkr = {
 		.enable_reg = 0xc148,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_camnoc_dcd_xo_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_xo_clk_src.clkr.hw,
@@ -1333,7 +1333,7 @@ static struct clk_branch cam_cc_cci_0_clk = {
 	.clkr = {
 		.enable_reg = 0xc0f8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_cci_0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cci_0_clk_src.clkr.hw,
@@ -1351,7 +1351,7 @@ static struct clk_branch cam_cc_cci_1_clk = {
 	.clkr = {
 		.enable_reg = 0xc114,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_cci_1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cci_1_clk_src.clkr.hw,
@@ -1369,7 +1369,7 @@ static struct clk_branch cam_cc_core_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0xc1a0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_core_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -1387,7 +1387,7 @@ static struct clk_branch cam_cc_cpas_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0xc11c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_cpas_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -1405,7 +1405,7 @@ static struct clk_branch cam_cc_csi0phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe0c4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi0phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi0phytimer_clk_src.clkr.hw,
@@ -1423,7 +1423,7 @@ static struct clk_branch cam_cc_csi1phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe0e8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi1phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi1phytimer_clk_src.clkr.hw,
@@ -1441,7 +1441,7 @@ static struct clk_branch cam_cc_csi2phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe10c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi2phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi2phytimer_clk_src.clkr.hw,
@@ -1459,7 +1459,7 @@ static struct clk_branch cam_cc_csi3phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe134,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi3phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi3phytimer_clk_src.clkr.hw,
@@ -1477,7 +1477,7 @@ static struct clk_branch cam_cc_csi4phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe158,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi4phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi4phytimer_clk_src.clkr.hw,
@@ -1495,7 +1495,7 @@ static struct clk_branch cam_cc_csiphy0_clk = {
 	.clkr = {
 		.enable_reg = 0xe0c8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1513,7 +1513,7 @@ static struct clk_branch cam_cc_csiphy1_clk = {
 	.clkr = {
 		.enable_reg = 0xe0ec,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1531,7 +1531,7 @@ static struct clk_branch cam_cc_csiphy2_clk = {
 	.clkr = {
 		.enable_reg = 0xe110,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy2_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1549,7 +1549,7 @@ static struct clk_branch cam_cc_csiphy3_clk = {
 	.clkr = {
 		.enable_reg = 0xe138,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy3_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1567,7 +1567,7 @@ static struct clk_branch cam_cc_csiphy4_clk = {
 	.clkr = {
 		.enable_reg = 0xe15c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy4_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1585,7 +1585,7 @@ static struct clk_branch cam_cc_gdsc_clk = {
 	.clkr = {
 		.enable_reg = 0xc1bc,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_gdsc_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_xo_clk_src.clkr.hw,
@@ -1603,7 +1603,7 @@ static struct clk_branch cam_cc_icp_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0xc0d8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_icp_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -1621,7 +1621,7 @@ static struct clk_branch cam_cc_icp_clk = {
 	.clkr = {
 		.enable_reg = 0xc0d0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_icp_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_icp_clk_src.clkr.hw,
@@ -1639,7 +1639,7 @@ static struct clk_branch cam_cc_ife_0_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xa080,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1657,7 +1657,7 @@ static struct clk_branch cam_cc_ife_0_clk = {
 	.clkr = {
 		.enable_reg = 0xa028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_0_clk_src.clkr.hw,
@@ -1675,7 +1675,7 @@ static struct clk_branch cam_cc_ife_0_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xa07c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1693,7 +1693,7 @@ static struct clk_branch cam_cc_ife_0_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xa054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_0_csid_clk_src.clkr.hw,
@@ -1711,7 +1711,7 @@ static struct clk_branch cam_cc_ife_0_dsp_clk = {
 	.clkr = {
 		.enable_reg = 0xa038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_dsp_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_0_clk_src.clkr.hw,
@@ -1729,7 +1729,7 @@ static struct clk_branch cam_cc_ife_1_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb068,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1747,7 +1747,7 @@ static struct clk_branch cam_cc_ife_1_clk = {
 	.clkr = {
 		.enable_reg = 0xb028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_1_clk_src.clkr.hw,
@@ -1765,7 +1765,7 @@ static struct clk_branch cam_cc_ife_1_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xb064,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1783,7 +1783,7 @@ static struct clk_branch cam_cc_ife_1_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xb054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_1_csid_clk_src.clkr.hw,
@@ -1801,7 +1801,7 @@ static struct clk_branch cam_cc_ife_1_dsp_clk = {
 	.clkr = {
 		.enable_reg = 0xb038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_dsp_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_1_clk_src.clkr.hw,
@@ -1819,7 +1819,7 @@ static struct clk_branch cam_cc_ife_2_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb0d4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1837,7 +1837,7 @@ static struct clk_branch cam_cc_ife_2_clk = {
 	.clkr = {
 		.enable_reg = 0xb094,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_2_clk_src.clkr.hw,
@@ -1855,7 +1855,7 @@ static struct clk_branch cam_cc_ife_2_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xb0d0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1873,7 +1873,7 @@ static struct clk_branch cam_cc_ife_2_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xb0c0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_2_csid_clk_src.clkr.hw,
@@ -1891,7 +1891,7 @@ static struct clk_branch cam_cc_ife_2_dsp_clk = {
 	.clkr = {
 		.enable_reg = 0xb0a4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_dsp_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_2_clk_src.clkr.hw,
@@ -1909,7 +1909,7 @@ static struct clk_branch cam_cc_ife_lite_0_clk = {
 	.clkr = {
 		.enable_reg = 0xc01c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_lite_0_clk_src.clkr.hw,
@@ -1927,7 +1927,7 @@ static struct clk_branch cam_cc_ife_lite_0_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xc040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_0_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1945,7 +1945,7 @@ static struct clk_branch cam_cc_ife_lite_0_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xc038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_0_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_lite_0_csid_clk_src.clkr.hw,
@@ -1963,7 +1963,7 @@ static struct clk_branch cam_cc_ife_lite_1_clk = {
 	.clkr = {
 		.enable_reg = 0xc060,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_lite_1_clk_src.clkr.hw,
@@ -1981,7 +1981,7 @@ static struct clk_branch cam_cc_ife_lite_1_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xc084,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_1_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1999,7 +1999,7 @@ static struct clk_branch cam_cc_ife_lite_1_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xc07c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_1_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_lite_1_csid_clk_src.clkr.hw,
@@ -2017,7 +2017,7 @@ static struct clk_branch cam_cc_ipe_0_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x8040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ipe_0_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -2035,7 +2035,7 @@ static struct clk_branch cam_cc_ipe_0_areg_clk = {
 	.clkr = {
 		.enable_reg = 0x803c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ipe_0_areg_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_fast_ahb_clk_src.clkr.hw,
@@ -2053,7 +2053,7 @@ static struct clk_branch cam_cc_ipe_0_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x8038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ipe_0_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -2071,7 +2071,7 @@ static struct clk_branch cam_cc_ipe_0_clk = {
 	.clkr = {
 		.enable_reg = 0x8028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ipe_0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ipe_0_clk_src.clkr.hw,
@@ -2089,7 +2089,7 @@ static struct clk_branch cam_cc_jpeg_clk = {
 	.clkr = {
 		.enable_reg = 0xc0a4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_jpeg_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_jpeg_clk_src.clkr.hw,
@@ -2107,7 +2107,7 @@ static struct clk_branch cam_cc_lrme_clk = {
 	.clkr = {
 		.enable_reg = 0xc168,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_lrme_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_lrme_clk_src.clkr.hw,
@@ -2125,7 +2125,7 @@ static struct clk_branch cam_cc_mclk0_clk = {
 	.clkr = {
 		.enable_reg = 0xe018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk0_clk_src.clkr.hw,
@@ -2143,7 +2143,7 @@ static struct clk_branch cam_cc_mclk1_clk = {
 	.clkr = {
 		.enable_reg = 0xe034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk1_clk_src.clkr.hw,
@@ -2161,7 +2161,7 @@ static struct clk_branch cam_cc_mclk2_clk = {
 	.clkr = {
 		.enable_reg = 0xe050,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk2_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk2_clk_src.clkr.hw,
@@ -2179,7 +2179,7 @@ static struct clk_branch cam_cc_mclk3_clk = {
 	.clkr = {
 		.enable_reg = 0xe06c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk3_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk3_clk_src.clkr.hw,
@@ -2197,7 +2197,7 @@ static struct clk_branch cam_cc_mclk4_clk = {
 	.clkr = {
 		.enable_reg = 0xe088,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk4_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk4_clk_src.clkr.hw,
@@ -2215,7 +2215,7 @@ static struct clk_branch cam_cc_mclk5_clk = {
 	.clkr = {
 		.enable_reg = 0xe0a4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk5_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk5_clk_src.clkr.hw,
@@ -2233,7 +2233,7 @@ static struct clk_branch cam_cc_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0xc1d8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_sleep_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_sleep_clk_src.clkr.hw,
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

