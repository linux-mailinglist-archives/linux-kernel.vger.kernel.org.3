Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21234C5EC5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiB0UjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiB0Uiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:38:55 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 287CB6C973;
        Sun, 27 Feb 2022 12:38:12 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,141,1643641200"; 
   d="scan'208";a="112525454"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2022 05:38:12 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3361940E81B7;
        Mon, 28 Feb 2022 05:38:10 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 07/12] arm64: dts: renesas: r9a07g054: Fillup the OSTM{0,1,2} stub nodes
Date:   Sun, 27 Feb 2022 20:37:39 +0000
Message-Id: <20220227203744.18355-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fillup the OSTM{0,1,2} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 24 +++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 1207a99bf3fe..50cb2f0e6e73 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -629,18 +629,36 @@
 		};
 
 		ostm0: timer@12801000 {
+			compatible = "renesas,r9a07g054-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801000 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G054_OSTM0_PCLK>;
+			resets = <&cpg R9A07G054_OSTM0_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm1: timer@12801400 {
+			compatible = "renesas,r9a07g054-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801400 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G054_OSTM1_PCLK>;
+			resets = <&cpg R9A07G054_OSTM1_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm2: timer@12801800 {
+			compatible = "renesas,r9a07g054-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801800 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G054_OSTM2_PCLK>;
+			resets = <&cpg R9A07G054_OSTM2_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 	};
 
-- 
2.17.1

