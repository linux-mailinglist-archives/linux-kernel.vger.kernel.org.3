Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95369582219
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiG0I2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiG0I2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:28:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6245988;
        Wed, 27 Jul 2022 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658910509; x=1690446509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=x0IRMGjcA2CLorutTCaSisYtCty1JCM5WAEfbx850mo=;
  b=atOb5sNJQemdWEtEzUBbnMJU9C6RxSI0utBaY8K2dVRw6U/0OtrY1PNA
   wYigfyNm8N48vYiESY9jThQHAfX1fHf5VekYEHiSiIvCf3hnUnCtudnvt
   eB8L+27CmTxaMtsoCMATDpAVMBAbR9gpICsTU6zEME5Wj8Y69ri0GiBdG
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Jul 2022 01:28:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 01:28:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 01:28:27 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 01:28:24 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH V7 3/5] dt-bindings: clock: Add resets for LPASS audio clock controller for SC7280
Date:   Wed, 27 Jul 2022 13:57:55 +0530
Message-ID: <1658910477-6494-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658910477-6494-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1658910477-6494-1-git-send-email-quic_c_skakit@quicinc.com>
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

Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
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

