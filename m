Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE715916C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiHLVjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiHLVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:39:42 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A89FAB8;
        Fri, 12 Aug 2022 14:39:41 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LgJSE-1nZ2UJ3rWu-00ni2g;
 Fri, 12 Aug 2022 23:39:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: freescale: verdin-imx8mm: fix atmel_mxt_ts reset polarity
Date:   Fri, 12 Aug 2022 23:39:04 +0200
Message-Id: <20220812213905.216065-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220812213905.216065-1-marcel@ziswiler.com>
References: <20220812213905.216065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QrXho2BgfaJQ0+SiBPLn4R/M3L+q35xAaEyc833BOiWNCISPkE2
 Z+hn/3N9NXmghfLkfqpW8LZQTJodEhJ7Tgge/8ipbgjewrqOPhacRlEjtU73QI3LJ+/WnNH
 IvMoglBVy/IOUVKX6iFq13jUJ1q/wyncgUjvrDKxplk1/I677G5hVJa5WbhQBSrg9Ixs7h2
 3nUE4fZ+VGFeZdX+Vzwxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SpFNcjKJGNs=:4kSWIn0eocH08Lde98LPr4
 iHWAP5w7e2c4RXN+bbX/YJls+aiDprS20My2DcdNJrnwKMlTWDmrqr1OKusId2gQFvtw708sb
 2Ft8jIDvk2zr5LKVnDR9yytg8xP51Rg6WTV7SvM+BcaAFuoDqoll1C1FMzbLbzLAfVoX9aLqG
 9Xl+XZ+dyqQH897aF8mjHqBzQPvu1XMWuHj0zvIikImmxk+gtC/LaQ89p2qv8xUxm4r6y9wjW
 X02/cnx/8nNvVdSJXMzs0t9mzSBkhB/esuMZ4BaGfpJNki76DLnWtnTdwMNZnmMndNMZpo2xV
 oZu85x8vWg8B1rzaxt8Ra66EZdCgzAPDA9+hqboyVTTvMLVxpQBJYD0eYsPfvGgI4o2o8wlxC
 3JGdFubwA9ZgfYvK2TF/1PMWgidrjAFG3PSrvWPpQTW0rvJw9JmrsSNV88L5Yca3YPse9pFev
 uic1rDCQW6WFWAzsBRGMSiAMU+1qNNkI1lbJQz5j6TzFCDMwyILUEEvmpTWB1x8Pl+KcRWLZK
 GSre1k5OZztKrJRlFGna8d/DQw3kDVb0cKl5AGd8eeTO5z3UZRgjdVYQYlyisD8rqOZxiOONF
 z398rMze+4kgyEvS10P4D3z7MyX2o9PqAeIu5g4+Mr6H/+BhF1ifUyv7dxByhwozKkxaM96ED
 3ShOxGnPiiPEpdDlZQNNy8CujgEBKoErYtaetjNnc2HZfmosGTS1ye0v3op6e3xegltg48sj3
 MryNYOEDCOkDAQUK5zCsZK2YtJO575oERVjCfF69+RDchV3PVmkZ4HEYax4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix reset GPIO polarity in-line with the following commit feedaacdadfc
("Input: atmel_mxt_ts - fix up inverted RESET handler").

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index d1b4582f44c4..9b8417a53487 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -603,7 +603,7 @@ atmel_mxt_ts: touch@4a {
 		pinctrl-0 = <&pinctrl_gpio_9_dsi>, <&pinctrl_i2s_2_bclk_touch_reset>;
 		reg = <0x4a>;
 		/* Verdin I2S_2_BCLK (TOUCH_RESET#, SODIMM 42) */
-		reset-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 		status = "disabled";
 	};
 
-- 
2.36.1

