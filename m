Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189C651DC01
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442885AbiEFPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442848AbiEFPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:38 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80816D1BE;
        Fri,  6 May 2022 08:28:49 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mg7F4-1oJY9T0fra-00hala;
 Fri, 06 May 2022 17:28:37 +0200
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
Subject: [PATCH v1 04/24] ARM: dts: imx7-colibri: add usb dual-role switching using extcon
Date:   Fri,  6 May 2022 17:27:49 +0200
Message-Id: <20220506152809.295409-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ouHQzRwJkADa37gIZTedAOIRP/KOUmtL6FIHFiTLITHSiruKzHp
 gCTBHW6Pr/1DeGWUi34pNgsgTXUcWF1p/zB3wFU3eHAtel3UAOJjxoLizzUqHvmLjVvoexG
 Qzvc4Y8NWIjDhiMhzy8eQXenTxe8QPTsHHLuViFaZSWmXENEf5K4d4b4YmIu6HErY1dBnQ1
 z9i6ZnUts1fsMd4U6WiPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VaMEYnA2Ji4=:ZFdPvu0XcwNrcqcThr2p70
 hRGJyLLRlxErPTzJW9Yl1mUHJR0J/Sx0nqslU0WxOa06y171U0j+XmS/4cg23K69SkArSFvGd
 vsO7d4uccf5/PdVcd8L3z6bQFzLyoXgNbj68o8dLKVVayS/B/PIklxjhZaZ/7Pxi6ZQkCP62U
 aBTPRVBrH2UojfRGWPrWxThvXaYCY+R2k1IkYByjXAoB6a2Qc1ZS05Ayt9iApoFf3TKA//dkY
 9jIqtmmzgWAxGT+9heZ+ak2iXqbrsNCE9PI0K9QAlfL8W1+x9LM5Bo0y4sqe1xD59Rz3HSSDQ
 WG1nZZ736WabhYOpfXZjmVb9YzsQp+AQE9eAaM7wwERDQdbCcSR9hTMTIgRFCJ2qkFuDVoM3u
 oF9orFTS+azEx+VeiC+U7rV3+l+LrFca+PU5SkkZbkpadH9zWljJ7jQsASl8y/bPoQ0KDiipj
 MAkgA4aeY4+FnDPHAInxJUwufcAJlKqx2WnaokODaJUkq1HpY5i70Wh4FqbTpUueWlUOXUJ4E
 ZP7w6uSjjE4ecEFBEDnHDDzpGCLTQRamt7SBqK344/dRpj4udk54JsN2QfcuOb6dKSZrlLh42
 gvbs++Q54Ux1PVwOFNmq10rRxlPSO2JVtmknQhuaEG0Hp2C9+hRgiSSfhlaqoRulOeDAVx84N
 WOneyYtog1WqKaU7tR/mhGAB43/tFpVI4zAg6wmZ8QNRzhfMelsubCGD7i8DnSHmQzyI=
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

