Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D053F356
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiFGBYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiFGBYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:24:46 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3EE1EEFF;
        Mon,  6 Jun 2022 18:24:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F3EF932009A6;
        Mon,  6 Jun 2022 21:24:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 06 Jun 2022 21:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1654565082; x=1654651482; bh=H7
        3kBZJeQevq82+1Bfe9V6iI5LibBPJEAtjXG+4r1xg=; b=el/+8YzDdeeHp3S/Nc
        NtkWcQY2LI9P1TrcDqU7yE3IHMzhfzYoRW9iP0Do9mFmUBoQYG1h4sJe3VxLfKlm
        uDp+lEY/INMSKIBATpLoIS4lrAanj1ao6sQBC9htuU8NEIvjHws6R97Zmv7Qx0ae
        IJaACINiasuvTLxCTBF8WgZ15YQFu3MyTfic5rSnHcvOSJ4BnZBxdvMotglbxkDK
        DvFiVPOh8J1D0NsL/kbKnXf2wOlbVUU6sTPMUyFn6j/urbConyHW36snCahI/KSn
        U4kJXB+C+cpBspVqWWqCJ9kTkFvyfvIbVJvLd9mWk5jh+f27IgzZyvwKc8vfComJ
        gGww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1654565082; x=1654651482; bh=H73kBZJeQevq8
        2+1Bfe9V6iI5LibBPJEAtjXG+4r1xg=; b=bnHEitcJbF9TyrUoSQRvhO+kV/vpM
        9gNsmXOXv8vdRkZdgEgg5odh2vI4pnmhfqNHhqjpj94E5gXCwYnm5z9dt/r6Tvka
        Kgx973HNlVZh0FCUkaJhJ7+NNZqWLOrpl7cDJtQ8mGphyMj8caRmLCljCzfMrSvK
        J9/uSGVCbKLVRFeJKaviMbRbFevpf4X9R8O9w2gWv4lRpMsVyvNTUbxKZpylEEr6
        bqYsqM2oYFsbJIB/xOJMwrjvjFlw7tMRcY4Aq/Yi8jGcuIXbB1JCyWgdQls4uoV/
        F86EOMW/UT6nCxn5dlc2IwLGaZrRhiKfn9RFhWCBXnp/RVew4GB9/cicA==
X-ME-Sender: <xms:2qieYmmSBeD4Qy1GYXQgPEw9BKrs8DbIr-Xhc-6gHhrLV2cv6T7zpw>
    <xme:2qieYt3Iq7I4eSH3nYuYs-OQiNMQPotFYpFiZxcWxdu-umRt919Gdu-JOLCTkbFHF
    vy7woR5JgTdgyBwWQ>
X-ME-Received: <xmr:2qieYkpstzJ566Xej6pEA-5dG7gZ4l26HQVfOIX6gxaZFfQE3T_4ssWjUadewG3s9cYdyp_cvcRQGkPMvm9IpmY5xDa1P8SueTU3zV-R-LrGOP8K_3CD5_1FKhe3Cp5Qt-_DPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtgedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:2qieYqkDf6iscW-GQcipmXviH7alYQnsVNRcjrBKM12AyV_kzYfNtw>
    <xmx:2qieYk0pbgWxWHlJ5gzXaghXbeaeDJ2M6Rz4AvQWuVk46TguI3dD1Q>
    <xmx:2qieYhtg5aKjnz-rSecrBeVDcTWBYlW3wFQIaaaxvBG_K-ONazwHZA>
    <xmx:2qieYllEvYs6V7ZdrYeMtcyTczaFLf-Xgag95MuPXT4HyiJZ1SQKFA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jun 2022 21:24:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] arm64: dts: allwinner: Use constants for RTC clock indexes
Date:   Mon,  6 Jun 2022 20:24:38 -0500
Message-Id: <20220607012438.18183-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607012438.18183-1-samuel@sholland.org>
References: <20220607012438.18183-1-samuel@sholland.org>
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

 .../boot/dts/allwinner/sun50i-a64-amarula-relic.dts  |  2 +-
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts   |  4 ++--
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts     |  2 +-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts   |  4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi        | 10 ++++++----
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts      |  4 ++--
 .../boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts  |  4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi   |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi         | 12 +++++++-----
 9 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index f17cc89f472d..8233582f6288 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -58,7 +58,7 @@ ov5640_ep: endpoint {
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* WL-PMU-EN: PL2 */
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 997a19372683..e6d5bc0f7a61 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -56,7 +56,7 @@ led-2 {
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 };
@@ -355,7 +355,7 @@ &uart1 {
 
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_dldo2>;
 		vddio-supply = <&reg_dldo4>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index e47ff06a6fa9..0af6dcdf7515 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -43,7 +43,7 @@ led {
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index c519d9fa6967..e2f963332925 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -71,7 +71,7 @@ reg_usb1_vbus: usb1-vbus {
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 	};
 };
@@ -369,7 +369,7 @@ &uart1 {
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		max-speed = <1500000>;
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		vbat-supply = <&reg_dldo2>;
 		vddio-supply = <&reg_dldo4>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index de77c87481fd..77b5349f6087 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -4,6 +4,7 @@
 //    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
 
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
+#include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -660,7 +661,7 @@ ohci1: usb@1c1b400 {
 		ccu: clock@1c20000 {
 			compatible = "allwinner,sun50i-a64-ccu";
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&rtc 0>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -673,7 +674,8 @@ pio: pinctrl@1c20800 {
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>,
+				 <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -1226,7 +1228,7 @@ hdmi: hdmi@1ee0000 {
 			reg-io-width = <1>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
-				 <&ccu CLK_HDMI>, <&rtc 0>;
+				 <&ccu CLK_HDMI>, <&rtc CLK_OSC32K>;
 			clock-names = "iahb", "isfr", "tmds", "cec";
 			resets = <&ccu RST_BUS_HDMI1>;
 			reset-names = "ctrl";
@@ -1287,7 +1289,7 @@ r_intc: interrupt-controller@1f00c00 {
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun50i-a64-r-ccu";
 			reg = <0x01f01400 0x100>;
-			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CLK_IOSC>,
 				 <&ccu CLK_PLL_PERIPH0>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index c45d7b7fb39a..6fc65e8db220 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -86,7 +86,7 @@ reg_vcc_wifi_io: vcc-wifi-io {
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
 		post-power-on-delay-ms = <200>;
@@ -314,7 +314,7 @@ &uart1 {
 
 	bluetooth {
 		compatible = "brcm,bcm4345c5";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		device-wakeup-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
 		host-wakeup-gpios = <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
index e8770858b5d0..fb31dcb1cb6d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -13,7 +13,7 @@ aliases {
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
 		post-power-on-delay-ms = <200>;
@@ -64,7 +64,7 @@ &uart1 {
 
 	bluetooth {
 		compatible = "brcm,bcm4345c5";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "lpo";
 		device-wakeup-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
 		host-wakeup-gpios = <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
index edb71e4a0304..4903d6358112 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
@@ -78,7 +78,7 @@ spdif_out: spdif-out {
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		clocks = <&rtc 1>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
 		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index fbe94abbb1f9..5a28303d3d4c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun50i-h6-ccu.h>
 #include <dt-bindings/clock/sun50i-h6-r-ccu.h>
+#include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-tcon-top.h>
 #include <dt-bindings/reset/sun50i-h6-ccu.h>
@@ -237,7 +238,7 @@ ve_sram: sram-section@0 {
 		ccu: clock@3001000 {
 			compatible = "allwinner,sun50i-h6-ccu";
 			reg = <0x03001000 0x1000>;
-			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CLK_IOSC>;
 			clock-names = "hosc", "losc", "iosc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -317,7 +318,7 @@ pio: pinctrl@300b000 {
 				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
+			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -725,7 +726,7 @@ dwc3: usb@5200000 {
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_XHCI>,
 				 <&ccu CLK_BUS_XHCI>,
-				 <&rtc 0>;
+				 <&rtc CLK_OSC32K>;
 			clock-names = "ref", "bus_early", "suspend";
 			resets = <&ccu RST_BUS_XHCI>;
 			/*
@@ -931,7 +932,7 @@ rtc: rtc@7000000 {
 		r_ccu: clock@7010000 {
 			compatible = "allwinner,sun50i-h6-r-ccu";
 			reg = <0x07010000 0x400>;
-			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CLK_IOSC>,
 				 <&ccu CLK_PLL_PERIPH0>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
@@ -960,7 +961,8 @@ r_pio: pinctrl@7022000 {
 			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
+			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>,
+				 <&rtc CLK_OSC32K>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
-- 
2.35.1

