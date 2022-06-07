Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B38533B72
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiEYLO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbiEYLOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:14:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43128BD04;
        Wed, 25 May 2022 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653477261; x=1685013261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=O4otGyblllpBPDvOc1ezv7Wz3HXWEbPrUNO9I+gsuss=;
  b=fKC8/czhjDTcm6qY35WG3EgwpS61uM+if3kqejx1DLCxiQFvmm93MApg
   De6TfyE4Mgpy3HeQVgaCxt/91TE3ncCX+dUSCzjyxOFdwI/J6JuhuX2VX
   GVwJXSZxZCm5rQ5DL8bqIdb1yy9xLEKP0kc/jJCGMFPvNfEQwZ1hzbbgk
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 May 2022 04:14:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 04:14:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 04:14:21 -0700
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 04:14:16 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V8 1/7] dt-bindings: Added the yaml bindings for DCC
Date:   Wed, 25 May 2022 16:43:16 +0530
Message-ID: <41b94746e1560d63f16fb5dc965042ec496aeaf1.1653475467.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1653475467.git.quic_schowdhu@quicinc.com>
References: <cover.1653475467.git.quic_schowdhu@quicinc.com>
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

Documentation for Data Capture and Compare(DCC) device tree bindings
in yaml format.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
new file mode 100644
index 0000000..b7a6619
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,dcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Data Capture and Compare
+
+maintainers:
+  - Souradeep Chowdhury <schowdhu@codeaurora.org>
+
+description: |
+    DCC (Data Capture and Compare) is a DMA engine which is used to save
+    configuration data or system memory contents during catastrophic failure
+    or SW trigger. DCC is used to capture and store data for debugging purpose
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sm8150-dcc
+          - qcom,sc7280-dcc
+          - qcom,sc7180-dcc
+          - qcom,sdm845-dcc
+      - const: qcom,dcc
+
+  reg:
+    items:
+      - description: DCC base register region
+      - description: DCC RAM base register region
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dma@10a2000{
+                compatible = "qcom,sm8150-dcc","qcom,dcc";
+                reg = <0x010a2000  0x1000>,
+                      <0x010ad000  0x2000>;
+    };
-- 
2.7.4

