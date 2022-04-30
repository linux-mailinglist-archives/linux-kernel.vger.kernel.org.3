Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC08515F33
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383100AbiD3Q2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383028AbiD3Q1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:27:32 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F365F8FD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:24:08 -0700 (PDT)
Received: from localhost.localdomain (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id DDC4E3F731;
        Sat, 30 Apr 2022 18:24:05 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] arm64: dts: qcom: msm8998-oneplus: Apply style fixes
Date:   Sat, 30 Apr 2022 18:23:46 +0200
Message-Id: <20220430162353.607709-8-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220430162353.607709-1-konrad.dybcio@somainline.org>
References: <20220430162353.607709-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some newlines, reorder some properties, remove some indentation to make
it more coherent.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi | 45 +++++++++++++++----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 5c4454da6bca..501771068938 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -11,9 +11,9 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "msm8998.dtsi"
+#include "pm8005.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
-#include "pm8005.dtsi"
 
 / {
 	/* Required for bootloader to select correct board */
@@ -241,13 +241,11 @@ pm8005_s1: s1 {
 
 &pm8998_gpio {
 	vol_keys_default: vol-keys-default {
-		pinconf {
-			pins = "gpio5", "gpio6";
-			function = "normal";
-			bias-pull-up;
-			input-enable;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-		};
+		pins = "gpio5", "gpio6";
+		function = "normal";
+		bias-pull-up;
+		input-enable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 };
 
@@ -295,91 +293,113 @@ vreg_s3a_1p35: s3 {
 			regulator-min-microvolt = <1352000>;
 			regulator-max-microvolt = <1352000>;
 		};
+
 		vreg_s4a_1p8: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_s5a_2p04: s5 {
 			regulator-min-microvolt = <1904000>;
 			regulator-max-microvolt = <2040000>;
 		};
+
 		vreg_s7a_1p025: s7 {
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1028000>;
 		};
+
 		vreg_l1a_0p875: l1 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
 		};
+
 		vreg_l2a_1p2: l2 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 		};
+
 		vreg_l3a_1p0: l3 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
 		};
+
 		vreg_l5a_0p8: l5 {
 			regulator-min-microvolt = <800000>;
 			regulator-max-microvolt = <800000>;
 		};
+
 		vreg_l6a_1p8: l6 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <1808000>;
 		};
+
 		vreg_l7a_1p8: l7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l8a_1p2: l8 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 		};
+
 		vreg_l9a_1p8: l9 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 		};
+
 		vreg_l10a_1p8: l10 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 		};
+
 		vreg_l11a_1p0: l11 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
 		};
+
 		vreg_l12a_1p8: l12 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l13a_2p95: l13 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 		};
+
 		vreg_l14a_1p88: l14 {
 			regulator-min-microvolt = <1880000>;
 			regulator-max-microvolt = <1880000>;
 		};
+
 		vreg_l15a_1p8: l15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l16a_2p7: l16 {
 			regulator-min-microvolt = <2704000>;
 			regulator-max-microvolt = <2704000>;
 		};
+
 		vreg_l17a_1p3: l17 {
 			regulator-min-microvolt = <1304000>;
 			regulator-max-microvolt = <1304000>;
 		};
+
 		vreg_l18a_2p7: l18 {
 			regulator-min-microvolt = <2704000>;
 			regulator-max-microvolt = <2704000>;
 		};
+
 		vreg_l19a_3p0: l19 {
 			regulator-min-microvolt = <3008000>;
 			regulator-max-microvolt = <3008000>;
 		};
+
 		vreg_l20a_2p95: l20 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
@@ -388,34 +408,41 @@ vreg_l20a_2p95: l20 {
 		vreg_l21a_2p95: l21 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
-			regulator-allow-set-load;
 			regulator-system-load = <800000>;
+			regulator-allow-set-load;
 		};
+
 		vreg_l22a_2p85: l22 {
 			regulator-min-microvolt = <2864000>;
 			regulator-max-microvolt = <2864000>;
 		};
+
 		vreg_l23a_3p3: l23 {
 			regulator-min-microvolt = <3312000>;
 			regulator-max-microvolt = <3312000>;
 		};
+
 		vreg_l24a_3p075: l24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
 		};
+
 		vreg_l25a_3p3: l25 {
 			regulator-min-microvolt = <3104000>;
 			regulator-max-microvolt = <3312000>;
 		};
+
 		vreg_l26a_1p2: l26 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l28_3p0: l28 {
 			regulator-min-microvolt = <3008000>;
 			regulator-max-microvolt = <3008000>;
 		};
+
 		vreg_lvs1a_1p8: lvs1 { };
 		vreg_lvs2a_1p8: lvs2 { };
 	};
-- 
2.35.2

