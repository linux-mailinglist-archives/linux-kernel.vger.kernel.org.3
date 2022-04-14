Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5D5008C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiDNIyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiDNIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:07 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103BF5A0A0;
        Thu, 14 Apr 2022 01:51:42 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M2Ohe-1nfUEQ2XEs-003sXi;
 Thu, 14 Apr 2022 10:51:29 +0200
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
Subject: [PATCH v1 03/14] ARM: dts: imx6ull-colibri: change touch i2c parameters
Date:   Thu, 14 Apr 2022 10:50:55 +0200
Message-Id: <20220414085106.18621-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PrUdRr7lJNylNQs5YAAtcSHGAf2AuFsk+QjxxQZnL4oYz5aYOLt
 MZw9gTowkY7xk4JAjeKBP6H6CTRvujCq7XExmd+mfHeakqXeVvB+VHt88r3Bxy4zV+qSH7v
 lBH5jcHNVSqOoFYfN/2rrETdBJOEOzs3qL6qjTGr6K426OiKgWr0EuLU4uiPc+fsrOJ++o8
 Jmiw07EyrwlLznwJ7Ufeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VxVvqScpZWE=:UpENukvdF5ohWHmHhlqcdk
 fEHKd1197hG+IBTjH3QfG5rQY1rvYhL6a4ERrwANwh9sufmhFtyRvFoKlKgzgYadiFA2Pwl44
 9PfDuhetHnBXzYldhUHl6CyUZoyg+00toAIrp2l+J7CSShAQDY1uLPfVexQobhDI2g4hrRgbA
 guOm2vQfk1LwPnCTsQhEzuWzI81GBXc8FhMXmNg1J+5JUrgmSsVZoNwdTyi5cLlQHQA7tkn+M
 VEULd/Eb9jvaLcuKA2eBf/PnIRqNFmG5cH05HHV8noHsqalhaHxGzE1wNI3/uO7k+1jzGPcua
 cKF+i5TlRgs222mZyqOms5vBVQK9P3UL+pUlpt/OwmqJwPV+bwOB50dsoGqWAF34PokjchrBp
 92ao28asbYBE2pd7qJ12Hg0F73pRmY7kMYGJk9eYcuiD3Deua4lId8XAPk/paYTesi02KiGbO
 /i5efA+n8Gk7pyA1yT6Wfhf4IMDn7SYXiOOdSbpgAQckOEGESP8RJvds9EBI7ho2lETRmPmPu
 7vxbYFVYfGm1NQO98OH7AUmbteLeY6lv3pNNpWr/F59cTcr7F8Kt7ksDYx23rK0ZA5KLOUsnQ
 RKnc3W2cyx/z7AJrCLjvs60d+lsvm3wddripzcJ+wVCX+RlLiibw2CQND+1Aixz9uTQtTDiHr
 AsYvjf3z0ag4/19UjgdwHDBU5DJRJtxxIPGc/Q8KMl2wIBwH/mpjUUMELEQ1kFR8FjCo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

