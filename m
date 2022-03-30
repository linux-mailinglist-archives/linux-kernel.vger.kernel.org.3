Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE024EB9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbiC3FOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242795AbiC3FOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:14:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C29BAED;
        Tue, 29 Mar 2022 22:12:28 -0700 (PDT)
X-UUID: c788adcedbfb4701b48689ef8bb3e588-20220330
X-UUID: c788adcedbfb4701b48689ef8bb3e588-20220330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 838381258; Wed, 30 Mar 2022 13:12:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Mar 2022 13:12:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 13:12:17 +0800
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
        <matthias.bgg@gmail.com>, <mripard@kernel.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <tzimmermann@suse.de>, <vkoul@kernel.org>
Subject: Re: [PATCH v9 03/22] dt-bindings: mediatek,dp_phy: Add Display Port PHY binding
Date:   Wed, 30 Mar 2022 13:12:17 +0800
Message-ID: <20220330051217.19789-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220327223927.20848-4-granquet@baylibre.com>
References: <20220327223927.20848-4-granquet@baylibre.com>
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

>This phy controller is embedded in the Display Port Controller on mt8195 SoCs.
>
>Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>---
> .../bindings/phy/mediatek,dp-phy.yaml         | 43 +++++++++++++++++++
> 1 file changed, 43 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
>
>diff --git a/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
>new file mode 100644
>index 000000000000..1f5ffca4e140
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
>@@ -0,0 +1,43 @@
>+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>+# Copyright (c) 2022 MediaTek
>+%YAML 1.2
>+---
>+$id: http://devicetree.org/schemas/phy/mediatek,dp-phy.yaml#
>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>+
>+title: MediaTek Display Port PHY
>+
>+maintainers:
>+  - CK Hu <ck.hu@mediatek.com>
>+  - Jitao shi <jitao.shi@mediatek.com>
>+
>+description: |
>+  Device tree bindings for the Mediatek (embedded) Display Port PHY

s/Mediatek/MediaTek/

>+  present on some Mediatek SoCs.

s/Mediatek/MediaTek/

>+
>+properties:
>+  compatible:
>+    enum:
>+      - mediatek,mt8195-dp-phy
>+
>+  mediatek,dp-syscon:
>+    $ref: /schemas/types.yaml#/definitions/phandle
>+    description: Phandle to the Display Port node.
>+
>+  "#phy-cells":
>+    const: 0
>+
>+required:
>+  - compatible
>+  - mediatek,dp-syscon
>+  - "#phy-cells"
>+
>+additionalProperties: false
>+
>+examples:
>+  - |
>+    dp_phy: dp-phy {
>+      compatible = "mediatek,mt8195-dp-phy";
>+      mediatek,dp-syscon = <&dp_tx>;
>+      #phy-cells = <0>;
>+    };
>-- 
>2.34.1
>
>
