Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639B51DC27
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354839AbiEFPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442971AbiEFPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:33:26 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714D76D398;
        Fri,  6 May 2022 08:29:28 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MdMsu-1oMKdw1p32-00ZMUS;
 Fri, 06 May 2022 17:29:16 +0200
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
Date:   Fri,  6 May 2022 17:28:04 +0200
Message-Id: <20220506152809.295409-20-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eDSqjHvYUgUDpPDz2ip0xhz8v56Xm8HmZNsFQ6smeZO9h+EgnB6
 R43ZdDrLnBRKoDgIs2DPwkhHWQBZrKY5mLXoNOC5Ib1QT6N8ZtQDa0b9QCbZ7CaBTIo/0Nv
 yrq81wxJLAEFW15pc0EbDgRmdXn7mnoSi+TX/usDtD14N857nHdt+eXwEqaxaks2I+plTyt
 p4tHz/PsGIsZjsoGaATlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wXRkrhduIOE=:LuNedX6YpLBvr9MPAV31a5
 1pJYTM6xS5iHRslRfQJOjWkcGHI7rPPZMUY0wo+Jerlcg5sfX5+aE6IItUk2bxOlDoDYhKT4i
 x+VyxF8Q20aIVTNdpNCc5SeVm/o8PUpWSwM+AYSdxn1SwiD8L/vYIz4W4QuWob3/LzcU2tgjb
 ky+GA5vsbd7LPniOlmlbgUN84wHLccJKdjq/oHgN/WYcel1XXb9aT63sTsvf4aFJmo9jymC91
 aywIRDPTeZXA0VkxbW7HLiWDSb0lqNgk6qaDg/NddndjmVrhvVlhda/+LXSkmDFVIXz2EgzoK
 V/8acMx0xsnSAh1BKfV9MLWyGCDuXeKsM6tPRfjFsrR0b/PElHALDN5IFhbVSlVjLcKIEucJG
 Dnu3l5TJbzvsUi7c+LnX/PSR/RA1lt5pPfrJqru5qz11QdskiaLiH/w8mPDn2/Tsc9WxSQcFM
 0JGxdza62o6We+UfaMbLlHKzext7Hs7NBKT4Z7SYvWCLBeT+IHNi/29BXNIaI10gd5Wz/r0+3
 ZbdaWsLDVV7+TDHwnFjtl/jKaZL9OUK3eGEOJCrqX74CglqRSkUZuk1EJiCESg3Zv0M0K04vZ
 /Gyq3hakWbtV6I5RgWN+YuGMpcQjF0DMxkjK5/dJ8u8CWLnWWnWfnZre5+EWPsRLoNhVtj1iv
 LooMgsuiLb4KhFlfLXb6FW/cU/Dbg83iO4MlWKliriU8V40dfMLzI0oocthSDW0aeATI=
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

