Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E93D5A0421
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiHXWhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiHXWhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:37:11 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA974CE0;
        Wed, 24 Aug 2022 15:37:10 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 390DA1A13DE;
        Thu, 25 Aug 2022 00:37:09 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA7011A13D4;
        Thu, 25 Aug 2022 00:37:08 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 7F95340A9F;
        Wed, 24 Aug 2022 15:37:07 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Po Liu <po.liu@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 03/11] arm64: dts: ls1043a: use pcie aer/pme interrupts
Date:   Wed, 24 Aug 2022 17:36:54 -0500
Message-Id: <20220824223700.32442-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220824223700.32442-1-leoyang.li@nxp.com>
References: <20220824223700.32442-1-leoyang.li@nxp.com>
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

After the binding has been updated to include more specific interrupt
definition, update the dts to use the more specific interrupt names.

Signed-off-by: Po Liu <po.liu@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 3ba66b18de35..242fe8bfab17 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -883,9 +883,9 @@ pcie1: pcie@3400000 {
 			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
 			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 118 0x4>, /* controller interrupt */
-				     <0 117 0x4>; /* PME interrupt */
-			interrupt-names = "intr", "pme";
+			interrupts = <0 117 0x4>,
+				     <0 118 0x4>;
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -909,9 +909,9 @@ pcie2: pcie@3500000 {
 			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
 			      <0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 128 0x4>,
-				     <0 127 0x4>;
-			interrupt-names = "intr", "pme";
+			interrupts = <0 127 0x4>,
+				     <0 128 0x4>;
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -935,9 +935,9 @@ pcie3: pcie@3600000 {
 			reg = <0x00 0x03600000 0x0 0x00100000>, /* controller registers */
 			      <0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 162 0x4>,
-				     <0 161 0x4>;
-			interrupt-names = "intr", "pme";
+			interrupts = <0 161 0x4>,
+				     <0 162 0x4>;
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.37.1

