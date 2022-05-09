Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508A51FE9D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiEINpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiEINoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:44:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7C32685D9;
        Mon,  9 May 2022 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652103641; x=1683639641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JH0x1E/8aMwewdZ/zcW9VLRPTRAnZIwcMzcieBWDSRs=;
  b=R5xxJpjumCtwfJCC75U7pBWP5iaXD60r7f9PDbVo+coYnZD6v6jVdyiI
   I0HNri45y8rDnj2+GDZU6s2nBRo1lW9gKu51q/IUmfT1UQ6pIaX8l9UgW
   TvyNxeFZo2DMURpEe8gijJeVY06rQUP43tB+NfyRN1LwNWgKHAjImrynu
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 May 2022 06:40:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:40:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 06:40:39 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 06:40:35 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
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
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v7 08/10] dt-bindings: arm: Adds CoreSight TPDA hardware definitions
Date:   Mon, 9 May 2022 21:39:45 +0800
Message-ID: <20220509133947.20987-9-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/coresight-tpda.yaml          | 119 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml

diff --git a/Documentation/devicetree/bindings/arm/coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
new file mode 100644
index 000000000000..4948ac13e7f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
@@ -0,0 +1,119 @@
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
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Tao Zhang <quic_taozha@quicinc.com>
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 28d32b3f3f5c..5d2d8c0ee340 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1978,6 +1978,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 F:	Documentation/devicetree/bindings/arm/coresight-cti.yaml
+F:	Documentation/devicetree/bindings/arm/coresight-tpda.yaml
 F:	Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
 F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/devicetree/bindings/arm/ete.yaml
-- 
2.17.1

