Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555BD592ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbiHOHe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbiHOHeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:34:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8F183AD;
        Mon, 15 Aug 2022 00:34:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p125so6052049pfp.2;
        Mon, 15 Aug 2022 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=up++5EREYL75SQc53yDph90kSCluwcs4sUEUFyLB5DY=;
        b=gZH7c2f1bPRfAynZ6wdxSOg7T8PRgU8LR1G7ucYyNw4x+vV6NpYdcpME5BDnrwfQNn
         +okUQTIo24cahw90COH98uPiMfr9bKd4VzNePSxQemRQS9Nbb4XHiz2HFOAvRiiU9/V9
         dItwuf5dBk9FkSh4nLjZX+3rC6/I/RNptfE9w+XBXYbxqVzbPr/HoE5lTPOw366TseFf
         jhYxJUe6fcXXccQB2t7CZI+E8wTnZ+fEjd3jL1YBLobFHzzUnUnumV8mzmSiasLk+21X
         n+laqZLV+KoRC9SuCr770ko+68zrzGmfmVz0KriboANEQQqy2tYjU/Mtd2DxNwUOV6wT
         v5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=up++5EREYL75SQc53yDph90kSCluwcs4sUEUFyLB5DY=;
        b=db2AHmKoPkfVnhKk43ZOsEowfOLyyw4uKZ33gdrCzQGFfPeLWGTtnb61J7pS3PVQMD
         IDqvFbZ47bil8BkkUydpiqaUtGUIRN8EQSPnHeki8euAAGWeUp4fkx7VtW3j7UiFOIU3
         XHCC1ff2Lky1DilTymnstG7qza2xdGYZLcB19S77GklprmlKRK2wI+zjRfaXYzUJ1hXd
         XBpcuhUKeoOY28x/myb4w7QkFvq7jxh0rvlyqV+dSvyYrDNZV/y0w49B5WNJpXMiSMZl
         Sx8AMlhTtS4BfvT0RQyVWWnad8NQOf0Me8O6ELAJRNUEEA5ZyNudVdH/D4nEIcR/Ktku
         xeSw==
X-Gm-Message-State: ACgBeo3JnuObAp6/+6yINCJ7/XTFDlsrYjlfRMzDHTmfsNBXOSQzOytM
        Z70rgyR7skq1oDjLGxTZ7+U=
X-Google-Smtp-Source: AA6agR6V1Ptsb8psMUVEy8FccO/BOlc3X/IZzoactMIKHm4JP8UlTTnGpFAPbKOAaXJCWXKRAlxYeg==
X-Received: by 2002:a05:6a00:4304:b0:532:3c0f:3597 with SMTP id cb4-20020a056a00430400b005323c0f3597mr15231159pfb.44.1660548863296;
        Mon, 15 Aug 2022 00:34:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:2a3e:f57e:22d4:1ae1:ffd3])
        by smtp.gmail.com with ESMTPSA id r1-20020aa79ec1000000b0053249b67215sm6088503pfq.131.2022.08.15.00.34.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2022 00:34:22 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     alina_yu@richtek.com, cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Mon, 15 Aug 2022 15:34:11 +0800
Message-Id: <1660548852-6222-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660548852-6222-1-git-send-email-u0084500@gmail.com>
References: <1660548852-6222-1-git-send-email-u0084500@gmail.com>
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

Add bindings for the Richtek RT9471 I2C controlled battery charger.

Co-developed-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v2
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.

---
 .../bindings/power/supply/richtek,rt9471.yaml      | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
new file mode 100644
index 00000000..9286b82
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9471.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9471 3A Single Cell Switching Battery charger
+
+maintainers:
+  - Alina Yu <alina_yu@richtek.com>
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT9471 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
+  portable applications. It supports USB BC1.2 port detection, current and
+  voltage regulations in both charging and boost mode.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9471=RT9471D/DS9471D-02.pdf
+
+properties:
+  compatible:
+    const: richtek,rt9471
+
+  reg:
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO used to turn on and off charging.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    unevaluatedProperties: false
+    $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@53 {
+        compatible = "richtek,rt9471";
+        reg = <0x53>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+
+        usb-otg-vbus-regulator {
+          regulator-name = "usb-otg-vbus";
+          regulator-min-microvolt = <4850000>;
+          regulator-max-microvolt = <5300000>;
+          regulator-min-microamp = <500000>;
+          regulator-max-microamp = <1200000>;
+        };
+      };
+    };
-- 
2.7.4

