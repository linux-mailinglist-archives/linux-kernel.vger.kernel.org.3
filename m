Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2B51DC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442888AbiEFPdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442856AbiEFPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:42 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7386D1AC;
        Fri,  6 May 2022 08:28:58 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M6mQM-1nkDOl0XAk-008Fws;
 Fri, 06 May 2022 17:28:45 +0200
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
Subject: [PATCH v1 07/24] ARM: dts: imx7-colibri: move aliases, chosen, extcon and gpio-keys
Date:   Fri,  6 May 2022 17:27:52 +0200
Message-Id: <20220506152809.295409-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QpzcMql6/IF9Ghd25BqVELfMBiROsYBtZvrZcCggmh/Z/3Y/UHT
 qdnG/5xR91+LxeEhPXtZHuUvejGPASBJTUVkKlCYw8rcNij6EYqttQQGQFkGz/oYwTecXob
 MOkwCd9pS+UcT2oz+je6IftzTZM5wMED4vhWEuOjh3gggy7TFFra2uTu4qQxNgDIri+uMRi
 0rV7CX7dcMYLD1XtGADxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vzG8wR6IQIs=:/afAHazV92YtBBW/gmEwHN
 t42ghNMTK/oNR1cc19ra4/kjN0voZ1LA53OgYUoo6LhgX+4cPe15vWTZw8RRbrMukzIMEPaTK
 KQrkGdP56k8UvhHqncUm8fBw1uasu886LHKb9ZEsmEixcDlaS5dZQWTgP85eUPDlvW2A1pQ9D
 sjUOM/GawU4Z3t5Aha1sm9NjgcZ7oSW21WQvmUGUGWcwtX/32aDKe5I0+SLzt0czsxsyCMyJO
 uNhzQuQ7yIV1tr5I+Ko7sITiAkm2qkR9Kggn/i5dHFbleFm6b5iwYGu4jGolllg//uMh2me5Q
 QpyygG4ZxDiIoX6E8k7gWR7b1FKMWtZyI5l923Kjsxbs9/WyNICP/vjYIXTJM9F0doiTxAinc
 HJfwN/7bMVz3fe1A7t+itbUwYMwv65AYRF8cM7M4Ek3e2TNY8qqnGKcOfRDL/TSh3w01XqrLv
 qVYAyh8wyfJbiIuYaoGxL2igTA5THkaCPy2jCSvflv06jND82ArkXd1hadozQIGfs7NI5pj9t
 9MrH59Lj7NFtpCIEAaJ/VQMtTuJFr3vvlew6aWuysh1T/fQchDG8p6NdsPbXYdoNnb6EmA8Pj
 QNlRQ5duu0332StWz2buBJl5Nohi0jb38uES4PTL/59ImOs2Bjjaousc4rbJBumsGAHwMMEzJ
 35FYnK0b7bdxR0rkc2ilToWwfgx9nF3eGwUx9rv7EMVNelVOxyDI/cdtsT/AaT58AmWufkIWI
 wsgw4aDQfykREBnR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move aliases, chosen, extcon and gpio-keys to module-level device tree
given they are standard Colibri functionalities.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-aster.dtsi   | 18 ------------
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 31 --------------------
 arch/arm/boot/dts/imx7-colibri.dtsi         | 32 +++++++++++++++++++++
 3 files changed, 32 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index 9148c54403f3..c12de1861c05 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -4,24 +4,6 @@
  */
 
 / {
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiokeys>;
-
-		power {
-			label = "Wake-Up";
-			gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>;
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
-
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 4a7e593e9ac6..2e6678f81af6 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -4,15 +4,6 @@
  */
 
 / {
-	aliases {
-		rtc0 = &rtc;
-		rtc1 = &snvs_rtc;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	/* fixed crystal dedicated to mpc258x */
 	clk16m: clk16m {
 		compatible = "fixed-clock";
@@ -20,27 +11,6 @@ clk16m: clk16m {
 		clock-frequency = <16000000>;
 	};
 
-	extcon_usbc_det: usbc-det {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbc_det>;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiokeys>;
-
-		power {
-			label = "Wake-Up";
-			gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>;
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
-
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
@@ -148,7 +118,6 @@ &uart3 {
 };
 
 &usbotg1 {
-	extcon = <0>, <&extcon_usbc_det>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index fa615379a117..c5a58949d664 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -6,6 +6,11 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
+	aliases {
+		rtc0 = &rtc;
+		rtc1 = &snvs_rtc;
+	};
+
 	backlight: backlight {
 		brightness-levels = <0 45 63 88 119 158 203 255>;
 		compatible = "pwm-backlight";
@@ -18,6 +23,32 @@ backlight: backlight {
 		status = "disabled";
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	extcon_usbc_det: usbc-det {
+		compatible = "linux,extcon-usb-gpio";
+		debounce = <25>;
+		id-gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>; /* SODIMM 137 / USBC_DET */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_det>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		wakeup {
+			debounce-interval = <10>;
+			gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* SODIMM 45 */
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
 	panel_dpi: panel-dpi {
 		backlight = <&backlight>;
 		compatible = "edt,et057090dhu";
@@ -513,6 +544,7 @@ &uart3 {
 
 &usbotg1 {
 	dr_mode = "otg";
+	extcon = <0>, <&extcon_usbc_det>;
 };
 
 &usdhc1 {
-- 
2.35.1

