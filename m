Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ECE52E77C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347231AbiETIbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347152AbiETIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:30:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB3154B3C;
        Fri, 20 May 2022 01:30:13 -0700 (PDT)
X-UUID: 41405730c003445a81b485da79845711-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ef7d4511-139d-404f-b567-0802b063af5f,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:2a19b09,CLOUDID:c177fd79-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 41405730c003445a81b485da79845711-20220520
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2006429441; Fri, 20 May 2022 16:30:09 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 16:30:08 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 16:30:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 16:30:07 +0800
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
        <cellopoint.kai@gmail.com>,
        Moudy Ho <moudy.ho@mediatek.corp-partner.google.com>
Subject: [PATCH v16 1/4] dt-binding: mediatek: add bindings for MediaTek MDP3 components
Date:   Fri, 20 May 2022 16:30:03 +0800
Message-ID: <20220520083006.27789-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220520083006.27789-1-moudy.ho@mediatek.com>
References: <20220520083006.27789-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moudy Ho <moudy.ho@mediatek.corp-partner.google.com>

This patch adds DT binding documents for Media Data Path 3 (MDP3)
a unit in multimedia system combined with several components and
used for scaling and color format convert.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/mediatek,mdp3-rdma.yaml    | 85 +++++++++++++++++++
 .../bindings/media/mediatek,mdp3-rsz.yaml     | 65 ++++++++++++++
 .../bindings/media/mediatek,mdp3-wrot.yaml    | 70 +++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
new file mode 100644
index 000000000000..4fe704e476dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
@@ -0,0 +1,85 @@
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
index 000000000000..7b566fbec3c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
@@ -0,0 +1,65 @@
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
index 000000000000..5481d4e43315
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
@@ -0,0 +1,70 @@
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
+    mdp3_wrot0: mdp3-wrot0@14005000 {
+      compatible = "mediatek,mt8183-mdp3-wrot";
+      reg = <0x14005000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
+      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+      clocks = <&mmsys CLK_MM_MDP_WROT0>;
+      iommus = <&iommu>;
+    };
-- 
2.18.0

