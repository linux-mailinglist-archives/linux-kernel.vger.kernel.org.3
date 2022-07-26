Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF358132D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiGZMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiGZMca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:32:30 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670EF27151
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=Ev4N4q24UwXqRA9IZ9T6SOhwkJ7AA8kM5UgVGYCXGXQ=;
        b=d0RrxLX+5rSzrN9QmweysEEObWTyM0ljDKDvGLjfnUjYArMeEzrmxGPwpiq0GviBB3vnrb0Cr2eVk
         z9DhOhVZ7fcoMQVuu9JkjTETo1xG6n+zyJiutgYuTqMdR7Ifq9325ixMBFb3omrWHUbGnApQcVk5DY
         7W/zYUeJ1lajGxomtrizHpjXYj98nlLGaJSd5Dh2Xiko7ilqetl3uLy00qOMQGNh2BNDrW/V/2SNeM
         qf7rXqh+BtCxiEbrZSLaDphY/4RaXYevWJzBG1TZyOIYkRsRlI2Z1LCf123F+5q0BH+NhIIujga/O+
         C2IanePDUou8CBwYJSTxNbr49CXC6yA==
X-MSG-ID: 00f680fd-0cdf-11ed-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH v2 2/2] arm: dts: imx6qdl-vicut1.dtsi: Fix node name backlight_led
Date:   Tue, 26 Jul 2022 14:32:22 +0200
Message-Id: <20220726123222.1074876-3-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220726123222.1074876-1-david@protonic.nl>
References: <20220726123222.1074876-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This naming error slipped through, so now that a new backlight node has
been added with correct spelling, fix this one also.

Fixes: 98efa526a0c4 ("ARM: dts: imx6qdl-vicut1/vicutgo: Add backlight_led node")
Signed-off-by: David Jander <david@protonic.nl>
---
v2:
 - new patch in series
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index 8a2512f3f378..c4e6cf0527ba 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -28,7 +28,7 @@ backlight_lcd: backlight {
 		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
 	};
 
-	backlight_led: backlight_led {
+	backlight_led: backlight-led {
 		compatible = "pwm-backlight";
 		pwms = <&pwm3 0 5000000 0>;
 		brightness-levels = <0 16 64 255>;
-- 
2.32.0

