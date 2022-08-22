Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D259BABB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiHVIBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiHVIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:01:36 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F2D2AE1A;
        Mon, 22 Aug 2022 01:01:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8268AC018B;
        Mon, 22 Aug 2022 10:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1661155293; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=zU7RWqah3dWELUuDIGga8OUgOvhVsdQkNRY8DYAu0mA=;
        b=0V3YtkNi8oSxCB1pI3wQ4ewfj16U9R4eGlFjGfwkNXCWngqiKJj7x0mJBgKD/oECttXeJK
        TJOK2Qglh4xNA5JH9kJWLOMo8kboej+O+SFwzOU3A/FajjRpTmYYw1di1KDETTqZHWl5S2
        d56uhaCaAia57AJ8Qw8KpH5quxJqNiXKQYY1bj8oFdkN2mH0fihAFshMLFWhxffYkAP30Z
        75BrnxW/8jjadJL3qrKpm/ltOUiVqeX6VyLjF7Ta0Al4gBBOUjhEeIVxNJ4rewk2PafO0n
        cFAGRF5i64K0VK4HQoaiSs0535lY8wBwoaVVh41q5XXrVp7RY+BhbNmFv58mWQ==
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/8] dt-bindings: arm: fsl: Rename compatibles for Kontron i.MX8MM SoM/board
Date:   Mon, 22 Aug 2022 10:00:54 +0200
Message-Id: <20220822080103.24016-2-frieder@fris.de>
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

