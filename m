Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3750E5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiDYQ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243450AbiDYQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:32 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EFC11F953;
        Mon, 25 Apr 2022 09:24:28 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M5dpW-1o71br34iu-00xYXo;
 Mon, 25 Apr 2022 18:24:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
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
Subject: [PATCH v2 03/14] ARM: dts: imx6ull-colibri: add phy-supply to fec
Date:   Mon, 25 Apr 2022 18:23:45 +0200
Message-Id: <20220425162356.176665-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425162356.176665-1-marcel@ziswiler.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0+FdhGU/ntWSyzpR14rp2dCwoQdc4CNQ9T0hYVYyUUwi3KM+KpG
 exShnAs/Ds92DrnCQj9hmRrR3CY3VHg5D59Tn0fGbc0do/tbUZP9hScRYNVA9Z0kVD3WNct
 FiujCO8oh5T04QNabFA86wcpfTXRM58mkzyHAyWcER/2Ats2XSBcUXeb7LX5blokcD3ifmT
 ashJGylaG1yJzpz7Vdb3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xYLDPxswUR0=:cWdIX1HrKGoQCP4mL+ejXx
 IWVgTVNNsKu57P1t4tmxUKqH1T9s5K8kDGLaSjDHqVGgMpulZN5FHSLHtlzB5jsIIcPvXn7JJ
 QJEmUuPmL1XrjrEcp/8tW3UA9ICLq8mtaxMkcurBQHzRKLMzr4hrEvDtxsnY877/7zwCld7bS
 WLnysdB3x8YdJn8hyHhjlecNZ2r9mPZX9rYAeoxts5D5Z7S6kyByH5Ihs8tn7r4LDcwse6IRM
 s7RXd/GoKjBwDJQx/tdSbACL4eyEQbSmQjNS+OtUzjQtHlw7Mn+Oi2hjVLULrEwILDHOG934M
 UuZRaqXWhJJtgG6r6ksdjXq1LZ4ghrmU0+BbL3flxXbKzZTJqm1u7jPwoMvRvpVgGqRhjfShP
 8ZcRfKrDHDWqRojRMofNgPVQUbPLqvmQKip3rg5fAfbWtnYZVGTTrHwtK2tPlJ+YXrYTKE2Yz
 Bj8Nka4iqFxf37KWxmp3ltRkiPcEpG8MnVs7z86xcSH9DFq5i7rwQsDNK4qYRhHw5Umxu5xaW
 cVq1urtJmBgnPiw2RKpi2IkWUiOeTCoK11OE1It6AV4vUlc2HYnEjMkEmkuAkPhJ6uHi/MzgI
 /gVipa6ywOGRjzM8rVVa5N++lJBiApjjGDb0gwHwDPQ+0fZ5ROLVhhSKN6yi+hMpls4l+/ycg
 YmBloNQv7aDS35YY65VtvDcNVjzZjKVUYz7pT1DoqstkT3toK/9ZM9Nowt/lIO78NSos=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This adds the proper phy-supply to the FEC. This supply is actually
switched by a clock that is now properly stated. This has the advantage
to add a delay for that particular regulator which is needed.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index bea00cfaa820..e619da3b00b3 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -47,6 +47,18 @@ reg_sd1_vmmc: regulator-sd1-vmmc {
 		states = <1800000 0x1 3300000 0x0>;
 		vin-supply = <&reg_module_3v3>;
 	};
+
+	reg_eth_phy: regulator-eth-phy {
+		compatible = "regulator-fixed-clock";
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "+V3.3_ETH";
+		regulator-type = "voltage";
+		vin-supply = <&reg_module_3v3>;
+		clocks = <&clks IMX6UL_CLK_ENET2_REF_125M>;
+		startup-delay-us = <150000>;
+	};
 };
 
 &adc1 {
@@ -81,6 +93,7 @@ &fec2 {
 	pinctrl-1 = <&pinctrl_enet2_sleep>;
 	phy-mode = "rmii";
 	phy-handle = <&ethphy1>;
+	phy-supply = <&reg_eth_phy>;
 	status = "okay";
 
 	mdio {
-- 
2.35.1

