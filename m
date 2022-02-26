Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728914C5859
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiBZVtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiBZVtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:49:11 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D71414FFD2;
        Sat, 26 Feb 2022 13:48:34 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r7so10705017iot.3;
        Sat, 26 Feb 2022 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieN8WfwCekNPr23xG7R/307g4QeN+9K5mZ1oCMGI15Y=;
        b=YjxWGEBwWikTPRVDX+OEhAjD0m1KFtj6115LA36+J7sLUbSVHHIPKmms3YTnx9Jl32
         IOLefKxwzzzQjPsz6Fc/fPAt19tcLyE6Cgs9iOYIKefGruzUp+FMMfMSSJITr5fmmYKd
         y6AMI7VVnIhZEVVmvWKeaML+Hynt9nVOqLYvl3YEN0ZjrCpk2c9QBvWICGtx8IjTFaqs
         RWMMGyF7eukr1N2E9poc8YtxrCwzns/I8oLvZA/uT3ES92DWm8Ol/mSOD3GJfD5o7BX5
         MBU4hMpZZh01EZMjAaoedTlaXdzLp9dzS3e5oCihSIOihlZ8Q/FeiA/moDdhYMhslcph
         Xv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieN8WfwCekNPr23xG7R/307g4QeN+9K5mZ1oCMGI15Y=;
        b=k7Zu87PGY9yaqm9Jtvrj0/80KthabI3Ztu/5V4vNAWJr1NSey1fJJlI3XpZmtxsF9L
         732TzQuADPL98MxAFTP8h7OJBSiMBo4d7o/s6y2sSZjFubFoaVYYT+vSaDBZCoMBAp3k
         xHZhtJK5098MWMEC4yIzLEi8YmYaPU6ccdjVxaicQhTrXgQta5BsCBdWXNGoQY4AQ7t6
         3vfSr7SnurwjKAY0IVKfAEjjdAA7syeDaCiDKJVoTEcbOhsU+Gc3JuPvAvT6bGY/tLtg
         7COiW1dxDykGt1C1fUb8r6M4oqXv5O0gFPPGp72CX3rz+E2jC/A3sjWxPLmHyO5f5QYO
         RnXg==
X-Gm-Message-State: AOAM531Kzqcb3XDG2dvehL4Q4B29wfNfHgRss6V7ZiP4egs/sS8Deohn
        7FIKy/Y4DiPYXPdPSrsqz3yMw9OiQ7mYMw==
X-Google-Smtp-Source: ABdhPJx8F8HQ4zyp2ef5cJ3VJCGBgJry/NnKdruRsWkEpxqX1U1cSuXVEIMjjxbzw0CqpV9Es/g5cA==
X-Received: by 2002:a02:c76f:0:b0:313:f8d3:efe9 with SMTP id k15-20020a02c76f000000b00313f8d3efe9mr9638539jao.304.1645912113456;
        Sat, 26 Feb 2022 13:48:33 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5781:f50c:883:3bec])
        by smtp.gmail.com with ESMTPSA id q24-20020a6bf218000000b006416f8414dfsm3325208ioh.12.2022.02.26.13.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 13:48:32 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: am3517-evm: Fix misc pinmuxing
Date:   Sat, 26 Feb 2022 15:48:19 -0600
Message-Id: <20220226214820.747847-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bootloader for the AM3517 has previously done much of the pin
muxing, but as the bootloader is moving more and more to a model
based on the device tree, it may no longer automatically pux the
pins, so it is necessary to add the pinmuxing to the Linux device
trees so the respective peripherals can remain functional.

Fixes: 6ed1d7997561 ("ARM: dts: am3517-evm: Add support for UI board and Audio")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
I put the fixes tag here, because I feel that the pinmuxing should not
have depended on the bootloader, but if it's not appropriate, feel free
to drop the fixes tag when applying or I can submit a subsequent patch
with the fixes tag dropped.

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 0d2fac98ce7d..c8b80f156ec9 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -161,6 +161,8 @@ pwm11: dmtimer-pwm@11 {
 
 	/* HS USB Host PHY on PORT 1 */
 	hsusb1_phy: hsusb1_phy {
+		pinctrl-names = "default";
+		pinctrl-0 = <&hsusb1_rst_pins>;
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>; /* gpio_57 */
 		#phy-cells = <0>;
@@ -168,7 +170,9 @@ hsusb1_phy: hsusb1_phy {
 };
 
 &davinci_emac {
-	     status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_pins>;
+	status = "okay";
 };
 
 &davinci_mdio {
@@ -193,6 +197,8 @@ dpi_out: endpoint {
 };
 
 &i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
 	clock-frequency = <400000>;
 	/* User DIP swithes [1:8] / User LEDS [1:2] */
 	tca6416: gpio@21 {
@@ -205,6 +211,8 @@ tca6416: gpio@21 {
 };
 
 &i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
 	clock-frequency = <400000>;
 };
 
@@ -223,6 +231,8 @@ &mmc3 {
 };
 
 &usbhshost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hsusb1_pins>;
 	port1-mode = "ehci-phy";
 };
 
@@ -231,8 +241,35 @@ &usbhsehci {
 };
 
 &omap3_pmx_core {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb1_rst_pins>;
+
+	ethernet_pins: pinmux_ethernet_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21fe, PIN_INPUT | MUX_MODE0) /* rmii_mdio_data */
+			OMAP3_CORE1_IOPAD(0x2200, MUX_MODE0) /* rmii_mdio_clk */
+			OMAP3_CORE1_IOPAD(0x2202, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_rxd0 */
+			OMAP3_CORE1_IOPAD(0x2204, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_rxd1 */
+			OMAP3_CORE1_IOPAD(0x2206, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_crs_dv */
+			OMAP3_CORE1_IOPAD(0x2208, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* rmii_rxer */
+			OMAP3_CORE1_IOPAD(0x220a, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* rmii_txd0 */
+			OMAP3_CORE1_IOPAD(0x220c, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* rmii_txd1 */
+			OMAP3_CORE1_IOPAD(0x220e, PIN_OUTPUT_PULLDOWN |MUX_MODE0) /* rmii_txen */
+			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50mhz_clk */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c2_scl */
+			OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c2_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c3_sda */
+		>;
+	};
 
 	leds_pins: pinmux_leds_pins {
 		pinctrl-single,pins = <
@@ -300,8 +337,6 @@ OMAP3_CORE1_IOPAD(0x20ba, PIN_OUTPUT | MUX_MODE4)	/* gpmc_ncs6.gpio_57 */
 };
 
 &omap3_pmx_core2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb1_pins>;
 
 	hsusb1_pins: pinmux_hsusb1_pins {
 		pinctrl-single,pins = <
diff --git a/arch/arm/boot/dts/am3517-som.dtsi b/arch/arm/boot/dts/am3517-som.dtsi
index 8b669e2eafec..f7b680f6c48a 100644
--- a/arch/arm/boot/dts/am3517-som.dtsi
+++ b/arch/arm/boot/dts/am3517-som.dtsi
@@ -69,6 +69,8 @@ nand@0,0 {
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
 
 	s35390a: s35390a@30 {
@@ -179,6 +181,13 @@ bluetooth {
 
 &omap3_pmx_core {
 
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c1_sda */
+		>;
+	};
+
 	wl12xx_buffer_pins: pinmux_wl12xx_buffer_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2156, PIN_OUTPUT | MUX_MODE4)  /* mmc1_dat7.gpio_129 */
-- 
2.34.1

