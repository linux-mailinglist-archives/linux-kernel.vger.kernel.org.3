Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58822578B13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbiGRTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiGRTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:38:09 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AD6E30569;
        Mon, 18 Jul 2022 12:38:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,281,1650898800"; 
   d="scan'208";a="126531998"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jul 2022 04:38:02 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1719440E2264;
        Tue, 19 Jul 2022 04:37:58 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/V2L SoC
Date:   Mon, 18 Jul 2022 20:37:45 +0100
Message-Id: <20220718193745.7472-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/V2L (R9A07G054) IRQC bindings. The RZ/V2L IRQC block is
identical to one found on the RZ/G2L SoC. No driver changes are
required as generic compatible string "renesas,rzg2l-irqc" will be
used as a fallback.

While at it, update the comment "# RZ/G2L" to "# RZ/G2{L,LC}" for
"renesas,r9a07g044-irqc" compatible string as both RZ/G2L and
RZ/G2LC SoC's use the common SoC DTSI and have the same IRQC block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note: This patch depends on [0] which is in next.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
commit/?h=next-20220718&id=96fed779d3d4cb3c221bb70e94de59b8dec0abfc
---
 .../bindings/interrupt-controller/renesas,rzg2l-irqc.yaml      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index ffbb4ab4d9a7..33b90e975e33 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -26,7 +26,8 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g044-irqc    # RZ/G2L
+          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
+          - renesas,r9a07g054-irqc    # RZ/V2L
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
-- 
2.25.1

