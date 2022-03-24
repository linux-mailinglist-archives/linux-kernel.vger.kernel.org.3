Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73C34E667B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346626AbiCXP7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351470AbiCXP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:58:57 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF8FAD134;
        Thu, 24 Mar 2022 08:57:23 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MgOMF-1nzaiC36ND-00hs4j;
 Thu, 24 Mar 2022 16:57:08 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v1 03/10] arm64: dts: imx8mm-verdin: alphabetically re-order nodes
Date:   Thu, 24 Mar 2022 16:56:42 +0100
Message-Id: <20220324155649.285924-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TdzkpasYGlzKJaYNlxNS/8qH3TE2zqmHiuo8Av1ViL9IZNgShTh
 OVG+aTHuaZkZmpCkjfl6bCys/sGa+IFgwIhO6cKIbQiWt9HTmz239JWOC+habTDY8r4yixY
 FhO1BHzcpzudRtvNp0yPai9NANLtZS/Yy5uopz2DPO25UcrZnJ4xTt2hNf6vJFyGyVEwgL+
 F3Pu24NqnNpYs/7jpJziw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JczHvuUaNUU=:gYBVOb/EhAiJvt5YzLS/Vg
 aF8GmzRf17e/6PYUSNUGUUxVaSOQiEF3ytpSIEerg5SUzLYOIgcQKe6EJ9xHS3L02FSdW659T
 msGaRLhLGmB8MTPOvoTY9a4rTWPcr0ZXPIc/zVi4Wnz7ZmlDgXhEx0Pt9FVr1WrX7JSWKrBbB
 MYuptt0oiDio4cqyqk+xWc2E57G4l8qCuRDulintUBVNt49Yf67GPHufgY8k3/vkr+nf89Od0
 MqoOdVsIMtqmKS6F5svatZ3J3E20t6iQLNxVu1i62LAw+k7jLaoLJ/DaKFvTUqJnY0mFjiNfz
 hRHF76MgSjcWtv/nObP3CrFLzAzN8sJ7HtKkT1U0BO6DEmbWTdUI2cQ2tbVOvXwICivmT+BGg
 uMI3jPToiHcXK97PBN1Y0kaN4zWf5F9uQebdmt4PigGAmudT6b5tfi9x06/ZHea6lHVtqrVzT
 uYLSwfyv+kYp9URDlQS8B3hy1bovzWRVStssT2+5CNP1zeQg4c+Jc4tZAgw3WmzuBgfifAKXr
 7i9+QJQ/0LIrBNgf41ifZ92NIKCznvjK8W82IyV23UZFJN5n5duaQolper9Da578oJPeti9yP
 fGFOMv9QP7xMn1S0BYcvke0oJFO0l1WoiBPOQwcf8Z6DzlPKxsTyKhIq8XhEKdzQRDppfZCqO
 8AOOsez6DTRHtftocm+KNuUNCuc8xeGKgAB+kyeDPnyyQfHzjEXxIGUNiz2NOft93XF0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Alphabetically re-order nodes.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../dts/freescale/imx8mm-verdin-wifi.dtsi     | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi
index 3e06a6ce3406..017db9eab256 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi.dtsi
@@ -17,19 +17,6 @@ reg_wifi_en: regulator-wifi-en {
 	};
 };
 
-/* On-module Wi-Fi */
-&usdhc3 {
-	bus-width = <4>;
-	keep-power-in-suspend;
-	non-removable;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_wifi_ctrl>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_wifi_ctrl>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_wifi_ctrl>;
-	vmmc-supply = <&reg_wifi_en>;
-	status = "okay";
-};
-
 &gpio3 {
 	gpio-line-names = "SODIMM_52",
 			  "SODIMM_54",
@@ -92,3 +79,16 @@ &gpio4 {
 			  "SODIMM_135",
 			  "SODIMM_129";
 };
+
+/* On-module Wi-Fi */
+&usdhc3 {
+	bus-width = <4>;
+	keep-power-in-suspend;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_wifi_ctrl>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_wifi_ctrl>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_wifi_ctrl>;
+	vmmc-supply = <&reg_wifi_en>;
+	status = "okay";
+};
-- 
2.34.1

