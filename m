Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694EB52E548
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346004AbiETGtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343544AbiETGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:49:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B16A14CDF3;
        Thu, 19 May 2022 23:49:35 -0700 (PDT)
X-UUID: 416eb733717b4b038b0d5a7018f92c22-20220520
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.5,REQID:5cef92da-3a01-44ef-8f32-9de96ff7b0c7,OB:10,L
        OB:0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS6885
        AD,ACTION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.5,REQID:5cef92da-3a01-44ef-8f32-9de96ff7b0c7,OB:10,LOB
        :0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:120
X-CID-META: VersionHash:2a19b09,CLOUDID:7136e9e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:49a5bc0a18bc,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 416eb733717b4b038b0d5a7018f92c22-20220520
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 555473026; Fri, 20 May 2022 14:49:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 14:49:26 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 14:49:25 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei-Shun Chang <weishunc@google.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Subject: [PATCH v9 1/2] dt-bindings: phy: mediatek: Add YAML schema for PCIe PHY
Date:   Fri, 20 May 2022 14:49:19 +0800
Message-ID: <20220520064920.27313-2-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520064920.27313-1-jianjun.wang@mediatek.com>
References: <20220520064920.27313-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML schema documentation for PCIe PHY on MediaTek chipsets.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/phy/mediatek,pcie-phy.yaml       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
new file mode 100644
index 000000000000..422750cc4121
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek PCIe PHY
+
+maintainers:
+  - Jianjun Wang <jianjun.wang@mediatek.com>
+
+description: |
+  The PCIe PHY supports physical layer functionality for PCIe Gen3 port.
+
+properties:
+  compatible:
+    const: mediatek,mt8195-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: sif
+
+  "#phy-cells":
+    const: 0
+
+  nvmem-cells:
+    maxItems: 7
+    description:
+      Phandles to nvmem cell that contains the efuse data, if unspecified,
+      default value is used.
+
+  nvmem-cell-names:
+    items:
+      - const: glb_intr
+      - const: tx_ln0_pmos
+      - const: tx_ln0_nmos
+      - const: rx_ln0
+      - const: tx_ln1_pmos
+      - const: tx_ln1_nmos
+      - const: rx_ln1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@11e80000 {
+        compatible = "mediatek,mt8195-pcie-phy";
+        #phy-cells = <0>;
+        reg = <0x11e80000 0x10000>;
+        reg-names = "sif";
+        nvmem-cells = <&pciephy_glb_intr>,
+                      <&pciephy_tx_ln0_pmos>,
+                      <&pciephy_tx_ln0_nmos>,
+                      <&pciephy_rx_ln0>,
+                      <&pciephy_tx_ln1_pmos>,
+                      <&pciephy_tx_ln1_nmos>,
+                      <&pciephy_rx_ln1>;
+        nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
+                           "tx_ln0_nmos", "rx_ln0",
+                           "tx_ln1_pmos", "tx_ln1_nmos",
+                           "rx_ln1";
+        power-domains = <&spm 2>;
+    };
-- 
2.18.0

