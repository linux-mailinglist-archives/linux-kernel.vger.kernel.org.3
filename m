Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A11530E00
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiEWJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiEWJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:23:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139D647AEA;
        Mon, 23 May 2022 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653297817; x=1684833817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OtId1SOPqu9ilQgZpsTJuoPbg8PQB/bd9KI0xO+wj1E=;
  b=cAV6bYQZMAwRnmHujzMC0gSytZTYvh88OKAvh1cP/pWCfTiGhQr8vykZ
   kA0AT+IFKayOVf1OxsePLZ6z8GVSxfCJGwJ7z5W133bmyhd3TQhceu81E
   GT0ejrcxg9tMXDotdx4//KHtQfI5EZ7W6ui5vZ5+ATCP+R63AWF8RQpOh
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 02:23:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 02:23:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 02:23:35 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 02:23:31 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v2 1/3] dt-bindings: clock: Add resets for LPASS audio clock controller for SC7280
Date:   Mon, 23 May 2022 14:53:12 +0530
Message-ID: <20220523092314.14252-2-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220523092314.14252-1-quic_tdas@quicinc.com>
References: <20220523092314.14252-1-quic_tdas@quicinc.com>
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

Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
for SC7280. Update reg property min/max items in YAML schema.

Fixes: 57405b795504 ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 .../clock/qcom,sc7280-lpasscorecc.yaml        | 20 ++++++++++++++++---
 .../clock/qcom,lpassaudiocc-sc7280.h          |  5 +++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
index bad9135489de..f066e8c57bbf 100644
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
@@ -69,6 +71,12 @@ allOf:
           items:
             - const: bi_tcxo
             - const: lpass_aon_cc_main_rcg_clk_src
+
+        reg:
+          maxItems: 2
+          items:
+            - description: lpass core cc register
+            - description: lpass audio csr register
   - if:
       properties:
         compatible:
@@ -90,6 +98,8 @@ allOf:
             - const: bi_tcxo_ao
             - const: iface

+        reg:
+          maxItems: 1
   - if:
       properties:
         compatible:
@@ -108,6 +118,8 @@ allOf:
           items:
             - const: bi_tcxo

+        reg:
+          maxItems: 1
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
@@ -116,13 +128,15 @@ examples:
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

