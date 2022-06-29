Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37355FE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiF2LDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiF2LDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:03:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEEB658A;
        Wed, 29 Jun 2022 04:03:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A5077660191C;
        Wed, 29 Jun 2022 12:03:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656500587;
        bh=TSJ58VdGf/kfLshDwHVh4FvKPSqq+LoxdH9m/wkRPdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKHDUj375Veyo1P5kL4cvW96YgZTL13Y2aBEokQkmXRFkR/agoq/PwW0WLBdbdx3K
         hNe+ffPwba8nanK5j7q2AQEXIykIdPDKR01zzcqrVfvzC6coi8H8/Dvdob3q3dV9Qu
         1CCsH+O/KL+eRdkPi29OC5yclpmh6MQp/pVKM+adXL6d103ZbXxiRIuCd2u+5FvTh4
         ONhcYUOrSFMPdb62xZiUZcXAnvUKmUB4hzWVuGN075YEEaLFsW2Ot4cDUBh/+RumG2
         TFLfnHJh9534mHyXW5ArTk0XSXLJeHyMweWZqo41PLXPZSLGVhQAumnewil7QjIvY7
         FeTZWbeYehi1Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
Subject: [PATCH v5 4/7] dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
Date:   Wed, 29 Jun 2022 13:02:51 +0200
Message-Id: <20220629110254.184213-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
References: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for the clock drivers of the MediaTek Helio X10
MT6795 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++++
 .../clock/mediatek,mt6795-sys-clock.yaml      | 54 +++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
new file mode 100644
index 000000000000..04469eabc8fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt6795-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Functional Clock Controller for MT6795
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+description: |
+  The clock architecture in MediaTek like below
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The devices provide clock gate control in different IP blocks.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6795-mfgcfg
+      - mediatek,mt6795-vdecsys
+      - mediatek,mt6795-vencsys
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mfgcfg: clock-controller@13000000 {
+            compatible = "mediatek,mt6795-mfgcfg";
+            reg = <0 0x13000000 0 0x1000>;
+            #clock-cells = <1>;
+        };
+
+        vdecsys: clock-controller@16000000 {
+            compatible = "mediatek,mt6795-vdecsys";
+            reg = <0 0x16000000 0 0x1000>;
+            #clock-cells = <1>;
+        };
+
+        vencsys: clock-controller@18000000 {
+            compatible = "mediatek,mt6795-vencsys";
+            reg = <0 0x18000000 0 0x1000>;
+            #clock-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
new file mode 100644
index 000000000000..378b761237d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt6795-sys-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Clock Controller for MT6795
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+description:
+  The Mediatek system clock controller provides various clocks and system
+  configuration like reset and bus protection on MT6795.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt6795-apmixedsys
+          - mediatek,mt6795-infracfg
+          - mediatek,mt6795-pericfg
+          - mediatek,mt6795-topckgen
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        topckgen: clock-controller@10000000 {
+            compatible = "mediatek,mt6795-topckgen", "syscon";
+            reg = <0 0x10000000 0 0x1000>;
+            #clock-cells = <1>;
+        };
+    };
-- 
2.35.1

