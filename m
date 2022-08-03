Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256E0588E78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiHCOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiHCOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:21:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743AE15A01;
        Wed,  3 Aug 2022 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659536507; x=1691072507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=W/xwRUYFWKtrKuwiHbo54nv9KOwbqLwnqwwukkswyy8=;
  b=ERf/mGLurP/FgzZCDehUXAqbJo4QZkQtsdFXW5d31GcWetdbmrwcx+4w
   i1DsixykO0MoibuPT4p3R402AQY5EGnZercO1DLKnTMbn8UR38CI8SS0C
   g2RSDKJCeJqWyxkZI2HmFjm6DyEza8uc2APWgTDcGoNxEpztligKp1zuG
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Aug 2022 07:21:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:21:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 07:21:46 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 07:21:40 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 1/8] dt-bindings: remoteproc: qcom: adsp: Make ADSP pil loader as generic
Date:   Wed, 3 Aug 2022 19:51:13 +0530
Message-ID: <1659536480-5176-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename sdm845 adsp pil bindings to generic name, for using same binings
file for subsequent SoCs.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 .../bindings/remoteproc/qcom,lpass-adsp-pil.yaml   | 160 +++++++++++++++++++++
 .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  | 160 ---------------------
 2 files changed, 160 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
new file mode 100644
index 0000000..9f11332
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,lpass-adsp-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LPASS ADSP Peripheral Image Loader
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  This document defines the binding for a component that loads and boots firmware
+  on the Qualcomm Technology Inc. ADSP.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-adsp-pil
+
+  reg:
+    maxItems: 1
+    description:
+      The base address and size of the qdsp6ss register
+
+  interrupts:
+    items:
+      - description: Watchdog interrupt
+      - description: Fatal interrupt
+      - description: Ready interrupt
+      - description: Handover interrupt
+      - description: Stop acknowledge interrupt
+
+  interrupt-names:
+    items:
+      - const: wdog
+      - const: fatal
+      - const: ready
+      - const: handover
+      - const: stop-ack
+
+  clocks:
+    items:
+      - description: XO clock
+      - description: SWAY clock
+      - description: LPASS AHBS AON clock
+      - description: LPASS AHBM AON clock
+      - description: QDSP XO clock
+      - description: Q6SP6SS SLEEP clock
+      - description: Q6SP6SS CORE clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: sway_cbcr
+      - const: lpass_ahbs_aon_cbcr
+      - const: lpass_ahbm_aon_cbcr
+      - const: qdsp6ss_xo
+      - const: qdsp6ss_sleep
+      - const: qdsp6ss_core
+
+  power-domains:
+    items:
+      - description: CX power domain
+
+  resets:
+    items:
+      - description: PDC AUDIO SYNC RESET
+      - description: CC LPASS restart
+
+  reset-names:
+    items:
+      - const: pdc_sync
+      - const: cc_lpass
+
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle reference to a syscon representing TCSR followed by the
+      three offsets within syscon for q6, modem and nc halt registers.
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the Hexagon core
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The names of the state bits used for SMP2P output
+    items:
+      - const: stop
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+  - qcom,halt-regs
+  - memory-region
+  - qcom,smem-states
+  - qcom,smem-state-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/clock/qcom,lpass-sdm845.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
+    remoteproc@17300000 {
+        compatible = "qcom,sdm845-adsp-pil";
+        reg = <0x17300000 0x40c>;
+
+        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                "handover", "stop-ack";
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>,
+                 <&gcc GCC_LPASS_SWAY_CLK>,
+                 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
+                 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
+                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
+                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
+                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
+        clock-names = "xo", "sway_cbcr",
+                "lpass_ahbs_aon_cbcr",
+                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
+                "qdsp6ss_sleep", "qdsp6ss_core";
+
+        power-domains = <&rpmhpd SDM845_CX>;
+
+        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
+                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
+        reset-names = "pdc_sync", "cc_lpass";
+
+        qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
+
+        memory-region = <&pil_adsp_mem>;
+
+        qcom,smem-states = <&adsp_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+    };
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
deleted file mode 100644
index 1535bbb..0000000
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
+++ /dev/null
@@ -1,160 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/remoteproc/qcom,sdm845-adsp-pil.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm SDM845 ADSP Peripheral Image Loader
-
-maintainers:
-  - Bjorn Andersson <bjorn.andersson@linaro.org>
-
-description:
-  This document defines the binding for a component that loads and boots firmware
-  on the Qualcomm Technology Inc. ADSP.
-
-properties:
-  compatible:
-    enum:
-      - qcom,sdm845-adsp-pil
-
-  reg:
-    maxItems: 1
-    description:
-      The base address and size of the qdsp6ss register
-
-  interrupts:
-    items:
-      - description: Watchdog interrupt
-      - description: Fatal interrupt
-      - description: Ready interrupt
-      - description: Handover interrupt
-      - description: Stop acknowledge interrupt
-
-  interrupt-names:
-    items:
-      - const: wdog
-      - const: fatal
-      - const: ready
-      - const: handover
-      - const: stop-ack
-
-  clocks:
-    items:
-      - description: XO clock
-      - description: SWAY clock
-      - description: LPASS AHBS AON clock
-      - description: LPASS AHBM AON clock
-      - description: QDSP XO clock
-      - description: Q6SP6SS SLEEP clock
-      - description: Q6SP6SS CORE clock
-
-  clock-names:
-    items:
-      - const: xo
-      - const: sway_cbcr
-      - const: lpass_ahbs_aon_cbcr
-      - const: lpass_ahbm_aon_cbcr
-      - const: qdsp6ss_xo
-      - const: qdsp6ss_sleep
-      - const: qdsp6ss_core
-
-  power-domains:
-    items:
-      - description: CX power domain
-
-  resets:
-    items:
-      - description: PDC AUDIO SYNC RESET
-      - description: CC LPASS restart
-
-  reset-names:
-    items:
-      - const: pdc_sync
-      - const: cc_lpass
-
-  memory-region:
-    maxItems: 1
-    description: Reference to the reserved-memory for the Hexagon core
-
-  qcom,halt-regs:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description:
-      Phandle reference to a syscon representing TCSR followed by the
-      three offsets within syscon for q6, modem and nc halt registers.
-
-  qcom,smem-states:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description: States used by the AP to signal the Hexagon core
-    items:
-      - description: Stop the modem
-
-  qcom,smem-state-names:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: The names of the state bits used for SMP2P output
-    items:
-      - const: stop
-
-required:
-  - compatible
-  - reg
-  - interrupts
-  - interrupt-names
-  - clocks
-  - clock-names
-  - power-domains
-  - resets
-  - reset-names
-  - qcom,halt-regs
-  - memory-region
-  - qcom,smem-states
-  - qcom,smem-state-names
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
-    #include <dt-bindings/clock/qcom,lpass-sdm845.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
-    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
-    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
-    remoteproc@17300000 {
-        compatible = "qcom,sdm845-adsp-pil";
-        reg = <0x17300000 0x40c>;
-
-        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
-                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-        interrupt-names = "wdog", "fatal", "ready",
-                "handover", "stop-ack";
-
-        clocks = <&rpmhcc RPMH_CXO_CLK>,
-                 <&gcc GCC_LPASS_SWAY_CLK>,
-                 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
-                 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
-                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
-                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
-                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
-        clock-names = "xo", "sway_cbcr",
-                "lpass_ahbs_aon_cbcr",
-                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
-                "qdsp6ss_sleep", "qdsp6ss_core";
-
-        power-domains = <&rpmhpd SDM845_CX>;
-
-        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
-                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
-        reset-names = "pdc_sync", "cc_lpass";
-
-        qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
-
-        memory-region = <&pil_adsp_mem>;
-
-        qcom,smem-states = <&adsp_smp2p_out 0>;
-        qcom,smem-state-names = "stop";
-    };
-- 
2.7.4

