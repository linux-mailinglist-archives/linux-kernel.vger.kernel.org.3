Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB24E6690
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbiCXP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350615AbiCXP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:58:57 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C571AD109;
        Thu, 24 Mar 2022 08:57:23 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mrgkq-1nsBnm0nau-00nfUk;
 Thu, 24 Mar 2022 16:57:02 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/10] arm64: dts: imx8mm-verdin: update regulator names
Date:   Thu, 24 Mar 2022 16:56:40 +0100
Message-Id: <20220324155649.285924-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:I035u/TEBtkJzziFVV5WB+N0KkClcIp6K+bbegIPfj7H5mXmNjL
 k2A0LCla47UVCnMBv0djfEvGGhS2cmKCMRLpFGo8RU4vVsk3NSxnGHWmmzuIhq2IpQuEf1Z
 WpH4gBaair4CJBje1eT3sr8m124A0NFJyGBdUvFS9kYd3JAGcffz7XzmdVtrlM37/x+EfqN
 3C/h1n6F/GOl0BKJjuoFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iXGFFCpYWmI=:GrN1dLLY2hywm8USLmI20G
 +c5phTW05eWcens1Y9Dyu2tmJC+MfRXQESwUVZ20WzWSfzFDn/AX907Li3/3XMEP8Moj5AdON
 7Y/lnfPBUqeh4Mmiqwy9vj2EpXHCidkv76roBSkzvzkQWzzDvwAAZnuaeABdoDtnzbU/BilaT
 ri/wd/SeVO36M5lv01Pm0s2+T0btQEiBcmlqnDm1CFZ9cHWW1LrNJCddu2JKJBmErNP588cAo
 Xbd4n7Q6jt3cx/PbscbjLnTQw8iH0w9YOaom4kPrpi33gWhhFNQ2ZnD9DMzV5MPYPP9rWcuaM
 b3pDrHG3B5bqGDF0DpLaGe4uWnqZQ2okMjPu8sNH87eirTQqcsPf3/E2Jpvj3rXwvrIeILc4a
 Rmhf1LgVPs4fyandJmNmCUjyEkTtf6sAPCtZQdakm8++SZagS8oor/nwxxzg9tOrcmhU1YLVB
 2A1BKS5OTzynouMK8KFn2O59brThec0pJzMpQXYs3nOsxKLA6HLAu/WDcVexbRTgzdpbgMr92
 aN7VpvgormgAEzXhmBmtkR0V5x6qVnCvVi1g0Nn7ABtAH0e2yM8UAv22Y8Fg8Pa9aKAkJMMFn
 Qy1VyA/CJSDE1SyvO+7rS0rH929hJNQdiGCD3sfbbACjCCMAV8O/CCAIwDyxYX9eIHH78uOUi
 6B3jVU1VaN2NZ5zC3uhMNAHEt/9YsVHFxOPr3/H9OSn4Zq7VK0S4LsfzLgMwrLmcFnYU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate regulators which are on-module.
Rename usb_otg{1/2}_vbus to USB_{1/2}_EN more in-line with Verdin spec.
Annotate PMIC regulators with information on which BUCK/LDO they are on.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 0d84d29e70f1..f70782d2a23d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -86,7 +86,7 @@ reg_ethphy: regulator-ethphy {
 		regulator-boot-on;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
-		regulator-name = "+V3.3_ETH";
+		regulator-name = "On-module +V3.3_ETH";
 		startup-delay-us = <200000>;
 	};
 
@@ -99,7 +99,7 @@ reg_usb_otg1_vbus: regulator-usb-otg1 {
 		pinctrl-0 = <&pinctrl_reg_usb1_en>;
 		regulator-max-microvolt = <5000000>;
 		regulator-min-microvolt = <5000000>;
-		regulator-name = "usb_otg1_vbus";
+		regulator-name = "USB_1_EN";
 	};
 
 	reg_usb_otg2_vbus: regulator-usb-otg2 {
@@ -111,7 +111,7 @@ reg_usb_otg2_vbus: regulator-usb-otg2 {
 		pinctrl-0 = <&pinctrl_reg_usb2_en>;
 		regulator-max-microvolt = <5000000>;
 		regulator-min-microvolt = <5000000>;
-		regulator-name = "usb_otg2_vbus";
+		regulator-name = "USB_2_EN";
 	};
 
 	reg_usdhc2_vmmc: regulator-usdhc2 {
@@ -345,7 +345,7 @@ reg_vdd_soc: BUCK1 {
 				regulator-boot-on;
 				regulator-max-microvolt = <850000>;
 				regulator-min-microvolt = <800000>;
-				regulator-name = "+VDD_SOC";
+				regulator-name = "On-module +VDD_SOC (BUCK1)";
 				regulator-ramp-delay = <3125>;
 			};
 
@@ -356,7 +356,7 @@ reg_vdd_arm: BUCK2 {
 				regulator-boot-on;
 				regulator-max-microvolt = <950000>;
 				regulator-min-microvolt = <850000>;
-				regulator-name = "+VDD_ARM";
+				regulator-name = "On-module +VDD_ARM (BUCK2)";
 				regulator-ramp-delay = <3125>;
 			};
 
@@ -365,7 +365,7 @@ reg_vdd_dram: BUCK3 {
 				regulator-boot-on;
 				regulator-max-microvolt = <950000>;
 				regulator-min-microvolt = <850000>;
-				regulator-name = "+VDD_GPU_VPU_DDR";
+				regulator-name = "On-module +VDD_GPU_VPU_DDR (BUCK3)";
 			};
 
 			reg_vdd_3v3: BUCK4 {
@@ -373,7 +373,7 @@ reg_vdd_3v3: BUCK4 {
 				regulator-boot-on;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <3300000>;
-				regulator-name = "+V3.3";
+				regulator-name = "On-module +V3.3 (BUCK4)";
 			};
 
 			reg_vdd_1v8: BUCK5 {
@@ -381,7 +381,7 @@ reg_vdd_1v8: BUCK5 {
 				regulator-boot-on;
 				regulator-max-microvolt = <1800000>;
 				regulator-min-microvolt = <1800000>;
-				regulator-name = "PWR_1V8_MOCI";
+				regulator-name = "PWR_1V8_MOCI (BUCK5)";
 			};
 
 			reg_nvcc_dram: BUCK6 {
@@ -389,7 +389,7 @@ reg_nvcc_dram: BUCK6 {
 				regulator-boot-on;
 				regulator-max-microvolt = <1100000>;
 				regulator-min-microvolt = <1100000>;
-				regulator-name = "+VDD_DDR";
+				regulator-name = "On-module +VDD_DDR (BUCK6)";
 			};
 
 			reg_nvcc_snvs: LDO1 {
@@ -397,7 +397,7 @@ reg_nvcc_snvs: LDO1 {
 				regulator-boot-on;
 				regulator-max-microvolt = <1800000>;
 				regulator-min-microvolt = <1800000>;
-				regulator-name = "+V1.8_SNVS";
+				regulator-name = "On-module +V1.8_SNVS (LDO1)";
 			};
 
 			reg_vdd_snvs: LDO2 {
@@ -405,7 +405,7 @@ reg_vdd_snvs: LDO2 {
 				regulator-boot-on;
 				regulator-max-microvolt = <900000>;
 				regulator-min-microvolt = <800000>;
-				regulator-name = "+V0.8_SNVS";
+				regulator-name = "On-module +V0.8_SNVS (LDO2)";
 			};
 
 			reg_vdda: LDO3 {
@@ -413,7 +413,7 @@ reg_vdda: LDO3 {
 				regulator-boot-on;
 				regulator-max-microvolt = <1800000>;
 				regulator-min-microvolt = <1800000>;
-				regulator-name = "+V1.8A";
+				regulator-name = "On-module +V1.8A (LDO3)";
 			};
 
 			reg_vdd_phy: LDO4 {
@@ -421,13 +421,13 @@ reg_vdd_phy: LDO4 {
 				regulator-boot-on;
 				regulator-max-microvolt = <900000>;
 				regulator-min-microvolt = <900000>;
-				regulator-name = "+V0.9_MIPI";
+				regulator-name = "On-module +V0.9_MIPI (LDO4)";
 			};
 
 			reg_nvcc_sd: LDO5 {
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <1800000>;
-				regulator-name = "+V3.3_1.8_SD";
+				regulator-name = "On-module +V3.3_1.8_SD (LDO5)";
 			};
 		};
 	};
-- 
2.34.1

