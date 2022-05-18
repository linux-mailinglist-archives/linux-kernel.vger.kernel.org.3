Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2C52B6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiERJha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiERJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:36:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DAAB8BCA;
        Wed, 18 May 2022 02:36:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CAE861F4245E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652866599;
        bh=qqSMX64oBzw5AUG70z0JfMK5uOuzZnT/sCD+YBRG804=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbImY02IiZX3mxGSk3oCKDO+OMUszPOTL3+0M1TOG+l7opXMHuOT8pEuSXs2Vsica
         qIeUpwOiSM2RL4UVgzXhctyTSu77yv5S2fWYYUJokzaWQpfeKf/nuUQcxKP6X9oN85
         SPEcwl/0NBIV2TVBgmu3eaebirc3kTDvT5IMaeFopT0ajf8/hevNstvrFQwOJlNgAb
         PuwFGWFzNGapZmPmzU43K6joWZd3wVXBoW2A4lB/nqiji03IsP1yX+BC2VrlN4iGhO
         Is34zZ+TyJZ+1hljX4bqxwOZHAyRNgin1icit0bffH88rtH79iKFNXPMuOvwKF5sws
         ebXX9JLGcf+FQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 1/2] dt-bindings: arm: mtk-clock: Remove unnecessary 'items' and fix formatting
Date:   Wed, 18 May 2022 11:36:30 +0200
Message-Id: <20220518093631.25491-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
References: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino	Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/mediatek/mediatek,mt8186-clock.yaml   | 28 ++++-----
 .../arm/mediatek/mediatek,mt8192-clock.yaml   | 45 +++++++-------
 .../arm/mediatek/mediatek,mt8195-clock.yaml   | 58 +++++++++----------
 3 files changed, 65 insertions(+), 66 deletions(-)

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

