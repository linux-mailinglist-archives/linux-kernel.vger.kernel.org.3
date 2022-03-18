Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77664DE27D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbiCRU13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiCRU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:27:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA86292D83;
        Fri, 18 Mar 2022 13:25:57 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6037C22450;
        Fri, 18 Mar 2022 21:25:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647635155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+g/RitcSmaUMyCXbz8jc3Ub243800mj7iWOgdS+Wq4=;
        b=djQAeiKVyhz+SRkyF9z0+sx3GNNCwzSIK6/uG+iRBXjNmo0p4JuNABD1zXGi4/YICIO+5o
        QfZsdvRN/pxJ1QLYvCM5/nVgc5itAAf4K8o462NfOv8fPjQk2b2uWQ6K/DffASwVKbKx+t
        TLAEDmwn4YxHJmfJfgcuvWqqJRNVnps=
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
Subject: [PATCH v2 6/8] arm64: dts: sparx5: fix pinctrl node names
Date:   Fri, 18 Mar 2022 21:25:45 +0100
Message-Id: <20220318202547.1650687-7-michael@walle.cc>
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

Fixes: ("arm64: dts: sparx5: Add i2c devices, i2c muxes")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../dts/microchip/sparx5_pcb134_board.dtsi    | 26 +++++++++----------
 .../dts/microchip/sparx5_pcb135_board.dtsi    | 10 +++----
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index 33faf1f3264f..6f488e774215 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -325,69 +325,69 @@ &sgpio2 {
 };
 
 &gpio {
-	i2cmux_pins_i: i2cmux-pins-i {
+	i2cmux_pins_i: i2cmux-pins {
 	       pins = "GPIO_16", "GPIO_17", "GPIO_18", "GPIO_19",
 		      "GPIO_20", "GPIO_22", "GPIO_36", "GPIO_35",
 		      "GPIO_50", "GPIO_51", "GPIO_56", "GPIO_57";
 		function = "twi_scl_m";
 		output-low;
 	};
-	i2cmux_0: i2cmux-0 {
+	i2cmux_0: i2cmux-0-pins {
 		pins = "GPIO_16";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_1: i2cmux-1 {
+	i2cmux_1: i2cmux-1-pins {
 		pins = "GPIO_17";
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
 		pins = "GPIO_22";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_6: i2cmux-6 {
+	i2cmux_6: i2cmux-6-pins {
 		pins = "GPIO_36";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_7: i2cmux-7 {
+	i2cmux_7: i2cmux-7-pins {
 		pins = "GPIO_35";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_8: i2cmux-8 {
+	i2cmux_8: i2cmux-8-pins {
 		pins = "GPIO_50";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_9: i2cmux-9 {
+	i2cmux_9: i2cmux-9-pins {
 		pins = "GPIO_51";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_10: i2cmux-10 {
+	i2cmux_10: i2cmux-10-pins {
 		pins = "GPIO_56";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_11: i2cmux-11 {
+	i2cmux_11: i2cmux-11-pins {
 		pins = "GPIO_57";
 		function = "twi_scl_m";
 		output-high;
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index ef96e6d8c6b3..d9e519bfbf68 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -59,28 +59,28 @@ led@7 {
 };
 
 &gpio {
-	i2cmux_pins_i: i2cmux-pins-i {
+	i2cmux_pins_i: i2cmux-pins {
 	       pins = "GPIO_35", "GPIO_36",
 		      "GPIO_50", "GPIO_51";
 		function = "twi_scl_m";
 		output-low;
 	};
-	i2cmux_s29: i2cmux-0 {
+	i2cmux_s29: i2cmux-0-pins {
 		pins = "GPIO_35";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_s30: i2cmux-1 {
+	i2cmux_s30: i2cmux-1-pins {
 		pins = "GPIO_36";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_s31: i2cmux-2 {
+	i2cmux_s31: i2cmux-2-pins {
 		pins = "GPIO_50";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_s32: i2cmux-3 {
+	i2cmux_s32: i2cmux-3-pins {
 		pins = "GPIO_51";
 		function = "twi_scl_m";
 		output-high;
-- 
2.30.2

