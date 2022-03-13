Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8005A4D7668
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiCMPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiCMPbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:31:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ACD27CC8;
        Sun, 13 Mar 2022 08:29:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1A1F8223E9;
        Sun, 13 Mar 2022 16:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647185386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsR/n/iXwlJMJJQjdlhM2ugPtT0Os51cUfzrMcefFdM=;
        b=pMzYdb3DmHXEYbeqRjxN6dCK6NWRN2spYe4w2pYOpmHwCW8u6GRfnluJgFJmMiIimZkXzs
        1EBtj9B+/cQ9xbykI0K7z3DstCX968Twp6NqEi9tZiYBvW1M5cggHggvCMiKCNTxJt2Qx0
        3d9OcIbhkISN+Cn0Il5M+kx2eAiD7N8=
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
Subject: [PATCH v1 1/8] MIPS: mscc: jaguar2: fix pinctrl nodes
Date:   Sun, 13 Mar 2022 16:29:17 +0100
Message-Id: <20220313152924.61931-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220313152924.61931-1-michael@walle.cc>
References: <20220313152924.61931-1-michael@walle.cc>
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

Fixes: f84778f7d8c3 ("MIPS: mscc: Add jaguar2 support")
Signed-off-by: Michael Walle <michael@walle.cc>
---
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

