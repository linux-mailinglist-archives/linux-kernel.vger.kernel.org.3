Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6204A8266
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350046AbiBCKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:35:47 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:8650 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349867AbiBCKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643884544; x=1675420544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ipXsq7qTH1/FSymAH5tAlILjsAInI3AmrKyu6Npw8iM=;
  b=Om8d66dtA4AjXtJTZHuYxqyHnyfs5NuMEaX0QtlzTn4VQybrk8FJ2hoZ
   jybO3b07TvKcXhs4fdmn1SnQDIxFn9i59llCoYoBCKCjnSlJvUO8YeFtp
   alxctupqj43I/Zhv2bo+0cpbYh+GfycZX+bDEHhFxTA+y0bx2k/4Osylg
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2022 02:35:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:35:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:35:43 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:35:39 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V5 1/6] dt-bindings: Add the yaml bindings for EUD
Date:   Thu, 3 Feb 2022 16:04:30 +0530
Message-ID: <09ebfb6c3efcd3084ba2eae65820a6d4187785c7.1643880577.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1643880577.git.quic_schowdhu@quicinc.com>
References: <cover.1643880577.git.quic_schowdhu@quicinc.com>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml     | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
new file mode 100644
index 0000000..c98aab2
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,eud.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Embedded USB Debugger
+
+maintainers:
+  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
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
+    description: EUD interrupt
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      These ports is to be attached to the endpoint of the DWC3 controller node
+      and type C connector node. The controller has the "usb-role-switch"
+      property.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: This port is to be attached to the DWC3 controller.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: This port is to be attached to the type C connector.
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    eud@88e0000 {
+           compatible = "qcom,sc7280-eud","qcom,eud";
+           reg = <0x88e0000 0x2000>,
+                 <0x88e2000 0x1000>;
+           ports {
+                   #address-cells = <1>;
+                   #size-cells = <0>;
+                   port@0 {
+                           reg = <0>;
+                           eud_ep: endpoint {
+                                   remote-endpoint = <&usb2_role_switch>;
+                           };
+                   };
+                   port@1 {
+                           reg = <1>;
+                           eud_con: endpoint {
+                                   remote-endpoint = <&con_eud>;
+                           };
+                   };
+           };
+    };
-- 
2.7.4

