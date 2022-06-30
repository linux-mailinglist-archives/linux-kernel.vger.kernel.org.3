Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3574F5615C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiF3JO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiF3JOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:14:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A29205EC;
        Thu, 30 Jun 2022 02:14:15 -0700 (PDT)
X-UUID: a3b5a3e2ccf147f9938a64c107970b6f-20220630
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.7,REQID:f9ae2d3f-d6e5-4837-8b68-5d48511e06da,OB:10,L
        OB:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.7,REQID:f9ae2d3f-d6e5-4837-8b68-5d48511e06da,OB:10,LOB
        :0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:120
X-CID-META: VersionHash:87442a2,CLOUDID:81f22f86-57f0-47ca-ba27-fe8c57fbf305,C
        OID:70c20fffc513,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: a3b5a3e2ccf147f9938a64c107970b6f-20220630
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1864564924; Thu, 30 Jun 2022 17:14:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 30 Jun 2022 17:14:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Jun 2022 17:14:09 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <moudy.ho@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <cellopoint.kai@gmail.com>
Subject: [PATCH v20 2/4] dt-binding: mediatek: add bindings for MediaTek CCORR and WDMA
Date:   Thu, 30 Jun 2022 17:14:06 +0800
Message-ID: <20220630091408.6438-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220630091408.6438-1-moudy.ho@mediatek.com>
References: <20220630091408.6438-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT binding documentation for MediaTek's CCORR and
WDMA components.
These components exist in both MediaTek's Media Data Path 3(MDP3) and DRM,
and the bindings are placed under the folder "./soc/mediatek" to prevent
duplicate builds.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/soc/mediatek/mediatek,ccorr.yaml | 58 +++++++++++++++
 .../bindings/soc/mediatek/mediatek,wdma.yaml  | 71 +++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
new file mode 100644
index 000000000000..20d02cb4ad0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,ccorr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek color correction
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+
+description: |
+  Mediatek color correction with 3X3 matrix.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8183-mdp3-ccorr
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/gce/mt8183-gce.h>
+
+    mdp3_ccorr: mdp3-ccorr@1401c000 {
+      compatible = "mediatek,mt8183-mdp3-ccorr";
+      reg = <0x1401c000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xc000 0x1000>;
+      clocks = <&mmsys CLK_MM_MDP_CCORR>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
new file mode 100644
index 000000000000..102d9e163139
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,wdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Write Direct Memory Access
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+
+description: |
+  Mediatek Write Direct Memory Access(WDMA) component used to write
+  the data into DMA.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8183-mdp3-wdma
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - power-domains
+  - clocks
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/gce/mt8183-gce.h>
+    #include <dt-bindings/power/mt8183-power.h>
+    #include <dt-bindings/memory/mt8183-larb-port.h>
+
+    mdp3_wdma: mdp3-wdma@14006000 {
+      compatible = "mediatek,mt8183-mdp3-wdma";
+      reg = <0x14006000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
+      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+      clocks = <&mmsys CLK_MM_MDP_WDMA0>;
+      iommus = <&iommu>;
+    };
-- 
2.18.0

