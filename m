Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7651D915
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbiEFNaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392637AbiEFN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:29:09 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66EDEDB;
        Fri,  6 May 2022 06:25:25 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MHmnb-1nnnpc17zp-003fxu;
 Fri, 06 May 2022 15:24:49 +0200
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
Subject: [PATCH v3 08/13] ARM: dts: imx6ull-colibri: add support for toradex iris carrier boards
Date:   Fri,  6 May 2022 15:24:11 +0200
Message-Id: <20220506132416.273965-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XVnGLvfT9RAgSXntsQzKOxA2U1aob3avOFMoEbCwf5u+/zWMXY7
 ebgVsLARLDFUaoz3s48dXkw671rt0ZvY36lZ/O60sbcVLJcDF8guPbIj33jC+dmGf4ONV1Q
 q67dK7utkkmZZ2teGzaJ6TI1+0f2t/Hb5tyXlEb3yoZzSuFRPLH5qUqEkq1xLdkGAUaL/09
 4MfEZffi8A7ipPvctH+mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X+G8Z4paqdg=:CAFvuYjvEA10rMcHipyBR2
 SXLtyA7ITq/WsynolOTLqN5eYjNo5Bkt874gXcq1fpm9qmhpC8Pg17yfZxDKSfS1MH4d1F67Q
 r0cuJoJobtoG7XAHnXZ//rh3L1D30tDAkohI6hAufrYWsNzXUHYEINbMpzXz7L6335/bNpr9E
 kjHm0jgJ2xVuJrU9oPTavRppj8KuSjcjaf0Mab1JE4Nl+8zvRjYPNmjo+Da6jzGliUj3I3t2N
 pC9JEopiVv5FrEIxiXg1ZW/1RHixE4qKHgsO1b3V4kQ+lPz1jrr0COohYJ/2EKD+D4eTbSzSH
 YAtjJgOJU8quCCFZB4H3qDhYqio7pDjCkHEYeY2s1eSYmM3KeI/QMxVPyjoU7evzll2s089uU
 OEtdtpry2SvtAr4Q6GuFvdWYzc2WNK1EQlhWV8a18+EzXzAdmkHnvw8Rr1vWJlbG8r7IvDhVM
 pEzMqJ7TMWUuZ4AJiM0gYBjAZK6AUNzrHTPsz0YUjPD/FwnzVAhWZ0iEPOkvB0QayQsTeg4bS
 X9Sq59vT1C7qy5sGS7QNpLB3kZLH7MrJvcLVyPRnt+hzD2ge8y4ORbU7egROBqUZl+RUW9dn2
 txnlOLwtgoExL0J1WHmP58RFl+081c4zYL/ay3hwQVEXAniNftgKZEQq/QZ130hWetT0+0oKC
 nB2Acfxom0suiG5cHJSLm8ZgELetduQzkKCqyUUlPmq/228+2Q8Sb6FNrT+ThV5998kyoqWiV
 DFWjysn7owLJB6B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v3:
- Replaced underscores by dashes in GPIO hog node names.
- Added more LVDS specific GPIO hogs in-line with other modules.

Changes in v2:
- Fix alphabetical node order as suggested by Shawn.

 arch/arm/boot/dts/Makefile                    |   6 +
 .../boot/dts/imx6ull-colibri-emmc-iris-v2.dts |  17 +++
 .../boot/dts/imx6ull-colibri-emmc-iris.dts    |  17 +++
 .../dts/imx6ull-colibri-emmc-nonwifi.dtsi     |   4 +-
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts |   6 +-
 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi |   5 +-
 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts |  65 +++++++++
 .../arm/boot/dts/imx6ull-colibri-iris-v2.dtsi |  27 ++++
 arch/arm/boot/dts/imx6ull-colibri-iris.dts    |  20 +++
 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi   | 132 ++++++++++++++++++
 .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi |   4 +-
 .../boot/dts/imx6ull-colibri-wifi-eval-v3.dts |   4 +-
 .../boot/dts/imx6ull-colibri-wifi-iris-v2.dts |  65 +++++++++
 .../boot/dts/imx6ull-colibri-wifi-iris.dts    |  20 +++
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   |   4 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        |   4 +-
 16 files changed, 385 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0ad8339e07d8..6c737679165c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -707,8 +707,14 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
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
index 000000000000..afc1e0119783
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
@@ -0,0 +1,65 @@
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
+	/* This turns the LVDS transceiver on */
+	lvds-power-on {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>; /* SODIMM 99 */
+		line-name = "LVDS_POWER_ON";
+		output-high;
+	};
+};
+
+&gpio2 {
+	/*
+	 * This switches the LVDS transceiver to the single-channel
+	 * output mode.
+	 */
+	lvds-ch-mode {
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_HIGH>; /* SODIMM 55 */
+		line-name = "LVDS_CH_MODE";
+		output-high;
+	};
+
+	/*
+	 * This switches the LVDS transceiver to the 24-bit RGB mode.
+	 */
+	lvds-rgb-mode {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_HIGH>; /* SODIMM 63 */
+		line-name = "LVDS_RGB_MODE";
+		output-low;
+	};
+};
+
+&gpio5 {
+	/*
+	 * This switches the LVDS transceiver to VESA color mapping mode.
+	 */
+	lvds-color-map {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_HIGH>; /* SODIMM 95 */
+		line-name = "LVDS_COLOR_MAP";
+		output-low;
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
index 000000000000..7f3b37baba88
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
index 000000000000..ce02f8a9ddd3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
@@ -0,0 +1,65 @@
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
+	/* This turns the LVDS transceiver on */
+	lvds-power-on {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>; /* SODIMM 99 */
+		line-name = "LVDS_POWER_ON";
+		output-high;
+	};
+};
+
+&gpio2 {
+	/*
+	 * This switches the LVDS transceiver to the single-channel
+	 * output mode.
+	 */
+	lvds-ch-mode {
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_HIGH>; /* SODIMM 55 */
+		line-name = "LVDS_CH_MODE";
+		output-high;
+	};
+
+	/*
+	 * This switches the LVDS transceiver to the 24-bit RGB mode.
+	 */
+	lvds-rgb-mode {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_HIGH>; /* SODIMM 63 */
+		line-name = "LVDS_RGB_MODE";
+		output-low;
+	};
+};
+
+&gpio5 {
+	/*
+	 * This switches the LVDS transceiver to VESA color mapping mode.
+	 */
+	lvds-color-map {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_HIGH>; /* SODIMM 95 */
+		line-name = "LVDS_COLOR_MAP";
+		output-low;
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
index 28baffcef096..e74dd98fa66a 100644
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

