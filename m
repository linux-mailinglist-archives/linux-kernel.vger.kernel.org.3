Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CFA592DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiHOLDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbiHOLCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:02:36 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6880D248D1;
        Mon, 15 Aug 2022 04:02:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E318C017B;
        Mon, 15 Aug 2022 13:02:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660561351; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=zU7RWqah3dWELUuDIGga8OUgOvhVsdQkNRY8DYAu0mA=;
        b=UE+2ciGotMn/GtfPYy2TWR1AqWcJiNfdKYIfBAo2091NfNMlXSUz1DB+VLvzjsKuTD0BtZ
        XNwFlvqX65XiMEXl3JJqBvLtw0aruTYvImS8K+tuxjq9R7Q1EPkzn4NoN8PMYZmguF76yG
        7wp2KbRWxVo0jdNKqNRge+T+8Ff/6OGWGuu2DvFu7tenFx4mMsmm6addZej2AuEID88iqO
        MwgmnwYxRfrLXSaLrBpi1C6Ham9yI26+zEcN+IgJwjXWq3VP58YP/hAh4SD5tLeYy+amv0
        9Hthko3EPAyRu3+33tXv116UTg52lJP70PDzJTZ0L3NEakiti6hC6z+FBpT7Mw==
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/8] dt-bindings: arm: fsl: Rename compatibles for Kontron i.MX8MM SoM/board
Date:   Mon, 15 Aug 2022 13:01:24 +0200
Message-Id: <20220815110134.49683-2-frieder@fris.de>
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

This updates the bindings in order to use names for the boards that
follow the latest convention used by Kontron marketing.

By updating we make sure, that we can maintain this more easily in
future and make sure that the proper devicetree can be selected for
the hardware.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v3:
* new patch
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7431579ab0e8..4dcfa27044f0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -831,7 +831,7 @@ properties:
               - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
               - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
               - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
-              - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
+              - kontron,imx8mm-sl         # i.MX8MM Kontron SL (N801X) SOM
               - menlo,mx8menlo            # i.MX8MM Menlo board with Verdin SoM
               - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
               - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini Modules without Wi-Fi / BT
@@ -850,8 +850,8 @@ properties:
 
       - description: Kontron BL i.MX8MM (N801X S) Board
         items:
-          - const: kontron,imx8mm-n801x-s
-          - const: kontron,imx8mm-n801x-som
+          - const: kontron,imx8mm-bl
+          - const: kontron,imx8mm-sl
           - const: fsl,imx8mm
 
       - description: Toradex Boards with Verdin iMX8M Mini Modules
-- 
2.37.1

