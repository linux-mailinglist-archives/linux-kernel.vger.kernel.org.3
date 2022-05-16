Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F64D527E40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiEPHJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbiEPHJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:09:28 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F193E011;
        Mon, 16 May 2022 00:09:24 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FMvk8I008866;
        Mon, 16 May 2022 09:09:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=uMamLNj5EKxEnDIDCpvvDWC4KvQie3wCsrhwTZMTMHc=;
 b=S+ZsdrLey5ckmjAuGhjderH+248PSGMWejwlgzVy1F+qtTF0qYIxvrrvEpykl3uP7fIF
 IBbJGGkFGqWl4JuAeCExH/EMov9aZhTG2zYCV2UEw2sk923mU3WSMnE57fr1quJo6XQD
 vesdkBR55/7W3KVwcRBYe6fJNizrtiMIKvu96Z5IZeo2PkgNJvvFzfsCm5TTU2Yren/8
 nNtvuekivqoJPvVlezj7Y4OLGzJRaxMnVIrr9ZI4KBPdiEWemws1wjagJhJ0Mgdjy+ro
 05H8KZRrHBPX5GsDMbygqgm/PKMsXnrCblDMbPgQ2KN+9jOLdOzAWf9E9GqLDMf6CaTV Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21j8h3jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 09:09:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76324100034;
        Mon, 16 May 2022 09:09:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DF5021230D;
        Mon, 16 May 2022 09:09:11 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 09:09:10
 +0200
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 13/14] ARM: dts: stm32: add RCC on STM32MP13x SoC family
Date:   Mon, 16 May 2022 09:05:59 +0200
Message-ID: <20220516070600.7692-14-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_03,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Enables Reset and Clocks Controller on STM32MP13

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi  | 117 +++++++++++------------------
 arch/arm/boot/dts/stm32mp133.dtsi  |   4 +-
 arch/arm/boot/dts/stm32mp13xf.dtsi |   3 +-
 3 files changed, 47 insertions(+), 77 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 8f73a308116d..9ad50d18d289 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -4,6 +4,8 @@
  * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
  */
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/stm32mp13-clks.h>
+#include <dt-bindings/reset/stm32mp13-resets.h>
 
 / {
 	#address-cells = <1>;
@@ -51,61 +53,6 @@ scmi_reset: protocol@16 {
 			};
 		};
 	};
-	clocks {
-		clk_axi: clk-axi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <266500000>;
-		};
-
-		clk_hse: clk-hse {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-		};
-
-		clk_hsi: clk-hsi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <64000000>;
-		};
-
-		clk_lsi: clk-lsi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32000>;
-		};
-
-		clk_pclk3: clk-pclk3 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <104438965>;
-		};
-
-		clk_pclk4: clk-pclk4 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <133250000>;
-		};
-
-		clk_pll4_p: clk-pll4_p {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <50000000>;
-		};
-
-		clk_pll4_r: clk-pll4_r {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <99000000>;
-		};
-
-		clk_rtc_k: clk-rtc-k {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-		};
-	};
 
 	intc: interrupt-controller@a0021000 {
 		compatible = "arm,cortex-a7-gic";
@@ -154,7 +101,8 @@ uart4: serial@40010000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40010000 0x400>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_hsi>;
+			clocks = <&rcc UART4_K>;
+			resets = <&rcc UART4_R>;
 			status = "disabled";
 		};
 
@@ -169,7 +117,8 @@ dma1: dma-controller@48000000 {
 				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_pclk4>;
+			clocks = <&rcc DMA1>;
+			resets = <&rcc DMA1_R>;
 			#dma-cells = <4>;
 			st,mem2mem;
 			dma-requests = <8>;
@@ -186,7 +135,8 @@ dma2: dma-controller@48001000 {
 				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_pclk4>;
+			clocks = <&rcc DMA2>;
+			resets = <&rcc DMA2_R>;
 			#dma-cells = <4>;
 			st,mem2mem;
 			dma-requests = <8>;
@@ -195,13 +145,29 @@ dma2: dma-controller@48001000 {
 		dmamux1: dma-router@48002000 {
 			compatible = "st,stm32h7-dmamux";
 			reg = <0x48002000 0x40>;
-			clocks = <&clk_pclk4>;
+			clocks = <&rcc DMAMUX1>;
+			resets = <&rcc DMAMUX1_R>;
 			#dma-cells = <3>;
 			dma-masters = <&dma1 &dma2>;
 			dma-requests = <128>;
 			dma-channels = <16>;
 		};
 
+		rcc: rcc@50000000 {
+			compatible = "st,stm32mp13-rcc", "syscon";
+			reg = <0x50000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			clock-names = "hse", "hsi", "csi", "lse", "lsi";
+
+			clocks = <&scmi_clk CK_SCMI_HSE>,
+				 <&scmi_clk CK_SCMI_HSI>,
+				 <&scmi_clk CK_SCMI_CSI>,
+				 <&scmi_clk CK_SCMI_LSE>,
+				 <&scmi_clk CK_SCMI_LSI>;
+		};
+
 		exti: interrupt-controller@5000d000 {
 			compatible = "st,stm32mp13-exti", "syscon";
 			interrupt-controller;
@@ -212,14 +178,14 @@ exti: interrupt-controller@5000d000 {
 		syscfg: syscon@50020000 {
 			compatible = "st,stm32mp157-syscfg", "syscon";
 			reg = <0x50020000 0x400>;
-			clocks = <&clk_pclk3>;
+			clocks = <&rcc SYSCFG>;
 		};
 
 		mdma: dma-controller@58000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x58000000 0x1000>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_pclk4>;
+			clocks = <&rcc MDMA>;
 			#dma-cells = <5>;
 			dma-channels = <32>;
 			dma-requests = <48>;
@@ -231,8 +197,9 @@ sdmmc1: mmc@58005000 {
 			reg = <0x58005000 0x1000>, <0x58006000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cmd_irq";
-			clocks = <&clk_pll4_p>;
+			clocks = <&rcc SDMMC1_K>;
 			clock-names = "apb_pclk";
+			resets = <&rcc SDMMC1_R>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
 			max-frequency = <130000000>;
@@ -245,8 +212,9 @@ sdmmc2: mmc@58007000 {
 			reg = <0x58007000 0x1000>, <0x58008000 0x1000>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cmd_irq";
-			clocks = <&clk_pll4_p>;
+			clocks = <&rcc SDMMC2_K>;
 			clock-names = "apb_pclk";
+			resets = <&rcc SDMMC2_R>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
 			max-frequency = <130000000>;
@@ -256,7 +224,7 @@ sdmmc2: mmc@58007000 {
 		iwdg2: watchdog@5a002000 {
 			compatible = "st,stm32mp1-iwdg";
 			reg = <0x5a002000 0x400>;
-			clocks = <&clk_pclk4>, <&clk_lsi>;
+			clocks = <&rcc IWDG2>, <&scmi_clk CK_SCMI_LSI>;
 			clock-names = "pclk", "lsi";
 			status = "disabled";
 		};
@@ -265,7 +233,8 @@ rtc: rtc@5c004000 {
 			compatible = "st,stm32mp1-rtc";
 			reg = <0x5c004000 0x400>;
 			interrupts-extended = <&exti 19 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_pclk4>, <&clk_rtc_k>;
+			clocks = <&scmi_clk CK_SCMI_RTCAPB>,
+				 <&scmi_clk CK_SCMI_RTC>;
 			clock-names = "pclk", "rtc_ck";
 			status = "disabled";
 		};
@@ -306,7 +275,7 @@ gpioa: gpio@50002000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x0 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOA>;
 				st,bank-name = "GPIOA";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 0 16>;
@@ -318,7 +287,7 @@ gpiob: gpio@50003000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x1000 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOB>;
 				st,bank-name = "GPIOB";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 16 16>;
@@ -330,7 +299,7 @@ gpioc: gpio@50004000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x2000 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOC>;
 				st,bank-name = "GPIOC";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 32 16>;
@@ -342,7 +311,7 @@ gpiod: gpio@50005000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x3000 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOD>;
 				st,bank-name = "GPIOD";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 48 16>;
@@ -354,7 +323,7 @@ gpioe: gpio@50006000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x4000 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOE>;
 				st,bank-name = "GPIOE";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 64 16>;
@@ -366,7 +335,7 @@ gpiof: gpio@50007000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x5000 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOF>;
 				st,bank-name = "GPIOF";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 80 16>;
@@ -378,7 +347,7 @@ gpiog: gpio@50008000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x6000 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOG>;
 				st,bank-name = "GPIOG";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 96 16>;
@@ -390,7 +359,7 @@ gpioh: gpio@50009000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x7000 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOH>;
 				st,bank-name = "GPIOH";
 				ngpios = <15>;
 				gpio-ranges = <&pinctrl 0 112 15>;
@@ -402,7 +371,7 @@ gpioi: gpio@5000a000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x8000 0x400>;
-				clocks = <&clk_pclk4>;
+				clocks = <&rcc GPIOI>;
 				st,bank-name = "GPIOI";
 				ngpios = <8>;
 				gpio-ranges = <&pinctrl 0 128 8>;
diff --git a/arch/arm/boot/dts/stm32mp133.dtsi b/arch/arm/boot/dts/stm32mp133.dtsi
index 0fb1386257cf..531c263c9f46 100644
--- a/arch/arm/boot/dts/stm32mp133.dtsi
+++ b/arch/arm/boot/dts/stm32mp133.dtsi
@@ -15,7 +15,7 @@ m_can1: can@4400e000 {
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
-			clocks = <&clk_hse>, <&clk_pll4_r>;
+			clocks = <&scmi_clk CK_SCMI_HSE>, <&rcc FDCAN_K>;
 			clock-names = "hclk", "cclk";
 			bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
 			status = "disabled";
@@ -28,7 +28,7 @@ m_can2: can@4400f000 {
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
-			clocks = <&clk_hse>, <&clk_pll4_r>;
+			clocks = <&scmi_clk CK_SCMI_HSE>, <&rcc FDCAN_K>;
 			clock-names = "hclk", "cclk";
 			bosch,mram-cfg = <0x1400 0 0 32 0 0 2 2>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/stm32mp13xf.dtsi b/arch/arm/boot/dts/stm32mp13xf.dtsi
index fa6889e30591..4d00e7592882 100644
--- a/arch/arm/boot/dts/stm32mp13xf.dtsi
+++ b/arch/arm/boot/dts/stm32mp13xf.dtsi
@@ -10,7 +10,8 @@ cryp: crypto@54002000 {
 			compatible = "st,stm32mp1-cryp";
 			reg = <0x54002000 0x400>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_axi>;
+			clocks = <&rcc CRYP1>;
+			resets = <&rcc CRYP1_R>;
 			status = "disabled";
 		};
 	};
-- 
2.25.1

