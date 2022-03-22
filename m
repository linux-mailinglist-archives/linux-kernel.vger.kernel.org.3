Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050D64E36A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiCVCai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiCVCae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:30:34 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330F3BE8AC;
        Mon, 21 Mar 2022 19:28:55 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D404420132D;
        Tue, 22 Mar 2022 03:28:53 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 927DB20022E;
        Tue, 22 Mar 2022 03:28:53 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.145])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 3A5184028F;
        Mon, 21 Mar 2022 19:28:52 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] powerpc/fsl: update ifc node name to be memory-controller
Date:   Mon, 21 Mar 2022 21:28:18 -0500
Message-Id: <20220322022818.9860-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220322022818.9860-1-leoyang.li@nxp.com>
References: <20220322022818.9860-1-leoyang.li@nxp.com>
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

Update the node name to be align with latest binding.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/powerpc/boot/dts/fsl/bsc9131rdb.dts    | 2 +-
 arch/powerpc/boot/dts/fsl/bsc9132qds.dts    | 2 +-
 arch/powerpc/boot/dts/fsl/c293pcie.dts      | 2 +-
 arch/powerpc/boot/dts/fsl/p1010rdb_32b.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p1010rdb_36b.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/bsc9131rdb.dts b/arch/powerpc/boot/dts/fsl/bsc9131rdb.dts
index 8da984251abc..0ba86a6dce1b 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9131rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/bsc9131rdb.dts
@@ -15,7 +15,7 @@ memory {
 		device_type = "memory";
 	};
 
-	board_ifc: ifc: ifc@ff71e000 {
+	board_ifc: ifc: memory-controller@ff71e000 {
 		/* NAND Flash on board */
 		ranges = <0x0 0x0 0x0 0xff800000 0x00004000>;
 		reg = <0x0 0xff71e000 0x0 0x2000>;
diff --git a/arch/powerpc/boot/dts/fsl/bsc9132qds.dts b/arch/powerpc/boot/dts/fsl/bsc9132qds.dts
index 7cb2158dfe58..ce642e879a1b 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9132qds.dts
+++ b/arch/powerpc/boot/dts/fsl/bsc9132qds.dts
@@ -15,7 +15,7 @@ memory {
 		device_type = "memory";
 	};
 
-	ifc: ifc@ff71e000 {
+	ifc: memory-controller@ff71e000 {
 		/* NOR, NAND Flash on board */
 		ranges = <0x0 0x0 0x0 0x88000000 0x08000000
 			  0x1 0x0 0x0 0xff800000 0x00010000>;
diff --git a/arch/powerpc/boot/dts/fsl/c293pcie.dts b/arch/powerpc/boot/dts/fsl/c293pcie.dts
index 5e905e0857cf..e2fdac2ed420 100644
--- a/arch/powerpc/boot/dts/fsl/c293pcie.dts
+++ b/arch/powerpc/boot/dts/fsl/c293pcie.dts
@@ -42,7 +42,7 @@ memory {
 		device_type = "memory";
 	};
 
-	ifc: ifc@fffe1e000 {
+	ifc: memory-controller@fffe1e000 {
 		reg = <0xf 0xffe1e000 0 0x2000>;
 		ranges = <0x0 0x0 0xf 0xec000000 0x04000000
 			  0x1 0x0 0xf 0xff800000 0x00010000
diff --git a/arch/powerpc/boot/dts/fsl/p1010rdb_32b.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb_32b.dtsi
index fdc19aab2f70..583a6cd05079 100644
--- a/arch/powerpc/boot/dts/fsl/p1010rdb_32b.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb_32b.dtsi
@@ -36,7 +36,7 @@ memory {
 	device_type = "memory";
 };
 
-board_ifc: ifc: ifc@ffe1e000 {
+board_ifc: ifc: memory-controller@ffe1e000 {
 	/* NOR, NAND Flashes and CPLD on board */
 	ranges = <0x0 0x0 0x0 0xee000000 0x02000000
 		  0x1 0x0 0x0 0xff800000 0x00010000
diff --git a/arch/powerpc/boot/dts/fsl/p1010rdb_36b.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb_36b.dtsi
index de2fceed4f79..4d41efe0038f 100644
--- a/arch/powerpc/boot/dts/fsl/p1010rdb_36b.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb_36b.dtsi
@@ -36,7 +36,7 @@ memory {
 	device_type = "memory";
 };
 
-board_ifc: ifc: ifc@fffe1e000 {
+board_ifc: ifc: memory-controller@fffe1e000 {
 	/* NOR, NAND Flashes and CPLD on board */
 	ranges = <0x0 0x0 0xf 0xee000000 0x02000000
 		  0x1 0x0 0xf 0xff800000 0x00010000
-- 
2.25.1

