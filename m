Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00114D2A44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiCIIDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiCIICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:02:53 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F614CCA1;
        Wed,  9 Mar 2022 00:01:53 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z4so1292596pgh.12;
        Wed, 09 Mar 2022 00:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tALxSMTh/dhGv+YQvXsygJvCV5BCG6c1EUZFPr7ldOI=;
        b=ea0JLyfHxdxqdJYUtBAzt8F+e4HOjMDcR9tV2uDIjJ8JLlztdshqhVjdq4tkI5FH+s
         ItuIBWXtl0kc86QyLHFmcB3ok0KzBZf+9Jz+UZThRhFxKax3nbxd22bfgSnWBQ1ZEVJx
         1PlCEbLoN1JhrW3lIQwVpND8WMt12Laa0RPrtBB1KygQxm5NE/kzBqnann6G7/RwhcjV
         KXg+hCPVvlt+K60txJOTOKZIvVuU9TL/+75GIHLrt/D5mocWh6JU0H1V93wCMNOAxs0r
         7g/deYMJsW6ZxtCSGVAzfI6axOctjf0AcFkjFPzxDO0gWg5JBbJonctpnW5mBM0HX8RT
         JlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tALxSMTh/dhGv+YQvXsygJvCV5BCG6c1EUZFPr7ldOI=;
        b=1pEB6SBvSp4rj9Xtw3G1EnS2PvjhPERtOCnWtAX5HhU2Th8xEs878l1F2fcZvLGd4h
         YtP7sQ+hdNX/tM7UOK2786x6J4K3uLZKvHGFzPq6EHTOlJwfEBMHJsX/YQGfexyWxZJX
         xprJm6UzpfvQBRhTE4N5mYiZ/WAVVQiFFlX3lWxhe9mSgiw7knMVJByNFUDHHe1zizsU
         SQVP1Cxcwx69qDrNgc+XTNZ/tnshGijAWkON5sKFpWtXcKBj6AyWqTqKYuYGJYyIB8PR
         82omspwH7P7ZDz+TqucGyPzu85owE7DxrHYqquGHmzcbwfSXdO+I3v2eA53nlMNi/nxK
         5QfQ==
X-Gm-Message-State: AOAM532kThHeJ2JrO2PI5ATDjdzco+j4Xlyji8f2FVomAKyDVG8pItg9
        MlZs12EBaY8Ok5y0bgRoo/Q=
X-Google-Smtp-Source: ABdhPJwJWKPqeLSGrrIWR4MmwZVE6xoWfeZP2TUvhMri0se4gxaIHOhusD/1nEk83SAgYrrgA353Tg==
X-Received: by 2002:a62:bd05:0:b0:4f7:aec:dd7e with SMTP id a5-20020a62bd05000000b004f70aecdd7emr12493864pff.9.1646812913251;
        Wed, 09 Mar 2022 00:01:53 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:486:47ca:79e4:f285:9205:e22])
        by smtp.gmail.com with ESMTPSA id ay5-20020a056a00300500b004f6d510af4asm1489873pfb.124.2022.03.09.00.01.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:01:52 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     krzysztof.kozlowski@canonical.com, lgirdwood@gmail.com,
        cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: regulator: Add bindings for Richtek RT5190A PMIC
Date:   Wed,  9 Mar 2022 16:01:42 +0800
Message-Id: <1646812903-32496-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646812903-32496-1-git-send-email-u0084500@gmail.com>
References: <1646812903-32496-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add bindings for Richtek RT5190A PMIC.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rt5190a-regulator.yaml       | 141 +++++++++++++++++++++
 .../regulator/richtek,rt5190a-regulator.h          |  15 +++
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
 create mode 100644 include/dt-bindings/regulator/richtek,rt5190a-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
new file mode 100644
index 00000000..28725c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5190a-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5190A PMIC Regulator
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT5190A integrates 1 channel buck controller, 3 channels high efficiency
+  synchronous buck converters, 1 LDO, I2C control interface and peripherial
+  logical control.
+
+  It also supports mute AC OFF depop sound and quick setting storage while
+  input power is removed.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt5190a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vin2-supply:
+    description: phandle to buck2 input voltage.
+
+  vin3-supply:
+    description: phandle to buck3 input voltage.
+
+  vin4-supply:
+    description: phandle to buck4 input voltage.
+
+  vinldo-supply:
+    description: phandle to ldo input voltage
+
+  richtek,mute-enable:
+    description: |
+      The mute function uses 'mutein', 'muteout', and 'vdet' pins as the control
+      signal. When enabled, The normal behavior is to bypass the 'mutein' signal
+      'muteout'. But if the power source removal is detected from 'vdet',
+      whatever the 'mutein' signal is, it will pull down the 'muteout' to force
+      speakers mute. this function is commonly used to prevent the speaker pop
+      noise during AC power turned off in the modern TV system design.
+    type: boolean
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^buck[1-4]$|^ldo$":
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          regulator description for buck1 and buck4.
+
+        properties:
+          regulator-allowed-modes:
+            description: |
+             buck operating mode, only buck1/4 support mode operating.
+              0: auto mode
+              1: force pwm mode
+            items:
+              enum: [0, 1]
+
+          richtek,latchup-enable:
+            type: boolean
+            description: |
+              If specified, undervolt protection mode changes from the default
+              hiccup to latchup.
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@64 {
+        compatible = "richtek,rt5190a";
+        reg = <0x64>;
+        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+        vin2-supply = <&rt5190_buck1>;
+        vin3-supply = <&rt5190_buck1>;
+        vin4-supply = <&rt5190_buck1>;
+
+        regulators {
+          rt5190_buck1: buck1 {
+            regulator-name = "rt5190a-buck1";
+            regulator-min-microvolt = <5090000>;
+            regulator-max-microvolt = <5090000>;
+            regulator-allowed-modes = <RT5190A_OPMODE_AUTO RT5190A_OPMODE_FPWM>;
+            regulator-boot-on;
+          };
+          buck2 {
+            regulator-name = "rt5190a-buck2";
+            regulator-min-microvolt = <600000>;
+            regulator-max-microvolt = <1400000>;
+            regulator-boot-on;
+          };
+          buck3 {
+            regulator-name = "rt5190a-buck3";
+            regulator-min-microvolt = <600000>;
+            regulator-max-microvolt = <1400000>;
+            regulator-boot-on;
+          };
+          buck4 {
+            regulator-name = "rt5190a-buck4";
+            regulator-min-microvolt = <850000>;
+            regulator-max-microvolt = <850000>;
+            regulator-allowed-modes = <RT5190A_OPMODE_AUTO RT5190A_OPMODE_FPWM>;
+            regulator-boot-on;
+          };
+          ldo {
+            regulator-name = "rt5190a-ldo";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-boot-on;
+          };
+        };
+      };
+    };
diff --git a/include/dt-bindings/regulator/richtek,rt5190a-regulator.h b/include/dt-bindings/regulator/richtek,rt5190a-regulator.h
new file mode 100644
index 00000000..63f99d4
--- /dev/null
+++ b/include/dt-bindings/regulator/richtek,rt5190a-regulator.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __DT_BINDINGS_RICHTEK_RT5190A_REGULATOR_H__
+#define __DT_BINDINGS_RICHTEK_RT5190A_REGULATOR_H__
+
+/*
+ * BUCK/LDO mode constants which may be used in devicetree properties
+ * (eg. regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define RT5190A_OPMODE_AUTO	0
+#define RT5190A_OPMODE_FPWM	1
+
+#endif
-- 
2.7.4

