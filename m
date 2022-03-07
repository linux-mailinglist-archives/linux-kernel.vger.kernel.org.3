Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7404CFBE7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiCGKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242306AbiCGKtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:49:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C879834660;
        Mon,  7 Mar 2022 02:08:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m22so12957409pja.0;
        Mon, 07 Mar 2022 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cMODfEuB/bWL2mIF4xu/VOgQ2ijW069H0ypnoIgKd0A=;
        b=M1YG6t0tZx2PNV40LBHkm2dPqOslVeVJFboYB/KKJzOHxcUOzNOmwECiy0NX4KiwDs
         AbRjInZU+TO1/o1Xgs+V7alqvrJ+N7kIdaN4TxUdMzYctFmrX6fEKduhs0l18o2e4uBY
         PUR99j/GerK6aWC58d5KeZr0d2CRA+igY3PsjgzzWWuwbvaehFRrxA1EHgXG/c0cr8yM
         RBvCGpmCAJMwnnKdvkvTvcAPvYS2AtmIqYzPxD2IujgdQn+fN+J9qK/dbEFcDjrcoc82
         7SCqaUlgsFwE4rinMw17QSFVvUUzN/PhhP4yHEhoGwC4fPmhfLBLhga/A/tkuc3Il3zJ
         U97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cMODfEuB/bWL2mIF4xu/VOgQ2ijW069H0ypnoIgKd0A=;
        b=lqN2rUtZ7IYBkxvJOyJP79nKNPgJ7dpX8LTAzUpI71+Wvnw7UKIT4uc74uLJrRT3g7
         zqoNXOn5e3Zzj2LwfL1wuuK86pISW04DsFkMkcQVMmuFgW5q8WZHKcyLECyKVWjTPHYo
         rWFsuhoAJgXRLvePviVr8bUWyOXet3g84mPwedQuF87zsCKRlG02Y5dZq+h3t/K3+1Vx
         T6ORnEzD6yrgF74skZfDLo1OtbbnTU3t6Byo947U7y2ZGndEkwFLkgjEczGLvbOhBoS2
         Wqydl1u+w8mRvEP8Q6jHZAvxAn4KXSjTlYN/v3/2w5CTJQZcjfYFd3jCp4sHRwcvwGXL
         GnxA==
X-Gm-Message-State: AOAM530FOMDRQzGBkL+4PGuospjYoKoDItZ3/UUZPgJ6B9hGLsbr0yOw
        jZcncH8Id8OpLrK8Q0wB0Yo=
X-Google-Smtp-Source: ABdhPJy7zJvzZX7Vbmmoo5aUuYHkqyRxgHNY81pKhHdq1NM3OSMFj3s/DXLTGp/jlAx+JG95hI5fMA==
X-Received: by 2002:a17:902:ef4f:b0:14f:6188:62ca with SMTP id e15-20020a170902ef4f00b0014f618862camr11118301plx.106.1646647715219;
        Mon, 07 Mar 2022 02:08:35 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:486:4335:5d3f:ee29:17d3:65af])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b004f3ba7c23e2sm15140125pfu.37.2022.03.07.02.08.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:08:34 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek RT5190A PMIC
Date:   Mon,  7 Mar 2022 18:08:23 +0800
Message-Id: <1646647704-2331-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646647704-2331-1-git-send-email-u0084500@gmail.com>
References: <1646647704-2331-1-git-send-email-u0084500@gmail.com>
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
 .../regulator/richtek,rt5190a-regulator.yaml       | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
new file mode 100644
index 00000000..b9f5836
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
@@ -0,0 +1,138 @@
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
+  richtek,buck1-fixed-microvolt:
+    description: buck1 fixed voltage that depends on the external resistor.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  richtek,buck4-fixed-microvolt:
+    description: buck4 fixed voltage that depends on the external resistor.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  richtek,ldo-fixed-microvolt:
+    description: ldo fixed voltage that depends on the external resistor.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  richtek,mute-enable:
+    description: this can be used to enable mute function.
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
+          regulator description for buck[1-4] and ldo.
+
+        properties:
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
+  - richtek,buck1-fixed-microvolt
+  - richtek,buck4-fixed-microvolt
+  - richtek,ldo-fixed-microvolt
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt5190a@64 {
+        compatible = "richtek,rt5190a";
+        reg = <0x64>;
+        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+        vin2-supply = <&rt5190_buck1>;
+        vin3-supply = <&rt5190_buck1>;
+        vin4-supply = <&rt5190_buck1>;
+        richtek,buck1-fixed-microvolt = <5090000>;
+        richtek,buck4-fixed-microvolt = <850000>;
+        richtek,ldo-fixed-microvolt = <1200000>;
+
+        regulators {
+          rt5190_buck1: buck1 {
+            regulator-name = "rt5190a-buck1";
+            regulator-allowed-modes = <0 1>;
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
+            regulator-allowed-modes = <0 1>;
+            regulator-boot-on;
+          };
+          ldo {
+            regulator-name = "rt5190a-ldo";
+            regulator-boot-on;
+          };
+        };
+      };
+    };
-- 
2.7.4

