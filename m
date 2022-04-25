Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8350E5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbiDYQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbiDYQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:44 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0005311F953;
        Mon, 25 Apr 2022 09:24:39 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MIcLW-1nlDMm0OF6-002Gzw;
 Mon, 25 Apr 2022 18:24:24 +0200
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
Subject: [PATCH v2 06/14] ARM: dts: imx6ull-colibri: update device trees to support overlays
Date:   Mon, 25 Apr 2022 18:23:48 +0200
Message-Id: <20220425162356.176665-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425162356.176665-1-marcel@ziswiler.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+igbeOghPhe6M3gEizB8AVT7oSjjfiUdrze/kubBf24xhfoW15O
 O6mFkgRIAi+NMEP9ztA8Cx66mpJtVKPBVPOuuT5kONJVhezN+L+Zt9O8R/glThQLCLwKNIo
 uaKSMosEQoY68PsU0BXn5KR1buyrrUQZul/hHsTJjtXhomCdX72UcREW7Y+xmA1anfaRr+D
 7mTxKOg/TerJ8JP1OyzqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t8g3efxgEBg=:BvN3l9h5fjZ7lUIsV5IsqF
 I7PJtrF3Pp51fJ93iVf9R5GjrH5oRFQaOBDotbK69D7qUQgZFGeooF8Nho3GnqYvUmG6FKlyH
 pII2mpnAnX+LQ5UX1Ku2wP43yF5zfr0ocxpKz/zoWn87uUnR/UT8aG2oy9OKixx58bLSIZqJ+
 XdXZT+Ms4ZQ5K5R9Rgxrhuupx0pbm/KWuaIE2RsmJdMZFAkwk0rsgBw9JWscery+rWArhluVi
 fyPKKpdL+DEUQY+uxJc5t0z8cyo4rzg1u5syFkx1DGEefcb05/ndUrZPXtmnl91aU2ql8RfjM
 IPBy97Tit7o2xJxcOfhL64RXSAzMQJ1KBvsBK2pk3G5kL1RywY10zcVHnBj/lCbBuUHT5eAQx
 GFj2PK5QA3rYk209qlmFgdLpeM/1aFO5uuDAItxJ24dnFPDqSKyz+GLkTvEvdaeEBUZZAZFGF
 UIhaz3JXlYcUKRcSFK79odOgUWGi+UUPthvbczuG4kY+Dhn2DyDRyF/T/M1+vFArp9flsU+Md
 vBl9FPf1YufcQWy2efiyLBRVP6uyzOytN2FZ+BItUt33TMJUWWzOvdv3xeXmivrexiL2Y9vbS
 MR/gtFTQsefdYYi6OW/x9IH/R2Z7cu9wsqgzX3VS7t2tqrgK5SHvAFPJ/RPoZWOF0RXcFD4l+
 ki1pgMOmO2obbAGWADTrNp3GzU06DDixphUtYlTSYpUqNrzsE7xB9JmonmuDHBftjc/sLalB/
 EBAssrKQSRa8rK9U
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index bd8736d90cbb..756cb4222805 100644
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

