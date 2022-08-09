Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7458DB13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiHIP0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244843AbiHIPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:25:53 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14706381;
        Tue,  9 Aug 2022 08:25:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BEA4C0160;
        Tue,  9 Aug 2022 17:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660058750; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=5xiMAiruKhslu8d37P50Kdp+6lpsYDSM14qlW6rniqk=;
        b=k0SheYgbLa7YRoo+uVcg6SsDksvEoBQBeSoaOoIaJ2XIahCYUN5au923cbk0umWzfwYj4E
        2KvmflEhReYrd7tgvwIjfyjaF2q+iWdkuuW8mFFQ3sOC9+41252irNGpjwcmNtz9+7Wr4Y
        1+u+cBHmqXFAzOIzEQKEawG428nE6VrPhyhbTMwL0VffbswhxzReCvfn5bHOAg3punqpDx
        QciO9RIVg7WAqQrq0kfPA2TPPEMVrSKhtZBkebBJkAIpWMY/8u6br32Vo6DlwI5AuHCQgD
        ED1UvwOZbzBUt9OgK136T/sODu4yt2wh6S07goSFldg6hXD3k7noglTM0SrhCQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/4] dt-bindings: arm: fsl: imx6ul-kontron: Update bindings
Date:   Tue,  9 Aug 2022 17:25:28 +0200
Message-Id: <20220809152534.292034-2-frieder@fris.de>
In-Reply-To: <20220809152534.292034-1-frieder@fris.de>
References: <20220809152534.292034-1-frieder@fris.de>
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

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../devicetree/bindings/arm/fsl.yaml          | 31 +++++++------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..7c4c27d553ec 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -553,8 +553,7 @@ properties:
               - engicam,imx6ul-isiot      # Engicam Is.IoT MX6UL eMMC/NAND Starter kit
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
               - karo,imx6ul-tx6ul         # Ka-Ro electronics TXUL-0010 Module
-              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
-              - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
+              - kontron,imx6ul-n631x-som  # Kontron SL i.MX6UL (N631X SOM)
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
+          - const: kontron,imx6ul-n631x-s
+          - const: kontron,imx6ul-n631x-som
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
+          - const: kontron,imx6ul-n631x-s-43
+          - const: kontron,imx6ul-n631x-s
+          - const: kontron,imx6ul-n631x-som
           - const: fsl,imx6ul
 
       - description: TQ-Systems TQMa6UL1 SoM on MBa6ULx board
@@ -636,7 +629,7 @@ properties:
           - enum:
               - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
               - joz,jozacp                # JOZ Access Point
-              - kontron,imx6ull-n6411-som # Kontron N6411 SOM
+              - kontron,imx6ull-n641x-som # Kontron SL i.MX6ULL (N641X SOM)
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
+          - const: kontron,imx6ull-n641x-s
+          - const: kontron,imx6ull-n641x-som
           - const: fsl,imx6ull
 
       - description: TQ Systems TQMa6ULLx SoM on MBa6ULx board
-- 
2.37.1

