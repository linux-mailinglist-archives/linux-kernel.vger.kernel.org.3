Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DA4529F43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiEQKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiEQKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:18:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F664DF6F;
        Tue, 17 May 2022 03:15:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D5CB41F443C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652782523;
        bh=j6UwDST1RTpQZrK1XFoXP0QqL60WFGsaB1pWsCUIccs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1kiaYW+CqNYfHl5qFIrwH8QnujW9bPbn7+E/Y7x/IAL6Hq3Su+8yV8MXyxQLSahT
         TWvejk6ACQ484JcrAaIqj+g6Oo2jqw0aQYXHs8wtaC45Ik6cSrUka89OtbbFsKjSCK
         B+md89cBcfTch0Q1Fw4/fHfjymetSY82tfK7AymonzLJ9Ucais5B9eS8ZN8UU25CIj
         yOo/mIjR418yDC4rABhurC21jnTtqF6H3Dvt60ciHJtDFE1Xyzemb3qOF1zdN36uSr
         lPGQu7lJ7GoA062Y358nPpgsIa6GVKzRBMPt29/geJI0BQk4pugG3ck5cDVqc1W846
         ARd5Cp9g84c8A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: arm: mt8192-clock: Remove unnecessary 'items'
Date:   Tue, 17 May 2022 12:15:13 +0200
Message-Id: <20220517101514.21639-6-angelogioacchino.delregno@collabora.com>
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

There's no need for 'items' when there's only one item.

Fixes: 4a803990aeb1 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../arm/mediatek/mediatek,mt8192-clock.yaml   | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
index c8c67c033f8c..bb410b178f33 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
@@ -14,29 +14,28 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - mediatek,mt8192-scp_adsp
-          - mediatek,mt8192-imp_iic_wrap_c
-          - mediatek,mt8192-imp_iic_wrap_e
-          - mediatek,mt8192-imp_iic_wrap_s
-          - mediatek,mt8192-imp_iic_wrap_ws
-          - mediatek,mt8192-imp_iic_wrap_w
-          - mediatek,mt8192-imp_iic_wrap_n
-          - mediatek,mt8192-msdc_top
-          - mediatek,mt8192-msdc
-          - mediatek,mt8192-mfgcfg
-          - mediatek,mt8192-imgsys
-          - mediatek,mt8192-imgsys2
-          - mediatek,mt8192-vdecsys_soc
-          - mediatek,mt8192-vdecsys
-          - mediatek,mt8192-vencsys
-          - mediatek,mt8192-camsys
-          - mediatek,mt8192-camsys_rawa
-          - mediatek,mt8192-camsys_rawb
-          - mediatek,mt8192-camsys_rawc
-          - mediatek,mt8192-ipesys
-          - mediatek,mt8192-mdpsys
+    enum:
+      - mediatek,mt8192-scp_adsp
+      - mediatek,mt8192-imp_iic_wrap_c
+      - mediatek,mt8192-imp_iic_wrap_e
+      - mediatek,mt8192-imp_iic_wrap_s
+      - mediatek,mt8192-imp_iic_wrap_ws
+      - mediatek,mt8192-imp_iic_wrap_w
+      - mediatek,mt8192-imp_iic_wrap_n
+      - mediatek,mt8192-msdc_top
+      - mediatek,mt8192-msdc
+      - mediatek,mt8192-mfgcfg
+      - mediatek,mt8192-imgsys
+      - mediatek,mt8192-imgsys2
+      - mediatek,mt8192-vdecsys_soc
+      - mediatek,mt8192-vdecsys
+      - mediatek,mt8192-vencsys
+      - mediatek,mt8192-camsys
+      - mediatek,mt8192-camsys_rawa
+      - mediatek,mt8192-camsys_rawb
+      - mediatek,mt8192-camsys_rawc
+      - mediatek,mt8192-ipesys
+      - mediatek,mt8192-mdpsys
 
   reg:
     maxItems: 1
-- 
2.35.1

