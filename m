Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60324B9893
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiBQF6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:58:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiBQF6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:58:34 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893A295FD0;
        Wed, 16 Feb 2022 21:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645077500; x=1676613500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=957/481RiDErmNCiF4UUSyZeyRJqu9YSyQc/7+LcejM=;
  b=cS/JPZ+r/TIcgcnXaNTtcB1FGbkTb39skskpUGtrexZWUsdCBMaXpiAP
   Pl2UKYSUFKpWMg0/SsxxWgrlJZFH5lceqaq0DCxyLdcoC0rJtV5fdht3O
   gYzuuRgVK1EjKJkL+yuzFYmCH8d23q5UEj49aGwYb3f1BxRcRm3KVVmVA
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Feb 2022 21:58:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 21:58:13 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 21:58:13 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 21:58:07 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [RESEND v7 1/7] dt-bindings: pinctrl: qcom: Update lpass lpi file name to SoC specific
Date:   Thu, 17 Feb 2022 11:27:41 +0530
Message-ID: <1645077467-6831-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645077467-6831-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645077467-6831-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change generic lpass lpi pincotrol bindings file to SoC specific file,
to distinguish and accomadate other SoC specific dt bindings.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 133 ---------------------
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 133 +++++++++++++++++++++
 2 files changed, 133 insertions(+), 133 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
deleted file mode 100644
index 5c5542f..0000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
+++ /dev/null
@@ -1,133 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
-  Low Power Island (LPI) TLMM block
-
-maintainers:
-  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  LPASS LPI IP on most Qualcomm SoCs
-
-properties:
-  compatible:
-    const: qcom,sm8250-lpass-lpi-pinctrl
-
-  reg:
-    minItems: 2
-    maxItems: 2
-
-  clocks:
-    items:
-      - description: LPASS Core voting clock
-      - description: LPASS Audio voting clock
-
-  clock-names:
-    items:
-      - const: core
-      - const: audio
-
-  gpio-controller: true
-
-  '#gpio-cells':
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
-#PIN CONFIGURATION NODES
-patternProperties:
-  '-pins$':
-    type: object
-    description:
-      Pinctrl node's client devices use subnodes for desired pin configuration.
-      Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
-
-    properties:
-      pins:
-        description:
-          List of gpio pins affected by the properties specified in this
-          subnode.
-        items:
-          oneOf:
-            - pattern: "^gpio([0-9]|[1-9][0-9])$"
-        minItems: 1
-        maxItems: 14
-
-      function:
-        enum: [ gpio, swr_tx_clk, qua_mi2s_sclk, swr_tx_data, qua_mi2s_ws,
-                qua_mi2s_data, swr_rx_clk, swr_rx_data, dmic1_clk, i2s1_clk,
-                dmic1_data, i2s1_ws, dmic2_clk, dmic2_data, i2s1_data,
-                i2s2_clk, wsa_swr_clk, i2s2_ws, wsa_swr_data, dmic3_clk,
-                dmic3_data, i2s2_data ]
-        description:
-          Specify the alternative function to be configured for the specified
-          pins.
-
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-            0: No adjustments
-            1: Higher Slew rate (faster edges)
-            2: Lower Slew rate (slower edges)
-            3: Reserved (No adjustments)
-
-      bias-pull-down: true
-
-      bias-pull-up: true
-
-      bias-disable: true
-
-      output-high: true
-
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
-
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - clock-names
-  - gpio-controller
-  - '#gpio-cells'
-  - gpio-ranges
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/sound/qcom,q6afe.h>
-    lpi_tlmm: pinctrl@33c0000 {
-        compatible = "qcom,sm8250-lpass-lpi-pinctrl";
-        reg = <0x33c0000 0x20000>,
-              <0x3550000 0x10000>;
-        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-        clock-names = "core", "audio";
-        gpio-controller;
-        #gpio-cells = <2>;
-        gpio-ranges = <&lpi_tlmm 0 0 14>;
-    };
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
new file mode 100644
index 0000000..06efb13
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
+  Low Power Island (LPI) TLMM block
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer block found in the
+  LPASS LPI IP on most Qualcomm SoCs
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-lpi-pinctrl
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: LPASS Core voting clock
+      - description: LPASS Audio voting clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: audio
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description: Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+#PIN CONFIGURATION NODES
+patternProperties:
+  '-pins$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9])$"
+        minItems: 1
+        maxItems: 14
+
+      function:
+        enum: [ gpio, swr_tx_clk, qua_mi2s_sclk, swr_tx_data, qua_mi2s_ws,
+                qua_mi2s_data, swr_rx_clk, swr_rx_data, dmic1_clk, i2s1_clk,
+                dmic1_data, i2s1_ws, dmic2_clk, dmic2_data, i2s1_data,
+                i2s2_clk, wsa_swr_clk, i2s2_ws, wsa_swr_data, dmic3_clk,
+                dmic3_data, i2s2_data ]
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      slew-rate:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+            0: No adjustments
+            1: Higher Slew rate (faster edges)
+            2: Lower Slew rate (slower edges)
+            3: Reserved (No adjustments)
+
+      bias-pull-down: true
+
+      bias-pull-up: true
+
+      bias-disable: true
+
+      output-high: true
+
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    lpi_tlmm: pinctrl@33c0000 {
+        compatible = "qcom,sm8250-lpass-lpi-pinctrl";
+        reg = <0x33c0000 0x20000>,
+              <0x3550000 0x10000>;
+        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+        clock-names = "core", "audio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&lpi_tlmm 0 0 14>;
+    };
-- 
2.7.4

