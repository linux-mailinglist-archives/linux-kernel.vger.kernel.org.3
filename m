Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82A84C5FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 00:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiB0XAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 18:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiB0XAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 18:00:39 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D99BF6D4C9;
        Sun, 27 Feb 2022 15:00:01 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,142,1643641200"; 
   d="scan'208";a="111726405"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2022 08:00:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1047F40062C3;
        Mon, 28 Feb 2022 07:59:58 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/V2L SoC
Date:   Sun, 27 Feb 2022 22:59:56 +0000
Message-Id: <20220227225956.29570-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RSPI binding documentation for Renesas RZ/V2L SoC.

RSPI block is identical to one found on RZ/A, so no driver changes are
required. The fallback compatible string "renesas,rspi-rz" will be used
on RZ/V2L.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
DTSI changes have been posted as part of series [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20220227203744.18355-13-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 Documentation/devicetree/bindings/spi/renesas,rspi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
index 76e6d9e52fc7..a902f0ca2198 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -22,6 +22,7 @@ properties:
               - renesas,rspi-r7s72100  # RZ/A1H
               - renesas,rspi-r7s9210   # RZ/A2
               - renesas,r9a07g044-rspi # RZ/G2{L,LC}
+              - renesas,r9a07g054-rspi # RZ/V2L
           - const: renesas,rspi-rz     # RZ/A and RZ/G2{L,LC}
 
       - items:
@@ -124,6 +125,7 @@ allOf:
             enum:
               - renesas,qspi
               - renesas,r9a07g044-rspi
+              - renesas,r9a07g054-rspi
     then:
       required:
         - resets
-- 
2.17.1

