Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A64F4B2369
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349221AbiBKKjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:39:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349126AbiBKKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:38:51 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E01D45;
        Fri, 11 Feb 2022 02:38:46 -0800 (PST)
X-UUID: 6c63780a1da94e92865e7e90e5dde4a2-20220211
X-UUID: 6c63780a1da94e92865e7e90e5dde4a2-20220211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1836664229; Fri, 11 Feb 2022 18:38:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 11 Feb 2022 18:38:39 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 18:38:38 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>
CC:     <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <zhangqilong3@huawei.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH 15/15] dt-bindings: mediatek: mt8186: add mt8186-mt6366-rt1019-rt5682 document
Date:   Fri, 11 Feb 2022 18:38:18 +0800
Message-ID: <20220211103818.8266-16-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
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

This patch adds document for mt8186 board with mt6366, rt1019 and rt5682.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 .../sound/mt8186-mt6366-rt1019-rt5682.yaml    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682.yaml

diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682.yaml
new file mode 100644
index 000000000000..32ca724334c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mt8186-mt6366-rt1019-rt5682.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT8186 with MT6366, RT1019 and RT5682 ASoC sound card driver
+
+maintainers:
+  - Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+description:
+  This binding describes the MT8186 sound card.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8186_mt6366_rt1019_rt5682_sound
+
+  mediatek,platform:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of MT8186 ASoC platform.
+
+  mediatek,hdmi-codec:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of HDMI codec.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - mediatek,platform
+
+examples:
+  - |
+
+    sound: mt8192-sound {
+        compatible = "mediatek,mt8186_mt6366_rt1019_rt5682_sound";
+        mediatek,platform = <&afe>;
+        mediatek,hdmi-codec = <&it6505dptx>;
+        pinctrl-names = "aud_clk_mosi_off",
+                        "aud_clk_mosi_on";
+        pinctrl-0 = <&aud_clk_mosi_off>;
+        pinctrl-1 = <&aud_clk_mosi_on>;
+    };
+
+...
-- 
2.18.0

