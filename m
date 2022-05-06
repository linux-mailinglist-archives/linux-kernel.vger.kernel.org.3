Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059DB51DC1A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391247AbiEFPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442895AbiEFPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:54 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05226D39C;
        Fri,  6 May 2022 08:29:07 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MpUtU-1oAATj2bTo-00psDs;
 Fri, 06 May 2022 17:28:56 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v1 11/24] ARM: dts: imx7-colibri: clean-up usdhc1 and add sleep config
Date:   Fri,  6 May 2022 17:27:56 +0200
Message-Id: <20220506152809.295409-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gOHANZqjzdFZYYWGf09oaG8BUvlJRsrHFx6QTTGyi3s6+jn3yo6
 e32qePfo8a2qzr51g4yVTYJTBDw9qbDaAlZTnvJYxSOuhLwrrAjBK2QES+bFcxVBhQlOMsb
 9XUbtolv31pIGuBIx+2vIDBHMn+jgcwcFTpiJAZb/j7rabW+o3e/I/v+0vEOeWC7bf0Qo7N
 cM4DprsCXH+R6OCLuIItw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6lPkD2sBw4w=:BRk7CmH5OU2tPhm8hXYdEw
 YlWpnSU2jPfY9itDpQ9b+K+j3025k9CuBL99Bj3zgvWUcknxLT50fUz7hjIbrdcIFcYSZL/2o
 09qLo1ch7MABtla6fRVLpVsqgmuoww68tZqC/pbqvBZGsTaGgs4+PhePA5wgD8PwJqOScWTaO
 Tsc7TmxDvOCeJZ+Hi75YxOV0pmD8I5qhJ2mrWotDYBgL2jkexnSv3ssIjDxVjVehXKJEEJXfq
 vZJJU8KoUgffX1i6ro816kZc05hSG33t0HAd42broNhxFQPIrdccjJldLOOG2Vw+X+uf7dJSH
 wIephftosGp+hWbptceGq0TTfmbiN+rX9cNIXs3ARTlHpgSiNlz28V0mMy4A/oAnVU3GSoRyl
 NjGyYhLYtAaEaneY17C/f7FM4QKTaz3gyvlyb++seEce099zdcaGnr6tiBWkWaaiZo2bkI07g
 QXUxPGfFbEayOw/an3OmmU1mo2ZDMZ72O3k+HmiSrdLmS/Nxa7H/ouhEXMgyZSdxXwUsWqTEa
 VlKF39C7wRK3zA+WTf+2OX1pHaRP8jMmIt0xezPQksHkA862WkzUEm45TmbClMhlZQ9dpIMD1
 AOdcJJ5HPQPXq2Ab76AXtu0qUfYqEHZvEp+7NyC0gwYAYztuw+euhgA8v6b6LhppZLGLhlF1W
 t8DKuB/3V9fO3g9i+D+2/tYyE+ERtt33Kq+7oR65bVblmJWDsAbqmk/mm9qJo9iTd/J6JgtJq
 Upwr8WXDSai1t8HV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Adding no-1-8-v property to usdhc1 to disable +1.8V signaling (UHS-I)
mode on SoM dtsi level.

Clean up no-1-8-v from Aster carrier board dtsi, which is using defaults
from SoM dtsi and is not UHS-I capable.

A carrier board may have a MMC/SD card slot with a switchable power
supply. Add a pinctrl sleep used when the card power is off to avoid
backfeeding to the card and add the "sleep" pinctrl to the usdhc1
controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-aster.dtsi   |  5 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi |  3 -
 arch/arm/boot/dts/imx7-colibri.dtsi         | 75 ++++++++++++++-------
 3 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index 440f98dc323d..f3a5cb7d6a0c 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -61,10 +61,7 @@ &usbotg1 {
 	status = "okay";
 };
 
+/* Colibri MMC/SD */
 &usdhc1 {
-	keep-power-in-suspend;
-	no-1-8-v;
-	wakeup-source;
-	vmmc-supply = <&reg_3v3>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 33a9cbbca0d2..618831e89ce8 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -97,8 +97,5 @@ &usbotg1 {
 };
 
 &usdhc1 {
-	keep-power-in-suspend;
-	wakeup-source;
-	vmmc-supply = <&reg_3v3>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 09dbd262dad1..3da9ddc06aae 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -585,12 +585,19 @@ &usbotg1 {
 	extcon = <0>, <&extcon_usbc_det>;
 };
 
+/* Colibri MMC/SD */
 &usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
 	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	no-1-8-v;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_cd_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_cd_usdhc1>;
+	pinctrl-3 = <&pinctrl_usdhc1_sleep &pinctrl_cd_usdhc1_sleep>;
+	vmmc-supply = <&reg_3v3>;
 	vqmmc-supply = <&reg_LDO2>;
+	wakeup-source;
 };
 
 &usdhc3 {
@@ -949,36 +956,48 @@ MX7D_PAD_UART3_CTS_B__GPIO4_IO7	0x14 /* SODIMM 129 USBH PEN */
 		>;
 	};
 
-	pinctrl_usdhc1: usdhc1-grp {
+	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
-			MX7D_PAD_SD1_CLK__SD1_CLK	0x19
-			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x59
-			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x59
-			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x59
-			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x19 /* SODIMM 47 */
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x59 /* SODIMM 190 */
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59 /* SODIMM 192 */
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59 /* SODIMM 49 */
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59 /* SODIMM 51 */
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59 /* SODIMM 53 */
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
-			MX7D_PAD_SD1_CMD__SD1_CMD	0x5a
-			MX7D_PAD_SD1_CLK__SD1_CLK	0x1a
-			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5a
-			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5a
-			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5a
-			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5a
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
-			MX7D_PAD_SD1_CMD__SD1_CMD	0x5b
-			MX7D_PAD_SD1_CLK__SD1_CLK	0x1b
-			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5b
-			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5b
-			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5b
-			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5b
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5b
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5b
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5b
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5b
+		>;
+	};
+
+	/* Avoid backfeeding with removed card power. */
+	pinctrl_usdhc1_sleep: usdhc1-slpgrp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x10
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x10
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x10
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x10
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x10
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x10
 		>;
 	};
 
@@ -1077,9 +1096,15 @@ MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x4000007f
 		>;
 	};
 
-	pinctrl_cd_usdhc1: usdhc1-cd-grp {
+	pinctrl_cd_usdhc1: cdusdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* SODIMM 43 / MMC_CD */
+		>;
+	};
+
+	pinctrl_cd_usdhc1_sleep: cdusdhc1-slpgrp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* CD */
+			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x0
 		>;
 	};
 
-- 
2.35.1

