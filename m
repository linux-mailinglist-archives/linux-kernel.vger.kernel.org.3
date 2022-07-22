Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180B57E951
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiGVVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiGVVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:28 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF5B272B;
        Fri, 22 Jul 2022 14:55:24 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LfU6x-1nhslr0yNt-00p6VR;
 Fri, 22 Jul 2022 23:55:10 +0200
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
Subject: [PATCH v2 05/12] ARM: dts: imx7d-pico: indent use tabs, no spaces at start of line
Date:   Fri, 22 Jul 2022 23:54:38 +0200
Message-Id: <20220722215445.3548530-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RdDBStTWzDdkCguA6SaacDSlK2MqPT6N528sWZ1LLS23+x4l2TN
 GpDkXJftNjXSHvyBGzPUMY5AH2491ExarBHypkeHN5Glkl8+RRo14E8xwL8ajMZi+Z5z7Fb
 RdJ2xT8A4HdCzifS/ZzD8R9Q/VNw8VwdCFdA6eJhXPJDPell9Guvma6zgp9KBjBRwR8J1XN
 QLL3M4eafoyOHkmZ5n/8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DBbEMH/BTww=:5XPTqxB4MSewH2loIEBOTO
 fW6vOHAfyUwtNnFhNE6aDR2pgXbA7I9bbcdi72Wy1I1WemGxp4Itorm2uLBAfjH+Vf1Z+0W+X
 yinM2otriJaPrpgl75xzajZQYH2yrN3mT0OHl0nsg7A2cGuIgnRBaWv0UIjt7jETf5tCwMYy+
 lADDQBoLe26rt+p7oPAN3LtsyH35RAAW2k4iUBao1qh78TcGBuJVEUpa+kCaGIRoeG3TP4XEx
 qYSMAo4eu6P3ZECjiyzXxYGtS0Ddnow97PYgKDEb+cai5XLqiTR2nGT/Af3sbd6hvWZyjDVyF
 RW75yObdkF5LGOyTWSB8CQ6zJ9uDkWdKRxw7msW4Orlha5GSxWpCcNtbweCUGq8vp11gMdL7H
 gOzO3GM3rMIGWQcZ3CWmV9lAAD94111Z8coLM1EfZID/2REH8ynRk0jg190HfHfGLuh00wE/Q
 rOsr00F43kpSuH3DjXXMJLVe5xsj+J4Eod8ryYSWP4QjRn1TlmdwrTGp2HwKNElbw+6thecL8
 Dtf7vXhwT5vyGeHZpG3g2046DYHnkyqEatPC0bDurxvVvi6T1StvWfeFvDyq6fQNgveXYIy6G
 BmIVs4JOepjgVltBuBwduggX6WXFbwSGpjB62t+yuCSJWeQQxOXKNAE6n/vdhrAsLjBs/VKTf
 l72Q+xjaZKLYtXs+MzlE6Zyf9oXzE1ikNRNhdIABWqWMws/ujTC0p2mUp6rHohfm/+qhr7Q66
 lZUAueCkez1vrh9PLh4/EVVUShKCA6j0I5Fbh4wCHd5okF94cFElWbkFFlk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

(no changes since v1)

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

