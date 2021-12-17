Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5416D479264
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbhLQRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbhLQRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:05:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D669AC061574;
        Fri, 17 Dec 2021 09:05:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso4493453wmc.4;
        Fri, 17 Dec 2021 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuPdYf/cmtPVxurcR1CFKYTteopIuixXBqin4u9JEls=;
        b=QLlhC5eYHXXhX55YgqGn6X3Dp556n+X90hfaVMTrxTCFk6CLRptHWtjFuWWw0JXFdZ
         KcZyQUq0ttw8Snz2dhdoBktZW6Fix8Py1F9YVCfJgMRWChLyYrGJbr7dqtxvg+NLuUD9
         MOCjdSNNe/ifapyiNu7RFpHT0SHuZ/ddm3tdCv7tcdbdlPuwZ+es8tnKX13GIpJqxzmQ
         1HyBAvda3g6Ns29KGY+L5s95d+IfW0Jo22zqatm/9+MlzzoBP8mOkIibigneU5QAsXLh
         /pYc5BNOWEoFMTVZ/hKVby8APCt5Vda11QKvZdv4e0e6dPsL6wJPac19zzwMYJIzTRpw
         iOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuPdYf/cmtPVxurcR1CFKYTteopIuixXBqin4u9JEls=;
        b=hpkKhqVXw9bqK7GlJhQ0/VCrUizA5mJm9U+LtjylxkNBv428ozVUyvB9UQ9KdPnd6l
         DjoxcPww3DAi8L/xOJYY7Gljgzssiv4HBOYTePUFFhutW55k49XW6ySBX34Vb5WHuEQg
         SJtf7uIsp9jkeOiwI9CC/NWQsURM8lDKYm13VbDBZBFAlAt46N9Tz52eCO63CAVcGguD
         Q5+QPVmjSMOMGPDU0c7obbNmh90xBX+l1YTssVXugfLmlhOQtCvbSlb9fP0vrvDwHcF9
         do923frSAnsUltaWhoACqKKd1nNpt6wEa6W3VrvXBAYmBSU5q/9Y6zYGP+3V0UZEns3G
         GQGw==
X-Gm-Message-State: AOAM53282BNhulvxz8Gr6Inx/4K40HXo6sbGJDXSTedLq1JSBsOfcXgY
        pqyEZzzEx6qLsCMBmlNMVcU=
X-Google-Smtp-Source: ABdhPJwea3Gn85IDSVhrdO142v/vM8dLI3qEOm2gSkJ2DdCjEc1Mw0ZAhkmZ0Jk1iHx8XHPhvW+6DQ==
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr10495704wmq.53.1639760722317;
        Fri, 17 Dec 2021 09:05:22 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id t17sm11878853wmq.15.2021.12.17.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:05:21 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] dt-bindings: regulator: tps65090: Convert to json-schema
Date:   Fri, 17 Dec 2021 18:05:07 +0100
Message-Id: <20211217170507.2843568-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217170507.2843568-1-thierry.reding@gmail.com>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Texas Instruments TPS65090 bindings from the free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/regulator/ti,tps65090.yaml       | 199 ++++++++++++++++++
 .../bindings/regulator/tps65090.txt           | 126 -----------
 2 files changed, 199 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65090.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps65090.txt

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65090.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65090.yaml
new file mode 100644
index 000000000000..9743746475a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65090.yaml
@@ -0,0 +1,199 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps65090.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPS65090 voltage regulator
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: ti,tps65090
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vsys1-supply:
+    description: input supply for DCDC1
+
+  vsys2-supply:
+    description: input supply for DCDC2
+
+  vsys3-supply:
+    description: input supply for DCDC3
+
+  infet1-supply:
+    description: input supply for FET1
+
+  infet2-supply:
+    description: input supply for FET2
+
+  infet3-supply:
+    description: input supply for FET3
+
+  infet4-supply:
+    description: input supply for FET4
+
+  infet5-supply:
+    description: input supply for FET5
+
+  infet6-supply:
+    description: input supply for FET6
+
+  infet7-supply:
+    description: input supply for FET7
+
+  vsys-l1-supply:
+    description: input supply for LDO1
+
+  vsys-l2-supply:
+    description: input supply for LDO2
+
+  charger:
+    $ref: ../power/supply/tps65090-charger.yaml
+
+  regulators:
+    type: object
+    description: A node that houses a sub-node for each regulator within the device. Each sub-node
+      is identified using the node's name, with valid values listed below. The content of each
+      sub-node is defined by the standard binding for regulators; see regulator.txt.
+
+    patternProperties:
+      "^dcdc[1-3]|fet[1-7]|ldo[1-2]$":
+        $ref: regulator.yaml
+        properties:
+          ti,enable-ext-control:
+            $ref: /schemas/types.yaml#/definitions/flag
+            description: This is applicable for DCDC1, DCDC2 and DCDC3. If DCDCs are externally
+              controlled then this property should be there.
+
+          dcdc-ext-control-gpios:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description: This is applicable for DCDC1, DCDC2 and DCDC3. If DCDCs are externally
+              controlled and if it is from GPIO then GPIO number should be provided. If it is
+              externally controlled and no GPIO entry then driver will just configure this rails
+              as external control and will not provide any enable/disable APIs.
+
+          ti,overcurrent-wait:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: This is applicable to FET registers, which have a poorly defined
+              "overcurrent wait" field.  If this property is present it should be between 0 - 3.
+              If this property isn't present we won't touch the "overcurrent wait" field and we'll
+              leave it to the BIOS/EC to deal with.
+            enum: [ 0, 1, 2, 3 ]
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@48 {
+        compatible = "ti,tps65090";
+        reg = <0x48>;
+        interrupts = <0 88 0x4>;
+
+        vsys1-supply = <&some_reg>;
+        vsys2-supply = <&some_reg>;
+        vsys3-supply = <&some_reg>;
+        infet1-supply = <&some_reg>;
+        infet2-supply = <&some_reg>;
+        infet3-supply = <&some_reg>;
+        infet4-supply = <&some_reg>;
+        infet5-supply = <&some_reg>;
+        infet6-supply = <&some_reg>;
+        infet7-supply = <&some_reg>;
+        vsys-l1-supply = <&some_reg>;
+        vsys-l2-supply = <&some_reg>;
+
+        regulators {
+          dcdc1 {
+            regulator-name = "dcdc1";
+            regulator-boot-on;
+            regulator-always-on;
+            ti,enable-ext-control;
+            dcdc-ext-control-gpios = <&gpio 10 0>;
+          };
+
+          dcdc2 {
+            regulator-name = "dcdc2";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          dcdc3 {
+            regulator-name = "dcdc3";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          fet1 {
+            regulator-name = "fet1";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          fet2 {
+            regulator-name = "fet2";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          fet3 {
+            regulator-name = "fet3";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          fet4 {
+            regulator-name = "fet4";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          fet5 {
+            regulator-name = "fet5";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          fet6 {
+            regulator-name = "fet6";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          fet7 {
+            regulator-name = "fet7";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          ldo1 {
+            regulator-name = "ldo1";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          ldo2 {
+            regulator-name = "ldo2";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/tps65090.txt b/Documentation/devicetree/bindings/regulator/tps65090.txt
deleted file mode 100644
index ae326f263597..000000000000
--- a/Documentation/devicetree/bindings/regulator/tps65090.txt
+++ /dev/null
@@ -1,126 +0,0 @@
-TPS65090 regulators
-
-Required properties:
-- compatible: "ti,tps65090"
-- reg: I2C slave address
-- interrupts: the interrupt outputs of the controller
-- regulators: A node that houses a sub-node for each regulator within the
-  device. Each sub-node is identified using the node's name, with valid
-  values listed below. The content of each sub-node is defined by the
-  standard binding for regulators; see regulator.txt.
-  dcdc[1-3], fet[1-7] and ldo[1-2] respectively.
-- vsys[1-3]-supply: The input supply for DCDC[1-3] respectively.
-- infet[1-7]-supply: The input supply for FET[1-7] respectively.
-- vsys-l[1-2]-supply: The input supply for LDO[1-2] respectively.
-
-Optional properties:
-- ti,enable-ext-control: This is applicable for DCDC1, DCDC2 and DCDC3.
-  If DCDCs are externally controlled then this property should be there.
-- dcdc-ext-control-gpios: This is applicable for DCDC1, DCDC2 and DCDC3.
-  If DCDCs are externally controlled and if it is from GPIO then GPIO
-  number should be provided. If it is externally controlled and no GPIO
-  entry then driver will just configure this rails as external control
-  and will not provide any enable/disable APIs.
-- ti,overcurrent-wait: This is applicable to FET registers, which have a
-  poorly defined "overcurrent wait" field.  If this property is present it
-  should be between 0 - 3.  If this property isn't present we won't touch the
-  "overcurrent wait" field and we'll leave it to the BIOS/EC to deal with.
-
-Each regulator is defined using the standard binding for regulators.
-
-Example:
-
-	tps65090@48 {
-		compatible = "ti,tps65090";
-		reg = <0x48>;
-		interrupts = <0 88 0x4>;
-
-		vsys1-supply = <&some_reg>;
-		vsys2-supply = <&some_reg>;
-		vsys3-supply = <&some_reg>;
-		infet1-supply = <&some_reg>;
-		infet2-supply = <&some_reg>;
-		infet3-supply = <&some_reg>;
-		infet4-supply = <&some_reg>;
-		infet5-supply = <&some_reg>;
-		infet6-supply = <&some_reg>;
-		infet7-supply = <&some_reg>;
-		vsys-l1-supply = <&some_reg>;
-		vsys-l2-supply = <&some_reg>;
-
-		regulators {
-			dcdc1 {
-				regulator-name = "dcdc1";
-				regulator-boot-on;
-				regulator-always-on;
-				ti,enable-ext-control;
-				dcdc-ext-control-gpios = <&gpio 10 0>;
-			};
-
-			dcdc2 {
-				regulator-name = "dcdc2";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			dcdc3 {
-				regulator-name = "dcdc3";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			fet1 {
-				regulator-name = "fet1";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			fet2 {
-				regulator-name = "fet2";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			fet3 {
-				regulator-name = "fet3";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			fet4 {
-				regulator-name = "fet4";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			fet5 {
-				regulator-name = "fet5";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			fet6 {
-				regulator-name = "fet6";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			fet7 {
-				regulator-name = "fet7";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1 {
-				regulator-name = "ldo1";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2 {
-				regulator-name = "ldo2";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-- 
2.34.1

