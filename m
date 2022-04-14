Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9FF5008D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbiDNIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbiDNIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:52 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EEA66230;
        Thu, 14 Apr 2022 01:52:14 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MzQ0y-1nrvoq2wzo-00vPIy;
 Thu, 14 Apr 2022 10:51:57 +0200
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
Subject: [PATCH v1 11/14] ARM: dts: imx6ull-colibri: add support for toradex aster carrier boards
Date:   Thu, 14 Apr 2022 10:51:03 +0200
Message-Id: <20220414085106.18621-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s/d8+OhtDoA+sST0wFuPWRe/6NNBxseHzH//qRM0sEJOyvgS+hI
 PP52z0tWu0anqQ3zw1x0Ep6L5oultwBUIVmxytoXSm2MACxFADzM9+4kacgG2hurtIgya2C
 OpBYJblSNtrL/XUdCb5xZLHjQ8aI0tzBkP3LsOm6qTwcl6/lj1RJzb22P1pNKGqVBikm2eA
 MOKJ5TcHIn0DS0PKRy4dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:loiBPaUrHkM=:5RviezFiq05+y5EgleuH6z
 /M6EdO4+HBnEPYde0AnLmtajhKWIqvB4kebESo1cyi2K9uxqVp0aOiaDgmbv5u9ueKAwZVjPl
 igVLkcUrKcDAnHfM59qyZYUefvfZrBHvti/XxDrgjr2J3HiulOPIhrDmGa9fanVeJcOoYHVnO
 rtgGGM3Jog0DYCPkmDDsUBZcBRKTmT4dJGmIh4CSLdYpervemzsyT3Z6fFIi8wIJ/b58un2+l
 SNI9KeE8O2o4NzA5sk0Qt5IHPQvCzn2UOTiHxbHQSU1JCMZ4i8M6Y/RztfSIopdokFO9xUK3H
 wPiI0qaJsFzGz8GD4ygAZm/f7kBj2g1ETphI8mc0vTcw6PiCSqL3chNjqJksqhJXQ1UV8U4ht
 kwfe5p7FAgVhzYo9BE2z7AnT6BEtWicZfJo4mgFJIv/E2oEySa3UW/bKsQVZK7ByHg+n/bauR
 dlN8I7uH1ekSkAKt7TGu2i3q38wCsdSWwmtdkEm3v4sEJ84ELvPktppFa0c4hYzkSPBAKbbsM
 ovD9c1strSMGUXqjI+zl3NheqwOkSiwsMfnm5u3uNPGWkVxNu/j22LKNsc7VFcoikuqDaUuW4
 +cgdrcFsilqu5rTJl8xT1g6fSV1oE+OS7xVALx83mmQD0zZ92IBSKeyeU6wEY7tYdgfGgj68g
 2RlG/2cwXci589cpfsp9Ip831MZLtF5FpOwGtiUKOTQmZ+EQba7woV1qPNoaYdZjipIENqSC4
 +x69qhNUFXsvb6v3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 53b41ef092d9..2ba1ce9883c8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -704,12 +704,15 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
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

