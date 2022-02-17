Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46B4BADAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiBQX7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:59:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiBQX7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:59:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9435C2D1EA;
        Thu, 17 Feb 2022 15:59:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso5190820wmj.2;
        Thu, 17 Feb 2022 15:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PFiamB+cQuNEgEgXc6/10rnSWlRi//qQSXDSvXdnqAc=;
        b=ho6SgGCoEgJu+iPaF2fCNtdUrhIzB5uVrqyl9XJicxf8Mhgo1yCZ46rX3HfZ9yOgFR
         r7OCozkdPw/BCRBHh9ZuO0y0pwbXHlTT3pEU6Alfo9jogLecbEqPoiMYpk9vJVMDTbqL
         ++exPUpfnuwPfJS6mPT/+uMINI0zDU7frLoevW5ZTlBGGErSgb+FD2xiVTmmtSjOaPtz
         DcBG5knS2HnZoBheuvp8NH6qQOTLNUEtToN7nM5dAba8Ax7zPmP9PikfliueQ2ucTJj8
         P6dZXrGyrpFj6WAeym75jFhDS0mL+NMCLBILcH8UVq1EBlAS1/hhaQOFfJoAjmDCizMQ
         4UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFiamB+cQuNEgEgXc6/10rnSWlRi//qQSXDSvXdnqAc=;
        b=lgU8/F2tAP2rBi+1byZZK2jR0/z98itKr0by4rYnwdFu7uCdcA/EUUjmBcMk0yNtkO
         641ojx8QDniz6MKgEorEwiOaN0eule/gLBsVRxc8RGzOuzBTDRCaSoT/GBuf+QzYe+EL
         89x6dzoN/uTyi3PyVGtAKLOrGR52629rcxTCdlwlv8VLpWM2W+9TQCml0azJgmklm+lB
         HZLKgVQVoPg86Ko6OyUpfOvqrJqDragNL5wtHXGQrN18BwiKF3uSb3yipHHnWxSwdAor
         qIPa9RjyaatGz1jYoTqpww2+onifj0vaReuqSRO5DkpI8VU5beJMvuuVHC71OTJlc8rS
         ZjIA==
X-Gm-Message-State: AOAM533rhCO35mg9/mGddThcb5ROOu98svJacNDEE+Puza4IdCOkGRwX
        bFdLs+ipqV/bCCrTmrR8+PQ=
X-Google-Smtp-Source: ABdhPJxuXPGS4hJI4sRtS9hGAP7ZhWuE5bRs1Rg+VYCkmRtbj/crMfMw+G09dA8DhtZmunKSUnVYbA==
X-Received: by 2002:a05:600c:3ba0:b0:37b:b86a:5d30 with SMTP id n32-20020a05600c3ba000b0037bb86a5d30mr8091645wms.136.1645142237518;
        Thu, 17 Feb 2022 15:57:17 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:17 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/16] clk: qcom: gcc-ipq806x: add CryptoEngine clocks
Date:   Fri, 18 Feb 2022 00:57:00 +0100
Message-Id: <20220217235703.26641-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing CryptoEngine clocks and pll11 required clock.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 244 +++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 0912abc3af32..e2b310fbc7c0 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -256,6 +256,24 @@ static struct clk_pll pll18 = {
 	},
 };
 
+static struct clk_pll pll11 = {
+	.l_reg = 0x3184,
+	.m_reg = 0x3188,
+	.n_reg = 0x318c,
+	.config_reg = 0x3194,
+	.mode_reg = 0x3180,
+	.status_reg = 0x3198,
+	.status_bit = 16,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pll11",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "pxo",
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_ops,
+	},
+};
+
 enum {
 	P_PXO,
 	P_PLL8,
@@ -264,6 +282,7 @@ enum {
 	P_CXO,
 	P_PLL14,
 	P_PLL18,
+	P_PLL11,
 };
 
 static const struct parent_map gcc_pxo_pll8_map[] = {
@@ -331,6 +350,44 @@ static const struct clk_parent_data gcc_pxo_pll8_pll14_pll18_pll0[] = {
 	{ .hw = &pll18.clkr.hw },
 };
 
+static const struct parent_map gcc_pxo_pll8_pll0_pll14_pll18_pll11_map[] = {
+	{ P_PXO, 0 },
+	{ P_PLL8, 4 },
+	{ P_PLL0, 2 },
+	{ P_PLL14, 5 },
+	{ P_PLL18, 1 },
+	{ P_PLL11, 3 },
+};
+
+static const struct clk_parent_data gcc_pxo_pll8_pll0_pll14_pll18_pll11[] = {
+	{ .fw_name = "pxo" },
+	{ .hw = &pll8_vote.hw },
+	{ .hw = &pll0_vote.hw },
+	{ .hw = &pll14.clkr.hw },
+	{ .hw = &pll18.clkr.hw },
+	{ .hw = &pll11.clkr.hw },
+
+};
+
+static const struct parent_map gcc_pxo_pll3_pll0_pll14_pll18_pll11_map[] = {
+	{ P_PXO, 0 },
+	{ P_PLL3, 6 },
+	{ P_PLL0, 2 },
+	{ P_PLL14, 5 },
+	{ P_PLL18, 1 },
+	{ P_PLL11, 3 },
+};
+
+static const struct clk_parent_data gcc_pxo_pll3_pll0_pll14_pll18_pll11[] = {
+	{ .fw_name = "pxo" },
+	{ .hw = &pll3.clkr.hw },
+	{ .hw = &pll0_vote.hw },
+	{ .hw = &pll14.clkr.hw },
+	{ .hw = &pll18.clkr.hw },
+	{ .hw = &pll11.clkr.hw },
+
+};
+
 static struct freq_tbl clk_tbl_gsbi_uart[] = {
 	{  1843200, P_PLL8, 2,  6, 625 },
 	{  3686400, P_PLL8, 2, 12, 625 },
@@ -2818,6 +2875,186 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 	},
 };
 
+static const struct freq_tbl clk_tbl_ce5_core[] = {
+	{ 150000000, P_PLL3, 8, 1, 1 },
+	{ 213200000, P_PLL11, 5, 1, 1 },
+	{ }
+};
+
+static struct clk_dyn_rcg ce5_core_src = {
+	.ns_reg[0] = 0x36C4,
+	.ns_reg[1] = 0x36C8,
+	.bank_reg = 0x36C0,
+	.s[0] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll3_pll0_pll14_pll18_pll11_map,
+	},
+	.s[1] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll3_pll0_pll14_pll18_pll11_map,
+	},
+	.p[0] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.p[1] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.mux_sel_bit = 0,
+	.freq_tbl = clk_tbl_ce5_core,
+	.clkr = {
+		.enable_reg = 0x36C0,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_core_src",
+			.parent_data = gcc_pxo_pll3_pll0_pll14_pll18_pll11,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3_pll0_pll14_pll18_pll11),
+			.ops = &clk_dyn_rcg_ops,
+		},
+	},
+};
+
+static struct clk_branch ce5_core_clk = {
+	.halt_reg = 0x2FDC,
+	.halt_bit = 5,
+	.hwcg_reg = 0x36CC,
+	.hwcg_bit = 6,
+	.clkr = {
+		.enable_reg = 0x36CC,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_core_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&ce5_core_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static const struct freq_tbl clk_tbl_ce5_a_clk[] = {
+	{ 160000000, P_PLL0, 5, 1, 1 },
+	{ 213200000, P_PLL11, 5, 1, 1 },
+	{ }
+};
+
+static struct clk_dyn_rcg ce5_a_clk_src = {
+	.ns_reg[0] = 0x3d84,
+	.ns_reg[1] = 0x3d88,
+	.bank_reg = 0x3d80,
+	.s[0] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll8_pll0_pll14_pll18_pll11_map,
+	},
+	.s[1] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll8_pll0_pll14_pll18_pll11_map,
+	},
+	.p[0] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.p[1] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.mux_sel_bit = 0,
+	.freq_tbl = clk_tbl_ce5_a_clk,
+	.clkr = {
+		.enable_reg = 0x3d80,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_a_clk_src",
+			.parent_data = gcc_pxo_pll8_pll0_pll14_pll18_pll11,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0_pll14_pll18_pll11),
+			.ops = &clk_dyn_rcg_ops,
+		},
+	},
+};
+
+static struct clk_branch ce5_a_clk = {
+	.halt_reg = 0x3c20,
+	.halt_bit = 12,
+	.hwcg_reg = 0x3d8c,
+	.hwcg_bit = 6,
+	.clkr = {
+		.enable_reg = 0x3d8c,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_a_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&ce5_a_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static const struct freq_tbl clk_tbl_ce5_h_clk[] = {
+	{ 160000000, P_PLL0, 5, 1, 1 },
+	{ 213200000, P_PLL11, 5, 1, 1 },
+	{ }
+};
+
+static struct clk_dyn_rcg ce5_h_clk_src = {
+	.ns_reg[0] = 0x3c64,
+	.ns_reg[1] = 0x3c68,
+	.bank_reg = 0x3c60,
+	.s[0] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll8_pll0_pll14_pll18_pll11_map,
+	},
+	.s[1] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll8_pll0_pll14_pll18_pll11_map,
+	},
+	.p[0] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.p[1] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.mux_sel_bit = 0,
+	.freq_tbl = clk_tbl_ce5_h_clk,
+	.clkr = {
+		.enable_reg = 0x3c60,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_h_clk_src",
+			.parent_data = gcc_pxo_pll8_pll0_pll14_pll18_pll11,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0_pll14_pll18_pll11),
+			.ops = &clk_dyn_rcg_ops,
+		},
+	},
+};
+
+static struct clk_branch ce5_h_clk = {
+	.halt_reg = 0x3c20,
+	.halt_bit = 11,
+	.hwcg_reg = 0x3c6c,
+	.hwcg_bit = 6,
+	.clkr = {
+		.enable_reg = 0x3c6c,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_h_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&ce5_h_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
 static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[PLL0] = &pll0.clkr,
 	[PLL0_VOTE] = &pll0_vote,
@@ -2825,6 +3062,7 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[PLL4_VOTE] = &pll4_vote,
 	[PLL8] = &pll8.clkr,
 	[PLL8_VOTE] = &pll8_vote,
+	[PLL11] = &pll11.clkr,
 	[PLL14] = &pll14.clkr,
 	[PLL14_VOTE] = &pll14_vote,
 	[PLL18] = &pll18.clkr,
@@ -2939,6 +3177,12 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[PLL9] = &hfpll0.clkr,
 	[PLL10] = &hfpll1.clkr,
 	[PLL12] = &hfpll_l2.clkr,
+	[CE5_A_CLK_SRC] = &ce5_a_clk_src.clkr,
+	[CE5_A_CLK] = &ce5_a_clk.clkr,
+	[CE5_H_CLK_SRC] = &ce5_h_clk_src.clkr,
+	[CE5_H_CLK] = &ce5_h_clk.clkr,
+	[CE5_CORE_CLK_SRC] = &ce5_core_src.clkr,
+	[CE5_CORE_CLK] = &ce5_core_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq806x_resets[] = {
-- 
2.34.1

