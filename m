Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AB1540466
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbiFGRJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345442AbiFGRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:09:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD185A15C;
        Tue,  7 Jun 2022 10:09:29 -0700 (PDT)
X-UUID: e2da1a5048054ebda342996bb87e28c2-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:3c3c21dc-8b5e-46e4-b9d0-c56b7e996abc,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:2a19b09,CLOUDID:3236f9e4-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: e2da1a5048054ebda342996bb87e28c2-20220608
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 402892439; Wed, 08 Jun 2022 01:09:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Tue, 7 Jun 2022 17:09:22 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 7 Jun 2022 22:06:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jun 2022 22:06:06 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <cw00.choi@samsung.com>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>
CC:     <khilman@kernel.org>, <djakov@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH v7 1/2] dt-bindings: interconnect: Add MediaTek CCI dt-bindings
Date:   Tue, 7 Jun 2022 22:05:55 +0800
Message-ID: <20220607140556.6278-2-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220607140556.6278-1-johnson.wang@mediatek.com>
References: <20220607140556.6278-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding of MediaTek CCI on MT8183 and MT8186.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Georgi Djakov <djakov@kernel.org>
---
 .../bindings/interconnect/mediatek,cci.yaml   | 141 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
new file mode 100644
index 000000000000..449c7c988229
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/mediatek,cci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Cache Coherent Interconnect (CCI) frequency and voltage scaling
+
+maintainers:
+  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
+  - Johnson Wang <johnson.wang@mediatek.com>
+
+description: |
+  MediaTek Cache Coherent Interconnect (CCI) is a hardware engine used by
+  MT8183 and MT8186 SoCs to scale the frequency and adjust the voltage in
+  hardware. It can also optimize the voltage to reduce the power consumption.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8183-cci
+      - mediatek,mt8186-cci
+
+  clocks:
+    items:
+      - description:
+          The multiplexer for clock input of the bus.
+      - description:
+          A parent of "bus" clock which is used as an intermediate clock source
+          when the original clock source (PLL) is under transition and not
+          stable yet.
+
+  clock-names:
+    items:
+      - const: cci
+      - const: intermediate
+
+  operating-points-v2: true
+  opp-table: true
+
+  proc-supply:
+    description:
+      Phandle of the regulator for CCI that provides the supply voltage.
+
+  sram-supply:
+    description:
+      Phandle of the regulator for sram of CCI that provides the supply
+      voltage. When it is present, the implementation needs to do
+      "voltage tracking" to step by step scale up/down Vproc and Vsram to fit
+      SoC specific needs. When absent, the voltage scaling flow is handled by
+      hardware, hence no software "voltage tracking" is needed.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - operating-points-v2
+  - proc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    cci: cci {
+        compatible = "mediatek,mt8183-cci";
+        clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+                 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+        clock-names = "cci", "intermediate";
+        operating-points-v2 = <&cci_opp>;
+        proc-supply = <&mt6358_vproc12_reg>;
+    };
+
+    cci_opp: opp-table-cci {
+        compatible = "operating-points-v2";
+        opp-shared;
+        opp2_00: opp-273000000 {
+            opp-hz = /bits/ 64 <273000000>;
+            opp-microvolt = <650000>;
+        };
+        opp2_01: opp-338000000 {
+            opp-hz = /bits/ 64 <338000000>;
+            opp-microvolt = <687500>;
+        };
+        opp2_02: opp-403000000 {
+            opp-hz = /bits/ 64 <403000000>;
+            opp-microvolt = <718750>;
+        };
+        opp2_03: opp-463000000 {
+            opp-hz = /bits/ 64 <463000000>;
+            opp-microvolt = <756250>;
+        };
+        opp2_04: opp-546000000 {
+            opp-hz = /bits/ 64 <546000000>;
+            opp-microvolt = <800000>;
+        };
+        opp2_05: opp-624000000 {
+            opp-hz = /bits/ 64 <624000000>;
+            opp-microvolt = <818750>;
+        };
+        opp2_06: opp-689000000 {
+            opp-hz = /bits/ 64 <689000000>;
+            opp-microvolt = <850000>;
+        };
+        opp2_07: opp-767000000 {
+            opp-hz = /bits/ 64 <767000000>;
+            opp-microvolt = <868750>;
+        };
+        opp2_08: opp-845000000 {
+            opp-hz = /bits/ 64 <845000000>;
+            opp-microvolt = <893750>;
+        };
+        opp2_09: opp-871000000 {
+            opp-hz = /bits/ 64 <871000000>;
+            opp-microvolt = <906250>;
+        };
+        opp2_10: opp-923000000 {
+            opp-hz = /bits/ 64 <923000000>;
+            opp-microvolt = <931250>;
+        };
+        opp2_11: opp-962000000 {
+            opp-hz = /bits/ 64 <962000000>;
+            opp-microvolt = <943750>;
+        };
+        opp2_12: opp-1027000000 {
+            opp-hz = /bits/ 64 <1027000000>;
+            opp-microvolt = <975000>;
+        };
+        opp2_13: opp-1092000000 {
+            opp-hz = /bits/ 64 <1092000000>;
+            opp-microvolt = <1000000>;
+        };
+        opp2_14: opp-1144000000 {
+            opp-hz = /bits/ 64 <1144000000>;
+            opp-microvolt = <1025000>;
+        };
+        opp2_15: opp-1196000000 {
+            opp-hz = /bits/ 64 <1196000000>;
+            opp-microvolt = <1050000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b54288db77aa..2800ddceb54c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5757,6 +5757,7 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
 F:	Documentation/devicetree/bindings/devfreq/
+F:	Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
 F:	drivers/devfreq/
 F:	include/linux/devfreq.h
 F:	include/trace/events/devfreq.h
-- 
2.18.0

