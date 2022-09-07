Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5245D5B003F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIGJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIGJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:21:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C21DA4F;
        Wed,  7 Sep 2022 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662542480; x=1694078480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GuFBZXXxj5JZvk7OWi1+kSXB5Q/GhtyNc2SsO4+S5jQ=;
  b=yXcd3PbOmciICT7n3LHqOsCLUU/qEckW+MVtQ+QjRp+As8hWvCklSNg5
   o3E1FEqqi/zoeNhlb00glnmmJujt50I+76ZCxnSDw7fkx0yLkYZD3t/EY
   j3967eg3gFYy/YFK2mjG6FvXz+rFwNKzJl+wZJya5OWOKYuZlZGG7fjKt
   mUNIMYVInEn8qYuXmZPXDgJvVPB7RexoStj6F8oL0McM93KvAyt5FG3J5
   Tu22hAZv9jUG31ZrV+lNtGY2jXZCtgk/OZKFAO7AKrkdPWMtHi5yN+Nyz
   HRK+dFWc0i0bpGag4vOaXoIaoafLphaxjCl7JZdwDSOohYOGQaRdGqSYz
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="112520797"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 02:21:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 02:21:18 -0700
Received: from che-lt-i63539lx.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 02:21:12 -0700
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
Subject: [linux][PATCH 2/6] ARM: dts: at91: sam9x60: Move flexcom definitions to the SoC dtsi
Date:   Wed, 7 Sep 2022 14:50:50 +0530
Message-ID: <20220907092054.29915-3-Hari.PrasathGE@microchip.com>
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

Move the flexcom definitions to the SoC specifc DTSI file retaining only
the pinmux and desired functions in the board specific DTS file of
sam9x60ek.

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
Signed-off-by: Manikandan M <manikandan.m@microchip.com>
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 34 +-----------------
 arch/arm/boot/dts/sam9x60.dtsi       | 52 ++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index b9b7a235ef89..9d9e50c77794 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -211,15 +211,10 @@
 	status = "okay";
 
 	i2c0: i2c@600 {
-		compatible = "microchip,sam9x60-i2c";
-		reg = <0x600 0x200>;
-		interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx0_default>;
-		atmel,fifo-size = <16>;
 		i2c-analog-filter;
 		i2c-digital-filter;
 		i2c-digital-filter-width-ns = <35>;
@@ -239,16 +234,8 @@
 	status = "disabled";
 
 	spi4: spi@400 {
-		compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
-		reg = <0x400 0x200>;
-		interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
-		clock-names = "spi_clk";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx4_default>;
-		atmel,fifo-size = <16>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		status = "disabled";
 	};
 };
@@ -258,22 +245,8 @@
 	status = "okay";
 
 	uart5: serial@200 {
-		compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
-		reg = <0x200 0x200>;
-		interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas = <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(10))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(11))>;
-		dma-names = "tx", "rx";
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
-		clock-names = "usart";
-		pinctrl-0 = <&pinctrl_flx5_default>;
 		pinctrl-names = "default";
-		atmel,use-dma-rx;
-		atmel,use-dma-tx;
+		pinctrl-0 = <&pinctrl_flx5_default>;
 		status = "okay";
 	};
 };
@@ -283,15 +256,10 @@
 	status = "okay";
 
 	i2c6: i2c@600 {
-		compatible = "microchip,sam9x60-i2c";
-		reg = <0x600 0x200>;
-		interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx6_default>;
-		atmel,fifo-size = <16>;
 		i2c-analog-filter;
 		i2c-digital-filter;
 		i2c-digital-filter-width-ns = <35>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index d3f60f6a456d..f0e0dc20de1b 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -169,6 +169,16 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf0000000 0x800>;
 				status = "disabled";
+
+				spi4: spi@400 {
+					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
+					reg = <0x400 0x200>;
+					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
+					clock-names = "spi_clk";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx5: flexcom@f0004000 {
@@ -179,6 +189,26 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf0004000 0x800>;
 				status = "disabled";
+
+				uart5: serial@200 {
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(10))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(11))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					status = "disabled";
+				};
 			};
 
 			dma0: dma-controller@f0008000 {
@@ -378,6 +408,15 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf8010000 0x800>;
 				status = "disabled";
+
+				i2c6: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx7: flexcom@f8014000 {
@@ -404,10 +443,19 @@
 				compatible = "atmel,sama5d2-flexcom";
 				reg = <0xf801c000 0x200>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
-				#address-cells = <1>;
-				#size-cells = <1>;
 				ranges = <0x0 0xf801c000 0x800>;
 				status = "disabled";
+
+				i2c0: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx1: flexcom@f8020000 {
-- 
2.17.1

