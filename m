Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8851FE8E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiEINoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiEINoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:44:13 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C62655CE;
        Mon,  9 May 2022 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652103620; x=1683639620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IVmO9D+Vm96kcooLwoiSwRjXUHzZKbKPSe0OzOHGd74=;
  b=Q9y00SYFdytaOvz2pgKa9cbi6uplgN1BI6FoVyQzLki0LU6mE7OKZiYR
   YbyfNV8IUxON9LmgXJ5HYJTmNCxDi1gC//2WYarxLnm3ArBvr+4C3cbka
   Uc6f5cNNjSuPsQk0UxYrHET5EizSysLM/EHD6+Iv1WPq3fmPJcX+f9jEf
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 06:40:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:40:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 06:40:18 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 06:40:14 -0700
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
Subject: [PATCH v7 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware definitions
Date:   Mon, 9 May 2022 21:39:40 +0800
Message-ID: <20220509133947.20987-4-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds new coresight-tpdm.yaml file describing the bindings required
to define tpdm in the device trees.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/coresight-tpdm.yaml          | 99 +++++++++++++++++++
 .../devicetree/bindings/arm/coresight.txt     |  7 ++
 MAINTAINERS                                   |  1 +
 3 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml

diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
new file mode 100644
index 000000000000..451342d3d8b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/coresight-tpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trace, Profiling and Diagnostics Monitor - TPDM
+
+description: |
+  The TPDM or Monitor serves as data collection component for various dataset
+  types specified in the QPMDA spec. It covers Implementation defined ((ImplDef),
+  Basic Counts (BC), Tenure Counts (TC), Continuous Multi-Bit (CMB), and Discrete
+  Single Bit (DSB). It performs data collection in the data producing clock
+  domain and transfers it to the data collection time domain, generally ATB
+  clock domain.
+
+  The primary use case of the TPDM is to collect data from different data
+  sources and send it to a TPDA for packetization, timestamping, and funneling.
+
+maintainers:
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Tao Zhang <quic_taozha@quicinc.com>
+
+properties:
+  $nodename:
+    pattern: "^tpdm(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-tpdm
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+   items:
+     - const: apb_pclk
+
+  out-ports:
+    description: |
+      Output connections from the TPDM to coresight funnle/tpda.
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port:
+        description: Output connection from the TPDM to coresight
+            funnel/tpda.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  # minimum TPDM definition. TPDM connect to coresight funnel.
+  - |
+    tpdm@6980000 {
+      compatible = "qcom,coresight-tpdm", "arm,primecell";
+      reg = <0x6980000 0x1000>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      out-ports {
+        port {
+          tpdm_turing_out_funnel_turing: endpoint {
+            remote-endpoint =
+              <&funnel_turing_in_tpdm_turing>;
+          };
+        };
+      };
+    };
+  # minimum TPDM definition. TPDM connect to coresight TPDA.
+  - |
+    tpdm@684c000 {
+      compatible = "qcom,coresight-tpdm", "arm,primecell";
+      reg = <0x684c000 0x1000>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      out-ports {
+        port {
+          tpdm_prng_out_tpda_qdss: endpoint {
+            remote-endpoint =
+              <&tpda_qdss_in_tpdm_prng>;
+          };
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index c68d93a35b6c..f7ce8af48574 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -52,6 +52,10 @@ its hardware characteristcs.
 			"arm,coresight-cti", "arm,primecell";
 			See coresight-cti.yaml for full CTI definitions.
 
+		- Trace, Profiling and Diagnostics Monitor (TPDM):
+			"qcom,coresight-tpdm", "arm,primecell";
+			See coresight-tpdm.yaml for full TPDM definitions.
+
 	* reg: physical base address and length of the register
 	  set(s) of the component.
 
@@ -82,6 +86,9 @@ its hardware characteristcs.
 * Required properties for Coresight Cross Trigger Interface (CTI)
 	See coresight-cti.yaml for full CTI definitions.
 
+* Required properties for Trace, Profiling and Diagnostics Monitor (TPDM)
+	See coresight-tpdm.yaml for full TPDM definitions.
+
 * Required properties for devices that don't show up on the AMBA bus, such as
   non-configurable replicators and non-configurable funnels:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..28d32b3f3f5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1978,6 +1978,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 F:	Documentation/devicetree/bindings/arm/coresight-cti.yaml
+F:	Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
 F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/devicetree/bindings/arm/ete.yaml
 F:	Documentation/devicetree/bindings/arm/trbe.yaml
-- 
2.17.1

