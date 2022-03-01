Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7124C8BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiCAMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCAMgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:36:13 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BCE997BBF;
        Tue,  1 Mar 2022 04:35:32 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,146,1643641200"; 
   d="scan'208";a="112805924"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Mar 2022 21:35:31 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C326A4006CD9;
        Tue,  1 Mar 2022 21:35:29 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2] dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC
Date:   Tue,  1 Mar 2022 12:35:26 +0000
Message-Id: <20220301123527.15950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/V2L RPC-IF bindings. RZ/V2L RPC-IF is identical to one found
on the RZ/G2L SoC. No driver changes are required as generic compatible
string "renesas,rzg2l-rpc-if" will be used as a fallback.

While at it, drop the comment "# RZ/G2L family" for "renesas,rzg2l-rpc-if"
compatible string as this will avoid changing the line for every new SoC
addition.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2
* Included RB tag
* Dropped the comment from generic compatible string as suggested
  by Geert.

v1:
https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220227215308.26135-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 294f1036420d..9a6dbf54b540 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -40,7 +40,8 @@ properties:
       - items:
           - enum:
               - renesas,r9a07g044-rpc-if      # RZ/G2{L,LC}
-          - const: renesas,rzg2l-rpc-if       # RZ/G2L family
+              - renesas,r9a07g054-rpc-if      # RZ/V2L
+          - const: renesas,rzg2l-rpc-if
 
   reg:
     items:
-- 
2.17.1

