Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8479502904
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352815AbiDOL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352757AbiDOL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:20 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA67A8EE5;
        Fri, 15 Apr 2022 04:56:51 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 5339D3F67E;
        Fri, 15 Apr 2022 13:56:49 +0200 (CEST)
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
Subject: [PATCH 07/23] ARM: dts: qcom-msm8974*: Rename msmgpio to tlmm
Date:   Fri, 15 Apr 2022 13:56:17 +0200
Message-Id: <20220415115633.575010-8-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the label to match new the style used in newer DTs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts |  2 +-
 .../boot/dts/qcom-msm8974-fairphone-fp2.dts   |  2 +-
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 18 ++++++++---------
 .../boot/dts/qcom-msm8974-samsung-klte.dts    | 20 +++++++++----------
 .../qcom-msm8974-sony-xperia-rhine-amami.dts  |  2 +-
 .../qcom-msm8974-sony-xperia-rhine-honami.dts |  4 ++--
 ...com-msm8974-sony-xperia-shinano-castor.dts | 10 +++++-----
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  4 ++--
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 83793b835d40..f8983739fe4c 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -35,7 +35,7 @@ sdhci@f9824900 {
 		};
 
 		sdhci@f98a4900 {
-			cd-gpios = <&msmgpio 62 0x1>;
+			cd-gpios = <&tlmm 62 0x1>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
 			bus-width = <4>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
index 6d77e0f8ca4d..c502a059f090 100644
--- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
@@ -51,7 +51,7 @@ volume-up {
 
 	vibrator {
 		compatible = "gpio-vibrator";
-		enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
 		vcc-supply = <&pm8941_l18>;
 	};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 7bd577e8e941..cf06d4a17097 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -229,7 +229,7 @@ vreg_wlan: wlan-regulator {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpio = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
+		gpio = <&tlmm 26 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
@@ -482,9 +482,9 @@ bluetooth {
 			pinctrl-names = "default";
 			pinctrl-0 = <&bt_pin>;
 
-			host-wakeup-gpios = <&msmgpio 42 GPIO_ACTIVE_HIGH>;
-			device-wakeup-gpios = <&msmgpio 62 GPIO_ACTIVE_HIGH>;
-			shutdown-gpios = <&msmgpio 41 GPIO_ACTIVE_HIGH>;
+			host-wakeup-gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
+			device-wakeup-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
+			shutdown-gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -522,7 +522,7 @@ i2c@f9968000 {
 		mpu6515@68 {
 			compatible = "invensense,mpu6515";
 			reg = <0x68>;
-			interrupts-extended = <&msmgpio 73 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&tlmm 73 IRQ_TYPE_EDGE_FALLING>;
 			vddio-supply = <&pm8941_lvs1>;
 
 			pinctrl-names = "default";
@@ -538,7 +538,7 @@ i2c-gate {
 				ak8963@f {
 					compatible = "asahi-kasei,ak8963";
 					reg = <0x0f>;
-					gpios = <&msmgpio 67 0>;
+					gpios = <&tlmm 67 0>;
 					vid-supply = <&pm8941_lvs1>;
 					vdd-supply = <&pm8941_l17>;
 				};
@@ -577,7 +577,7 @@ fuelgauge: max17048@36 {
 			maxim,double-soc;
 			maxim,rcomp = /bits/ 8 <0x4d>;
 
-			interrupt-parent = <&msmgpio>;
+			interrupt-parent = <&tlmm>;
 			interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
 			pinctrl-names = "default";
@@ -600,7 +600,7 @@ synaptics@70 {
 			compatible = "syna,rmi4-i2c";
 			reg = <0x70>;
 
-			interrupts-extended = <&msmgpio 5 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&tlmm 5 IRQ_TYPE_EDGE_FALLING>;
 			vdd-supply = <&pm8941_l22>;
 			vio-supply = <&pm8941_lvs3>;
 
@@ -632,7 +632,7 @@ i2c@f9925000 {
 		avago_apds993@39 {
 			compatible = "avago,apds9930";
 			reg = <0x39>;
-			interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&tlmm 61 IRQ_TYPE_EDGE_FALLING>;
 			vdd-supply = <&pm8941_l17>;
 			vddio-supply = <&pm8941_lvs1>;
 			led-max-microamp = <100000>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
index 571b396f32cf..daafc4d31fc5 100644
--- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
@@ -215,8 +215,8 @@ i2c-gpio-touchkey {
 		compatible = "i2c-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		sda-gpios = <&msmgpio 95 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		scl-gpios = <&msmgpio 96 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		sda-gpios = <&tlmm 95 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 96 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c_touchkey_pins>;
 
@@ -240,8 +240,8 @@ i2c-gpio-led {
 		compatible = "i2c-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		scl-gpios = <&msmgpio 121 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		sda-gpios = <&msmgpio 120 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 121 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		sda-gpios = <&tlmm 120 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c_led_gpioex_pins>;
 
@@ -259,7 +259,7 @@ gpio_expander: gpio@20 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&gpioex_pin>;
 
-			reset-gpios = <&msmgpio 145 GPIO_ACTIVE_LOW>;
+			reset-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
 		};
 
 		led-controller@30 {
@@ -339,9 +339,9 @@ bluetooth {
 			max-speed = <3000000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&bt_pins>;
-			device-wakeup-gpios = <&msmgpio 91 GPIO_ACTIVE_HIGH>;
+			device-wakeup-gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
 			shutdown-gpios = <&gpio_expander 9 GPIO_ACTIVE_HIGH>;
-			interrupt-parent = <&msmgpio>;
+			interrupt-parent = <&tlmm>;
 			interrupts = <75 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "host-wakeup";
 		};
@@ -563,7 +563,7 @@ sdhci@f9864900 {
 		 */
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdhc2_pin_a /* &sdhc2_cd_pin */>;
-		// cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+		// cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 	};
 
 	sdhci@f98a4900 {
@@ -587,7 +587,7 @@ wifi@1 {
 			reg = <1>;
 			compatible = "brcm,bcm4329-fmac";
 
-			interrupt-parent = <&msmgpio>;
+			interrupt-parent = <&tlmm>;
 			interrupts = <92 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "host-wake";
 
@@ -818,7 +818,7 @@ panel: panel@0 {
 				vddr-supply = <&vreg_panel>;
 
 				reset-gpios = <&pma8084_gpios 17 GPIO_ACTIVE_LOW>;
-				te-gpios = <&msmgpio 12 GPIO_ACTIVE_HIGH>;
+				te-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
 
 				port {
 					panel_in: endpoint {
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
index 79e2cfbbb1ba..b8b35f000813 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
@@ -280,7 +280,7 @@ sdhci@f98a4900 {
 		vmmc-supply = <&pm8941_l21>;
 		vqmmc-supply = <&pm8941_l13>;
 
-		cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+		cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
index a62e5c25b23c..1f04f8493784 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
@@ -305,7 +305,7 @@ sdhci@f98a4900 {
 		vmmc-supply = <&pm8941_l21>;
 		vqmmc-supply = <&pm8941_l13>;
 
-		cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+		cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
@@ -331,7 +331,7 @@ synaptics@2c {
 			compatible = "syna,rmi4-i2c";
 			reg = <0x2c>;
 
-			interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&tlmm 61 IRQ_TYPE_EDGE_FALLING>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
index d0d03ef12c31..d77540205594 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
@@ -239,7 +239,7 @@ vreg_bl_vddio: lcd-backlight-vddio {
 		regulator-min-microvolt = <3150000>;
 		regulator-max-microvolt = <3150000>;
 
-		gpio = <&msmgpio 69 0>;
+		gpio = <&tlmm 69 0>;
 		enable-active-high;
 
 		vin-supply = <&pm8941_s3>;
@@ -323,7 +323,7 @@ sdhci@f98a4900 {
 		vmmc-supply = <&pm8941_l21>;
 		vqmmc-supply = <&pm8941_l13>;
 
-		cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+		cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
@@ -351,8 +351,8 @@ bluetooth {
 				    <&bt_dev_wake_pin>,
 				    <&bt_reg_on_pin>;
 
-			host-wakeup-gpios = <&msmgpio 95 GPIO_ACTIVE_HIGH>;
-			device-wakeup-gpios = <&msmgpio 96 GPIO_ACTIVE_HIGH>;
+			host-wakeup-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
+			device-wakeup-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 			shutdown-gpios = <&pm8941_gpios 16 GPIO_ACTIVE_HIGH>;
 		};
 	};
@@ -566,7 +566,7 @@ synaptics@2c {
 			compatible = "syna,rmi4-i2c";
 			reg = <0x2c>;
 
-			interrupt-parent = <&msmgpio>;
+			interrupt-parent = <&tlmm>;
 			interrupts = <86 IRQ_TYPE_EDGE_FALLING>;
 
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 5392c595e5ec..ecc230c4f324 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -953,11 +953,11 @@ wifi {
 			};
 		};
 
-		msmgpio: pinctrl@fd510000 {
+		tlmm: pinctrl@fd510000 {
 			compatible = "qcom,msm8974-pinctrl";
 			reg = <0xfd510000 0x4000>;
 			gpio-controller;
-			gpio-ranges = <&msmgpio 0 0 146>;
+			gpio-ranges = <&tlmm 0 0 146>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.35.2

