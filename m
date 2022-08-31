Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C05A786A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiHaIDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiHaIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:03:39 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C830AB99FA;
        Wed, 31 Aug 2022 01:03:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CAF5EDF5D1;
        Wed, 31 Aug 2022 01:03:33 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eHVmjyzaFMHl; Wed, 31 Aug 2022 01:03:33 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1661933013; bh=7qHCaOfhLwiXbXUxRw2B/DGm0lbeC8SuRRq3JSV3d7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMWhbEiZzi7b6oOqzzFXS7btCUFRKtoEJoJZNhU0briwOSdg/jmeuWPwgl4G3+RzU
         z5FhcC122drJ1Ym5hMvnR0hV5QU4Z31AFJNcG9QWmFlwelcGHRS0h/jfUJ877Px+DN
         fhpiayvTxieHo/9WqgVPknAwFWY8ft0GHAXTWcB11iyBoOBRYt6shzwjXQM6JYBq4o
         nEAwK4jMmbkKvGT4pOI+WQUBTd5ix9yPopjwi8EcvbkZH95m0Dufe2r8dYJ8h98jA/
         HYL0Xv1eu54Ri0vVR+o/98hPbSJeRTP8DPxSsD7NNcQ37Sg/pGJX/RzGaVjz807SSM
         TQxQKV6pbWLjQ==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v1 2/5] arm64: dts: imx8mq-librem5: add RGB pwmleds
Date:   Wed, 31 Aug 2022 10:02:58 +0200
Message-Id: <20220831080301.1092737-3-martin.kepplinger@puri.sm>
In-Reply-To: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
References: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
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
index 0626e4194d958..bbf49e419b498 100644
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
 
+	pwmleds {
+		compatible = "pwm-leds";
+
+		blue {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_BLUE>;
+			max-brightness = <248>;
+			pwms = <&pwm2 0 50000 0>;
+		};
+
+		green {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			max-brightness = <248>;
+			pwms = <&pwm4 0 50000 0>;
+		};
+
+		red {
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

