Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4D51DC17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442943AbiEFPdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442875AbiEFPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:49 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB96D1AD;
        Fri,  6 May 2022 08:29:04 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MF3cC-1nbwBm1Ya0-00FQwS;
 Fri, 06 May 2022 17:28:50 +0200
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
Subject: [PATCH v1 09/24] ARM: dts: imx7-colibri: move regulators
Date:   Fri,  6 May 2022 17:27:54 +0200
Message-Id: <20220506152809.295409-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5laOCdj7QHxL+ag8jGrQaVaxkK5KF20XC64EkXjcWbZlGnr+K9J
 GL6QOlEpfBCSkuI3GyfdmV9Uh9DcqzDGio5R7ruk9VlkZBeO887PUs2MH8ds2eg2VcK5oQ1
 snRw/WcsTX3G2RvhRxFNn68MPjEyirOZiES4XTsDW/4XZFIrWb3gDPM3uA4AkVpfd8pjE7n
 5J8L1aKk7nrOTrd9Udkaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gZUJV1BPv4I=:SCAn7S3vQKoYbpZRn5DP2t
 AStc4ecKAfgLT6ZGMrAXlOykwMA4sQCeImbmNuB73MpbxlCsFC3/mpzVWczrabu9CO6o/uSL5
 iGDn01CnSxL/r2JFnYiUwUeVCpPnisFwnZjqAzx2tv74Cg5zKueLwz5VZGerFjxtA1qyoWhZi
 7aRsJaIlFqz+NV11ZmRdzjeLpQnX2emUK42rqADTo0wwILEv0ws7qTr5V504kHbjOH4lBfcn4
 tAUxlSMIl9zVyTfY5wMjbdTzoZjxZv/a9dR7+QNiieW1+HSpeSwiSrP6W24TcSiCFcAxRqynW
 zTBS7IkY061dU6d4hyv15y9022Bzxl+U9ZDACKUUGnCRr0RVZd9NvwRi7ffJlkfPqViQMMCBN
 HVZImTaSBTMVWtKyDVWtKLm2JQKVpzsIptE722jX3wlVfEpbKrzofBduOj53ES60uergJ3+UE
 3VCGaL7X9JFewjbHoCasC6EKFmqddXSbeXu9uKXdF/Z9zYe3xK3V6HjWEqcVCjHz7M1uDBaT3
 bhyNo2FgEFncNwR1c9BmEX1E1Re2scVJvY11g1uaXD8UXGmzJUNiAwNJEYBxHdON/OCTjX8iW
 DrDTfS8pSoG7ZurPOZ/maJ8hIPuL4ruxUUCXCYIwR3aibdatqsCblPIYd39wH55neumQJRKUx
 PNBQkHyW0O3U6/4PLUbKZHzD+U7qmEWf6QH+2xR5bZlxYmcntcDidbD2hIOH/M2zcQY8EaZQk
 2378PLdagwJOXDAB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move regulators to module-level device tree given they are standard
Colibri functionalities.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-aster.dtsi     | 27 -------------
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi   | 25 ------------
 arch/arm/boot/dts/imx7-colibri.dtsi           | 39 ++++++++++++++++---
 arch/arm/boot/dts/imx7d-colibri-aster.dts     |  1 -
 .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |  1 -
 .../boot/dts/imx7d-colibri-emmc-eval-v3.dts   |  1 -
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi     |  1 +
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts   |  1 -
 arch/arm/boot/dts/imx7d-colibri.dtsi          |  1 +
 9 files changed, 35 insertions(+), 62 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index c12de1861c05..440f98dc323d 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -3,33 +3,6 @@
  * Copyright 2017-2022 Toradex
  */
 
-/ {
-	reg_3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_5v0: regulator-5v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	reg_usbh_vbus: regulator-usbh-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbh_reg>;
-		regulator-name = "VCC_USB[1-4]";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>;
-		vin-supply = <&reg_5v0>;
-	};
-};
-
 &adc1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 2e6678f81af6..33a9cbbca0d2 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -10,31 +10,6 @@ clk16m: clk16m {
 		#clock-cells = <0>;
 		clock-frequency = <16000000>;
 	};
-
-	reg_3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_5v0: regulator-5v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	reg_usbh_vbus: regulator-usbh-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbh_reg>;
-		regulator-name = "VCC_USB[1-4]";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>;
-		vin-supply = <&reg_5v0>;
-	};
 };
 
 &adc1 {
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index c5a58949d664..329638985db6 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -62,20 +62,47 @@ lcd_panel_in: endpoint {
 		};
 	};
 
-	reg_module_3v3: regulator-module-3v3 {
+	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "+V3.3";
-		regulator-min-microvolt = <3300000>;
+		regulator-always-on;
 		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V";
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
 		regulator-always-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "5V";
 	};
 
-	reg_module_3v3_avdd: regulator-module-3v3-avdd {
+	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "+V3.3_AVDD_AUDIO";
-		regulator-min-microvolt = <3300000>;
+		regulator-always-on;
 		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3";
+	};
+
+	reg_module_3v3_avdd: regulator-module-3v3-avdd {
+		compatible = "regulator-fixed";
 		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_AVDD_AUDIO";
+	};
+
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>; /* SODIMM 129 / USBH_PEN */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh_reg>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "VCC_USB[1-4]";
+		vin-supply = <&reg_5v0>;
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/imx7d-colibri-aster.dts
index 2ed1823c4805..cfd75e3424fa 100644
--- a/arch/arm/boot/dts/imx7d-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
@@ -36,6 +36,5 @@ &panel_dpi {
 };
 
 &usbotg2 {
-	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
index 33e1034b75a4..7b4451699478 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
@@ -17,6 +17,5 @@ / {
 };
 
 &usbotg2 {
-	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
index 25d8d4583289..3e84018392ee 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
@@ -16,6 +16,5 @@ / {
 };
 
 &usbotg2 {
-	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index e77f0b26b6fb..45b12b0d8710 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -47,6 +47,7 @@ &gpio6 {
 
 &usbotg2 {
 	dr_mode = "host";
+	vbus-supply = <&reg_usbh_vbus>;
 };
 
 &usdhc3 {
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
index 51561388fac5..7aabe5691459 100644
--- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -47,6 +47,5 @@ &pwm3 {
 };
 
 &usbotg2 {
-	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index 48993abacae4..d1469aa8b025 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -29,4 +29,5 @@ &gpmi {
 
 &usbotg2 {
 	dr_mode = "host";
+	vbus-supply = <&reg_usbh_vbus>;
 };
-- 
2.35.1

