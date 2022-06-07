Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5B653F355
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiFGBYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiFGBYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:24:45 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30CA8FD54;
        Mon,  6 Jun 2022 18:24:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7853232009B8;
        Mon,  6 Jun 2022 21:24:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 Jun 2022 21:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1654565079; x=1654651479; bh=ZJeobm3gyB+9zKZVYustX79Ye
        cpWPfNx6+5liWQJmFQ=; b=hf0vY6NtOXMzTG/p8IMI4LaG2fEhiAs6fR9G8IjbU
        Tz3FoZyp+yd52vJ3tP478YCGW4vMd2Lg0Q7uc7wliKMy1q/M1AAq6Rx/VTCyFXU3
        +hiJqmzX6zsyYfRTLnmmM6QeFtIBaQxqRnbvk71VrA8Fw+5zT8BuLxEpJOC3c22t
        QbkPJGNsjVPdmxc27YHAlYb2/sKb69+xcW6inlubk/KWCF46cPSg25tSvxHSnBuR
        MEisEVb67FzfccURJvPG2OMhesOrnQSfeqU1Oed4fja2BElfsZYlM9UoZUnCLOyh
        ckoUheAlluHi91QOTDqBgeW+1s3UTnmpo6buLZ3PTsVuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1654565079; x=1654651479; bh=ZJeobm3gyB+9zKZVYustX79YecpWPfNx6+5
        liWQJmFQ=; b=P9al+f2UEXP2QE/tNJzQaInk0ChipGG5z/Z4fBxZxEa0xej+kwF
        i59sEdAQ6VhvOm4Z8NtG7T7zvwE1CTGgZ9pDA5NZzasPdoDaVcJoibnZtzoT0+q+
        cGSwxRpbq//K/V4J0r44Z5tvwQt4KY3VuBLNVLxnsubf2qNrEe+ecm5u1P3B5djL
        KjYxzjO5Fr0CeZQew+Z2GNVsDihwrQYs7JPh3GrIHk837byDsupS8/MG2tD3BLEw
        2gUSL8MzN+D5nr9fA8vmwlOEMVtN4lVjQ2oE3eQoTuW/0+fN9V0QyAQEwPZwF8Rw
        BoHT8ZVESlGSRTftcBwU/m6hVEBkDAWSEbA==
X-ME-Sender: <xms:16ieYmR7EF9-Zd90gdD0JK56OCvuKuNyMsl7jEzC5fgNgtFs5Om4AA>
    <xme:16ieYrx9BgnQl3O4Pgwdn6eJsM-TKTkiUUQLWH7RIJgCLuKJYYWPSEEjjsGIo4B9n
    FC1FTPi0joTL7B-cA>
X-ME-Received: <xmr:16ieYj3JapUP4KFBrARNeE4SumWBietxC0EdhRDgUAMghPgT7XzwI__iz7v3xRwK8EyIKbEVzu5slHdYbMXYKxVCyqp-tCqkO6RotJ5a0cw_k31Nhw0aUBy6aiS5okCFAOsBpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtgedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:16ieYiDpYz76Gnd7ex_uY7I11kBwK3L1OcQXq5IJv3XW9Izapud7RQ>
    <xmx:16ieYvjGwDlmLsDG4HBmX2zXIpnK9LTIHAzV354Pg1I_GKquH9A4tQ>
    <xmx:16ieYuojXsdezINM3RA556O5Yv39O0lHjCfUMy5n6CyamQrxSgQQpQ>
    <xmx:16ieYvjuOsNWLYEFemECHc-9e2qVU3dH2uQbRqrct_ElqL1TilxZug>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jun 2022 21:24:39 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 1/2] ARM: dts: sunxi: Use constants for RTC clock indexes
Date:   Mon,  6 Jun 2022 20:24:37 -0500
Message-Id: <20220607012438.18183-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

The binding header provides descriptive names for the RTC clock indexes,
since the indexes were arbitrarily chosen by the binding, not by the
hardware. Let's use the names, so the meaning is clearer.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/boot/dts/sun6i-a31.dtsi                    | 12 +++++++-----
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                |  8 +++++---
 .../arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts |  4 ++--
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts           |  2 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts          |  4 ++--
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts       |  2 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts            |  4 ++--
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts        |  4 ++--
 arch/arm/boot/dts/sun8i-r40.dtsi                    |  8 +++++---
 arch/arm/boot/dts/sun8i-v3s.dtsi                    |  6 ++++--
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi       |  4 ++--
 arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi     |  4 ++--
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                  | 13 ++++++++-----
 13 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 715d74854449..70e634b37aae 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -46,6 +46,7 @@
 #include <dt-bindings/thermal/thermal.h>
 
 #include <dt-bindings/clock/sun6i-a31-ccu.h>
+#include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/reset/sun6i-a31-ccu.h>
 
 / {
@@ -598,7 +599,7 @@ ohci2: usb@1c1c400 {
 		ccu: clock@1c20000 {
 			compatible = "allwinner,sun6i-a31-ccu";
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&rtc 0>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -612,7 +613,8 @@ pio: pinctrl@1c20800 {
 				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_APB1_PIO>, <&osc24M>, <&rtc 0>;
+			clocks = <&ccu CLK_APB1_PIO>, <&osc24M>,
+				 <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -1319,7 +1321,7 @@ prcm@1f01400 {
 			ar100: ar100_clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
-				clocks = <&rtc 0>, <&osc24M>,
+				clocks = <&rtc CLK_OSC32K>, <&osc24M>,
 					 <&ccu CLK_PLL_PERIPH>,
 					 <&ccu CLK_PLL_PERIPH>;
 				clock-output-names = "ar100";
@@ -1354,7 +1356,7 @@ apb0_gates: apb0_gates_clk {
 			ir_clk: ir_clk {
 				#clock-cells = <0>;
 				compatible = "allwinner,sun4i-a10-mod0-clk";
-				clocks = <&rtc 0>, <&osc24M>;
+				clocks = <&rtc CLK_OSC32K>, <&osc24M>;
 				clock-output-names = "ir";
 			};
 
@@ -1385,7 +1387,7 @@ r_pio: pinctrl@1f02c00 {
 			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc 0>;
+			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			resets = <&apb0_rst 0>;
 			gpio-controller;
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 4461d5098b20..1a262a05fdcb 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -44,6 +44,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+#include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/clock/sun8i-a23-a33-ccu.h>
 #include <dt-bindings/reset/sun8i-a23-a33-ccu.h>
 
@@ -329,7 +330,7 @@ ohci0: usb@1c1a400 {
 
 		ccu: clock@1c20000 {
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&rtc 0>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -340,7 +341,8 @@ pio: pinctrl@1c20800 {
 			reg = <0x01c20800 0x400>;
 			interrupt-parent = <&r_intc>;
 			/* interrupts get set in SoC specific dtsi file */
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>,
+				 <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -810,7 +812,7 @@ r_pio: pinctrl@1f02c00 {
 			reg = <0x01f02c00 0x400>;
 			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc 0>;
+			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			resets = <&apb0_rst 0>;
 			gpio-controller;
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index d5c7b7984d85..c06b217a8af5 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -106,7 +106,7 @@ poweroff {
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 };
@@ -181,7 +181,7 @@ &uart1 {
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		max-speed = <1500000>;
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_vcc3v3>;
 		vddio-supply = <&reg_vcc3v3>;
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index cd9f655e4f92..7721a7a50d45 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -125,7 +125,7 @@ spdif_out: spdif-out {
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
index 8e7dfcffe1fb..23aae3eaed79 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
@@ -90,7 +90,7 @@ reg_vdd_sys: vdd-sys {
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 
@@ -151,7 +151,7 @@ &uart2 {
 
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_vcc3v3>;
 		vddio-supply = <&reg_vcc3v3>;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index cd3df12b6573..9e1a33f94cad 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -127,7 +127,7 @@ &uart3 {
 
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_vcc3v3>;
 		vddio-supply = <&reg_vcc3v3>;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
index 26e2e6172e0d..42cd1131adf3 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
@@ -46,7 +46,7 @@ reg_vdd_cpux: gpio-regulator {
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 
@@ -147,7 +147,7 @@ &uart3 {
 
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_vcc3v3>;
 		vddio-supply = <&reg_vcc3v3>;
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index bf5b5e2f6168..bc394686fedb 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -91,7 +91,7 @@ reg_vcc5v0: vcc5v0 {
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL06 */
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 };
@@ -283,7 +283,7 @@ &uart1 {
 
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_dldo1>;
 		vddio-supply = <&reg_aldo3>;
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 03d3e5f45a09..75d55a46b50e 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -42,6 +42,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-r40-ccu.h>
 #include <dt-bindings/clock/sun8i-tcon-top.h>
@@ -485,7 +486,7 @@ spi3: spi@1c1f000 {
 		ccu: clock@1c20000 {
 			compatible = "allwinner,sun8i-r40-ccu";
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&rtc 0>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -504,7 +505,8 @@ pio: pinctrl@1c20800 {
 			compatible = "allwinner,sun8i-r40-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>,
+				 <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -1231,7 +1233,7 @@ hdmi: hdmi@1ee0000 {
 			reg-io-width = <1>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_HDMI0>, <&ccu CLK_HDMI_SLOW>,
-				 <&ccu CLK_HDMI>, <&rtc 0>;
+				 <&ccu CLK_HDMI>, <&rtc CLK_OSC32K>;
 			clock-names = "iahb", "isfr", "tmds", "cec";
 			resets = <&ccu RST_BUS_HDMI1>;
 			reset-names = "ctrl";
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 084323d5c61c..db194c606fdc 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -42,6 +42,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/clock/sun8i-v3s-ccu.h>
 #include <dt-bindings/reset/sun8i-v3s-ccu.h>
 #include <dt-bindings/clock/sun8i-de2.h>
@@ -321,7 +322,7 @@ usbphy: phy@1c19400 {
 		ccu: clock@1c20000 {
 			compatible = "allwinner,sun8i-v3s-ccu";
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&rtc 0>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -342,7 +343,8 @@ pio: pinctrl@1c20800 {
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>,
+				 <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index d03f5853ef7b..d4627bc7c122 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -101,7 +101,7 @@ reg_gmac_3v3: gmac-3v3 {
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 };
@@ -221,7 +221,7 @@ &uart1 {
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		max-speed = <1500000>;
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_vcc3v3>;
 		vddio-supply = <&reg_vcc3v3>;
diff --git a/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi b/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
index fc67e30fe212..60804b0e6c56 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
@@ -22,7 +22,7 @@ wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 2 7 GPIO_ACTIVE_LOW>; /* PC7 */
 		post-power-on-delay-ms = <200>;
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 };
@@ -124,7 +124,7 @@ &uart1 {
 
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_vcc3v3>;
 		vddio-supply = <&reg_vcc3v3>;
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index d7e9f977f986..09aefb4e90f8 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -40,6 +40,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-h3-ccu.h>
 #include <dt-bindings/clock/sun8i-r-ccu.h>
@@ -386,7 +387,7 @@ ohci3: usb@1c1d400 {
 		ccu: clock@1c20000 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&rtc 0>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -398,7 +399,8 @@ pio: pinctrl@1c20800 {
 			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>,
+				 <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -818,7 +820,7 @@ hdmi: hdmi@1ee0000 {
 			reg-io-width = <1>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
-				 <&ccu CLK_HDMI>, <&rtc 0>;
+				 <&ccu CLK_HDMI>, <&rtc CLK_OSC32K>;
 			clock-names = "iahb", "isfr", "tmds", "cec";
 			resets = <&ccu RST_BUS_HDMI1>;
 			reset-names = "ctrl";
@@ -878,7 +880,7 @@ r_intc: interrupt-controller@1f00c00 {
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
-			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CLK_IOSC>,
 				 <&ccu CLK_PLL_PERIPH0>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
@@ -931,7 +933,8 @@ r_pio: pinctrl@1f02c00 {
 			reg = <0x01f02c00 0x400>;
 			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&rtc 0>;
+			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>,
+				 <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
-- 
2.35.1

