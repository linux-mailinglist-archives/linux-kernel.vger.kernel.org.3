Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610E457E223
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiGVNPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiGVNPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:15:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B22115A27;
        Fri, 22 Jul 2022 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658495711; x=1690031711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLZkiQ4n/K57EeOf5NzeNj8fQsedMD8wxWDY8eSo21o=;
  b=DhfgeevpUydlpw7W/iLVLdkr6wKb4+OF3HZuTJscZ+3v38+sXJ8Lu0jS
   inqu3GYkzWted+GWryJiGFyeMwOFnI4TypFmiUjHSb7+vbIpbmuw5cV1S
   lX8coyMezJvuCOhxKZne62T3N1LlD05gJPivgfl4/oEX7k1PZYYUfV9qP
   KeVCYIog56FjmgyPqga24U9WthTAuL5HCjFVA+/PUkk2feVUmUum+3NOu
   mNRG6hIP5iY6LlCSlk6sNwzPr9pmgeLVGJPdhWJd2odoZRYaV5XgTSx+Z
   eO3hNIiL0XiaG6iL9FCq2QIbsxpTaiVJdHn27w/yZUVMSLQPNgl4FJfFd
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="165969846"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2022 06:15:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 22 Jul 2022 06:15:08 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Fri, 22 Jul 2022 06:15:05 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 2/2] ARM: dts: lan966x: add support for pcb8309
Date:   Fri, 22 Jul 2022 15:18:36 +0200
Message-ID: <20220722131836.2377720-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220722131836.2377720-1-horatiu.vultur@microchip.com>
References: <20220722131836.2377720-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for pcb8309. It is similar with pcb8291 with one big
difference that is having 2 SFP cages. Therefore it has 4 network ports.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/Makefile            |   3 +-
 arch/arm/boot/dts/lan966x-pcb8309.dts | 184 ++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/lan966x-pcb8309.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 184899808ee7..6a6166e3a405 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -772,7 +772,8 @@ dtb-$(CONFIG_SOC_IMXRT) += \
 dtb-$(CONFIG_SOC_LAN966) += \
 	lan966x-pcb8291.dtb \
 	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
-	lan966x-kontron-kswitch-d10-mmt-8g.dtb
+	lan966x-kontron-kswitch-d10-mmt-8g.dtb \
+	lan966x-pcb8309.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-iot.dtb \
 	ls1021a-moxa-uc-8410a.dtb \
diff --git a/arch/arm/boot/dts/lan966x-pcb8309.dts b/arch/arm/boot/dts/lan966x-pcb8309.dts
new file mode 100644
index 000000000000..05ce27ed5648
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x-pcb8309.dts
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * lan966x_pcb8309.dts - Device Tree file for PCB8309
+ */
+/dts-v1/;
+#include "lan966x.dtsi"
+#include "dt-bindings/phy/phy-lan966x-serdes.h"
+
+/ {
+	model = "Microchip EVB - LAN9662";
+	compatible = "microchip,lan9662-pcb8309", "microchip,lan9662", "microchip,lan966";
+
+	aliases {
+		serial0 = &usart3;
+		i2c102 = &i2c102;
+		i2c103 = &i2c103;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
+		priority = <200>;
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mux-controls = <&mux>;
+		i2c-parent = <&i2c4>;
+
+		i2c102: i2c-sfp@1 {
+			reg = <1>;
+		};
+
+		i2c103: i2c-sfp@2 {
+			reg = <2>;
+		};
+	};
+
+	mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&sgpio_out 11 0 GPIO_ACTIVE_HIGH>, /* p11b0 */
+			    <&sgpio_out 11 1 GPIO_ACTIVE_HIGH>; /* p11b1 */
+	};
+
+	sfp2: sfp2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c102>;
+		tx-disable-gpios = <&sgpio_out 10 0 GPIO_ACTIVE_LOW>;
+		los-gpios = <&sgpio_in  2 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in  2 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in  1 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp3: sfp3 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c103>;
+		tx-disable-gpios = <&sgpio_out 10 1 GPIO_ACTIVE_LOW>;
+		los-gpios = <&sgpio_in  3 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in  3 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in  1 1 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&flx3 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+
+	usart3: serial@200 {
+		pinctrl-0 = <&fc3_b_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+};
+
+&flx4 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c4: i2c@600 {
+		compatible = "microchip,sam9x60-i2c";
+		reg = <0x600 0x200>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&nic_clk>;
+		pinctrl-0 = <&fc4_b_pins>;
+		pinctrl-names = "default";
+		i2c-analog-filter;
+		i2c-digital-filter;
+		i2c-digital-filter-width-ns = <35>;
+		i2c-sda-hold-time-ns = <1500>;
+		status = "okay";
+	};
+};
+
+&gpio {
+	fc3_b_pins: fc3-b-pins {
+		/* RXD, TXD */
+		pins = "GPIO_52", "GPIO_53";
+		function = "fc3_b";
+	};
+
+	fc4_b_pins: fc4-b-pins {
+		/* SCL, SDA */
+		pins = "GPIO_57", "GPIO_58";
+		function = "fc4_b";
+	};
+
+	sgpio_a_pins: sgpio-a-pins {
+		/* SCK, D0, D1, LD */
+		pins = "GPIO_32", "GPIO_33", "GPIO_34", "GPIO_35";
+		function = "sgpio_a";
+	};
+};
+
+&mdio1 {
+	status = "okay";
+};
+
+&phy0 {
+	status = "okay";
+};
+
+&phy1 {
+	status = "okay";
+};
+
+&port0 {
+	phy-handle = <&phy0>;
+	phy-mode = "gmii";
+	phys = <&serdes 0 CU(0)>;
+	status = "okay";
+};
+
+&port1 {
+	phy-handle = <&phy1>;
+	phy-mode = "gmii";
+	phys = <&serdes 1 CU(1)>;
+	status = "okay";
+};
+
+&port2 {
+	sfp = <&sfp2>;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phys = <&serdes 2 SERDES6G(0)>;
+	status = "okay";
+};
+
+&port3 {
+	sfp = <&sfp3>;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phys = <&serdes 3 SERDES6G(1)>;
+	status = "okay";
+};
+
+&serdes {
+	status = "okay";
+};
+
+&sgpio {
+	pinctrl-0 = <&sgpio_a_pins>;
+	pinctrl-names = "default";
+	microchip,sgpio-port-ranges = <0 3>, <8 11>;
+	status = "okay";
+
+	gpio@0 {
+		ngpios = <64>;
+	};
+	gpio@1 {
+		ngpios = <64>;
+	};
+};
+
+&switch {
+	status = "okay";
+};
-- 
2.33.0

