Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025D3572F85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiGMHrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiGMHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:47:41 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F9E5DD8;
        Wed, 13 Jul 2022 00:47:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6881C01E0;
        Wed, 13 Jul 2022 09:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1657698118; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=OON4EWemRTnjfuAi52ZThbCXiYTlc2KJyIwRE7eWOt4=;
        b=1KyECdwXld74BH/fCljC8NdpXUjdkiUKbWQXbOVpreYTE6idE7XMjxw9OYZBfMsPd2Fxy/
        EKNBhTDQHRfFor6GJCftzJy3h2g1YZr/LEXDfGguGKPhzynJXu9mTB/9NncP9v6892IbGI
        dbmIDfKA+TxD7fJymUxNHPL9e2Ifwp2BcAFF4qMC/GPDTfyQt7itio5FyRvHfJCCkDUH6E
        UnNeV/R+KaLS4IDuv+M2T5Ndrhxytzyexk71E6/2V/Wz4zQ2bBVXUFSem/PTlfunJxYuXE
        1nseUT70G8L0rHcqGP1OH7o62Mf3iBHLL+UzJ0Om077KlidlLMj1r9xFqMtaXA==
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
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 6/6] dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board
Date:   Wed, 13 Jul 2022 09:41:17 +0200
Message-Id: <20220713074118.14733-7-frieder@fris.de>
In-Reply-To: <20220713074118.14733-1-frieder@fris.de>
References: <20220713074118.14733-1-frieder@fris.de>
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
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..ef99d948e908 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -847,6 +847,12 @@ properties:
           - const: kontron,imx8mm-n801x-som
           - const: fsl,imx8mm
 
+      - description: Kontron BL i.MX8MM OSM-S (N802X S) Board
+        items:
+          - const: kontron,imx8mm-n802x-s
+          - const: kontron,imx8mm-n802x-som
+          - const: fsl,imx8mm
+
       - description: Toradex Boards with Verdin iMX8M Mini Modules
         items:
           - enum:
-- 
2.37.0

