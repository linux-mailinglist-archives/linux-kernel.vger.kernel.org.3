Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4534E34BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiCUXry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiCUXrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:47:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C05E543B;
        Mon, 21 Mar 2022 16:45:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t11so22784200wrm.5;
        Mon, 21 Mar 2022 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KntnxEIslcAH3B4iwp3a7mNe3NHTLtligyxMWAIcv1w=;
        b=IatH+BimJzIeGHXk5nktn42eXk06Zme6ZQ8njFt25twK2Gg1kwx1lAhHdNM3LQH7dz
         mQFZo0e2p8BOB18UR7308LKprm543sjagjbNfVa7xolh6snNUJS7NY//vJx717tmKcAO
         VX1AGQLLa5srzJzP1XHx6DSjsWD+wQgpIE2iX5MedLCfH9UIPb4OIpH/PLDjct87tJNi
         o2zMbGQ6yNMMu7NHcxeAZZw7uxBp8rov8RDEIAzgsufcDCL/Vl/3M/Wpml5nkbc4D8UH
         NJTdg9nopJj7yFAZQM/XJHrnGno4rxyv8e89hbblshqp4ETX1p7Fs8BeFV1LfMEliGEe
         c13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KntnxEIslcAH3B4iwp3a7mNe3NHTLtligyxMWAIcv1w=;
        b=qO1XKX3YsMU8G/m8SLjxv2kPcZsPl4c3cZ6yZP+Q2lWj0bxxuEr89Wpu0EOCgKx1R8
         QgHDBNe+CnYbmmllBVaO2RUY0ta0DEDxUp0eA7Y84eEY2ehaCldKJa+wgGlJIJJHbFL3
         0rbp4FcYN4FBpl+0DPLx5SRGLJHuvN3hnw2SLcVBaw3hYlCkZgHyE/h+RQIwv26YrhMW
         RemD3WG9Inot7tTepTMN9nEa5ygQME48FxwIapqqNp/ucpOJT5Z2s64IhXBn4Cp2JV8a
         tjOpIkG8Imn+tTi8Ttw/eJnYLkKXx+XtSQZebwEAO7203POf7V2sgSTDSR1DiUmt1573
         gRRw==
X-Gm-Message-State: AOAM530ob38ojaywrxDW1Kuu0SaDvzOwFfpNy/O++yc4/fRRikWV4YWu
        Ag5uCGAeDqgeQ62B42cY9X4=
X-Google-Smtp-Source: ABdhPJzh7ultj61Cwbg82x0fZ0oejvG8K5EIEbFWAc88D2M17FPNoKw/alaKDcOEFmy0+XhslbGySg==
X-Received: by 2002:a05:6000:1883:b0:1f0:44f6:4bc0 with SMTP id a3-20020a056000188300b001f044f64bc0mr20515015wri.659.1647906331098;
        Mon, 21 Mar 2022 16:45:31 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:30 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 18/18] ARM: dts: qcom: qcom-ipq8064: add missing krait-cc compatible and clocks
Date:   Tue, 22 Mar 2022 00:15:48 +0100
Message-Id: <20220321231548.14276-19-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
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

Add missing krait-cc clock-controller and define missing aux clock for
CPUs. Also change phandle for l2cc node to point to pxo_board instead
of gcc PXO_SRC. This should align ipq8064 dtsi to the new changes in
the Documentation.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..cebb5561f5d1 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -468,11 +468,19 @@ IRQ_TYPE_EDGE_RISING)>,
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu0_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu1_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		adm_dma: dma-controller@18300000 {
@@ -780,11 +788,23 @@ tcsr: syscon@1a400000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
-			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
 			clock-output-names = "acpu_l2_aux";
+			#clock-cells = <0>;
+		};
+
+		kraitcc: clock-controller {
+			compatible = "qcom,krait-cc-v1";
+			clocks = <&gcc PLL9>, <&gcc PLL10>,
+				 <&acc0>, <&acc1>, <&qsb>,
+				 <&gcc PLL12>, <&l2cc>;
+			clock-names = "hfpll0", "hfpll1",
+				      "acpu0_aux", "acpu1_aux", "qsb",
+				      "hfpll_l2", "acpu_l2_aux";
+			#clock-cells = <1>;
 		};
 
 		lcc: clock-controller@28000000 {
-- 
2.34.1

