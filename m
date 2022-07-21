Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4549057D48E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiGUUFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGUUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:40 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74A7435F;
        Thu, 21 Jul 2022 13:05:36 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M9WFU-1oBIxW0UAm-005Z14;
 Thu, 21 Jul 2022 22:00:14 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/12] ARM: dts: imx7d-pico: indent use tabs, no spaces at start of line
Date:   Thu, 21 Jul 2022 21:59:28 +0200
Message-Id: <20220721195936.1082422-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ma/1/gUOs+1SQ5WFYt6UMn+Ph4ajz6DquzBm4NWtSK7DSqJEH1f
 fBQ4Z4E8qrvxChuy6B8sWTCs6qIgruBWAuzBLJWizy/h4cw3lc/W8RVygWf9wjjipcf1ItE
 cUIxyYj2gMVRCAC1BanRUhji8+1QjC2KzZUCehxTBHz5E5GdyoFoc3wUbrct72wmfm0+X5i
 vGp2LdZIPGfT1SFzXGwaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QIN+N77RXoI=:3SEcnrIdS/24oPRKJCWvex
 NruA7leIbvr3qI9Vfuv4QG5igvubz2KLq4z9qBWjemq3pL67desQ12cwNEALB9EMUNbiBIzY/
 smnatO5BDunoYbFvYb7Nd3r0PcdFkeNqrO52uSyVfamrtf6D7C9v7XPHJvUr7pZXvKoi7/Sc3
 iLsOlaGLQKXG4R1P6gHF05jdTtwHQf80ds1YR11bf5E2OHEMirgL091Spv64q6nHAZc8quwYc
 CSJ7NPMtDPZ+T3R43h5E6VInCNxWDqylLRuwWYBco9Dqs/wCuU0fqcMbXLjCVRNivAD2WZUq4
 HKOldpeAnXkvHxsWpLGNaqScFydEywjinfJnNW76qglvzIXgkbcdwnIqbizH+nGTSMJ0aS+v8
 mfjml+YnIPrn3qUHIfWML9yaJ1spo6FLpdAx2n3SVAipTl2psI5q5wySmjnnHL6laQDGLJmo9
 59QRki9CEXbAO3GnIv9vjudXps+PyV3eQ5GLuuYCHfsXtV1Xgq7IBMNAFsbvi2Qo9u2tKlx79
 kJKQ8kILWVeqG3ggUxRbl/EAwmKcTA9GWEMgbedvDmcgfQK56cohVkBLhiMCd91dkCVp04X4r
 hoIFj7cYC5IJ/EnDNaD+VVScl/MZUatbxKql8ubgpiXELi+CuzsR+QsXrpkTaPcSEPeZECkc3
 NSE18+0/eZIp+auEW+Nlyi56PXr+aC1uw1XmA9c/bBdWWvjliNUCqCpDJSygyf97aHFv/ou3o
 Bk4GYwCkAzl3XF5JAQZxySzI8ythx0VAm/LrhA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warning:

arch/arm/boot/dts/imx7d-pico.dtsi:44: error: code indent should use tabs
 where possible
arch/arm/boot/dts/imx7d-pico.dtsi:44: warning: please, no spaces at the
 start of a line

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index e519897fae08..e0bff39e8d3e 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -41,7 +41,7 @@ reg_lcd_3v3: regulator-lcd-3v3 {
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-        };
+	};
 
 	reg_wlreg_on: regulator-wlreg_on {
 		compatible = "regulator-fixed";
@@ -432,7 +432,7 @@ MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
 			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
 			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
 			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
-			MX7D_PAD_SD3_RESET_B__GPIO6_IO11                0x1  /* Ethernet reset */
+			MX7D_PAD_SD3_RESET_B__GPIO6_IO11		0x1  /* Ethernet reset */
 		>;
 	};
 
@@ -493,19 +493,19 @@ MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14
 
 	pinctrl_pwm1: pwm1 {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO08__PWM1_OUT   0x7f
+			MX7D_PAD_GPIO1_IO08__PWM1_OUT	0x7f
 		>;
 	};
 
 	pinctrl_pwm2: pwm2 {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO09__PWM2_OUT   0x7f
+			MX7D_PAD_GPIO1_IO09__PWM2_OUT	0x7f
 		>;
 	};
 
 	pinctrl_pwm3: pwm3 {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO10__PWM3_OUT   0x7f
+			MX7D_PAD_GPIO1_IO10__PWM3_OUT	0x7f
 		>;
 	};
 
-- 
2.35.1

