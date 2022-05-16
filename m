Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35695285CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiEPNs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbiEPNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:20 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0139151;
        Mon, 16 May 2022 06:48:17 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LlDCS-1nI54g2uZy-00b4hZ;
 Mon, 16 May 2022 15:48:01 +0200
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
Subject: [PATCH v2 02/24] ARM: dts: imx7-colibri: add mdio phy node
Date:   Mon, 16 May 2022 15:47:12 +0200
Message-Id: <20220516134734.493065-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EiKg6GdRQXCI7+hpaiYbx3hOVFUyGIVPqTcXaERUXQ+xtiShetm
 DXtcaLGwYB8YcFjYLlFgKLC3CFKQ2ykja0a0hv4eu1mdhRNU7g5RoFeYuxoCjD4N8h8dxKN
 GjjrqNItnSsvS1t+Oenxgu+iy6d9PP0jnXm+ijLcCfqiFdiPwX/5dkXkbCs/CSjHTKAwKTh
 H5vXgiwtvmJdYeveJ+/HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ykcNnNnrMaM=:zNiM0tdeGuQynexErFVSWs
 +HoTlAhzM+vMPPT7ECRy+MMZ92doFs8SHFJsk2jaOg4rhM9XOGPZZ1hiZpeCq0yzsSDczqcSn
 Jj8hGGryhH/JAnrCte/DmjBg+phHQmZT1nC2n/Bsdrbz7LNdATQoWb6pmAmkf1m///6Bxketh
 KXJ//nhk7BcnFE7dlhMTxdfq4478Rtr38sipuzQb0rLytAUDqPr5KnIzngdXas9mReHbdUsKs
 3JPFrp9xlt7+SsyC6uwhyLzSueVmvatmGYiuSz2FVkNu++KzoyEkiT/1kzukqQiMy9omPPmWe
 wwZ7DICVP+jXyc6J7LX8sUzL8ROqutpke2dnkNErZ9kyLGJdxwcqswvA4m4x3Ev6kmDAw+z2L
 Mwz3iNw2SA5SPX2qxVnGZltH3rBwQXfHv1EIqzVsoy1v3Y3I+ZWA7qAsluQBtgtqosW3QjEIB
 J4ueNeNeNMPLXgie5Q/xEL5z5QmoB0YUmcQF6zHi/6cLfQVMJX0kOWvm0hWar/dvHC3i15UbO
 EQP2ml+KPuHBfrkRDPuQixbf42jUMwS/MNTlemg8pm4urfbE9l+kL2nk+z1PLFHIzxaQbL0AH
 G0QSOQDljBwyAESvEZm/WuW5M/XIA4hBh9cCsgYqkPkzLenq98irLYd6YeUc7x5WDYUqhMrq2
 arSTs4iPogxglWECtG4ydEiFppP6cb9ahA707Vs/CYOqnXRsyv/QTbf5TxjeNsuhiTCU=
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

(no changes since v1)

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

