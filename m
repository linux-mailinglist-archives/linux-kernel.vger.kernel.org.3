Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9651D917
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392571AbiEFNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392540AbiEFN2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:50 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316D69CE3;
        Fri,  6 May 2022 06:25:00 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MgdCj-1nQEYk2nAt-00Nvbo;
 Fri, 06 May 2022 15:24:38 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/13] ARM: dts: imx6ull-colibri: add touchscreen device nodes
Date:   Fri,  6 May 2022 15:24:07 +0200
Message-Id: <20220506132416.273965-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kTzP2dKjh7P3AChHYjD9MUXLo2VnKd4yHU8l0rV658RSKhGVuYv
 zlNvvphj3mHFa3BjpmhDKLHsQUpe0A+ALVKog17BvM9CsEjL08GLcLmjLn7WFRL27CfC1Fu
 hwGs04rcAbJqoFmGX8TOGaIqPXJjj6QOzD7edgXsRSyJustVxRcJ9cUyrlfux6nyKd+9W+R
 xAItNje5JE9SXdZvcFxsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a6/ScGZMOdo=:UhP+R4Q0LOeH5GT+KBdRFY
 W4AxU8ZDW7SATWcN/7KDNOTbZNrJglijwhQweMtS2njDIjJ4a65BYc7XBQrhWzfGUByOVPOSt
 kRWVUJxrPMUwWd1LBjSNdfRlF23wdTnVx1MJa2sxX5qntuSRE9nTjrbM17bOouk7XEajFp82w
 KJTVAfJIdx8gKr6+AXPxr2tFajUFeFKd99JGyDP4wzVu6rbqaAvy7M/S35ZHs3dtN3rI8PN89
 KgaHKx1v3ZN5SrwAtU3RUJQQWV79Yoqp+HERTz0fL1YKWxmjuT4iK80kst0FNnDfYgwk2oTKH
 dfrA5Hbr2UCxJGtA43V2KnNt5KhdTxgvEl9PSpWJi70FqvUuv6nLnf/0j4G730IGio8QMaEIo
 hcMyj6679B9Fo+kYAukDqa3V187tj2a7qUgCJsUredaD/79ANSFyuHBKxoRHkkpz+1gugZr0c
 MYsi51nPBjcs8diPyZUVFayka1o5yD1Vhb4E08YUx+RKiDAhgBjn9YgBSawS/UASZ/p0nR1Jr
 G2GjrK8f70iWKVr5OWGJHv5AFs1VBfs/8f7BMTsw1GKlnEyOGu1tKHi4HpG3g57bdFHzxVnoP
 SySOjjKEW1ZR1ZvnC8Dino0pNABzn15TWvdbuVW7B85OUEbeLfATT2jggOcWg2NHRuvy5tFUK
 L36M2kWNEOvj14uka/fEzlp/+w+chAEEeWOJNtEp8LFzoGacI4VJP4KZ+bMXsJIoKirw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Drozdov <denys.drozdov@toradex.com>

Move all Atmel nodes from the board-level into the main module-level
device tree and prepare the device trees for use with Atmel MXT device
tree overlays. Also, add required pinmux groups.

The common scheme for pin groups in touch screen overlays is as follows:
- pinctrl_atmel_conn - SODIMM 106/107 pins for INT/RST signals (default)
- pinctrl_atmel_adap - SODIMM   28/30 pins for INT/RST signals.

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3:
- Fixed reset GPIO polarity in-line with the following upstream commit:
  feedaacdadfc ("Input: atmel_mxt_ts - fix up inverted RESET handler")
- Fixed comment using more common SODIMM followed by number naming.

Changes in v2:
- Fixed pinctrl node names as suggested by Shawn.

 .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi |  4 +-
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   |  4 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 39 +++++++++++++------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
index 95a11b8bcbdb..5e55a6c820bc 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
@@ -15,10 +15,10 @@ memory@80000000 {
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
-		&pinctrl_gpio4 &pinctrl_gpio5 &pinctrl_gpio6 &pinctrl_gpio7>;
+		&pinctrl_gpio4 &pinctrl_gpio6 &pinctrl_gpio7>;
 };
 
 &iomuxc_snvs {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio2 &pinctrl_snvs_gpio3>;
+	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio3>;
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
index 9f1e38282bee..6e8ddb07e11d 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
@@ -26,13 +26,13 @@ &cpu0 {
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
-		&pinctrl_gpio4 &pinctrl_gpio5 &pinctrl_gpio7>;
+		&pinctrl_gpio4 &pinctrl_gpio7>;
 
 };
 
 &iomuxc_snvs {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio2>;
+	pinctrl-0 = <&pinctrl_snvs_gpio1>;
 };
 
 &usdhc2 {
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 7cd912df5d19..c89b209be316 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -124,6 +124,19 @@ &i2c1 {
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
 	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	/* Atmel maxtouch controller */
+	atmel_mxt_ts: touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_atmel_conn>;
+		reg = <0x4a>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;       /* SODIMM 107 / INT */
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;    /* SODIMM 106 / RST */
+		status = "disabled";
+	};
 };
 
 &i2c2 {
@@ -241,6 +254,20 @@ MX6UL_PAD_GPIO1_IO09__GPIO1_IO09        0x3000 /* SODIMM 2 */
 		>;
 	};
 
+	pinctrl_atmel_adap: atmeladapgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_DQS__GPIO4_IO16          0xb0a0  /* SODIMM 28 */
+			MX6UL_PAD_ENET1_TX_EN__GPIO2_IO05       0xb0a0  /* SODIMM 30 */
+		>;
+	};
+
+	pinctrl_atmel_conn: atmelconngrp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_MOD__GPIO1_IO10          0xb0a0  /* SODIMM 106 */
+			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04     0xb0a0	/* SODIMM 107 */
+		>;
+	};
+
 	pinctrl_can_int: canint-grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_TX_DATA1__GPIO2_IO04	0x13010	/* SODIMM 73 */
@@ -347,12 +374,6 @@ MX6UL_PAD_CSI_DATA07__GPIO4_IO28	0x10b0 /* SODIMM 65 */
 		>;
 	};
 
-	pinctrl_gpio5: gpio5-grp { /* ATMEL MXT TOUCH */
-		fsl,pins = <
-			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0xb0a0 /* SODIMM 106 */
-		>;
-	};
-
 	pinctrl_gpio6: gpio6-grp { /* Wifi pins */
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0x10b0 /* SODIMM 89 */
@@ -606,12 +627,6 @@ MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x110a0	/* SODIMM 138 */
 		>;
 	};
 
-	pinctrl_snvs_gpio2: snvs-gpio2-grp { /* ATMEL MXT TOUCH */
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0xb0a0	/* SODIMM 107 */
-		>;
-	};
-
 	pinctrl_snvs_gpio3: snvs-gpio3-grp { /* Wifi pins */
 		fsl,pins = <
 			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x130a0	/* SODIMM 127 */
-- 
2.35.1

