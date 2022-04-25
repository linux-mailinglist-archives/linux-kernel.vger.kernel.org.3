Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2050E6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbiDYRRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbiDYRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:16:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDCF13DD7;
        Mon, 25 Apr 2022 10:13:54 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id e128so11259319qkd.7;
        Mon, 25 Apr 2022 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAioprNETEkeNP3AEr8nOEM8MgiWKcO/wKpJyyoVSnQ=;
        b=N7JWI75DT/WlqkSPnKQntlr2Ah+Kwqw+y6b5qSk6465Ii+rc9q4vgLkujB8iZc7muQ
         yqlClnj9AVmPqHRAK6N//wqNoaSNMOKkJo5LMSBnIfEZwrm0BTdmvAd/K5liqlkUOaAC
         90z86yOLg+NfJtcE0Ph9LiFyK4+WIfD4r2m/LYR8bPE15iBDKiNMN0C1iSXP8xwvjJ5q
         x0DpT5FGXyDejrD/UQ3cK7q91/bDU4XbFs0lCgioEWGb1lQddisDnpideptUref/0dFM
         JkgiIHZm/W8sln3HXAzGFUXI3wqQ/Cn61qd0K/GmObA1oP7m0S59gI6c7M+jy/1n5Qaz
         iIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAioprNETEkeNP3AEr8nOEM8MgiWKcO/wKpJyyoVSnQ=;
        b=iZHRyAjjzi0kugNMOnUT131i8NGIpz0hrJu34L+9VGPYRCIyWXH8A5bIEoR3HLE2o+
         3G4ytHX8KkYApHwSqXe6R6B/DrueTfOiKxWH8uW5LPS54F0LWBbJ6Bc2cvjF1acBVL3Z
         JTwltgLriw2esxCHuj86y4nFuzHrWyUdEl0TYeEcq2ZaS0OOyROuHuqGj77tVfZ80b0z
         VSOnClmAA1QYdCe94mxwa1sVn2lz/lXAFwqCX9vvOqmYAkUMnEigu6FtN1e0UTDzhway
         d6q9h1fZhjd/RtynfOMA5mfBOGD82M5OKzMHhgUMTl2A/Mu0gAP1k7q9XyuA2jearHox
         YUCQ==
X-Gm-Message-State: AOAM531zOxpVB3jiLPhPWGHb9NljVUv6E+5BVGGclJF9HHC5eGkzc7Ks
        GiR5BG4++sHMgbhqZRxGDhk=
X-Google-Smtp-Source: ABdhPJwEye4vimf4V3yXKCMG9jJtjgaUiOPgA0qUbQW6WVCqDWPwib/gXHuSLomUEb+idBzQWqKPtQ==
X-Received: by 2002:a05:620a:1791:b0:69f:46bb:aefd with SMTP id ay17-20020a05620a179100b0069f46bbaefdmr4681136qkb.720.1650906833028;
        Mon, 25 Apr 2022 10:13:53 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm7154928qtw.64.2022.04.25.10.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:13:52 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/7] arm64: dts: rockchip: add SoQuartz CM4IO dts
Date:   Mon, 25 Apr 2022 13:13:43 -0400
Message-Id: <20220425171344.1924057-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425171344.1924057-1-pgwipeout@gmail.com>
References: <20220425171344.1924057-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial SoQuartz SoM device tree on a CM4IO carrier board.
This board outputs debug on uart2 and supports the following components:
Gigabit Ethernet
USB2 (OTG/Host shared)
PCIe 2.0 x1
HDMI (HDMI Port 0)
eDP (HDMI Port 1)
DSI (RPi compatible pinout)
CSI (RPi compatible pinout)
A/B/G/N WiFi
Bluetooth
SDMMC
eMMC
SPI NOR Flash (Not placed)
PI-40 compatible pin header

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts | 167 +++++
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 607 ++++++++++++++++++
 3 files changed, 775 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 252ee47b8a1d..23a2a0c111ac 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -60,5 +60,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
new file mode 100644
index 000000000000..fa470a587e2b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3566-soquartz.dtsi"
+
+/ {
+	model = "Pine64 RK3566 SoQuartz with CM4-IO Carrier Board";
+	compatible = "pine64,soquartz-cm4io", "pine64,soquartz", "rockchip,rk3566";
+
+	/* labeled +12v in schematic */
+	vcc12v_dcin: vcc12v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	/* labeled +5v in schematic */
+	vcc_5v: vcc-5v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+};
+
+&gmac1 {
+	status = "okay";
+};
+
+/* i2c1 is exposed on CM1 / Module1A
+ * pin 80 - SCL0 - i2c1_scl_m0, pullup to vcc3v3_pmu
+ * pin 82 - SDA0 - i2c1_sda_m0, pullup to vcc3v3_pmu
+ */
+&i2c1 {
+	status = "okay";
+
+	/* the rtc interrupt is tied to PMIC_PWRON,
+	 * it will force reset the board if triggered.
+	 */
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063";
+		reg = <0x51>;
+	};
+};
+
+/* i2c2 is exposed on CM1 / Module1A - to PI40
+ * pin 56 - GPIO3 - i2c2_scl_m1, pullup to vcc_3v3, shared with i2s1_8ch
+ * pin 58 - GPIO2 - i2c2_sda_m1, pullup to vcc_3v3
+ */
+&i2c2 {
+	status = "disabled";
+};
+
+/* i2c3 is exposed on CM1 / Module1A - to PI40
+ * pin 35 - ID_SC(GPIO28) - i2c3_scl_m0, pullup to vcc_3v3
+ * pin 36 - ID_SD(GPIO27) - i2c3_sda_m0, pullup to vcc_3v3
+ */
+&i2c3 {
+	status = "disabled";
+};
+
+/* i2c4 is exposed on CM2 / Module1B - to PI40
+ * pin 45 - GPIO24 - i2c4_scl_m1
+ * pin 47 - GPIO23 - i2c4_sda_m1
+ */
+&i2c4 {
+	status = "disabled";
+};
+
+/* i2s1_8ch is exposed on CM1 / Module1A - to PI40
+ * pin 24 - GPIO26 - i2s1_sdi1_m1
+ * pin 25 - GPIO21 - i2s1_sdo0_m1
+ * pin 26 - GPIO19 - i2s1_lrck_tx_m1
+ * pin 27 - GPIO20 - i2s1_sdi0_m1
+ * pin 29 - GPIO16 - i2s1_sdi3_m1
+ * pin 30 - GPIO6  - i2s1_sdi2_m1
+ * pin 40 - GPIO9  - i2s1_sdo1_m1, shared with spi3
+ * pin 41 - GPIO25 - i2s1_sdo2_m1
+ * pin 49 - GPIO18 - i2s1_sclk_tx_m1
+ * pin 50 - GPIO17 - i2s1_mclk_m1
+ * pin 56 - GPIO3  - i2s1_sdo3_m1, shared with i2c2
+ */
+&i2s1_8ch {
+	status = "disabled";
+};
+
+&led_diy {
+	status = "okay";
+};
+
+&led_work {
+	status = "okay";
+};
+
+&rgmii_phy1 {
+	status = "okay";
+};
+
+/* saradc is exposed on CM1 / Module1A - to J2
+ * pin 94 - AIN1 - saradc_vin3
+ * pin 96 - AIN0 - saradc_vin2
+ */
+&saradc {
+	status = "disabled";
+};
+
+&sdmmc0 {
+	vmmc-supply = <&sdmmc_pwr>;
+	status = "okay";
+};
+
+&sdmmc_pwr {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	status = "okay";
+};
+
+/* spi3 is exposed on CM1 / Module1A - to PI40
+ * pin 37 - GPIO7  - spi3_cs1_m0
+ * pin 38 - GPIO11 - spi3_clk_m0
+ * pin 39 - GPIO8  - spi3_cs0_m0
+ * pin 40 - GPIO9  - spi3_miso_m0, shared with i2s1_8ch
+ * pin 44 - GPIO10 - spi3_mosi_m0
+ */
+&spi3 {
+	status = "disabled";
+};
+
+/* uart2 is exposed on CM1 / Module1A - to PI40
+ * pin 51 - GPIO15 - uart2_rx_m0
+ * pin 55 - GPIO14 - uart2_tx_m0
+ */
+&uart2 {
+	status = "okay";
+};
+
+/* uart7 is exposed on CM1 / Module1A - to PI40
+ * pin 46 - GPIO22 - uart7_tx_m2
+ * pin 47 - GPIO23 - uart7_rx_m2
+ */
+&uart7 {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc_5v>;
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	status = "okay";
+};
+
+&vbus {
+	vin-supply = <&vcc_5v>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
new file mode 100644
index 000000000000..9ebb2afe7e82
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3566.dtsi"
+
+/ {
+	model = "Pine64 RK3566 SoQuartz SOM";
+	compatible = "pine64,soquartz", "rockchip,rk3566";
+
+	aliases {
+		ethernet0 = &gmac1;
+		mmc0 = &sdmmc0;
+		mmc1 = &sdhci;
+		mmc2 = &sdmmc1;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	gmac1_clkin: external-gmac1-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "gmac1_clkin";
+		#clock-cells = <0>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_diy: led-diy {
+			label = "diy-led";
+			default-state = "on";
+			gpios = <&gpio0 RK_PC1 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+			pinctrl-names = "default";
+			pinctrl-0 = <&diy_led_enable_h>;
+			retain-state-suspended;
+			status = "disabled";
+		};
+
+		led_work: led-work {
+			label = "work-led";
+			default-state = "off";
+			gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_LOW>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&work_led_enable_h>;
+			retain-state-suspended;
+			status = "disabled";
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		status = "okay";
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk809 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+
+	vbus: vbus-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	/* sourced from vbus, vbus is provided by the carrier board */
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vbus>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	sdmmc_pwr: sdmmc-pwr-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwr_h>;
+		regulator-name = "sdmmc_pwr";
+		status = "disabled";
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>, <&gmac1_clkin>;
+	clock_in_out = "input";
+	phy-supply = <&vcc_3v3>;
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m0_miim
+		     &gmac1m0_tx_bus2
+		     &gmac1m0_rx_bus2
+		     &gmac1m0_rgmii_clk
+		     &gmac1m0_clkinout
+		     &gmac1m0_rgmii_bus>;
+	snps,reset-gpio = <&gpio0 RK_PC3 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f, also works well here */
+	snps,reset-delays-us = <0 20000 100000>;
+	tx_delay = <0x30>;
+	rx_delay = <0x10>;
+	phy-handle = <&rgmii_phy1>;
+	status = "disabled";
+};
+
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		wakeup-source;
+
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+					regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_ddr";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_npu";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdda0v9_image: LDO_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda0v9_image";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda_0v9";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda0v9_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_acodec";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca_1v8";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_pmu";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_image: LDO_REG9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_image";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-name = "vcc_3v3";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
+				status = "disabled";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+		};
+	};
+};
+
+/* i2c1 is exposed on CM1 / Module1A
+ * pin 80 - i2c1_scl_m0, pullup to vcc3v3_pmu
+ * pin 82 - i2c1_sda_m0, pullup to vcc3v3_pmu
+ */
+&i2c1 {
+	status = "disabled";
+};
+
+/* i2c2 is exposed on CM1 / Module1A
+ * pin 56 - i2c2_scl_m1, pullup to vcc_3v3, shared with i2s1_8ch
+ * pin 58 - i2c2_sda_m1, pullup to vcc_3v3
+ */
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2m1_xfer>;
+	status = "disabled";
+};
+
+/* i2c3 is exposed on CM1 / Module1A
+ * pin 35 - i2c3_scl_m0, pullup to vcc_3v3
+ * pin 36 - i2c3_sda_m0, pullup to vcc_3v3
+ */
+&i2c3 {
+	status = "disabled";
+};
+
+/* i2c4 is exposed on CM2 / Module1B
+ * pin 45 - i2c4_scl_m1
+ * pin 47 - i2c4_sda_m1
+ */
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m1_xfer>;
+	status = "disabled";
+};
+
+/* i2s1_8ch is exposed on CM1 / Module1A
+ * pin 24 - i2s1_sdi1_m1
+ * pin 25 - i2s1_sdo0_m1
+ * pin 26 - i2s1_lrck_tx_m1
+ * pin 27 - i2s1_sdi0_m1
+ * pin 29 - i2s1_sdi3_m1
+ * pin 30 - i2s1_sdi2_m1
+ * pin 40 - i2s1_sdo1_m1, shared with spi3
+ * pin 41 - i2s1_sdo2_m1
+ * pin 49 - i2s1_sclk_tx_m1
+ * pin 50 - i2s1_mclk_m1
+ * pin 56 - i2s1_sdo3_m1, shared with i2c2
+ */
+&i2s1_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m1_sclktx &i2s1m1_sclkrx
+		     &i2s1m1_lrcktx &i2s1m1_lrckrx
+		     &i2s1m1_sdi0   &i2s1m1_sdi1
+		     &i2s1m1_sdi2   &i2s1m1_sdi3
+		     &i2s1m1_sdo0   &i2s1m1_sdo1
+		     &i2s1m1_sdo2   &i2s1m1_sdo3>;
+	status = "disabled";
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		status = "disabled";
+	};
+};
+
+&pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_host_wake_l: bt-host-wake-l {
+			rockchip,pins = <2 RK_PC0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bt_wake_l: bt-wake-l {
+			rockchip,pins = <2 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		work_led_enable_h: work-led-enable-h {
+			rockchip,pins = <0 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		diy_led_enable_h: diy-led-enable-h {
+			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc-pwr {
+		sdmmc_pwr_h: sdmmc-pwr-h {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vcc_3v3>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_3v3>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+/* saradc is exposed on CM1 / Module1A
+ * pin 94 - saradc_vin3
+ * pin 96 - saradc_vin2
+ */
+&saradc {
+	vref-supply = <&vcca_1v8>;
+	status = "disabled";
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	broken-cd;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "disabled";
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sys>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+/* spi3 is exposed on CM1 / Module1A
+ * pin 37 - spi3_cs1_m0
+ * pin 38 - spi3_clk_m0
+ * pin 39 - spi3_cs0_m0
+ * pin 40 - spi3_miso_m0, shared with i2s1_8ch
+ * pin 44 - spi3_mosi_m0
+ */
+&spi3 {
+	status = "disabled";
+};
+
+&tsadc {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk809 1>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+		vbat-supply = <&vcc3v3_sys>;
+		vddio-supply = <&vcca1v8_pmu>;
+	};
+};
+
+/* uart2 is exposed on CM1 / Module1A
+ * pin 51 - uart2_rx_m0
+ * pin 55 - uart2_tx_m0
+ */
+&uart2 {
+	status = "disabled";
+};
+
+/* uart7 is exposed on CM1 / Module1A
+ * pin 46 - uart7_tx_m2
+ * pin 47 - uart7_rx_m2
+ */
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart7m2_xfer>;
+	status = "disabled";
+};
+
+/* dwc3_otg is the only usb port available */
+&usb2phy0 {
+	status = "disabled";
+};
+
+&usb2phy0_otg {
+	status = "disabled";
+};
+
+&usb_host0_xhci {
+	status = "disabled";
+};
-- 
2.25.1

