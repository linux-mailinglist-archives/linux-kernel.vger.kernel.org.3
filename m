Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5878F511338
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359309AbiD0IIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359275AbiD0IHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:07:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD006522E0;
        Wed, 27 Apr 2022 01:04:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k14so894774pga.0;
        Wed, 27 Apr 2022 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OOkWlT5TtgSr3f5WTjCqUYVthsAQ04wJKZJ02py4e7s=;
        b=GJdQ8dVzSoTnnqJXvNPDDfKYf1IkcuQx2fkKljfGAaWhVmlEf3wM4Pqxm4j+EvYTzQ
         U0nv2tcjNDhwLrb6rIrm5RadlxTvhZkp+FkiZGEowo9WwlFVJzErSC2POBnUGS7V1ovs
         3tOs16OpYc30wXrq943yJtggObGFkL5xUb9ss00aquYt04lhCnOfhsWuw9XWCxhs3A3R
         hR6JtkzVHEdNcBPf1bb0A8Fze5gr+D3uOBHEoQsCzqvkdC3caFC7eI+KsbryNrfKNbRN
         k8p7kI/2AWTSO9oKqg1h2jLtqDLKUArshZTkt8luaJR6cLWp+thq+QGSyzeiUGcNpdGJ
         EuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOkWlT5TtgSr3f5WTjCqUYVthsAQ04wJKZJ02py4e7s=;
        b=iJT7ZWaI0z+nmiyVVhqal8H63OMlURz3RR7+l+WHl8GWiNdx4RETzvusSCgw5k4Evp
         LtjiAPaaGUjpreiOP/AuO5LOoVahMYsIJS4Nb4VNf4apylgarR7skfX2Yjl0MlIwkrNK
         DNog5Qjlt4hrI3xbw2k5l01s76lqsJN0I/NXmFj+ZY1b9dVRFNYqpXd8bbn0lluy2li2
         +k46WKm3/h9bEFfHXE117CVNOJmWlcexN7l80yChuLBYnxS2mZwiCCKyV/isZxgD2sIN
         17vBdJaMHjxQMsTBh1px8T8Wa7ChPX8Z3whZneyUR344q+yYwmo4ATxYv0XktcrTVQ6x
         ccwA==
X-Gm-Message-State: AOAM5329Fnfpwxr/IshGHKfJtWHrCWEWieZS8fBHpgZrfsTGUTuWeyIF
        gKbqm1OFxqFJM8XgZAAxcmY=
X-Google-Smtp-Source: ABdhPJzihmyoo54arIgiz4u7SYLof9thbDPOiEhHsmeweCBIJiuI9zUmUX5kiDY/tyF8hghBIfv/0w==
X-Received: by 2002:a63:6cc5:0:b0:3ab:7a48:af2b with SMTP id h188-20020a636cc5000000b003ab7a48af2bmr8619907pgc.302.1651046670336;
        Wed, 27 Apr 2022 01:04:30 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:469:f77c:f4fa:b753:7807:4e40])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090a70cb00b001cd4989ff50sm1746750pjm.23.2022.04.27.01.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:04:30 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: [PATCH 2/2] dt-bindings: mfd: Add bindings for the Mediatek MT6360
Date:   Wed, 27 Apr 2022 16:03:30 +0800
Message-Id: <20220427080330.40136-3-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427080330.40136-1-gene.chen.richtek@gmail.com>
References: <20220427080330.40136-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings for the Mediatek MT6360

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 .../devicetree/bindings/mfd/mt6360.yaml       | 258 ++++++++++++++++++
 1 file changed, 258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mt6360.yaml b/Documentation/devicetree/bindings/mfd/mt6360.yaml
new file mode 100644
index 000000000000..2c0c5df16b00
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mt6360.yaml
@@ -0,0 +1,258 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mt6360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6360 PMIC from MediaTek Integrated IC
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  MT6360 is a PMIC device with the following sub modules.
+  It is interfaced to host controller using I2C interface.
+
+  This document describes the binding for PMIC device and its sub module.
+
+properties:
+  compatible:
+    const: mediatek,mt6360
+
+  reg:
+    description: I2C device address.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    enum:
+      - IRQB
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      The first cell is the IRQ number.
+
+  regulators:
+    $ref: ../regulator/mt6360-regulator.yaml
+
+  charger:
+    $ref: ../power/supply/mt6360_charger.yaml
+
+  tcpc:
+    $ref: ../usb/mediatek,mt6360-tcpc.yaml
+
+  led-controller:
+    $ref: ../leds/leds-mt6360.yaml
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+    #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      mt6360@34 {
+        compatible = "mediatek,mt6360";
+        reg = <0x34>;
+        wakeup-source;
+        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-names = "IRQB";
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        mt6360_charger: charger {
+          compatible = "mediatek,mt6360-chg";
+          richtek,vinovp-microvolt = <14500000>;
+
+          otg_vbus_regulator: usb-otg-vbus-regulator {
+            regulator-compatible = "usb-otg-vbus";
+            regulator-name = "usb-otg-vbus";
+            regulator-min-microvolt = <4425000>;
+            regulator-max-microvolt = <5825000>;
+          };
+        };
+
+        led-controller {
+          compatible = "mediatek,mt6360-led";
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          multi-led@0 {
+            reg = <0>;
+            function = LED_FUNCTION_INDICATOR;
+            color = <LED_COLOR_ID_RGB>;
+            led-max-microamp = <24000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            led@0 {
+              reg = <0>;
+              color = <LED_COLOR_ID_RED>;
+            };
+            led@1 {
+              reg = <1>;
+              color = <LED_COLOR_ID_GREEN>;
+            };
+            led@2 {
+              reg = <2>;
+              color = <LED_COLOR_ID_BLUE>;
+            };
+          };
+          led@3 {
+            reg = <3>;
+            function = LED_FUNCTION_INDICATOR;
+            color = <LED_COLOR_ID_WHITE>;
+            led-max-microamp = <150000>;
+          };
+          led@4 {
+            reg = <4>;
+            function = LED_FUNCTION_FLASH;
+            color = <LED_COLOR_ID_WHITE>;
+            function-enumerator = <1>;
+            led-max-microamp = <200000>;
+            flash-max-microamp = <500000>;
+            flash-max-timeout-us = <1024000>;
+          };
+          led@5 {
+            reg = <5>;
+            function = LED_FUNCTION_FLASH;
+            color = <LED_COLOR_ID_WHITE>;
+            function-enumerator = <2>;
+            led-max-microamp = <200000>;
+            flash-max-microamp = <500000>;
+            flash-max-timeout-us = <1024000>;
+          };
+        };
+
+        regulators {
+          compatible = "mediatek,mt6360-regulator";
+          LDO_VIN3-supply = <&BUCK2>;
+          buck1 {
+            regulator-compatible = "BUCK1";
+            regulator-name = "mt6360,buck1";
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1300000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP
+                 MT6360_OPMODE_ULP>;
+          };
+          BUCK2: buck2 {
+            regulator-compatible = "BUCK2";
+            regulator-name = "mt6360,buck2";
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1300000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP
+                 MT6360_OPMODE_ULP>;
+          };
+          ldo6 {
+            regulator-compatible = "LDO6";
+            regulator-name = "mt6360,ldo6";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <2100000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+          ldo7 {
+            regulator-compatible = "LDO7";
+            regulator-name = "mt6360,ldo7";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <2100000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+          ldo1 {
+            regulator-compatible = "LDO1";
+            regulator-name = "mt6360,ldo1";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3600000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+            ldo2 {
+            regulator-compatible = "LDO2";
+            regulator-name = "mt6360,ldo2";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3600000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+          ldo3 {
+            regulator-compatible = "LDO3";
+            regulator-name = "mt6360,ldo3";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3600000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+          ldo5 {
+            regulator-compatible = "LDO5";
+            regulator-name = "mt6360,ldo5";
+            regulator-min-microvolt = <2700000>;
+            regulator-max-microvolt = <3600000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+        };
+
+        tcpc {
+          compatible = "mediatek,mt6360-tcpc";
+          interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+          interrupt-names = "PD_IRQB";
+
+          connector {
+            compatible = "usb-c-connector";
+            label = "USB-C";
+            data-role = "dual";
+            power-role = "dual";
+            try-power-role = "sink";
+            source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+            sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+            op-sink-microwatt = <10000000>;
+
+            ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                reg = <0>;
+                endpoint {
+                  remote-endpoint = <&usb_hs>;
+                };
+              };
+              port@1 {
+                reg = <1>;
+                endpoint {
+                  remote-endpoint = <&usb_ss>;
+                };
+              };
+              port@2 {
+                reg = <2>;
+                endpoint {
+                  remote-endpoint = <&dp_aux>;
+                };
+              };
+            };
+          };
+        };
+
+      };
+    };
-- 
2.25.1

