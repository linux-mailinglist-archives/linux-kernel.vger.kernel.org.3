Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A2151D906
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392512AbiEFN3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392503AbiEFN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:37 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55866972A;
        Fri,  6 May 2022 06:24:53 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M1m9M-1o7X062cDS-00ti3N;
 Fri, 06 May 2022 15:24:41 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
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
Subject: [PATCH v3 05/13] ARM: dts: imx6ull-colibri: update usdhc1 pixmux and signaling
Date:   Fri,  6 May 2022 15:24:08 +0200
Message-Id: <20220506132416.273965-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9jTQUi0FQdHyIXM/FBLSNDoQB3bT5f3Hv89Zc84bMhDg/y7nJ7/
 2/JLhov/jxEpT8zyfPdT/wdPvF5Dj/cTicQon4W0hoi2RhQ/v2ewZxSEok2KsqD6MzVQ0FO
 aX3qp0YtySU/UlJGYDPf0Pcl3xi28uP8JDI1J5L+JJIWZYsKPxwQXY8CtR4NRV3J071Lqr3
 DLkHTaxJ/xUFsH2PTMi0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g/cQV3B+G7E=:7iyZbjpogHAr47Oi4XQRu4
 JpL3BLCqMQmyHuWqx6cbLy50F5Pc/q/nDcnlLZxVlRLXYVUAbE9tOVR+4XV8mutNCfW7ExmXE
 OsL/uWR5/pSV6H7pGAQOHpi7m2DRGY05KjRJNNTcoeEIccIqhSg7a5sUKxdMcq/7nw/4jtGMi
 6HIU/4RerYITkwhBBUzX+Y2pljEAZWgeMSMWiZj2Tvn4unb/bu8xRZcChEDU5VS59zvN/J4Rz
 +kcdvcILBF4xCBi2CvQqoUBuLjwMwYVSRT/NlgSswL5FrcTQGi8X00fifsWk3zIJiugRJYrCF
 G+oeXPOqeFT4SoekEcdM2alAr8mjbqgpjo8cFd1pTSbUajbgXBzDXm/47VEZneV9m60WuWiUe
 vFvmlp4wSzr2pjZu53lPlhXck0ulFekmxTwjQiEEGwIJhTtlKH3iaoIfHKAxb4qdkAOfdz2gL
 SwSi/TlwftxPYMP3L8gxPb2HwgOSUkO4ldQTe3xC2zDlWcUY4t2IrdigEMf9zqFhNDSFlceP9
 0OG8xj/GyMe1ptnciZjgpkpeL2fJHXqrqBswr8zwgG+FDv3k3msJW9FkwnymOJynHN1x3fkGe
 cSUO4Oxe4keym/779DVqBL8Rot59d0gswG9VJ5k2uGV1J33Uvth7iAIceO8epNRoFtL+BqWMT
 qU8kxGMRGHBU6dwmajnBZcBFCXKb+1DJ8LTS0w6BE+p9ciqzWJXTbuQVmdQ8hT8D96mg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Due to many carrier boards pulling the usdhc1 signals up to 3.3 volt we
need to disable 1.8 volt signaling. Adding the no-1-8-v property
basically disables UHS-I modes by default.

Also pull-up the command and data lines to the +V3.3_1.8_SD rail and
set them to the 200 MHz speed grade (e.g. pinmux bits 7-6: meaning 11
SPEED_3_max_200MHz).

Explicitly specify a bus-width of <4> in the module-level device tree
include file and drop the no-1-8-v property from the carrier boards
device trees.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 14 --------
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 36 ++++++++++++-------
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index a78849fd2afa..ea086b305d22 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -159,20 +159,6 @@ &usbotg2 {
 };
 
 &usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
-	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_snvs_usdhc1_cd>;
-	pinctrl-3 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_sleep_cd>;
-	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	wakeup-source;
-	keep-power-in-suspend;
 	vmmc-supply = <&reg_3v3>;
-	vqmmc-supply = <&reg_sd1_vmmc>;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index c89b209be316..351ea2acd5a6 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -35,7 +35,7 @@ reg_module_3v3_avdd: regulator-module-3v3-avdd {
 		regulator-max-microvolt = <3300000>;
 	};
 
-	reg_sd1_vmmc: regulator-sd1-vmmc {
+	reg_sd1_vqmmc: regulator-sd1-vqmmc {
 		compatible = "regulator-gpio";
 		gpio = <&gpio5 9 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -232,9 +232,21 @@ &usbotg2 {
 };
 
 &usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_snvs_usdhc1_cd>;
+	pinctrl-3 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_sleep_cd>;
 	assigned-clocks = <&clks IMX6UL_CLK_USDHC1_SEL>, <&clks IMX6UL_CLK_USDHC1>;
 	assigned-clock-parents = <&clks IMX6UL_CLK_PLL2_PFD2>;
 	assigned-clock-rates = <0>, <198000000>;
+	bus-width = <4>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	keep-power-in-suspend;
+	no-1-8-v;
+	vqmmc-supply = <&reg_sd1_vqmmc>;
+	wakeup-source;
 };
 
 &wdog1 {
@@ -550,8 +562,8 @@ MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0x10b0 /* SODIMM 129 */
 
 	pinctrl_usdhc1: usdhc1-grp {
 		fsl,pins = <
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059 /* SODIMM 47 */
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x10059 /* SODIMM 190 */
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059 /* SODIMM 47 */
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059 /* SODIMM 190 */
 			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059 /* SODIMM 192 */
 			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059 /* SODIMM 49 */
 			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059 /* SODIMM 51 */
@@ -561,8 +573,8 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059 /* SODIMM 53 */
 
 	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x170b9
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x100b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
 			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
 			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
 			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
@@ -572,12 +584,12 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
 
 	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x170f9
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x100f9
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
 		>;
 	};
 
@@ -588,7 +600,7 @@ MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17069
 			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17069
 			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17069
 			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17069
-			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x17069
+			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x10069
 
 			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x10
 		>;
-- 
2.35.1

