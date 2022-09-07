Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9295B004A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIGJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiIGJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:21:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E7B0B0A;
        Wed,  7 Sep 2022 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662542504; x=1694078504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JdkaiBQAOGFL6JQPA+3wuDGAg53fqTitwcaouDxZODI=;
  b=14gvYL3jCGYaD7tEz0+vNCgOmNz+BsKGXJJGwrFAlxcKBwpc00vtxOUx
   b9GqsrTLyzb8nwnlkGKe0coJZ64KgRTei3GxeimTy7wv6yqqudb6QH430
   bINCxeUOyEiwWsxyQd9JKP+42EcKspv3PwY7zjG1a8ShbOmzm9VjUp2fG
   Ts7SGTV/dd/grVjY5AKd+mXUHUv754adcGFf7J3TdUMRNt8dERCySYyH6
   HpjM7hkwbeSfkl9AJDwBOt42wU2YKj4G3Kll47UHzAmW9CySus6AnR0s3
   FU8QKgs78lO/uPrAEaTAD7hR1dEhT9iOwd64DggJDP6aVJNnl2SKkTtoI
   g==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="172733009"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 02:21:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 02:21:40 -0700
Received: from che-lt-i63539lx.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 02:21:34 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <manikandan.m@microchip.com>, <michael@walle.cc>,
        <horatiu.vultur@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <durai.manickamkr@microchip.com>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [linux][PATCH 5/6] ARM: dts: at91: sam9x60: Add missing flexcom definitions
Date:   Wed, 7 Sep 2022 14:50:53 +0530
Message-ID: <20220907092054.29915-6-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
References: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Durai Manickam KR <durai.manickamkr@microchip.com>

Added the missing flexcom functions for all the flexcom nodes.

Signed-off-by: Manikandan M <manikandan.m@microchip.com>
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
---
 arch/arm/boot/dts/sam9x60.dtsi | 547 +++++++++++++++++++++++++++++++++
 1 file changed, 547 insertions(+)

diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index feeabc53e0ec..1c580c3ba7c3 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -170,6 +170,27 @@
 				ranges = <0x0 0xf0000000 0x800>;
 				status = "disabled";
 
+				uart4: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(8))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(9))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
 				spi4: spi@400 {
 					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
 					reg = <0x400 0x200>;
@@ -188,6 +209,24 @@
 					atmel,fifo-size = <16>;
 					status = "disabled";
 				};
+
+				i2c4: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(8))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(9))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx5: flexcom@f0004000 {
@@ -219,6 +258,43 @@
 					atmel,fifo-size = <16>;
 					status = "disabled";
 				};
+
+				spi5: spi@400 {
+					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
+					reg = <0x400 0x200>;
+					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
+					clock-names = "spi_clk";
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(10))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(11))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c5: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(10))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(11))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			dma0: dma-controller@f0008000 {
@@ -290,6 +366,45 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf0020000 0x800>;
 				status = "disabled";
+
+				uart11: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(22))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(23))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c11: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(22))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(23))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx12: flexcom@f0024000 {
@@ -300,6 +415,45 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf0024000 0x800>;
 				status = "disabled";
+
+				uart12: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(24))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(25))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c12: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(24))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(25))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			pit64b: timer@f0028000 {
@@ -419,6 +573,27 @@
 				ranges = <0x0 0xf8010000 0x800>;
 				status = "disabled";
 
+				uart6: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(12))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(13))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
 				i2c6: i2c@600 {
 					compatible = "microchip,sam9x60-i2c";
 					reg = <0x600 0x200>;
@@ -446,6 +621,45 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf8014000 0x800>;
 				status = "disabled";
+
+				uart7: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(14))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(15))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c7: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(14))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(15))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx8: flexcom@f8018000 {
@@ -456,15 +670,96 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf8018000 0x800>;
 				status = "disabled";
+
+				uart8: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(16))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(17))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c8: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(16))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(17))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx0: flexcom@f801c000 {
 				compatible = "atmel,sama5d2-flexcom";
 				reg = <0xf801c000 0x200>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+				#address-cells = <1>;
+				#size-cells = <1>;
 				ranges = <0x0 0xf801c000 0x800>;
 				status = "disabled";
 
+				uart0: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(0))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(1))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				spi0: spi@400 {
+					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
+					reg = <0x400 0x200>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+					clock-names = "spi_clk";
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(0))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(1))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
 				i2c0: i2c@600 {
 					compatible = "microchip,sam9x60-i2c";
 					reg = <0x600 0x200>;
@@ -494,6 +789,64 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf8020000 0x800>;
 				status = "disabled";
+
+				uart1: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(2))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(3))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				spi1: spi@400 {
+					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
+					reg = <0x400 0x200>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
+					clock-names = "spi_clk";
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(2))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(3))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c1: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(2))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(3))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx2: flexcom@f8024000 {
@@ -504,6 +857,64 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf8024000 0x800>;
 				status = "disabled";
+
+				uart2: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(4))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(5))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				spi2: spi@400 {
+					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
+					reg = <0x400 0x200>;
+					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
+					clock-names = "spi_clk";
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(4))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(5))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c2: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(4))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(5))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx3: flexcom@f8028000 {
@@ -514,6 +925,64 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf8028000 0x800>;
 				status = "disabled";
+
+				uart3: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(6))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(7))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				spi3: spi@400 {
+					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
+					reg = <0x400 0x200>;
+					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
+					clock-names = "spi_clk";
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(6))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(7))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c3: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(6))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(7))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			macb0: ethernet@f802c000 {
@@ -579,6 +1048,45 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf8040000 0x800>;
 				status = "disabled";
+
+				uart9: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(18))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(19))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c9: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(18))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(19))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx10: flexcom@f8044000 {
@@ -589,6 +1097,45 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf8044000 0x800>;
 				status = "disabled";
+
+				uart10: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(20))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(21))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
+
+				i2c10: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(20))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(21))>;
+					dma-names = "tx", "rx";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			isi: isi@f8048000 {
-- 
2.17.1

