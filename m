Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5089E59BB59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiHVIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiHVIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:23:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F807E90;
        Mon, 22 Aug 2022 01:23:20 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M6gDxr026127;
        Mon, 22 Aug 2022 08:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/Q5kmXxuUFHz47EJqw2ElHmEA0gkxMeb4ibI1KBQWFA=;
 b=VG2aOiFbYEupKZOq4CLOFGaBnE7yxAgLvMx8rRHTVoCETDKIUysBjQ6+E/vMc5zFEr+W
 q+LyqXqyXRiObl9PJ51cW2A50AmXhfX3oPGar5+A556QY/6MEoiM+fjNGDxyFOri+eTc
 Jumpd/vsDahNRgROF0OqdRtb0C4yF+UDOow5Me+mBtLham8OOfyZTr8bf6/ClJwI6Q0L
 sIx9z0USYKl8Q7+DiKx9YMjm5z1l/2KXjIHNzN1XyqbNAHjIcXSl+UZJdpSokeRElJ0T
 vpABwneGy6ECm4r9KcvkR8ftxSa9Dee/J/O73oI7ORxFMNbbm+qXZYIvRub+93KFXXz2 7A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2vwn3nbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 08:22:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27M8MWa5015731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 08:22:32 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 22 Aug 2022 01:22:26 -0700
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
Subject: [RESEND v5 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP support
Date:   Mon, 22 Aug 2022 13:51:57 +0530
Message-ID: <1661156523-22611-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com>
References: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -00uXRz5H5ZkGVmkfUyfZsJM-Rk-WqsB
X-Proofpoint-ORIG-GUID: -00uXRz5H5ZkGVmkfUyfZsJM-Rk-WqsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADSP PIL loading support for SC7280 SoCs.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V4:
	-- Update halt registers description in dt bindings.

 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 196 +++++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
new file mode 100644
index 0000000..cf895fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
@@ -0,0 +1,196 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-adsp-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7280 ADSP Peripheral Image Loader
+
+maintainers:
+  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
+
+description:
+  This document defines the binding for a component that loads and boots firmware
+  on the Qualcomm Technology Inc. ADSP.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7280-adsp-pil
+
+  reg:
+    minItems: 1
+    items:
+      - description: qdsp6ss register
+      - description: efuse q6ss register
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
+      - description: XO clock
+      - description: GCC CFG NOC LPASS clock
+      - description: LPASS AHBS AON clock
+      - description: LPASS AHBM AON clock
+      - description: QDSP XO clock
+      - description: Q6SP6SS SLEEP clock
+      - description: Q6SP6SS CORE clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: gcc_cfg_noc_lpass
+      - const: lpass_ahbs_aon_cbcr
+      - const: lpass_ahbm_aon_cbcr
+      - const: qdsp6ss_xo
+      - const: qdsp6ss_sleep
+      - const: qdsp6ss_core
+
+  power-domains:
+    items:
+      - description: LCX power domain
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
+  qcom,adsp-memory-regions:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      Each entry consists of 4 integers and represents the
+      list of memory regions accessed by ADSP firmware.
+    items:
+      items:
+        - description: |
+            "iova reg" indicates the address of virtual memory region.
+        - description: |
+            "physical reg" indicates the address of phyical memory region.
+        - description: |
+            "size" indicates the offset memory region.
+        - description: |
+            "access level" indicates the read, read and write access levels.
+          minimum: 0
+          maximum: 1
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle reference to a syscon representing TCSR followed by the
+      four offsets within syscon for q6, CE, AXI and qv6 halt registers.
+    items:
+      items:
+        - description: phandle to TCSR MUTEX
+        - description: offset to q6 halt registers
+        - description: offset to CE halt registers
+        - description: offset to AXI halt registers
+        - description: offset to qv6 halt registers
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
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpass-sc7280.h>
+    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
+    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@3000000 {
+        compatible = "qcom,sc7280-adsp-pil";
+        reg = <0x03000000 0x5000>,
+              <0x355B000 0x10>;
+
+        interrupts-extended = <&pdc 162 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+                <&adsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+
+        interrupt-names = "wdog", "fatal", "ready",
+                "handover", "stop-ack", "shutdown-ack";
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>,
+                 <&gcc GCC_CFG_NOC_LPASS_CLK>,
+                 <&lpasscc LPASS_Q6SS_AHBM_CLK>,
+                 <&lpasscc LPASS_Q6SS_AHBS_CLK>,
+                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
+                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
+                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
+        clock-names = "xo", "gcc_cfg_noc_lpass",
+                "lpass_ahbs_aon_cbcr",
+                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
+                "qdsp6ss_sleep", "qdsp6ss_core";
+
+        power-domains = <&rpmhpd SC7280_LCX>;
+
+        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
+                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
+        reset-names = "pdc_sync", "cc_lpass";
+
+        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
+
+        memory-region = <&adsp_mem>;
+
+        qcom,smem-states = <&adsp_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        qcom,adsp-memory-regions = <0x00100000 0x00100000 0x4000 0>,
+                                   <0x00113000 0x00113000 0x1000 0>,
+                                   <0x00117000 0x00117000 0x2000 1>;
+    };
-- 
2.7.4

