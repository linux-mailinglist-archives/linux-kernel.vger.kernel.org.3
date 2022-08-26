Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B15A2FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiHZTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiHZTXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:23:21 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC93BBD4F9;
        Fri, 26 Aug 2022 12:23:20 -0700 (PDT)
Received: from toolbox.int.toradex.com ([104.5.61.88]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LiS78-1ozsfx25pk-00ck07;
 Fri, 26 Aug 2022 21:23:01 +0200
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
Subject: [PATCH v1 2/5] ARM: dts: imx6sx-udoo-neo: don't use multiple blank lines
Date:   Fri, 26 Aug 2022 21:22:49 +0200
Message-Id: <20220826192252.794651-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826192252.794651-1-marcel@ziswiler.com>
References: <20220826192252.794651-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nMxnJVY3DjKpIxBtOTY9BUBzvfqQ/iNpACfPU85XRrXSE7F+Qmp
 SCciqoRnkr5hzoJp3O/FPSKjshFVR6fneL8oL2Ghx9IY7shl2eHUJqACA8JbBfxcQoiR0UL
 wu1G8SRkGeFfcKuXUvbWuBj55HXrjXOktFoK2fHXvxBatejTQHoy00VRzSg7kgCIMa29vZq
 zCZYjcgepwN9OarLsvRnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:24kIE7ZK/Zo=:ln0cFXTOIlzPAqZyYINRMF
 YwJK7GZ8HL9oppF6SgqKaSbCJdEvgFH33RX7UbJV0ObZqLvR9nWfcCHNAblkMiM36f9biGaTY
 eqYSWFM9x3E+yWC7ekEqUF6FOGVpM4c3YwBTYfdtKopOcdTFOI5uqQwX3S7ilTvO+MoXXVJnH
 ffxiMv/jRp94vUQPv6GQ0IauFt5jQPhOKh1LabjYNO5qxJ9YXperYuJS3zLC6U/dtcwnJzZbV
 n0w72Adxz/wptkUTLvkj4qA8ay5JwH5MTSpVkl3VcHyOq+VerUTssPpekzPD+8/Tec30hCDcK
 pWIJZjFebXa49rpQYNi4YZ3vTgMjL7PQl9k67B/RxJVwAJ8i9OnY+MSbpbFzsgaPezXW6Mxop
 hD2xryEKeAYUKbmXacqH1AQixhQTj8ACpfZpJ54SlcoFzJQDMpt0HWWB+XfU/y7OsPq94BPXZ
 RnFdtX94nhS4EPLOWWSojXG6EnS/8lhPDKxTAHpp9INkhQB2xLPBBkflzan5qD+OWqzo22Ruy
 vLLATHgqMrqRr1zZwcjNGRiTUPkGAS3AYlviZedsUCGUlyCF6ogDcZedaGauv5sHAlZWv0UPS
 X2pWbWEjYNReswB35cRqhSmwSSQ7HbqEnfJhGN6iZUA2H3Ry+hWZ+i4Qhyvs2k3edS+yGhbV/
 6IkRwQIRO9IM/BDtLazASFhWlyIFTloOf9VLZi6D/QlvHzvMbsnKA0jG9VHsWbk6/zvFwrqTK
 +TD3c7H1fWSGU2KE1uWkMuPUmYRwFYcA9uSmRw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following warning:

arch/arm/boot/dts/imx6sx-udoo-neo.dtsi:309: check: Please don't use multiple
blank lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index 35861bbea94e..c84ea1fac5e9 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -226,7 +226,7 @@ lcdc: endpoint {
 &iomuxc {
 	pinctrl_bt_reg: btreggrp {
 		fsl,pins =
-			<MX6SX_PAD_KEY_ROW2__GPIO2_IO_17        0x15059>;
+			<MX6SX_PAD_KEY_ROW2__GPIO2_IO_17	0x15059>;
 	};
 
 	pinctrl_enet1: enet1grp {
@@ -306,7 +306,6 @@ MX6SX_PAD_LCD1_RESET__GPIO3_IO_27		0x4001b0b0
 		>;
 	};
 
-
 	pinctrl_uart1: uart1grp {
 		fsl,pins =
 			<MX6SX_PAD_GPIO1_IO04__UART1_DCE_TX	0x1b0b1>,
@@ -347,24 +346,23 @@ pinctrl_uart6: uart6grp {
 
 	pinctrl_otg1_reg: otg1grp {
 		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO09__GPIO1_IO_9        0x10b0>;
+			<MX6SX_PAD_GPIO1_IO09__GPIO1_IO_9	0x10b0>;
 	};
 
-
 	pinctrl_otg2_reg: otg2grp {
 		fsl,pins =
-			<MX6SX_PAD_NAND_RE_B__GPIO4_IO_12        0x10b0>;
+			<MX6SX_PAD_NAND_RE_B__GPIO4_IO_12	0x10b0>;
 	};
 
 	pinctrl_usb_otg1: usbotg1grp {
 		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO10__ANATOP_OTG1_ID    0x17059>,
-			<MX6SX_PAD_GPIO1_IO08__USB_OTG1_OC       0x10b0>;
+			<MX6SX_PAD_GPIO1_IO10__ANATOP_OTG1_ID	0x17059>,
+			<MX6SX_PAD_GPIO1_IO08__USB_OTG1_OC	0x10b0>;
 	};
 
 	pinctrl_usb_otg2: usbot2ggrp {
 		fsl,pins =
-			<MX6SX_PAD_QSPI1A_DATA0__USB_OTG2_OC     0x10b0>;
+			<MX6SX_PAD_QSPI1A_DATA0__USB_OTG2_OC	0x10b0>;
 	};
 
 	pinctrl_usdhc2: usdhc2grp {
-- 
2.36.1

