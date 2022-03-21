Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0334E22B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbiCUI6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345598AbiCUI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:58:11 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9357485;
        Mon, 21 Mar 2022 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647853006; x=1679389006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ISCUgpFLNrcd0Zd2YYdxHLQx+tSivhuR0hYqwrnB+vc=;
  b=dRIfHgQyW1b/wKw2O3hVnuznAQnOKEqLYwOxydemvjCyLgAQF7Ju22LZ
   /wTxpXMsnaPodqRYki/kNPWuAMvi3i9onipPMRWJjU8SOgi8i4yVFaanz
   Va2GhujRiUFudj5b4iM31NH1BBlBkUBEN2pp39wepJZI1QHCVTES/ecFu
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 21 Mar 2022 01:56:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 01:56:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 01:56:44 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 01:56:39 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <krzysztof.kozlowski@canonical.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH 1/3] ASoC: qcom: dt-bindings: Update bindings for clocks in lpass digital codes
Date:   Mon, 21 Mar 2022 14:26:19 +0530
Message-ID: <1647852981-27895-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
References: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
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

Update dt-bindings for clocks as per ADSP bypass solutions, in which macro
dcodec GDSCs are enabled using power domains in lpass digital codec drivers.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml  | 17 +++++++++++------
 .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml  | 17 +++++++++++------
 .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml  | 11 +++++++----
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index 6127df5..a6905bc 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -28,12 +28,17 @@ properties:
     maxItems: 5
 
   clock-names:
-    items:
-      - const: mclk
-      - const: npl
-      - const: macro
-      - const: dcodec
-      - const: fsgen
+    oneOf:
+      - items:   #for ADSP based platforms
+          - const: mclk
+          - const: npl
+          - const: macro
+          - const: dcodec
+          - const: fsgen
+      - items:   #for ADSP bypass based platforms
+          - const: mclk
+          - const: npl
+          - const: fsgen
 
   clock-output-names:
     items:
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 3f0f99c..324595a 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -28,12 +28,17 @@ properties:
     maxItems: 5
 
   clock-names:
-    items:
-      - const: mclk
-      - const: npl
-      - const: macro
-      - const: dcodec
-      - const: fsgen
+    oneOf:
+      - items:   #for ADSP based platforms
+          - const: mclk
+          - const: npl
+          - const: macro
+          - const: dcodec
+          - const: fsgen
+      - items:   #for ADSP bypass based platforms
+          - const: mclk
+          - const: npl
+          - const: fsgen
 
   clock-output-names:
     items:
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 9868a5e..7b4cc84 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -28,10 +28,13 @@ properties:
     maxItems: 3
 
   clock-names:
-    items:
-      - const: mclk
-      - const: core
-      - const: dcodec
+    oneOf:
+      - items:   #for ADSP based platforms
+          - const: mclk
+          - const: core
+          - const: dcodec
+      - items:   #for ADSP bypass based platforms
+          - const: mclk
 
   clock-output-names:
     items:
-- 
2.7.4

