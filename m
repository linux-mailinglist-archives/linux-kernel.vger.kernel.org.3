Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D64DE27E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbiCRU1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbiCRU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:27:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5168F292D85;
        Fri, 18 Mar 2022 13:25:57 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F02DB2244E;
        Fri, 18 Mar 2022 21:25:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647635155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf4D+lq8p2304IqZfXohb7B3lm+eDnMGkVWOmv4VwzU=;
        b=UbrVyxmqTc0GEjuVOwatzQjPI85cmOegG8tv0+XhhLh73Gykiyf3kTugkAiRy0QzRHML68
        19WIYzg5/FC5yVT5Bfui/1fHOSIhs7KyqK4byFlyhnpqHnOpMfi5CxAVR7kt9tofU84nVO
        KSiZTvKWLqvZkeENW3a1D4lMegGLSlI=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 5/8] MIPS: mscc: serval: fix pinctrl node names
Date:   Fri, 18 Mar 2022 21:25:44 +0100
Message-Id: <20220318202547.1650687-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220318202547.1650687-1-michael@walle.cc>
References: <20220318202547.1650687-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl device tree binding will be converted to YAML format. All
the pin nodes should end with "-pins". Fix them.

Fixes: fe0052018a84 ("MIPS: mscc: Add serval support")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/mips/boot/dts/mscc/serval_common.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/boot/dts/mscc/serval_common.dtsi b/arch/mips/boot/dts/mscc/serval_common.dtsi
index 5b404836db5e..0893de420e27 100644
--- a/arch/mips/boot/dts/mscc/serval_common.dtsi
+++ b/arch/mips/boot/dts/mscc/serval_common.dtsi
@@ -82,38 +82,38 @@ i2c_pins: i2c-pins {
 		pins = "GPIO_7"; /* No "default" scl for i2c0 */
 		function = "twi";
 	};
-	i2cmux_pins_i: i2cmux-pins-i {
+	i2cmux_pins_i: i2cmux-pins {
 		pins = "GPIO_11", "GPIO_12", "GPIO_18", "GPIO_19",
 			"GPIO_20", "GPIO_21";
 		function = "twi_scl_m";
 		output-low;
 	};
-	i2cmux_0: i2cmux-0 {
+	i2cmux_0: i2cmux-0-pins {
 		pins = "GPIO_11";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_1: i2cmux-1 {
+	i2cmux_1: i2cmux-1-pins {
 		pins = "GPIO_12";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_2: i2cmux-2 {
+	i2cmux_2: i2cmux-2-pins {
 		pins = "GPIO_18";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_3: i2cmux-3 {
+	i2cmux_3: i2cmux-3-pins {
 		pins = "GPIO_19";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_4: i2cmux-4 {
+	i2cmux_4: i2cmux-4-pins {
 		pins = "GPIO_20";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_5: i2cmux-5 {
+	i2cmux_5: i2cmux-5-pins {
 		pins = "GPIO_21";
 		function = "twi_scl_m";
 		output-high;
-- 
2.30.2

