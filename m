Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6065C51DC04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442890AbiEFPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442846AbiEFPch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:37 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C246D1B1;
        Fri,  6 May 2022 08:28:48 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MpE2t-1oARSy3KZD-00qhR9;
 Fri, 06 May 2022 17:28:32 +0200
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
Subject: [PATCH v1 02/24] ARM: dts: imx7-colibri: add mdio phy node
Date:   Fri,  6 May 2022 17:27:47 +0200
Message-Id: <20220506152809.295409-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oVrkLLgygwWKvFTplELyCAW33WTzbFbsXbnpKbLKnd1GGvNvLC4
 JQkrrOraOdfcZUwewFg/6ZUW/QB3bn1Qgf9gVZ0r+IdWaZ5go6lo6AXdAEQFymz29TaIF4G
 Bvv3oYI1HEIhoUowBsHaQ9VaCfdQxlrP2yukwLTUyAL6pAihNxiz2vyJ4q2iw2E27+uN07j
 cZLuKCZcd0M6Z1Ahm/SDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oCyVUsQyThk=:mAtEvTMhBtv/d3XevJvliU
 DIbKP6Cs+mzoi7ntuMhr2EFVnmDN42cuyWc/hzerRwMemIm2b3ZQEAJf6fX6+8qJCKZd3+tw4
 1XjF2deIOhjvecfv7IDCZOdwdMQvUOVQTb6pttyEz/PRfcgmGlFSlN/LawTZgDYzMFphx9F5J
 CCTTjPPksW/0G87rAnMCrtw2JHK3BNS7KvzSQNu3M75D5Bt4JzhLXKnDj783w4+1v/9oeDst4
 sgWr/4041TsF5x1gi1cHVSQH6HEck3jSNgnQGf7DLwdJAzzrLOKhGW4mjB+xn6rjbGAe0FmmQ
 zTEbpbJw/JQcfgWu/tVoS55+mKyi0V9aoXL8uDWaTG7BxM3UCunrnDiDuQL4oyiQActBtVx9z
 NWxTqCiLaUxTdlQcVzSiQto2ofEu5+AEjVpcW6RenyV80oneO8YCbnbasXHMIJP8qtLWx5BOD
 350jro+MV2eVDCRYAZb/a849bmm76ygXTlouluMzNBRBe15gFp2wfNxXHFC5o8hhfSztoePV9
 qciiMDnUttkNHYjtgfPsamNRK4ovLLCptUgWnQPTRFOiBVfm5Pj/vmsE2RY2h9blonIB0bmjg
 ewA5leIVkgMveqUzYlpJOabmZI1iBITJLXsaAxnnLSvAVbkcilQuSahTWik34X6N6WMDd4HGE
 1PlyAmqPKqsDrsSGsD1hVBjBZ070mqZ3CWUZLbZ1e7SmKnfNwQM05lWk0JeUXIGnHQYw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add the MDIO bus with the respective PHY to allow for making changes to
that easier.

While at it also alphabetically re-order properties and improve
indentation.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri.dtsi | 35 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index e20b0977f38f..074ebb0f8001 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -83,21 +83,34 @@ &ecspi3 {
 };
 
 &fec1 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_enet1>;
-	pinctrl-1 = <&pinctrl_enet1_sleep>;
-	clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
-		<&clks IMX7D_ENET_AXI_ROOT_CLK>,
-		<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
-		<&clks IMX7D_PLL_ENET_MAIN_50M_CLK>;
-	clock-names = "ipg", "ahb", "ptp", "enet_clk_ref";
-	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
-			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	clock-names = "ipg", "ahb", "ptp", "enet_clk_ref";
+	clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+		 <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+		 <&clks IMX7D_ENET1_TIME_ROOT_CLK>,
+		 <&clks IMX7D_PLL_ENET_MAIN_50M_CLK>;
+	fsl,magic-packet;
+	phy-handle = <&ethphy0>;
 	phy-mode = "rmii";
 	phy-supply = <&reg_LDO1>;
-	fsl,magic-packet;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_enet1>;
+	pinctrl-1 = <&pinctrl_enet1_sleep>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			max-speed = <100>;
+			micrel,led-mode = <0>;
+			reg = <0>;
+		};
+	};
 };
 
 &flexcan1 {
-- 
2.35.1

