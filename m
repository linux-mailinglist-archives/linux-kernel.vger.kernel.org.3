Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D55090BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381859AbiDTTx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381843AbiDTTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:53:19 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF6286DC;
        Wed, 20 Apr 2022 12:50:32 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6134F22253;
        Wed, 20 Apr 2022 21:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650484230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVw7qHKLWCFU8NJG+HbG+7HB2455fVE1/5Rhd7k/rHE=;
        b=PgGVZHttZP9E8n4R5rjcT5TSEzRE+a8cOZILrz2DguhiS0IFqGJYDOgQ88Jc8AkLhnd4Mo
        VW9+b/Q0o9p1ztpEpdcPbkdzxB4y8pw/Oywc8wlFtHGAua5AaEICQDf43I/kwGcI+iLzsh
        IPFUEsLnVBG1uek8//Cy8almxK2Y/TM=
From:   Michael Walle <michael@walle.cc>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     UNGLinuxDriver@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 3/3] MIPS: mscc: serval: rename pinctrl nodes
Date:   Wed, 20 Apr 2022 21:50:18 +0200
Message-Id: <20220420195018.3417053-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420195018.3417053-1-michael@walle.cc>
References: <20220420195018.3417053-1-michael@walle.cc>
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

