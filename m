Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC257B221
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiGTHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiGTHxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:53:45 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5D75F987
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:53:43 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id xKtg270094C55Sk06KtgKp; Wed, 20 Jul 2022 09:53:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oE4WZ-004RV9-TU; Wed, 20 Jul 2022 09:53:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oE4WZ-00Es0W-9t; Wed, 20 Jul 2022 09:53:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: timer: renesas,cmt: Fix R-Car Gen4 fall-out
Date:   Wed, 20 Jul 2022 09:53:34 +0200
Message-Id: <2e3863ae32e17d49f41111580f195dd34e2b769d.1658303544.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore sort order (by family, followed by type).
Update the conditional sections specifying the number of interrupts.

Fixes: 525b296185b4b0ab ("dt-bindings: timer: renesas,cmt: Add r8a779f0 and generic Gen4 CMT support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/timer/renesas,cmt.yaml     | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 433ddb49620ca518..bde6c9b66bf42689 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -82,12 +82,6 @@ properties:
               - renesas,r8a77995-cmt0     # 32-bit CMT0 on R-Car D3
           - const: renesas,rcar-gen3-cmt0 # 32-bit CMT0 on R-Car Gen3 and RZ/G2
 
-      - items:
-          - enum:
-              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
-              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
-          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
-
       - items:
           - enum:
               - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
@@ -104,6 +98,12 @@ properties:
               - renesas,r8a77995-cmt1     # 48-bit CMT on R-Car D3
           - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/G2
 
+      - items:
+          - enum:
+              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
+              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
+          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
+
       - items:
           - enum:
               - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
@@ -145,6 +145,7 @@ allOf:
             enum:
               - renesas,rcar-gen2-cmt0
               - renesas,rcar-gen3-cmt0
+              - renesas,rcar-gen4-cmt0
     then:
       properties:
         interrupts:
@@ -158,6 +159,7 @@ allOf:
             enum:
               - renesas,rcar-gen2-cmt1
               - renesas,rcar-gen3-cmt1
+              - renesas,rcar-gen4-cmt1
     then:
       properties:
         interrupts:
-- 
2.25.1

