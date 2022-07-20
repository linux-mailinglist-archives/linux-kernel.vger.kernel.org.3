Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3983457B509
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbiGTLE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiGTLEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:04:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951B86E2FD;
        Wed, 20 Jul 2022 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658315064; x=1689851064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kAjjWLiiEM0pdfTrehQE5WDcpM33oDPnXSZyjJF9leQ=;
  b=vDXp+Io4YLZLydQwQ7wIf5sfiuNw1F+RhENNyseqJqkQ2K26iXT7zDCH
   Kjqpkxy2UYjOUp0/+CoSBAwX6Uuf7w5Hnzt6GKYM0QFqSdpoklp9dT9FY
   k9IlbiLcStjoJD0X+lC6D8sMIUsj/Ij9cB873x8X3eYp4SsEwsxQV3c1g
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jul 2022 04:04:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 04:04:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:04:23 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:04:19 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <quic_tdas@quicinc.com>,
        <quic_c_skakit@quicinc.com>
Subject: [PATCH V6 3/5] dt-bindings: clock: Add resets for LPASS audio clock controller for SC7280
Date:   Wed, 20 Jul 2022 16:33:41 +0530
Message-ID: <1658315023-3336-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
for SC7280. Update reg property min/max items in YAML schema.

Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml       | 19 ++++++++++++++++---
 include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h  |  5 +++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
index 5ccfb24..f50e284 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
@@ -22,6 +22,8 @@ properties:
 
   clock-names: true
 
+  reg: true
+
   compatible:
     enum:
       - qcom,sc7280-lpassaoncc
@@ -38,8 +40,8 @@ properties:
   '#power-domain-cells':
     const: 1
 
-  reg:
-    maxItems: 1
+  '#reset-cells':
+    const: 1
 
   qcom,adsp-pil-mode:
     description:
@@ -75,6 +77,11 @@ allOf:
           items:
             - const: bi_tcxo
             - const: lpass_aon_cc_main_rcg_clk_src
+
+        reg:
+          items:
+            - description: lpass core cc register
+            - description: lpass audio csr register
   - if:
       properties:
         compatible:
@@ -96,6 +103,8 @@ allOf:
             - const: bi_tcxo_ao
             - const: iface
 
+        reg:
+          maxItems: 1
   - if:
       properties:
         compatible:
@@ -114,6 +123,8 @@ allOf:
           items:
             - const: bi_tcxo
 
+        reg:
+          maxItems: 1
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
@@ -122,13 +133,15 @@ examples:
     #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
     lpass_audiocc: clock-controller@3300000 {
       compatible = "qcom,sc7280-lpassaudiocc";
-      reg = <0x3300000 0x30000>;
+      reg = <0x3300000 0x30000>,
+            <0x32a9000 0x1000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
       clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
       power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
       #clock-cells = <1>;
       #power-domain-cells = <1>;
+      #reset-cells = <1>;
     };
 
   - |
diff --git a/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h b/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
index 20ef2ea..22dcd47 100644
--- a/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
+++ b/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
@@ -24,6 +24,11 @@
 #define LPASS_AUDIO_CC_RX_MCLK_CLK			14
 #define LPASS_AUDIO_CC_RX_MCLK_CLK_SRC			15
 
+/* LPASS AUDIO CC CSR */
+#define LPASS_AUDIO_SWR_RX_CGCR				0
+#define LPASS_AUDIO_SWR_TX_CGCR				1
+#define LPASS_AUDIO_SWR_WSA_CGCR			2
+
 /* LPASS_AON_CC clocks */
 #define LPASS_AON_CC_PLL				0
 #define LPASS_AON_CC_PLL_OUT_EVEN			1
-- 
2.7.4

