Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1F4C5F9F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 23:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiB0W5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 17:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiB0W5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:57:19 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24C4B6C96E;
        Sun, 27 Feb 2022 14:56:42 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,142,1643641200"; 
   d="scan'208";a="111726256"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2022 07:56:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1E1B940062C3;
        Mon, 28 Feb 2022 07:56:38 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/V2L SoC
Date:   Sun, 27 Feb 2022 22:56:32 +0000
Message-Id: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/V2L SSI bindings. RZ/V2L SSI is identical to one found
on the RZ/G2L SoC. No driver changes are required as generic compatible
string "renesas,rz-ssi" will be used as a fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
DTSI changes have been posted as part of series [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20220227203744.18355-10-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 414ff8035a4e..7e8d252f7bca 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/sound/renesas,rz-ssi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/G2L ASoC Sound Serial Interface (SSIF-2)
+title: Renesas RZ/{G2L,V2L} ASoC Sound Serial Interface (SSIF-2)
 
 maintainers:
   - Biju Das <biju.das.jz@bp.renesas.com>
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
+          - renesas,r9a07g054-ssi  # RZ/V2L
       - const: renesas,rz-ssi
 
   reg:
-- 
2.17.1

