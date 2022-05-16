Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E15285DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbiEPNtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbiEPNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:40 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D97D3A1AB;
        Mon, 16 May 2022 06:48:32 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MQgmZ-1oKXcm1fJt-00U2ZC;
 Mon, 16 May 2022 15:48:21 +0200
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
Subject: [PATCH v2 07/24] ARM: dts: imx7-colibri: move aliases, chosen, extcon and gpio-keys
Date:   Mon, 16 May 2022 15:47:17 +0200
Message-Id: <20220516134734.493065-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gvb4Pz7xuRxZ+58OL+CJboTfCyHLK0D3kqPOjx0qC972LhlnSeO
 AtsJRG7vrlk/hhQtnfAD1SNBwB5XdeN+lkF/3/ksJjFJu35W/lW1i8H+zDSQTyqXdYEf4jX
 a3WVSZVFDTvMJrDPWWcOoCxMfflBB12btJbfhSKIJqz/cHDG0S+4am7GUT0YgvC2FxYLiKa
 K+9HbPx0TPA14+k4qZMeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8NXUCNc3Y5E=:V3+fSEHt1EH+onN28TjwUm
 Jdyt5xk26q5GJvn9bD0PH/y4Le/EcoEv7wtyt/6BIdxiiYJUA5N/eJD2uP1QGjFGKU2BT5K1F
 +B3gypeEztC+cG/7sJ2vxDokepI2OWqQbpQV/HbCl9dtpmd5G34DQDDbDKGsXOkbuUf4so0R2
 laVxVONB4b9MMlUNGd+yZW3/wkNE+RQZHdcM5e/bmRn+RbXQ2ua1d9wN3Jd2+NLiOZFH20P3D
 58rsVI4qbR8ljHu4yiCD/8RdM/8NO6hWcpLZQd6xUyajKFyJqKZy+jBIle8SgqtZNTvNDPbjl
 5pCXTsUgg0GG2j9N5OeEDP7Hn50lPePRPDumJw7wbtsS0NAegN7ZxWSaRRHo+jJRTq+6/GMFC
 6KRR7o/upwPRUnrW4eeB/7eyFvlb/3YIe0HlqmvAapfwMsyQ4qXawifWu3rcILyVqh46dxTlL
 izpmHXGLmPqg0QRjFMbi2d2inS7mRSc6PiW8901sc7r5Nw0wtgNN73mdoThrz0foFgth46vmg
 C5zO84uQ2TFrxzUQQS+q67+ypT/84cmkXqScKFEjqZUl5OI9bjjnaW2fVbBjT/Vsg5ufe0t+S
 902ARmEA9UvHKVmkMDTXay3ESgQvc99JLzDw24aDf5Fzm1E43sxPfCHEEI9S+E0h/fFKFYGeY
 gRr09F/TMs8EvVbKJLBn96NyfJMjAFnXJ/5NJo1xDiWAqOV78tMPGpGFW9pDjvxjhuac=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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

