Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963C84C5F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 23:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiB0Wti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 17:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiB0Wtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:49:36 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDD66593AB;
        Sun, 27 Feb 2022 14:48:58 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,142,1643641200"; 
   d="scan'208";a="111725986"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2022 07:48:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C590C4006DFA;
        Mon, 28 Feb 2022 07:48:54 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chris Brandt <chris.brandt@renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2L OSTM
Date:   Sun, 27 Feb 2022 22:48:44 +0000
Message-Id: <20220227224845.27348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the General Timer Module(a.k.a OSTM) found on the RZ/V2L SoC.
OSTM module is identical to one found RZ/G2L SoC. No driver changes are
required as generic compatible string "renesas,ostm" will be used as a
fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
DTSI changes have been posted as part of series [0]

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220227203744.18355-8-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
index 7fa7f977b44c..c399a019dde7 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -24,6 +24,7 @@ properties:
           - renesas,r7s72100-ostm  # RZ/A1H
           - renesas,r7s9210-ostm   # RZ/A2M
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
+          - renesas,r9a07g054-ostm # RZ/V2L
       - const: renesas,ostm        # Generic
 
   reg:
@@ -54,6 +55,7 @@ if:
       contains:
         enum:
           - renesas,r9a07g044-ostm
+          - renesas,r9a07g054-ostm
 then:
   required:
     - resets
-- 
2.17.1

