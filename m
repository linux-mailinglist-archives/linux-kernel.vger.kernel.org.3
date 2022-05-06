Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C657551D90C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiEFN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392566AbiEFN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:54 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B96972C;
        Fri,  6 May 2022 06:25:07 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LcAWh-1oC5x53kGb-00jdYs;
 Fri, 06 May 2022 15:24:55 +0200
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
Subject: [PATCH v3 10/13] ARM: dts: imx6ull-colibri: fix nand bch geometry
Date:   Fri,  6 May 2022 15:24:13 +0200
Message-Id: <20220506132416.273965-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rpEKWpAhE2cfXREOK6cvHNFrxxALhy80kDx1PldgifDBF+yMz30
 oL9Hce1oRR1Lvv3PvegLJfUbXLNT+H//w+zSSkcc9RxbrixEI4faCuerIPegk9oCRVe4353
 XjCBw76lZfuEbWZfOc7EUJFBZUBQAdxuXeDBY7NCuq83icDG66pahk4vaerijuWSUS2Ylau
 dMP8f/P+oFRB5q+6UZb4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r6cmugd0f9U=:TaD6Hr6K9LRILd8i6RKPaq
 5Sda9gacaZ8BAX7LeX5RcJV0TnwnJNPu3cyfH/WNbxlAnXwiY28lqiCQ475CJ7+yo1R8YyU0K
 tNwCh98eJYeKZv0QoaLYVf+DHhdB4hImYSir8WlbD/82+dKrb8e8EoW87YrcW0w+Vbh91oH4w
 YgdclZEE4JDRTJYqRohTlsuBygtB4yPpVTq/bYT/GKVzx86iaerAH/oR1pjprZkmtPHxf823/
 YYBbZuDtOwkXJG03H6lUmfDyht/kLFR4TfoDFJD2lG4FnbklFsDIaKUjATe2AXMMW4y1HdqmE
 fVIi2qC6tDnUpJbqm1k4TiobE6gm2tYG6wBmrLK6b0TUko/O/rKsC7hkf4zo0995DHnpoapDt
 jNxXOeW9gFhNIv5OMgXoRkHiUvSQwwx5WhbeXC0gVgPG41sVO73PGoyWrSeyMXK/THlvTB7dl
 T/OFeza4gRxSDIFqBLr4e0EU+gqei28VP5SSkfWhLmXPIB28WA+5BOrJVS+WVGb73iZnOwKwg
 IX+adG5n6FSgZslzrFLlGiqGSMiyfVAD34vsqKW/omPhpTSO9fOBoDNV/gmbIh7PcF0dYk8ou
 9B0/wQfIXe5Pt03gKntpzVtZZXoDBU+MO/NxU3ca9NnypFnH+WTw+S8zPAoVDpvhv6A3jRtbm
 ZvMQlXv7rrL9eh8Nb74ts04dMDdAQyZ1jpSeJ0HuW7LIddPjRZH1kEtneO8WdwBKrDch/w4ip
 4yx9FdietL/t2VWZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix NAND BCH geometry relevant mainly for U-Boot.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index e74dd98fa66a..5e0cee146121 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -128,6 +128,7 @@ ethphy1: ethernet-phy@2 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	fsl,use-minimum-ecc;
 	nand-on-flash-bbt;
 	nand-ecc-mode = "hw";
 	nand-ecc-strength = <8>;
-- 
2.35.1

