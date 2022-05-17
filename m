Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDED529F37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbiEQKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbiEQKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:18:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C814DF6A;
        Tue, 17 May 2022 03:15:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4C0F11F443BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652782521;
        bh=pzo1+dtMa6njW2GpA6/MtdlSKfPgcIWtCqftoMrICX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6N19vRG6Rm/G2l/YpJFs1T+FepNZFi3TVkSjVWPM8PXAFdX0z6HfSUJzWPYJFRzf
         xuu8gWtUfSgQF2bIOZijOFeO01erxA7kzxdMdH4Nzq1DPer9oXoVajWX6xt0ZIQ7eF
         SQp+UzqYV0SMleKnVwMWwNvcM9Wni4wII37NHQwmjun9Z9sK51nWZ5Jklc2i7Rc8QL
         DYjLpGxEyethfeeFtZ/J80mma214UPI3Xua0w5DtNDQrvbIrvikfJDKN5ZjRcugIn+
         1qCWOH/82zLISVg+TR1UCrDl8hoU3gMLg0MzTC3NTj7IBV+aQzjSGLjSveZ87kLtwH
         jSNek9H5C7Ltw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: arm: mt8195-clock: Remove unnecessary 'items' and fix formatting
Date:   Tue, 17 May 2022 12:15:11 +0200
Message-Id: <20220517101514.21639-4-angelogioacchino.delregno@collabora.com>
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

Fixes: 34d3ed3b9a00 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../arm/mediatek/mediatek,mt8195-clock.yaml   | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
index 17fcbb45d121..0189aa0e34d4 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
@@ -22,35 +22,35 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - mediatek,mt8195-scp_adsp
-          - mediatek,mt8195-imp_iic_wrap_s
-          - mediatek,mt8195-imp_iic_wrap_w
-          - mediatek,mt8195-mfgcfg
-          - mediatek,mt8195-vppsys0
-          - mediatek,mt8195-wpesys
-          - mediatek,mt8195-wpesys_vpp0
-          - mediatek,mt8195-wpesys_vpp1
-          - mediatek,mt8195-vppsys1
-          - mediatek,mt8195-imgsys
-          - mediatek,mt8195-imgsys1_dip_top
-          - mediatek,mt8195-imgsys1_dip_nr
-          - mediatek,mt8195-imgsys1_wpe
-          - mediatek,mt8195-ipesys
-          - mediatek,mt8195-camsys
-          - mediatek,mt8195-camsys_rawa
-          - mediatek,mt8195-camsys_yuva
-          - mediatek,mt8195-camsys_rawb
-          - mediatek,mt8195-camsys_yuvb
-          - mediatek,mt8195-camsys_mraw
-          - mediatek,mt8195-ccusys
-          - mediatek,mt8195-vdecsys_soc
-          - mediatek,mt8195-vdecsys
-          - mediatek,mt8195-vdecsys_core1
-          - mediatek,mt8195-vencsys
-          - mediatek,mt8195-vencsys_core1
-          - mediatek,mt8195-apusys_pll
+    enum:
+      - mediatek,mt8195-scp_adsp
+      - mediatek,mt8195-imp_iic_wrap_s
+      - mediatek,mt8195-imp_iic_wrap_w
+      - mediatek,mt8195-mfgcfg
+      - mediatek,mt8195-vppsys0
+      - mediatek,mt8195-wpesys
+      - mediatek,mt8195-wpesys_vpp0
+      - mediatek,mt8195-wpesys_vpp1
+      - mediatek,mt8195-vppsys1
+      - mediatek,mt8195-imgsys
+      - mediatek,mt8195-imgsys1_dip_top
+      - mediatek,mt8195-imgsys1_dip_nr
+      - mediatek,mt8195-imgsys1_wpe
+      - mediatek,mt8195-ipesys
+      - mediatek,mt8195-camsys
+      - mediatek,mt8195-camsys_rawa
+      - mediatek,mt8195-camsys_yuva
+      - mediatek,mt8195-camsys_rawb
+      - mediatek,mt8195-camsys_yuvb
+      - mediatek,mt8195-camsys_mraw
+      - mediatek,mt8195-ccusys
+      - mediatek,mt8195-vdecsys_soc
+      - mediatek,mt8195-vdecsys
+      - mediatek,mt8195-vdecsys_core1
+      - mediatek,mt8195-vencsys
+      - mediatek,mt8195-vencsys_core1
+      - mediatek,mt8195-apusys_pll
+
   reg:
     maxItems: 1
 
-- 
2.35.1

