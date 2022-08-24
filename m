Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933E05A0477
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiHXXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiHXXMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:12:15 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2A58000B;
        Wed, 24 Aug 2022 16:12:13 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7100C2014E8;
        Thu, 25 Aug 2022 01:12:12 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BED42014DD;
        Thu, 25 Aug 2022 01:12:12 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id E4AD24060D;
        Wed, 24 Aug 2022 16:12:09 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 3/9] arm64: dts: ls1046a: Add big-endian property for PCIe nodes
Date:   Wed, 24 Aug 2022 18:11:54 -0500
Message-Id: <20220824231200.494-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220824231200.494-1-leoyang.li@nxp.com>
References: <20220824231200.494-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the big-endian property for LS1046A PCIe nodes for accessing PEX_LUT
and PF register block.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index fce3c6401653..f8e8c1415c02 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -805,6 +805,7 @@ pcie1: pcie@3400000 {
 					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -817,6 +818,7 @@ pcie_ep1: pcie_ep@3400000 {
 			interrupt-names = "pme";
 			num-ib-windows = <6>;
 			num-ob-windows = <8>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -843,6 +845,7 @@ pcie2: pcie@3500000 {
 					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -855,6 +858,7 @@ pcie_ep2: pcie_ep@3500000 {
 			interrupt-names = "pme";
 			num-ib-windows = <6>;
 			num-ob-windows = <8>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -881,6 +885,7 @@ pcie3: pcie@3600000 {
 					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -893,6 +898,7 @@ pcie_ep3: pcie_ep@3600000 {
 			interrupt-names = "pme";
 			num-ib-windows = <6>;
 			num-ob-windows = <8>;
+			big-endian;
 			status = "disabled";
 		};
 
-- 
2.37.1

