Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1F51D918
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441802AbiEFNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392571AbiEFN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:54 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1481169CC4;
        Fri,  6 May 2022 06:25:09 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lkvx5-1oKvej1WKr-00anrC;
 Fri, 06 May 2022 15:24:52 +0200
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
Subject: [PATCH v3 09/13] ARM: dts: imx6ull-colibri: add support for toradex aster carrier boards
Date:   Fri,  6 May 2022 15:24:12 +0200
Message-Id: <20220506132416.273965-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DN2nvZMKX9eFKrCfEDKZ+tgQxg5KNMypDH0QIT83+nnua90pYTp
 NX3r3tGtrHnxmX8u09Q1WH795vtrQMnA/20hfvOqDRWcu7uySOc3qcHpX6OJ0qY1y2IUVME
 xG82q+kPkW2XBsSyrzwTteuTkWSy7UX6MvdvQyZbNVbKJ0evBOBF1gz7e6YfuUKwZdk0rIK
 9UUu88OeQemvd88BsJcVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kE3EHfeCyjQ=:g08za8R/86/0czyCyUggds
 P9Mj9DHGUTG4lihjBOUt3h7s2y9BKiTL0WRxYAN7Y8xUnjn/P49HJSUSdwkyy5OU2kag8sDf1
 Av89WkjkTwEPmqs3nOnODWGwT/CrSlRaveEuKHnM1289QMPrZTXgq4rjipwJOnexrgdnv87Se
 VzbL0UK3mOy1iL/8EKfK7Ft6ilYN9CdsVklOo7Edh8/TQNOoaySFYsmge5VlqF5U9fFR1jB8/
 cgTM1c543KA3b89UHT0+FQx7KQDDrR1OQaYW56Td6NchZ/HkFjdlWh3hPGnrBMGRBhya+/kKd
 ONXUmd4zZ0G/slZPyOeLmqAXWsatml8Jic9BHF/e9cocuXQP3WwoMPdyYXfyGWZJdLylgCeGu
 yXlcWbuQAjnLVBOHzEluhIcVEEqiXPVabZTHyyAHvZJHgmteyxt32vBZp+cfStbGUHPdxKsof
 CibqvSUP1RsRTZYcqOOEPrZUSMtowYeT6ZRR9pejp6hdswUeBLGAPYpWxZRNjBLbsr6Ug13cK
 Jb0EcMOHvT7PgQY+QMArjWqroyyvRNaR2N7+BeIxczERRj5Ee69fUp9itICWIXXoJ3VRbhqw4
 IJcGTOseY665M9NryUirbUBXFajyFCu3Q+tdJK891lVzEYDPOl+FlUdyUSukWTlrrIZmP16Sg
 6F75Vtf36SattGyUfeZdCzrNeE7ttZSwijB13vld+gjS2BuPWIQ3EP5uexVoTR2CKxVA=
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

Changes in v3:
- Re-based on top of Shawn's imx/dt branch.
- Dropped [PATCH v2 08/14] dt-bindings: arm: fsl: add
  toradex,colibri-imx6ull which already got applied by Shawn. Thanks!

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
index 6c737679165c..7dba9e37ff98 100644
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

