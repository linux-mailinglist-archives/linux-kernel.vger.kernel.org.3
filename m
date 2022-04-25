Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264850E5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiDYQ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243541AbiDYQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:28:00 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC0211F961;
        Mon, 25 Apr 2022 09:24:55 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LiS78-1oJBD61bGW-00chkK;
 Mon, 25 Apr 2022 18:24:44 +0200
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
Subject: [PATCH v2 13/14] ARM: dts: imx6ull-colibri: move gpio-keys node to som dtsi
Date:   Mon, 25 Apr 2022 18:23:55 +0200
Message-Id: <20220425162356.176665-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425162356.176665-1-marcel@ziswiler.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2wLqalwvBvHjQI0F6bwaX+aju6hhfLeigrJDH7hvf7o4SviWJsz
 YjPxhFznJJ09jTQTFqTNy48dlPYgRPzdAVgSshekfav2zeuXZILl7tPO4CKTDqsYpGUTDG8
 I1j7Q/YTWdzbZpURx1j64jrd64IS+HEenyPsO/BP67qxnIILye/x2eQ3PlPnc0kic2r7pkM
 XsPzbMRKRq8m9C22+So5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YK334HG6ib4=:Ovs1iPJGRN9wr3DHRSPc0l
 OUhzsIK9U5FFfDu+4+zBN6RTQUTggDIS1mYlaNhVbxGXhu/m4Ufr4mdmgyRsjynfpPllCvJTB
 UHHdWoe9bpnzr0aIJ0dgWBPas17MY0QJXYxe/vrz+BxombJSywzTL1SneSFk2LqMYvuDKMQiB
 kwgTo6SXwA380cXM7TMX4/SjRej7+GcgKcZqsZtCgtAG1AQcJF67N9Y+qR8TElb4G7V/B2kqD
 Wu+A0SmyKjp66OBBcwXtrX3yhMbiIITcoVEJXixKT/JGKdzdgGROgsmZdnRA5uRzOcs99+J6Q
 0uBHndvydR0Uuewad3Q547VEq/lab2QVEXL0dW17JJW7DvPticU7DV6hKcUW++0J3l2pzdC8g
 Q2s8kxSl9R0Wnxhc/p8KASLV/N444IcoNz4qlfWkXxEuJqjaJh/O+dFFybEXtyb34vSj5JLLb
 xIH91wGRrkbV96CKi5S6BBcDyt9JMwBgD3KNPERXNrTfweimljjFDRdnzJ+pKv5/F+Id+90U2
 M/oKB089xTg6IFK9LFXfC1Ty7TAUg9tczNWM2dxz6Te0ouFXvv09CmODJXg84boUc6fjRLsWa
 9jC0MvdlmDxCM+GBttt55PBbG7M91T4Q7VP44jz780X/lcqJILHfB+fWvmN2LcVS0N7fiI9t5
 6mHPO3R/EOo5yqitcU6emN2UwmVJoyqvT35AbPsn8N09D2eI15/SCcm625U1Wtfvx6IIf7rh7
 58MNCXpQlJsTi0H5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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
index 13a3f251d9eb..f1e724f6cdfc 100644
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

