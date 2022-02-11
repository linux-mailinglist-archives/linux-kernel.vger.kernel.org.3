Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF44B23BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbiBKKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:53:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349235AbiBKKx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:53:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE4DA9;
        Fri, 11 Feb 2022 02:53:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so10738217wrb.5;
        Fri, 11 Feb 2022 02:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NEg/h1rqfy5tfcGwjNRH+ELJL27ypf3P9uQhCTngjpQ=;
        b=EiHJjKtki0Y3p75pwSD062DGTRPcAr9d7YoJJjtcA6quBe3oHjMNyJ/v1LLxzzpGTa
         X0I7l8QQEjrQyHmDb0XaHXAEjmfjGDCbpgPe3+do8toNvxEpn5bMSL1Nkl+2J3/+bG/a
         vSrqx88iV/uQ0ynOYhO1LI39+hPMccCvhbLja4swMrNnxdIHcyZuxV0f3BPGOXxmaMer
         Nt4LLzoZCpIW6YAxwVDao/Lsj7hPJuJIfQqbvqjHT+6lZMS6TEOOy8zVgGfxaZymipMO
         QCi4s3UO6ecrQRZYIqkz6ZpsKg7Qa/MzQyNWuMTHkCU8YqZPDfy+y9pvSHwh9Oi0vIls
         x2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NEg/h1rqfy5tfcGwjNRH+ELJL27ypf3P9uQhCTngjpQ=;
        b=gCdNmEUkhvfeSX3qzeAgiuADDUWJGn05E19VbS+1R+CZT8+O0ghxuZNIkAiWvC+XBW
         Fyqze8/7RwC0WjWOmgAv82wo792uvxoS4tox82mPJmIT82NZNq8SAZenDUWQ1HUYkbbX
         a4VA0OZpQ+QgDyAFTE3pVgQAF4g1AMkLsTibJOH+VAsGciPF3ybV/wid4JI8V/KI2cdZ
         H2qAuXN2o6D2Mp8sCYJy07wD8Fx7tNYrW1x6JV1ZW3GREruZCirYSWBjunp7ou/JAcQ5
         DtSadX/e6+TZp+cP/LHOYQ5gMIiAHtxTS4WSaozHjBckOCT2jVRuCzldcHOtjtUT/YYq
         SnAA==
X-Gm-Message-State: AOAM530ajVqRfqY3EwkKq2JrORN5wPr1Nku7sh4+TIrBqYBOER/pVzG/
        me2IsDI/avpyfxMoEpJ8txg=
X-Google-Smtp-Source: ABdhPJyDyblAnzKFDfH5G1AvXIGzF5i1aOIDvOxvPib/TWe/45UGWSj7DZx0XP22W3Q51MF11gjODw==
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr901310wrc.662.1644576803672;
        Fri, 11 Feb 2022 02:53:23 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b4sm13382374wrw.100.2022.02.11.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:53:23 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: add support for OSMC Vero 4K+
Date:   Fri, 11 Feb 2022 10:53:11 +0000
Message-Id: <20220211105311.30320-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211105311.30320-1-christianshewitt@gmail.com>
References: <20220211105311.30320-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OSMC Vero 4K+ device is based on the Amlogic S905D (P230)
reference design with the following specifications:

- 2GB DDR4 RAM
- 16GB eMMC
- HDMI 2.1 video
- S/PDIF optical output
- AV output
- 10/100/1000 Ethernet
- AP6255 Wireless (802.11 a/b/g/n/ac, BT 4.2)
- 2x USB 2.0 ports (1x OTG)
- IR receiver (internal)
- IR extender port (external)
- 1x micro SD card slot
- 1x Power LED (red)
- 1x Reset button (in AV jack)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Chad Wagner <wagnerch42@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s905d-vero4k-plus.dts   | 117 ++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 13f73ca700ef..0eec18678311 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-vero4k-plus.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts
new file mode 100644
index 000000000000..4b0ff707e21b
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Author: Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905d.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "osmc,vero4k-plus", "amlogic,s905d", "amlogic,meson-gxl";
+	model = "OSMC Vero 4K Plus";
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <20>;
+
+		button@0 {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-standby {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+			panic-indicator;
+		};
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+
+	phy-mode = "rgmii-txid";
+	phy-handle = <&external_phy>;
+
+	amlogic,tx-delay-ns = <0>;
+};
+
+&external_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		pinctrl-0 = <&eth_phy_irq_pin>;
+		pinctrl-names = "default";
+
+		reg = <0>;
+		max-speed = <1000>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&pinctrl_periphs {
+	/* Ensure the phy irq pin is properly configured as input */
+	eth_phy_irq_pin: eth-phy-irq {
+		mux {
+			groups = "GPIOZ_15";
+			function = "gpio_periphs";
+			bias-disable;
+			output-disable;
+		};
+	};
+};
+
+&sd_emmc_a {
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
+};
+
+&usb {
+	dr_mode = "host";
+};
+
+&usb2_phy0 {
+	/* HDMI_5V also supplies the USB VBUS */
+	phy-supply = <&hdmi_5v>;
+};
+
+&usb2_phy0 {
+	/* HDMI_5V also supplies the USB VBUS */
+	phy-supply = <&hdmi_5v>;
+};
-- 
2.17.1

