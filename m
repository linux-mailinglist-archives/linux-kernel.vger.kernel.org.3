Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9A58E896
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiHJITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiHJIS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:18:56 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0784B84ECA;
        Wed, 10 Aug 2022 01:18:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6033DC01AE;
        Wed, 10 Aug 2022 10:18:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660119527; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=lb5r4fhzCVyIKGPH6lTSEJrvrA9c3e3YpbDRnMWteCU=;
        b=wCnkZkqj3PbFcJ6FDuHNbEbflqfOKSE/E4JNhelNfdM7vS+lgneIWtqfoz93rsnyxSTBjs
        B/yWPAC3Smk+cFbsUxeEQLpZuMn+IZrNav/zWpO7zaG6GW6HiowO4MSfFX1tFJZv6jh4EQ
        cs/TS2oP0I4o8AvNlyvcJdNtuOYOnmFDVWNt70Th2NiFG2+N6yb5dLGgQ/8LaHA63mKE7t
        QaM4WhQF+CsZCqk/vuedXXvWKNyWuCbRcS7Ma22VWOXkoeB8V3D9aQGjSBtRz/TFF+jM76
        7QPtPrmovWUzLKIOZFSPy+78aEh+UmUuuO6P2PB4GuLoq616LyB/tUIaj9PrVg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: imx6ul-kontron: Update bindings
Date:   Wed, 10 Aug 2022 10:18:21 +0200
Message-Id: <20220810081825.19051-2-frieder@fris.de>
In-Reply-To: <20220810081825.19051-1-frieder@fris.de>
References: <20220810081825.19051-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This updates the bindings in order to simplify the devicetree
structure and to add names for the boards that follow the latest
convention used by Kontron marketing.

It also gets rid of the N6xxx notation in the compatibles and
file names, as they are not really used anymore and often result
in confusion.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../devicetree/bindings/arm/fsl.yaml          | 31 +++++++------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..649862052f53 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -553,8 +553,7 @@ properties:
               - engicam,imx6ul-isiot      # Engicam Is.IoT MX6UL eMMC/NAND Starter kit
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
               - karo,imx6ul-tx6ul         # Ka-Ro electronics TXUL-0010 Module
-              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
-              - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
+              - kontron,sl-imx6ul         # Kontron SL i.MX6UL SoM
               - prt,prti6g                # Protonic PRTI6G Board
               - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
               - technexion,imx6ul-pico-hobbit  # TechNexion i.MX6UL Pico-Hobbit
@@ -590,23 +589,17 @@ properties:
           - const: phytec,imx6ul-pcl063   # PHYTEC phyCORE-i.MX 6UL
           - const: fsl,imx6ul
 
-      - description: Kontron N6310 S Board
+      - description: Kontron BL i.MX6UL (N631X S) Board
         items:
-          - const: kontron,imx6ul-n6310-s
-          - const: kontron,imx6ul-n6310-som
+          - const: kontron,bl-imx6ul       # Kontron BL i.MX6UL Carrier Board
+          - const: kontron,sl-imx6ul       # Kontron SL i.MX6UL SoM
           - const: fsl,imx6ul
 
-      - description: Kontron N6311 S Board
+      - description: Kontron BL i.MX6UL 43 (N631X S 43) Board
         items:
-          - const: kontron,imx6ul-n6311-s
-          - const: kontron,imx6ul-n6311-som
-          - const: fsl,imx6ul
-
-      - description: Kontron N6310 S 43 Board
-        items:
-          - const: kontron,imx6ul-n6310-s-43
-          - const: kontron,imx6ul-n6310-s
-          - const: kontron,imx6ul-n6310-som
+          - const: kontron,bl-imx6ul-43    # Kontron BL i.MX6UL Carrier Board with 4.3" Display
+          - const: kontron,bl-imx6ul       # Kontron BL i.MX6UL Carrier Board
+          - const: kontron,sl-imx6ul       # Kontron SL i.MX6UL SoM
           - const: fsl,imx6ul
 
       - description: TQ-Systems TQMa6UL1 SoM on MBa6ULx board
@@ -636,7 +629,7 @@ properties:
           - enum:
               - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
               - joz,jozacp                # JOZ Access Point
-              - kontron,imx6ull-n6411-som # Kontron N6411 SOM
+              - kontron,sl-imx6ull        # Kontron SL i.MX6ULL SoM
               - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluation Board
               - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
               - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
@@ -697,10 +690,10 @@ properties:
           - const: toradex,colibri-imx6ull-wifi       # Colibri iMX6ULL Wi-Fi / BT Module
           - const: fsl,imx6ull
 
-      - description: Kontron N6411 S Board
+      - description: Kontron BL i.MX6ULL (N6411 S) Board
         items:
-          - const: kontron,imx6ull-n6411-s
-          - const: kontron,imx6ull-n6411-som
+          - const: kontron,bl-imx6ull   # Kontron BL i.MX6ULL Carrier Board
+          - const: kontron,sl-imx6ull   # Kontron SL i.MX6ULL SoM
           - const: fsl,imx6ull
 
       - description: TQ Systems TQMa6ULLx SoM on MBa6ULx board
-- 
2.37.1

