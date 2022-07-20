Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1EC57BED7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiGTTqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiGTTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:46:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB954CAB;
        Wed, 20 Jul 2022 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658346364; x=1689882364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDGmeIC5wAWph6fx9zzOtxX1lbFu5oe4nSte9/EaAZI=;
  b=znbhDTBjJgdN8Ekr/ZQlzAx/CtnxTUuPB557q6x9Lvi1FjQjWhkeazmv
   /aafmI37NR2f091rqgN6d4hqJM14gJN5riZ56i3vWeGddaR0Xh0ZaVjrI
   HnquwBAXKrDUr/x9wJ48sd9pWod1mSP7LcBtKmB7aOr9KdkQO15zx4Zft
   BICOaHRy17UzTFYrj0ct+GrimrtvOdSy2zYpjYnzgzLZdi9IzkApguVCX
   CB/RiGqrTfuvR1VytMRvYhrxXow6ecsaocsYU9W/tPV1lbm76vFtGjq4E
   yauvJoK/Ao0zI9duBXi/clAJiBNfUigb+qCqXGteAW55pReLkTvXE6ki9
   g==;
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="165677162"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 12:45:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 12:45:56 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 12:45:53 -0700
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
Subject: [PATCH 2/2] ARM: dts: lan966x: add support for pcb8309
Date:   Wed, 20 Jul 2022 21:49:04 +0200
Message-ID: <20220720194904.2025384-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
References: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
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
 arch/arm/boot/dts/lan966x-pcb8309.dts | 189 ++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 1 deletion(-)
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
index 000000000000..ef441195e8c1
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x-pcb8309.dts
@@ -0,0 +1,189 @@
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c103: i2c-sfp@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+&i2c4 {
+	compatible = "microchip,sam9x60-i2c";
+	reg = <0x600 0x200>;
+	interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&nic_clk>;
+	pinctrl-0 = <&fc4_b_pins>;
+	pinctrl-names = "default";
+	i2c-analog-filter;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
+	i2c-sda-hold-time-ns = <1500>;
+	status = "okay";
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
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "gmii";
+	phys = <&serdes 0 CU(0)>;
+};
+
+&port1 {
+	status = "okay";
+	phy-handle = <&phy1>;
+	phy-mode = "gmii";
+	phys = <&serdes 1 CU(1)>;
+};
+
+&port2 {
+	status = "okay";
+	sfp = <&sfp2>;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phys = <&serdes 2 SERDES6G(0)>;
+};
+
+&port3 {
+	status = "okay";
+	sfp = <&sfp3>;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phys = <&serdes 3 SERDES6G(1)>;
+};
+
+&serdes {
+	status = "okay";
+};
+
+&sgpio {
+	status = "okay";
+	pinctrl-0 = <&sgpio_a_pins>;
+	pinctrl-names = "default";
+	microchip,sgpio-port-ranges = <0 3>, <8 11>;
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

