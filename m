Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3844AD76A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiBHLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356919AbiBHLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:12:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312CC03FEC0;
        Tue,  8 Feb 2022 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644318753; x=1675854753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=05urutNyZTswWjeb7wt10gcHvbrqmnvKF+7rarJvQ/A=;
  b=xvVhUBBzGYR9kkK736rpgKjTVKRjXTiBQER1+EHu4G1fb93DRG0bo7eZ
   n9LDLwF6dAR3FK3qOqVZmu1UAyVlzG5k8+sC8BFXgh+eXwKVLMj53JAcv
   XCocag2SMHy1mfgAzB//Tc0VTtEhHY+CFUnQeA7ZmFFZm9q4K9ZsOcRYQ
   IcKOMGSZKBxHLeY6SEC5qlnUUQC92e7yzLYiO+S4clE7I5wS706lKUcAA
   /kjluaVw43dJM1Mj6bfnzvqpqiqWfp0WSQxz2hjCP3xQbGqG3p09ok8Gm
   uY1e41MwmRbd7wk2u41zuDkeRPRq49pPM654CjEC4OgTbrgHaDPWgDrMF
   w==;
IronPort-SDR: Xeleq6+aLlK7L3OKMq+TGS3K1Izyc+7b2jyNkcFWtglhpbiCwdOmdWJ3kFn0UneLoX9y9evo8p
 uhIo+xGvfeK7HBDd8RbXPtjDXqeZLoUaVOO4TzggdMTrsuPlva8e/LEuRjHPiKOWdR6GTgnu1C
 0gHExuuGh2rvKAwCCTTUbXEKm2Qg4XShDXC/xWZnIUXlz+to8gsb/5N02riCFsjxOSFP/hHeA6
 0wGGEN2ZtudeHeEsE84ANFTm0y7eyHTV+7/RuaYNazGKDa3GLtCzgOZOscVv1a29agOls7KJCp
 N9WpAVM0DyBCuBANNGbXH08g
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="161461447"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 04:12:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 04:12:32 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 04:12:29 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kavyasree.kotagiri@microchip.com>,
        <krzysztof.kozlowski@canonical.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: Use the generic "crypto" node name for the crypto IPs
Date:   Tue, 8 Feb 2022 13:12:25 +0200
Message-ID: <20220208111225.234685-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The DT specification recommeds that:
"The name of a node should be somewhat generic, reflecting the function of
the device and not its precise programming model. If appropriate, the name
should be one of the following choices:"
"crypto" being the recommendation for the crypto nodes. Follow the DT
recommendation and use the generic "crypto" node name for the at91 crypto
IPs. While at this, add labels to the crypto nodes where they missed, for
easier reference purposes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/sam9x60.dtsi | 6 +++---
 arch/arm/boot/dts/sama5d2.dtsi | 6 +++---
 arch/arm/boot/dts/sama5d3.dtsi | 6 +++---
 arch/arm/boot/dts/sama5d4.dtsi | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index ec45ced3cde6..ec686f617ec7 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -270,7 +270,7 @@ pit64b: timer@f0028000 {
 				clock-names = "pclk", "gclk";
 			};
 
-			sha: sha@f002c000 {
+			sha: crypto@f002c000 {
 				compatible = "atmel,at91sam9g46-sha";
 				reg = <0xf002c000 0x100>;
 				interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -291,7 +291,7 @@ trng: trng@f0030000 {
 				status = "okay";
 			};
 
-			aes: aes@f0034000 {
+			aes: crypto@f0034000 {
 				compatible = "atmel,at91sam9g46-aes";
 				reg = <0xf0034000 0x100>;
 				interrupts = <39 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -307,7 +307,7 @@ AT91_XDMAC_DT_PERID(32))>,
 				status = "okay";
 			};
 
-			tdes: tdes@f0038000 {
+			tdes: crypto@f0038000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xf0038000 0x100>;
 				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index c700c3b19e4c..51e80611aa02 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -306,7 +306,7 @@ qspi1: spi@f0024000 {
 				status = "disabled";
 			};
 
-			sha@f0028000 {
+			sha: crypto@f0028000 {
 				compatible = "atmel,at91sam9g46-sha";
 				reg = <0xf0028000 0x100>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -319,7 +319,7 @@ sha@f0028000 {
 				status = "okay";
 			};
 
-			aes@f002c000 {
+			aes: crypto@f002c000 {
 				compatible = "atmel,at91sam9g46-aes";
 				reg = <0xf002c000 0x100>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -1084,7 +1084,7 @@ pioBU: secumod@fc040000 {
 				#gpio-cells = <2>;
 			};
 
-			tdes@fc044000 {
+			tdes: crypto@fc044000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xfc044000 0x100>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index d1841bffe3c5..8fa423c52592 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -381,7 +381,7 @@ usart3: serial@f8024000 {
 				status = "disabled";
 			};
 
-			sha@f8034000 {
+			sha: crypto@f8034000 {
 				compatible = "atmel,at91sam9g46-sha";
 				reg = <0xf8034000 0x100>;
 				interrupts = <42 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -391,7 +391,7 @@ sha@f8034000 {
 				clock-names = "sha_clk";
 			};
 
-			aes@f8038000 {
+			aes: crypto@f8038000 {
 				compatible = "atmel,at91sam9g46-aes";
 				reg = <0xf8038000 0x100>;
 				interrupts = <43 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -402,7 +402,7 @@ aes@f8038000 {
 				clock-names = "aes_clk";
 			};
 
-			tdes@f803c000 {
+			tdes: crypto@f803c000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xf803c000 0x100>;
 				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index f6e3e6f57252..1dff79a29012 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -673,7 +673,7 @@ adc0: adc@fc034000 {
 				status = "disabled";
 			};
 
-			aes@fc044000 {
+			aes: crypto@fc044000 {
 				compatible = "atmel,at91sam9g46-aes";
 				reg = <0xfc044000 0x100>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -687,7 +687,7 @@ aes@fc044000 {
 				status = "okay";
 			};
 
-			tdes@fc04c000 {
+			tdes: crypto@fc04c000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xfc04c000 0x100>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -701,7 +701,7 @@ tdes@fc04c000 {
 				status = "okay";
 			};
 
-			sha@fc050000 {
+			sha: crypto@fc050000 {
 				compatible = "atmel,at91sam9g46-sha";
 				reg = <0xfc050000 0x100>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.25.1

