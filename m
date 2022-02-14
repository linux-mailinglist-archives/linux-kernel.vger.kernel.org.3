Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50954B5299
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354788AbiBNOBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:01:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354804AbiBNOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:01:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2018C4A3D0;
        Mon, 14 Feb 2022 06:01:29 -0800 (PST)
X-UUID: e44e341af8bf4330809b24a4d5b3ece2-20220214
X-UUID: e44e341af8bf4330809b24a4d5b3ece2-20220214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1351013192; Mon, 14 Feb 2022 22:01:25 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Feb 2022 22:01:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 22:01:23 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 14 Feb 2022 22:01:22 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        xinlei lee <xinlei.lee@mediatek.com>
Subject: [1/1] dt-bindings: pwm:Convert pwm-mtk-disp.txt format file to pwm-mtk-disp.yaml format file
Date:   Mon, 14 Feb 2022 22:01:16 +0800
Message-ID: <1644847276-27622-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1644847276-27622-1-git-send-email-xinlei.lee@mediatek.com>
References: <1644847276-27622-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xinlei lee <xinlei.lee@mediatek.com>

Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-mtk-disp.yaml      | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
new file mode 100644
index 0000000..2f1183e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-mtk-disp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: mediatek PWM Controller Device Tree Bindings
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+  - Lee Jones <lee.jones@linaro.org>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt2701-disp-pwm
+      - mediatek,mt6595-disp-pwm
+      - mediatek,mt8173-disp-pwm
+      - mediatek,mt8183-disp-pwm
+      - mediatek,mt8186-disp-pwm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Clock
+      - description: Mm Clock
+
+  clock-names:
+    items:
+      - const: main
+      - const: mm
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8186-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    disp_pwm: disp_pwm0@1100e000 {
+        compatible = "mediatek,mt8183-disp-pwm";
+        reg = <0x1100e000 0x1000>;
+        interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&topckgen CLK_TOP_DISP_PWM>,
+                 <&infracfg_ao CLK_INFRA_AO_DISP_PWM>;
+        clock-names = "main", "mm";
+        status = "okay";
+    };
\ No newline at end of file
-- 
2.6.4

