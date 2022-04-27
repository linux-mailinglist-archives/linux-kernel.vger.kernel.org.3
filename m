Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8395111EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358591AbiD0HJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345769AbiD0HIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:08:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A780F13EBB;
        Wed, 27 Apr 2022 00:05:25 -0700 (PDT)
X-UUID: ebf483ee16554bfda565f122a8f9d019-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:02e775f8-7934-4609-b75e-6cf690b5cdb6,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:faefae9,CLOUDID:7d36a5c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: ebf483ee16554bfda565f122a8f9d019-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 763365487; Wed, 27 Apr 2022 15:05:18 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Apr 2022 15:05:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 15:05:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 15:05:16 +0800
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v14 1/3] dt-binding: mediatek: add bindings for MediaTek MDP3 components
Date:   Wed, 27 Apr 2022 15:05:12 +0800
Message-ID: <20220427070514.10355-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220427070514.10355-1-moudy.ho@mediatek.com>
References: <20220427070514.10355-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT binding documents for Media Data Path 3 (MDP3)
a unit in multimedia system combined with several components and
used for scaling and color format convert.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../bindings/media/mediatek,mdp3-rdma.yaml    | 82 +++++++++++++++++++
 .../bindings/media/mediatek,mdp3-rsz.yaml     | 61 ++++++++++++++
 .../bindings/media/mediatek,mdp3-wrot.yaml    | 66 +++++++++++++++
 .../bindings/soc/mediatek/mediatek,ccorr.yaml | 54 ++++++++++++
 .../bindings/soc/mediatek/mediatek,wdma.yaml  | 67 +++++++++++++++
 5 files changed, 330 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
new file mode 100644
index 000000000000..ce24eda14cb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Read Direct Memory Access
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+
+description: |
+  Mediatek Read Direct Memory Access(RDMA) component used to do read DMA.
+  It contains one line buffer to store the sufficient pixel data, and
+  must be siblings to the central MMSYS_CONFIG node.
+  For a description of the MMSYS_CONFIG binding, see
+  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+  for details.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt8183-mdp3-rdma
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    maxItems: 1
+    description: |
+      The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: RDMA clock
+      - description: RSZ clock
+
+  iommus:
+    maxItems: 1
+
+  mboxes:
+    items:
+      - description: used for 1st data pipe from RDMA
+      - description: used for 2nd data pipe from RDMA
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - power-domains
+  - clocks
+  - iommus
+  - mboxes
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
+    mdp3_rdma0: mdp3-rdma0@14001000 {
+      compatible = "mediatek,mt8183-mdp3-rdma";
+      reg = <0x14001000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
+      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+      clocks = <&mmsys CLK_MM_MDP_RDMA0>,
+               <&mmsys CLK_MM_MDP_RSZ1>;
+      iommus = <&iommu>;
+      mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
+               <&gce 21 CMDQ_THR_PRIO_LOWEST>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
new file mode 100644
index 000000000000..ebc124f86dc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-rsz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Resizer
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to do frame resizing.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8183-mdp3-rsz
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+    mdp3_rsz0: mdp3-rsz0@14003000 {
+      compatible = "mediatek,mt8183-mdp3-rsz";
+      reg = <0x14003000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>;
+      clocks = <&mmsys CLK_MM_MDP_RSZ0>;
+    };
+
+    mdp3_rsz1: mdp3-rsz1@14004000 {
+      compatible = "mediatek,mt8183-mdp3-rsz";
+      reg = <0x14004000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x4000 0x1000>;
+      clocks = <&mmsys CLK_MM_MDP_RSZ1>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
new file mode 100644
index 000000000000..a19d536d5a9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-wrot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Write DMA with Rotation
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to write DMA with frame rotation.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8183-mdp3-wrot
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+    mdp3_wrot0: mdp3-wrot0@14005000 {
+      compatible = "mediatek,mt8183-mdp3-wrot";
+      reg = <0x14005000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
+      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+      clocks = <&mmsys CLK_MM_MDP_WROT0>;
+      iommus = <&iommu>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
new file mode 100644
index 000000000000..582f5eff93ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
@@ -0,0 +1,54 @@
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
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
index 000000000000..f60c60c5dd81
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
@@ -0,0 +1,67 @@
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
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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

