Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484575008D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbiDNIyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241207AbiDNIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:35 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806A65D39;
        Thu, 14 Apr 2022 01:51:56 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MTisb-1nWrHE3anN-00U6MD;
 Thu, 14 Apr 2022 10:51:42 +0200
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
Subject: [PATCH v1 07/14] ARM: dts: imx6ull-colibri: update device trees to support overlays
Date:   Thu, 14 Apr 2022 10:50:59 +0200
Message-Id: <20220414085106.18621-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o18EqjaqFqmOiCMZr9tOYKPth0afq3U2xv0bEeiIkxnX1PIGNMR
 oPvoa/eG2TpS6QE1WRE9QyJvzpSBxg1cDnMbn5rb7qC7k1RMCmihXxZBe9zJVEcidwD4v2W
 CnKwsfa2K5+KQ5buqJgHbYvsNqA3fRxOdcjRmxv70+508qJDuBKgLBVwGLWNR6N5WIUHGZA
 eXGrvTuO5W99lG/Zvel/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gDAZEyIffAg=:AfoY5Ebp5ykv65njsNwENK
 p2kIJTSin0JcuejtLWxr38qGy4GFc6HPzlsKqvdEITGyZf4E+IogTHpYxsylMy5LjCpsctdGZ
 HFtOCZ7Qgj9Oo7xdFvA+AJP7K7OJSnR+QsoWAgmvHM6dVCwwWx5D6lRXjolU5r/OP/KCmvcqS
 TRsYnzrL5ItuxGodOCthsrsk3CPQfsi99FoS1hp7w26RmNRlPkKd4yWads9Fg4fHk3I1rCcSD
 61y72gFVrdCYts+jzx7h3Ia3vcgYUQfufxxl+BZynQygJECIs1Q4VCAKfuXVp2RQ2OC2KJ3W7
 TFwJZcG8EYufLEPaJIXVfcgivkDS+8v0Wsl6El22jYZF4P0ybg0UdOm1hL2P2HzknRqm8tdzK
 4GXtTAi/70I4ZbpjyWX+YQojtj0+3sSbFxdoXjCjHXOoa8HvaP4HJ3+AxB5Ah9z9FYNSGiSQJ
 gcgIo9lYGVulAS5L9F5v+wy6Dnya9lMA7aXryVITxzyprQNlbHoOHpYILY83oVxdNXdhAD8qL
 t1mZRBUBlEM6J4BZXy6K1UCQn0kZSvem37eSanYoVWnfsZjG36/TEriRSdXTSSj4OXoMG6XDJ
 x4ZpMG+owo1/Bzk3WVVZ9m7iekYamux7rJkPkz79BeZourytZtI7AJzAXsHc+1LpD06HuWGQP
 QV8QunRnd7hPAtvb+t3op0JN2mPWYWMWmpKF8xj21CfPbCjcLR8gYpEpYL/xLAQ04DFMGo3ot
 afiC5g9GmvSf0huE
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
index d633288b8ee8..a1e26ac4d1e7 100644
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

