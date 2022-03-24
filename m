Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7234E6676
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbiCXP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351522AbiCXP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:59:32 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E0BADD7A;
        Thu, 24 Mar 2022 08:57:44 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N0WTY-1oIcbr2d1A-00wVDS;
 Thu, 24 Mar 2022 16:57:28 +0100
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
Subject: [PATCH v1 10/10] arm64: dts: imx8mm-verdin: add sd1 sleep pinctrl
Date:   Thu, 24 Mar 2022 16:56:49 +0100
Message-Id: <20220324155649.285924-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WIrHfN3/v5DuBXh1t3yffOL9Tw5KZ5XlFYczKupNGYPAq+n7WrD
 DANHRumWHhXIDVaf5JkUfT73VjmJ3TxuLZLkvYoo+whWoIpDQDlfGTZkKXwNSlX6QrvCWRN
 JSwyuxdjOSsQnE7ioFOyD3AP4IqtET8rzkithDHYiNVUDifnkxX8xFv2MgIN68tCuxTTbHO
 FpUEyqMuarciUkQLdUIUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jTvlto+j76Q=:H8J00gum5WgD7Mb3KULfw8
 x5bhjAs6fgiFIVkMO+yilqNZUYUfRk4FzUllQQGohPGBRq1mI/fnylRIHXoEVxKYUezhamNje
 8SC9L6FGlKwCCtUJtncClymECLE4QfY1NiSEoaoA7Uvq3DAFC00fS/3s9Ff8CGxGWU6EsVR99
 lQx0/5TQB9OsIkbyU7VRXK0KwN10wen31Plupp4JNA2/+rrjomCTshNzMJWIrlRowlhhkuOKe
 +GUCZmVrGBcM8jKfUGvzk9jrmNBVu12HujwXfLUyvtDDcS0kbcz2oc1M2AIRhnfnEq+dTgCWO
 mcJHg0IaMeKFo6LB+WkCGY7tDstDH9llnAARQO0PO1SG4FXYsMDy6ICc3SpMrMBg8mv95fUVY
 rKFbM3iplHc3IoqK1X5MFRNSkxFxDdAoe4tCbtpVYbUvpJiiNIV4ZKGfQ+h2iK//kdj9blf/2
 n+07MaVOBzmY/l6jErS3w1G4nMzyOHUqpRQ/Bt9BDkGXQfoYy9j73TtJxpYI2CpJqV87Lex56
 0Dj/3tsTSceyeqiu5IgENy1baytJNmpOE/8djt5kYa1kNZ7fv/1oFrQ4c+QiPUJApvjwLuLqe
 2GYzaX6H9BS8wmvHBETqadgirPnyiLNSMyQzb7BxMivs7oM+WEE4c5SN6HOmD9p/kSVaY6/ei
 ngVGJZPb/D6yxdTX13Uoq+DExZd58ngmIvK2O19uoBuApOfsI87p6FegtTpqhEp5ykWKGTL6t
 6BsX+JWnkwjW5eAw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add SD1 sleep pinctrl to avoid backfeeding during sleep.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 97dd7a00d63b..eafa88d980b3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -757,10 +757,11 @@ &usdhc2 {
 	bus-width = <4>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	disable-wp;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 };
 
@@ -1174,6 +1175,11 @@ pinctrl_usdhc2_cd: usdhc2cdgrp {
 			<MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x6>;	/* SODIMM 84 */
 	};
 
+	pinctrl_usdhc2_cd_sleep: usdhc2cdslpgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x0>;	/* SODIMM 84 */
+	};
+
 	pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
 		fsl,pins =
 			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x6>;	/* SODIMM 76 */
@@ -1216,6 +1222,18 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x96>;
 	};
 
+	/* Avoid backfeeding with removed card power */
+	pinctrl_usdhc2_sleep: usdhc2slpgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x0>,
+			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x0>,
+			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x0>,
+			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0>,
+			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0>,
+			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0>,
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0>;
+	};
+
 	/*
 	 * On-module Wi-Fi/BT or type specific SDHC interface
 	 * (e.g. on X52 extension slot of Verdin Development Board)
-- 
2.34.1

