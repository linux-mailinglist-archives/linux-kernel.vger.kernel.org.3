Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B134AB423
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbiBGFwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350686AbiBGDnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:43:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B629C061A73;
        Sun,  6 Feb 2022 19:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644205389; x=1675741389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jyHTg8lc0rGJjYDbvRpmmpXq2f0nIZ3DZxj0wHryZ9Q=;
  b=XNxksdeDNzMQxwRnR8fdySwpNTZnutTnBqqVnSUwLGNGpFc98nds2K1u
   kYF5TygrtQTF19+qeDVTT+elGKJCKRBvY5RKrGQHJFyfu81t3Iu8AwFWm
   O3nNUIOSFA/k+316XXmH9SAA2B0DLTLVPiZVXOMoQkkSN3hjHrSvFKlaJ
   bDBZFeB57PfY96UZaYYOIU93/80zDKOkYquaBYEyja/1eFw8v1/px7bs5
   b8rK2QjKfb1O+TL9i56p+Qi2h4WH2+7lZfzjRgfVLSjzbV0u/rjBHcslp
   Y2JtBRDSD0S3U7mAbsWGVxDo2cs2XvzK3dSpO+B54fJmJQjh/Hvgv0IeL
   g==;
IronPort-SDR: LFwX+2kkz/dSAtaaFwAsKjKNjhNXpD8tg4DD6rnX5C3HNHw1dOUYa5xbav7Bvz/WhtZBK6exmJ
 z9NQ3DU+4a9uScj/kPLDmU+REej+WVxGbWJcVQZubKU6vLjf2RQ2PMRWNGaJbTTqclH7nsxTmQ
 Q/v+h90rszuKM9VmhLhLeP3d24XM3ULzEyP2bs5V9G9VrUBkBfOWiLaJ94f7wGYHM9fTWYjh3X
 xCCCeYsTDdKg7RQ/4aIxaONT3digBrCqNnjE1OKhOMHSa3UZs5uZRnxM/w+pIpe/hq02uhTWJj
 lKkmPoQV3vcnoTlRvngpo6Uy
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="161282083"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2022 20:43:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 6 Feb 2022 20:43:08 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sun, 6 Feb 2022 20:43:06 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2] ARM: dts: at91: sama7g5: Add crypto nodes
Date:   Mon, 7 Feb 2022 05:43:03 +0200
Message-ID: <20220207034303.72827-1-tudor.ambarus@microchip.com>
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
---
v2:
- add label to the tdes node
- update commit description and specify testing method
- put clocks and clock-names properties before dmas and dma-names
  because the clocks are mandatory, while DMA is optional for TDES and SHA

 arch/arm/boot/dts/sama7g5.dtsi | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 7972cb8c2562..a87f498cf098 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -393,6 +393,29 @@ pit64b1: timer@e1804000 {
 			clock-names = "pclk", "gclk";
 		};
 
+		aes: aes@e1810000 {
+			compatible = "atmel,at91sam9g46-aes";
+			reg = <0xe1810000 0x100>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
+			clock-names = "aes_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(1)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(2)>;
+			dma-names = "tx", "rx";
+			status = "okay";
+		};
+
+		sha: sha@e1814000 {
+			compatible = "atmel,at91sam9g46-sha";
+			reg = <0xe1814000 0x100>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 83>;
+			clock-names = "sha_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(48)>;
+			dma-names = "tx";
+			status = "okay";
+		};
+
 		flx0: flexcom@e1818000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe1818000 0x200>;
@@ -475,6 +498,18 @@ trng: rng@e2010000 {
 			status = "disabled";
 		};
 
+		tdes: tdes@e2014000 {
+			compatible = "atmel,at91sam9g46-tdes";
+			reg = <0xe2014000 0x100>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 96>;
+			clock-names = "tdes_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(54)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(53)>;
+			dma-names = "tx", "rx";
+			status = "okay";
+		};
+
 		flx4: flexcom@e2018000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2018000 0x200>;
-- 
2.25.1

