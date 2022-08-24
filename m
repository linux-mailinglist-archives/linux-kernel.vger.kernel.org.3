Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDC15A0476
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiHXXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiHXXMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:12:12 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28C7FFB1;
        Wed, 24 Aug 2022 16:12:11 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 542FC2014E3;
        Thu, 25 Aug 2022 01:12:10 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 117A72014DD;
        Thu, 25 Aug 2022 01:12:10 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 01B1D40AA2;
        Wed, 24 Aug 2022 16:12:08 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 2/9] arm64: dts: ls1046a: Add the PME interrupt to PCIe EP nodes
Date:   Wed, 24 Aug 2022 18:11:53 -0500
Message-Id: <20220824231200.494-3-leoyang.li@nxp.com>
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

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add the PME interrupt property to the PCIe EP nodes.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index ddae3cb0a977..fce3c6401653 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -813,6 +813,8 @@ pcie_ep1: pcie_ep@3400000 {
 			reg = <0x00 0x03400000 0x0 0x00100000>,
 			      <0x40 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
 			num-ib-windows = <6>;
 			num-ob-windows = <8>;
 			status = "disabled";
@@ -849,6 +851,8 @@ pcie_ep2: pcie_ep@3500000 {
 			reg = <0x00 0x03500000 0x0 0x00100000>,
 			      <0x48 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
 			num-ib-windows = <6>;
 			num-ob-windows = <8>;
 			status = "disabled";
@@ -885,6 +889,8 @@ pcie_ep3: pcie_ep@3600000 {
 			reg = <0x00 0x03600000 0x0 0x00100000>,
 			      <0x50 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
 			num-ib-windows = <6>;
 			num-ob-windows = <8>;
 			status = "disabled";
-- 
2.37.1

