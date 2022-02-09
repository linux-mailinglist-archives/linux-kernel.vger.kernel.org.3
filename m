Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D664AF07B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiBIL7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiBIL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:40 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E493EC1038F1;
        Wed,  9 Feb 2022 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644404285; x=1675940285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FgGVLLKzbuPBRNCztCvx+NV+dXwd+FE70X81iodajX8=;
  b=j+0HXHB0kqFfdTXIB5h/jHl8Z+cjEWSnZLjJc8C1ehD7YyUSelGjbWV1
   c5aTgSBSoSiOP0o+pxF9yyoL9/LKr98l3x4r1QoAR+rU63A/wNo9WYl+T
   2hU1RzgztpBiwpvyjmvWOkl2AE1Zp4OvF52Kdx74UP7nvivNaX7yolaTI
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 02:58:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 02:58:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:58:04 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:58:00 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 09/10] dt-bindings: arm: Adds CoreSight TPDA hardware definitions
Date:   Wed, 9 Feb 2022 18:57:05 +0800
Message-ID: <20220209105706.18852-10-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
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

Adds new coresight-tpda.yaml file describing the bindings required
to define tpda in the device trees.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/coresight-tpda.yaml          | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml

diff --git a/Documentation/devicetree/bindings/arm/coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
new file mode 100644
index 000000000000..311a70a1fcc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/coresight-tpda.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trace, Profiling and Diagnostics Aggregator - TPDA
+
+description: |
+  TPDAs are responsible for packetization and timestamping of data sets
+  utilizing the MIPI STPv2 packet protocol. Pulling data sets from one or
+  more attached TPDM and pushing the resultant (packetized) data out a
+  master ATB interface. Performing an arbitrated ATB interleaving (funneling)
+  task for free-flowing data from TPDM (i.e. CMB and DSB data set flows).
+
+maintainers:
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+
+properties:
+  $nodename:
+    pattern: "^tpda(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-tpda
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  qcom,tpda-atid:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
+    description: |
+      Use the ATID field for trace source identification. This allows
+      multiple TPDMs to be interleaved and formatted via the Coresight
+      trace formatter framing protocol and de-formatted/parsed on a host
+      or debugger.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  in-ports:
+    type: object
+    description: |
+      Input connections from TPDM to TPDA
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^port@[0-9a-f]+$":
+        type: object
+        required:
+          - reg
+
+    required:
+      - '#size-cells'
+      - '#address-cells'
+
+  out-ports:
+    type: object
+    description: |
+      Output connections from the TPDA to legacy CoreSight trace bus.
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+     port:
+       description:
+         Output connection from the TPDA to legacy CoreSight Trace bus.
+       $ref: /schemas/graph.yaml#/properties/port
+
+required:
+    - compatible
+    - reg
+    - qcom,tpda-atid
+    - clocks
+    - clock-names
+    - in-ports
+    - out-ports
+
+additionalProperties: false
+
+examples:
+  # minimum tpda definition.
+  - |
+    tpda@6004000 {
+       compatible = "qcom,coresight-tpda", "arm,primecell";
+       reg = <0x6004000 0x1000>;
+
+       qcom,tpda-atid = <65>;
+
+       clocks = <&aoss_qmp>;
+       clock-names = "apb_pclk";
+
+       in-ports {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          tpda_qdss_0_in_tpdm_dcc: endpoint {
+            remote-endpoint =
+              <&tpdm_dcc_out_tpda_qdss_0>;
+            };
+        };
+      };
+
+       out-ports {
+         port {
+                 tpda_qdss_out_funnel_in0: endpoint {
+                    remote-endpoint =
+                    <&funnel_in0_in_tpda_qdss>;
+                  };
+          };
+       };
+    };
+
+...
-- 
2.17.1

