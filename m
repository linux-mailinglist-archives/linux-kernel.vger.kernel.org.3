Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3BE5285D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiEPNs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiEPNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:24 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3883B39157;
        Mon, 16 May 2022 06:48:19 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MVw6g-1oNYIr1L0i-00X2hX;
 Mon, 16 May 2022 15:48:09 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
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
Subject: [PATCH v2 04/24] ARM: dts: imx7-colibri: add usb dual-role switching using extcon
Date:   Mon, 16 May 2022 15:47:14 +0200
Message-Id: <20220516134734.493065-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZIvTcuCtSM5HSzwuVxCC2PUV43++zzjqATon98hwIfegN9JAj5u
 hUq7mlURCpsPXeFo1z+mictulBbxvgAV4sThOo9MjrUFgQeTdxsIJXH4HU7m9iOUUrLF3iV
 hgm9pW1bUXeL/GbsqP5FnEblzSFK9Z5V4wvq3hLTMcAwSwe8k5fMmaaWSBUyH+Ne+Yp3bAZ
 xhYYytZzSREs1U3Nna50w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7gprov4bjz0=:7syDZPKY2GnRYE1Bf/Vgfz
 3xw3sqjFon0irniMHDB56sDmNmtkvVFU+y+FGbA0J37yUmsxqZ3QOg+ZbAtmDYm6iEptBgmMO
 qPLYWk+u8dGTleDp2AGmMf4UCstkD5lht5CHvSTo5j5JgkbbjMTEFQj3NOTTcjEKvJHUmh0Rj
 EaNQDrxzJvrZhHto65OauSbRNLgBiT1qWUw630V37jY8u7S16qH/PMebL+LGFbLqub8dIuXTL
 F0heOJS642eHzNHwapNMkxmcAU9L2t8qx/wGNumpvAXLRhnyviomsPjzR/QAslOIWZyqLKQa3
 Xqvs7ol4+a7zUYQpaWkPyHl7rdEqjvYBSeBfN/ReJJL9Ia6N7JWWBKFNAdyj6p7krr251/ccK
 3utDmqQSKPaQ4/nDuFk8jMR1I4D0GB1K7aBnSsyBzlTePWS80WV1IZ4CHlRx0tHUPHdjFbTCg
 Zm9TDwAPbouhbamvvrVwpFp6p8hNw7HkauoHMobdPcRsfpjbnBXUyHAgW648JteU1ng6waR5k
 n7R/TEVMQe7HRgydQN8zwlo0T33gQzRYgirXY5iw0SP4s39eZqWZMdE5pgZHFgjXLX00aP6uS
 EdpmpHsHkhD43JlGhvXrUNwiHffSehNdM5XNNA6sUOT7+HotijeRDjbu3PDp8w7rmc1GxA6SJ
 a7xey/allrgzBmGaWQTfjR9vcHJ7PWEQuihamRnOjK9Un+1i04M9bof7z7M20OLQgrDA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add USB dual-role switching using extcon.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 8 ++++++++
 arch/arm/boot/dts/imx7-colibri.dtsi         | 5 ++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index d6fa74222960..17ad9065646d 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -20,6 +20,13 @@ clk16m: clk16m {
 		clock-frequency = <16000000>;
 	};
 
+	extcon_usbc_det: usbc-det {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_det>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -141,6 +148,7 @@ &uart3 {
 };
 
 &usbotg1 {
+	extcon = <0>, <&extcon_usbc_det>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 3c1cfd766645..6df82a67953a 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -512,7 +512,7 @@ &uart3 {
 };
 
 &usbotg1 {
-	dr_mode = "host";
+	dr_mode = "otg";
 };
 
 &usdhc1 {
@@ -540,8 +540,7 @@ &usdhc3 {
 
 &iomuxc {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4
-		     &pinctrl_usbc_det>;
+	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4>;
 
 	/*
 	 * Atmel MXT touchsceen + Capacitive Touch Adapter
-- 
2.35.1

