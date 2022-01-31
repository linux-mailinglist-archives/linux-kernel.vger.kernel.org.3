Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADE34A47C6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378533AbiAaNJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378509AbiAaNI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:08:56 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB67C061401
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:08:56 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z7so19349147ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knY3kPsWT9PL+CcABRLQO8dn62YWF64PSCm2xjp09g8=;
        b=eyzrMejc617K4v6zcmAJkrMsT5EIvswJkqwB0+OAVXVzJ80KQL70iivzovmHc2Cq8y
         Ae3gkPTZTK+yNMwfvmsUlq24M2zChXvIAIx3JB2iFlU5rUtdmXo/M7Sx47NfBQj54GWY
         +0oQeQHK3RSTIFz63/w0WYeOJcKC8n/xK/DDl5FSOj+aWxmT0U5GLQfkIauiVjrEzOvi
         egKfrgJuxT8+l2k0SSt/vbPfb/aioJ4/BrXMiV/thV+BV5BpJ/xhErb6FlEr7vwwN65J
         6QtR7iMFFizURpI6zRy6J1+sRzxUqWnUL+SbSeNy3L04lfDcD4YlhRwx/oAYyAgiupX2
         KB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knY3kPsWT9PL+CcABRLQO8dn62YWF64PSCm2xjp09g8=;
        b=60eCUKDWFv1x8SevpNj50n8a6SzFdy3y4UzKhpTkaAUswF5V2qsJf/xBthiDM2S0S0
         OOAbHXnn9RnceJO84w++oL5FXSG8u9Kqc2yjJsIOf4dVru91xlZsJNCj3+TMEvD0SJtm
         dBtoPGBvanQuw9AHFnkHfGHS0YTs+wgpyA+kpgblGJlV586M2GLvSdx6OwQaPsBkzXmG
         g4o97B5FBTAHy6oMT+cx6hKB9IFSk3LhKoFavvP8TQK9DZid083gphNDkpOgeuuDpDCv
         Hm3Zhh8YlDVkZztx6WPdGtXMUjOYGzRRQfNP7h6bn2IeFFAG6B7nrNmZ9B4LxENhLBKJ
         +jWw==
X-Gm-Message-State: AOAM531pHXkpUo7Ttko1zXKuc2pwapaZkdYo/VnwIIbEgBj4dMEmZQp5
        W4oMKoEZV8H51furhlzxKg6caA==
X-Google-Smtp-Source: ABdhPJx4PinwHcGYaZK51bJp+hH5BeXFiDJhaC3CySalyk2RewsCJHkBuq88fAybfrBGXG2sxmJFAg==
X-Received: by 2002:a2e:9b8c:: with SMTP id z12mr7806291lji.476.1643634534579;
        Mon, 31 Jan 2022 05:08:54 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m1sm3045057lfj.28.2022.01.31.05.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:08:54 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] arm64: dts: exynos: Add initial E850-96 board support
Date:   Mon, 31 Jan 2022 15:08:49 +0200
Message-Id: <20220131130849.2667-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131130849.2667-1-semen.protsenko@linaro.org>
References: <20220131130849.2667-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E850-96 is a 96boards development board manufactured by WinLink. It
incorporates Samsung Exynos850 SoC, and is compatible with 96boards
mezzanine boards [1], as it follows 96boards standards.

This patch adds minimal support for E850-96 board. Next features are
enabled in board dts file and verified with minimal BusyBox rootfs:

 * User buttons
 * LEDs
 * Serial console
 * Watchdog timers
 * RTC
 * eMMC

[1] https://www.96boards.org/products/mezzanine/

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v6:
  - (none)

Changes in v5:
  - (none)

Changes in v4:
  - Moved "rtcclk" clock to board dts file
    - Specified "rtc_src" clock for rtc node in board dts file
    - Specified "rtcclk" clock for cmu_hsi node in board dts file
  - Improved comment for RAM memory node

Changes in v3:
  - Ordered the pinctrl_alive phandle alphabetically (forgot to do so in
    v2)

Changes in v2:
  - Removed board_id and board_rev properties
  - Removed BOARD_ID and BOARD_REV constants
  - Put dtb in alphabetical order in Makefile
  - Added "color" and "function" properties to LED nodes
  - Sorted all phandle overrides by phandle name
  - Removed 'broken-cd' property in eMMC node
  - Added memory node

 arch/arm64/boot/dts/exynos/Makefile           |   1 +
 .../boot/dts/exynos/exynos850-e850-96.dts     | 195 ++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts

diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index b41e86df0a84..be9df8e85c59 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -3,4 +3,5 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
 	exynos5433-tm2.dtb	\
 	exynos5433-tm2e.dtb	\
 	exynos7-espresso.dtb	\
+	exynos850-e850-96.dtb	\
 	exynosautov9-sadk.dtb
diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
new file mode 100644
index 000000000000..7b5a61d22cc5
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * WinLink E850-96 board device tree source
+ *
+ * Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ * Copyright (C) 2021 Linaro Ltd.
+ *
+ * Device tree source file for WinLink's E850-96 board which is based on
+ * Samsung Exynos850 SoC.
+ */
+
+/dts-v1/;
+
+#include "exynos850.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "WinLink E850-96 board";
+	compatible = "winlink,e850-96", "samsung,exynos850";
+
+	chosen {
+		stdout-path = &serial_0;
+	};
+
+	/*
+	 * RAM: 4 GiB (eMCP):
+	 *   - 2 GiB at 0x80000000
+	 *   - 2 GiB at 0x880000000
+	 *
+	 * 0xbab00000..0xbfffffff: secure memory (85 MiB).
+	 */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x3ab00000>,
+		      <0x0 0xc0000000 0x40000000>,
+		      <0x8 0x80000000 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_voldown_pins &key_volup_pins>;
+
+		volume-down-key {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&gpa1 0 GPIO_ACTIVE_LOW>;
+		};
+
+		volume-up-key {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&gpa0 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		/* HEART_BEAT_LED */
+		user_led1: led-1 {
+			label = "yellow:user1";
+			gpios = <&gpg2 2 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+		};
+
+		/* eMMC_LED */
+		user_led2: led-2 {
+			label = "yellow:user2";
+			gpios = <&gpg2 3 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			linux,default-trigger = "mmc0";
+		};
+
+		/* SD_LED */
+		user_led3: led-3 {
+			label = "white:user3";
+			gpios = <&gpg2 4 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_SD;
+			linux,default-trigger = "mmc2";
+		};
+
+		/* WIFI_LED */
+		wlan_active_led: led-4 {
+			label = "yellow:wlan";
+			gpios = <&gpg2 6 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_WLAN;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		/* BLUETOOTH_LED */
+		bt_active_led: led-5 {
+			label = "blue:bt";
+			gpios = <&gpg2 7 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_BLUETOOTH;
+			linux,default-trigger = "hci0rx";
+			default-state = "off";
+		};
+	};
+
+	/*
+	 * RTC clock (XrtcXTI); external, must be 32.768 kHz.
+	 *
+	 * TODO: Remove this once RTC clock is implemented properly as part of
+	 *       PMIC driver.
+	 */
+	rtcclk: clock-rtcclk {
+		compatible = "fixed-clock";
+		clock-output-names = "rtcclk";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+};
+
+&cmu_hsi {
+	clocks = <&oscclk>, <&rtcclk>,
+		 <&cmu_top CLK_DOUT_HSI_BUS>,
+		 <&cmu_top CLK_DOUT_HSI_MMC_CARD>,
+		 <&cmu_top CLK_DOUT_HSI_USB20DRD>;
+	clock-names = "oscclk", "rtcclk", "dout_hsi_bus",
+		      "dout_hsi_mmc_card", "dout_hsi_usb20drd";
+};
+
+&mmc_0 {
+	status = "okay";
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-highspeed;
+	non-removable;
+	mmc-hs400-enhanced-strobe;
+	card-detect-delay = <200>;
+	clock-frequency = <800000000>;
+	bus-width = <8>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <2 4>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk_pins &sd0_cmd_pins &sd0_rdqs_pins &sd0_nreset_pins
+		     &sd0_bus1_pins &sd0_bus4_pins &sd0_bus8_pins>;
+};
+
+&oscclk {
+	clock-frequency = <26000000>;
+};
+
+&pinctrl_alive {
+	key_voldown_pins: key-voldown-pins {
+		samsung,pins = "gpa1-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	key_volup_pins: key-volup-pins {
+		samsung,pins = "gpa0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+};
+
+&rtc {
+	status = "okay";
+	clocks = <&cmu_apm CLK_GOUT_RTC_PCLK>, <&rtcclk>;
+	clock-names = "rtc", "rtc_src";
+};
+
+&serial_0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+};
+
+&usi_uart {
+	samsung,clkreq-on; /* needed for UART mode */
+	status = "okay";
+};
+
+&watchdog_cl0 {
+	status = "okay";
+};
+
+&watchdog_cl1 {
+	status = "okay";
+};
-- 
2.30.2

