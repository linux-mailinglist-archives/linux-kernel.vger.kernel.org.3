Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A7D487BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348858AbiAGSFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:05:03 -0500
Received: from mout.perfora.net ([74.208.4.194]:37321 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240533AbiAGSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:54 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N4hat-1mPnQa3Nm3-011l5g;
 Fri, 07 Jan 2022 19:04:28 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/14] arm64: dts: freescale: add initial support for verdin imx8m mini
Date:   Fri,  7 Jan 2022 19:03:14 +0100
Message-Id: <20220107180314.1816515-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EAT7Pwiw54w7e1Y1AEUiYdQDTeSffmOz0zL+Tg46aKmccE5atWE
 m/wJvoA7RLfkBLdcr0RgiRxk9Ke4NdKbWUBr3NgX5OMmaikh4pV/+t9RidA95nkdKh7Gpfl
 gkhzQiCVy6BUg/rJZWMh2avsqGxdSTiMRHo6qEznKEM3o+gTc5HnRODXBucZS14QVNc3Sy5
 B0up8P6DE8vKY/0+HMGyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Zi0lvLaghU=:Wnu3yUE8HqR24KiP6hmNpr
 A1l/RjfXBThRpeKKKK/L8Kv136Lonzuzy7wwERd/WKWIug3E6JROKeKSK0xMomz9ylAqqDkJn
 2xbIhjkrAk3mzGzFTILF9obNhcW7/MHQGFi7O826mO02OMTpXvc472HvJIK0rGklb+vVz87e4
 B1UKZ6JNF7mL8r6cmaEkwZb6u3g19LQS9hXGC1jaHtOZrMULk40NjrGl3LKJuWghoj1ffPcaz
 9As2ulctLK8D9+FLEUi+f5QjoqVStE6EjPgMw0DlHMcAxYNn902ItK96l6+v+C4H4kPQ95oN8
 pE7/XUqdhXUuHkcBAlmNZUaDv8/giV8VAQdSe8m57h9cjNNvoTMJ6WNCl4b9Y1MjsyioamzYU
 x8c0zdgbGW1zfsXSWGNkX0eJuRenRER61amf61uAnAfSucc5xXjdsgOUZlcgrsC+J6CiRlp3r
 /EUZFPIeSxPbD880lsWWKdaobpJpXywbbuWQl2XJba4LyLQbiCmfTCDWbOtq86jVB1vAwJtCQ
 IK1v9NCHgVWLnwIMGpBC+BJX5/wbTe9cX4+Lmp5NYoBKtHMDC56dfZlKS0J6C05B8pS63MyXu
 kUu41xUQH4CllqzkH9Uo8csdMx2hQ/BHgoNAyUg0RPvicDRm2X/M6WJIkzxE91rxt+332LBO3
 Wl54cAgyRGwhmw5fdnvysn1FyprL/Kmcb10mT54BXK8xP5cBYcM16O+/y0+zN6Okz/aHYxdrJ
 WdLGD6tEWuUeEdW9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This patch adds the device tree to support Toradex Verdin iMX8M Mini a
computer on module which can be used on different carrier boards.

The module consists of an NXP i.MX 8M Mini family SoC (either i.MX 8M
Mini Quad or 8M Mini DualLite), a PCA9450A PMIC, a Gigabit Ethernet PHY,
1 or 2 GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC, an I2C EEPROM, an
RX8130 RTC, an optional SPI CAN controller plus an optional Bluetooth/
Wi-Fi module.

Anything that is not self-contained on the module is disabled by
default.

The device tree for the Dahlia includes the module's device tree and
enables the supported peripherals of the carrier board.

The device tree for the Verdin Development Board includes the module's
device tree as well as the Dahlia one as it is a superset and supports
almost all peripherals available.

So far there is no display functionality supported at all but basic
console UART, USB host, eMMC and Ethernet and PCIe functionality work
fine.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm64/boot/dts/freescale/Makefile        |    4 +
 .../dts/freescale/imx8mm-verdin-dahlia.dtsi   |  143 ++
 .../boot/dts/freescale/imx8mm-verdin-dev.dtsi |   67 +
 .../imx8mm-verdin-nonwifi-dahlia.dts          |   18 +
 .../freescale/imx8mm-verdin-nonwifi-dev.dts   |   18 +
 .../dts/freescale/imx8mm-verdin-nonwifi.dtsi  |   75 +
 .../freescale/imx8mm-verdin-wifi-dahlia.dts   |   18 +
 .../dts/freescale/imx8mm-verdin-wifi-dev.dts  |   18 +
 .../dts/freescale/imx8mm-verdin-wifi.dtsi     |   95 ++
 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 1277 +++++++++++++++++
 10 files changed, 1733 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 6d8f0a532587..04380f2e44a2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -63,6 +63,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dahlia.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dev.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dahlia.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
new file mode 100644
index 000000000000..b5bf025c74a2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/ {
+	sound_card: sound-card {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,name = "imx8mm-wm8904";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"Headphone Jack", "MICBIAS",
+			"IN1L", "Headphone Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Headphone Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+
+		dailink_master: simple-audio-card,codec {
+			clocks = <&clk IMX8MM_CLK_SAI2_ROOT>;
+			sound-dai = <&wm8904_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+	};
+};
+
+/* Verdin SPI_1 */
+&ecspi2 {
+	status = "okay";
+};
+
+/* EEPROM on display adapter boards */
+&eeprom_display_adapter {
+	status = "okay";
+};
+
+/* EEPROM on Verdin Development board */
+&eeprom_carrier_board {
+	status = "okay";
+};
+
+&fec1 {
+	status = "okay";
+};
+
+/* Verdin QSPI_1 */
+&flexspi {
+	status = "okay";
+};
+
+/* Current measurement into module VCC */
+&hwmon {
+	status = "okay";
+};
+
+&hwmon_temp {
+	vs-supply = <&reg_1p8v>;
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+/* Verdin I2C_1 */
+&i2c4 {
+	status = "okay";
+
+	/* Audio Codec */
+	wm8904_1a: codec@1a {
+		compatible = "wlf,wm8904";
+		AVDD-supply = <&reg_3p3v>;
+		clocks = <&clk IMX8MM_CLK_SAI2_ROOT>;
+		clock-names = "mclk";
+		CPVDD-supply = <&reg_3p3v>;
+		DBVDD-supply = <&reg_3p3v>;
+		DCVDD-supply = <&reg_3p3v>;
+		MICVDD-supply = <&reg_3p3v>;
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+/* Verdin PCIE_1 */
+
+/* Verdin PWM_3_DSI */
+&pwm1 {
+	status = "okay";
+};
+
+/* Verdin PWM_1 */
+&pwm2 {
+	status = "okay";
+};
+
+/* Verdin PWM_2 */
+&pwm3 {
+	status = "okay";
+};
+
+/* VERDIN I2S_1 */
+&sai2 {
+	status = "okay";
+};
+
+/* Verdin UART_3 */
+&uart1 {
+	status = "okay";
+};
+
+/* Verdin UART_1 */
+&uart2 {
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&uart3 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usbotg1 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usbotg2 {
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&usdhc2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
new file mode 100644
index 000000000000..f35d22dc546b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+#include "imx8mm-verdin-dahlia.dtsi"
+
+/ {
+	sound_card: sound-card {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,name = "imx8mm-nau8822";
+		simple-audio-card,routing =
+			"Headphones", "LHP",
+			"Headphones", "RHP",
+			"Speaker", "LSPK",
+			"Speaker", "RSPK",
+			"Line Out", "AUXOUT1",
+			"Line Out", "AUXOUT2",
+			"LAUX", "Line In",
+			"RAUX", "Line In",
+			"LMICP", "Mic In",
+			"RMICP", "Mic In";
+		simple-audio-card,widgets =
+			"Headphones", "Headphones",
+			"Line Out", "Line Out",
+			"Speaker", "Speaker",
+			"Microphone", "Mic In",
+			"Line", "Line In";
+
+		dailink_master: simple-audio-card,codec {
+			clocks = <&clk IMX8MM_CLK_SAI2_ROOT>;
+			sound-dai = <&nau8822_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+	};
+};
+
+&gpio_expander_21 {
+	status = "okay";
+};
+
+/* Verdin I2C_1 */
+&i2c4 {
+	/* Audio Codec */
+	nau8822_1a: codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a>;
+	};
+};
+
+/* Verdin UART_1, connector X50 through RS485 transceiver */
+&uart2 {
+	linux,rs485-enabled-at-boot-time;
+	rs485-rts-active-low;
+	rs485-rx-during-tx;
+};
+
+/* Limit frequency on dev board due to long traces and bad signal integrity */
+&usdhc2 {
+	max-frequency = <100000000>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dts b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dts
new file mode 100644
index 000000000000..d64ff378a152
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mm-verdin.dtsi"
+#include "imx8mm-verdin-nonwifi.dtsi"
+#include "imx8mm-verdin-dahlia.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Mini on Dahlia Board";
+	compatible = "toradex,verdin-imx8mm-nonwifi-dahlia",
+		     "toradex,verdin-imx8mm-nonwifi",
+		     "toradex,verdin-imx8mm",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dts b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dts
new file mode 100644
index 000000000000..6ae71ecac8de
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mm-verdin.dtsi"
+#include "imx8mm-verdin-nonwifi.dtsi"
+#include "imx8mm-verdin-dev.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Mini on Verdin Development Board";
+	compatible = "toradex,verdin-imx8mm-nonwifi-dev",
+		     "toradex,verdin-imx8mm-nonwifi",
+		     "toradex,verdin-imx8mm",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi.dtsi
new file mode 100644
index 000000000000..9aff9dde1a02
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+&gpio3 {
+	gpio-line-names = "SODIMM_52",
+			  "SODIMM_54",
+			  "SODIMM_64",
+			  "SODIMM_21",
+			  "SODIMM_206",
+			  "SODIMM_76",
+			  "SODIMM_56",
+			  "SODIMM_58",
+			  "SODIMM_60",
+			  "SODIMM_62",
+			  "SODIMM_162",
+			  "SODIMM_164",
+			  "SODIMM_166",
+			  "SODIMM_168",
+			  "SODIMM_66",
+			  "SODIMM_17",
+			  "",
+			  "SODIMM_156",
+			  "SODIMM_160",
+			  "SODIMM_244",
+			  "SODIMM_250",
+			  "SODIMM_48",
+			  "SODIMM_44",
+			  "SODIMM_42",
+			  "SODIMM_46";
+};
+
+&gpio4 {
+	gpio-line-names = "SODIMM_102",
+			  "SODIMM_90",
+			  "SODIMM_92",
+			  "SODIMM_94",
+			  "SODIMM_96",
+			  "SODIMM_100",
+			  "SODIMM_148",
+			  "SODIMM_152",
+			  "SODIMM_154",
+			  "SODIMM_174",
+			  "SODIMM_120",
+			  "SODIMM_104",
+			  "SODIMM_106",
+			  "SODIMM_108",
+			  "SODIMM_112",
+			  "SODIMM_114",
+			  "SODIMM_116",
+			  "SODIMM_150",
+			  "SODIMM_118",
+			  "",
+			  "SODIMM_88",
+			  "SODIMM_149",
+			  "SODIMM_147",
+			  "SODIMM_36",
+			  "SODIMM_32",
+			  "SODIMM_30",
+			  "SODIMM_34",
+			  "SODIMM_38",
+			  "SODIMM_252",
+			  "SODIMM_133",
+			  "SODIMM_135",
+			  "SODIMM_129";
+};
+
+&usdhc3 {
+	bus-width = <4>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dts b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dts
new file mode 100644
index 000000000000..d424c475cba1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mm-verdin.dtsi"
+#include "imx8mm-verdin-wifi.dtsi"
+#include "imx8mm-verdin-dahlia.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Mini WB on Dahlia Board";
+	compatible = "toradex,verdin-imx8mm-wifi-dahlia",
+		     "toradex,verdin-imx8mm-wifi",
+		     "toradex,verdin-imx8mm",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dts b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dts
new file mode 100644
index 000000000000..ef952021832e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mm-verdin.dtsi"
+#include "imx8mm-verdin-wifi.dtsi"
+#include "imx8mm-verdin-dev.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Mini WB on Verdin Development Board";
+	compatible = "toradex,verdin-imx8mm-wifi-dev",
+		     "toradex,verdin-imx8mm-wifi",
+		     "toradex,verdin-imx8mm",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi
new file mode 100644
index 000000000000..c400770c1df5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/ {
+	reg_wifi_en: regulator-wifi-en {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 25 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_pwr_en>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "PDn_AW-CM276NF";
+		startup-delay-us = <2000>;
+	};
+};
+
+/* On-module Wi-Fi */
+&usdhc3 {
+	bus-width = <4>;
+	keep-power-in-suspend;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_wifi_ctrl>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_wifi_ctrl>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_wifi_ctrl>;
+	vmmc-supply = <&reg_wifi_en>;
+	wifi-host;
+	status = "okay";
+};
+
+&gpio3 {
+	gpio-line-names = "SODIMM_52",
+			  "SODIMM_54",
+			  "SODIMM_64",
+			  "SODIMM_21",
+			  "SODIMM_206",
+			  "SODIMM_76",
+			  "SODIMM_56",
+			  "SODIMM_58",
+			  "SODIMM_60",
+			  "SODIMM_62",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_66",
+			  "SODIMM_17",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_244",
+			  "SODIMM_250",
+			  "SODIMM_48",
+			  "SODIMM_44",
+			  "SODIMM_42",
+			  "SODIMM_46";
+};
+
+&gpio4 {
+	gpio-line-names = "SODIMM_102",
+			  "SODIMM_90",
+			  "SODIMM_92",
+			  "SODIMM_94",
+			  "SODIMM_96",
+			  "SODIMM_100",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_174",
+			  "SODIMM_120",
+			  "SODIMM_104",
+			  "SODIMM_106",
+			  "SODIMM_108",
+			  "SODIMM_112",
+			  "SODIMM_114",
+			  "SODIMM_116",
+			  "",
+			  "SODIMM_118",
+			  "",
+			  "SODIMM_88",
+			  "SODIMM_149",
+			  "SODIMM_147",
+			  "SODIMM_36",
+			  "SODIMM_32",
+			  "SODIMM_30",
+			  "SODIMM_34",
+			  "SODIMM_38",
+			  "SODIMM_252",
+			  "SODIMM_133",
+			  "SODIMM_135",
+			  "SODIMM_129";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
new file mode 100644
index 000000000000..23eb695a5266
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -0,0 +1,1277 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+#include "dt-bindings/pwm/pwm.h"
+#include "imx8mm.dtsi"
+
+/ {
+	chosen {
+		bootargs = "console=ttymxc0,115200 earlycon";
+		stdout-path = &uart1;
+	};
+
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = &snvs_rtc;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
+		/* Verdin I2S_2_D_OUT (DSI_1_BKL_EN/DSI_1_BKL_EN_LVDS, SODIMM 46) */
+		enable-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s_2_d_out_dsi_1_bkl_en>;
+		power-supply = <&reg_3p3v>;
+		/* Verdin PWM_3_DSI/PWM_3_DSI_LVDS (SODIMM 19) */
+		pwms = <&pwm1 0 6666667 PWM_POLARITY_INVERTED>;
+		status = "disabled";
+	};
+
+	/* Fixed clock dedicated to SPI CAN controller */
+	clk20m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <20000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		wakeup {
+			debounce-interval = <10>;
+			/* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
+			gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
+	/* Carrier Board Supplies */
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_5p0v: regulator-5p0v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "+V5_SW";
+	};
+
+	/* Non PMIC On-module Supplies */
+	reg_ethphy: regulator-ethphy {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>; /* PMIC_EN_ETH */
+		off-on-delay = <500000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_eth>;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_ETH";
+		startup-delay-us = <200000>;
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		/* Verdin USB_1_EN (SODIMM 155) */
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1_en>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb_otg1_vbus";
+	};
+
+	reg_usb_otg2_vbus: regulator-usb-otg2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		/* Verdin USB_2_EN (SODIMM 185) */
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_en>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb_otg2_vbus";
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		/* Verdin SD_1_PWR_EN (SODIMM 76) */
+		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+		off-on-delay = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SD";
+		startup-delay-us = <2000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* Use the kernel configuration settings instead */
+		/delete-node/ linux,cma;
+
+		rpmsg_reserved: rpmsg@b8000000 {
+			no-map;
+			reg = <0 0xb8000000 0 0x400000>;
+		};
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&ddrc {
+	operating-points-v2 = <&ddrc_opp_table>;
+
+	ddrc_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-25M {
+			opp-hz = /bits/ 64 <25000000>;
+		};
+
+		opp-100M {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+
+		opp-750M {
+			opp-hz = /bits/ 64 <750000000>;
+		};
+	};
+};
+
+/* Verdin SPI_1 */
+&ecspi2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+};
+
+/* Verdin CAN_1 and CAN_2 (On-module) */
+&ecspi3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>,
+		   <&gpio1 5 GPIO_ACTIVE_LOW>;
+	spi-num-chipselects = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+
+	can1: can@0 {
+		compatible = "microchip,mcp251xfd";
+		clocks = <&clk20m>;
+		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can1_int>;
+		reg = <0>;
+		spi-max-frequency = <8500000>;
+	};
+
+	can2: can@1 {
+		compatible = "microchip,mcp251xfd";
+		clocks = <&clk20m>;
+		interrupts-extended = <&gpio1 7 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can2_int>;
+		reg = <1>;
+		spi-max-frequency = <8500000>;
+		/* Not assembled on regular SKUs */
+		status = "disabled";
+	};
+};
+
+/* Verdin ETH_1 (On-module PHY) */
+&fec1 {
+	fsl,magic-packet;
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&reg_ethphy>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_fec1>;
+	pinctrl-1 = <&pinctrl_fec1_sleep>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@7 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			interrupt-parent = <&gpio1>;
+			interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+			micrel,led-mode = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+/* Verdin QSPI_1 */
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+#if 0
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+	};
+#endif
+};
+
+&gpio1 {
+	gpio-line-names = "SODIMM_216",
+			  "SODIMM_19",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_220",
+			  "SODIMM_222",
+			  "",
+			  "SODIMM_218",
+			  "SODIMM_155",
+			  "SODIMM_157",
+			  "SODIMM_185",
+			  "SODIMM_187";
+};
+
+&gpio2 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_84",
+			  "SODIMM_78",
+			  "SODIMM_74",
+			  "SODIMM_80",
+			  "SODIMM_82",
+			  "SODIMM_70",
+			  "SODIMM_72";
+};
+
+&gpio5 {
+	gpio-line-names = "SODIMM_131",
+			  "",
+			  "SODIMM_91",
+			  "SODIMM_16",
+			  "SODIMM_15",
+			  "SODIMM_208",
+			  "SODIMM_137",
+			  "SODIMM_139",
+			  "SODIMM_141",
+			  "SODIMM_143",
+			  "SODIMM_196",
+			  "SODIMM_200",
+			  "SODIMM_198",
+			  "SODIMM_202",
+			  "",
+			  "",
+			  "SODIMM_55",
+			  "SODIMM_53",
+			  "SODIMM_95",
+			  "SODIMM_93",
+			  "SODIMM_14",
+			  "SODIMM_12",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_210",
+			  "SODIMM_212",
+			  "SODIMM_151",
+			  "SODIMM_153";
+
+	ctrl_sleep_moci-hog {
+		gpio-hog;
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpios = <1 GPIO_ACTIVE_HIGH>;
+		line-name = "CTRL_SLEEP_MOCI#";
+		output-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
+	};
+};
+
+/* On-module I2C */
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	pca9450: pmic@25 {
+		compatible = "nxp,pca9450a";
+		interrupt-parent = <&gpio1>;
+		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		reg = <0x25>;
+		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			reg_vdd_soc: BUCK1 {
+				nxp,dvs-run-voltage = <850000>;
+				nxp,dvs-standby-voltage = <800000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <850000>;
+				regulator-min-microvolt = <800000>;
+				regulator-name = "+VDD_SOC";
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_vdd_arm: BUCK2 {
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "+VDD_ARM";
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_vdd_dram: BUCK3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "+VDD_GPU_VPU_DDR";
+			};
+
+			reg_vdd_3v3: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "+V3.3";
+			};
+
+			reg_vdd_1v8: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "PWR_1V8_MOCI";
+			};
+
+			reg_nvcc_dram: BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1100000>;
+				regulator-min-microvolt = <1100000>;
+				regulator-name = "+VDD_DDR";
+			};
+
+			reg_nvcc_snvs: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "+V1.8_SNVS";
+			};
+
+			reg_vdd_snvs: LDO2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <900000>;
+				regulator-min-microvolt = <800000>;
+				regulator-name = "+V0.8_SNVS";
+			};
+
+			reg_vdda: LDO3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "+V1.8A";
+			};
+
+			reg_vdd_phy: LDO4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <900000>;
+				regulator-min-microvolt = <900000>;
+				regulator-name = "+V0.9_MIPI";
+			};
+
+			reg_nvcc_sd: LDO5 {
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "+V3.3_1.8_SD";
+			};
+		};
+	};
+
+	rtc_i2c: rtc@32 {
+		compatible = "epson,rx8130";
+		reg = <0x32>;
+	};
+
+	adc@49 {
+		compatible = "ti,ads1015";
+		reg = <0x49>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Verdin I2C_1 (ADC_4 - ADC_3) */
+		channel@0 {
+			reg = <0>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin I2C_1 (ADC_4 - ADC_1) */
+		channel@1 {
+			reg = <1>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin I2C_1 (ADC_3 - ADC_1) */
+		channel@2 {
+			reg = <2>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin I2C_1 (ADC_2 - ADC_1) */
+		channel@3 {
+			reg = <3>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin I2C_1 ADC_4 */
+		channel@4 {
+			reg = <4>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin I2C_1 ADC_3 */
+		channel@5 {
+			reg = <5>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin I2C_1 ADC_2 */
+		channel@6 {
+			reg = <6>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin I2C_1 ADC_1 */
+		channel@7 {
+			reg = <7>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+	};
+
+	eeprom@50 {
+		compatible = "st,24c02";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
+};
+
+/* Verdin I2C_2_DSI */
+&i2c2 {
+	clock-frequency = <10000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "disabled";
+};
+
+/* Verdin I2C_3_HDMI N/A */
+
+/* Verdin I2C_4_CSI */
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* Verdin I2C_1 */
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	gpio_expander_21: gpio-expander@21 {
+		compatible = "nxp,pcal6416";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x21>;
+		status = "disabled";
+		vcc-supply = <&reg_3p3v>;
+	};
+
+	lvds_ti_sn65dsi83: bridge@2c {
+		compatible = "ti,sn65dsi83";
+		/* Verdin GPIO_9_DSI (SN65DSI84 IRQ, SODIMM 17, unused) */
+		/* Verdin GPIO_10_DSI (SODIMM 21) */
+		enable-gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_10_dsi>;
+		reg = <0x2c>;
+		status = "disabled";
+	};
+
+	/* Current measurement into module VCC */
+	hwmon: hwmon@40 {
+		compatible = "ti,ina219";
+		reg = <0x40>;
+		shunt-resistor = <10000>;
+		status = "disabled";
+	};
+
+	hdmi_lontium_lt8912: hdmi@48 {
+		compatible = "lontium,lt8912b";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_10_dsi>, <&pinctrl_pwm_3_dsi_hpd_gpio>;
+		reg = <0x48>;
+		/* Verdin GPIO_9_DSI (LT8912 INT, SODIMM 17, unused) */
+		/* Verdin GPIO_10_DSI (SODIMM 21) */
+		reset-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+		status = "disabled";
+	};
+
+	atmel_mxt_ts: touch@4a {
+		compatible = "atmel,maxtouch";
+		/* Verdin GPIO_9_DSI */
+		/* (TOUCH_INT#, SODIMM 17, also routed to SN65dsi83 IRQ albeit currently unused) */
+		interrupt-parent = <&gpio3>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_9_dsi>, <&pinctrl_i2s_2_bclk_touch_reset>;
+		reg = <0x4a>;
+		/* Verdin I2S_2_BCLK (TOUCH_RESET#, SODIMM 42) */
+		reset-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	/* Temperature sensor on carrier board */
+	hwmon_temp: sensor@4f {
+		compatible = "ti,tmp75c";
+		reg = <0x4f>;
+		status = "disabled";
+	};
+
+	/* EEPROM on display adapter (MIPI DSI Display Adapter) */
+	eeprom_display_adapter: eeprom@50 {
+		compatible = "st,24c02";
+		pagesize = <16>;
+		reg = <0x50>;
+		status = "disabled";
+	};
+
+	/* EEPROM on carrier board */
+	eeprom_carrier_board: eeprom@57 {
+		compatible = "st,24c02";
+		pagesize = <16>;
+		reg = <0x57>;
+		status = "disabled";
+	};
+};
+
+/* Verdin PWM_3_DSI */
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_1>;
+	#pwm-cells = <3>;
+};
+
+/* Verdin PWM_1 */
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_2>;
+	#pwm-cells = <3>;
+};
+
+/* Verdin PWM_2 */
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_3>;
+	#pwm-cells = <3>;
+};
+
+/* VERDIN I2S_1 */
+&sai2 {
+	#sound-dai-cells = <0>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+/* Verdin UART_3, used as the Linux console */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+/* Verdin UART_1 */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+};
+
+/* Verdin UART_2 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+};
+
+/* Verdin UART_4 */
+/*
+ * Resource allocated to M4 by default, must not be accessed from Cortex-A35 or you get an OOPS
+ */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+};
+
+&usbmisc1 {
+	vbus-wakeup-supply = <&reg_vdd_3v3>;
+};
+
+&usbmisc2 {
+	vbus-wakeup-supply = <&reg_vdd_3v3>;
+};
+
+/* Verdin USB_1 */
+&usbotg1 {
+	adp-disable;
+	dr_mode = "otg";
+	hnp-disable;
+	over-current-active-low;
+	picophy,dc-vol-level-adjust = <7>;
+	picophy,pre-emp-curr-control = <3>;
+	srp-disable;
+	vbus-supply = <&reg_usb_otg1_vbus>;
+};
+
+/* Verdin USB_2 */
+&usbotg2 {
+	dr_mode = "host";
+	over-current-active-low;
+	picophy,dc-vol-level-adjust = <7>;
+	picophy,pre-emp-curr-control = <3>;
+	vbus-supply = <&reg_usb_otg2_vbus>;
+};
+
+&usbphynop1 {
+	vcc-supply = <&reg_vdd_3v3>;
+};
+
+&usbphynop2 {
+	vcc-supply = <&reg_vdd_3v3>;
+};
+
+/* On-module eMMC */
+&usdhc1 {
+	bus-width = <8>;
+	keep-power-in-suspend;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pm-ignore-notify;
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+};
+
+&wdog1 {
+	fsl,ext-reset-output;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
+		    <&pinctrl_gpio3>, <&pinctrl_gpio4>,
+		    <&pinctrl_gpio7>, <&pinctrl_gpio8>,
+		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>,
+		    <&pinctrl_pmic_tpm_ena>;
+
+	pinctrl_can1_int: can1intgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x1c4>;	/* CAN_1_SPI_INT#_1.8V */
+	};
+
+	pinctrl_can2_int: can2intgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x1c4>;	/* CAN_2_SPI_INT#_1.8V */
+	};
+
+	pinctrl_ctrl_sleep_moci: ctrlsleepmocigrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1		0x1c4>;	/* SODIMM 256 */
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x4>,	/* SODIMM 196 */
+			<MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x4>,	/* SODIMM 200 */
+			<MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x1c4>,	/* SODIMM 198 */
+			<MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x1c4>;	/* SODIMM 202 */
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x4>,	/* CAN_SPI_SCK_1.8V */
+			<MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x4>,	/* CAN_SPI_MOSI_1.8V */
+			<MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x1c4>,	/* CAN_SPI_MISO_1.8V */
+			<MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x1c4>,	/* CAN_1_SPI_CS_1.8V# */
+			<MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x1c4>;	/* CAN_2_SPI_CS#_1.8V */
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_ENET_MDC_ENET1_MDC		0x3>,
+			<MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3>,
+			<MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f>,
+			<MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91>,
+			<MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91>,
+			<MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91>,
+			<MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91>,
+			<MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f>,
+			<MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91>,
+			<MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91>,
+			<MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f>,
+			<MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x1c4>;
+	};
+
+	pinctrl_fec1_sleep: fec1-sleepgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_ENET_MDC_ENET1_MDC		0x3>,
+			<MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3>,
+			<MX8MM_IOMUXC_ENET_TD3_GPIO1_IO18		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD2_GPIO1_IO19		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD1_GPIO1_IO20		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD0_GPIO1_IO21		0x1f>,
+			<MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91>,
+			<MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91>,
+			<MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91>,
+			<MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91>,
+			<MX8MM_IOMUXC_ENET_TXC_GPIO1_IO23		0x1f>,
+			<MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91>,
+			<MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91>,
+			<MX8MM_IOMUXC_ENET_TX_CTL_GPIO1_IO22		0x1f>,
+			<MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x184>;
+	};
+
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x1c2>,	/* SODIMM 52 */
+			<MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x82>,	/* SODIMM 54 */
+			<MX8MM_IOMUXC_NAND_CE1_B_QSPI_A_SS1_B		0x82>,	/* SODIMM 64 */
+			<MX8MM_IOMUXC_NAND_DQS_QSPI_A_DQS		0x82>,	/* SODIMM 66 */
+			<MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x82>,	/* SODIMM 56 */
+			<MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x82>,	/* SODIMM 58 */
+			<MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x82>,	/* SODIMM 60 */
+			<MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x82>;	/* SODIMM 62 */
+	};
+
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_CE3_B_GPIO3_IO4		0x184>;	/* SODIMM 206 */
+	};
+
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5		0x1c4>;	/* SODIMM 208 */
+	};
+
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_UART3_RXD_GPIO5_IO26		0x184>;	/* SODIMM 210 */
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_UART3_TXD_GPIO5_IO27		0x184>;	/* SODIMM 212 */
+	};
+
+	pinctrl_gpio5: gpio5grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x184>;	/* SODIMM 216 */
+	};
+
+	pinctrl_gpio6: gpio6grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x184>;	/* SODIMM 218 */
+	};
+
+	pinctrl_gpio7: gpio7grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x184>;	/* SODIMM 220 */
+	};
+
+	pinctrl_gpio8: gpio8grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x184>;	/* SODIMM 222 */
+	};
+
+	/* Verdin GPIO_9_DSI (pulled-up as active-low) */
+	pinctrl_gpio_9_dsi: gpio9dsigrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_RE_B_GPIO3_IO15		0x1c4>;	/* SODIMM 17 */
+	};
+
+	/* Verdin GPIO_10_DSI */
+	pinctrl_gpio_10_dsi: gpio10dsigrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_CE2_B_GPIO3_IO3		0x1c4>;	/* SODIMM 21 */
+	};
+
+	pinctrl_gpio_hog1: gpiohog1grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20		0x1c4>,	/* SODIMM 88 */
+			<MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1		0x1c4>,	/* SODIMM 90 */
+			<MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2		0x1c4>,	/* SODIMM 92 */
+			<MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3		0x1c4>,	/* SODIMM 94 */
+			<MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4		0x1c4>,	/* SODIMM 96 */
+			<MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5		0x1c4>,	/* SODIMM 100 */
+			<MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0		0x1c4>,	/* SODIMM 102 */
+			<MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11		0x1c4>,	/* SODIMM 104 */
+			<MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12		0x1c4>,	/* SODIMM 106 */
+			<MX8MM_IOMUXC_SAI1_TXD1_GPIO4_IO13		0x1c4>,	/* SODIMM 108 */
+			<MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x1c4>,	/* SODIMM 112 */
+			<MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x1c4>,	/* SODIMM 114 */
+			<MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x1c4>,	/* SODIMM 116 */
+			<MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x1c4>,	/* SODIMM 118 */
+			<MX8MM_IOMUXC_SAI1_TXFS_GPIO4_IO10		0x1c4>;	/* SODIMM 120 */
+	};
+
+	pinctrl_gpio_hog2: gpiohog2grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x1c4>;	/* SODIMM 91 */
+	};
+
+	pinctrl_gpio_hog3: gpiohog3grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x1c4>,	/* SODIMM 157 */
+			<MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x1c4>;	/* SODIMM 187 */
+	};
+
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x1c4>;	/* SODIMM 252 */
+	};
+
+	/* On-module I2C */
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c6>,	/* PMIC_I2C_SCL */
+			<MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c6>;	/* PMIC_I2C_SDA */
+	};
+
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14		0x400001c6>,	/* PMIC_I2C_SCL */
+			<MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15		0x400001c6>;	/* PMIC_I2C_SDA */
+	};
+
+	/* Verdin I2C_4_CSI */
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x400001c6>,	/* SODIMM 55 */
+			<MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x400001c6>;	/* SODIMM 53 */
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16		0x400001c6>,	/* SODIMM 55 */
+			<MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17		0x400001c6>;	/* SODIMM 53 */
+	};
+
+	/* Verdin I2C_2_DSI */
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x400001c6>,	/* SODIMM 95 */
+			<MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x400001c6>;	/* SODIMM 93 */
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18		0x400001c6>,	/* SODIMM 95 */
+			<MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19		0x400001c6>;	/* SODIMM 93 */
+	};
+
+	/* Verdin I2C_1 */
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c6>,	/* SODIMM 14 */
+			<MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c6>;	/* SODIMM 12 */
+	};
+
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20		0x400001c6>,	/* SODIMM 14 */
+			<MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21		0x400001c6>;	/* SODIMM 12 */
+	};
+
+	/* Verdin I2S_2_BCLK (TOUCH_RESET#) */
+	pinctrl_i2s_2_bclk_touch_reset: i2s2bclktouchresetgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x184>;	/* SODIMM 42 */
+	};
+
+	/* Verdin I2S_2_D_OUT shared with SAI5 */
+	pinctrl_i2s_2_d_out_dsi_1_bkl_en: i2s2doutdsi1bklengrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x184>;	/* SODIMM 46 */
+	};
+
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x6>,	/* SODIMM 244 */
+			/* PMIC_EN_PCIe_CLK, unused */
+			<MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x6>;
+	};
+
+	pinctrl_pmic: pmicirqgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x41>;	/* PMIC_INT# */
+	};
+
+	/* Verdin PWM_3_DSI shared with GPIO1_IO1 */
+	pinctrl_pwm_1: pwm1grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT		0x6>;	/* SODIMM 19 */
+	};
+
+	pinctrl_pwm_2: pwm2grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x6>;	/* SODIMM 15 */
+	};
+
+	pinctrl_pwm_3: pwm3grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT			0x6>;	/* SODIMM 16 */
+	};
+
+	/* Verdin PWM_3_DSI (pulled-down as active-high) shared with PWM1_OUT */
+	pinctrl_pwm_3_dsi_hpd_gpio: pwm3dsihpdgpiogrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x184>;	/* SODIMM 19 */
+	};
+
+	pinctrl_reg_eth: regethgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD2_WP_GPIO2_IO20			0x184>;	/* PMIC_EN_ETH */
+	};
+
+	pinctrl_reg_usb1_en: regusb1engrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x184>;	/* SODIMM 155 */
+	};
+
+	pinctrl_reg_usb2_en: regusb2engrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x184>;	/* SODIMM 185 */
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0xd6>,	/* SODIMM 32 */
+			<MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0xd6>,	/* SODIMM 30 */
+			<MX8MM_IOMUXC_SAI2_MCLK_SAI2_MCLK		0xd6>,	/* SODIMM 38 */
+			<MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0		0xd6>,	/* SODIMM 36 */
+			<MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0		0xd6>;	/* SODIMM 34 */
+	};
+
+	pinctrl_sai5: sai5grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI5_RXD0_SAI5_RX_DATA0		0xd6>,	/* SODIMM 48 */
+			<MX8MM_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC		0xd6>,	/* SODIMM 44 */
+			<MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK		0xd6>,	/* SODIMM 42 */
+			<MX8MM_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0		0xd6>;	/* SODIMM 46 */
+	};
+
+	/* control signal for optional ATTPM20P or SE050 */
+	pinctrl_pmic_tpm_ena: pmictpmenagrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x1c4>;	/* PMIC_TPM_ENA */
+	};
+
+	pinctrl_tsp: tspgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6		0x140>,	/* SODIMM 148 */
+			<MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x140>,	/* SODIMM 152 */
+			<MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x140>,	/* SODIMM 154 */
+			<MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x140>,	/* SODIMM 179 */
+			<MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x140>;	/* SODIMM 150 */
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x1c4>,	/* SODIMM 149 */
+			<MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x1c4>;	/* SODIMM 147 */
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x1c4>,	/* SODIMM 129 */
+			<MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x1c4>,	/* SODIMM 131 */
+			<MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x1c4>,	/* SODIMM 133 */
+			<MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x1c4>;	/* SODIMM 135 */
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX		0x1c4>,	/* SODIMM 137 */
+			<MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX		0x1c4>,	/* SODIMM 139 */
+			<MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x1c4>,	/* SODIMM 141 */
+			<MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B	0x1c4>;	/* SODIMM 143 */
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX		0x1c4>,	/* SODIMM 151 */
+			<MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX		0x1c4>;	/* SODIMM 153 */
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190>,
+			<MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0>,
+			<MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d0>,
+			<MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d0>,
+			<MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d0>,
+			<MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d0>,
+			<MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d0>,
+			<MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d0>,
+			<MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d0>,
+			<MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d0>,
+			<MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B	0x1d1>,
+			<MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x190>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194>,
+			<MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4>,
+			<MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d4>,
+			<MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d4>,
+			<MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d4>,
+			<MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d4>,
+			<MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d4>,
+			<MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d4>,
+			<MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d4>,
+			<MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d4>,
+			<MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B	0x1d1>,
+			<MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x194>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196>,
+			<MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6>,
+			<MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d6>,
+			<MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d6>,
+			<MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d6>,
+			<MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d6>,
+			<MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d6>,
+			<MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d6>,
+			<MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d6>,
+			<MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d6>,
+			<MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B	0x1d1>,
+			<MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x196>;
+	};
+
+	pinctrl_usdhc2_cd: usdhc2cdgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x1c4>;	/* SODIMM 84 */
+	};
+
+	pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x184>;	/* SODIMM 76 */
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190>,	/* SODIMM 78 */
+			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0>,	/* SODIMM 74 */
+			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0>,	/* SODIMM 80 */
+			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0>,	/* SODIMM 82 */
+			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0>,	/* SODIMM 70 */
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0>,	/* SODIMM 72 */
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194>,
+			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4>,
+			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4>,
+			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4>,
+			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4>,
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4>,
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196>,
+			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6>,
+			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6>,
+			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6>,
+			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6>,
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6>,
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0>;
+	};
+
+	/* On-module Wi-Fi/BT or type specific SDHC interface */
+	/* (e.g. on X52 extension slot of Verdin Development Board) */
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0>,
+			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0>,
+			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0>,
+			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0>,
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4>,
+			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4>,
+			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4>,
+			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4>,
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6>,
+			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6>,
+			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6>,
+			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6>,
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6>;	/* PMIC_WDI */
+	};
+
+	pinctrl_wifi_ctrl: wifictrlgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x1c4>,	/* WIFI_WKUP_BT */
+			<MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x1c4>,	/* WIFI_W_WKUP_HOST */
+			<MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x1c4>;	/* WIFI_WKUP_WLAN */
+	};
+
+	pinctrl_wifi_i2s: bti2sgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI1_RXD4_SAI6_TX_BCLK		0xd6>,	/* WIFI_TX_BCLK */
+			<MX8MM_IOMUXC_SAI1_RXD5_SAI6_TX_DATA0		0xd6>,	/* WIFI_TX_DATA0 */
+			<MX8MM_IOMUXC_SAI1_RXD6_SAI6_TX_SYNC		0xd6>,	/* WIFI_TX_SYNC */
+			<MX8MM_IOMUXC_SAI1_TXD5_SAI6_RX_DATA0		0xd6>;	/* WIFI_RX_DATA0 */
+	};
+
+	pinctrl_wifi_pwr_en: wifipwrengrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x184>;	/* PMIC_EN_WIFI */
+	};
+};
-- 
2.33.1

