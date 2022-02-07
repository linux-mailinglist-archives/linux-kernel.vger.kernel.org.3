Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941DE4AB90B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbiBGKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiBGKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:47:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F0C043181;
        Mon,  7 Feb 2022 02:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644230838; x=1675766838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8+dFrGD5ia9/wAG2M41Df0aqZPqFKd4Zz5q7iDj1TDw=;
  b=ZryZWCMvk3cd6ROBxC8+rRujXZeMRszPnRXtp5CVCHp3eT2ty3zqxqbF
   s57k/GFcfaJEVWCSE9I+YcxP3xrNj7bW/FT0xiud/t0cvNLysuWfsYrta
   GsYk7EZii0oUGogAfgi27FiV63ld5LF68UyEtjK/+EAO1krfDYxpahCsa
   DV/Y374l9Jmc7W+6vrPgb59mgwvqxRg5i4pHskN9c3YbjWEUX607BrCkZ
   EaFhrMaFak1FhPtlD7TW9L5oWCyiHDtbOfFrJ6aOrjAKIm7xBUgVRwMyr
   3beap0itxfFGZFc9Xp3cVBm4jTB6E9INGmeHHmOI2GnkJqoEtKiLiFMdD
   w==;
IronPort-SDR: 1CtX/c7B6xlWtGR3wpzrSz21W2TVEZqGH4uJhjTln2ksagqdX7ERHcBMABDWWFXUhPvFOPijhM
 gl8/ggs2GUpAJDO/O0hv9xwojtxxO0d2060iO+vZREcZNwyczR+yPcZfd07zp7eNDJAlsb2pxY
 tU2pTs04Onvxcyf4tjXD9eZMgSnUDRri5k+QHrSxdNNgILa87JMaD0gPuXP0Qy5g0cfeyIYa5I
 l41yz0ptav0rwX4r0bXHEv/tjG8qjk2be9mrSc1t1yIsDzswVoGquie/BzRVQzZZTUuxcwpeK5
 f9NP5ACqdAOEBMe9ux9Ol3Fc
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="84882724"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2022 03:47:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Feb 2022 03:47:17 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Feb 2022 03:47:15 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3] ARM: dts: at91: sama7g5: Add crypto nodes
Date:   Mon, 7 Feb 2022 12:47:13 +0200
Message-ID: <20220207104713.87284-1-tudor.ambarus@microchip.com>
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
index 7972cb8c2562..8f0c8f42257f 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -393,6 +393,27 @@ pit64b1: timer@e1804000 {
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
+		};
+
 		flx0: flexcom@e1818000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe1818000 0x200>;
@@ -475,6 +496,17 @@ trng: rng@e2010000 {
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
+		};
+
 		flx4: flexcom@e2018000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2018000 0x200>;
-- 
2.25.1

