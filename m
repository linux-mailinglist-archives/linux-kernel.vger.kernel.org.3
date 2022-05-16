Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55FB5286B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbiEPONo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbiEPONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:13:38 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26AA3B001;
        Mon, 16 May 2022 07:13:36 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MCc0S-1nysvc1IKA-009TOo;
 Mon, 16 May 2022 16:13:18 +0200
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
Subject: [PATCH v2 24/24] ARM: dts: imx7-colibri: add support for Toradex Iris carrier boards
Date:   Mon, 16 May 2022 16:13:13 +0200
Message-Id: <20220516141313.494569-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gJ7wOm1eo5meT2vDVGz+o1rdcGL9zqiyzJHwYUg6lrRTERJmyGj
 fZEZ9dDjlUzt2LsTf+b/p9bjiIQqBQFkZ+Ry+nHeV6s3vqT5AOWM7J21oW2cvyEkjbOqcan
 y9cUan3dSji1oNNMWeJJbBUd2iKcshJ7pK30VJmQPDYJrA4Wu6C5WeT5aWITAvYIMGXl7UK
 46BVcOpGkn6xpMVzMK/Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SA1kIogk4Js=:Ou40Mej/z7gI1C6zRERqEZ
 qvE5s1FxULrtuB+La64QJ1xjLeMTVOEseD+Tii6Cnxk3SOsFu3hKQ2jLZOsD87E5mh5U7OIin
 6ca472/Wmml3CpjEJwEiq+hS7grfW8SfMW19MrY5gGzPdqVXnsalO+6rjJsIsnXwclj4uqUOy
 K31L65EChVtnh67yovCg83s9rhMeRXh/Jwdoeuvyl5IAA5oR00S2xAXXuG9JaqNQQ1dkiOffB
 agDhiVOvCzgkAzW42tiq9V2US4QVo1s/DVBTjlQKPRtRBxuNtw1URUpszRJPJcaMnNox5GShw
 y35uxQgYjhF/S2qlmEVvUlj2fh+cNHN/6S1/LXp5cQyCiXLoDgOJB/fpS/jNKhPgrnhQYkjxH
 KOzsCdYeEGhxH+srRJOuACbKLCuhYcdBPip88W2PA/bJLbOlVDJTQOrm43DXFGB1lFHQTvxaa
 1P/HfztiAAES6NC1ROIStOxs8xF443rqCPu3Ao99weSYuHP8KtjZnlyTzKV3Yd2gceUP6j49C
 R33Pe+bzKVDLbuTXSRMtpRv4TfVxpY5CrVTJIxHj5KkXO8H2PagrvYe0WJabz3zuNOcNd+JcM
 rJGMeVUKu0VE0WfHNUJkTHW2Do3mklBUcNy1fiNFagQsp01PgplqV/+QmX3MDoa41gM4f2sv7
 8OgI4lErGYh8lCRZWAHvXfq8h1lXD4hE6vjYx36GNP7OioSz8oPaUb4eYG+vKD56FjG811pS6
 qHvoZIYpFjd0kgeX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
- Revert change on arch/arm/boot/dts/imx6dl-colibri-iris.dts which
  slipped into this patch set by error.
- Re-based on top of Shawn's for-next.

 arch/arm/boot/dts/Makefile                    |   6 +
 arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi   | 112 ++++++++++++++++++
 arch/arm/boot/dts/imx7-colibri-iris.dtsi      | 108 +++++++++++++++++
 .../boot/dts/imx7d-colibri-emmc-iris-v2.dts   |  21 ++++
 arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts |  21 ++++
 arch/arm/boot/dts/imx7d-colibri-iris-v2.dts   |  83 +++++++++++++
 arch/arm/boot/dts/imx7d-colibri-iris.dts      |  56 +++++++++
 arch/arm/boot/dts/imx7s-colibri-iris-v2.dts   |  78 ++++++++++++
 arch/arm/boot/dts/imx7s-colibri-iris.dts      |  51 ++++++++
 9 files changed, 536 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-colibri-iris.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-iris.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-iris.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a496c4751c86..e8c109d5e3bd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -735,8 +735,12 @@ dtb-$(CONFIG_SOC_IMX7D) += \
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
@@ -756,6 +760,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-zii-rpu2.dtb \
 	imx7s-colibri-aster.dtb \
 	imx7s-colibri-eval-v3.dtb \
+	imx7s-colibri-iris.dtb \
+	imx7s-colibri-iris-v2.dtb \
 	imx7s-mba7.dtb \
 	imx7s-warp.dtb
 dtb-$(CONFIG_SOC_IMX7ULP) += \
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

