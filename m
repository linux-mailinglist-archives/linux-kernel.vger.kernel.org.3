Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF484C9D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiCBFcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiCBFcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:32:48 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230517E3A;
        Tue,  1 Mar 2022 21:32:01 -0800 (PST)
X-UUID: 92ac1503dd904715a2f934bc4ad0522d-20220302
X-UUID: 92ac1503dd904715a2f934bc4ad0522d-20220302
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1169053540; Wed, 02 Mar 2022 13:31:56 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 2 Mar 2022 13:31:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Mar
 2022 13:31:54 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 2 Mar 2022 13:31:53 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, <allen-kh.cheng@mediatek.com>,
        <rex-bc.chen@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v3,1/6] dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format
Date:   Wed, 2 Mar 2022 13:31:41 +0800
Message-ID: <1646199106-26879-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
References: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format.

Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
 .../bindings/pwm/mediatek,pwm-disp.yaml       | 65 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 -------------
 2 files changed, 65 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
new file mode 100644
index 000000000000..f844695d605a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/mediatek,pwm-disp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek DISP_PWM Controller Device Tree Bindings
+
+maintainers:
+  - Jitao Shi <jitao.shi@mediatek.com>
+  - Xinlei Lee <xinlei.lee@mediatek.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-disp-pwm
+          - mediatek,mt6595-disp-pwm
+          - mediatek,mt8173-disp-pwm
+      - items:
+          - const: mediatek,mt8167-disp-pwm
+          - const: mediatek,mt8173-disp-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
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
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pwm0: pwm@1401e000 {
+        compatible = "mediatek,mt8173-disp-pwm";
+        reg = <0x1401e000 0x1000>;
+        #pwm-cells = <2>;
+        clocks = <&mmsys CLK_MM_DISP_PWM026M>,
+                 <&mmsys CLK_MM_DISP_PWM0MM>;
+        clock-names = "main", "mm";
+    };
diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
deleted file mode 100644
index 902b271891ae..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-MediaTek display PWM controller
-
-Required properties:
- - compatible: should be "mediatek,<name>-disp-pwm":
-   - "mediatek,mt2701-disp-pwm": found on mt2701 SoC.
-   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
-   - "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm": found on mt8167 SoC.
-   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
- - reg: physical base address and length of the controller's registers.
- - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
-   the cell format.
- - clocks: phandle and clock specifier of the PWM reference clock.
- - clock-names: must contain the following:
-   - "main": clock used to generate PWM signals.
-   - "mm": sync signals from the modules of mmsys.
- - pinctrl-names: Must contain a "default" entry.
- - pinctrl-0: One property must exist for each entry in pinctrl-names.
-   See pinctrl/pinctrl-bindings.txt for details of the property values.
-
-Example:
-	pwm0: pwm@1401e000 {
-		compatible = "mediatek,mt8173-disp-pwm",
-			     "mediatek,mt6595-disp-pwm";
-		reg = <0 0x1401e000 0 0x1000>;
-		#pwm-cells = <2>;
-		clocks = <&mmsys CLK_MM_DISP_PWM026M>,
-			 <&mmsys CLK_MM_DISP_PWM0MM>;
-		clock-names = "main", "mm";
-		pinctrl-names = "default";
-		pinctrl-0 = <&disp_pwm0_pins>;
-	};
-
-	backlight_lcd: backlight_lcd {
-		compatible = "pwm-backlight";
-		pwms = <&pwm0 0 1000000>;
-		brightness-levels = <
-			  0  16  32  48  64  80  96 112
-			128 144 160 176 192 208 224 240
-			255
-		>;
-		default-brightness-level = <9>;
-		power-supply = <&mt6397_vio18_reg>;
-		enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
-	};
-- 
2.18.0

