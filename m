Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49304DDDF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiCRQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiCRQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:10:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9F201AA;
        Fri, 18 Mar 2022 09:08:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u23so8340234ejt.1;
        Fri, 18 Mar 2022 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=F6E4RUrnpJmvXhfhcqyY04JCA7xMBLH8puqhFPnrF8wBOHDnse26GzZ9eXG1yx8/qI
         RX9G1GsnuThqUO+SrkhlaO7uNbMbbqm9vCI6RNwF3B3HmB+c/tO9tgKm9l5UIA2O8xY5
         lVK0BqRCKu1/cEqBjBDFe/EPPUgSVft9bGtArodKm1XO2zhZFWV1LRsKV9cVlMqSAs4i
         sFxaU9EY5kBm3xXvqbHen7QLjHZmHWerXcqaqAeVWxpuNwhawMhDt1xj4yUL5OcD+TaU
         mmqk7z+x1CBbIJNJsEI9LoChrv9mBvpMRmegf+0egVsT0HCgc8RcWGG5+/JjWCNH2CqP
         QOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=wej62SZOBUyPKxOakSB2Ubzug5FN8UMB64rtIPdFMSbN/iUIuY+6YHLn2GrHbuYplJ
         eFdMP2sFhz0YP9FXGXldjOJtuI/u4WE+rau6ebhQBOJPZO9aWLj/ES/GfQqI/3K6cKXi
         jsPjU5fhIi4YcEwicL/LoBBU3U0KnW1pbLjF8U0T4ocTkwF20UI926YRAx+B7UDbALMM
         ahcLB6xFrCuAqhzByMf8dWFf0dldcc9xEg1+VLywogIkm/p1r1OPOK6BJdY7ns3yoI1u
         W2TSo8E6BMnGdzNsQ9lUO37xGHgyTP+0LHKMQbW4sKPLvOZ9VhNQKZoAPfTC1lmpDorO
         nx8w==
X-Gm-Message-State: AOAM531bEPIew0Yv7CwR9Kqnm/SzFuz4AP9UgiBcjvzn1v+WimsLgWyj
        gmE1/18Q65WF7acw2aYp6bk=
X-Google-Smtp-Source: ABdhPJy1F26DEhhuhvt+bv1CovoXSvITpXqmY9HuSFLB3fNtqcm4BAhjdw2XN/nIf3Bm7jI3q7mg8w==
X-Received: by 2002:a17:907:7da6:b0:6db:2e12:b85f with SMTP id oz38-20020a1709077da600b006db2e12b85fmr9140378ejc.312.1647619724841;
        Fri, 18 Mar 2022 09:08:44 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:44 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 15/16] ARM: dts: qcom: qcom-ipq8064: add missing krait-cc compatible and clocks
Date:   Fri, 18 Mar 2022 17:08:26 +0100
Message-Id: <20220318160827.8860-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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
of gcc PXO_SRC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..888f17d64283 100644
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
@@ -782,11 +790,21 @@ tcsr: syscon@1a400000 {
 		l2cc: clock-controller@2011000 {
 			compatible = "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
-			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
 			clock-output-names = "acpu_l2_aux";
 		};
 
+		kraitcc: clock-controller {
+			compatible = "qcom,krait-cc-v1";
+			clocks = <&gcc PLL9>, <&gcc PLL10>, <&gcc PLL12>,
+				 <&acc0>, <&acc1>, <&l2cc>, <&qsb>;
+			clock-names = "hfpll0", "hfpll1", "hfpll_l2",
+				      "acpu0_aux", "acpu1_aux", "acpu_l2_aux",
+				      "qsb";
+			#clock-cells = <1>;
+		};
+
 		lcc: clock-controller@28000000 {
 			compatible = "qcom,lcc-ipq8064";
 			reg = <0x28000000 0x1000>;
-- 
2.34.1

