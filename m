Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2F535BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349934AbiE0IiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349822AbiE0IiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:38:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30E108AA0;
        Fri, 27 May 2022 01:37:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24R8b6Lg012327;
        Fri, 27 May 2022 03:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653640626;
        bh=D3w8nI02oB8EoNoAqaEWvOutV6JaRMHHmHyziuHi/rQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MPAg2J3hcjgd3R41zEA/4Q2cEr4xE0oR7I8ZL/Uekt/08WmJiNpqywNTWoquySpT8
         i8a717eNzR798slr0n+/lyefqsYLgKaXZaZ4ZA3ov4rtWKL8369dX5JuaLHsrT3PHP
         rx/rd1KK6VzZlTUT5mAFO8tZRYqjRQMQ7fWAAAYY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24R8b60M013580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 May 2022 03:37:06 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 27
 May 2022 03:37:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 27 May 2022 03:37:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24R8b4xv027749;
        Fri, 27 May 2022 03:37:05 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header
Date:   Fri, 27 May 2022 14:05:56 +0530
Message-ID: <20220527083556.18864-4-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220527083556.18864-1-r-ravikumar@ti.com>
References: <20220527083556.18864-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Add pinmux required to bring out
i2c5, ehrpwm 2 and 3 and gpios on
40 pin RPi header on sk board

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 89 ++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 98a55778f3fe..b913b18ae133 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -400,6 +400,57 @@
 			J721E_IOPAD(0x124, PIN_INPUT, 7) /* (Y24) PRG0_PRU1_GPO9.GPIO0_72 */
 		>;
 	};
+
+	main_i2c5_pins_default: main-i2c5-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
+			J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
+		>;
+	};
+
+	rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x01c, PIN_INPUT, 7) /* (AD22) PRG1_PRU0_GPO6.GPIO0_7 */
+			J721E_IOPAD(0x120, PIN_INPUT, 7) /* (AA28) PRG0_PRU1_GPO8.GPIO0_71 */
+			J721E_IOPAD(0x14c, PIN_INPUT, 7) /* (AA29) PRG0_PRU1_GPO19.GPIO0_82 */
+			J721E_IOPAD(0x02c, PIN_INPUT, 7) /* (AD21) PRG1_PRU0_GPO10.GPIO0_11 */
+			J721E_IOPAD(0x198, PIN_INPUT, 7) /* (V25) RGMII6_TD1.GPIO0_101 */
+			J721E_IOPAD(0x1b0, PIN_INPUT, 7) /* (W24) RGMII6_RD1.GPIO0_107 */
+			J721E_IOPAD(0x1a0, PIN_INPUT, 7) /* (W29) RGMII6_TXC.GPIO0_103 */
+			J721E_IOPAD(0x008, PIN_INPUT, 7) /* (AG22) PRG1_PRU0_GPO1.GPIO0_2 */
+			J721E_IOPAD(0x1d0, PIN_INPUT, 7) /* (AA3) SPI0_D1.GPIO0_115 */
+			J721E_IOPAD(0x11c, PIN_INPUT, 7) /* (AA24) PRG0_PRU1_GPO7.GPIO0_70 */
+			J721E_IOPAD(0x148, PIN_INPUT, 7) /* (AA26) PRG0_PRU1_GPO18.GPIO0_81 */
+			J721E_IOPAD(0x004, PIN_INPUT, 7) /* (AC23) PRG1_PRU0_GPO0.GPIO0_1 */
+			J721E_IOPAD(0x014, PIN_INPUT, 7) /* (AH23) PRG1_PRU0_GPO4.GPIO0_5 */
+			J721E_IOPAD(0x020, PIN_INPUT, 7) /* (AE20) PRG1_PRU0_GPO7.GPIO0_8 */
+			J721E_IOPAD(0x19c, PIN_INPUT, 7) /* (W27) RGMII6_TD0.GPIO0_102 */
+			J721E_IOPAD(0x1b4, PIN_INPUT, 7) /* (W25) RGMII6_RD0.GPIO0_108 */
+			J721E_IOPAD(0x188, PIN_INPUT, 7) /* (Y28) RGMII6_TX_CTL.GPIO0_97 */
+			J721E_IOPAD(0x00c, PIN_INPUT, 7) /* (AF22) PRG1_PRU0_GPO2.GPIO0_3 */
+			J721E_IOPAD(0x010, PIN_INPUT, 7) /* (AJ23) PRG1_PRU0_GPO3.GPIO0_4 */
+		>;
+	};
+
+	rpi_header_gpio1_pins_default: rpi-header-gpio1-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
+		>;
+	};
+
+	rpi_header_ehrpwm2_pins_default: rpi-header-ehrpwm2-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x178, PIN_INPUT, 6) /* (U27) RGMII5_RD3.EHRPWM2_A */
+			J721E_IOPAD(0x17c, PIN_INPUT, 6) /* (U24) RGMII5_RD2.EHRPWM2_B */
+		>;
+	};
+
+	rpi_header_ehrpwm3_pins_default: rpi-header-ehrpwm3-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x18c, PIN_INPUT, 6) /* (V23) RGMII6_RX_CTL.EHRPWM3_A */
+			J721E_IOPAD(0x190, PIN_INPUT, 6) /* (W23) RGMII6_TD3.EHRPWM3_B */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -631,11 +682,6 @@
 	status = "disabled";
 };
 
-&main_i2c5 {
-	/* Brought out on RPi Header */
-	status = "disabled";
-};
-
 &main_i2c6 {
 	/* Unused */
 	status = "disabled";
@@ -1138,18 +1184,39 @@
 	status = "disabled";
 };
 
-&main_ehrpwm2 {
+&main_ehrpwm4 {
 	status = "disabled";
 };
 
-&main_ehrpwm3 {
+&main_ehrpwm5 {
 	status = "disabled";
 };
 
-&main_ehrpwm4 {
-	status = "disabled";
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
 };
 
-&main_ehrpwm5 {
-	status = "disabled";
+&main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio1_pins_default>;
+};
+
+&main_i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c5_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&main_ehrpwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_ehrpwm2_pins_default>;
+	status = "okay";
+};
+
+&main_ehrpwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_ehrpwm3_pins_default>;
+	status = "okay";
 };
-- 
2.17.1

