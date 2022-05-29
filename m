Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3931C536F30
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiE2DSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 23:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiE2DSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:18:46 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD28B82D5;
        Sat, 28 May 2022 20:18:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 934AB32005CA;
        Sat, 28 May 2022 23:18:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 28 May 2022 23:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653794321; x=1653880721; bh=vZ1U3Uba78
        HKVPtbqYrYRIrImzZEszvCdvEWMx7ot+g=; b=k9eqPDgvGIfEQ37GLXdERdU6tb
        69YMWcS9ICOYucBGi5OjRqKzChqB/Zo4ztaXiaHmhYfbqh4/vYqlDcQsUiUtNmwR
        IlY+tekwsJZunpAwHl3pfci17Ksa4EJy+1dpVxtg+zjJ4kMbWdokea06atjDkabd
        b4i6aa/yvu/Prt/r9jLLYSqRJ6HPtXuGWlE9rJH6r/9eQimkL64rFfFd5lYqdzeL
        jU8kzyGqqALgBBB41h58EdAK+obpNR5jCoo1IPv+WWvjbv480fd306cW6j7ubbtB
        kgiQmOGhGnNUnYUvnL9pKDbbXVJ2YhP4W5mwe9NoM5109MMabn8/M/XEcdfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1653794321; x=
        1653880721; bh=vZ1U3Uba78HKVPtbqYrYRIrImzZEszvCdvEWMx7ot+g=; b=J
        Oldy02AJli1lREa7Gss7oxSK250T6MUDqwSdyMFpfssN+zGncJoS5XDL4+LBJefK
        5tdDuDA0ORIBrPneNLD81IuDfDDJjmiTH1z6JEQPkAB7ufDjdheCW6T0WfFVI3Ww
        k/oaGPrlLv+xqONouDW8Ae1mM06Vma7oMNQ+VGfsk0dNNN79K0sG2KAYvbXcfHej
        wSuR2R0YU3aqP9Y9Y/VntFD7Kh4AzuY+k4TH1V1GDUvf6GED3vCaJn32C1mSXMqI
        w7NQGEUzp0yU4foDuGNMLnT4x1snOFUystWq4ps9aDokilFj/TTXKfW9Gr7rPtz7
        jqYlsxfkVPqulae/XkHlw==
X-ME-Sender: <xms:EOaSYmWLwTvKhkNAvsXmmvkhavQU47XDCkCPjkybR6ng1HYxAjf5KQ>
    <xme:EOaSYik0t7O_nh_-6uLXkOVxnmHq7wBNIyZwWedL65F6g5zGvPMYUp-ePwL9e1nrm
    g7eOC4ODRww24wPpg>
X-ME-Received: <xmr:EOaSYqZjCrnekPpQzK5QI7NYkF-saOHW337kB06ZPcMM2zg81b839LQGgtdVmQ8XPdxVzy-lZqk531ltO7oWyLkojhghH8_JfpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeekhfekkeduiedthefggeehkeeiuedvjedthfevhfejkeeg
    teegffdttdetvdeigfenucffohhmrghinhepghhithhlrggsrdgtohhmpdhmvghgohhush
    drtghomhdpphhinhgvieegrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:EOaSYtX93jTJR6mhwRIXMY8eny3KlwXXxW_KpVVVLv-FWzSzVjk6WQ>
    <xmx:EOaSYgk2n80bNTmjax2OxyPGVmFB_xuMmaoB71FllBErm8P6V49cdQ>
    <xmx:EOaSYie0iLYd1TbljNngYxYR9QTKLmNKdNL9mu7URWZxY_xiju55dQ>
    <xmx:EeaSYl_SC8qQoslLYlJHBPOqTruJoFCPidX3dibrd0DeTdf1ZMZdFg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 May 2022 23:18:34 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <x@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro
Date:   Sun, 29 May 2022 13:17:05 +1000
Message-Id: <20220529031705.278631-3-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
References: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a basic DT that includes only features that are already
supported by mainline drivers.

Tested to work: booting from eMMC, WiFi, charging.

Future patches will flesh out the DT. Some components, e.g. the panel,
are awaiting driver mainlining.

This is derived from a combination of https://gitlab.com/pine64-org/linux
and https://megous.com/git/linux.

https://wiki.pine64.org/wiki/PinePhone_Pro

Co-developed-by: Ondrej Jirman <megous@megous.com>
Co-developed-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 939 ++++++++++++++++++
 2 files changed, 940 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 4ae9f35434b8..c00e7922d974 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinephone-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
new file mode 100644
index 000000000000..b1a486db1dfe
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -0,0 +1,939 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
+ * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
+ */
+
+// PinePhone Pro datasheet: https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
+
+/dts-v1/;
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/usb/pd.h>
+#include <dt-bindings/leds/common.h>
+#include "rk3399.dtsi"
+#include "rk3399-opp.dtsi"
+
+/ {
+	model = "Pine64 PinePhonePro";
+	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
+
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0xff1a0000";
+		stdout-path = "serial2:115200n8";
+	};
+
+	// Per "RK 3399 SARADC", page 8.
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1600000>;
+		poll-interval = <100>;
+
+		button-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <100000>;
+		};
+
+		button-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <300000>;
+		};
+	};
+
+	cluster1_opp_ppp: opp-table1b {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <800000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <825000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <875000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <950000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000>;
+		};
+	};
+
+	// Per "BACKLIGHT", page 16.
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 1000000 0>;
+		pwm-delay-us = <10000>;
+	};
+
+	// Per "RK3399 GPIO", page 11.
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&red_led_pin &green_led_pin &blue_led_pin>;
+
+		led-standby {
+			color = <LED_COLOR_ID_RED>;
+			default-state = "off";
+			function = LED_FUNCTION_STANDBY;
+			gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+			label = "red:standby";
+			panic-indicator;
+			retain-state-suspended;
+		};
+
+		led-pwr {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "on";
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
+			label = "green:disk-activity";
+		};
+
+		blue-charging {
+			color = <LED_COLOR_ID_BLUE>;
+			default-state = "off";
+			function = LED_FUNCTION_CHARGING;
+			gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
+			label = "blue:charging";
+		};
+	};
+
+	gpio-key-power {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwrbtn_pin>;
+
+		power {
+			debounce-interval = <20>;
+			// Per "PMU Controler", page 4.
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "Power";
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk818 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <500000>;
+
+		/* WL_REG_ON on module */
+		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
+	};
+
+	vibrator {
+		compatible = "gpio-vibrator";
+		// Per "GPIO", page 11.
+		enable-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
+		// Per "Motor", page 17.
+		vcc-supply = <&vcc3v3_sys>;
+	};
+
+	/* Power tree */
+	/* Root power source */
+	vcc_sysin: vcc-sysin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sysin";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc5v0_sys: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_sysin>;
+
+		regulator-state-mem {
+			regulator-on-in-suspend;
+		};
+	};
+
+	vcc5v0_typec: vcc5v0-typec-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_typec_en>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_typec";
+		vin-supply = <&vcc5v0_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-state-mem {
+			regulator-on-in-suspend;
+		};
+	};
+
+	/* Main 3.3v supply */
+	vcc3v3_sys: wifi_bat: vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sysin>;
+
+		regulator-state-mem {
+			regulator-on-in-suspend;
+		};
+	};
+
+	vcc1v8_codec: vcc1v8-codec-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc1v8_codec_en>;
+		regulator-name = "vcc1v8_codec";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	/* MIPI DSI panel 1.8v supply */
+	vcc1v8_lcd: vcc1v8-lcd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		regulator-name = "vcc1v8_lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+		gpio = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_pwren1>;
+	};
+
+	/* MIPI DSI panel 2.8v supply */
+	vcc2v8_lcd: vcc2v8-lcd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		regulator-name = "vcc2v8_lcd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc3v3_sys>;
+		gpio = <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_pwren>;
+	};
+
+	vcca1v8_s3: vcc1v8-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcca1v8_s3";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_b>;
+	operating-points-v2 = <&cluster1_opp_ppp>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_b>;
+	operating-points-v2 = <&cluster1_opp_ppp>;
+};
+
+&emmc_phy {
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&i2c0 {
+	// Per "SCL clock frequency", page 30, RK818 datasheet.
+	clock-frequency = <400000>;
+	i2c-scl-rising-time-ns = <168>;
+	i2c-scl-falling-time-ns = <4>;
+	status = "okay";
+
+	// Per "PMIC RK818-3", page 13.
+	rk818: pmic@1c {
+		compatible = "rockchip,rk818";
+		reg = <0x1c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		clock-output-names = "xin32k", "rk808-clkout2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		extcon = <&fusb0>;
+
+		vcc1-supply = <&vcc_sysin>;
+		vcc2-supply = <&vcc_sysin>;
+		vcc3-supply = <&vcc_sysin>;
+		vcc4-supply = <&vcc_sysin>;
+		vcc6-supply = <&vcc_sysin>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc_sysin>;
+		vcc9-supply = <&vcc3v3_sys>;
+
+		regulators {
+			vdd_cpu_l: DCDC_REG1 {
+				regulator-name = "vdd_cpu_l";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_center: DCDC_REG2 {
+				regulator-name = "vdd_center";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			// DDR
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					// Power RAM while suspended.
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_1v8: vcc_wl: DCDC_REG4 {
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
+			// Audio codec.
+			vcca3v0_codec: LDO_REG1 {
+				regulator-name = "vcca3v0_codec";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			// Touch screen.
+			vcc3v0_touch: LDO_REG2 {
+				regulator-name = "vcc3v0_touch";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_codec: LDO_REG3 {
+				regulator-name = "vcca1v8_codec";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_power_on: LDO_REG4 {
+				regulator-name = "vcc_power_on";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_3v0: LDO_REG5 {
+				regulator-name = "vcc_3v0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_1v5: LDO_REG6 {
+				regulator-name = "vcc_1v5";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1500000>;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG7 {
+				regulator-name = "vcc1v8_dvp";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_s3: LDO_REG8 {
+				regulator-name = "vcc3v3_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG9 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc3v3_s0: SWITCH_REG {
+				regulator-name = "vcc3v3_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			boost_otg: DCDC_BOOST {
+				regulator-name = "boost_otg";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <5000000>;
+				};
+			};
+
+			otg_switch: OTG_SWITCH {
+				regulator-name = "otg_switch";
+			};
+		};
+	};
+
+	vdd_cpu_b: regulator@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel1_pin>;
+		regulator-name = "vdd_cpu_b";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_gpu: regulator@41 {
+		compatible = "silergy,syr828";
+		reg = <0x41>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel2_pin>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c1 {
+	i2c-scl-rising-time-ns = <300>;
+	i2c-scl-falling-time-ns = <15>;
+	status = "okay";
+};
+
+&i2c3 {
+	i2c-scl-rising-time-ns = <450>;
+	i2c-scl-falling-time-ns = <15>;
+	status = "okay";
+
+	// Per "Ambient Light", page 17.
+	light-sensor@48 {
+		compatible = "sensortek,stk3311";
+		reg = <0x48>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PD3 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&stk3311_int>;
+		vdd-supply = <&vcc_3v0>;
+		leda-supply = <&vcc_3v0>;
+	};
+};
+
+&i2c4 {
+	i2c-scl-rising-time-ns = <600>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+
+	// Per "TYPE-C", page 23.
+	fusb0: typec-portc@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&fusb0_int>;
+		vbus-supply = <&vcc5v0_typec>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <1000000>;
+			power-role = "dual";
+			sink-pdos =
+				<PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 1400, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			extcon-cables = <1 2 5 6 9 10 12 44>;
+			typec-altmodes = <0xff01 1 0x001c0c00 1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usbc_hs: endpoint {
+						remote-endpoint =
+							<&u2phy0_typec_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usbc_ss: endpoint {
+						remote-endpoint =
+							<&tcphy0_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usbc_dp: endpoint {
+						remote-endpoint =
+							<&tcphy0_typec_dp>;
+					};
+				};
+			};
+		};
+	};
+
+	// Per "Gyro", page 17.
+	accelerometer@68 {
+		compatible = "invensense,mpu6500";
+		reg = <0x68>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PC6 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vcc_1v8>;
+		vddio-supply = <&vcc_1v8>;
+
+		mount-matrix =
+			"1", "0", "0",
+			"0", "-1", "0",
+			"0", "0", "1";
+	};
+};
+
+&io_domains {
+	status = "okay";
+
+	bt656-supply = <&vcc1v8_dvp>;
+	audio-supply = <&vcca1v8_codec>;
+	sdmmc-supply = <&vccio_sd>;
+	gpio1830-supply = <&vcc_3v0>;
+};
+
+&pmu_io_domains {
+	pmu1830-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_host_wake_l: bt-host-wake-l {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bt_wake_l: bt-wake-l {
+			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	buttons {
+		pwrbtn_pin: pwrbtn-pin {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	fusb302x {
+		fusb0_int: fusb0-int {
+			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		red_led_pin: red-led-pin {
+			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		green_led_pin: green-led-pin {
+			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		blue_led_pin: blue-led-pin {
+			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		vsel1_pin: vsel1-pin {
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		vsel2_pin: vsel2-pin {
+			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	sdcard {
+		sdmmc0_pwr_h: sdmmc0-pwr-h {
+			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb-typec {
+		vcc5v0_typec_en: vcc5v0_typec_en {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	dsi {
+		display_rst_l: display-rst-l {
+			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		display_pwren: display-pwren {
+			rockchip,pins = <3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		display_pwren1: display-pwren1 {
+			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	stk3311 {
+		stk3311_int: stk3311-int {
+			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sound {
+		vcc1v8_codec_en: vcc1v8-codec-en {
+			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+// Per "SARADC", page 8.
+&saradc {
+	vref-supply = <&vcca1v8_s3>;
+	status = "okay";
+};
+
+&sdio0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+// Per "SDMMC Controler", page 6.
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	max-frequency = <150000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	vmmc-supply = <&vcc3v3_sys>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	status = "okay";
+};
+
+&tcphy0 {
+	extcon = <&fusb0>;
+	status = "okay";
+};
+
+&tcphy0_dp {
+	port {
+		tcphy0_typec_dp: endpoint {
+			remote-endpoint = <&usbc_dp>;
+		};
+	};
+};
+
+&tcphy0_usb3 {
+	port {
+		tcphy0_typec_ss: endpoint {
+			remote-endpoint = <&usbc_ss>;
+		};
+	};
+};
+
+// Enable thermal sensors.
+&tsadc {
+	/* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-mode = <1>;
+	/* tshut polarity 0:LOW 1:HIGH */
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+
+	u2phy0_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy0_host: host-port {
+		status = "okay";
+		phy-supply = <&vcc5v0_sys>;
+	};
+
+	port {
+		u2phy0_typec_hs: endpoint {
+			remote-endpoint = <&usbc_hs>;
+		};
+	};
+};
+
+&u2phy1 {
+	status = "okay";
+
+	u2phy1_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy1_host: host-port {
+		status = "okay";
+		phy-supply = <&vcc5v0_sys>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	uart-has-rtscts;
+	status = "okay";
+
+	// Per "WIFI/BT MODULE", page 19.
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&rk818 1>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		max-speed = <1500000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&wifi_bat>;
+		vddio-supply = <&vcc_wl>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usbdrd3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
-- 
2.36.0

