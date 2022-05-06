Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55AB51DC21
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442961AbiEFPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442865AbiEFPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:55 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA46D3B5;
        Fri,  6 May 2022 08:29:10 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M1IF4-1npjiB0NZq-002llS;
 Fri, 06 May 2022 17:28:53 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
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
Subject: [PATCH v1 10/24] ARM: dts: imx7-colibri: add delay for on-module phy supply
Date:   Fri,  6 May 2022 17:27:55 +0200
Message-Id: <20220506152809.295409-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:prmmGjODMASiwQejOwpv0+0U+9fTCcyS5sPOIBvSBXEiafxEZ7b
 r+JpfOV9IvW0/ap3plhwe4q3Up2MHeEAGG8QJZ3oUw6HDc6kbn/PPgkTbI6smr3BlrhN95r
 i7maoZADPFMHcOWslw+8toWzBv1Q4z1tpVG4mBdNgWdUyMnenmC917ojFMWyrcPbPtkeSWE
 JgdvgE+PWlRzk4AwMzpcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QgdhHhQYsaU=:YquTNlcSgdxRp4GmRwPkBJ
 +v2rhl1QYWfndIu4pexiXn7kP+QNGjW5GfGDb4xNfBnN8EeYFaER6oiB3ySNH6K8kaBvXeNu6
 68NINcI2s1CzU9/koc1OZoboGg32SaqZtPmnfwxBdpSZnOGAXSqb0vstkDpj69W6zQLU+czOp
 8XFlkzOLLbCiZ0whYoLXTaVugZUWrpSgPUvCPgPogyx5S8kWtoPOF9sIcqR13g/xmlTD8Athr
 Vl1OH9xbQwA/Y1FZjhgegoHvikrEOgp7r2yjz/5v3qCUo5LI3WjymWOdhwI8qTCOKx0lb/vcu
 5mmBX1BZ2XSo4ZlNElv3LmBl7ludFj7OjGXWqAoZMtM2IF4HHubhlRomChYI4LN+7quwmTrGa
 yOOLxqTSFRYQVbwrY4hhyv0Ctia8S2yu3MbNnRoC0WQmLBj9RKsN3hN06SCpoFMRScIGwsDq5
 hRrle0Wh7Vzqv9ajlAusonZOh4eoH0Ri8L/gauv5p9YysKjvEdQW/efznVy0Nvlequalcc+9J
 LJbS6rZgnfViX9WSKUiqvzm7iwUz4ZPY5TYimCVE7Gcfgofx6l+Gf00ohSDwSltO6E86VkQaP
 7DzWlzREGRqAcl2IBRXoBGMx9dzfAsO1CRcErcy9zzvBrv1JcUQCeRGxieY46uYh00yUTlgtf
 BZ3eSJh6IBArnBfSXqFyMk8JIZWQ7ChL7nP6ZGksN/deoybXSeY4KlPJNc58FeZnn0UA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

There is a significant time required for PHY Micrel KSZ8041 to power up.
Add a delay on start-up/wake-up before the FEC starts communicating with
the PHY.

LDO1 takes 6 ms, R39 + C44 takes ~100ms, the KSZ8041 datasheet asks for
~11 ms before starting any programming on the MIIM.

Counting that, add a 200 ms delay to be sure the PHY is ready for
programming. Also, add the same off delay time to give the capacitor
time to discharge in order to properly reset.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 329638985db6..09dbd262dad1 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -94,6 +94,17 @@ reg_module_3v3_avdd: regulator-module-3v3-avdd {
 		regulator-name = "+V3.3_AVDD_AUDIO";
 	};
 
+	reg_module_3v3_eth: regulator-module-3v3-eth {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <200000>;
+		regulator-name = "+V3.3_ETH";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		startup-delay-us = <200000>;
+		vin-supply = <&reg_LDO1>;
+	};
+
 	reg_usbh_vbus: regulator-usbh-vbus {
 		compatible = "regulator-fixed";
 		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>; /* SODIMM 129 / USBH_PEN */
@@ -153,7 +164,7 @@ &fec1 {
 	fsl,magic-packet;
 	phy-handle = <&ethphy0>;
 	phy-mode = "rmii";
-	phy-supply = <&reg_LDO1>;
+	phy-supply = <&reg_module_3v3_eth>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet1>;
 	pinctrl-1 = <&pinctrl_enet1_sleep>;
@@ -440,7 +451,7 @@ reg_DCDC4: DCDC4 { /* V1.35_DRAM */
 			};
 
 			reg_LDO1: LDO1 { /* PWR_EN_+V3.3_ETH */
-				regulator-min-microvolt = <1800000>;
+				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 			};
-- 
2.35.1

