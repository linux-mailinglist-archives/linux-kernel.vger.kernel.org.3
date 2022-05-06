Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBF851DC84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351187AbiEFPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443144AbiEFPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:50:58 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6EC6D869;
        Fri,  6 May 2022 08:47:14 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MulRf-1o4wUg07NL-00rrBI;
 Fri, 06 May 2022 17:47:01 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v1 19/24] ARM: dts: imx7-colibri: clean-up device enabling/disabling
Date:   Fri,  6 May 2022 17:46:43 +0200
Message-Id: <20220506154643.297078-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZalQCdbDt6il2RNQAglTtkGkXNwrkD/G8sAe4D+gev6ffBr0JrT
 TaOkmK/ZfIEnl5hDlNrO+Bg6bKGr3CRgkJFS7BfGECFJk0xHOpcTKhVcQuhXihbXL+DydqF
 zkylbfFKpsc4LEN+/vZ0wdeK5LHyPQNDpiWAkBJMJwrbAjGmsmkH2DWzHSZKhviNOlv1eOq
 6si89bIBR+lVzw1czepDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IG8Pk1MUVD0=:mu7e9d1ol3kW0ZvNzQo+L3
 hybNhWHpNHKum7FT82zoIHdNcVuQK7iDwP5IHqnAdW64PfwolI4ytHtQgC49gekyWHyxD11cB
 aCrFicYW8jKIAIyRf3Kx/IvFtSilCtnkU2YdBBuWBvkHE1QOLIg46uEXOoOgXUM1ywnRxma9A
 g1b3G4vpH9IeU7kH/71b1i5/05V9BPtIAuBZil9SoJwbBXwylIGN8lwacKYTbpgJNMwlomhYp
 Vlfe9cbIK6iwIsdk2oQJ1WRYJ916NkDTJO7aHdicmciC11uO1JsH+yyfNeL+l8jD5m65H+NPF
 Lj/K6EJYkCL6heU1eCbnokqBzkRfQziu/xhGVyJOTP+iz8wAixcQk8GjHzfi5C+WYDMLnMH0A
 G9rNroJpk+RmmdKwzzfOp1KSgOiU2SiJ6lInO+m54mqw1C+7+DeC3nve7yqcaORNpDKwBcPNl
 Iurza3U1xj2rcyNChDGvL5r4n5A9INxy6U8BGeF3ZQtqz+Pk30rgr/ntYvC3od3A4yOkP7Ct0
 FSufrb/UCbBkOW9LCD5IjjSw3xxZBzdGMBABAC+MxAfxecNWfmXNb2vjmM26XreI6HFNNcVUM
 nZ0iGUfvX2Tnlm3+CfLdGQ3Lw+eYG7G2mctthIVMg6gQ62FIBjqKtfpVqrFdzpDx0u/EA4MgP
 26ytQZSMGVviTD3ZoYomUmIrfQyWkSIppVq8oBzAatPSeEhH/iYiOWi7qLhxNAfs3bfmNKlqr
 dBKxpyBrxDJ9Ypw9QX7MTvFmCuLuAPdPOPm0B1QnUf6giybYacl1pm0CBVjp8IxBeSxbmWxFY
 ztAFw5fr3uGBQmdDV2bXyWcG0ReIQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Disable most nodes on module-level to be enabled on carrier board-level.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 1 -
 arch/arm/boot/dts/imx7-colibri.dtsi         | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index fea6e4c0d4d6..826f13da5b81 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -44,7 +44,6 @@ mcp2515: can@0 {
 		spi-max-frequency = <10000000>;
 		vdd-supply = <&reg_3v3>;
 		xceiver-supply = <&reg_5v0>;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index f29096fca54d..065d8f55f326 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -140,9 +140,6 @@ &adc1 {
 };
 
 /* ADC2 is not available as it conflicts with AD7879 resistive touchscreen. */
-&adc2 {
-	status = "disabled";
-};
 
 &cpu0 {
 	cpu-supply = <&reg_DCDC2>;
@@ -191,13 +188,11 @@ ethphy0: ethernet-phy@0 {
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "disabled";
 };
 
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	status = "disabled";
 };
 
 &gpio1 {
-- 
2.35.1

