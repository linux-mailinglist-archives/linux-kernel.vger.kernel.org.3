Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77E4586BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiHANQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiHANQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:16:07 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6512B265;
        Mon,  1 Aug 2022 06:16:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AE05C01B2;
        Mon,  1 Aug 2022 15:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1659359763; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=EvDIWgGGFv0dTGHx3tYvYz7xpwXiwSm00vavKsPFV3Y=;
        b=obDUdM6Vkpe6QoBH6/m6GEV5mMxg0lGFjtT07gSiov3zBVNDhpdws4E5hSXXeXbC1e+AND
        BQzau/fcSKuvZpsk1DvZOreD0aFQgpDlRRvyO3SedmX98xMrAV1Ru4+bfMqAKWNrsNKWBd
        AaF3dOyxFVzDiKtMe6E93BMqXI295awqmyu9G9KpH9NOpZOvknBE0qxtOuN49+kX0B5eyU
        w1En35OKRXnlRMb0OT3YNmTjY15H5kK8mThx0hsIhuNDAqgyqBt3jYC8VHuF/GjNUtyjE5
        2CjkKKrp72e63W+V0Q+ONcStiImD1xEVby5pNiueZLbjNkV0ozej6QYQav4hbg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 1/8] dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board
Date:   Mon,  1 Aug 2022 15:15:45 +0200
Message-Id: <20220801131554.116795-2-frieder@fris.de>
In-Reply-To: <20220801131554.116795-1-frieder@fris.de>
References: <20220801131554.116795-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
* add A-b tag from Krzysztof (Thanks!)
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
2.37.1

