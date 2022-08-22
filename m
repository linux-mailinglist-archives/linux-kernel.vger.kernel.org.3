Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB259BAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiHVIBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiHVIBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:01:37 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0E2AC51;
        Mon, 22 Aug 2022 01:01:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CB32C01BC;
        Mon, 22 Aug 2022 10:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1661155294; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=hzJyrDoXrhCO0SrbCPDsNSDDOwNsM9vLr50z3j28vZM=;
        b=v+xGDzjY/NHElhlidd2kj+/PqHlXJZoGyB0Owlbnv2LwftDjhD8f06+EEgAhR3ohR5HWOg
        5UKVvr0yQvtc1tqxGeaMFT9HnY2oIz+pCa5MJJImBRBlFJ2DeX0UGBPjXHIJP1/VPMffZX
        9GsnfKddcZQxYxit2QcPGO2sdtCQ5OQwoyBPUHphlZ2zTXd+9EII60u2GxId4Vv9EpldCO
        8wBV4b4ukvVeg9j8bKsjgjn0hN9drp2b+wTlu2kqhwKdpcB8SY5mnzD6umBKWUgMKvg/3M
        RqtrFEijM0VFTuUpoQkhFriiGq99o10vQeNlrZR7ELva1bz60H/RLixC3awXyQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/8] dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board
Date:   Mon, 22 Aug 2022 10:00:55 +0200
Message-Id: <20220822080103.24016-3-frieder@fris.de>
In-Reply-To: <20220822080103.24016-1-frieder@fris.de>
References: <20220822080103.24016-1-frieder@fris.de>
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

Add bindings for the Kontron BL i.MX8MM OSM-S board.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
* rename compatibles
* rebase on v6.0-rc1

Changes in v2:
* add A-b tag from Krzysztof (Thanks!)
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 4dcfa27044f0..2b5a4d293e25 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -832,6 +832,7 @@ properties:
               - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
               - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
               - kontron,imx8mm-sl         # i.MX8MM Kontron SL (N801X) SOM
+              - kontron,imx8mm-osm-s      # i.MX8MM Kontron OSM-S (N802X) SOM
               - menlo,mx8menlo            # i.MX8MM Menlo board with Verdin SoM
               - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
               - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini Modules without Wi-Fi / BT
@@ -854,6 +855,12 @@ properties:
           - const: kontron,imx8mm-sl
           - const: fsl,imx8mm
 
+      - description: Kontron BL i.MX8MM OSM-S (N802X S) Board
+        items:
+          - const: kontron,imx8mm-bl-osm-s
+          - const: kontron,imx8mm-osm-s
+          - const: fsl,imx8mm
+
       - description: Toradex Boards with Verdin iMX8M Mini Modules
         items:
           - enum:
-- 
2.37.1

