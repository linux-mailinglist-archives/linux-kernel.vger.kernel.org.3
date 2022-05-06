Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1651DCAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443255AbiEFQCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiEFQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:02:29 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAD16D1B6;
        Fri,  6 May 2022 08:58:45 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MDiSu-1nbVt62E8c-00HAUO;
 Fri, 06 May 2022 17:58:27 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v1 24/24] ARM: dts: imx7-colibri: add support for Toradex Iris carrier boards
Date:   Fri,  6 May 2022 17:58:21 +0200
Message-Id: <20220506155821.297686-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yRWcy8MKdSGDIQxT6vwlwChUUwElSPtTpT4etGI8iGfj48gnvBD
 3J4hAC/Gmyp3Kv3zDU3bV418EvSV7n0ppwkYH5BryxaL/b9J9PvTEnjQE22v2j2KrnsyhB3
 HpafVq1kSnBZHDxFStBub7EJA8p6fARFGBPkzdsBG4gyM1eZIth//Oo0W4RoGTV2xVHq3YZ
 l6hFoi8+878cFZSkLeV6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iFSraCP1FAQ=:jR+L9QJeM9i5ZQyaSAYlo2
 vQvmfhemrQp10ZpNKiXxN6X/QAs42+oEHRB2ezu8bR5fK/gH/lWeOqxnuHdOOt8Dvfhaov4AE
 x2QHP/PzDU2NsOuR9kGz8jJYxSvv+eVLCH4VZFgLEgYPGvQx5w+A5kBCBljaL6RqHxr325ZSp
 IhZL9EhVc17ob0XVpymu8wbYorcReLVzQOkFg8ATzWwqQli6qPFPCpPGU1OC1bstQmp6X0TwA
 tiXaJBHPtGWaE8OUqmlMo3S6c/T3rU8XgnO9v01nzqtewKqbNkfhjus+u04olOwKXssHP3Aaj
 XzAJBr1PnRCLw/MuKl5KDa1FtlrcU6L8yanuXQsUng0uDf+OIHr5DCqbFgklZQsCth3nmQtNO
 2aaHLCUMpyioDNbqk/XsrtliT5fie0gnCBj4tSEp9ZPQP6YDRTDCfzMpHCAeIdDaZnkbDGwPR
 khdyp8h/OOkPQ8+k5xA9+F0U0kDOJCu0MEQLDtK0Hr70aTlX4S9ivcZwNi1hxFOvBBsnUH7z2
 Utkk1/tcgatHtOij/H8k3iVrDn5ZruikqBzS8EYK4+XHQz5AY9OAnnIgv5oIjbe0sylZt40nW
 9zTMhhpso7Vp39/PRSMlx6uCqGRrwWOmLa72FbNMLaRw3mKMn6DUa43h+iXXmp4dYMsiIjJxi
 O877SdftN51Eh8PoFtnfxPfeoNS6o2nRAaRiqocv14vCja/sEQRJr3mU4X6NB8fQsCD4AIGSk
 4EWZ6UPoUfbZ0rLfI6PWQfcL1nv0WA0ZwPfdFniUNXCJJHU6ZNVmklYcs9k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add support for Toradex Iris, small form-factor Pico-ITX Colibri Arm
Computer Module family Carrier Board.

Additional details available at
https://www.toradex.com/products/carrier-board/iris-carrier-board

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/Makefile                    |   6 +
 arch/arm/boot/dts/imx6dl-colibri-iris.dts     |   9 +-
 arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi   | 112 ++++++++++++++++++
 arch/arm/boot/dts/imx7-colibri-iris.dtsi      | 108 +++++++++++++++++
 .../boot/dts/imx7d-colibri-emmc-iris-v2.dts   |  21 ++++
 arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts |  21 ++++
 arch/arm/boot/dts/imx7d-colibri-iris-v2.dts   |  83 +++++++++++++
 arch/arm/boot/dts/imx7d-colibri-iris.dts      |  56 +++++++++
 arch/arm/boot/dts/imx7s-colibri-iris-v2.dts   |  78 ++++++++++++
 arch/arm/boot/dts/imx7s-colibri-iris.dts      |  51 ++++++++
 10 files changed, 540 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-colibri-iris.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-iris.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-iris.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b711d4423b42..5a9c805dbc84 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -726,8 +726,12 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-aster.dtb \
 	imx7d-colibri-emmc-aster.dtb \
+	imx7d-colibri-emmc-iris.dtb \
+	imx7d-colibri-emmc-iris-v2.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
 	imx7d-colibri-eval-v3.dtb \
+	imx7d-colibri-iris.dtb \
+	imx7d-colibri-iris-v2.dtb \
 	imx7d-flex-concentrator.dtb \
 	imx7d-flex-concentrator-mfg.dtb \
 	imx7d-mba7.dtb \
@@ -747,6 +751,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-zii-rpu2.dtb \
 	imx7s-colibri-aster.dtb \
 	imx7s-colibri-eval-v3.dtb \
+	imx7s-colibri-iris.dtb \
+	imx7s-colibri-iris-v2.dtb \
 	imx7s-mba7.dtb \
 	imx7s-warp.dtb
 dtb-$(CONFIG_SOC_IMX7ULP) += \
diff --git a/arch/arm/boot/dts/imx6dl-colibri-iris.dts b/arch/arm/boot/dts/imx6dl-colibri-iris.dts
index cf77d894f6d7..6e048d696c77 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-iris.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-iris.dts
@@ -40,11 +40,10 @@ &gpio2 {
 	pinctrl-0 = <&pinctrl_uart1_forceoff &pinctrl_uart23_forceoff>;
 
 	/*
-	 * uart-a-on-x13-enable turns the UART transceiver for UART_A on. If one
-	 * wants to turn the transceiver off, that property has to be deleted
-	 * and the gpio handled in userspace.
-	 * The same applies to uart-b-c-on-x14-enable where the UART_B and
-	 * UART_C transceiver is turned on.
+	 * uart-a-on-x13-enable-hog turns the UART transceiver for UART_A on. If one wants to turn
+	 * the transceiver off, that property has to be deleted and the gpio handled in userspace.
+	 * The same applies to uart-b-c-on-x14-enable-hog where the UART_B and UART_C transceiver is
+	 * turned on.
 	 */
 	uart-a-on-x13-enable-hog {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi b/arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
new file mode 100644
index 000000000000..6e199613583c
--- /dev/null
+++ b/arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/ {
+	reg_3v3_vmmc: regulator-3v3-vmmc {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio5 16 GPIO_ACTIVE_HIGH>; /* SODIMM 100 */
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3_vmmc";
+		startup-delay-us = <100>;
+	};
+};
+
+/* Colibri AD0 to AD3 */
+&adc1 {
+	status = "okay";
+};
+
+/* Colibri SSP */
+&ecspi3 {
+	status = "okay";
+};
+
+/* Colibri Fast Ethernet */
+&fec1 {
+	status = "okay";
+};
+
+&gpio2 {
+	/*
+	 * uart_b_c_on_x14_enable turns the UART transceiver for UART2 and 5 on. If one wants to
+	 * turn the transceiver off, that property has to be deleted and the gpio handled in
+	 * userspace.
+	 * The same applies to uart_a_on_x13_enable where the UART_A transceiver is turned on.
+	 */
+	uart-b-c-on-x14-enable-hog {
+		gpio-hog;
+		gpios = <27 GPIO_ACTIVE_HIGH>; /* SODIMM 104 */
+		output-high;
+	};
+};
+
+&gpio5 {
+	uart-a-on-x13-enable-hog {
+		gpio-hog;
+		gpios = <17 GPIO_ACTIVE_HIGH>; /* SODIMM 102 */
+		output-high;
+	};
+};
+
+/* Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 */
+&i2c4 {
+	status = "okay";
+};
+
+/* Colibri PWM<A> */
+&pwm1 {
+	status = "okay";
+};
+
+/* Colibri PWM<B> */
+&pwm2 {
+	status = "okay";
+};
+
+/* Colibri PWM<C> */
+&pwm3 {
+	status = "okay";
+};
+
+/* Colibri PWM<D> */
+&pwm4 {
+	status = "okay";
+};
+
+/* M41T0M6 real time clock */
+&rtc {
+	status = "okay";
+};
+
+/* Colibri UART_A */
+&uart1 {
+	status = "okay";
+};
+
+/* Colibri UART_B */
+&uart2 {
+	status = "okay";
+};
+
+/* Colibri UART_C */
+&uart3 {
+	status = "okay";
+};
+
+/* Colibri USBC */
+&usbotg1 {
+	status = "okay";
+};
+
+/* Colibri MMC/SD, UHS-I capable uSD slot */
+&usdhc1 {
+	cap-power-off-card;
+	/delete-property/ keep-power-in-suspend;
+	/delete-property/ no-1-8-v;
+	vmmc-supply = <&reg_3v3_vmmc>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7-colibri-iris.dtsi b/arch/arm/boot/dts/imx7-colibri-iris.dtsi
new file mode 100644
index 000000000000..175c5d478d2e
--- /dev/null
+++ b/arch/arm/boot/dts/imx7-colibri-iris.dtsi
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/* Colibri AD0 to AD3 */
+&adc1 {
+	status = "okay";
+};
+
+/*
+ * The Atmel maxtouch controller uses SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm2, pwm3.
+ * So if you enable following capacitive touch controller, disable pwm2/pwm3 first.
+ */
+&atmel_mxt_ts {
+	interrupt-parent = <&gpio1>;
+	interrupts = <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 / INT */
+	pinctrl-0 = <&pinctrl_atmel_adapter>;
+	reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;	/* SODIMM 30 / RST */
+};
+
+/* Colibri SSP */
+&ecspi3 {
+	status = "okay";
+};
+
+/* Colibri Fast Ethernet */
+&fec1 {
+	status = "okay";
+};
+
+&gpio2 {
+	/*
+	 * uart25 turns the UART transceiver for UART2 and 5 on. If one wants to turn the
+	 * transceiver off, that property has to be deleted and the gpio handled in userspace.
+	 * The same applies to uart1_tx_on where the UART1 transceiver is turned on.
+	 */
+	uart25-tx-on-hog {
+		gpio-hog;
+		gpios = <27 GPIO_ACTIVE_HIGH>; /* SODIMM 104 */
+		output-high;
+	};
+};
+
+&gpio5 {
+	uart1-tx-on-hog {
+		gpio-hog;
+		gpios = <17 GPIO_ACTIVE_HIGH>; /* SODIMM 102 */
+		output-high;
+	};
+};
+
+/* Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 */
+&i2c4 {
+	status = "okay";
+};
+
+/* Colibri PWM<A> */
+&pwm1 {
+	status = "okay";
+};
+
+/* Colibri PWM<B> */
+&pwm2 {
+	/* The pwm2 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
+	status = "okay";
+};
+
+/* Colibri PWM<C> */
+&pwm3 {
+	/* The pwm3 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
+	status = "okay";
+};
+
+/* Colibri PWM<D> */
+&pwm4 {
+	status = "okay";
+};
+
+/* M41T0M6 real time clock */
+&rtc {
+	status = "okay";
+};
+
+/* Colibri UART_A */
+&uart1 {
+	status = "okay";
+};
+
+/* Colibri UART_B */
+&uart2 {
+	status = "okay";
+};
+
+/* Colibri UART_C */
+&uart3 {
+	status = "okay";
+};
+
+/* Colibri USBC */
+&usbotg1 {
+	status = "okay";
+};
+
+/* Colibri MMC/SD */
+&usdhc1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
new file mode 100644
index 000000000000..7347659557f3
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+#include "imx7d-colibri-emmc.dtsi"
+#include "imx7-colibri-iris-v2.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7D 1GB on Iris V2 Carrier Board";
+	compatible = "toradex,colibri-imx7d-emmc-iris-v2",
+		     "toradex,colibri-imx7d-emmc",
+		     "toradex,colibri-imx7d",
+		     "fsl,imx7d";
+};
+
+/* Colibri USBH */
+&usbotg2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
new file mode 100644
index 000000000000..5324c92e368d
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+#include "imx7d-colibri-emmc.dtsi"
+#include "imx7-colibri-iris.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7D 1GB on Iris Carrier Board";
+	compatible = "toradex,colibri-imx7d-emmc-iris",
+		     "toradex,colibri-imx7d-emmc",
+		     "toradex,colibri-imx7d",
+		     "fsl,imx7d";
+};
+
+/* Colibri USBH */
+&usbotg2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-iris-v2.dts b/arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
new file mode 100644
index 000000000000..5762f51d5f0f
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+#include "imx7d-colibri.dtsi"
+#include "imx7-colibri-iris-v2.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7D on Iris V2 Carrier Board";
+	compatible = "toradex,colibri-imx7d-iris-v2",
+		     "toradex,colibri-imx7d",
+		     "fsl,imx7d";
+};
+
+&ad7879_ts {
+	status = "okay";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&gpio2 {
+	/*
+	 * This switches the LVDS transceiver to VESA color mapping mode.
+	 */
+	lvds-color-map-hog {
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>; /* SODIMM 95 */
+		line-name = "LVDS_COLOR_MAP";
+		output-low;
+	};
+};
+
+&gpio7 {
+	/*
+	 * This switches the LVDS transceiver to the 24-bit RGB mode.
+	 */
+	lvds-rgb-mode-hog {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_HIGH>; /* SODIMM 63 */
+		line-name = "LVDS_RGB_MODE";
+		output-low;
+	};
+
+	/*
+	 * This switches the LVDS transceiver to the single-channel
+	 * output mode.
+	 */
+	lvds-ch-mode-hog {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_HIGH>; /* SODIMM 55 */
+		line-name = "LVDS_CH_MODE";
+		output-high;
+	};
+
+	/* This turns the LVDS transceiver on */
+	lvds-power-on-hog {
+		gpio-hog;
+		gpios = <11 GPIO_ACTIVE_HIGH>; /* SODIMM 99 */
+		line-name = "LVDS_POWER_ON";
+		output-high;
+	};
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+/* Colibri USBH */
+&usbotg2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-iris.dts b/arch/arm/boot/dts/imx7d-colibri-iris.dts
new file mode 100644
index 000000000000..9c63cb9d9a64
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-iris.dts
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+#include "imx7d-colibri.dtsi"
+#include "imx7-colibri-iris.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7D on Iris Carrier Board";
+	compatible = "toradex,colibri-imx7d-iris",
+		     "toradex,colibri-imx7d",
+		     "fsl,imx7d";
+};
+
+&ad7879_ts {
+	status = "okay";
+};
+
+/*
+ * The Atmel maxtouch controller uses SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm2, pwm3.
+ * So if you enable following capacitive touch controller, disable pwm2/pwm3 first.
+ */
+&atmel_mxt_ts {
+	status = "disabled";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+/* Colibri PWM<B> */
+&pwm2 {
+	/* The pwm2 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
+	status = "okay";
+};
+
+/* Colibri PWM<C> */
+&pwm3 {
+	/* The pwm3 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
+	status = "okay";
+};
+
+/* Colibri USBH */
+&usbotg2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7s-colibri-iris-v2.dts b/arch/arm/boot/dts/imx7s-colibri-iris-v2.dts
new file mode 100644
index 000000000000..72b5c17ab1ab
--- /dev/null
+++ b/arch/arm/boot/dts/imx7s-colibri-iris-v2.dts
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+#include "imx7s-colibri.dtsi"
+#include "imx7-colibri-iris-v2.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7S on Iris V2 Carrier Board";
+	compatible = "toradex,colibri-imx7s-iris-v2",
+		     "toradex,colibri-imx7s",
+		     "fsl,imx7s";
+};
+
+&ad7879_ts {
+	status = "okay";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&gpio2 {
+	/*
+	 * This switches the LVDS transceiver to VESA color mapping mode.
+	 */
+	lvds-color-map-hog {
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>; /* SODIMM 95 */
+		line-name = "LVDS_COLOR_MAP";
+		output-low;
+	};
+};
+
+&gpio7 {
+	/*
+	 * This switches the LVDS transceiver to the 24-bit RGB mode.
+	 */
+	lvds-rgb-mode-hog {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_HIGH>; /* SODIMM 63 */
+		line-name = "LVDS_RGB_MODE";
+		output-low;
+	};
+
+	/*
+	 * This switches the LVDS transceiver to the single-channel
+	 * output mode.
+	 */
+	lvds-ch-mode-hog {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_HIGH>; /* SODIMM 55 */
+		line-name = "LVDS_CH_MODE";
+		output-high;
+	};
+
+	/* This turns the LVDS transceiver on */
+	lvds-power-on-hog {
+		gpio-hog;
+		gpios = <11 GPIO_ACTIVE_HIGH>; /* SODIMM 99 */
+		line-name = "LVDS_POWER_ON";
+		output-high;
+	};
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7s-colibri-iris.dts b/arch/arm/boot/dts/imx7s-colibri-iris.dts
new file mode 100644
index 000000000000..26ba72c17feb
--- /dev/null
+++ b/arch/arm/boot/dts/imx7s-colibri-iris.dts
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+#include "imx7s-colibri.dtsi"
+#include "imx7-colibri-iris.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7S on Iris Carrier Board";
+	compatible = "toradex,colibri-imx7s-iris",
+		     "toradex,colibri-imx7s",
+		     "fsl,imx7s";
+};
+
+&ad7879_ts {
+	status = "okay";
+};
+
+/*
+ * The Atmel maxtouch controller uses SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm2, pwm3.
+ * So if you enable following capacitive touch controller, disable pwm2/pwm3 first.
+ */
+&atmel_mxt_ts {
+	status = "disabled";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+/* Colibri PWM<B> */
+&pwm2 {
+	/* The pwm2 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
+	status = "okay";
+};
+
+/* Colibri PWM<C> */
+&pwm3 {
+	/* The pwm3 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
+	status = "okay";
+};
-- 
2.35.1

