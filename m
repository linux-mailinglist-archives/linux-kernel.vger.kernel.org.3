Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612D05285E0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiEPNty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbiEPNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:49:04 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246539176;
        Mon, 16 May 2022 06:48:41 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LaVpp-1nTOoR3q87-00mOQm;
 Mon, 16 May 2022 15:48:33 +0200
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
Subject: [PATCH v2 10/24] ARM: dts: imx7-colibri: add delay for on-module phy supply
Date:   Mon, 16 May 2022 15:47:20 +0200
Message-Id: <20220516134734.493065-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MNItR7s/bmR+5uVBwwbJ3Zk1WETutn2ATdlnbs2j3z42Scnylfm
 3o086A00d6NkX4DbMpBv2MIgLvs6gtPK8fnC0R+f5E6ElelPR65nrPX7hXsIMVAYXbaq8xD
 0W+U8BjQLtPSdLrat2NAHW2Z9w8VMReW5RwL7fyHvhCVp9t/0NMYMy4QjVD8jSJJ/1ODvNs
 +CB9I3c4mKoW6d5/CzLjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fCszss8YMos=:BEfF6oyMEQGpsrEXszJEZe
 dD085/5lkLmY6IOtuu1YYetJPRQ3Ue/meHbWjZNqE1Hs0LpxEQgs462nh+d8AvlVt1XpSixDu
 yNA6fIX8v7if7d/27qTr2xC1NsOm46tmQH1JJE5eVFKEhkp0Gzf7bGF+bjvDkdv6Nco69TZVR
 IVzeX9K4257uja73niUOwnJlFUE1qC81kinJs7sTYenTDFbaIaN2DCTQg0ZV1hHV2VCLQuol3
 Z8sm1coY0a1+RfLN1h8PPlb8Vs/pkEw4fIOIlQVzUBO65kPG/1UOtVwZxw7FNLGR2yBOcdy+3
 xLVJ3Ka3MccPmnvi6Jf6A+JE1n/XNxG2H8sLPa4WJQz12YNw5qZHh73iSeIMACYKMg3g4eZPn
 vBAcE7E+Qz/cyaR4Agm9CI+r5484p8+SbDNpGrBAxGG+g7cS0SJxdLcpYIH22rtAN2E1CQSRH
 qALr+p5tl1ZQJXwhiukkOwsDVOulr3wH+GY74KZsUJyUGIw0OB3FxteYSHzrh6u4Ni0MPZoSZ
 gr6VP6IH/ff6FsdmIsvnNRNatB6mjHbOMpWluXXaEa+4xVpkuFt5DJgCrq+TpPWjDRI8N+ZtO
 0+LKTCRX0E0JJVT9HP+xqq7y67Qp+rngqQriuhdpEogNBKYcPcF5lu6SE8Gzman/JKWovrT/R
 O8oKa6fFPgh4Yar2bNE31qJ3gzwHlFhNLUd9HG9uj7znfwNrV17Uc1+6MR1lIuLaES7E=
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

(no changes since v1)

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

