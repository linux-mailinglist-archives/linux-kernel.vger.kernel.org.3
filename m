Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91F84FD602
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390395AbiDLJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353684AbiDLIKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:10:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D08E59
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:40:17 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1neB8A-0007gF-Lm; Tue, 12 Apr 2022 09:40:06 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1neB89-00AQZT-Bk; Tue, 12 Apr 2022 09:40:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v1 06/17] arm: dts: imx6qdl-vicut1.dtsi: Fix debug LED gpio pins
Date:   Tue, 12 Apr 2022 09:39:53 +0200
Message-Id: <20220412074004.2485264-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412074004.2485264-1-o.rempel@pengutronix.de>
References: <20220412074004.2485264-1-o.rempel@pengutronix.de>
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

While there are LEDs connected on some variants on GPIO4 pins 16 and 17,
those are not the debug LEDs that should be visible to user-space.
It should be the same as in imx6dl-victgo.dtsi.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index b7a705b39178..a5f962f1028b 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -92,14 +92,14 @@ leds {
 		led-0 {
 			label = "debug0";
 			function = LED_FUNCTION_HEARTBEAT;
-			gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		led-1 {
 			label = "debug1";
 			function = LED_FUNCTION_DISK;
-			gpios = <&gpio4 17 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "disk-activity";
 		};
 
-- 
2.30.2

