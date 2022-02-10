Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863F34B049D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiBJErL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:47:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiBJEq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:46:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A351A6;
        Wed,  9 Feb 2022 20:47:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so7367088wrc.6;
        Wed, 09 Feb 2022 20:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVIcuDz6GjpOZ4yoklcTopWb9sLPnBO2BTPRQDHuze4=;
        b=lfusYxrBeGh0ZDAiCpcDAPQz3UYVLND1HVMBkg/UAecwAC0CHX7yl/oIWSIfISAMmo
         n/5+B+QKAYXtreUCsqx9lO9md+BXN6eqVFrfqp3IKEGEURoQ1BAwzo/wKb2gK4YAwO3J
         O0DPdssQBrabMErkw5CBkU5ckEg4/sTkE8Jfk8/EjS/Cz/DwCgikf7QsRU0+5pNsKYuM
         XEPdJiamzBzzOJF506b3ucLSJRC2Nvjp99KcxGN326xNn1yWJJdtESmsliMUr08tFfYf
         AOxYntl25yAeqU7LFt9CCFNEll5zjlO3EUk0LDvgJFrNrLRf12XwO5ohTDZU7QAv4mS6
         9Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVIcuDz6GjpOZ4yoklcTopWb9sLPnBO2BTPRQDHuze4=;
        b=lNpVzmFKg6vHwfdAuwvsBCEQNjmDgyu7DGdBPtT3i9FPzrjCYz6oOw/X4sNHfL9tGJ
         crvsGdUFvLd2Eh5NuNCOG7hQelDEXVY11YIRYn1PodOkmc//+Km6fbSQRcFRLXeHzLf0
         Hpxs89s1TO9Jbk+HRmHwDIWPxgUq3NunKZXigjIxVIbjU0WbtohtHeXPeie0k5Z6yRL3
         L3rgkeRaZeX66isYcitZfN65ChPZVRYFvI10HebbIac4CthUKcVF3nY9tSdIIRKO9ky7
         pmPpfcq88uInU1U2RQYdK2HC0f++QCdHfSX2S6E042ad+G2VAqVybOYJdl4rHjv/TK9q
         oKRA==
X-Gm-Message-State: AOAM530yrKROkJwEwyGnItvTIw8mzyy0Z+vMHkXmbRoEY72jbJOu47Tc
        XunOkNJ92y+MWfWa4A9gLWY=
X-Google-Smtp-Source: ABdhPJxWY1CDtE0jw55kAeDJ6p8q5IR4lBSTmWD24fQzgrqWE77Sm9GoOD+rl8eHcZbM2XpWOe3saw==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr3755541wro.427.1644468419618;
        Wed, 09 Feb 2022 20:46:59 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h17sm323089wmm.15.2022.02.09.20.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:46:59 -0800 (PST)
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
Subject: [PATCH 3/3] arm64: dts: meson: add support for OSMC Vero 4K+
Date:   Thu, 10 Feb 2022 04:46:47 +0000
Message-Id: <20220210044647.14443-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210044647.14443-1-christianshewitt@gmail.com>
References: <20220210044647.14443-1-christianshewitt@gmail.com>
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
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s905d-vero4k-plus.dts   | 125 ++++++++++++++++++
 2 files changed, 126 insertions(+)
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
index 000000000000..453d51a4b77e
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts
@@ -0,0 +1,125 @@
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
+	reserved-memory {
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
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
+		/* External PHY reset is shared with internal PHY Led signal */
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

