Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523E54C564C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiBZNxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiBZNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83A6C91D;
        Sat, 26 Feb 2022 05:52:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m3so11076442eda.10;
        Sat, 26 Feb 2022 05:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jMmhdiGgNn0d8zIhQoWuEDweFSRHdxUP3PBi3zJ4pjo=;
        b=qKRa0hV+IOQ1qUW4fSQDtvhQyBJdcVqM6kBRbyp+DstcqMFAHhH9v1OrEryKyS6qgX
         HDwyejaFZ1K/g0hPDLY6Ph3PA8WWsRnQL4f7uV3kT1VmRYW4NLGWSqhM1hmAc5O4LzST
         8+DYDphnuaTRVAhWjFuu/vW80llhY4iKn+IGzoD6HZOcRl163is3pIGvU2XkI1BbHM6v
         QluJoUFNGoyHxmrKV1l72XD2yam7F8014BYBHeX6ivCkLBfa3yu7VDwGPYs1FVLgnlox
         g2WSxgmpf83QosOzGfdY5kiFXWzlBvfx5cMv130WJFDBax6mWne/x+jiwOGV15YVnDiV
         1UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMmhdiGgNn0d8zIhQoWuEDweFSRHdxUP3PBi3zJ4pjo=;
        b=knWeRkD5IDP3exF8RG80gaj+SvI+7266zsggO7YlyitfcBxo0zeJHXp6LHB/11JKLf
         Da810smCdjFuSTuy8Z3kogLqE9/ss5gpZ+zwsH9jm7yaF3rDdQAch4zHqNKIdG9dujzE
         C9jc5Dx3XyUfFjkaMynvq8HAjq5dDjPk6JRdfpkUNccur8n45w+hS60kNGk/Aw9TsJja
         53BsPZQCX+ErrjDyhxZL8vPePJx5fcUF2l0dahzFq0cdBdnaCqMvfu6ER6GP9LYIbOk4
         HFQqsRihdLsDh3IKDJj1SrRfJCofdUK+e07Qcz8AGEtIuMWAT6QQzF5BmnTlR8SJYKSG
         w07w==
X-Gm-Message-State: AOAM533mB7IXI8ZKF6ACSPQtYkKyk8Cw975ucJKBe4dT3LqOmmGdQyb0
        XHckWDL1WEmTG8tTvefZRPni8n0zVdM=
X-Google-Smtp-Source: ABdhPJy925aSG7qGOkUT1G1wsoekuKm6COWsbqHxSoknNP/YoOW6ze+iQbyTviNUs/Nk1b4F9H0euA==
X-Received: by 2002:aa7:c703:0:b0:410:b96a:6bf with SMTP id i3-20020aa7c703000000b00410b96a06bfmr11363029edq.439.1645883566642;
        Sat, 26 Feb 2022 05:52:46 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:46 -0800 (PST)
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
Subject: [PATCH v6 07/15] clk: qcom: gcc-ipq806x: add additional freq nss cores
Date:   Sat, 26 Feb 2022 14:52:27 +0100
Message-Id: <20220226135235.10051-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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

Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
clocked to 800MHz. Add these missing freq to the gcc driver.
Set the freq_tbl for the ubi32_cores to the correct values based on the
machine compatible.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index ef285d3853aa..f49fc8b753a8 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -232,7 +232,9 @@ static struct clk_regmap pll14_vote = {
 
 static struct pll_freq_tbl pll18_freq_tbl[] = {
 	NSS_PLL_RATE(550000000, 44, 0, 1, 0x01495625),
+	NSS_PLL_RATE(600000000, 48, 0, 1, 0x01495625),
 	NSS_PLL_RATE(733000000, 58, 16, 25, 0x014b5625),
+	NSS_PLL_RATE(800000000, 64, 0, 1, 0x01495625),
 };
 
 static struct clk_pll pll18 = {
@@ -2698,7 +2700,7 @@ static struct clk_branch nss_tcm_clk = {
 	},
 };
 
-static const struct freq_tbl clk_tbl_nss[] = {
+static const struct freq_tbl clk_tbl_nss_ipq8064[] = {
 	{ 110000000, P_PLL18, 1, 1, 5 },
 	{ 275000000, P_PLL18, 2, 0, 0 },
 	{ 550000000, P_PLL18, 1, 0, 0 },
@@ -2706,6 +2708,14 @@ static const struct freq_tbl clk_tbl_nss[] = {
 	{ }
 };
 
+static const struct freq_tbl clk_tbl_nss_ipq8065[] = {
+	{ 110000000, P_PLL18, 1, 1, 5 },
+	{ 275000000, P_PLL18, 2, 0, 0 },
+	{ 600000000, P_PLL18, 1, 0, 0 },
+	{ 800000000, P_PLL18, 1, 0, 0 },
+	{ }
+};
+
 static struct clk_dyn_rcg ubi32_core1_src_clk = {
 	.ns_reg[0] = 0x3d2c,
 	.ns_reg[1] = 0x3d30,
@@ -2745,7 +2755,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
 		.pre_div_width = 2,
 	},
 	.mux_sel_bit = 0,
-	.freq_tbl = clk_tbl_nss,
+	/* nss freq table is selected based on the SoC compatible */
 	.clkr = {
 		.enable_reg = 0x3d20,
 		.enable_mask = BIT(1),
@@ -2798,7 +2808,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 		.pre_div_width = 2,
 	},
 	.mux_sel_bit = 0,
-	.freq_tbl = clk_tbl_nss,
+	/* nss freq table is selected based on the SoC compatible */
 	.clkr = {
 		.enable_reg = 0x3d40,
 		.enable_mask = BIT(1),
@@ -3131,6 +3141,14 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_machine_is_compatible("qcom,ipq8065")) {
+		ubi32_core1_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
+		ubi32_core2_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
+	} else {
+		ubi32_core1_src_clk.freq_tbl = clk_tbl_nss_ipq8064;
+		ubi32_core2_src_clk.freq_tbl = clk_tbl_nss_ipq8064;
+	}
+
 	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
 	if (ret)
 		return ret;
-- 
2.34.1

