Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CF51D8FE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392486AbiEFN2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391600AbiEFN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:32 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06DD6971F;
        Fri,  6 May 2022 06:24:49 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MQPne-1nNiP60Wzc-00TlRH;
 Fri, 06 May 2022 15:24:32 +0200
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
Subject: [PATCH v3 02/13] ARM: dts: imx6ull-colibri: change touch i2c parameters
Date:   Fri,  6 May 2022 15:24:05 +0200
Message-Id: <20220506132416.273965-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NglH/itG/phwz6Aw3Z4/JVnrTYv8/PuNhHZ8qeCtohqdIXjDyjT
 IXT2ee0yiOtX+G9p8BjW6C/9YPPrNKJHBI9Td6mKXCH9snmrdhctTyxXJsHtmUIcevmIxqo
 KjWku2O3whwH9P/c67ROKAQylx/QLHwjbb4lGuoGIFYZwXlaTkLe+vVG2F3q0qQ/7CNfrrr
 KPkBhYaBoI3yT7r+LPcRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1VxgiRBNDP0=:g3Ba5THtk/zXQP/xbUkU9+
 ErgHYf4mFEJxeYPMBVpSJckNwZteB/FQ/zv0iLf8xWXTCzSMYw+ulAyfcJMR5YmPY9lCf1Bm6
 CcIHOw5lxEUjtVK91llvgXkBG5HUxJTNKf0mka/qDyuVMq56agZE4S+qLbFXHWRsSUU9xgKZV
 lXG2SFrW5+KEiMieap0bvArsPCkyz8Y9JVJIwqzqLjcMGH2eWpYZaP4DXwr0I9P4Yvb3n36iz
 9jvoyyFeh8BpbQpwThRLRKqm8wLJOdbf7Hjv8+hvmZW+8DbdZiVvym1oGzXrfWVhL5QrcCan4
 SBx+K5Ccin7nU4wKdtPs2QzYQWd2ZjvIw/qXl9RbfhVWX5Pfq0BN5D+sSNcclum7fDzZrDj6i
 4tEV+4qTIrniwwZ4i+AZdz0VuQ/6aZIyXyiT2Epp0JelgMZia9AZ9YAz2qN/ZQIyV5Jj+f+Vs
 OC+g7h43/vSX6TYj2l+zenkiH2cL/qhVnR81lvbMEbXo1iNBLtTlrf0viNyy/J/y43ZTDwJKy
 /mj2FJ1/Q0amHj3r5Qth9eHAYmnkoTBMFON4Ba/+gxVXXolYx5+2bTIqtQyOklzqf35uSIPee
 51s/KaG6xEcFT4B3uyl67+paplKgZ3cVBn+ILuU059cPeG6gRZneOc1XUM/UVCF5A9l1Gb9L+
 ADXglGsDIIJl4CL2IdTgP3cDQQXrHuNxSNxiKfWn/3lSepvZJj8NQ3r2XlgEJEKQvVJE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 84bb7574d211..dc947035495b 100644
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

