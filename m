Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FFA4C5FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 00:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiB0XQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 18:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiB0XQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 18:16:15 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91D7122B19;
        Sun, 27 Feb 2022 15:15:37 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,142,1643641200"; 
   d="scan'208";a="111727887"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2022 08:15:36 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8833241139A9;
        Mon, 28 Feb 2022 08:15:34 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/V2L bindings
Date:   Sun, 27 Feb 2022 23:15:31 +0000
Message-Id: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/V2L (R9A07G054) SoC bindings. USBHS block is identical to one
found on RZ/A2 SoC. No driver changes are required as generic compatible
string "renesas,rza2-usbhs" will be used as a fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
DTSi changes have been posted as part of series [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
cover/20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index 012fe80a7611..0bb841b28003 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -20,6 +20,7 @@ properties:
           - enum:
               - renesas,usbhs-r7s9210   # RZ/A2
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
+              - renesas,usbhs-r9a07g054 # RZ/V2L
           - const: renesas,rza2-usbhs
 
       - items:
@@ -116,7 +117,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,usbhs-r9a07g044
+            enum:
+              - renesas,usbhs-r9a07g044
+              - renesas,usbhs-r9a07g054
     then:
       properties:
         interrupts:
-- 
2.17.1

