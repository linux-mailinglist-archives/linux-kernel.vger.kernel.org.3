Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E4F5A93CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiIAKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiIAKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:02:22 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5541E70E77;
        Thu,  1 Sep 2022 03:02:21 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LlDCS-1p4PDa45yA-00b4Cg;
 Thu, 01 Sep 2022 12:02:01 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] arm64: dts: verdin-imx8mm: rename sn65dsi83 to sn65dsi84
Date:   Thu,  1 Sep 2022 12:01:48 +0200
Message-Id: <20220901100151.1378709-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901100151.1378709-1-marcel@ziswiler.com>
References: <20220901100151.1378709-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Efele8LPcZTE0dwVCkMdmkn4AWpPfvzwaKFuuTV1/uPix4+cMkB
 bKemEJ3yeHnxuO0FTUTZG8uf3+HvsoSztMKxsuykU0Ujtt68vfBu3S7ic4alHJMeBmB2A8F
 8oMHx7/WbELi453Gp/+bf9WxTelVOBQljANPn+vJG8NOCDwDW7A7ehef7ek+bN+NyZ5fGJ0
 tPS1ikkEb6MP6lT5LV78Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3B84zA5vQQU=:RYp6p3vSvIsIuogdlJ7oQu
 JwhMqrGWBqwKYAKN0d2SCJpJtoPqXy2cqB6rBpKw8tRch4Mra3FP0yF4+ImdimaJWOyeYe7Fn
 dNQWctiWvzXrF0VscEWvi38T/eyFJxyizsJSqdUMvu3B/BrGkxu0FiwJ+bJn773vuZU1e5hKv
 v7czPMZDIajYf//ejDMEnnMfYkhiOIHwgVReDJbXlxWXDutbmrnz+lIdbavZJ0NYPY4U+TnXQ
 EZmnDdDJLnkbA6tY7up1qvCWM2VPjtTjQ0KyMq7hH3RpjEQOuQ3SWPZ/cmi1LwGEbp+UHQDMQ
 sVYjyxxc6WDWCYhz/Cj/tF9/MkqgWMWyImr6WlzfjhDMWEQlBvbF9Iyze1+2HUUmTyWTRS7hm
 gazoy/NS+Yo3i6h9uPF/VVNWUcD+DFBOcusXi4uwyjyhS3mDKJisqy8lTMwbA6XjLtRl0wtLT
 jl7da/2D4K928dWgMc4gQoecT38aYJV3FoxNKn3EbXDoSlh4sUysSEDM0hTbLYDrtZWsbmaCx
 nqbTo1W8XyvK0/xX99es8pYKK3Ir1t1iRnBAdYinT6TxzWr1WIHLqvG62keDnuepu5FrYzP1V
 qoli4B9x3O0v+pQ7XB/c2LoXS5KtoywBzcNiAQHtmssMp0roRVho4GsU/poxJUslWCQZ79pD7
 Rf3Qn1tJzvpAiMVreF0QDSMbTvGygbdtZ+mXKFNMIsGNrN+4Y1xXs3B9DeuZSsoUEhWWFajvz
 GoDLOgbOUWSk2tYC6WZ+dmqkV6m+CSJqa9PF49SjMgDke8XL3b+VGNoFBhN7P89lBob4JA12/
 bvAHBCG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename sn65dsi83 to sn65dsi84 as that is the exact chip used on the
Verdin DSI to LVDS Adapter.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index d1b4582f44c4..f5a2dade24a1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -561,8 +561,8 @@ gpio_expander_21: gpio-expander@21 {
 		status = "disabled";
 	};
 
-	lvds_ti_sn65dsi83: bridge@2c {
-		compatible = "ti,sn65dsi83";
+	lvds_ti_sn65dsi84: bridge@2c {
+		compatible = "ti,sn65dsi84";
 		/* Verdin GPIO_9_DSI (SN65DSI84 IRQ, SODIMM 17, unused) */
 		/* Verdin GPIO_10_DSI (SODIMM 21) */
 		enable-gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
-- 
2.36.1

