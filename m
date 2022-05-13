Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62F525A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376750AbiEMD3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376737AbiEMD26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:28:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A525A20E0A3;
        Thu, 12 May 2022 20:28:56 -0700 (PDT)
X-UUID: fd3ee12a5fa24a3cbe89af3ed9bee05c-20220513
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.4,REQID:b4e0812c-5bd6-45f2-b051-2a872bcc4d1b,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:125
X-CID-INFO: VERSION:1.1.4,REQID:b4e0812c-5bd6-45f2-b051-2a872bcc4d1b,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:125
X-CID-META: VersionHash:faefae9,CLOUDID:5c7924a7-eab7-4b74-a74d-5359964535a9,C
        OID:b353f2b42eba,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: fd3ee12a5fa24a3cbe89af3ed9bee05c-20220513
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1903576602; Fri, 13 May 2022 11:28:52 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 13 May 2022 11:28:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 May 2022 11:28:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 May 2022 11:28:51 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <cw00.choi@samsung.com>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>
CC:     <djakov@kernel.org>, <khilman@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [RESEND v4 1/2] dt-bindings: interconnect: Add MediaTek CCI dt-bindings
Date:   Fri, 13 May 2022 11:28:31 +0800
Message-ID: <20220513032832.17645-2-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220513032832.17645-1-johnson.wang@mediatek.com>
References: <20220513032832.17645-1-johnson.wang@mediatek.com>
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

Add devicetree binding of MediaTek CCI on MT8183 and MT8186.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../bindings/interconnect/mediatek,cci.yaml   | 140 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
new file mode 100644
index 000000000000..034c3b38ca3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
@@ -0,0 +1,140 @@
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
+          A parent of "cpu" clock which is used as an intermediate clock source
+          when the original CPU is under transition and not stable yet.
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
index e8c52d0192a6..69f03077f77c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5698,6 +5698,7 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
 F:	Documentation/devicetree/bindings/devfreq/
+F:	Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
 F:	drivers/devfreq/
 F:	include/linux/devfreq.h
 F:	include/trace/events/devfreq.h
-- 
2.18.0

