Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0562750E5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbiDYQ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243537AbiDYQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:56 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359011F953;
        Mon, 25 Apr 2022 09:24:51 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M5dpW-1o71aO2Im0-00xYXo;
 Mon, 25 Apr 2022 18:24:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v2 10/14] ARM: dts: imx6ull-colibri: add support for toradex aster carrier boards
Date:   Mon, 25 Apr 2022 18:23:52 +0200
Message-Id: <20220425162356.176665-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425162356.176665-1-marcel@ziswiler.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Hzr4iHc16kut1SNComZgrRs7isdK2Ry5z8GurKHUydqJTTC1fQT
 ZKtj/cM4MAoNy294udAHPQDujvE7B+/A5GwSy3sYlCODuKxzV9KzRMBv+rizSOAQISv2WrQ
 cRlqd/90TWZFQWzUefnF4XdmkZmxriN7gAjQIUUSYzhuo/akePzPpWTE/2hlBZ8Emi2MNnq
 KqqmlK742DIUsOwF1gAfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L27nKVNhx7s=:k5VF5uqJSuiihzASpAUSa2
 0xiET0q86BMaG7NqS1vqcZCk55y38oyUUXY6juSRcuAUrCHm944CcieqVv1C+9jMM/ysWKcbE
 P6FWeP17t/fjlw5CseTUX6uc9ZKoluMUWPf+Os8wC1i5suHvSR80HuHwcM9yuOEKRjT9+xoY3
 QfZbbXZtJYRHhQE41JSgNH9THv6KOqiZoNld/+89+TG49WYaK7AkF7nIuKcNS/eQCec1isdcj
 NQ02UBo2M+l8tWUayNTL+dJLngb1UwT7OyzqBMlmS56ssWpZqw8nTlo7Z8J+vOhzQAz94x2FK
 FiZy96X1QZKtzdGsNOVg3MRkXDGJemAbQgFD3w850jb1V2LKzvhrP9VyZBr3+tGJFNe8P5W0D
 gAuZ7DoGTDorUfI0z+gCQDo3vj7sgAJHn/oomr4ds3CpIGcGqBNKNi9ppITYCmGVp1RY/P5fn
 idcfiCvvkBjlheMMPb7nmnqC5+ul+O6ALalWICJRuKBJmMOtgsyQrjLdHUSEtRuR7gU1xw913
 oxlmfJn//lmv5WlC0gOuHX0KGqTZgaFhpKzoFhJ/aOdoKtydaIdgeoOqo+zkPkTononilpNpu
 S5fUIT58dOdNajy79NIs6Rz8CeCi/wXieM1EBBJGy/qHcbswz+tuE2sxbU2c0/9d0hGLeXGK9
 9FGvbju1kMUmalllbXaZ/i5vDSGV2gLoNnwI6UWW7XNw1d9ItItmyVfSVca4s5nHjShE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Drozdov <denys.drozdov@toradex.com>

Add support for Toradex Aster, small form-factor Colibri Arm
Computer Module family carrier board.

Aster Device Trees:
- imx6ull-colibri-aster.dtb
- imx6ull-colibri-emmc-aster.dtb
- imx6ull-colibri-wifi-aster.dtb

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Dropped [PATCH v1 02/14] ARM: dts: imx6ull-colibri: fix vqmmc
  regulator which already got applied by Shawn. Thanks!

 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/imx6ull-colibri-aster.dts   |  20 +++
 arch/arm/boot/dts/imx6ull-colibri-aster.dtsi  | 145 ++++++++++++++++++
 .../boot/dts/imx6ull-colibri-emmc-aster.dts   |  17 ++
 .../boot/dts/imx6ull-colibri-wifi-aster.dts   |  20 +++
 5 files changed, 205 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-aster.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 727aa78443e1..011f0747fdb2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -706,12 +706,15 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
 	imx6ull-14x14-evk.dtb \
+	imx6ull-colibri-aster.dtb \
+	imx6ull-colibri-emmc-aster.dtb \
 	imx6ull-colibri-emmc-eval-v3.dtb \
 	imx6ull-colibri-emmc-iris.dtb \
 	imx6ull-colibri-emmc-iris-v2.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-iris.dtb \
 	imx6ull-colibri-iris-v2.dtb \
+	imx6ull-colibri-wifi-aster.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
 	imx6ull-colibri-wifi-iris.dtb \
 	imx6ull-colibri-wifi-iris-v2.dtb \
diff --git a/arch/arm/boot/dts/imx6ull-colibri-aster.dts b/arch/arm/boot/dts/imx6ull-colibri-aster.dts
new file mode 100644
index 000000000000..d3f2fb7c6c1e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-aster.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2017-2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-nonwifi.dtsi"
+#include "imx6ull-colibri-aster.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 256/512MB on Colibri Aster";
+	compatible = "toradex,colibri-imx6ull-aster",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-aster.dtsi b/arch/arm/boot/dts/imx6ull-colibri-aster.dtsi
new file mode 100644
index 000000000000..c9133ba2d705
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-aster.dtsi
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2017-2022 Toradex
+ */
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
+
+		power {
+			label = "Wake-Up";
+			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh_reg>;
+		regulator-name = "VCC_USB[1-4]";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 2 GPIO_ACTIVE_LOW>;
+		vin-supply = <&reg_5v0>;
+	};
+};
+
+&adc1 {
+	status = "okay";
+};
+
+&ecspi1 {
+	status = "okay";
+
+	num-cs = <2>;
+	cs-gpios = <
+		&gpio3 26 GPIO_ACTIVE_HIGH /* SODIMM 86 LCD_DATA21 */
+		&gpio4 28 GPIO_ACTIVE_HIGH /* SODIMM 65 CSI_DATA07 */
+	>;
+};
+
+/*
+ * Following SODIMM Pins should not be accessed as GPIO on Aster board:
+ * 134 - AIN5_SCL (no connection)
+ * 127 - Voltage Level Translator OE# signal (IC11 and IC12)
+ *
+ * To configure GPIO to LED5, please disable FEC2 and uncomment the following:
+ *	&iomuxc {
+ *		pinctrl-names = "default";
+ *		pinctrl-0 = <
+ *			&pinctrl_gpio1
+ *			&pinctrl_gpio2
+ *			&pinctrl_gpio3
+ *			&pinctrl_gpio4
+ *			&pinctrl_gpio6 - for non-WiFi modules only
+ *			&pinctrl_gpio7
+ *			&pinctrl_gpio_aster
+ *		>;
+ *
+ *		pinctrl_gpio_aster: gpio-aster {
+ *			fsl,pins = <
+ *				MX6UL_PAD_GPIO1_IO07__GPIO1_IO07    0x1b0b0
+ *			>;
+ *		};
+ *  };
+ */
+
+&i2c1 {
+	status = "okay";
+
+	m41t0m6: rtc@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+	};
+};
+
+/* PWM <A> */
+&pwm4 {
+	status = "okay";
+};
+
+/* PWM <B> */
+&pwm5 {
+	status = "okay";
+};
+
+/* PWM <C> */
+&pwm6 {
+	status = "okay";
+};
+
+/* PWM <D> */
+&pwm7 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usbh_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usbh_vbus>;
+	status = "okay";
+};
+
+&usdhc1 {
+	vmmc-supply = <&reg_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dts b/arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dts
new file mode 100644
index 000000000000..919c0464d6cb
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-emmc-nonwifi.dtsi"
+#include "imx6ull-colibri-aster.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 1GB (eMMC) on Colibri Aster";
+	compatible = "toradex,colibri-imx6ull-emmc-aster",
+		     "toradex,colibri-imx6ull-emmc",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts
new file mode 100644
index 000000000000..b4f65e8c5857
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2017-2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-wifi.dtsi"
+#include "imx6ull-colibri-aster.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 512MB on Colibri Aster";
+	compatible = "toradex,colibri-imx6ull-wifi-aster",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
-- 
2.35.1

