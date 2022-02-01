Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6A4A5A97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiBAKwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:52:40 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38010 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236902AbiBAKwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643712759; x=1675248759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yqgm7U5YGtZz6hahIBNTP2HYghD/D1TM6tljCYAyk98=;
  b=KjkyywHCRDV4c1UyUBpbJBSiPi9d0H8GStDuBDbk7wcELv4ve+Z4sut7
   e4tjXA4+z/ABi0fBBtYgEY8hVRs9KuFwn4uSAkUGrhKHEvrad7BCP44Y2
   HR0duJxbriQO8wAlVj8VgfFSOArxzxlnJdCa8DpvbTddctFDbCQBkcYOQ
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Feb 2022 02:52:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 02:52:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 1 Feb 2022 02:52:38 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 1 Feb 2022 02:52:33 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <ohad@wizery.com>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>
CC:     <linux-remoteproc@vger.kernel.org>, <swboyd@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <kuabhs@chromium.org>, <quic_pillair@quicinc.com>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v10 1/3] dt-bindings: remoteproc: qcom: adsp: Convert binding to YAML
Date:   Tue, 1 Feb 2022 16:22:02 +0530
Message-ID: <1643712724-12436-2-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Pillai <pillair@codeaurora.org>

Convert Qualcomm ADSP/CDSP Remoteproc devicetree
binding to YAML.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 .../bindings/remoteproc/qcom,hexagon-v56.txt       | 140 ------------------
 .../bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml  | 161 +++++++++++++++++++++
 .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  | 160 ++++++++++++++++++++
 3 files changed, 321 insertions(+), 140 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt b/Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
deleted file mode 100644
index 1337a3d..0000000
--- a/Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
+++ /dev/null
@@ -1,140 +0,0 @@
-Qualcomm Technology Inc. Hexagon v56 Peripheral Image Loader
-
-This document defines the binding for a component that loads and boots firmware
-on the Qualcomm Technology Inc. Hexagon v56 core.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,qcs404-cdsp-pil",
-		    "qcom,sdm845-adsp-pil"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must specify the base address and size of the qdsp6ss register
-
-- interrupts-extended:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must list the watchdog, fatal IRQs ready, handover and
-		    stop-ack IRQs
-
-- interrupt-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition:  List of phandles and clock specifier pairs for the Hexagon,
-		     per clock-names below.
-
-- clock-names:
-	Usage: required for SDM845 ADSP
-	Value type: <stringlist>
-	Definition: List of clock input name strings sorted in the same
-		    order as the clocks property. Definition must have
-		    "xo", "sway_cbcr", "lpass_ahbs_aon_cbcr",
-		    "lpass_ahbm_aon_cbcr", "qdsp6ss_xo", "qdsp6ss_sleep"
-		    and "qdsp6ss_core".
-
-- clock-names:
-	Usage: required for QCS404 CDSP
-	Value type: <stringlist>
-	Definition: List of clock input name strings sorted in the same
-		    order as the clocks property. Definition must have
-		    "xo", "sway", "tbu", "bimc", "ahb_aon", "q6ss_slave",
-		    "q6ss_master", "q6_axim".
-
-- power-domains:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to cx power domain node.
-
-- resets:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the list of resets for the Hexagon.
-
-- reset-names:
-        Usage: required for SDM845 ADSP
-        Value type: <stringlist>
-        Definition: must be "pdc_sync" and "cc_lpass"
-
-- reset-names:
-        Usage: required for QCS404 CDSP
-        Value type: <stringlist>
-        Definition: must be "restart"
-
-- qcom,halt-regs:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: a phandle reference to a syscon representing TCSR followed
-		    by the offset within syscon for Hexagon halt register.
-
-- memory-region:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the reserved-memory for the firmware
-
-- qcom,smem-states:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the smem state for requesting the Hexagon to
-		    shut down
-
-- qcom,smem-state-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "stop"
-
-
-= SUBNODES
-The adsp node may have an subnode named "glink-edge" that describes the
-communication edge, channels and devices related to the Hexagon.
-See ../soc/qcom/qcom,glink.txt for details on how to describe these.
-
-= EXAMPLE
-The following example describes the resources needed to boot control the
-ADSP, as it is found on SDM845 boards.
-
-	remoteproc@17300000 {
-		compatible = "qcom,sdm845-adsp-pil";
-		reg = <0x17300000 0x40c>;
-
-		interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
-			<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-			<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-			<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-			<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "wdog", "fatal", "ready",
-			"handover", "stop-ack";
-
-		clocks = <&rpmhcc RPMH_CXO_CLK>,
-			<&gcc GCC_LPASS_SWAY_CLK>,
-			<&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
-			<&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
-			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
-			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
-			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
-		clock-names = "xo", "sway_cbcr",
-			"lpass_ahbs_aon_cbcr",
-			"lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
-			"qdsp6ss_sleep", "qdsp6ss_core";
-
-		power-domains = <&rpmhpd SDM845_CX>;
-
-		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
-			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
-		reset-names = "pdc_sync", "cc_lpass";
-
-		qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
-
-		memory-region = <&pil_adsp_mem>;
-
-		qcom,smem-states = <&adsp_smp2p_out 0>;
-		qcom,smem-state-names = "stop";
-	};
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
new file mode 100644
index 0000000..31413cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,qcs404-cdsp-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCS404 CDSP Peripheral Image Loader
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  This document defines the binding for a component that loads and boots firmware
+  on the Qualcomm Technology Inc. CDSP (Compute DSP).
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcs404-cdsp-pil
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
+      - description: TBU clock
+      - description: BIMC clock
+      - description: AHB AON clock
+      - description: Q6SS SLAVE clock
+      - description: Q6SS MASTER clock
+      - description: Q6 AXIM clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: sway
+      - const: tbu
+      - const: bimc
+      - const: ahb_aon
+      - const: q6ss_slave
+      - const: q6ss_master
+      - const: q6_axim
+
+  power-domains:
+    items:
+      - description: CX power domain
+
+  resets:
+    items:
+      - description: AOSS restart
+
+  reset-names:
+    items:
+      - const: restart
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
+    #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/clock/qcom,turingcc-qcs404.h>
+    remoteproc@b00000 {
+        compatible = "qcom,qcs404-cdsp-pil";
+        reg = <0x00b00000 0x4040>;
+
+        interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
+                              <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        clocks = <&xo_board>,
+                 <&gcc GCC_CDSP_CFG_AHB_CLK>,
+                 <&gcc GCC_CDSP_TBU_CLK>,
+                 <&gcc GCC_BIMC_CDSP_CLK>,
+                 <&turingcc TURING_WRAPPER_AON_CLK>,
+                 <&turingcc TURING_Q6SS_AHBS_AON_CLK>,
+                 <&turingcc TURING_Q6SS_AHBM_AON_CLK>,
+                 <&turingcc TURING_Q6SS_Q6_AXIM_CLK>;
+        clock-names = "xo",
+                      "sway",
+                      "tbu",
+                      "bimc",
+                      "ahb_aon",
+                      "q6ss_slave",
+                      "q6ss_master",
+                      "q6_axim";
+
+        power-domains = <&rpmhpd SDM845_CX>;
+
+        resets = <&gcc GCC_CDSP_RESTART>;
+        reset-names = "restart";
+
+        qcom,halt-regs = <&tcsr 0x19004>;
+
+        memory-region = <&cdsp_fw_mem>;
+
+        qcom,smem-states = <&cdsp_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+    };
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
new file mode 100644
index 0000000..1535bbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sdm845-adsp-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM845 ADSP Peripheral Image Loader
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
-- 
2.7.4

