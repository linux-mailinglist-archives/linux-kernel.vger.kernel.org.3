Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17146DB86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbhLHSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:52:43 -0500
Received: from ixit.cz ([94.230.151.217]:33416 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhLHSw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:52:28 -0500
Received: from localhost.localdomain (unknown [213.151.89.154])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D3D3B21F5E;
        Wed,  8 Dec 2021 19:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1638989331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FLGpTFcyBc+SpF4QfsWcJfjJHCR3UG+w8At8T7vAVBs=;
        b=tADy0WX8QOBigA8V1uEb1rZRgGmg0UevHzuDCSWsdBggs/3sZCnwFru1LTtly/Zp0DZ8g9
        K4p96+t1Upd4kKEZRF/tLbiB64Z0tg3kHg91U+VGEbYAX9ivDfOE8izt4XpdtaQXI73s6x
        MxXLJZKExO871+agKA2JvscbSPfMSbo=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: xilinx: dts: drop legacy property #stream-id-cells
Date:   Wed,  8 Dec 2021 19:48:45 +0100
Message-Id: <20211208184846.101166-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property #stream-id-cells is legacy leftover and isn't currently
documented nor used.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - split qcom and xilinx
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 28 --------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 74e66443e4ce..493719f71fb5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -262,7 +262,6 @@ fpd_dma_chan1: dma@fd500000 {
 			interrupts = <0 124 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x14e8>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
@@ -275,7 +274,6 @@ fpd_dma_chan2: dma@fd510000 {
 			interrupts = <0 125 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x14e9>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
@@ -288,7 +286,6 @@ fpd_dma_chan3: dma@fd520000 {
 			interrupts = <0 126 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x14ea>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
@@ -301,7 +298,6 @@ fpd_dma_chan4: dma@fd530000 {
 			interrupts = <0 127 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x14eb>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
@@ -314,7 +310,6 @@ fpd_dma_chan5: dma@fd540000 {
 			interrupts = <0 128 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x14ec>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
@@ -327,7 +322,6 @@ fpd_dma_chan6: dma@fd550000 {
 			interrupts = <0 129 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x14ed>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
@@ -340,7 +334,6 @@ fpd_dma_chan7: dma@fd560000 {
 			interrupts = <0 130 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x14ee>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
@@ -353,7 +346,6 @@ fpd_dma_chan8: dma@fd570000 {
 			interrupts = <0 131 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <128>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x14ef>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
@@ -383,7 +375,6 @@ lpd_dma_chan1: dma@ffa80000 {
 			interrupts = <0 77 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x868>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
@@ -396,7 +387,6 @@ lpd_dma_chan2: dma@ffa90000 {
 			interrupts = <0 78 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x869>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
@@ -409,7 +399,6 @@ lpd_dma_chan3: dma@ffaa0000 {
 			interrupts = <0 79 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x86a>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
@@ -422,7 +411,6 @@ lpd_dma_chan4: dma@ffab0000 {
 			interrupts = <0 80 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x86b>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
@@ -435,7 +423,6 @@ lpd_dma_chan5: dma@ffac0000 {
 			interrupts = <0 81 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x86c>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
@@ -448,7 +435,6 @@ lpd_dma_chan6: dma@ffad0000 {
 			interrupts = <0 82 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x86d>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
@@ -461,7 +447,6 @@ lpd_dma_chan7: dma@ffae0000 {
 			interrupts = <0 83 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x86e>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
@@ -474,7 +459,6 @@ lpd_dma_chan8: dma@ffaf0000 {
 			interrupts = <0 84 4>;
 			clock-names = "clk_main", "clk_apb";
 			xlnx,bus-width = <64>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x86f>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
@@ -495,7 +479,6 @@ nand0: nand-controller@ff100000 {
 			interrupts = <0 14 4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x872>;
 			power-domains = <&zynqmp_firmware PD_NAND>;
 		};
@@ -509,7 +492,6 @@ gem0: ethernet@ff0b0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x874>;
 			power-domains = <&zynqmp_firmware PD_ETH_0>;
 		};
@@ -523,7 +505,6 @@ gem1: ethernet@ff0c0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x875>;
 			power-domains = <&zynqmp_firmware PD_ETH_1>;
 		};
@@ -537,7 +518,6 @@ gem2: ethernet@ff0d0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x876>;
 			power-domains = <&zynqmp_firmware PD_ETH_2>;
 		};
@@ -551,7 +531,6 @@ gem3: ethernet@ff0e0000 {
 			clock-names = "pclk", "hclk", "tx_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x877>;
 			power-domains = <&zynqmp_firmware PD_ETH_3>;
 		};
@@ -621,7 +600,6 @@ pcie: pcie@fd0e0000 {
 					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
 					<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
 					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x4d0>;
 			power-domains = <&zynqmp_firmware PD_PCIE>;
 			pcie_intc: legacy-interrupt-controller {
@@ -642,7 +620,6 @@ qspi: spi@ff0f0000 {
 			      <0x0 0xc0000000 0x0 0x8000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x873>;
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 		};
@@ -674,7 +651,6 @@ sata: ahci@fd0c0000 {
 			interrupts = <0 133 4>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
-			#stream-id-cells = <4>;
 			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
 				 <&smmu 0x4c2>, <&smmu 0x4c3>;
 		};
@@ -686,7 +662,6 @@ sdhci0: mmc@ff160000 {
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x870>;
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd0", "clk_in_sd0";
@@ -700,7 +675,6 @@ sdhci1: mmc@ff170000 {
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
-			#stream-id-cells = <1>;
 			iommus = <&smmu 0x871>;
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd1", "clk_in_sd1";
@@ -825,7 +799,6 @@ dwc3_0: usb@fe200000 {
 				interrupt-parent = <&gic>;
 				interrupt-names = "dwc_usb3", "otg";
 				interrupts = <0 65 4>, <0 69 4>;
-				#stream-id-cells = <1>;
 				iommus = <&smmu 0x860>;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				/* dma-coherent; */
@@ -852,7 +825,6 @@ dwc3_1: usb@fe300000 {
 				interrupt-parent = <&gic>;
 				interrupt-names = "dwc_usb3", "otg";
 				interrupts = <0 70 4>, <0 74 4>;
-				#stream-id-cells = <1>;
 				iommus = <&smmu 0x861>;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				/* dma-coherent; */
-- 
2.33.0

