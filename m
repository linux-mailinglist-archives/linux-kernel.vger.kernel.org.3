Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F94347925F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhLQRF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbhLQRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:05:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE8FC06173F;
        Fri, 17 Dec 2021 09:05:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t26so5306318wrb.4;
        Fri, 17 Dec 2021 09:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RbFRzg37nUuFZEBHxwUpUEERhItCztkJH3wmVjodWY8=;
        b=epaZyAMtWCy+sRjecc3ZXqE81cir0K3jjAozKNTE1KDhJBdWTyeBmjwd2KhU7SAaXT
         MAyrv7/2BkzpeoDK1lJiHm+EjbYLYGn1n5sH43IlncDGCuzSHPoghdq9o73Gcl3Xhx0j
         XReKQDdCMWQ6yqQTU1GjEWjZ6eegzXuc5EQBAa0Jbh786KDUcurJDdliOd3rlEjzBpBj
         mxF89oaTNH1SrDUe3rRAPC85ZcULD0wrjjiMs/c47UjfpfkC6BmlZbshrzfQxt4lBR4r
         bYoFTP9TBB/aIwVJ1N45PIWtZ4SYvHFNQ67RHfONZpu4dn6e6j4TiSKSX2+3GXoUYnHX
         VExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbFRzg37nUuFZEBHxwUpUEERhItCztkJH3wmVjodWY8=;
        b=G52KUUkdclpaZlnKniVryENm0mMycvw6Sl93OaUo5ItvsHrd3sEXIgSsRbLqdDKATG
         21DREibVS8LeNxegvhVZqnTdsCl0Zl5h+ydUv8kq/VzU82EoY5z2lK+ZJeFDXRz9xgOM
         XDNjOdYTZuObVzrcbdO8JIUGTUGYrZaUQEc6sXNhcCTqir8hvKICWYPMJAEPR6yb6PP3
         i0tM7LJ9gLl/c7UieOnvd74eEMdn3syB8rN4Knv0eHW30eLAe80SdtRW8F0Ngntuvv5t
         P5dpJBXU3qxvaP7oX3lNYzLUVSgQmJFg0HIzpbYptULF2n7ljK7SWIJUxtzkeM9t6zzn
         dP/Q==
X-Gm-Message-State: AOAM531Cp2A51bxzITR6U0ptDUZwfN0jR8BtQT8gLS0UdTfNyZ25FMaL
        E/VcfJ650SEry+iJhsI445w=
X-Google-Smtp-Source: ABdhPJzECBckAoi4KGxnwI4KAlHYVckXCSp3RtuXwe7UQp3wkSmRcjVJwm5q1Rm03C5dHjeZ2eEt8g==
X-Received: by 2002:a05:6000:144a:: with SMTP id v10mr3221351wrx.357.1639760717541;
        Fri, 17 Dec 2021 09:05:17 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id z11sm8343295wmf.9.2021.12.17.09.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:05:16 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: regulator: tps62360: Convert to json-schema
Date:   Fri, 17 Dec 2021 18:05:05 +0100
Message-Id: <20211217170507.2843568-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217170507.2843568-1-thierry.reding@gmail.com>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Texas Instruments TPS62360 bindings from the free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/regulator/ti,tps62360.yaml       | 80 +++++++++++++++++++
 .../bindings/regulator/tps62360-regulator.txt | 44 ----------
 2 files changed, 80 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps62360.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps62360-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62360.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62360.yaml
new file mode 100644
index 000000000000..82558118284d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps62360.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps62360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPS62360 voltage regulator
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - ti,tps62360
+      - ti,tps62361
+      - ti,tps62362
+      - ti,tps62363
+
+  reg:
+    maxItems: 1
+
+  ti,enable-vout-discharge:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable output discharge.
+
+  ti,enable-pull-down:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable pull down.
+
+  ti,vsel0-gpio:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: GPIO for controlling VSEL0 line. If this property is missing, then assume that
+      there is no GPIO for VSEL0 control.
+
+  ti,vsel1-gpio:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: GPIO for controlling VSEL1 line. If this property is missing, then assume that
+      there is no GPIO for VSEL1 control.
+
+  ti,vsel0-state-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Initial state of VSEL0 input is high. If this property is missing, then assume
+      the state as low (0).
+
+  ti,vsel1-state-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Initial state of VSEL1 input is high. If this property is missing, then assume
+      the state as low (0).
+
+allOf:
+  - $ref: regulator.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@60 {
+        compatible = "ti,tps62361";
+        reg = <0x60>;
+        regulator-name = "tps62361-vout";
+        regulator-min-microvolt = <500000>;
+        regulator-max-microvolt = <1500000>;
+        regulator-boot-on;
+        ti,vsel0-gpio = <&gpio1 16 0>;
+        ti,vsel1-gpio = <&gpio1 17 0>;
+        ti,vsel0-state-high;
+        ti,vsel1-state-high;
+        ti,enable-pull-down;
+        ti,enable-vout-discharge;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/tps62360-regulator.txt b/Documentation/devicetree/bindings/regulator/tps62360-regulator.txt
deleted file mode 100644
index 1b20c3dbcdb8..000000000000
--- a/Documentation/devicetree/bindings/regulator/tps62360-regulator.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-TPS62360 Voltage regulators
-
-Required properties:
-- compatible: Must be one of the following.
-	"ti,tps62360"
-	"ti,tps62361",
-	"ti,tps62362",
-	"ti,tps62363",
-- reg: I2C slave address
-
-Optional properties:
-- ti,enable-vout-discharge: Enable output discharge. This is boolean value.
-- ti,enable-pull-down: Enable pull down. This is boolean value.
-- ti,vsel0-gpio: GPIO for controlling VSEL0 line.
-  If this property is missing, then assume that there is no GPIO
-  for vsel0 control.
-- ti,vsel1-gpio: Gpio for controlling VSEL1 line.
-  If this property is missing, then assume that there is no GPIO
-  for vsel1 control.
-- ti,vsel0-state-high: Initial state of vsel0 input is high.
-  If this property is missing, then assume the state as low (0).
-- ti,vsel1-state-high: Initial state of vsel1 input is high.
-  If this property is missing, then assume the state as low (0).
-
-Any property defined as part of the core regulator binding, defined in
-regulator.txt, can also be used.
-
-Example:
-
-	abc: tps62360 {
-		compatible = "ti,tps62361";
-		reg =  <0x60>;
-		regulator-name = "tps62361-vout";
-		regulator-min-microvolt = <500000>;
-		regulator-max-microvolt = <1500000>;
-		regulator-boot-on
-		ti,vsel0-gpio = <&gpio1 16 0>;
-		ti,vsel1-gpio = <&gpio1 17 0>;
-		ti,vsel0-state-high;
-		ti,vsel1-state-high;
-		ti,enable-pull-down;
-		ti,enable-force-pwm;
-		ti,enable-vout-discharge;
-	};
-- 
2.34.1

