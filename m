Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F14A5AAA5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiIBIn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbiIBInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:43:05 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0E89E6A7;
        Fri,  2 Sep 2022 01:43:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9E10ADFE2A;
        Fri,  2 Sep 2022 01:42:33 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2FZVnIlIZDDt; Fri,  2 Sep 2022 01:42:32 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1662108152; bh=XTCJOy1lkwWbbFV/ClvUNuSaI8YS0YPYuLCf+fQ4u70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjczDtnuMPfxFD7pvzPTt7m8+EKF5pj6HYfvpQelgRVe1FLyvQpo+tgvicr1dxw57
         yFaEQ359kfmHUTUy715IrOjF+Dt8iKjK1sURwit6U2ZhRo1QA7N0HUaXHO5scJXpCh
         tZooioEePYHowXMHO3mKbtipSWwvntblMRSxzkJJSJim11OrgTc1HlVanzBD1M5J2p
         QRtCf0HiKm9NSS/+S6vpbsOxjNS08Mg8FBq3U2tbpdJMTz21oVQnU9kiZ00q/53MGu
         RLmreh17fuVbsSuuYt59e23MQfRwHLb8081NI6V1Vho0WwfdL7O/4yqbG/UlskARJ0
         pEUaadBDQGq5w==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v2 2/6] arm64: dts: imx8mq-librem5: add RGB pwm notification leds
Date:   Fri,  2 Sep 2022 10:42:12 +0200
Message-Id: <20220902084216.1259202-3-martin.kepplinger@puri.sm>
In-Reply-To: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
References: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

Describe the RGB notification leds on the Librem 5 phone.
Use the common defines so we're sure to adhere to the common patterns,
use predefined led colors and functions so we're being warned in case
of deprecations.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 0626e4194d958..8da7b87c1aa1f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -7,6 +7,7 @@
 
 #include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 #include "dt-bindings/pwm/pwm.h"
 #include "dt-bindings/usb/pd.h"
 #include "imx8mq.dtsi"
@@ -54,6 +55,31 @@ key-vol-up {
 		};
 	};
 
+	led-controller {
+		compatible = "pwm-leds";
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_BLUE>;
+			max-brightness = <248>;
+			pwms = <&pwm2 0 50000 0>;
+		};
+
+		led-1 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			max-brightness = <248>;
+			pwms = <&pwm4 0 50000 0>;
+		};
+
+		led-2 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			max-brightness = <248>;
+			pwms = <&pwm3 0 50000 0>;
+		};
+	};
+
 	reg_aud_1v8: regulator-audio-1v8 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.30.2

