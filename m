Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D094E2BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349947AbiCUPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348349AbiCUPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2D222A3;
        Mon, 21 Mar 2022 08:18:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u16so20159548wru.4;
        Mon, 21 Mar 2022 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=Wq5Wbzf6NhoPBSPjHRqEZ0z+qbJQWcaRjc+QGGBTK9S/mzChfvwqvpUwsRmCYzgD4W
         aR+sTYtlB4e4/m4NLL0P2rSdHt5HVgZ3rpDjM7uUvd9QbAJlPJ780ucuVmLwfOVqB80F
         +LJVzIlA3X8hEGge8GSRo7HXHC38kjvg+akVLkFtLu/9s3GO657Zqb+YYWe+3AS0jSMm
         bR5sNz/oNmlK12aNlxbRK2V3A+Q8wzwfeqa019k2R2gY3LOUUsdWvX54N8i9Gq2Vx8Ui
         db0VbRWiOVcdiBDEB6srYxFfshkADWHf4neNhvovfbfmm7g+LSRbx5pHlkoeevlV6XsU
         73Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=FFNcStlbA8JbejED8CVqAAL87QEZZgKVOBvchkWQ26YFzhhnCIXX0WyWrpLUmOHYog
         x+MbNSa8C+7KprfRdfxcDpD7ppontOl+c5xVJYrXE2dgN3vM03F/B3ii7mgz/KRDDihC
         iVBFwTYYi6rpOwJYA0OWlPa6x8JoJOlh0kqKgpn1LxE3tUxs2x4lD/qcxShQbAeie6JW
         Th24mMZ6oSH+QLQyRjWPlQtUYqdbbPaVri1B/1deI1lneNEPWl3bFcuKQ1qxxIvyu3j8
         /gQFhaWIlKEnpTNydkfzTZdvfsdkQWtsnUMf1dH29XecD3Wb+OxJcuk4Wjzghp3RNnzw
         1nHA==
X-Gm-Message-State: AOAM5322O1J/O1RJJzCsfuRVjLY1+rAblKiWVH9mGpEF+U/UsnOn01tx
        2H9mBcMQb9hb9QE1wD3JVTA=
X-Google-Smtp-Source: ABdhPJy1PUTDsFzinFwnrcdLaY0O52uKDE5vMUA2EnCtTrX1mZtOKubR9voSpiKX8sFlcFeJPwIg8A==
X-Received: by 2002:a5d:668e:0:b0:203:d9c5:f475 with SMTP id l14-20020a5d668e000000b00203d9c5f475mr18260594wru.98.1647875882484;
        Mon, 21 Mar 2022 08:18:02 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:18:02 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 16/18] ARM: dts: qcom: qcom-ipq8064: add missing krait-cc compatible and clocks
Date:   Mon, 21 Mar 2022 15:48:23 +0100
Message-Id: <20220321144825.11736-17-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

