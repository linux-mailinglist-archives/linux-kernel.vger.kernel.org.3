Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC105090A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381839AbiDTTtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381761AbiDTTs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:48:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F74A1C928;
        Wed, 20 Apr 2022 12:46:11 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 29AD722249;
        Wed, 20 Apr 2022 21:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650483969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7WHTmyBnw+kRKp9ai99bDBnCL1nOdm+EiFK2nOE9oeg=;
        b=szzAM2xkKF+cJM6oJdlWwkQXLgmxWnwehN8OLhIg/XccmkdzlUMI7q4XCk7FldPo1aLBJR
        pSHLkBwbOjPXBF+aLbcZ46+HswmQLkXG68RPNf+oFNm+kSeGQbCPMTR2bJ6ieHnzO6O2V9
        rI8iLhiSzDP3MtwKrgbA3Bq4ghlRw2s=
From:   Michael Walle <michael@walle.cc>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: sparx5: rename pinctrl nodes
Date:   Wed, 20 Apr 2022 21:46:00 +0200
Message-Id: <20220420194600.3416282-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl device tree binding will be converted to YAML format. Rename
the pin nodes so they end with "-pins" to match the schema.

Signed-off-by: Michael Walle <michael@walle.cc>
---
The YAML conversion patch is alread in
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

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

