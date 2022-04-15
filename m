Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D6502921
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiDOMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiDOL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:25 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22833A94DF;
        Fri, 15 Apr 2022 04:56:55 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 984403F639;
        Fri, 15 Apr 2022 13:56:53 +0200 (CEST)
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
Subject: [PATCH 10/23] ARM: dts: qcom-msm8974-lge-nexus5: Use &labels
Date:   Fri, 15 Apr 2022 13:56:20 +0200
Message-Id: <20220415115633.575010-11-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use &labels to align with the style used in new DTS and apply tiny
style fixes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 1134 ++++++++---------
 1 file changed, 548 insertions(+), 586 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index cf06d4a17097..a1cae3d453c2 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -19,206 +19,24 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	smd {
-		rpm {
-			rpm_requests {
-				pm8841-regulators {
-					s1 {
-						regulator-min-microvolt = <675000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s2 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1050000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s4 {
-						regulator-min-microvolt = <815000>;
-						regulator-max-microvolt = <900000>;
-					};
-				};
-
-				pm8941-regulators {
-					vdd_l1_l3-supply = <&pm8941_s1>;
-					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-					vdd_l4_l11-supply = <&pm8941_s1>;
-					vdd_l5_l7-supply = <&pm8941_s2>;
-					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
-					vdd_l8_l16_l18_l19-supply = <&vreg_vph_pwr>;
-					vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
-					vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
-					vdd_l21-supply = <&vreg_boost>;
-
-					s1 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s2 {
-						regulator-min-microvolt = <2150000>;
-						regulator-max-microvolt = <2150000>;
-
-						regulator-boot-on;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l1 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l2 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l3 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l4 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l5 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l6 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l7 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l8 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l9 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l10 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l11 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-					};
-
-					l12 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l13 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l14 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l15 {
-						regulator-min-microvolt = <2050000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					l16 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l17 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l18 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l19 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-						regulator-system-load = <200000>;
-						regulator-allow-set-load;
-					};
-
-					l21 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l22 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					l23 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					l24 {
-						regulator-min-microvolt = <3075000>;
-						regulator-max-microvolt = <3075000>;
-
-						regulator-boot-on;
-					};
-				};
-			};
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pin_a>;
+
+		volume-up {
+			label = "volume_up";
+			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		volume-down {
+			label = "volume_down";
+			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEDOWN>;
 		};
 	};
 
@@ -237,525 +55,669 @@ vreg_wlan: wlan-regulator {
 	};
 };
 
-&soc {
-	serial@f991d000 {
-		status = "okay";
+&blsp1_i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	charger: bq24192@6b {
+		compatible = "ti,bq24192";
+		reg = <0x6b>;
+		interrupts-extended = <&spmi_bus 0 0xd5 0 IRQ_TYPE_EDGE_FALLING>;
+
+		omit-battery-class;
+
+		usb_otg_vbus: usb-otg-vbus { };
 	};
 
-	pinctrl@fd510000 {
-		sdhc1_pin_a: sdhc1-pin-active {
-			clk {
-				pins = "sdc1_clk";
-				drive-strength = <16>;
-				bias-disable;
-			};
+	fuelgauge: max17048@36 {
+		compatible = "maxim,max17048";
+		reg = <0x36>;
 
-			cmd-data {
-				pins = "sdc1_cmd", "sdc1_data";
-				drive-strength = <10>;
-				bias-pull-up;
-			};
-		};
+		maxim,double-soc;
+		maxim,rcomp = /bits/ 8 <0x4d>;
 
-		sdhc2_pin_a: sdhc2-pin-active {
-			clk {
-				pins = "sdc2_clk";
-				drive-strength = <6>;
-				bias-disable;
-			};
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 
-			cmd-data {
-				pins = "sdc2_cmd", "sdc2_data";
-				drive-strength = <6>;
-				bias-pull-up;
-			};
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&fuelgauge_pin>;
 
-		i2c1_pins: i2c1 {
-			mux {
-				pins = "gpio2", "gpio3";
-				function = "blsp_i2c1";
+		maxim,alert-low-soc-level = <2>;
+	};
+};
 
-				drive-strength = <2>;
-				bias-disable;
-			};
-		};
+&blsp1_i2c2 {
+	status = "okay";
+	clock-frequency = <355000>;
 
-		i2c2_pins: i2c2 {
-			mux {
-				pins = "gpio6", "gpio7";
-				function = "blsp_i2c2";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+	synaptics@70 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x70>;
+
+		interrupts-extended = <&tlmm 5 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8941_l22>;
+		vio-supply = <&pm8941_lvs3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pin>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <1>;
 		};
 
-		i2c3_pins: i2c3 {
-			mux {
-				pins = "gpio10", "gpio11";
-				function = "blsp_i2c3";
-				drive-strength = <2>;
-				bias-disable;
-			};
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
 		};
+	};
+};
 
-		i2c11_pins: i2c11 {
-			mux {
-				pins = "gpio83", "gpio84";
-				function = "blsp_i2c11";
+&blsp1_i2c3 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
+	avago_apds993@39 {
+		compatible = "avago,apds9930";
+		reg = <0x39>;
+		interrupts-extended = <&tlmm 61 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8941_l17>;
+		vddio-supply = <&pm8941_lvs1>;
+		led-max-microamp = <100000>;
+		amstaos,proximity-diodes = <0>;
+	};
+};
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+&blsp2_i2c5 {
+	status = "okay";
+	clock-frequency = <355000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c11_pins>;
+
+	led-controller@38 {
+		compatible = "ti,lm3630a";
+		status = "okay";
+		reg = <0x38>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			led-sources = <0 1>;
+			label = "lcd-backlight";
+			default-brightness = <200>;
 		};
+	};
+};
+
+&blsp2_i2c6 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c12_pins>;
+
+	mpu6515@68 {
+		compatible = "invensense,mpu6515";
+		reg = <0x68>;
+		interrupts-extended = <&tlmm 73 IRQ_TYPE_EDGE_FALLING>;
+		vddio-supply = <&pm8941_lvs1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&mpu6515_pin>;
 
-		i2c12_pins: i2c12 {
-			mux {
-				pins = "gpio87", "gpio88";
-				function = "blsp_i2c12";
-				drive-strength = <2>;
-				bias-disable;
+		mount-matrix = "0", "-1", "0",
+				"-1", "0", "0",
+				"0", "0", "1";
+
+		i2c-gate {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ak8963@f {
+				compatible = "asahi-kasei,ak8963";
+				reg = <0x0f>;
+				gpios = <&tlmm 67 0>;
+				vid-supply = <&pm8941_lvs1>;
+				vdd-supply = <&pm8941_l17>;
 			};
-		};
 
-		mpu6515_pin: mpu6515 {
-			irq {
-				pins = "gpio73";
-				function = "gpio";
-				bias-disable;
-				input-enable;
+			bmp280@76 {
+				compatible = "bosch,bmp280";
+				reg = <0x76>;
+				vdda-supply = <&pm8941_lvs1>;
+				vddd-supply = <&pm8941_l17>;
 			};
 		};
+	};
+};
+
+&blsp1_uart1 {
+	status = "okay";
+};
 
-		touch_pin: touch {
-			int {
-				pins = "gpio5";
-				function = "gpio";
+&blsp2_uart4 {
+	status = "okay";
 
-				drive-strength = <2>;
-				bias-disable;
-				input-enable;
-			};
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp2_uart4_pin_a>;
 
-			reset {
-				pins = "gpio8";
-				function = "gpio";
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pin>;
+
+		host-wakeup-gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
+	};
+};
 
-		panel_pin: panel {
-			te {
-				pins = "gpio12";
-				function = "mdp_vsync";
+&dsi0 {
+	status = "okay";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
-		};
+	vdda-supply = <&pm8941_l2>;
+	vdd-supply = <&pm8941_lvs3>;
+	vddio-supply = <&pm8941_l12>;
 
-		bt_pin: bt {
-			hostwake {
-				pins = "gpio42";
-				function = "gpio";
-			};
+	panel: panel@0 {
+		reg = <0>;
+		compatible = "lg,acx467akm-7";
 
-			devwake {
-				pins = "gpio62";
-				function = "gpio";
-			};
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_pin>;
 
-			shutdown {
-				pins = "gpio41";
-				function = "gpio";
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
 			};
 		};
+	};
+};
 
-		blsp2_uart4_pin_a: blsp2-uart4-pin-active {
-			tx {
-				pins = "gpio53";
-				function = "blsp_uart10";
+&dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+&dsi0_phy {
+	status = "okay";
 
-			rx {
-				pins = "gpio54";
-				function = "blsp_uart10";
+	vddio-supply = <&pm8941_l12>;
+};
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+&mdss {
+	status = "okay";
+};
 
-			cts {
-				pins = "gpio55";
-				function = "blsp_uart10";
+&otg {
+	status = "okay";
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
 
-			rts {
-				pins = "gpio56";
-				function = "blsp_uart10";
+	extcon = <&charger>, <&usb_id>;
+	vbus-supply = <&usb_otg_vbus>;
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+
+	ulpi {
+		phy@a {
+			status = "okay";
+
+			v1p8-supply = <&pm8941_l6>;
+			v3p3-supply = <&pm8941_l24>;
+
+			qcom,init-seq = /bits/ 8 <0x1 0x64>;
 		};
 	};
+};
 
-	sdhci@f9824900 {
-		status = "okay";
+&pm8941_gpios {
+	gpio_keys_pin_a: gpio-keys-active {
+		pins = "gpio2", "gpio3";
+		function = "normal";
 
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
+		bias-pull-up;
+		power-source = <PM8941_GPIO_S3>;
+	};
 
-		bus-width = <8>;
-		non-removable;
+	fuelgauge_pin: fuelgauge-int {
+		pins = "gpio9";
+		function = "normal";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc1_pin_a>;
+		bias-disable;
+		input-enable;
+		power-source = <PM8941_GPIO_S3>;
 	};
 
-	sdhci@f98a4900 {
-		status = "okay";
+	wlan_sleep_clk_pin: wl-sleep-clk {
+		pins = "gpio16";
+		function = "func2";
 
-		max-frequency = <100000000>;
-		bus-width = <4>;
-		non-removable;
-		vmmc-supply = <&vreg_wlan>;
-		vqmmc-supply = <&pm8941_s3>;
+		output-high;
+		power-source = <PM8941_GPIO_S3>;
+	};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc2_pin_a>;
+	wlan_regulator_pin: wl-reg-active {
+		pins = "gpio17";
+		function = "normal";
 
-		#address-cells = <1>;
-		#size-cells = <0>;
+		bias-disable;
+		power-source = <PM8941_GPIO_S3>;
+	};
+
+	otg {
+		gpio-hog;
+		gpios = <35 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "otg-gpio";
+	};
+};
 
-		bcrmf@1 {
-			compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
-			reg = <1>;
+&rpm_requests {
+	pm8841-regulators {
+		pm8841_s1: s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-			brcm,drive-strength = <10>;
+		pm8841_s2: s2 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_sleep_clk_pin>;
+		pm8841_s3: s3 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm8841_s4: s4 {
+			regulator-min-microvolt = <815000>;
+			regulator-max-microvolt = <900000>;
 		};
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
+	pm8941-regulators {
+		vdd_l1_l3-supply = <&pm8941_s1>;
+		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+		vdd_l4_l11-supply = <&pm8941_s1>;
+		vdd_l5_l7-supply = <&pm8941_s2>;
+		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+		vdd_l8_l16_l18_l19-supply = <&vreg_vph_pwr>;
+		vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
+		vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
+		vdd_l21-supply = <&vreg_boost>;
+
+		pm8941_s1: s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pin_a>;
+		pm8941_s2: s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+			regulator-boot-on;
+		};
 
-		volume-up {
-			label = "volume_up";
-			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEUP>;
+		pm8941_s3: s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
-		volume-down {
-			label = "volume_down";
-			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEDOWN>;
+		pm8941_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+			regulator-always-on;
+			regulator-boot-on;
 		};
-	};
 
-	serial@f9960000 {
-		status = "okay";
+		pm8941_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&blsp2_uart4_pin_a>;
+		pm8941_l3: l3 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-		bluetooth {
-			compatible = "brcm,bcm43438-bt";
-			max-speed = <3000000>;
+		pm8941_l4: l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&bt_pin>;
+		pm8941_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			host-wakeup-gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
-			device-wakeup-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
-			shutdown-gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
+		pm8941_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
 		};
-	};
 
-	i2c@f9967000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c11_pins>;
-		clock-frequency = <355000>;
-		qcom,src-freq = <50000000>;
+		pm8941_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+		};
 
-		led-controller@38 {
-			compatible = "ti,lm3630a";
-			status = "okay";
-			reg = <0x38>;
+		pm8941_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+		pm8941_l9: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
 
-			led@0 {
-				reg = <0>;
-				led-sources = <0 1>;
-				label = "lcd-backlight";
-				default-brightness = <200>;
-			};
+		pm8941_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
 		};
-	};
 
-	i2c@f9968000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c12_pins>;
-		clock-frequency = <100000>;
-		qcom,src-freq = <50000000>;
-
-		mpu6515@68 {
-			compatible = "invensense,mpu6515";
-			reg = <0x68>;
-			interrupts-extended = <&tlmm 73 IRQ_TYPE_EDGE_FALLING>;
-			vddio-supply = <&pm8941_lvs1>;
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&mpu6515_pin>;
-
-			mount-matrix = "0", "-1", "0",
-				       "-1", "0", "0",
-				       "0", "0", "1";
-
-			i2c-gate {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ak8963@f {
-					compatible = "asahi-kasei,ak8963";
-					reg = <0x0f>;
-					gpios = <&tlmm 67 0>;
-					vid-supply = <&pm8941_lvs1>;
-					vdd-supply = <&pm8941_l17>;
-				};
-
-				bmp280@76 {
-					compatible = "bosch,bmp280";
-					reg = <0x76>;
-					vdda-supply = <&pm8941_lvs1>;
-					vddd-supply = <&pm8941_l17>;
-				};
-			};
+		pm8941_l11: l11 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
 		};
-	};
 
-	i2c@f9923000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_pins>;
-		clock-frequency = <100000>;
-		qcom,src-freq = <50000000>;
+		pm8941_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-		charger: bq24192@6b {
-			compatible = "ti,bq24192";
-			reg = <0x6b>;
-			interrupts-extended = <&spmi_bus 0 0xd5 0 IRQ_TYPE_EDGE_FALLING>;
+		pm8941_l13: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-boot-on;
+		};
 
-			omit-battery-class;
+		pm8941_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			usb_otg_vbus: usb-otg-vbus { };
+		pm8941_l15: l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
 		};
 
-		fuelgauge: max17048@36 {
-			compatible = "maxim,max17048";
-			reg = <0x36>;
+		pm8941_l16: l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
 
-			maxim,double-soc;
-			maxim,rcomp = /bits/ 8 <0x4d>;
+		pm8941_l17: l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8941_l18: l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8941_l19: l19 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8941_l20: l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm8941_l21: l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-boot-on;
+		};
 
-			interrupt-parent = <&tlmm>;
-			interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+		pm8941_l22: l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&fuelgauge_pin>;
+		pm8941_l23: l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
 
-			maxim,alert-low-soc-level = <2>;
+		pm8941_l24: l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+			regulator-boot-on;
 		};
 	};
+};
 
-	i2c@f9924000 {
-		status = "okay";
+&sdhc_1 {
+	status = "okay";
 
-		clock-frequency = <355000>;
-		qcom,src-freq = <50000000>;
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+};
 
-		synaptics@70 {
-			compatible = "syna,rmi4-i2c";
-			reg = <0x70>;
+&sdhc_2 {
+	status = "okay";
 
-			interrupts-extended = <&tlmm 5 IRQ_TYPE_EDGE_FALLING>;
-			vdd-supply = <&pm8941_l22>;
-			vio-supply = <&pm8941_lvs3>;
+	max-frequency = <100000000>;
+	vmmc-supply = <&vreg_wlan>;
+	vqmmc-supply = <&pm8941_s3>;
+	non-removable;
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&touch_pin>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc2_pin_a>;
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-			rmi4-f01@1 {
-				reg = <0x1>;
-				syna,nosleep-mode = <1>;
-			};
+	bcrmf@1 {
+		compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
 
-			rmi4-f12@12 {
-				reg = <0x12>;
-				syna,sensor-type = <1>;
-			};
+		brcm,drive-strength = <10>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_sleep_clk_pin>;
+	};
+};
+
+&tlmm {
+	sdhc1_pin_a: sdhc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		cmd-data {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <10>;
+			bias-pull-up;
 		};
 	};
 
-	i2c@f9925000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c3_pins>;
-		clock-frequency = <100000>;
-		qcom,src-freq = <50000000>;
+	sdhc2_pin_a: sdhc2-pin-active {
+		clk {
+			pins = "sdc2_clk";
+			drive-strength = <6>;
+			bias-disable;
+		};
 
-		avago_apds993@39 {
-			compatible = "avago,apds9930";
-			reg = <0x39>;
-			interrupts-extended = <&tlmm 61 IRQ_TYPE_EDGE_FALLING>;
-			vdd-supply = <&pm8941_l17>;
-			vddio-supply = <&pm8941_lvs1>;
-			led-max-microamp = <100000>;
-			amstaos,proximity-diodes = <0>;
+		cmd-data {
+			pins = "sdc2_cmd", "sdc2_data";
+			drive-strength = <6>;
+			bias-pull-up;
 		};
 	};
 
-	usb@f9a55000 {
-		status = "okay";
+	i2c1_pins: i2c1 {
+		mux {
+			pins = "gpio2", "gpio3";
+			function = "blsp_i2c1";
 
-		phys = <&usb_hs1_phy>;
-		phy-select = <&tcsr 0xb000 0>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-		extcon = <&charger>, <&usb_id>;
-		vbus-supply = <&usb_otg_vbus>;
+	i2c2_pins: i2c2 {
+		mux {
+			pins = "gpio6", "gpio7";
+			function = "blsp_i2c2";
 
-		hnp-disable;
-		srp-disable;
-		adp-disable;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-		ulpi {
-			phy@a {
-				status = "okay";
+	i2c3_pins: i2c3 {
+		mux {
+			pins = "gpio10", "gpio11";
+			function = "blsp_i2c3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-				v1p8-supply = <&pm8941_l6>;
-				v3p3-supply = <&pm8941_l24>;
+	i2c11_pins: i2c11 {
+		mux {
+			pins = "gpio83", "gpio84";
+			function = "blsp_i2c11";
 
-				qcom,init-seq = /bits/ 8 <0x1 0x64>;
-			};
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 
-	mdss@fd900000 {
-		status = "okay";
+	i2c12_pins: i2c12 {
+		mux {
+			pins = "gpio87", "gpio88";
+			function = "blsp_i2c12";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-		mdp@fd900000 {
-			status = "okay";
+	mpu6515_pin: mpu6515 {
+		irq {
+			pins = "gpio73";
+			function = "gpio";
+			bias-disable;
+			input-enable;
 		};
+	};
 
-		dsi@fd922800 {
-			status = "okay";
+	touch_pin: touch {
+		int {
+			pins = "gpio5";
+			function = "gpio";
 
-			vdda-supply = <&pm8941_l2>;
-			vdd-supply = <&pm8941_lvs3>;
-			vddio-supply = <&pm8941_l12>;
+			drive-strength = <2>;
+			bias-disable;
+			input-enable;
+		};
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+		reset {
+			pins = "gpio8";
+			function = "gpio";
 
-			ports {
-				port@1 {
-					endpoint {
-						remote-endpoint = <&panel_in>;
-						data-lanes = <0 1 2 3>;
-					};
-				};
-			};
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
 
-			panel: panel@0 {
-				reg = <0>;
-				compatible = "lg,acx467akm-7";
+	panel_pin: panel {
+		te {
+			pins = "gpio12";
+			function = "mdp_vsync";
 
-				pinctrl-names = "default";
-				pinctrl-0 = <&panel_pin>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-				port {
-					panel_in: endpoint {
-						remote-endpoint = <&dsi0_out>;
-					};
-				};
-			};
+	bt_pin: bt {
+		hostwake {
+			pins = "gpio42";
+			function = "gpio";
 		};
 
-		dsi-phy@fd922a00 {
-			status = "okay";
+		devwake {
+			pins = "gpio62";
+			function = "gpio";
+		};
 
-			vddio-supply = <&pm8941_l12>;
+		shutdown {
+			pins = "gpio41";
+			function = "gpio";
 		};
 	};
-};
 
-&spmi_bus {
-	pm8941@0 {
-		gpios@c000 {
-			gpio_keys_pin_a: gpio-keys-active {
-				pins = "gpio2", "gpio3";
-				function = "normal";
+	blsp2_uart4_pin_a: blsp2-uart4-pin-active {
+		tx {
+			pins = "gpio53";
+			function = "blsp_uart10";
 
-				bias-pull-up;
-				power-source = <PM8941_GPIO_S3>;
-			};
+			drive-strength = <2>;
+			bias-disable;
+		};
 
-			fuelgauge_pin: fuelgauge-int {
-				pins = "gpio9";
-				function = "normal";
+		rx {
+			pins = "gpio54";
+			function = "blsp_uart10";
 
-				bias-disable;
-				input-enable;
-				power-source = <PM8941_GPIO_S3>;
-			};
-
-			wlan_sleep_clk_pin: wl-sleep-clk {
-				pins = "gpio16";
-				function = "func2";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
 
-				output-high;
-				power-source = <PM8941_GPIO_S3>;
-			};
+		cts {
+			pins = "gpio55";
+			function = "blsp_uart10";
 
-			wlan_regulator_pin: wl-reg-active {
-				pins = "gpio17";
-				function = "normal";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
 
-				bias-disable;
-				power-source = <PM8941_GPIO_S3>;
-			};
+		rts {
+			pins = "gpio56";
+			function = "blsp_uart10";
 
-			otg {
-				gpio-hog;
-				gpios = <35 GPIO_ACTIVE_HIGH>;
-				output-high;
-				line-name = "otg-gpio";
-			};
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 };
-- 
2.35.2

