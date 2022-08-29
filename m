Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49795A5682
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiH2Vvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2Vvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:51:37 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64ABC9E8B9;
        Mon, 29 Aug 2022 14:51:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,273,1654527600"; 
   d="scan'208";a="130995492"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Aug 2022 06:51:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D394C40EB267;
        Tue, 30 Aug 2022 06:51:32 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: Drop clock-names property from RPC node
Date:   Mon, 29 Aug 2022 22:51:28 +0100
Message-Id: <20220829215128.5983-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support implemented, there's a number of
warnings when running dtbs_check:

arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb: spi@ee200000: Unevaluated properties are not allowed ('clock-names' was unexpected)
	From schema: Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml

The main problem is that SoC DTSI's are including clock-names, whereas the
renesas,rpc-if.yaml has 'unevaluatedProperties: false'. So just drop
clock-names property from the SoC DTSI's.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 1 -
 7 files changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index e7d17776624d..fdd6d16cb1c1 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -2334,7 +2334,6 @@ rpc: spi@ee200000 {
 			reg-names = "regs", "dirmap", "wbuf";
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 917>;
-			clock-names = "rpc";
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 917>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index f62d95760e82..d541b48c7e38 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -2191,7 +2191,6 @@ rpc: spi@ee200000 {
 			reg-names = "regs", "dirmap", "wbuf";
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 917>;
-			clock-names = "rpc";
 			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets = <&cpg 917>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index c563d26a7a71..151e32ac0368 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1671,7 +1671,6 @@ rpc: spi@ee200000 {
 			reg-names = "regs", "dirmap", "wbuf";
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 917>;
-			clock-names = "rpc";
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 917>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 8ec59094882b..5c6cc586e9e2 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -2423,7 +2423,6 @@ rpc: spi@ee200000 {
 			reg-names = "regs", "dirmap", "wbuf";
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 917>;
-			clock-names = "rpc";
 			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
 			resets = <&cpg 917>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 2703ef3a38c2..49a738b6034c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -1053,7 +1053,6 @@ rpc: spi@ee200000 {
 			reg-names = "regs", "dirmap", "wbuf";
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 917>;
-			clock-names = "rpc";
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 917>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 8594be72f221..bb9777258174 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -1359,7 +1359,6 @@ rpc: spi@ee200000 {
 			reg-names = "regs", "dirmap", "wbuf";
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 917>;
-			clock-names = "rpc";
 			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 917>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index c6360470eeb5..a1e8f6fe3139 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -2096,7 +2096,6 @@ rpc: spi@ee200000 {
 			reg-names = "regs", "dirmap", "wbuf";
 			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 629>;
-			clock-names = "rpc";
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			resets = <&cpg 629>;
 			#address-cells = <1>;
-- 
2.25.1

