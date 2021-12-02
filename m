Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386F34660BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbhLBJ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:56:09 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:22645 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356679AbhLBJ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638438760; x=1669974760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9eo2qGNnGL41LARnRx/YPixlQKe6J2GkR3doXgm+13I=;
  b=cwjr80+XMUrAFoz08qnbUgru+scSWV3p3TFIoDf7fZh2s7kGap+6L4AC
   274JtABJZ0140pR14paeEj3O6t1ehTm9KgfeBk/iuWHd4cTXQXnWq6xoQ
   50nRsejCLHSCKEdTkByQ7MoiQrpt1lifOBEutibjA/Nn3wfDRAh5xwQ+I
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Dec 2021 01:52:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:52:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:52:37 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:52:32 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 1/8] dt-bindings: Add the yaml bindings for EUD
Date:   Thu, 2 Dec 2021 15:21:20 +0530
Message-ID: <401e300b18a86ca8fcfa77db0e7ba48d0ed88f15.1638430506.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1638430506.git.quic_schowdhu@quicinc.com>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for Embedded USB Debugger(EUD) device tree
bindings in yaml format.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
new file mode 100644
index 0000000..0c49d08
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,eud.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Embedded USB Debugger
+
+maintainers:
+  - Souradeep Chowdhury <schowdhu@codeaurora.org>
+
+description:
+  This binding is used to describe the Qualcomm Embedded USB Debugger, which is
+  mini USB-hub implemented on chip to support USB-based debug capabilities.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sc7280-eud
+      - const: qcom,eud
+
+  reg:
+    items:
+      - description: EUD Base Register Region
+      - description: EUD Mode Manager Register
+
+  interrupts:
+    description:
+      EUD interrupt
+
+  port:
+    description:
+      This port is to be attached to the endpoint of the connector child of
+      DWC3 controller node. The controller has the "usb-role-switch" property.
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    eud@88e0000 {
+           compatible = "qcom,sc7280-eud","qcom,eud";
+           reg = <0x88e0000 0x2000>,
+                 <0x88e2000 0x1000>;
+    };
-- 
2.7.4

