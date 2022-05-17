Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A82529F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbiEQKS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbiEQKSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:18:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888E4DF64;
        Tue, 17 May 2022 03:15:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B30531F443BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652782520;
        bh=yD0K1LzG4sl17Wt8hLcimPzliudGfQA7GrWMkET9a1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2VeW1mF5P+bz0Wp52qj1JfvQcWLqA1g13V0NcabygswWM+vcSxj+O1EhPYfx9tiF
         MRaFMLCHDkw3LCLqZ3CU3fK0wOGEgw6AjVbXyCJrkKx95BzfWgugBbRg1TeTLku7Yx
         dndIBqlaxPVq8PS3NzqSkrNv20/v87VOqIPDP4b7D6dObkx6qXCh+uEeK3STrAu1ND
         Sp2JCxYrWRDfOXPHTIPyPTRZVhgNOfk2CZTO5CkAuafegW3TanXw8+KoFTL+Z52MqO
         Blam74p/7Xgx8M8JKaR4JmWcfQG/KUIk4YhU8dP7OfXHOlBQbg+eDCl/ZbosxgP+wB
         b9UmsnZufNlbA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: arm: mt8186-clock: Remove unnecessary 'items' and fix formatting
Date:   Tue, 17 May 2022 12:15:09 +0200
Message-Id: <20220517101514.21639-2-angelogioacchino.delregno@collabora.com>
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

There's no need for 'items' when there's only one item; while at it,
also fix formatting by adding a blank line before specifying 'reg'.

Fixes: f113a51aa2cf ("dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock")
Signed-off-by: AngeloGioacchino	Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../arm/mediatek/mediatek,mt8186-clock.yaml   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
index cf1002c3efa6..371eace6780b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
@@ -21,20 +21,20 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - mediatek,mt8186-imp_iic_wrap
-          - mediatek,mt8186-mfgsys
-          - mediatek,mt8186-wpesys
-          - mediatek,mt8186-imgsys1
-          - mediatek,mt8186-imgsys2
-          - mediatek,mt8186-vdecsys
-          - mediatek,mt8186-vencsys
-          - mediatek,mt8186-camsys
-          - mediatek,mt8186-camsys_rawa
-          - mediatek,mt8186-camsys_rawb
-          - mediatek,mt8186-mdpsys
-          - mediatek,mt8186-ipesys
+    enum:
+      - mediatek,mt8186-imp_iic_wrap
+      - mediatek,mt8186-mfgsys
+      - mediatek,mt8186-wpesys
+      - mediatek,mt8186-imgsys1
+      - mediatek,mt8186-imgsys2
+      - mediatek,mt8186-vdecsys
+      - mediatek,mt8186-vencsys
+      - mediatek,mt8186-camsys
+      - mediatek,mt8186-camsys_rawa
+      - mediatek,mt8186-camsys_rawb
+      - mediatek,mt8186-mdpsys
+      - mediatek,mt8186-ipesys
+
   reg:
     maxItems: 1
 
-- 
2.35.1

