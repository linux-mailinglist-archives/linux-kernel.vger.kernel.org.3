Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349384DC106
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiCQIYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCQIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:24:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439E21C64BB;
        Thu, 17 Mar 2022 01:23:12 -0700 (PDT)
X-UUID: 57e86c3c97e041ac8ea5d6ec17fc49aa-20220317
X-UUID: 57e86c3c97e041ac8ea5d6ec17fc49aa-20220317
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 622322257; Thu, 17 Mar 2022 16:23:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Mar 2022 16:23:06 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 16:23:04 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder cores dt-bindings for mt8195
Date:   Thu, 17 Mar 2022 16:22:23 +0800
Message-ID: <20220317082230.23622-4-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317082230.23622-1-irui.wang@mediatek.com>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds encoder cores dt-bindings for mt8195.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../media/mediatek,vcodec-encoder-core.yaml   | 181 ++++++++++++++++++
 .../media/mediatek,vcodec-encoder.yaml        |   1 -
 2 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
new file mode 100644
index 000000000000..fcfb48900c76
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek Video Encoder Accelerator With Multi Core
+
+maintainers:
+  - Irui Wang <irui.wang@mediatek.com>
+
+description: |
+  Mediatek Video Encode is the video encode hardware present in Mediatek
+  SoCs which supports high resolution encoding functionalities. Required
+  parent and child device node.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8195-vcodec-enc
+
+  mediatek,scp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      The node of system control processor (SCP), using
+      the remoteproc & rpmsg framework.
+
+  mediatek,venc-multi-core:
+    type: boolean
+    description: |
+      Indicates whether the encoder has multiple cores or not.
+
+  iommus:
+    minItems: 1
+    maxItems: 32
+    description: |
+      List of the hardware port in respective IOMMU block for current Socs.
+      Refer to bindings/iommu/mediatek,iommu.yaml.
+
+  dma-ranges:
+    maxItems: 1
+    description: |
+      Describes the physical address space of IOMMU maps to memory.
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+# Required child node:
+patternProperties:
+  "^venc-core@[0-9a-f]+$":
+    type: object
+    description: |
+      The video encoder core device node which should be added as subnodes to
+      the main venc node.
+
+    properties:
+      compatible:
+        items:
+         - const: mediatek,mtk-venc-core
+
+      reg:
+        maxItems: 1
+
+      mediatek,core-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Current encoder core id.
+
+      iommus:
+        minItems: 1
+        maxItems: 32
+        description: |
+          List of the hardware port in respective IOMMU block for current Socs.
+          Refer to bindings/iommu/mediatek,iommu.yaml.
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - mediatek,core-id
+      - iommus
+      - interrupts
+      - clocks
+      - clock-names
+      - assigned-clocks
+      - assigned-clock-parents
+      - power-domains
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - mediatek,scp
+  - iommus
+  - dma-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt8195-memory-port.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        venc {
+            compatible = "mediatek,mt8195-vcodec-enc";
+            mediatek,scp = <&scp>;
+            mediatek,venc-multi-core;
+            iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+
+            venc-core@1a020000 {
+                compatible = "mediatek,mtk-venc-core";
+                reg = <0 0x1a020000 0 0x10000>;
+                mediatek,core-id = <0>;
+                iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>,
+                         <&iommu_vdo M4U_PORT_L19_VENC_REC>,
+                         <&iommu_vdo M4U_PORT_L19_VENC_BSDMA>,
+                         <&iommu_vdo M4U_PORT_L19_VENC_SV_COMV>,
+                         <&iommu_vdo M4U_PORT_L19_VENC_RD_COMV>,
+                         <&iommu_vdo M4U_PORT_L19_VENC_CUR_LUMA>,
+                         <&iommu_vdo M4U_PORT_L19_VENC_CUR_CHROMA>,
+                         <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
+                         <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
+                interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
+                clocks = <&vencsys CLK_VENC_VENC>;
+                clock-names = "clk_venc";
+                assigned-clocks = <&topckgen CLK_TOP_VENC>;
+                assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+                power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
+            };
+
+            venc-core@1b020000 {
+                compatible = "mediatek,mtk-venc-core";
+                reg = <0 0x1b020000 0 0x10000>;
+                mediatek,core-id = <1>;
+                iommus = <&iommu_vpp M4U_PORT_L20_VENC_RCPU>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_REC>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_BSDMA>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_SV_COMV>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_RD_COMV>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_CUR_LUMA>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_CUR_CHROMA>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_REF_LUMA>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_REF_CHROMA>;
+                interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH 0>;
+                clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>;
+                clock-names = "clk_venc_core1";
+                assigned-clocks = <&topckgen CLK_TOP_VENC>;
+                assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+                power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index e7b65a91c92c..0530a694bcbe 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -21,7 +21,6 @@ properties:
       - mediatek,mt8173-vcodec-enc
       - mediatek,mt8183-vcodec-enc
       - mediatek,mt8192-vcodec-enc
-      - mediatek,mt8195-vcodec-enc
 
   reg:
     maxItems: 1
-- 
2.18.0

