Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4814C8BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiCAMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiCAMn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:43:57 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CEC137AB8;
        Tue,  1 Mar 2022 04:43:16 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,146,1643641200"; 
   d="scan'208";a="112806374"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Mar 2022 21:43:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4FA5E400F7B5;
        Tue,  1 Mar 2022 21:43:13 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-phy@lists.infradead.org
Subject: [PATCH v2] dt-bindings: phy: renesas,usb2-phy: Document RZ/V2L phy bindings
Date:   Tue,  1 Mar 2022 12:42:55 +0000
Message-Id: <20220301124255.16836-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document USB phy bindings for RZ/V2L SoC. RZ/V2L USB phy is identical to
one found on the RZ/G2L SoC. No driver changes are required as generic
compatible string "renesas,rzg2l-usb2-phy" will be used as a fallback.

While at it, drop the comment "RZ/G2L family" for "renesas,rzg2l-usb2-phy"
compatible string as this will avoid changing the line for every new SoC
addition.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2
* Included Ack and RB tags
* Dropped the comment from generic string as suggested by Geert.

v1:
https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220227230817.31094-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index 3a6e1165419c..16807bbbdcb1 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -33,7 +33,8 @@ properties:
       - items:
           - enum:
               - renesas,usb2-phy-r9a07g044 # RZ/G2{L,LC}
-          - const: renesas,rzg2l-usb2-phy  # RZ/G2L family
+              - renesas,usb2-phy-r9a07g054 # RZ/V2L
+          - const: renesas,rzg2l-usb2-phy
 
   reg:
     maxItems: 1
-- 
2.17.1

