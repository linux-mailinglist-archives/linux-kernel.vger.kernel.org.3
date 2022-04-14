Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905425008D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbiDNIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbiDNIyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:14 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406EB65798;
        Thu, 14 Apr 2022 01:51:49 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MXHWM-1nSCZl0ZCA-00YlKM;
 Thu, 14 Apr 2022 10:51:35 +0200
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
Subject: [PATCH v1 05/14] ARM: dts: imx6ull-colibri: add touchscreen device nodes
Date:   Thu, 14 Apr 2022 10:50:57 +0200
Message-Id: <20220414085106.18621-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AzmStBKEEMT8nYa1ZTBmzScuYh2UziRpF/eJmtbuREyQxrNZ6mR
 q70hyNaB9Pm7r7TnNmmmfVc+hRmb1QpCbKYl+5jFlUJQVB+5oo3LEy8hJDFGU3f8vD2QsYl
 p4k2cbwUSztVaigw7edX9iftQ2LA28/+A+R9clv2IIbU3uxm9+qsRCvPQOEpsRJ93hGtg4U
 9jnBOJiVZbDse4lIbsSBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jcTR2j4yPIM=:Bx83FwfHBmTwzhvCo4b7l6
 +SAHnIfuhee802teUFXRZGyGJaHo4WfcaqC7HgLke4VrbeS0yfKMkjQIcXkrv66vINpzm1/ib
 lbE7FEEP0X0ZbBjjSu27kExmH+LGTYTA1pwuU4KOPw3mb9IjY0A/JK00uyFEeucFY+AVUQZyW
 Knh5ps0S0aaRu5qne2ZfhPFiR7dUCK7n8hNCkF0xWk4Pgyth3EVcNwJtpcCKJV0KbQKjCDW+c
 qNBTOniKQGBhcFCXs/FSRq1aVAMJo9xx4fD+uByQcJWH1zX3JpqxUA6A6iorw9Y7Km8fwbNSg
 OgA37OmPiGSGVHvC48CT6TbtAeoQIq53Ky6WCVWNSKCW8EbaWHyaJbGobafs3x7WRpelsuTDw
 X/W0N6N+NiHZsi2qzF1OglMz1mmX/mNMpoGWnhHsZ3vE26l9M7jywNWIhTUBcKJJsMKIob6hg
 1Ru++g//t8ocFbQn8jBnvASq99duSjvODTDqOlGW+opwtbt0g7EWoFwVkXgpy1mNc4KF02f/X
 cA3zyZ/P810rSSZ2jMobIiHo/Fh6Gugm0CthyfHri1bg77Qebn6zsAGjoP3pFn4hgryW9Wi7L
 Assag8dg7b4JwTJQIOXpHzh6n4GCVDgn7uJQjjAloKrGjrORwO/MjpqB3BPN9pOJtPpTaZnLs
 6+7w54xKdo9UXVk6xAbEfiLO8iyBnriVMAehRaiP/3S/ivrIKHpy7fktC2JO1BDUabO0=
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
index e619da3b00b3..b2345a5573f4 100644
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
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;       /* SODIMM_107, INT */
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;   /* SODIMM_106, RST */
+		status = "disabled";
+	};
 };
 
 &i2c2 {
@@ -241,6 +254,20 @@ MX6UL_PAD_GPIO1_IO09__GPIO1_IO09        0x3000 /* SODIMM 2 */
 		>;
 	};
 
+	pinctrl_atmel_adap: atmel_adap_group {
+		fsl,pins = <
+			MX6UL_PAD_NAND_DQS__GPIO4_IO16          0xb0a0  /* SODIMM 28 */
+			MX6UL_PAD_ENET1_TX_EN__GPIO2_IO05       0xb0a0  /* SODIMM 30 */
+		>;
+	};
+
+	pinctrl_atmel_conn: atmel_conn_group {
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

