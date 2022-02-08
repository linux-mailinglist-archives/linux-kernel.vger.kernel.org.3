Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7184AD72B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiBHLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356734AbiBHK4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:56:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F44C03FEC0;
        Tue,  8 Feb 2022 02:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644317812; x=1675853812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S8axRtcfBJDRvXNJoMKcZltsyqp7OihG7CRGPeue6xM=;
  b=e/ryt5cb2YaVsIqdf1Fz2gSMPoMTRETiKsf0viY2md9uvUddwHjMjrrc
   3Dz3/G1K3g0JwbctMgKcFMM/+bYJHbgwWF+nJPh4x54vJU64GhjPn0umv
   YbWZ+gj/LBUlo2CLJ99V9TkcFZh20pax7NIox0kFg7y1JfhtBrqt0vEpW
   7Re3yqZQ04a5wQzQwSzDVihelD3NBFEktE/yJQM5ZwVSe15HORKyTf9wX
   OTgwSU5WkVCtB1i3P1d+8xZ31zhDDNQBEfElBJKrb174sjDcIIh6GktJB
   foDlIAHA2cXybfzbJJvzqC7iOpM3/1Jcafo+VNjhoxxx0EHjdKym2ivji
   g==;
IronPort-SDR: oSZWL6gLyBR6i8c3UCQUQLO7+q7dHOhWWtbftQ55vQWnLds4v3IrbiQpDSqKTexzGCtZT6OM1m
 nwTAnKwL2WoXiwfrkdMDdmsRuJuOBbLJcMhGcRuW730KtEljnP8ElYD9uzEFHTRuXhsrCUCoAY
 yS0ldRmNbq/+QJ1uB62gwfCVcwvcMjjN11KZ5vPeNeiiJSihwKx5jr2d7K/FW4FNsnC5xQdafP
 ijK5WedzkRo75uV9/oWk0lm0mRx2GFmiAm521L9TamlVu6/bHqKPxvWDe5CWB3Zxi2W95d1Hih
 2PX2EfVxWt4+6YvlsAf0PNy+
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="85018576"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 03:56:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 03:56:51 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 03:56:48 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kavyasree.kotagiri@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v4] ARM: dts: at91: sama7g5: Add crypto nodes
Date:   Tue, 8 Feb 2022 12:56:46 +0200
Message-ID: <20220208105646.226623-1-tudor.ambarus@microchip.com>
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

Describe and enable the AES, SHA and TDES crypto IPs. Tested with the
extra run-time self tests of the registered crypto algorithms.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
v4: use the generic "crypto" node name for all the crypto nodes,
as recommended by the DT specification. Add Claudiu's R-b tag.

v3: remove explicit status = "okay", as it's already the default case
when not specified at all.

v2:
- add label to the tdes node
- update commit description and specify testing method
- put clocks and clock-names properties before dmas and dma-names
  because the clocks are mandatory, while DMA is optional for TDES and SHA

 arch/arm/boot/dts/sama7g5.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 7972cb8c2562..2453a6901313 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -393,6 +393,27 @@ pit64b1: timer@e1804000 {
 			clock-names = "pclk", "gclk";
 		};
 
+		aes: crypto@e1810000 {
+			compatible = "atmel,at91sam9g46-aes";
+			reg = <0xe1810000 0x100>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
+			clock-names = "aes_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(1)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(2)>;
+			dma-names = "tx", "rx";
+		};
+
+		sha: crypto@e1814000 {
+			compatible = "atmel,at91sam9g46-sha";
+			reg = <0xe1814000 0x100>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 83>;
+			clock-names = "sha_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(48)>;
+			dma-names = "tx";
+		};
+
 		flx0: flexcom@e1818000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe1818000 0x200>;
@@ -475,6 +496,17 @@ trng: rng@e2010000 {
 			status = "disabled";
 		};
 
+		tdes: crypto@e2014000 {
+			compatible = "atmel,at91sam9g46-tdes";
+			reg = <0xe2014000 0x100>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 96>;
+			clock-names = "tdes_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(54)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(53)>;
+			dma-names = "tx", "rx";
+		};
+
 		flx4: flexcom@e2018000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2018000 0x200>;
-- 
2.25.1

