Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECE948BD94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbiALDPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:15:14 -0500
Received: from out162-62-58-216.mail.qq.com ([162.62.58.216]:60615 "EHLO
        out162-62-58-216.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348774AbiALDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:15:09 -0500
X-Greylist: delayed 141720 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2022 22:15:08 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1641957306;
        bh=ncWG+lrjBteovL++31EbF/U4sbsDiS36FrWxO3Ytrco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vvLSChOyLJyZxKSK/LMhX1bJgEF4i2R/7iCNvSw5bXv9e73DEiwpByd+UjtDKiBvS
         HADK+90zDcQGnRgewJhlHgHRSZwhPCaHdNtmNQ0DOEqppXuqRd1Xfr5id+kCnEc6B3
         /oeqqyY8UOVWxbaWSbB4ceMPrd/AthIFFqwFuAXU=
Received: from fedora.. ([119.32.47.91])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 3711B294; Wed, 12 Jan 2022 11:13:49 +0800
X-QQ-mid: xmsmtpt1641957230t5swlvgq1
Message-ID: <tencent_00147CCBB6C9A0A0830DCE43F25DBC40A505@qq.com>
X-QQ-XMAILINFO: N+AV0Bxqx93Jgydw0V/gin4NV1csz72u8y7b2o0KD0BtV8vMvzb6OqMKg1LYJV
         T56lQjRRTYgeWXBtW8MyDrrStYVnces9EoojDyOVqItSp1H5gZv/MmusZeGIyIWKJxyHXWSXz8tI
         1DE8ZkYwXrs/61uSyiB59xOEpl31E+wJVZCv5cEfsLEJrMdiMLGJJsc36yKAqEbsJBsxoQwjRVKu
         hGoUSLS6UT9DyYkv2ZC1x41htrq7wavOlM5avx8E+AR1ShUUVKIcwwTHNxEFVkqioRc4FnsCnLWm
         xQ1Md3aOWyAP4z65lXvlGU/PZbB1JD63qMmZMqUE6exJcykJYyCYxFWxxHzGBLlSXhh5hLaIM4vD
         UKfOIkUm8yGBnrcPcJndzGR8NS7OTDFobyEj3r249diYJle07T6Bn5o3NR4A54fFn0t4BfA/BEm7
         pWMGKKHxwOTzwyh41q3YupWyU/nGWL+cvZRqGIwIpAlYYzlYSMbPq0q73eWE3pruqv2JK6GuBqgP
         wcYtrd9ol+0NB8rPOHkXQ+/Vr4SlGPnE9uR5zo3RhiPQhMj1jXBsU9NSdadLEzMOgTTO62XcX+z+
         ZQ0Qeoc/BfKl+OgYK2EPxsT9jn5FMdenPlTIyr2e0O30T2nmE7EDDqcqqCQDWNjW1iz3Rfrt0TAT
         tPb9LDVQAmsp84xxmcJDXYzCV0m4qPrjGV0rxGnIPzJhmwo5bbSIzfOGNTVft4wPL7dawR/vB0Yb
         jGmyea75O9pypnoXBcQL1WFMpWXrY0L5SJ6kU7359K0mqNmKwjI0iV5YA9D2MZg631kMBy6CxZKK
         zLPfjFxDmFHKwZTOWwYWy4IkNPhTwsfZPR/UVpoWDK1Qk4C1iHUAIYjsE0Z5E1ElVwZEKQr7+hZO
         ecmCUtyXWQOL2V2bC0rKuGT6bVq/axYeHusvMT4S/Fz2IwyyO4t1Y=
From:   Conley Lee <conleylee@foxmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conley Lee <conleylee@foxmail.com>
Subject: [PATCH v3 1/2] sun7i-a20-haoyu-marsboard.dts: add marsboard-a20 support
Date:   Wed, 12 Jan 2022 11:13:46 +0800
X-OQ-MSGID: <20220112031347.2492813-2-conleylee@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112031347.2492813-1-conleylee@foxmail.com>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
 <20220112031347.2492813-1-conleylee@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sun7i-a20-haoyu-marsboard.dts to support haoyu marsboard a20 SBC

Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun7i-a20-haoyu-marsboard.dts    | 183 ++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..5f1602d62927 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1219,6 +1219,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-icnova-swac.dtb \
 	sun7i-a20-lamobo-r1.dtb \
 	sun7i-a20-linutronix-testbox-v2.dtb \
+	sun7i-a20-haoyu-marsboard.dtb \
 	sun7i-a20-m3.dtb \
 	sun7i-a20-mk808c.dtb \
 	sun7i-a20-olimex-som-evb.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts b/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts
new file mode 100644
index 000000000000..4c6c6ae0c459
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 Conley Lee
+ * Conley Lee <conleylee@foxmail.com>
+ */
+
+/dts-v1/;
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "HAOYU Electronics Marsboard A20";
+	compatible = "haoyu,a20-marsboard", "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gmac_mii_pins {
+	pins = "PA0", "PA1", "PA2",
+	"PA3", "PA4", "PA5", "PA6",
+	"PA7", "PA8", "PA9", "PA10",
+	"PA11", "PA12", "PA13", "PA14",
+	"PA15", "PA16", "PA17";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_mii_pins>;
+	phy-handle = <&phy0>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
+	status = "okay";
+};
+
+&gmac_mdio {
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&reg_ahci_5v {
+	status = "okay";
+};
+
+#include "axp209.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1450000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.31.1

