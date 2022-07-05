Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0F566966
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiGELca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiGELc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:32:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC5E1403F;
        Tue,  5 Jul 2022 04:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657020746; x=1688556746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OsaLkT3umH4kgAjHw58Buvv6qeVIaVRPCZKVmwZeJLQ=;
  b=wN+MBqRzBd7NZtqlJuodSTwB8RMniTjzQo+ZpgxtTmo/NtU1umanX/Yn
   HZqnlWkTAzsCEgyrbJvemM65oGYj1V9j8vgnK+w+C1eopLSnnrzE8CeQ0
   wVifSg6vv6jlT04JB/89wv12WluAPGnBIDYFGqbvw1YNXQN09UI3ZQawW
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 04:32:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 04:32:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 04:32:25 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 04:32:21 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <mathieu.poirier@linaro.org>, <agross@kernel.org>,
        <konrad.dybcio@somainline.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V5 2/2] dt-bindings: remoteproc: qcom: Convert SC7180 MSS bindings to YAML
Date:   Tue, 5 Jul 2022 17:02:01 +0530
Message-ID: <1657020721-24939-3-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657020721-24939-1-git-send-email-quic_sibis@quicinc.com>
References: <1657020721-24939-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a separate YAML binding to act as a superset of the PAS and non-PAS
compatible for SC7180 MSS PIL. This also serves as a way to increase
readability.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

Depends on Krzysztof's remoteproc cleanups and improvements:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20220517070113.18023-1-krzysztof.kozlowski@linaro.org/

Previous discussion on PAS vs non-PAS bindings:
https://lore.kernel.org/lkml/YUps1JfGtf6JdbCx@ripper/ [Bjorn]
https://lore.kernel.org/lkml/CAE-0n51KBYjZvwGNy06_okmEWjEfRLQO54CYaY6-JnbBk6kOhA@mail.gmail.com/ [Stephen]

v5:
 * Improve phandle-array schemas [Stephen/Rob/Krzysztof]
 * Add more details to the firmware-name/memory region string array [Stephen/Rob]
 * Drop 'items' from label [Rob]

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  20 +-
 .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml   | 245 +++++++++++++++++++++
 2 files changed, 247 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 1ec9093c3a82..1a691c1435f3 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -14,7 +14,6 @@ on the Qualcomm Hexagon core.
 		    "qcom,msm8974-mss-pil"
 		    "qcom,msm8996-mss-pil"
 		    "qcom,msm8998-mss-pil"
-		    "qcom,sc7180-mss-pil"
 		    "qcom,sdm845-mss-pil"
 
 - reg:
@@ -46,7 +45,6 @@ on the Qualcomm Hexagon core.
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
 	qcom,msm8996-mss-pil:
 	qcom,msm8998-mss-pil:
-	qcom,sc7180-mss-pil:
 	qcom,sdm845-mss-pil:
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
 		    "shutdown-ack"
@@ -84,9 +82,6 @@ on the Qualcomm Hexagon core.
 	qcom,msm8998-mss-pil:
 		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
 		    "snoc_axi", "mnoc_axi", "qdss"
-	qcom,sc7180-mss-pil:
-		    must be "iface", "bus", "xo", "snoc_axi", "mnoc_axi",
-		    "nav"
 	qcom,sdm845-mss-pil:
 		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
 		    "snoc_axi", "mnoc_axi", "prng"
@@ -98,7 +93,7 @@ on the Qualcomm Hexagon core.
 		    reference to the list of 3 reset-controllers for the
 		    wcss sub-system
 		    reference to the list of 2 reset-controllers for the modem
-		    sub-system on SC7180, SDM845 SoCs
+		    sub-system on SDM845 SoCs
 
 - reset-names:
 	Usage: required
@@ -107,7 +102,7 @@ on the Qualcomm Hexagon core.
 		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
 		    for the wcss sub-system
 		    must be "mss_restart", "pdc_reset" for the modem
-		    sub-system on SC7180, SDM845 SoCs
+		    sub-system on SDM845 SoCs
 
 For devices where the mba and mpss sub-nodes are not specified, mba/mpss region
 should be referenced as follows:
@@ -172,8 +167,6 @@ For the compatible string below the following supplies are required:
 	qcom,msm8996-mss-pil:
 	qcom,msm8998-mss-pil:
 		    must be "cx", "mx"
-	qcom,sc7180-mss-pil:
-		    must be "cx", "mx", "mss"
 	qcom,sdm845-mss-pil:
 		    must be "cx", "mx", "mss"
 
@@ -200,15 +193,6 @@ For the compatible string below the following supplies are required:
 		    by the three offsets within syscon for q6, modem and nc
 		    halt registers.
 
-For the compatible strings below the following phandle references are required:
-  "qcom,sc7180-mss-pil"
-- qcom,spare-regs:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: a phandle reference to a syscon representing TCSR followed
-		    by the offset within syscon for conn_box_spare0 register
-		    used by the modem sub-system running on SC7180 SoC.
-
 The Hexagon node must contain iommus property as described in ../iommu/iommu.txt
 on platforms which do not have TrustZone.
 
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
new file mode 100644
index 000000000000..e76c861165dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
@@ -0,0 +1,245 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sc7180-mss-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7180 MSS Peripheral Image Loader
+
+maintainers:
+  - Sibi Sankar <quic_sibis@quicinc.com>
+
+description:
+  This document describes the hardware for a component that loads and boots firmware
+  on the Qualcomm Technology Inc. SC7180 Modem Hexagon Core.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7180-mss-pil
+
+  reg:
+    items:
+      - description: MSS QDSP6 registers
+      - description: RMB registers
+
+  reg-names:
+    items:
+      - const: qdsp6
+      - const: rmb
+
+  iommus:
+    items:
+      - description: MSA Stream 1
+      - description: MSA Stream 2
+
+  interrupts:
+    items:
+      - description: Watchdog interrupt
+      - description: Fatal interrupt
+      - description: Ready interrupt
+      - description: Handover interrupt
+      - description: Stop acknowledge interrupt
+      - description: Shutdown acknowledge interrupt
+
+  interrupt-names:
+    items:
+      - const: wdog
+      - const: fatal
+      - const: ready
+      - const: handover
+      - const: stop-ack
+      - const: shutdown-ack
+
+  clocks:
+    items:
+      - description: GCC MSS IFACE clock
+      - description: GCC MSS BUS clock
+      - description: GCC MSS NAV clock
+      - description: GCC MSS SNOC_AXI clock
+      - description: GCC MSS MFAB_AXIS clock
+      - description: RPMH XO clock
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bus
+      - const: nav
+      - const: snoc_axi
+      - const: mnoc_axi
+      - const: xo
+
+  power-domains:
+    items:
+      - description: CX power domain
+      - description: MX power domain
+      - description: MSS power domain
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mx
+      - const: mss
+
+  resets:
+    items:
+      - description: AOSS restart
+      - description: PDC reset
+
+  reset-names:
+    items:
+      - const: mss_restart
+      - const: pdc_reset
+
+  memory-region:
+    items:
+      - description: MBA reserved region
+      - description: modem reserved region
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    items:
+      - description: Name of MBA firmware
+      - description: Name of modem firmware
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Halt registers are used to halt transactions of various sub-components
+      within MSS.
+    items:
+      - items:
+          - description: phandle to TCSR_MUTEX registers
+          - description: offset to the Q6 halt register
+          - description: offset to the modem halt register
+          - description: offset to the nc halt register
+
+  qcom,spare-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Spare registers are multipurpose registers used for errata
+      handling.
+    items:
+      - items:
+          - description: phandle to TCSR_MUTEX registers
+          - description: offset to the conn_box_spare0 register
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the Hexagon core
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output
+    const: stop
+
+  glink-edge:
+    $ref: qcom,glink-edge.yaml#
+    description:
+      Qualcomm G-Link subnode which represents communication edge, channels
+      and devices related to the DSP.
+
+    properties:
+      interrupts:
+        items:
+          - description: IRQ from MSS to GLINK
+
+      mboxes:
+        items:
+          - description: Mailbox for communication between APPS and MSS
+
+      label:
+        const: modem
+
+      apr: false
+      fastrpc: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - iommus
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - power-domain-names
+  - resets
+  - reset-names
+  - qcom,halt-regs
+  - qcom,spare-regs
+  - memory-region
+  - qcom,qmp
+  - qcom,smem-states
+  - qcom,smem-state-names
+  - glink-edge
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
+    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+
+    remoteproc_mpss: remoteproc@4080000 {
+        compatible = "qcom,sc7180-mss-pil";
+        reg = <0x04080000 0x10000>, <0x04180000 0x48>;
+        reg-names = "qdsp6", "rmb";
+
+        iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
+
+        interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+
+        interrupt-names = "wdog", "fatal", "ready", "handover",
+                          "stop-ack", "shutdown-ack";
+
+        clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+                 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+                 <&gcc GCC_MSS_NAV_AXI_CLK>,
+                 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+                 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+                 <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "iface", "bus", "nav", "snoc_axi",
+                      "mnoc_axi", "xo";
+
+        power-domains = <&rpmhpd SC7180_CX>,
+                        <&rpmhpd SC7180_MX>,
+                        <&rpmhpd SC7180_MSS>;
+        power-domain-names = "cx", "mx", "mss";
+
+        memory-region = <&mba_mem>, <&mpss_mem>;
+
+        qcom,qmp = <&aoss_qmp>;
+
+        qcom,smem-states = <&modem_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+                 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+        reset-names = "mss_restart", "pdc_reset";
+
+        qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+        qcom,spare-regs = <&tcsr_regs 0xb3e4>;
+
+        glink-edge {
+            interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&apss_shared 12>;
+            qcom,remote-pid = <1>;
+            label = "modem";
+        };
+    };
-- 
2.7.4

