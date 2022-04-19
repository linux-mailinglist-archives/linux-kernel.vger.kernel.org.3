Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCE506385
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348351AbiDSEwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348364AbiDSEvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396402FFC1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:50 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmt-0002uU-Fc; Tue, 19 Apr 2022 06:48:27 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmr-0047QW-IV; Tue, 19 Apr 2022 06:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 05/17] ARM: dts: imx6qdl-vicut1.dtsi: Fix LED names
Date:   Tue, 19 Apr 2022 06:48:12 +0200
Message-Id: <20220419044824.981747-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419044824.981747-1-o.rempel@pengutronix.de>
References: <20220419044824.981747-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

The names should be consistent with the names in imx6dl-victgo.dts

This patch is preparation to unify vicut1 and victgo DTs.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index ea474aa93485..b7a705b39178 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -90,21 +90,21 @@ leds {
 		pinctrl-0 = <&pinctrl_leds>;
 
 		led-0 {
-			label = "LED_DI0_DEBUG_0";
+			label = "debug0";
 			function = LED_FUNCTION_HEARTBEAT;
 			gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		led-1 {
-			label = "LED_DI0_DEBUG_1";
+			label = "debug1";
 			function = LED_FUNCTION_DISK;
 			gpios = <&gpio4 17 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "disk-activity";
 		};
 
 		led-2 {
-			label = "POWER_LED";
+			label = "power_led";
 			function = LED_FUNCTION_POWER;
 			gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
-- 
2.30.2

