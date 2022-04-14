Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A295008E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiDNIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiDNIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:53 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA84692B6;
        Thu, 14 Apr 2022 01:52:15 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N8Won-1o0QGG03aj-014VyX;
 Thu, 14 Apr 2022 10:51:53 +0200
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
Subject: [PATCH v1 10/14] ARM: dts: imx6ull-colibri: add support for toradex iris carrier boards
Date:   Thu, 14 Apr 2022 10:51:02 +0200
Message-Id: <20220414085106.18621-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lGb6SsltbKX+oAQD5fN56Ds9TW1ox27OGFvrpqDyoNSIbNGQ+hf
 BrbjxKXOzUD+41S6U0Wct9WLLc56qjBZ5GRS1o82mQBK64rhHaLWcROPf/AUGimumTML+LA
 Si8XTVe39miYIX+ugwH/THf4nEHdrOqKFX3xoNu9KIm83JuhddBFhMya6j91wuC1ElIrTqY
 CIvkYhg0v/wGwXuiYTf+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DQyjwTc4JTA=:KfPPxn8GhVb0iCFj5bAGf7
 R6TldyMPhZC56Hiao5RGldtIf+8pS+lsSqoc8vx8aJwVE2z3oQjbChUwZ72CF8emS7VyP2+tq
 u3zAYYEASJRMOChdqqP0CtqJDypthGt6Yis+T/DtFqi1oX/bZNzh1LDFgPozG+S91Uz97jdyv
 aAvmQ/714K4PxwocRQmh3+xlJtiB63RFN3Y0d0G5rgbZpfRETFUEzaJ4ecva5SVoZzxtLr6lx
 TMff/TuZDtFb1C20OpM6KWOyGGxlJh4zM0KE+W2ZLG1cenYK196KcYGJhhq1YZlcDgA5d/5WW
 0kHHl/aHhn2ygW/RECHQpEFw/n9O/AWzgN5qryp/TmVPt66LoskhzItQ8tqeG7YwGqBgL0Bmu
 z1lHDkTAQwoR8DbSL2vR+JaPvH3Q0d3bTyl/1zqcS5N5O+JG/AZ4jbKuqD9hp2Dg9Cm1AuY65
 1l+6FGd0y/oZmcdzaeoUbWRLHR9nwkaXLhDPL51/+J7h+bLeVmWWxTZrpUeHINnswkZVc1Y2C
 O3BL/H2Pd3Xf7W1mlOIVJFaIZhUOrKBIWoYfZ3rBiHKzLHNbDBkeT37fQWkd6bRKnnIRazBTy
 kGzTABXrf4AISVz2a6eulvnks/KSMSsaZaiuimWrnmFgpszWnhpY4V4gaHk8f0nKIiw4PCgKg
 AZsoaUyNBea0gWjI+Dewk29gQmgbgJTk1nM+bVe/okjMnZj0JZojOQrCYNzx78p5lNGT/b2v7
 tuqC9LYSJ726cBg2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Drozdov <denys.drozdov@toradex.com>

Add support for Toradex Iris, small form-factor Pico-ITX Colibri Arm
Computer Module family carrier boards.

Iris Device Trees:
- imx6ull-colibri-iris.dtb
- imx6ull-colibri-emmc-iris.dtb
- imx6ull-colibri-wifi-iris.dtb

Iris-V2 Device Trees:
- imx6ull-colibri-iris-v2.dtb
- imx6ull-colibri-emmc-iris-v2.dtb
- imx6ull-colibri-wifi-iris-v2.dtb

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/Makefile                    |   6 +
 .../boot/dts/imx6ull-colibri-emmc-iris-v2.dts |  17 +++
 .../boot/dts/imx6ull-colibri-emmc-iris.dts    |  17 +++
 .../dts/imx6ull-colibri-emmc-nonwifi.dtsi     |   4 +-
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts |   6 +-
 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi |   5 +-
 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts |  28 ++++
 .../arm/boot/dts/imx6ull-colibri-iris-v2.dtsi |  27 ++++
 arch/arm/boot/dts/imx6ull-colibri-iris.dts    |  20 +++
 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi   | 132 ++++++++++++++++++
 .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi |   4 +-
 .../boot/dts/imx6ull-colibri-wifi-eval-v3.dts |   4 +-
 .../boot/dts/imx6ull-colibri-wifi-iris-v2.dts |  28 ++++
 .../boot/dts/imx6ull-colibri-wifi-iris.dts    |  20 +++
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   |   4 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        |   4 +-
 16 files changed, 311 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 252353fb4e3b..53b41ef092d9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -705,8 +705,14 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-mainboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-emmc-eval-v3.dtb \
+	imx6ull-colibri-emmc-iris.dtb \
+	imx6ull-colibri-emmc-iris-v2.dtb \
 	imx6ull-colibri-eval-v3.dtb \
+	imx6ull-colibri-iris.dtb \
+	imx6ull-colibri-iris-v2.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
+	imx6ull-colibri-wifi-iris.dtb \
+	imx6ull-colibri-wifi-iris-v2.dtb \
 	imx6ull-jozacp.dtb \
 	imx6ull-myir-mys-6ulx-eval.dtb \
 	imx6ull-opos6uldev.dtb \
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dts b/arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dts
new file mode 100644
index 000000000000..b9060c2f7977
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-emmc-nonwifi.dtsi"
+#include "imx6ull-colibri-iris-v2.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 1G (eMMC) on Colibri Iris V2";
+	compatible = "toradex,colibri-imx6ull-iris-v2",
+		     "toradex,colibri-imx6ull-emmc",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dts b/arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dts
new file mode 100644
index 000000000000..0ab71f2f5daa
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-emmc-nonwifi.dtsi"
+#include "imx6ull-colibri-iris.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 1GB (eMMC) on Colibri Iris";
+	compatible = "toradex,colibri-imx6ull-emmc-iris",
+		     "toradex,colibri-imx6ull-emmc",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
index a099abfdfa27..1d75bc671f75 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2021 Toradex
+ * Copyright 2022 Toradex
  */
 
 #include "imx6ull-colibri.dtsi"
diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
index 08669a18349e..9bf7111d7b00 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2018 Toradex AG
+ * Copyright 2018-2022 Toradex
  */
 
 /dts-v1/;
@@ -9,6 +9,6 @@
 #include "imx6ull-colibri-eval-v3.dtsi"
 
 / {
-	model = "Toradex Colibri iMX6ULL 256MB on Colibri Evaluation Board V3";
+	model = "Toradex Colibri iMX6ULL 256/512MB on Colibri Evaluation Board V3";
 	compatible = "toradex,colibri-imx6ull-eval", "fsl,imx6ull";
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index 3c07b4273e80..08197c66af12 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2017 Toradex AG
+ * Copyright 2017-2022 Toradex
  */
 
 / {
@@ -121,6 +121,7 @@ &uart5 {
 };
 
 &usbotg1 {
+	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
new file mode 100644
index 000000000000..47940a4ba6e6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-nonwifi.dtsi"
+#include "imx6ull-colibri-iris-v2.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 256M/512B on Colibri Iris V2";
+	compatible = "toradex,colibri-imx6ull-iris-v2",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
+
+&gpio1 {
+	lvds_tx_on {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtsi b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtsi
new file mode 100644
index 000000000000..93649cad0cc0
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2022 Toradex
+ */
+
+#include "imx6ull-colibri-iris.dtsi"
+
+/ {
+	reg_3v3_vmmc: regulator-3v3-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <100>;
+		enable-active-high;
+	};
+};
+
+
+&usdhc1 {
+	cap-power-off-card;
+	vmmc-supply = <&reg_3v3_vmmc>;
+	/delete-property/ keep-power-in-suspend;
+	/delete-property/ no-1-8-v;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris.dts b/arch/arm/boot/dts/imx6ull-colibri-iris.dts
new file mode 100644
index 000000000000..4fb97b0fe30b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-nonwifi.dtsi"
+#include "imx6ull-colibri-iris.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 256/512MB on Colibri Iris";
+	compatible = "toradex,colibri-imx6ull-iris",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi b/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
new file mode 100644
index 000000000000..eb30353e7fa8
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2022 Toradex
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
+&i2c1 {
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
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
+
+&gpio1 {
+	/*
+	 * uart25_tx_on turns the UART transceiver on. If one wants to turn the
+	 * transceiver off, that property has to be deleted and the gpio handled
+	 * in userspace.
+	 * The same applies to uart1_tx_on.
+	 */
+	uart25_tx_on {
+		gpio-hog;
+		gpios = <15 0>;
+		output-high;
+	};
+};
+
+&gpio2 {
+	uart1_tx_on {
+		gpio-hog;
+		gpios = <7 0>;
+		output-high;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
index 60f169227ad9..88901db255d6 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2018 Toradex AG
+ * Copyright 2018-2022 Toradex
  */
 
 #include "imx6ull-colibri.dtsi"
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
index df72ce1ae2cb..1d64d1a5d8a7 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2018 Toradex AG
+ * Copyright 2018-2022 Toradex
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
new file mode 100644
index 000000000000..ea610141a8bf
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-wifi.dtsi"
+#include "imx6ull-colibri-iris-v2.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 512MB on Colibri Iris V2";
+	compatible = "toradex,colibri-imx6ull-wifi-iris-v2",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
+
+&gpio1 {
+	lvds_tx_on {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts
new file mode 100644
index 000000000000..5ac1aa298ce7
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-wifi.dtsi"
+#include "imx6ull-colibri-iris.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 512MB on Colibri Iris";
+	compatible = "toradex,colibri-imx6ull-wifi-iris",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
index 3c47cfa7afa5..db59ee6b1c86 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2018 Toradex AG
+ * Copyright 2018-2022 Toradex
  */
 
 #include "imx6ull-colibri.dtsi"
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index a1e26ac4d1e7..59731ae7d04d 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2018-2021 Toradex
+ * Copyright 2018-2022 Toradex
  */
 
 #include "imx6ull.dtsi"
-- 
2.35.1

