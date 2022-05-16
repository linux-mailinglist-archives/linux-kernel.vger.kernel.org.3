Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E945285E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbiEPNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244023AbiEPNtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:49:20 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8D3A722;
        Mon, 16 May 2022 06:48:46 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mapv2-1o9mfO3mhu-00KNGT;
 Mon, 16 May 2022 15:48:37 +0200
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
Subject: [PATCH v2 11/24] ARM: dts: imx7-colibri: clean-up usdhc1 and add sleep config
Date:   Mon, 16 May 2022 15:47:21 +0200
Message-Id: <20220516134734.493065-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZRzc2gXZMKf3ghAXjPUT9TqYZgxorz496rHBn9Ig6p7AOfD7Kj1
 61AydMR9YZxrgkKnMrJvCHwhTNEMxUKKG7n0DDYaUA5+AuVLlvuf665SezJGojmDg8Zd7p7
 OXTeurCkUywqLS/rHWu0m1lBR9TaxPEygEo6mAd17DfHMj49e9bTtkPjmqL9eZklIkK/z1Q
 D4OBruByqETkX0dux5HjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SuGP2DzBcIg=:fynZZd6alUQKyCXZa+vtuZ
 1DgRHQ/d75HAMPk94zVpqEErTZnZ6DisECQWSb8WpePJ/8qJmxYeCoHcfaXxe/2BGncVBtnen
 77dp3rVStMIdbbPvWEt0EiZ1/v1mF7O5oyhbprvQ5i620/0SVeL8L9faNEA213LxKVf1349X1
 5wIL3YrgNzoXK1zbGdidaW1+0Lt4pE4yK0nWaEoOOtGw16E7xy60UTqPvtYjFrlLL+gStKuc7
 7ddqAGkAQnHpMAX6+Eu1/YZKvl+QPQaPT9EKPOBKAXp1/Y2duuqCRHVyiZ7ggnzbQVBci1yp8
 /0cfbVzS7nmTC6H8YiEhtpsidPGg8m29mPH+hsyGNiW3gVZiPUMSxsOmLTtzIz/GFq2zjhhHF
 CudEAsNvKkeyuhDdCyiJegpIFZvepzhGP5Jc/AoJOPvG2yNQlixLIgkIOsagoW7h4LGEbMNlu
 OqpVXClDbF2kOKEdaKEuGEGEQDYkibIN0nyI1mIGxFUpRzn9d4bsHGOOJBKU+oNxZXwlLV9N5
 deJ0P03r2aOavntFaVgGgvqjbtBvuCAWd40Sa43v01sMzsqHQTbsgmPvn7kRNSS+uvJ0BjWmj
 Fjvsv692mWzLnEMNNTJ5VlcCGcg/w6ewkekj/+jK1vy6yy8ekX3zEiMvDhjNS7zj6cpTAQzY/
 UfgoBYrl9bCLQICJLavzH+7E6pU8nImZqfcXPDBIn8gi1H/qqd3gWvLcdt4DoHJmW7BY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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

