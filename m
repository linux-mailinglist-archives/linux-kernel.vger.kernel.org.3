Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D995780FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiGRLib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiGRLi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:38:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F029C2181D;
        Mon, 18 Jul 2022 04:38:24 -0700 (PDT)
X-UUID: 7ab77175fc784f6b9bfe7596a77e3924-20220718
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.8,REQID:b561b549-0a76-4b30-9e3f-b1158e5e2527,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:115
X-CID-INFO: VERSION:1.1.8,REQID:b561b549-0a76-4b30-9e3f-b1158e5e2527,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:115
X-CID-META: VersionHash:0f94e32,CLOUDID:bbb8cad7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:2bfa91354fdb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7ab77175fc784f6b9bfe7596a77e3924-20220718
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1840059717; Mon, 18 Jul 2022 19:38:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 18 Jul 2022 19:38:16 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 18 Jul 2022 19:38:16 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <johnson.wang@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <sean.wang@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: mediatek: add pinctrl definition for mt8188
Date:   Mon, 18 Jul 2022 19:38:11 +0800
Message-ID: <20220718113813.23787-2-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220718113813.23787-1-hui.liu@mediatek.com>
References: <20220718113813.23787-1-hui.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hui.Liu" <hui.liu@mediatek.com>

This commit adds mt8188 compatible node in binding document.

Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
---
 .../bindings/pinctrl/pinctrl-mt8188.yaml      | 306 ++++++++++++++++++
 1 file changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml
new file mode 100644
index 000000000000..43cc2424107f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml
@@ -0,0 +1,306 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8188.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT8188 Pin Controller
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+description: |
+  The MediaTek's Pin controller is used to control SoC pins.
+
+properties:
+  compatible:
+    const: mediatek,mt8188-pinctrl
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description: |
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below
+      mentioned gpio binding representation for description of particular cells.
+    const: 2
+
+  gpio-ranges:
+    description: gpio valid number range.
+    maxItems: 1
+
+  reg:
+    description: |
+      Physical address base for gpio base registers. There are 8 GPIO
+      physical address base in mt8188.
+    maxItems: 8
+
+  reg-names:
+    description: |
+      Gpio base register names.
+    maxItems: 8
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    description: The interrupt outputs to sysirq.
+    maxItems: 1
+
+  mediatek,rsel_resistance_in_si_unit:
+    type: boolean
+    description: |
+      Identifying i2c pins pull up/down type which is RSEL. It can support
+      RSEL define or si unit value(ohm) to set different resistance.
+
+# PIN CONFIGURATION NODES
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '^pins':
+        type: object
+        additionalProperties: false
+        description: |
+          A pinctrl node should contain at least one subnodes representing the
+          pinctrl groups available on the machine. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to muxer
+          configuration, pullups, drive strength, input enable/disable and
+          input schmitt.
+          An example of using macro:
+          pincontroller {
+            /* GPIO0 set as multifunction GPIO0 */
+            gpio-pins {
+              pins {
+                pinmux = <PINMUX_GPIO0__FUNC_B_GPIO0>;
+              }
+            };
+            /* GPIO56 set as multifunction SDA0 */
+            i2c0-pins {
+              pins {
+                pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
+              }
+            };
+          };
+        $ref: "pinmux-node.yaml"
+
+        properties:
+          pinmux:
+            description: |
+              Integer array, represents gpio pin number and mux setting.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
+              directly.
+
+          drive-strength:
+            enum: [2, 4, 6, 8, 10, 12, 14, 16]
+
+          mediatek,drive-strength-adv:
+            description: |
+              Describe the specific driving setup property.
+              For I2C pins, the existing generic driving setup can only support
+              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
+              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
+              driving setup, the existing generic setup will be disabled.
+              The specific driving setup is controlled by E1E0EN.
+              When E1=0/E0=0, the strength is 0.125mA.
+              When E1=0/E0=1, the strength is 0.25mA.
+              When E1=1/E0=0, the strength is 0.5mA.
+              When E1=1/E0=1, the strength is 1mA.
+              EN is used to enable or disable the specific driving setup.
+              Valid arguments are described as below:
+              0: (E1, E0, EN) = (0, 0, 0)
+              1: (E1, E0, EN) = (0, 0, 1)
+              2: (E1, E0, EN) = (0, 1, 0)
+              3: (E1, E0, EN) = (0, 1, 1)
+              4: (E1, E0, EN) = (1, 0, 0)
+              5: (E1, E0, EN) = (1, 0, 1)
+              6: (E1, E0, EN) = (1, 1, 0)
+              7: (E1, E0, EN) = (1, 1, 1)
+              So the valid arguments are from 0 to 7.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: mt8188 pull down PUPD/R0/R1 type define value.
+              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
+                description: mt8188 pull down RSEL type define value.
+              - enum: [75000, 5000]
+                description: mt8188 pull down RSEL type si unit value(ohm).
+            description: |
+              For pull down type is normal, it don't need add RSEL & R1R0 define
+              and resistance value.
+              For pull down type is PUPD/R0/R1 type, it can add R1R0 define to
+              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
+              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
+              "MTK_PUPD_SET_R1R0_11" define in mt8188.
+              For pull down type is RSEL, it can add RSEL define & resistance
+              value(ohm) to set different resistance by identifying property
+              "mediatek,rsel_resistance_in_si_unit".
+              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
+              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
+              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
+              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
+              define in mt8188. It can also support resistance value(ohm)
+              "75000" & "5000" in mt8188.
+
+              An example of using RSEL define:
+              pincontroller {
+                i2c0_pin {
+                  pins {
+                    pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
+                    bias-pull-updown = <MTK_PULL_SET_RSEL_001>;
+                  }
+                };
+              };
+              An example of using si unit resistance value(ohm):
+              &pio {
+                mediatek,rsel_resistance_in_si_unit;
+              }
+              pincontroller {
+                i2c0_pin {
+                  pins {
+                    pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
+                    bias-pull-down = <75000>;
+                  }
+                };
+              };
+
+          bias-pull-up:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: mt8188 pull up PUPD/R0/R1 type define value.
+              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
+                description: mt8188 pull up RSEL type define value.
+              - enum: [1000, 1500, 2000, 3000, 4000, 5000, 10000, 75000]
+                description: mt8188 pull up RSEL type si unit value(ohm).
+            description: |
+              For pull up type is normal, it don't need add RSEL & R1R0 define
+              and resistance value.
+              For pull up type is PUPD/R0/R1 type, it can add R1R0 define to
+              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
+              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
+              "MTK_PUPD_SET_R1R0_11" define in mt8188.
+              For pull up type is RSEL, it can add RSEL define & resistance
+              value(ohm) to set different resistance by identifying property
+              "mediatek,rsel_resistance_in_si_unit".
+              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
+              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
+              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
+              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
+              define in mt8188. It can also support resistance value(ohm)
+              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" &
+              "75000" in mt8188.
+              An example of using RSEL define:
+              pincontroller {
+                i2c0-pins {
+                  pins {
+                    pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
+                    bias-pull-up = <MTK_PULL_SET_RSEL_001>;
+                  }
+                };
+              };
+              An example of using si unit resistance value(ohm):
+              &pio {
+                mediatek,rsel_resistance_in_si_unit;
+              }
+              pincontroller {
+                i2c0-pins {
+                  pins {
+                    pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
+                    bias-pull-up = <1000>;
+                  }
+                };
+              };
+
+          bias-disable: true
+
+          output-high: true
+
+          output-low: true
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+        required:
+          - pinmux
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/mt8188-pinfunc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #
+    pio: pinctrl@10005000 {
+      compatible = "mediatek,mt8188-pinctrl";
+      reg = <0x10005000 0x1000>,
+            <0x11c00000 0x1000>,
+            <0x11e10000 0x1000>,
+            <0x11e20000 0x1000>,
+            <0x11ea0000 0x1000>,
+            <0x1000b000 0x1000>;
+      reg-names = "iocfg0", "iocfg_rm",
+                  "iocfg_lt", "iocfg_lm", "iocfg_rt",
+                  "eint";
+      gpio-controller;
+      #gpio-cells = <2>;
+      gpio-ranges = <&pio 0 0 176>;
+      interrupt-controller;
+      interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH 0>;
+      #interrupt-cells = <2>;
+
+      pio-pins {
+        pins {
+          pinmux = <PINMUX_GPIO0__FUNC_B_GPIO0>;
+          output-low;
+        };
+      };
+
+      spi0-pins {
+        pins-spi {
+          pinmux = <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
+                   <PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
+                   <PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>;
+          bias-disable;
+        };
+        pins-spi-mi {
+          pinmux = <PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
+          bias-pull-down;
+        };
+      };
+
+      i2c0-pins {
+        pins {
+          pinmux = <PINMUX_GPIO55__FUNC_B1_SCL0>,
+                   <PINMUX_GPIO56__FUNC_B1_SDA0>;
+          bias-disable;
+          mediatek,drive-strength-adv = <7>;
+        };
+      };
+    };
-- 
2.18.0

