Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A687C54B4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbiFNPdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbiFNPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:33:49 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E82A41D;
        Tue, 14 Jun 2022 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655220825; x=1686756825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zjY0XrQYS1nwkvWVBjG20NJdnIYkCMtINOIY31X1fa4=;
  b=TQ8r8mulpS1FWxyGbR1KrvPV9vOcNBr23d/KryCxc0lvRuHbz2UU58DK
   1AbgF+LRXvMUAR6kkhbo5WeQ34GxXeT1/4cq0Jpfr1Kv91AKy8ghaOSeD
   n+a9UFrckZzPPVA6fw2AR8hZCHKmFiBiiLtpYco6atuKoug4tiADqmNBM
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jun 2022 08:33:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:33:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 08:33:44 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 08:33:40 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v5 1/3] dt-bindings: clock: Add resets for LPASS audio clock controller for SC7280
Date:   Tue, 14 Jun 2022 21:03:04 +0530
Message-ID: <20220614153306.29339-2-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220614153306.29339-1-quic_tdas@quicinc.com>
References: <20220614153306.29339-1-quic_tdas@quicinc.com>
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

Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
for SC7280. Update reg property min/max items in YAML schema.

Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 .../clock/qcom,sc7280-lpasscorecc.yaml        | 19 ++++++++++++++++---
 .../clock/qcom,lpassaudiocc-sc7280.h          |  5 +++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
index bad9135489de..1d20cdcc69ff 100644
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

 required:
   - compatible
@@ -69,6 +71,11 @@ allOf:
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
@@ -90,6 +97,8 @@ allOf:
             - const: bi_tcxo_ao
             - const: iface

+        reg:
+          maxItems: 1
   - if:
       properties:
         compatible:
@@ -108,6 +117,8 @@ allOf:
           items:
             - const: bi_tcxo

+        reg:
+          maxItems: 1
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
@@ -116,13 +127,15 @@ examples:
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
index 20ef2ea673f3..22dcd47d4513 100644
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
2.17.1

