Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C425157E2DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiGVOP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiGVOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:15:21 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1DE81C90F;
        Fri, 22 Jul 2022 07:15:19 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,185,1654527600"; 
   d="scan'208";a="127042270"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jul 2022 23:15:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7B58343279E4;
        Fri, 22 Jul 2022 23:15:16 +0900 (JST)
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
Subject: [PATCH v2 1/2] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/Five SoC
Date:   Fri, 22 Jul 2022 15:15:05 +0100
Message-Id: <20220722141506.20171-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/Five (R9A07G043) SYSC bindings. The SYSC block found on the
RZ/Five SoC is almost identical to one found on the RZ/G2UL (and alike)
SoC's. "renesas,r9a07g043-sysc" compatible string will be used on the
RZ/Five SoC so to make this clear, update the comment to include RZ/Five
SoC.

The SYSC block on RZ/Five has no interrupts to the core so to accommodate
this SoC make interrupts{,-names} properties optional.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
* Dropped "renesas,r9a07g043-rzfive-sysc" compatible string
* Made interrupts{,-names} properties optional
---
 .../devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml   | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
index ce2875c89329..398663d21ab1 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
@@ -20,7 +20,7 @@ description:
 properties:
   compatible:
     enum:
-      - renesas,r9a07g043-sysc # RZ/G2UL
+      - renesas,r9a07g043-sysc # RZ/G2UL and RZ/Five
       - renesas,r9a07g044-sysc # RZ/G2{L,LC}
       - renesas,r9a07g054-sysc # RZ/V2L
 
@@ -44,8 +44,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-names
 
 additionalProperties: false
 
-- 
2.25.1

