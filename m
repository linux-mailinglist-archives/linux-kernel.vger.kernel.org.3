Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1FF502934
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353102AbiDOMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352920AbiDOL7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:47 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64348BBE12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:57:16 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 0BA5A3F686;
        Fri, 15 Apr 2022 13:57:13 +0200 (CEST)
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
Subject: [PATCH 20/23] ARM: dts: qcom-msm8974*: Clean up old GPIO declarations
Date:   Fri, 15 Apr 2022 13:56:30 +0200
Message-Id: <20220415115633.575010-21-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded level of nesting, as it does not match the current DTS
style.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 21 +++-----
 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   | 13 ++---
 .../boot/dts/qcom-msm8974pro-samsung-klte.dts | 53 +++++++------------
 3 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 7e4e723f1dc3..52b3f055e834 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -573,12 +573,10 @@ cmd-data {
 	};
 
 	mpu6515_pin: mpu6515 {
-		irq {
-			pins = "gpio73";
-			function = "gpio";
-			bias-disable;
-			input-enable;
-		};
+		pins = "gpio73";
+		function = "gpio";
+		bias-disable;
+		input-enable;
 	};
 
 	touch_pin: touch {
@@ -601,13 +599,10 @@ reset {
 	};
 
 	panel_pin: panel {
-		te {
-			pins = "gpio12";
-			function = "mdp_vsync";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
+		pins = "gpio12";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
 	bt_pin: bt {
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index c2e423d2a21e..1120972ae4d2 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -375,14 +375,11 @@ &smbb {
 
 &tlmm {
 	ts_int_pin: touch-int {
-		pin {
-			pins = "gpio61";
-			function = "gpio";
-
-			drive-strength = <2>;
-			bias-disable;
-			input-enable;
-		};
+		pins = "gpio61";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
 	};
 
 	sdc1_on: sdc1-on {
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index f230a657d0f3..7c7ad9e7baa6 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -780,50 +780,37 @@ cmd-data {
 	};
 
 	i2c_touchkey_pins: i2c-touchkey {
-		mux {
-			pins = "gpio95", "gpio96";
-			function = "gpio";
-			input-enable;
-			bias-pull-up;
-		};
+		pins = "gpio95", "gpio96";
+		function = "gpio";
+		input-enable;
+		bias-pull-up;
 	};
 
 	i2c_led_gpioex_pins: i2c-led-gpioex {
-		mux {
-			pins = "gpio120", "gpio121";
-			function = "gpio";
-			input-enable;
-			bias-pull-down;
-		};
+		pins = "gpio120", "gpio121";
+		function = "gpio";
+		input-enable;
+		bias-pull-down;
 	};
 
 	gpioex_pin: gpioex {
-		res {
-			pins = "gpio145";
-			function = "gpio";
-
-			bias-pull-up;
-			drive-strength = <2>;
-		};
+		pins = "gpio145";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <2>;
 	};
 
 	wifi_pin: wifi {
-		int {
-			pins = "gpio92";
-			function = "gpio";
-
-			input-enable;
-			bias-pull-down;
-		};
+		pins = "gpio92";
+		function = "gpio";
+		input-enable;
+		bias-pull-down;
 	};
 
 	panel_te_pin: panel {
-		te {
-			pins = "gpio12";
-			function = "mdp_vsync";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
+		pins = "gpio12";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-disable;
 	};
 };
-- 
2.35.2

