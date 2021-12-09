Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B5446E88D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhLIMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:40:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:51435 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLIMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639053407; x=1670589407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LT7PgHIrK21v+VPZ+8bTrxj1+AbSS6gS6s49jHR4k9s=;
  b=jCZEnlrB25rrsj8+GDWM4c94LQxvDDSzgfVJkKUw9Jml4x5MHb9DfymA
   0hncaecPrQvUsQxJ75VFVy+YU8utB1/r6U2LIXkNJLw1moOf/29OOK/H9
   aPSp7ZlxuRvOn/jlWAYP+xw5a/y5sXyPTiOQZvuA35H/+k7YGLP9nsMMT
   VXlO9n9c749eYnDgw+zxNrF9oJ5g6+JfrjrnWEvK5mIiA5XwhxHA7s+bm
   oSiPnV9udv8+w8OS2YdP5Vb/VO8ShReAtpmJ4SpPsB5+6BQpFU1q7e1G9
   dzTuajt79brMCwRQNMU5YjNVKxmTzudDwOUttFSns2TYYLFTq477p3MzR
   g==;
IronPort-SDR: pxu94DQpWG2uT4PlpG2rDiTLisduxfKbRV/5dXHpACKvOr3Hy6yGrHT04c/Ialf4FyQ8aClyF1
 8+S8AecPwF6ze5MNYUwjFETEW/R3NaQACXWyHJVMDkxV1jXaUI8a5FG0iViVvxn0Of8hsFoT0n
 o9khmLoM2psbtao9FZxNm3xoBr8+eBXgb3QHnCP7ZAv922MO4o3ULBeTYb+RFHNmXon9JfEVOy
 X0bdia+yyds7nbm6L5N5kXjBjSXo136njyRDQl2ywF6EvftJGOdl7HsIkucNX2je7wNG1HWOVo
 KYvXJosq9dETuxB72RFm7Stl
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="154857917"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 05:36:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 05:36:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 05:36:44 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: sama7g5: Add QSPI nodes
Date:   Thu, 9 Dec 2021 14:36:42 +0200
Message-ID: <20211209123643.341892-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sama7g5 embedds 2 instances of QSPI controller:
1/ OSPI0 Supporting Up to 200 MHz DDR. Octal, TwinQuad, Hyperflash
   and OctaFlash Protocols Supported.
2/ QSPI1 Supporting Up to 90 MHz DDR/133 MHz SDR.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 7039311bf678..eddcfbf4d223 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -181,6 +181,36 @@ tcb1: timer@e0800000 {
 			clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 		};
 
+		qspi0: spi@e080c000 {
+			compatible = "microchip,sama7g5-ospi";
+			reg = <0xe080c000 0x400>, <0x20000000 0x10000000>;
+			reg-names = "qspi_base", "qspi_mmap";
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(41)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(40)>;
+			dma-names = "tx", "rx";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 78>, <&pmc PMC_TYPE_GCK 78>;
+			clock-names = "pclk", "gclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		qspi1: spi@e0810000 {
+			compatible = "microchip,sama7g5-qspi";
+			reg = <0xe0810000 0x400>, <0x30000000 0x10000000>;
+			reg-names = "qspi_base", "qspi_mmap";
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(43)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(42)>;
+			dma-names = "tx", "rx";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 79>, <&pmc PMC_TYPE_GCK 79>;
+			clock-names = "pclk", "gclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		adc: adc@e1000000 {
 			compatible = "microchip,sama7g5-adc";
 			reg = <0xe1000000 0x200>;
-- 
2.25.1

