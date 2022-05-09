Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5651F6D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiEIIOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbiEIIAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:00:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A024F10;
        Mon,  9 May 2022 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652083002; x=1683619002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HnEbvuN+yd7oaFfluy2z1va7ritUGrAZ1bTfH58jjFQ=;
  b=o3GV+FiIDp42md0gqoFZdBa+obBH4Fc67fJaBMYVyVaPNbuYVAWHlABG
   Yx3PwED0h5KB4HwHHcrcxtt/3M7JizyCwUEnlVzk0xkpMIE2jVSDXzUQY
   Ne+DZfDuwQVSbgXJSx5GvsJQyMTtQ1DcC+mmiBTFbHvLmtryZTgiHb10v
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 May 2022 00:53:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 00:53:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 00:53:38 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 00:53:33 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <evgreen@chromium.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>, <mka@chromium.org>,
        <krzysztof.kozlowski@canonical.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add SC7280 MSS bindings
Date:   Mon, 9 May 2022 13:23:17 +0530
Message-ID: <1652082798-5855-2-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652082798-5855-1-git-send-email-quic_sibis@quicinc.com>
References: <1652082798-5855-1-git-send-email-quic_sibis@quicinc.com>
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

Add MSS PIL loading bindings for SC7280 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 261 +++++++++++++++++++++
 1 file changed, 261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
new file mode 100644
index 000000000000..7e7dee6208b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
@@ -0,0 +1,261 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-mss-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7280 MSS Peripheral Image Loader
+
+maintainers:
+  - Sibi Sankar <quic_sibis@quicinc.com>
+
+description:
+  This document defines the binding for a component that loads and boots firmware
+  on the Qualcomm Technology Inc. SC7280 Modem Hexagon Core.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7280-mss-pil
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
+  interconnects:
+    items:
+      - description: Path leading to system memory
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
+      - description: GCC MSS SNOC_AXI clock
+      - description: GCC MSS OFFLINE clock
+      - description: RPMH PKA clock
+      - description: RPMH XO clock
+
+  clock-names:
+    items:
+      - const: iface
+      - const: snoc_axi
+      - const: offline
+      - const: pka
+      - const: xo
+
+  power-domains:
+    items:
+      - description: CX power domain
+      - description: MSS power domain
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mss
+
+  resets:
+    items:
+      - description: AOSS restart
+      - description: PDC SYNC
+
+  reset-names:
+    items:
+      - const: mss_restart
+      - const: pdc_sync
+
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Phandle reference to the reserved-memory for the MBA region followed
+                 by the modem region.
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      The name of the firmware which should be loaded for this remote
+      processor.
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle reference to a syscon representing TCSR followed by the
+      four offsets within syscon for q6, modem, nc and vq6 halt registers.
+
+  qcom,ext-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Two phandle references to syscons representing TCSR_REG and TCSR register
+      space followed by the two offsets within the syscon to force_clk_en/rscc_disable
+      and axim1_clk_off/crypto_clk_off registers respectively.
+
+  qcom,qaccept-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle reference to a syscon representing TCSR followed by the
+      three offsets within syscon for mdm, cx and axi qaccept registers.
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
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The names of the state bits used for SMP2P output
+    const: stop
+
+  glink-edge:
+    type: object
+    description: |
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
+        description: The names of the state bits used for SMP2P output
+        items:
+          - const: modem
+
+      qcom,remote-pid:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: ID of the shared memory used by GLINK for communication with MSS
+
+    required:
+      - interrupts
+      - mboxes
+      - label
+      - qcom,remote-pid
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - iommus
+  - interconnects
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - power-domain-names
+  - resets
+  - reset-names
+  - qcom,halt-regs
+  - qcom,ext-regs
+  - qcom,qaccept-regs
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
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interconnect/qcom,sc7280.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
+    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+
+    remoteproc_mpss: remoteproc@4080000 {
+        compatible = "qcom,sc7280-mss-pil";
+        reg = <0x04080000 0x10000>, <0x04180000 0x48>;
+        reg-names = "qdsp6", "rmb";
+
+        iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
+
+        interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
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
+                 <&gcc GCC_MSS_OFFLINE_AXI_CLK>,
+                 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+                 <&rpmhcc RPMH_PKA_CLK>,
+                 <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "iface", "offline", "snoc_axi", "pka", "xo";
+
+        power-domains = <&rpmhpd SC7280_CX>,
+                        <&rpmhpd SC7280_MSS>;
+        power-domain-names = "cx", "mss";
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
+        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
+        qcom,ext-regs = <&tcsr 0x10000 0x10004 &tcsr_mutex 0x26004 0x26008>;
+        qcom,qaccept-regs = <&tcsr_mutex 0x23030 0x23040 0x23020>;
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+                                   IPCC_MPROC_SIGNAL_GLINK_QMP
+                                   IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_MPSS
+                      IPCC_MPROC_SIGNAL_GLINK_QMP>;
+            label = "modem";
+            qcom,remote-pid = <1>;
+        };
+    };
-- 
2.7.4

