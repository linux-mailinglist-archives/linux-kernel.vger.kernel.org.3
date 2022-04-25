Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701650E5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbiDYQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243451AbiDYQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:33 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576411F96E;
        Mon, 25 Apr 2022 09:24:28 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MOPlT-1nmcPZ3bu9-005rtl;
 Mon, 25 Apr 2022 18:24:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
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
Subject: [PATCH v2 02/14] ARM: dts: imx6ull-colibri: change touch i2c parameters
Date:   Mon, 25 Apr 2022 18:23:44 +0200
Message-Id: <20220425162356.176665-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425162356.176665-1-marcel@ziswiler.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ADHj/TGDKswkLg5a89IKMUfylJ4N+jPV7Tu6xHT0qRHr/R0TXFx
 yXx2j7uUeU9/KFV0gw/rpjK+HhW2pOmGnpqLnNnzZ8dM1jQjEhSOrNvQlqBcpUYC7dVz+Lg
 XBmJ3MCtQphX2Xl0VSu5ecnivlqEFScqIt52yZAUZlJOl5/J5rDCCidWN9sz/CJjiqYYuQx
 /kZapW8bgFwpgGX6trR1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BYdktJvC4Zg=:mtLyBkNgwc/nC3nHd9KkWh
 FtcoQDWnTUQZzvK3zLPlaEM/G+e8ikGFTFVERlJnl6dIwAxrUTRqGQHVYmfM8EMa/r9kB+5/8
 kkU1IjcmJtAaTBj0yNsHMraF8E1JSEZpgXx04grgxQA6CfRkFDfRLJaeaVwWfeqQHN2afFeYS
 vxAyXLK9Nk68jFvENjQQjkQ4JxW0nimcXxJLUa6Sog4W92eTCPcW/qW4RFsTAn9Li74b5ccxR
 Im82qS51lkvValY3WGzG++U8Mh7Xf7YcVlihFEtTdUfmQtlaJjtIzLxELjoj62jn6wVxoZY1E
 kxKwS6rPCyvxb6jkFn2Qbo/en/RuThoDIkRdYP+AfM7DAXdNY+wEMn+g+0yN93hBz+eVD5fdJ
 lkbGCmzHqMMegMpbJHn/PG6EuYt/eJB569tzcbeEWuzRQ+OqT5S0u5Mnl+zOlDwLEwfwsK+Ny
 9qiqr3AVHaRZIpKDz963M/rXWdT27rJxeBS4IRWzOS9Jz217+zIEX9XxPXT4EmLcv9UcLgVL8
 3Gb8HQtaMKGZP+jN2YXG5DQs1aHwx3RQGbCcNWZ+NY9h3YFsjUF/JkfOiTKoJAWRQpNAlrRQX
 8gwIi5PS416hsWXXmdeSv59VYW6Ejw6VjB7Gr209FBfgTGP8tqJYtfuD2SRX9TIy9g3ntGl2G
 /o1WD0FK/BH7V0Ahu6WJGJmJ3tc4YFTa+egK7Aoens9QzcUFWiW09XIRZsigxsTiiLzQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Switch on 22 kOhm pull-ups and lower the I2C frequency to around 40 kHz
to get more reliable communication.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index eb13ed60d2e4..bea00cfaa820 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -114,6 +114,8 @@ &i2c1 {
 };
 
 &i2c2 {
+	/* Use low frequency to compensate for the high pull-up values. */
+	clock-frequency = <40000>;
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
@@ -405,15 +407,15 @@ MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29 0x4001b8b0	/* SODIMM 194 */
 
 	pinctrl_i2c2: i2c2-grp {
 		fsl,pins = <
-			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL 0x4001b8b0
-			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA 0x4001b8b0
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL 0x4001f8b0
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA 0x4001f8b0
 		>;
 	};
 
 	pinctrl_i2c2_gpio: i2c2-gpio-grp {
 		fsl,pins = <
-			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30 0x4001b8b0
-			MX6UL_PAD_UART5_RX_DATA__GPIO1_IO31 0x4001b8b0
+			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30 0x4001f8b0
+			MX6UL_PAD_UART5_RX_DATA__GPIO1_IO31 0x4001f8b0
 		>;
 	};
 
-- 
2.35.1

