Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F351D90B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392522AbiEFN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392520AbiEFN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:48 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226A369CD9;
        Fri,  6 May 2022 06:24:55 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M0fge-1o6R4X1T9q-00uoW5;
 Fri, 06 May 2022 15:24:43 +0200
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
Subject: [PATCH v3 06/13] ARM: dts: imx6ull-colibri: update device trees to support overlays
Date:   Fri,  6 May 2022 15:24:09 +0200
Message-Id: <20220506132416.273965-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y+KHdTdOAJTiItaIdQpfXfwJHvCoYEyTTzVPAC/1y8B4wO7s2C8
 Sb4UDZUHs9VbLggOEqTijXLtZi2a1WleBGrLW3AQxp/igV9Lb9fENn6fGU4uNxipP9byyHU
 0i/ap/Gg5hixITUto7BXrkAs6RNpJNfGMq/VXFgq1y0ZJbIYipt8xvD3R1yDmQgQvbzKvpn
 2ST1i7nV3Gs998fwk+JoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NQTj//WwDBQ=:emh555MUqzab00HdP4in69
 DCLGlQWph1tapDNo7AJaVOMD4aowxVYpmAgSA/oselL+Oa43zzvOpksnQBlWODsUmBMt3UGNu
 wVTuHddKPZNS2/X5jmCkk329f7BMP1sa2Y7+1j4er4d1jDswPZEPNRoFwhac7VP29Sb3Wyv0G
 Hd7jHF9ILGObZQw+LbCG2m+m7ebj+NCFoMRZ0Ee3EasmdmO4fP4CL28vUmfO3NSIKvrr2Jz4Z
 mp+wziYe9EsWNzGNvBPGvgHx77iZs1ZqPM8ricWkvZK2FhuwJT3Jbmk5soj8uJ0xzavzDXynw
 4dEey7ZHN5Ntbk+bVTQTR7xCnz9G9rmV9oWrLI/GBIoqZuLlJUtqEBd1UMwVCivh7sSJZQqtB
 7PWDRlh2eDnSQJAGYivHzsetzvCXM5Gsp+6HGmiDyrS7/r7+tZlV7zOBKVKAdgp3Kmeav3buW
 daSq93kT2aHY7FpcgiPlXP6r15QYXM5E1SdBv+680S3IBPkVDPoj8hqsaS7b85JPQD9jrXVnd
 /lOnKINzUoExRiPiLdsfT/wOesfDKktkbK0uGT1YMdXZCOjZ7c9gXlAPZzzHzPX4QWbfGMwwp
 8qflE6SGesnH70svr1siNSd672PADqgC5t0TNQmmBVbTlOZ4Cxpi8qjRHikMF2Ud8jHfcQH8v
 iTijY7TtBnzjQ6OeC/DCxpjofqPAUzLJpQm95MZThIHhJbtDw44W9eF1sTof2h9vNmbU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Drozdov <denys.drozdov@toradex.com>

Prepare in-tree device trees for out-of-tree device tree overlay support
(eMMC SKU only).

Relocate panel-dpi default to edt,et057090dhu (RGB 18bit VGA 640x480)
to the module-level dtsi and remove it from the carrier board dtsi.

Keep backlight, resistive touch and Atmel maxtouch nodes enabled
for both eMMC and NAND modules.

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 29 -----------------
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 31 ++++++++++++++++---
 2 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index ea086b305d22..3c07b4273e80 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -29,17 +29,6 @@ clk16m: clk16m {
 		clock-frequency = <16000000>;
 	};
 
-	panel: panel {
-		compatible = "edt,et057090dhu";
-		backlight = <&bl>;
-		power-supply = <&reg_3v3>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&lcdif_out>;
-			};
-		};
-	};
 
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
@@ -71,14 +60,6 @@ &adc1 {
 	status = "okay";
 };
 
-&bl {
-	brightness-levels = <0 4 8 16 32 64 128 255>;
-	default-brightness-level = <6>;
-	power-supply = <&reg_3v3>;
-	pwms = <&pwm4 0 5000000 1>;
-	status = "okay";
-};
-
 &ecspi1 {
 	status = "okay";
 
@@ -107,16 +88,6 @@ m41t0m6: rtc@68 {
 	};
 };
 
-&lcdif {
-	status = "okay";
-
-	port {
-		lcdif_out: endpoint {
-			remote-endpoint = <&panel_in>;
-		};
-	};
-};
-
 /* PWM <A> */
 &pwm4 {
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 351ea2acd5a6..28baffcef096 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -11,12 +11,29 @@ aliases {
 		ethernet1 = &fec1;
 	};
 
-	bl: backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		enable-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		enable-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
-		status = "disabled";
+		power-supply = <&reg_3v3>;
+		pwms = <&pwm4 0 5000000 1>;
+		status = "okay";
+	};
+
+	panel_dpi: panel-dpi {
+		compatible = "edt,et057090dhu";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+		status = "okay";
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
 	};
 
 	reg_module_3v3: regulator-module-3v3 {
@@ -149,7 +166,7 @@ &i2c2 {
 	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
-	ad7879@2c {
+	ad7879_ts: touchscreen@2c {
 		compatible = "adi,ad7879-1";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_snvs_ad7879_int>;
@@ -170,6 +187,12 @@ &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
 		     &pinctrl_lcdif_ctrl>;
+
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&lcd_panel_in>;
+		};
+	};
 };
 
 &pwm4 {
-- 
2.35.1

