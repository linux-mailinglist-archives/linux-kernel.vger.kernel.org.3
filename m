Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1E6578B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiGRT52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiGRT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:57:06 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D2A62ED51;
        Mon, 18 Jul 2022 12:57:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,281,1650898800"; 
   d="scan'208";a="126532760"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jul 2022 04:57:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7DA2740EE28D;
        Tue, 19 Jul 2022 04:57:01 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/5] arm64: dts: renesas: r9a07g044: Update pinctrl node to handle GPIO interrupts
Date:   Mon, 18 Jul 2022 20:56:48 +0100
Message-Id: <20220718195651.7711-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required  properties in pinctrl node to handle GPIO interrupts.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 46fb3d83592a..cfdcca1cf9c6 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -638,6 +638,10 @@ pinctrl: pinctrl@11030000 {
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			#address-cells = <2>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&irqc>;
+			interrupt-controller;
 			gpio-ranges = <&pinctrl 0 0 392>;
 			clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
 			power-domains = <&cpg>;
-- 
2.25.1

