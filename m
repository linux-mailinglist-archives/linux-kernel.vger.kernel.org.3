Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D65008DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiDNIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbiDNIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:55 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C036A049;
        Thu, 14 Apr 2022 01:52:22 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N8oCQ-1nz3LP3x4g-015t9W;
 Thu, 14 Apr 2022 10:52:06 +0200
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
Subject: [PATCH v1 14/14] ARM: dts: imx6ull-colibri: move gpio-keys node to som dtsi
Date:   Thu, 14 Apr 2022 10:51:06 +0200
Message-Id: <20220414085106.18621-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t4Eu9Yla157sKjIMqXBTLTyk1QFmNGXZN6GQRUh6lSLFewEOTC3
 6fESAbwY56Rx70TRW+51iAM3scxk8ubUD/nxQgWlOLMFocN6e+mN1p/uhLmzjvv3et4pbn4
 szXY4CRMVIyDY3YISCc6pUnk7NXSuN7XBh2Yg26qvWPIMUt50b4ZoeBcEIr6VdJDXD+9g2u
 N1S7cjLtKuMq0aFMeIAXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3O2Al+diOKo=:RQPRgZ8d6Ud+DZpszriMn6
 WSHcbCE43LBvtegma1TK9LwjI/I37GN4rgTlstVndzi2oMRYHeEOdBopRece2XQcP3A7uZdui
 hNeoOWh0C/MX5KyDXLYGAXMhvDJgG6fQBOtacY/l9AfWaFXxUOdmI2JjK9rIRwmv6Lt25dC0h
 l6aTxTfxXHO6HODWay6z/AS3e78yyC9CJS1B4krkkFav4g1RDn7PQb6U/0zr57cE3IP6YLoGg
 uyYFGJQpMaJCdoURISLJkHplMo5BX4X4E2Ur6y8iiXhVBQWw4FonqsQBtAWVYt4Y8OYxyuQVB
 +NlibE9c/ckMrR1e/WVS0PxwjIFZnHGRFtzRMSHH9ymeq1OvStSNR1gEHwocZkZ34Ry6sM91Y
 sCbO2cr6Nl5mvXOWzEZZ4dHnV5jUHO3AbG3joSHj+Qr2e7+nngNjvY8gX/rHPTi4kuOUFtXAK
 7Ty/GYoLU1Tx1gCUjtWKVr3pOkKcVLyOripv+nYyuB1ng0FCzPvJgUu4j8qiRS2C51J0aAXm0
 mCD0WBQ4RUfNUQx3PJN3BiL3uekmE/wD32f0efAJYZ1SNJx0Ed1r4Wp9CXDUqkYnvwghjngg1
 pDshWNN8gMb4i8LvMIUu232PowVX0eRjN/jE5SdJ9J7xa0XcuZbSZdEUWESgxM9QlnVmjWswd
 HkAYq1dbfq4QRk+2jZSMCdEmk4NRs3O9BiQ0A5j+xb3pNFmKjNlANDkyiNgApgxJgznz2g4M4
 tq26hyzhefwaDftvd6hk75Wt65j+oXnIF9OJrEE8eTZboS2Plsw8zznCGtpaOvb/hviShSqH3
 EAnYI7AfT5LLMk/r5W+ALtibUC6Gw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The gpio-keys define module level wake-up pin functionality. Move it
from the carrier board dts file to the Som dtsi file.
While at it, also re-order the properties in the gpio-keys node
alphabetically and rename to sub-node from power to wakeup.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 15 ---------------
 arch/arm/boot/dts/imx6ull-colibri.dtsi         | 16 +++++++++++++++-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index 08197c66af12..e29907428c20 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -8,20 +8,6 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
-
-		power {
-			label = "Wake-Up";
-			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
-
 	/* fixed crystal dedicated to mcp2515 */
 	clk16m: clk16m {
 		compatible = "fixed-clock";
@@ -29,7 +15,6 @@ clk16m: clk16m {
 		clock-frequency = <16000000>;
 	};
 
-
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index f6fbc5c0e1ee..300c28db8e7a 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -24,6 +24,20 @@ backlight: backlight {
 		status = "okay";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
+
+		wakeup {
+			debounce-interval = <10>;
+			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
 	panel_dpi: panel-dpi {
 		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
@@ -707,7 +721,7 @@ MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x130b0
 
 	pinctrl_snvs_gpiokeys: snvs-gpiokeys-grp {
 		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x130a0	/* SODIMM 45 */
+			MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x130a0	/* SODIMM 45 / WAKE_UP */
 		>;
 	};
 
-- 
2.35.1

