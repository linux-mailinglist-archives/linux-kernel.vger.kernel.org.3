Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E40473066
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbhLMP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbhLMP0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:26:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B04C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:26:36 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so54090126edu.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykkCfpUCbjjXmzdVAFFI6PyGKVCkNC1OacqXq6G77HY=;
        b=mKYJ7J9JJvPO7j+1dDJkTeHC5vQ3hnO6crbtDgCbOWsRrWMGMvtc3VTqhnHGCbNdIf
         fzUFuBTVZiFs4HuSuL97X/+Q/OVi4jcapjmKqVhNr4Qtq7B9vvxZ1G+pJV7lxjqQla71
         0rkpj66OD2QNSY0mI3WMpEN+1izzvD+H7RIkffKzqKQGxzoVmgh3GP0REP2gQ45hM69y
         U+VcFqX4A0ENmMoTDSGXp27WdncdpXFbeBZgVHpJV1vwD4+CnXXP859Rn1aIzQcv34fZ
         MEN/oCuyue4xAMSHoNcJ2NWiDkxtGBsDAbgfDsQRGtxYcgDQh9jKR8b1b8NaGIRt3DyQ
         pjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykkCfpUCbjjXmzdVAFFI6PyGKVCkNC1OacqXq6G77HY=;
        b=soQouDH7Mxe+XGpvkaKA19MJQZTAC2exFP9tLDclIu0yAC3p2453Qeiq/9Qvbvlo35
         VzMVya17E4hLCNo1lzJXa8womPGgHlRpD7NXsDbyDjZ+ZjVhajmrbGB8ESyr3Vlt5ohq
         3cMW7U9X/gbN6OZUpM6bygGKyyvtdtQfCIeRDUlDWk45xRwE+mDLlaD2CKf0+VZa2eih
         nOAEyls7JKLCww0XW7BnUwdLMXrEQT5EzcLjrmEwKNwjaqx6E6rk2S72I29mt5/e3wHr
         5xo30Oly3JOHaOwwKKytj33HKgqhnl/QYDVASbKasn6GbMGVfgtOyyV7Ha4HQyr00oDl
         FP9Q==
X-Gm-Message-State: AOAM532QS1nRUsyxS2DejhBXZ8Jie11RwVLk2jegcC/oTzU9Fckmp4YO
        KWP182W0M0R01A5YhFANaLwAzII3aJW68s9psbs=
X-Google-Smtp-Source: ABdhPJwfcROAMxl6G//QP4UkM3xWqf63ZVQfLQhuB0yv1Pf5CmNj2ufYa0WccjhDdfU5KxPsNoPqmw==
X-Received: by 2002:a05:6402:4396:: with SMTP id o22mr65766072edc.263.1639409189575;
        Mon, 13 Dec 2021 07:26:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id c13sm221291ejj.144.2021.12.13.07.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 07:26:29 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: qcom,pdc: convert to YAML
Date:   Mon, 13 Dec 2021 16:22:08 +0100
Message-Id: <20211213152208.290923-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the PDC interrupt controller bindings to YAML.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
This patch depends on the following patch, which fixed sm8250 & sm8350
compatibles and adds sm6350.
https://lore.kernel.org/linux-arm-msm/20211213082614.22651-4-luca.weiss@fairphone.com/

Also, if somebody has a better suggestion for the register names,
the second one is pulled from downstream commit message which calls it
both "SPI config registers" and "interface registers":
https://source.codeaurora.org/quic/la/kernel/msm-4.19/commit/?id=cdefb63745e051a5bcf69663ac9d084d7da1eeec

 .../interrupt-controller/qcom,pdc.txt         | 77 -----------------
 .../interrupt-controller/qcom,pdc.yaml        | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 77 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
deleted file mode 100644
index 3b7b1134dea9..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-PDC interrupt controller
-
-Qualcomm Technologies Inc. SoCs based on the RPM Hardened architecture have a
-Power Domain Controller (PDC) that is on always-on domain. In addition to
-providing power control for the power domains, the hardware also has an
-interrupt controller that can be used to help detect edge low interrupts as
-well detect interrupts when the GIC is non-operational.
-
-GIC is parent interrupt controller at the highest level. Platform interrupt
-controller PDC is next in hierarchy, followed by others. Drivers requiring
-wakeup capabilities of their device interrupts routed through the PDC, must
-specify PDC as their interrupt controller and request the PDC port associated
-with the GIC interrupt. See example below.
-
-Properties:
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: Should contain "qcom,<soc>-pdc" and "qcom,pdc"
-		    - "qcom,sc7180-pdc": For SC7180
-		    - "qcom,sc7280-pdc": For SC7280
-		    - "qcom,sdm845-pdc": For SDM845
-		    - "qcom,sm6350-pdc": For SM6350
-		    - "qcom,sm8250-pdc": For SM8250
-		    - "qcom,sm8350-pdc": For SM8350
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: Specifies the base physical address for PDC hardware.
-
-- interrupt-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: Specifies the number of cells needed to encode an interrupt
-		    source.
-		    Must be 2.
-		    The first element of the tuple is the PDC pin for the
-		    interrupt.
-		    The second element is the trigger type.
-
-- interrupt-controller:
-	Usage: required
-	Value type: <bool>
-	Definition: Identifies the node as an interrupt controller.
-
-- qcom,pdc-ranges:
-	Usage: required
-	Value type: <u32 array>
-	Definition: Specifies the PDC pin offset and the number of PDC ports.
-		    The tuples indicates the valid mapping of valid PDC ports
-		    and their hwirq mapping.
-		    The first element of the tuple is the starting PDC port.
-		    The second element is the GIC hwirq number for the PDC port.
-		    The third element is the number of interrupts in sequence.
-
-Example:
-
-	pdc: interrupt-controller@b220000 {
-		compatible = "qcom,sdm845-pdc";
-		reg = <0xb220000 0x30000>;
-		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&intc>;
-		interrupt-controller;
-	};
-
-DT binding of a device that wants to use the GIC SPI 514 as a wakeup
-interrupt, must do -
-
-	wake-device {
-		interrupts-extended = <&pdc 2 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-In this case interrupt 514 would be mapped to port 2 on the PDC as defined by
-the qcom,pdc-ranges property.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
new file mode 100644
index 000000000000..8465d79945ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/qcom,pdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PDC interrupt controller
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  Qualcomm Technologies Inc. SoCs based on the RPM Hardened architecture have a
+  Power Domain Controller (PDC) that is on always-on domain. In addition to
+  providing power control for the power domains, the hardware also has an
+  interrupt controller that can be used to help detect edge low interrupts as
+  well detect interrupts when the GIC is non-operational.
+
+  GIC is parent interrupt controller at the highest level. Platform interrupt
+  controller PDC is next in hierarchy, followed by others. Drivers requiring
+  wakeup capabilities of their device interrupts routed through the PDC, must
+  specify PDC as their interrupt controller and request the PDC port associated
+  with the GIC interrupt. See example below.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sc7180-pdc
+          - qcom,sc7280-pdc
+          - qcom,sdm845-pdc
+          - qcom,sm6350-pdc
+          - qcom,sm8250-pdc
+          - qcom,sm8350-pdc
+      - const: qcom,pdc
+
+  reg:
+    minItems: 1
+    items:
+      - description: PDC base register region
+      - description: PDC interface register region
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  qcom,pdc-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 32 # no hard limit
+    items:
+      items:
+        - description: starting PDC port
+        - description: GIC hwirq number for the PDC port
+        - description: number of interrupts in sequence
+    description: |
+      Specifies the PDC pin offset and the number of PDC ports.
+      The tuples indicates the valid mapping of valid PDC ports
+      and their hwirq mapping.
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - interrupt-controller
+  - qcom,pdc-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pdc: interrupt-controller@b220000 {
+        compatible = "qcom,sdm845-pdc", "qcom,pdc";
+        reg = <0xb220000 0x30000>;
+        qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&intc>;
+        interrupt-controller;
+    };
+
+    wake-device {
+        interrupts-extended = <&pdc 2 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.34.1

