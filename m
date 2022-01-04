Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9548414B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiADL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:59:46 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:6966 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232731AbiADL7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641297582; x=1672833582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PfFj0CJ7Z+T4HaxN3nL++olZvDm4hxLT9ASz/R5gqjE=;
  b=fSvdAZgVOJh9JQSupY+ARuoGOE7+/0tY5Qvk3yo4tiJdjVz2CLkDN+ba
   f4fb39GJhXsGI4r3k48rek0GPCiJDtzNz6FuZT0fhH/idA01bx4KDkL/1
   Txm0aAO0PabaLhLVbh0FmAD/oimubGdLfFRHtiSWGZbbBNtBt0IWTucwz
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Jan 2022 03:59:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 03:59:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 03:59:39 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 03:59:34 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, <tsoni@codeaurora.org>,
        <psodagud@codeaurora.org>, <satyap@codeaurora.org>,
        <pheragu@codeaurora.org>, <rnayak@codeaurora.org>,
        <sibis@codeaurora.org>, <saiprakash.ranjan@codeaurora.org>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V3 1/7] dt-bindings: Add the yaml bindings for EUD
Date:   Tue, 4 Jan 2022 17:28:14 +0530
Message-ID: <5d9491693870b5dde757959f4491296503d22f70.1641288286.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641288286.git.quic_schowdhu@quicinc.com>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
index 0000000..3523932
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

