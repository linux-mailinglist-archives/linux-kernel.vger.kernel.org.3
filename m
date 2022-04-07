Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F544F7D6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbiDGLBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244652AbiDGLBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:01:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE40512C6EE;
        Thu,  7 Apr 2022 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649329152; x=1680865152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KwvSJSFlJAxuW3H3oWRDTORiHi4D6agtNPl+L//vHlM=;
  b=jzVf6RtMygjEEn32RME24N/snpYauWUECE6UwBnPd+VumbmkGfSWeW9e
   zyBqjr37NGsm31qVyO5s/8lhKUzjoyhpR/xRuEuj1urNqCpu222PJurOt
   nMMhjbImUUFzzsFkzG6NX8N7UzNa+VRC6P8SGVDKhPIDeJqyXRl9uTLU8
   UNacbL7xzP73Ai5U4/S9Gd6diNXCgXC5/6L2B5/C0Sv7d1LcUG022rdZo
   9KnVbSR2BPvP84dXBp7psNk7zzQnU0m8AXKfpLD+e8EvrAj/IoWMt/Cr+
   imQozTDzLU+flxyTWftAttMcF2ZD1yK+zWBJQALdUwwybPtvQAXob+nTt
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="159274389"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 03:59:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 03:59:10 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 03:59:05 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <olof@lixom.net>,
        <soc@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <tudor.ambarus@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH 1/2] ARM: dts: lan966x: Add QSPI nodes
Date:   Thu, 7 Apr 2022 16:28:34 +0530
Message-ID: <20220407105835.10962-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407105835.10962-1-kavyasree.kotagiri@microchip.com>
References: <20220407105835.10962-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966x SoC supports 3 instances of QSPI.
Data and clock of qspi0, qspi1, qspi2 works upto 100Mhz.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 48 ++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 7d2869648050..b3c687db0aea 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -196,6 +196,54 @@
 			status = "disabled";
 		};
 
+		qspi0: spi@e0804000 {
+			compatible = "microchip,lan966x-qspi";
+			reg = <0xe0804000 0x100>,
+			      <0x20000000 0x08000000>;
+			reg-names = "qspi_base", "qspi_mmap";
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks GCK_ID_QSPI0>;
+			clock-names = "gclk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(1)>;
+			dma-names = "rx", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		qspi1: spi@e0054000 {
+			compatible = "microchip,lan966x-qspi";
+			reg = <0xe0054000 0x100>,
+			      <0x40000000 0x08000000>;
+			reg-names = "qspi_base", "qspi_mmap";
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks GCK_ID_QSPI1>;
+			clock-names = "gclk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(15)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(16)>;
+			dma-names = "rx", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		qspi2: spi@e0834000 {
+			compatible = "microchip,lan966x-qspi";
+			reg = <0xe0834000 0x100>,
+			      <0x30000000 0x08000000>;
+			reg-names = "qspi_base", "qspi_mmap";
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks GCK_ID_QSPI2>;
+			clock-names = "gclk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(17)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(18)>;
+			dma-names = "rx", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		can0: can@e081c000 {
 			compatible = "bosch,m_can";
 			reg = <0xe081c000 0xfc>, <0x00100000 0x4000>;
-- 
2.17.1

