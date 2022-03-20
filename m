Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028BD4E1CD9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245571AbiCTQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245572AbiCTQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75035DD9;
        Sun, 20 Mar 2022 09:28:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j10so4786937wrb.13;
        Sun, 20 Mar 2022 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=Y7BNVTk9cezmPcQXjAAq4bwk2ilXOMmt9Z496mY93lqThWnVj6vnnRNj+OtZGZVivV
         4IQnYi4l2k/trw38zXP/hlrF4rDf8mevN09wTfk6yxoIRb9aRyFhhdLVjhtmTpqnPZLk
         jwgLXx5oQXTL4WLVHA8G32CONxqA2uZmxWavRCs86VzGGI/JZ0goffQxJlZyun8pAYE7
         XOFfF4BMwru6cmQuHOM/g01NAQjTzpqA3LRCRqVZintsuidcbVet3Wa+MeWJy7bSluto
         WZck3Vkgt3oWeUaAX5IYvKEUqhINB6jrNuSwHRxitOxOasMZnoYXrBz2TbMiUoOuXWBo
         SXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=j+4y7ak+3mAQlDB2p6TnBzzt3tCyKePymP2VxvD2UIuNvkQuzAnBX8Qz+fc58vIee0
         tA1HBMNJo/GZGhuurEa27NiR9VdPDcf8vEzfb1y5durOemy5VrilWPKHGQ9nh8i12DSa
         VgiZkADaBrb4HNJGIcMFbeTLzYUvfyjz9hwwzcg/uyemeIOJe2Qd6z7NgZQUI1mGI3R3
         OTxMHFc4gLVXbmZxnrJ2rEESVjpNZF/I9WhxTiRASBaoU5xtrYS+yZP+dEeaOZ3oIGTc
         v1fSgaLS0Vi/Zf1simzAKl5iUmKyeL2DlFQJzxaP+efcCl8exCBLlG5fAJtG/wIaXdIS
         rx9w==
X-Gm-Message-State: AOAM532ydYiDletNIYugm9UGbBzQiUhqsVeuwVPLLaOi2/6bfLJXVMlb
        W0o6SrE8Gt6W+6D7gYO+7F0=
X-Google-Smtp-Source: ABdhPJxJAudWDgGVXloA9ASuQeNZSLaofQoYZDfhUlmOiZZYr4SgIdHrP6qALbzZcMc9DOhe5FKZ7g==
X-Received: by 2002:adf:ab09:0:b0:203:f9ce:cc1d with SMTP id q9-20020adfab09000000b00203f9cecc1dmr8590497wrc.269.1647793708830;
        Sun, 20 Mar 2022 09:28:28 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 16/18] ARM: dts: qcom: qcom-ipq8064: add missing krait-cc compatible and clocks
Date:   Sun, 20 Mar 2022 12:34:28 +0100
Message-Id: <20220320113430.26076-17-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

