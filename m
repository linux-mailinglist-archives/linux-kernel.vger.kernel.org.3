Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DA3592DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiHOLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiHOLCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:02:37 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17879237EC;
        Mon, 15 Aug 2022 04:02:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31A71C023A;
        Mon, 15 Aug 2022 13:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660561353; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=hzJyrDoXrhCO0SrbCPDsNSDDOwNsM9vLr50z3j28vZM=;
        b=IhIxl1EheucsydlzMt9+smOI4DtuQyICbQgb/grAVRUMZMuJwKZlGQDyjAo+jFUJFQYreI
        QlMxfPJAsOROWIz4wq8HesjmMG12vDcITBIAz3q7pBbaVx1lp0/qtAudCmWbQOaxoqOxog
        LQBQ2KBzmWRLePkN2Z5Of7Y8OIcQarpHyTlJIWLQaaRbh8/A2+I3x5CF/Y42DuHJbkDrWO
        6ZiSCgCZh6PdrAqBKyJoMI9XptkcEFaKPBvh/HENp/0ZGQfw84hwsJeylns8337Jh6/TIh
        MibLZIeg0RlTEV5RDUzulnGz/Rp5yDsOUxVT3LqZ1H2XP+uGWjXOfByxKtlIxw==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/8] dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board
Date:   Mon, 15 Aug 2022 13:01:25 +0200
Message-Id: <20220815110134.49683-3-frieder@fris.de>
In-Reply-To: <20220815110134.49683-1-frieder@fris.de>
References: <20220815110134.49683-1-frieder@fris.de>
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

