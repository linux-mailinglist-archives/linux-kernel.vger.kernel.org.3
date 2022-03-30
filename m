Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC04EB9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbiC3FOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbiC3FOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:14:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD699BB92;
        Tue, 29 Mar 2022 22:12:26 -0700 (PDT)
X-UUID: d0f022349abf4372afe2f72ada015375-20220330
X-UUID: d0f022349abf4372afe2f72ada015375-20220330
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 565690540; Wed, 30 Mar 2022 13:12:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 30 Mar 2022 13:12:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 13:12:02 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <granquet@baylibre.com>
CC:     <airlied@linux.ie>, <angelogioacchino.delregno@collabora.com>,
        <chunfeng.yun@mediatek.com>, <chunkuang.hu@kernel.org>,
        <ck.hu@mediatek.com>, <daniel@ffwll.ch>, <deller@gmx.de>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <jitao.shi@mediatek.com>, <kishon@ti.com>, <krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        <maarten.lankhorst@linux.intel.com>, <markyacoub@google.com>,
        <matthias.bgg@gmail.com>, <mripard@kernel.org>, <msp@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <tzimmermann@suse.de>, <vkoul@kernel.org>
Subject: Re: [PATCH v9 02/22] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Wed, 30 Mar 2022 13:12:02 +0800
Message-ID: <20220330051202.19594-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220327223927.20848-3-granquet@baylibre.com>
References: <20220327223927.20848-3-granquet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This controller is present on several mediatek hardware. Currently
>mt8195 and mt8395 have this controller without a functional difference,
>so only one compatible field is added.
>
>The controller can have two forms, as a normal display port and as an
>embedded display port.
>
>Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>---
> .../display/mediatek/mediatek,dp.yaml         | 100 ++++++++++++++++++
> 1 file changed, 100 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
>
>diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
>new file mode 100644
>index 000000000000..802cc406c72b
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
>@@ -0,0 +1,100 @@
>+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>+%YAML 1.2
>+---
>+$id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>+
>+title: Mediatek Display Port Controller

s/Mediatek/MediaTek/

>+
>+maintainers:
>+  - CK Hu <ck.hu@mediatek.com>
>+  - Jitao shi <jitao.shi@mediatek.com>
>+
>+description: |
>+  Device tree bindings for the Mediatek (embedded) Display Port controller

s/Mediatek/MediaTek/

>+  present on some Mediatek SoCs.

s/Mediatek/MediaTek/

>+
>+properties:
>+  compatible:
>+    items:
>+      - const: mediatek,mt8195-dp-tx
>+      - const: syscon
>+
>+  reg:
>+    maxItems: 1
>+
>+  interrupts:
>+    maxItems: 1
>+
>+  clocks:
>+    items:
>+      - description: faxi clock
>+
>+  clock-names:
>+    items:
>+      - const: faxi
>+
>+  phys:
>+    maxItems: 1
>+
>+  phy-names:
>+    items:
>+      - const: dp
>+
>+  power-domains:
>+    maxItems: 1
>+
>+  ports:
>+    $ref: /schemas/graph.yaml#/properties/ports
>+    properties:
>+      port@0:
>+        $ref: /schemas/graph.yaml#/properties/port
>+        description: Input endpoint of the controller, usually dp_intf
>+
>+      port@1:
>+        $ref: /schemas/graph.yaml#/properties/port
>+        description: Output endpoint of the controller
>+
>+    required:
>+      - port@0
>+
>+required:
>+  - compatible
>+  - reg
>+  - interrupts
>+  - ports
>+
>+additionalProperties: false
>+
>+examples:
>+  - |
>+    #include <dt-bindings/interrupt-controller/arm-gic.h>
>+    #include <dt-bindings/power/mt8195-power.h>
>+    edp_tx: edisplay-port-tx@1c500000 {
>+        compatible = "mediatek,mt8195-dp-tx","syscon";
>+        reg = <0 0x1c500000 0 0x8000>;
>+        interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
>+        power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
>+        pinctrl-names = "default";
>+        pinctrl-0 = <&edp_pin>;
>+        phys = <&dp_phy>;
>+        phy-names = "dp";
>+
>+        ports {
>+            #address-cells = <1>;
>+            #size-cells = <0>;
>+
>+            port@0 {
>+                reg = <0>;
>+                edp_in: endpoint {
>+                    remote-endpoint = <&dp_intf0_out>;
>+                };
>+            };
>+            port@1 {
>+                reg = <1>;
>+                edp_out: endpoint {
>+                    remote-endpoint = <&panel_in>;
>+                };
>+            };
>+        };
>+    };
>-- 
>2.34.1
>
>
