Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C25090B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381844AbiDTTxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381733AbiDTTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:53:18 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6CC27FF1;
        Wed, 20 Apr 2022 12:50:31 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6506D22249;
        Wed, 20 Apr 2022 21:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650484229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J4t5tSLMucyMj+m3zBxv0Et2me7exjbWlp6rk08kdfM=;
        b=nnxQzd14T5+Y7xfx397EX1iVYxRn6+ZfP3H+r5crsqDSMh+B4hDrzBtwqKytmyYAg6/4EM
        ctx3/4a7EgenLr7ezsCCcJqf9o8M20GdrsxYb0kbB0hv2JYMZoyhJ2RXzIgMldm7YYbLEg
        xighOjslUHlLk5rM2YGftVthqzEhI9c=
From:   Michael Walle <michael@walle.cc>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     UNGLinuxDriver@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/3] MIPS: mscc: jaguar2: rename pinctrl nodes
Date:   Wed, 20 Apr 2022 21:50:16 +0200
Message-Id: <20220420195018.3417053-1-michael@walle.cc>
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

 arch/mips/boot/dts/mscc/jaguar2_pcb110.dts | 10 +++++-----
 arch/mips/boot/dts/mscc/jaguar2_pcb111.dts | 10 +++++-----
 arch/mips/boot/dts/mscc/jaguar2_pcb118.dts |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/boot/dts/mscc/jaguar2_pcb110.dts b/arch/mips/boot/dts/mscc/jaguar2_pcb110.dts
index d80cd6842b2a..0ea7bc5b5746 100644
--- a/arch/mips/boot/dts/mscc/jaguar2_pcb110.dts
+++ b/arch/mips/boot/dts/mscc/jaguar2_pcb110.dts
@@ -180,27 +180,27 @@ synce_builtin_pins: synce-builtin-pins {
 		pins = "GPIO_49";
 		function = "si";
 	};
-	i2cmux_pins_i: i2cmux-pins-i {
+	i2cmux_pins_i: i2cmux-pins {
 		pins = "GPIO_17", "GPIO_18", "GPIO_20", "GPIO_21";
 		function = "twi_scl_m";
 		output-low;
 	};
-	i2cmux_0: i2cmux-0 {
+	i2cmux_0: i2cmux-0-pins {
 		pins = "GPIO_17";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_1: i2cmux-1 {
+	i2cmux_1: i2cmux-1-pins {
 		pins = "GPIO_18";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_2: i2cmux-2 {
+	i2cmux_2: i2cmux-2-pins {
 		pins = "GPIO_20";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_3: i2cmux-3 {
+	i2cmux_3: i2cmux-3-pins {
 		pins = "GPIO_21";
 		function = "twi_scl_m";
 		output-high;
diff --git a/arch/mips/boot/dts/mscc/jaguar2_pcb111.dts b/arch/mips/boot/dts/mscc/jaguar2_pcb111.dts
index 813c5e16013c..05d8c6a96dc4 100644
--- a/arch/mips/boot/dts/mscc/jaguar2_pcb111.dts
+++ b/arch/mips/boot/dts/mscc/jaguar2_pcb111.dts
@@ -79,27 +79,27 @@ cpld_fifo_pins: synce-builtin-pins {
 };
 
 &gpio {
-	i2cmux_pins_i: i2cmux-pins-i {
+	i2cmux_pins_i: i2cmux-pins {
 		pins = "GPIO_17", "GPIO_18";
 		function = "twi_scl_m";
 		output-low;
 	};
-	i2cmux_0: i2cmux-0 {
+	i2cmux_0: i2cmux-0-pins {
 		pins = "GPIO_17";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_1: i2cmux-1 {
+	i2cmux_1: i2cmux-1-pins {
 		pins = "GPIO_18";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_2: i2cmux-2 {
+	i2cmux_2: i2cmux-2-pins {
 		pins = "GPIO_20";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_3: i2cmux-3 {
+	i2cmux_3: i2cmux-3-pins {
 		pins = "GPIO_21";
 		function = "twi_scl_m";
 		output-high;
diff --git a/arch/mips/boot/dts/mscc/jaguar2_pcb118.dts b/arch/mips/boot/dts/mscc/jaguar2_pcb118.dts
index 27c644f2d17f..cf2cf591a211 100644
--- a/arch/mips/boot/dts/mscc/jaguar2_pcb118.dts
+++ b/arch/mips/boot/dts/mscc/jaguar2_pcb118.dts
@@ -39,17 +39,17 @@ i2c151: i2c@1 {
 };
 
 &gpio {
-	i2cmux_pins_i: i2cmux-pins-i {
+	i2cmux_pins_i: i2cmux-pins {
 		pins = "GPIO_17", "GPIO_16";
 		function = "twi_scl_m";
 		output-low;
 	};
-	i2cmux_0: i2cmux-0 {
+	i2cmux_0: i2cmux-0-pins {
 		pins = "GPIO_17";
 		function = "twi_scl_m";
 		output-high;
 	};
-	i2cmux_1: i2cmux-1 {
+	i2cmux_1: i2cmux-1-pins {
 		pins = "GPIO_16";
 		function = "twi_scl_m";
 		output-high;
-- 
2.30.2

