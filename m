Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1254DAA34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353788AbiCPGDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353731AbiCPGDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:03:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A0606CB;
        Tue, 15 Mar 2022 23:01:57 -0700 (PDT)
X-UUID: 01693fc781b64e3991c9f32d7ce8ed2d-20220316
X-UUID: 01693fc781b64e3991c9f32d7ce8ed2d-20220316
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1656271736; Wed, 16 Mar 2022 14:01:47 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 16 Mar 2022 14:01:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Mar
 2022 14:01:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 14:01:46 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <angelogioacchino.delregno@collabora.com>,
        <yc.hung@mediatek.com>
Subject: [PATCH v2 2/5] ASoC: dt-bindings: mediatek: mt8195: merge mt8195 machine yaml
Date:   Wed, 16 Mar 2022 14:01:36 +0800
Message-ID: <20220316060139.6211-3-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220316060139.6211-1-trevor.wu@mediatek.com>
References: <20220316060139.6211-1-trevor.wu@mediatek.com>
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

Because the same binding components can be shared by all codecs
combinations, we only reserve one binding file for mt8195 machine driver
and rename to a generic name.

We use compatible string to separate different codec combination instead
of creating a new binding file for new codec combination.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    | 51 -------------------
 ...-rt1019-rt5682.yaml => mt8195-mt6359.yaml} |  8 +--
 2 files changed, 5 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
 rename Documentation/devicetree/bindings/sound/{mt8195-mt6359-rt1019-rt5682.yaml => mt8195-mt6359.yaml} (87%)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
deleted file mode 100644
index cf6ad7933e23..000000000000
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
+++ /dev/null
@@ -1,51 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/mt8195-mt6359-rt1011-rt5682.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mediatek MT8195 with MT6359, RT1011 and RT5682 ASoC sound card driver
-
-maintainers:
-  - Trevor Wu <trevor.wu@mediatek.com>
-
-description:
-  This binding describes the MT8195 sound card with RT1011 and RT5682.
-
-properties:
-  compatible:
-    const: mediatek,mt8195_mt6359_rt1011_rt5682
-
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
-  mediatek,platform:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 ASoC platform.
-
-  mediatek,dptx-codec:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 Display Port Tx codec node.
-
-  mediatek,hdmi-codec:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 HDMI codec node.
-
-additionalProperties: false
-
-required:
-  - compatible
-  - mediatek,platform
-
-examples:
-  - |
-
-    sound: mt8195-sound {
-        compatible = "mediatek,mt8195_mt6359_rt1011_rt5682";
-        mediatek,platform = <&afe>;
-        pinctrl-names = "default";
-        pinctrl-0 = <&aud_pins_default>;
-    };
-
-...
diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
similarity index 87%
rename from Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
rename to Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
index 8f177e02ad35..74227fba91c7 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/mt8195-mt6359-rt1019-rt5682.yaml#
+$id: http://devicetree.org/schemas/sound/mt8195-mt6359.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8195 with MT6359, RT1019 and RT5682 ASoC sound card driver
+title: Mediatek MT8195 ASoC sound card driver
 
 maintainers:
   - Trevor Wu <trevor.wu@mediatek.com>
@@ -14,7 +14,9 @@ description:
 
 properties:
   compatible:
-    const: mediatek,mt8195_mt6359_rt1019_rt5682
+    enum:
+      - mediatek,mt8195_mt6359_rt1019_rt5682
+      - mediatek,mt8195_mt6359_rt1011_rt5682
 
   model:
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.18.0

