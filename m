Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA030529F42
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbiEQKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiEQKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:18:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E634DF6D;
        Tue, 17 May 2022 03:15:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 180091F443BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652782522;
        bh=eBRkr4WqaZlr+7CsJBZHJn+mlNJWVhtlI7s9X1ia8g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlOqhjo49ohOAQ2ZuFAreXPXG4V8YZCcT4aUTIrU+HQMawU1y6ySWiM1Jz9xb63+N
         KQbL4F7qdpnW8HAobgwSwl/GcOkEi6/coy15eH/wBr2QpDOmfE36NI5s3a7td5Hmt1
         JgpQT7ojwuCE+NAon9JXBdBHoes31kOpYhfdwOB9hs+QdPg6k6bWEiWMmOkNZUwqW6
         VOIAMAJ3nSkMIMbYuU9sonPTaQ8nB6yjOmme433gdR1HhBQGzwBDrKK+cjAWX8JqUc
         YtZAAoWFw4NRKtGo63e/tF1zqwXIspJH5P04O3+u2vrBGnLxjREJePZsCZ2oydm/7Z
         wiMKaaoFq+y5g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: arm: mt8195: Set #clock-cells as required property
Date:   Tue, 17 May 2022 12:15:12 +0200
Message-Id: <20220517101514.21639-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a clock-controller binding, so it needs #clock-cells, or
it would be of no use: add that to the list of required properties.

Fixes: 34d3ed3b9a00 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml  | 1 +
 .../bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
index 0189aa0e34d4..aabd9f0df2de 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
@@ -60,6 +60,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
index 95b6bdf99936..e2ba37830d4e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
@@ -43,6 +43,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
-- 
2.35.1

