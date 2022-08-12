Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2733D5916C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiHLVjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiHLVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:39:41 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFF9FAB4;
        Fri, 12 Aug 2022 14:39:40 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lg24j-1nc3Qa0vil-00pda5;
 Fri, 12 Aug 2022 23:39:19 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: freescale: verdin-imx8mp: fix atmel_mxt_ts reset polarity
Date:   Fri, 12 Aug 2022 23:39:05 +0200
Message-Id: <20220812213905.216065-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220812213905.216065-1-marcel@ziswiler.com>
References: <20220812213905.216065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S17GK/XSAzYGodzyvabz4JvWX5PFty20mLQHnNRLhhhX3R/50kM
 kx5z78l5QyxQe05X8UziHJvzkfjj7yFjpPdT0bTnkH+mRSxSkql99sjjusfvOKaqokr594k
 /uzh8UkqhAYdfbUqIA1AdqVy9B81kxT15EtQnt5DszdVlRjmyD96kp0KyfMCt8ZXYzqze7a
 H5rgJ98JIKtkU1QHfsy8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3tfj6Zh64s=:D/v5w1R7ecM6UlodKj8xI2
 LNrCZhTkpwezc+Tkf3cY9jE4Ak5nysJCRy1wTVZjxQHP0CrtgsGXiT6VpXCPNt4PqaKnYUt8E
 3A0pURDKoX5ZWS1GkJd0jIETn/faLXAA+t+sBwFsnt4HB+ca6VseCjQsKSIzgvjRQKeQsfxAO
 wWxOif/M833EZDEFHOjou8NWdAdYhw4dBov4T0IbUdXyLfRLkSUvPsQl9Nyp0/YAxAagK05X3
 nrkTuPvaSMFfocrgvPZjle3MAipPpiBTeNiho0steKqHz/pQ18NeIAPRVymxIfE5btXRIwm+T
 COcean+6gR3/vKbDchJa8MZS75weKSAwOc2+FxsDwjt57WHx9JProcIUBJX/LRM1pthzWR/6y
 GD3f2gJ6PrNh4OnHPexRJV50lKe9mxzx6f0zrRAh4kBXgZIPq9eZqqQgH+/VQeB77bvvlMuCJ
 Upb2Ge1AiBTm/XycTWH0OEc+/5VPoe/hKPPK5KOGdxPLQsWR2pqK1J3LrPigriVFTxaM84PaG
 3+EsSewsRen0QrQpb3PAmz+9fmZ+tJsSdyN4ZmDBvYPr/Gan6W3ghRBH0sckrfaKZ8h8JPzE1
 axD1gOmr7kYj4Pg+puhwhCfplq9+PUtadrpzWobMznvNC/Myq4g95XYZn5JBpIzqJ/NZ5kcaX
 OrdXCbZ0aM9PR+nSS1X4sE8r34qrzWn9qWuFMRFPGiwGWfFWiDb96Fs5vtbUDFYj7ZoifvrZw
 Cptn2iZlRbBRV69VXnkOqvEuke6IriGr8fk5AHZgTNaEPzWZQD7cE6YmxIs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix reset GPIO polarity in-line with the following commit feedaacdadfc
("Input: atmel_mxt_ts - fix up inverted RESET handler").

Fixes: a39ed23bdf6e ("arm64: dts: freescale: add initial support for verdin imx8m plus")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index c5987bdbb383..1c74c6a19449 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -628,7 +628,7 @@ atmel_mxt_ts_mezzanine: touch-mezzanine@4a {
 		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 		reg = <0x4a>;
 		/* Verdin GPIO_2 (SODIMM 208) */
-		reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
 		status = "disabled";
 	};
 };
@@ -705,7 +705,7 @@ atmel_mxt_ts: touch@4a {
 		pinctrl-0 = <&pinctrl_gpio_9_dsi>, <&pinctrl_i2s_2_bclk_touch_reset>;
 		reg = <0x4a>;
 		/* Verdin I2S_2_BCLK (TOUCH_RESET#, SODIMM 42) */
-		reset-gpios = <&gpio5 0 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 		status = "disabled";
 	};
 
-- 
2.36.1

